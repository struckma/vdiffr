package_version <- function(pkg) {
  as.character(utils::packageVersion(pkg))
}

cat_line <- function(..., trailing = TRUE, file = "") {
  cat(paste_line(..., trailing = trailing), file = file)
}
paste_line <- function(..., trailing = FALSE) {
  lines <- paste(chr(...), collapse = "\n")
  if (trailing) {
    lines <- paste0(lines, "\n")
  }
  lines
}
