#' Build one granular bs4Dashkit html dependency
#'
#' Granular, uniquely named dependencies let htmltools de-duplicate every
#' asset no matter which combination of `use_*()` helpers loads it.
#'
#' @noRd
dashkit_asset_dependency <- function(suffix, stylesheet = NULL, script = NULL) {
  htmltools::htmlDependency(
    name    = paste0("bs4dashkit-", suffix),
    version = as.character(utils::packageVersion("bs4Dashkit")),
    src     = c(file = system.file("app-assets", package = "bs4Dashkit")),
    stylesheet = stylesheet,
    script  = script
  )
}

#' @noRd
dashkit_core_dependency <- function() {
  dashkit_asset_dependency("core", stylesheet = "dash-core.css")
}

#' @noRd
dashkit_theme_dependency <- function() {
  dashkit_asset_dependency("theme", stylesheet = "dash-theme.css")
}

#' @noRd
dashkit_sidebar_dependency <- function() {
  dashkit_asset_dependency("sidebar", stylesheet = "dash-sidebar.css")
}

#' @noRd
dashkit_nav_center_dependency <- function() {
  dashkit_asset_dependency("nav-center", script = "dash-nav-center.js")
}

#' @noRd
dashkit_topnav_dependency <- function() {
  dashkit_asset_dependency(
    "topnav",
    stylesheet = "dash-topnav.css",
    script = "dash-topnav.js"
  )
}

#' @noRd
dashkit_demo_brand_dependency <- function() {
  dashkit_asset_dependency("demo-brand", script = "dash-demo-brand.js")
}

#' Load core CSS and JS for bs4Dashkit
#'
#' Adds the package's bundled CSS (core, theme, sidebar) and optional JS helpers.
#' All assets are attached as named \code{htmltools::htmlDependency} objects, so
#' they are included once per page regardless of how many bs4Dashkit helpers
#' request them.
#'
#' @param include_center_js Logical. If `TRUE` (default), also includes the
#'   JavaScript helper that supports the centered navbar title layout.
#'
#' @return A \code{htmltools::tagList} containing \code{htmltools::htmlDependency}
#'   objects for the package CSS and optional JavaScript helpers.
#' @export
use_bs4Dashkit <- function(include_center_js = TRUE) {
  htmltools::tagList(
    dashkit_core_dependency(),
    dashkit_theme_dependency(),
    dashkit_sidebar_dependency(),
    if (isTRUE(include_center_js)) dashkit_nav_center_dependency()
  )
}
