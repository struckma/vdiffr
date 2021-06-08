make_testcase_file <- function(fig_name) {
  file <- tempfile(fig_name, fileext = ".svg")
  structure(file, class = "vdiffr_testcase")
}

#' Default SVG writer
#'
#' This is the default SVG writer for vdiffr test cases. It uses
#' embedded versions of [svglite](https://svglite.r-lib.org),
#' [harfbuzz](https://harfbuzz.github.io/), and the Liberation and
#' Symbola fonts in order to create deterministic SVGs.
#'
#' @param plot A plot object to convert to SVG. Can be a ggplot2 object,
#'   a [recorded plot][grDevices::recordPlot], or any object with a
#'   [print()][base::print] method.
#' @param file The file to write the SVG to.
#' @param title An optional title for the test case.
#'
#' @export
write_svg <- function(plot, file, title = "") {
  svglite(file)
  on.exit(grDevices::dev.off())
  print_plot(plot, title)
}

print_plot <- function(p, title = "") {
  UseMethod("print_plot")
}

#' @export
print_plot.default <- function(p, title = "") {
  print(p)
}

#' @export
print_plot.ggplot <- function(p, title = "") {
  if (title != "" && !"title" %in% names(p$labels)) {
    p <- p + ggplot2::ggtitle(title)
  }
  if (!length(p$theme)) {
    p <- p + ggplot2::theme_test()
  }
  print(p)
}

#' @export
print_plot.recordedplot <- function(p, title) {
  grDevices::replayPlot(p)
}

#' @export
print_plot.function <- function(p, title) {
  p()
}
