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

push_log <- function(name, old_path, new_path) {
  log_path <- Sys.getenv("VDIFFR_LOG_PATH")

  # If no envvar is set, check if we are running under R CMD check. In
  # that case, always push a log file.
  if (!nzchar(log_path)) {
    if (!is_checking_remotely()) {
      return(invisible(FALSE))
    }
    log_path <- testthat::test_path("..", "vdiffr.Rout.fail")
  }

  log_exists <- file.exists(log_path)

  file <- file(log_path, "a")
  on.exit(close(file))

  if (!log_exists) {
    cat_line(
      file = file,
      "Environment:",
      vdiffr_info(),
      ""
    )
  }

  diff_lines <- diff_lines(name, old_path, new_path)
  cat_line(file = file, "", !!!diff_lines, "")
}
is_checking_remotely <- function() {
  nzchar(Sys.getenv("CI")) || !nzchar(Sys.getenv("NOT_CRAN"))
}

diff_lines <- function(name,
                       before_path,
                       after_path) {
  before <- readLines(before_path)
  after <- readLines(after_path)

  diff <- diffobj::diffChr(
    before,
    after,
    format = "raw",
    # For reproducibility
    disp.width = 80
  )
  lines <- as.character(diff)

  paste_line(
    glue("Failed doppelganger: {name} ({before_path})"),
    "",
    !!!lines
  )
}

vdiffr_info <- function() {
  glue(
    "- vdiffr-svg-engine: { SVG_ENGINE_VER }
     - vdiffr: { utils::packageVersion('vdiffr') }"
  )
}
