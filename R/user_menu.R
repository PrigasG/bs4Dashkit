#' Standard wrapper for a navbar user menu
#'
#' @param ui A UI object, typically a dropdown menu produced by the app
#' @export
dash_user_menu <- function(ui) {
  shiny::tags$li(class = "nav-item dropdown dash-user-menu", ui)
}
