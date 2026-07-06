#' Navbar title (center, right, or left)
#'
#' Creates a consistent title block for bs4Dash navbars, with optional subtitle
#' and icon. Alignment can be "center", "right", or "left".
#'
#' IMPORTANT:
#' - align = "left" is intended to be placed in dashboardHeader(leftUi = ...)
#' - align = "right" is intended to be placed in dashboardHeader(rightUi = ...)
#' - align = "center" can be placed anywhere (it is positioned by CSS/JS)
#'
#' @param title Main title (character or tag)
#' @param subtitle Optional subtitle (character or tag)
#' @param icon Optional Font Awesome icon name or simple \code{icon("shield-halved")} tag.
#' @param align One of c("center","right","left")
#'
#' @return A \code{shiny.tag} object representing the navbar title UI.
#' @export
dash_nav_title <- function(title, subtitle = NULL, icon = NULL,
                           align = c("center", "right", "left")) {
  align <- match.arg(align)
  icon <- dashkit_normalize_icon(icon)

  wrap_class <- switch(align,
                       center = "dash-nav-center-wrap",
                       right  = "dash-nav-right-wrap",
                       left   = "dash-nav-left-wrap"
  )
  box_class <- switch(align,
                      center = "dash-nav-center",
                      right  = "dash-nav-right",
                      left   = "dash-nav-left"
  )
  icon_class  <- paste0("dash-nav-", align, "-icon")
  text_class  <- paste0("dash-nav-", align, "-text")
  title_class <- paste0("dash-nav-", align, "-title")
  sub_class   <- paste0("dash-nav-", align, "-sub")

  shiny::tags$li(
    class = paste("nav-item", "dropdown",wrap_class),
    shiny::tags$div(
      class = box_class,
      if (!is.null(icon)) shiny::icon(icon, class = icon_class),
      shiny::tags$div(
        class = text_class,
        shiny::tags$div(class = title_class, title),
        if (!is.null(subtitle)) shiny::tags$div(class = sub_class, subtitle)
      )
    )
  )
}
