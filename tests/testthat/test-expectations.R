vdiffr_skip_stale()

test_that("ggplot doppelgangers pass", {
  p1_orig <- ggplot2::ggplot(mtcars, ggplot2::aes(disp)) + ggplot2::geom_histogram()
  expect_doppelganger("myplot", p1_orig, "")
})

test_that("base doppelgangers pass", {
  p_base <- function() plot(mtcars$disp)
  expect_doppelganger("myplot2", p_base, "")

  p_base_symbol <- function() {
    plot.new()
    text(0.5, 0.8, expression(x[i] + over(x, y)), font = 5)
  }

  expect_doppelganger("Base doppelganger with symbol", p_base_symbol, "")
})

test_that("grid doppelgangers pass", {
  p_grid <- function() {
    grid::grid.newpage()
    grid::grid.text("foobar", gp = grid::gpar(fontsize = 10.1))
    grid::grid.text("foobaz", 0.5, 0.1, gp = grid::gpar(fontsize = 15.05))
  }
  expect_doppelganger("Grid doppelganger", p_grid)
})

skip("TODO")

test_that("skip mismatches if vdiffr is stale", {
  withr::local_envvar(c(NOT_CRAN = "true"))
  mock_dir <- create_mock_pkg("mock-pkg-skip-stale")

  mock_test_dir <- file.path(mock_dir, "tests", "testthat")
  test_results <- testthat::test_dir(mock_test_dir, reporter = "silent")
  result <- test_results[[1]]$results[[1]]

  expect_is(result, "expectation_skip")
  expect_match(result$message, "The vdiffr engine is too old")
})
