vdiffr_skip_stale()

test_that("ggplot doppelgangers pass", {
  skip_if_not_installed("ggplot2")
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

test_that("stale snapshots are skipped", {
  plot <- ggplot2::ggplot() + ggplot2::labs()
  title <- "stale snapshots are skipped"
  new_path <- test_path("_snaps", "expect-doppelganger", "stale-snapshots-are-skipped.new.svg")

  if (regenerate_snapshots()) {
    expect_doppelganger(title, plot)

    # Update engine field to a stale version
    file <- new_path
    if (!file.exists(file)) {
      file <- test_path("_snaps", "expect-doppelganger", "stale-snapshots-are-skipped.svg")
    }
    lines <- readLines(file)
    lines <- sub("data-engine-version='[0-9.]+'", "data-engine-version='0.1'", lines)
    writeLines(lines, file)

    return()
  }

  cnd <- catch_cnd(expect_doppelganger(title, plot))
  expect_s3_class(cnd, "skip")
  file.remove(new_path)
})
