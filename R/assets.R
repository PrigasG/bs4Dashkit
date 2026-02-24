#' @noRd
bs4dashkit_dependency <- function(include_center_js = TRUE) {
  htmltools::htmlDependency(
    name    = "bs4dashkit",
    version = as.character(utils::packageVersion("bs4Dashkit")),
    src     = c(file = system.file("app-assets", package = "bs4Dashkit")),
    stylesheet = c("dash-core.css", "dash-theme.css", "dash-sidebar.css"),
    script = if (isTRUE(include_center_js)) "dash-nav-center.js" else NULL
  )
}

#' Load core CSS and JS for bs4Dashkit
#' @export
use_bs4Dashkit <- function(include_center_js = TRUE) {
  htmltools::tagList(bs4dashkit_dependency(include_center_js))
}
