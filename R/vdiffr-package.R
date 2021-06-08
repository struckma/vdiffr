#' @import rlang
#' @importFrom glue glue
#' @useDynLib vdiffr, .registration = TRUE
#' @keywords internal
"_PACKAGE"

SVG_ENGINE_VER <- "2.0"

svg_engine_ver <- function() {
  as.numeric_version(SVG_ENGINE_VER)
}

.onLoad <- function(lib, pkg) {
  set_engine_version(SVG_ENGINE_VER)
}

## usethis namespace: start
#' @importFrom lifecycle deprecated
## usethis namespace: end
NULL
