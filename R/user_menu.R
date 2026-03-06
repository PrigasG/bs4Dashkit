#' Standard wrapper for a navbar user menu
#'
#' @param ui A UI object, typically a dropdown menu produced by the app
#'
#' @return A \code{shiny.tag} object representing the user menu UI for the navbar.
#' @export
dash_user_menu <- function(ui) {
  shiny::tags$li(class = "nav-item dropdown dash-user-menu", ui)
}
