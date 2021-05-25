#' @import rlang
#' @importFrom glue glue
#' @importFrom purrr map map_chr keep walk every partial map2_chr compact
#' @importFrom R6 R6Class
#' @useDynLib vdiffr, .registration = TRUE
"_PACKAGE"

SVG_ENGINE_VER <- "2.0"

svg_engine_ver <- function() {
  as.numeric_version(SVG_ENGINE_VER)
}
