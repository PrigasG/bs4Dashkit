#' Navbar help button (styled)
#'
#' @param id inputId for actionButton
#' @param label Button label
#' @param icon Font Awesome icon name
#' @param class Additional classes
#' @param ... Passed to shiny::actionButton
#' @export
dash_nav_help_button <- function(
    id,
    label = "Help",
    icon = "circle-question",
    class = NULL,
    ...
) {
  shiny::actionButton(
    inputId = id,
    label   = shiny::tagList(shiny::icon(icon), shiny::span(label)),
    class = paste(c("btn btn-nav-pill", class), collapse = " "),
    ...
  )
}

#' Navbar refresh button (styled)
#'
#' @param id inputId for actionButton
#' @param label Button label
#' @param icon Font Awesome icon name
#' @param class Additional classes
#' @param ... Passed to shiny::actionButton
#' @export
dash_nav_refresh_button <- function(
    id,
    label = "Refresh",
    icon = "rotate-right",
    class = NULL,
    ...
) {
  shiny::actionButton(
    inputId = id,
    label   = label,
    icon    = shiny::icon(icon),
    class = paste(c("btn btn-nav-pill", class), collapse = " "),
    title   = "Reload app",
    ...
  )
}

#' Wrap a navbar control in a <li> (bs4Dash rightUi convention)
#'
#' @param ... UI elements
#' @export
dash_nav_item <- function(...) {
  shiny::tags$li(class = "nav-item dropdown", ...)
}
