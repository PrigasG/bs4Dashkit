#' Sidebar behavior: icon-only collapse + hover expand + ellipsis labels
#'
#' @param topbar_h Height for navbar and sidebar brand strip. Numeric values
#'   are treated as pixels; CSS lengths such as \code{"3.5rem"} are also
#'   accepted.
#' @param collapsed_w Width for icon-only sidebar. Numeric values are treated
#'   as rem; CSS lengths such as \code{"4.25rem"} are also accepted.
#' @param expanded_w Expanded sidebar width. Numeric values are treated as
#'   pixels; CSS lengths such as \code{"270px"} are also accepted.
#'
#' @return A \code{shiny.tag} or \code{shiny.tag.list} containing sidebar behavior dependencies to include in the UI.
#' @export
use_dash_sidebar_behavior <- function(topbar_h = 56, collapsed_w = 4.2, expanded_w = 250) {
  topbar_h <- dashkit_validate_css_dimension(topbar_h, "topbar_h", "px")
  collapsed_w <- dashkit_validate_css_dimension(collapsed_w, "collapsed_w", "rem")
  expanded_w <- dashkit_validate_css_dimension(expanded_w, "expanded_w", "px")

  shiny::tagList(
    dashkit_sidebar_dependency(),
    shiny::tags$head(
      shiny::tags$style(shiny::HTML(sprintf(
        ":root{--dash-topbar-h:%s;--dash-sidebar-collapsed-w:%s;--dash-sidebar-expanded-w:%s;}",
        topbar_h, collapsed_w, expanded_w
      )))
    )
  )
}
