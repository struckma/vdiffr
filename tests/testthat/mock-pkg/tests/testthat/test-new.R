library("vdiffr")

p1 <- function() plot(mtcars$disp)
p2 <- ggplot2::ggplot(mtcars, ggplot2::aes(disp)) +
  ggplot2::geom_histogram()

test_that("New plots are collected", {
  expect_doppelganger("new1", p1)
  expect_doppelganger("new2", p2)
})
