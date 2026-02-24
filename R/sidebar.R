#' Sidebar behavior: icon-only collapse + hover expand + ellipsis labels
#'
#' @param topbar_h Height in px for navbar and sidebar brand strip
#' @param collapsed_w Width for icon-only sidebar (rem)
#' @param expanded_w Expanded sidebar width (px)
#' @export
use_dash_sidebar_behavior <- function(topbar_h = 56, collapsed_w = 4.2, expanded_w = 250) {
  dashkit_register_resources()

  shiny::tagList(
    shiny::tags$head(
      shiny::tags$link(
        rel  = "stylesheet",
        type = "text/css",
        href = "bs4dashkit-assets/dash-sidebar.css"
      ),
      shiny::tags$style(shiny::HTML(sprintf(
        ":root{--dash-topbar-h:%dpx;--dash-sidebar-collapsed-w:%.4frem;--dash-sidebar-expanded-w:%dpx;}",
        topbar_h, collapsed_w, expanded_w
      )))
    )
  )
}
