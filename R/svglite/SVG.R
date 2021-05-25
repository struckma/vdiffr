#' An SVG Graphics Driver
#'
#' This function produces graphics compliant to the current w3 svg XML
#' standard. The driver output is currently NOT specifying a DOCTYPE DTD.
#'
#' svglite provides two ways of controlling fonts: system fonts
#' aliases and user fonts aliases. Supplying a font alias has two
#' effects. First it determines the \code{font-family} property of all
#' text anchors in the SVG output. Secondly, the font is used to
#' determine the dimensions of graphical elements and has thus an
#' influence on the overall aspect of the plots. This means that for
#' optimal display, the font must be available on both the computer
#' used to create the svg, and the computer used to render the
#' svg. See the \code{fonts} vignette for more information.
#'
#' @param filename The file where output will appear.
#' @param height,width Height and width in inches.
#' @param bg Default background color for the plot (defaults to "white").
#' @param pointsize Default point size.
#' @param standalone Produce a standalone svg file? If \code{FALSE}, omits
#'   xml header and default namespace.
#' @param always_valid Should the svgfile be a valid svg file while it is being
#'   written to? Setting this to `TRUE` will incur a considerable performance
#'   hit (>50% additional rendering time) so this should only be set to `TRUE`
#'   if the file is being parsed while it is still being written to.
#' @param file Identical to `filename`. Provided for backward compatibility.
#' @references \emph{W3C Scalable Vector Graphics (SVG)}:
#'   \url{http://www.w3.org/Graphics/SVG/}
#' @author This driver was written by T Jake Luciani
#'   \email{jakeluciani@@yahoo.com} 2012: updated by Matthieu Decorde
#'   \email{matthieu.decorde@@ens-lyon.fr}
#' @seealso \code{\link{pictex}}, \code{\link{postscript}}, \code{\link{Devices}}
#'
#' @examples
#' # Save to file
#' svglite(tempfile("Rplots.svg"))
#' plot(1:11, (-5:5)^2, type = 'b', main = "Simple Example")
#' dev.off()
#'
#' @keywords device
#' @useDynLib svglite, .registration = TRUE
#' @importFrom systemfonts match_font
#' @export
svglite <- function(filename = "Rplot%03d.svg", width = 10, height = 8,
                    bg = "white", pointsize = 12, standalone = TRUE,
                    always_valid = FALSE, file) {
  if (!missing(file)) {
    filename <- file
  }
  if (invalid_filename(filename))
    stop("invalid 'file': ", filename)
  invisible(svglite_(filename, bg, width, height, pointsize, standalone, always_valid))
}

#' Access current SVG as a string.
#'
#' This is a variation on \code{\link{svglite}} that makes it easy to access
#' the current value as a string.
#'
#' See \code{\link{svglite}()} documentation for information about
#' specifying fonts.
#'
#' @return A function with no arguments: call the function to get the
#'   current value of the string.
#' @examples
#' s <- svgstring(); s()
#'
#' plot.new(); s();
#' text(0.5, 0.5, "Hi!"); s()
#' dev.off()
#'
#' s <- svgstring()
#' plot(rnorm(5), rnorm(5))
#' s()
#' dev.off()
#' @inheritParams svglite
#' @export
svgstring <- function(width = 10, height = 8, bg = "white",
                      pointsize = 12, standalone = TRUE) {
  env <- new.env(parent = emptyenv())
  string_src <- svgstring_(env, width = width, height = height, bg = bg,
    pointsize = pointsize, standalone = standalone)

  function() {
    svgstr <- env$svg_string
    if(!env$is_closed) {
      svgstr <- c(svgstr, get_svg_content(string_src))
    }
    structure(svgstr, class = "svg")
  }
}

#' @export
print.svg <- function(x, ...) cat(x, sep = "\n")
