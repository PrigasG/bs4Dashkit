#' Ensure bs4Dashkit resource path is registered
#' @keywords internal
dashkit_register_resources <- function() {
  shiny::addResourcePath(
    prefix = "bs4dashkit-assets",
    directoryPath = system.file("app-assets", package = "bs4Dashkit")
  )
  invisible(TRUE)
}
