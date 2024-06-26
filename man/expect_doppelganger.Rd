% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expect-doppelganger.R
\name{expect_doppelganger}
\alias{expect_doppelganger}
\title{Does a figure look like its expected output?}
\usage{
expect_doppelganger(
  title,
  fig,
  path = deprecated(),
  ...,
  writer = write_svg,
  cran = FALSE,
  variant = NULL
)
}
\arguments{
\item{title}{A brief description of what is being tested in the
figure. For instance: "Points and lines overlap".

If a ggplot2 figure doesn't have a title already, \code{title} is
applied to the figure with \code{ggtitle()}.

The title is also used as file name for storing SVG (in a
sanitzed form, with special characters converted to \code{"-"}).}

\item{fig}{A figure to test. This can be a ggplot object, a
recordedplot, or more generally any object with a \code{print} method.

If you need to test a plot with non-printable objects (e.g. base
plots), \code{fig} can be a function that generates and prints the
plot, e.g. \code{fig = function() plot(1:3)}.}

\item{path, ...}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}.}

\item{writer}{A function that takes the plot, a target SVG file,
and an optional plot title. It should transform the plot to SVG
in a deterministic way and write it to the target file. See
\code{\link[=write_svg]{write_svg()}} (the default) for an example.}

\item{cran}{If \code{FALSE} (the default), mismatched snapshots only
cause a failure when you run tests locally or in your CI (Github
Actions or any platform that sets the \code{CI} environment variable).
If \code{TRUE}, failures may also occur on CRAN machines.

Failures are disabled on CRAN by default because testing the
appearance of a figure is inherently fragile. Changes in the R
graphics engine or in ggplot2 may cause subtle differences in the
aspect of a plot, such as a slightly smaller or larger margin.
These changes will cause spurious failures because you need to
update your snapshots to reflect the upstream changes.

It would be distracting for both you and the CRAN maintainers if
such changes systematically caused failures on CRAN. This is why
snapshot expectations do not fail on CRAN by default and should
be treated as a monitoring tool that allows you to quickly check
how the appearance of your figures changes over time, and to
manually assess whether changes reflect actual problems in your
package.

Internally, this argument is passed to
\code{\link[testthat:expect_snapshot_file]{testthat::expect_snapshot_file()}}.}

\item{variant}{see testthat}
}
\description{
\code{expect_doppelganger()} is a testthat expectation for graphical
plots. It generates SVG snapshots that you can review graphically
with \code{\link[testthat:snapshot_accept]{testthat::snapshot_review()}}. You will find more information
about snapshotting in the \href{https://testthat.r-lib.org/articles/snapshotting.html}{testthat snapshots vignette}.
}
\section{Debugging}{

It is sometimes difficult to understand the cause of a failure.
This usually indicates that the plot is not created
deterministically. Potential culprits are:
\itemize{
\item Some of the plot components depend on random variation. Try
setting a seed.
\item The plot depends on some system library. For instance sf plots
depend on libraries like GEOS and GDAL. It might not be possible
to test these plots with vdiffr.
}

To help you understand the causes of a failure, vdiffr
automatically logs the SVG diff of all failures when run under R
CMD check. The log is located in \code{tests/vdiffr.Rout.fail} and
should be displayed on Travis.

You can also set the \code{VDIFFR_LOG_PATH} environment variable with
\code{Sys.setenv()} to unconditionally (also interactively) log failures
in the file pointed by the variable.
}

\examples{
if (FALSE) {  # Not run

library("ggplot2")

test_that("plots have known output", {
  disp_hist_base <- function() hist(mtcars$disp)
  expect_doppelganger("disp-histogram-base", disp_hist_base)

  disp_hist_ggplot <- ggplot(mtcars, aes(disp)) + geom_histogram()
  expect_doppelganger("disp-histogram-ggplot", disp_hist_ggplot)
})

}
}
