#' Apply a theme via CSS variables
#'
#' Sets bs4Dashkit CSS custom properties (variables) for background, surfaces,
#' borders, text, and accent color.
#'
#' @param bg Page background color.
#' @param surface Card and panel background color.
#' @param border Border color used on cards, separators, and outlines.
#' @param text Primary text color.
#' @param muted Muted text color.
#' @param accent Accent color used for highlights and emphasis.
#' @param radius Corner radius in pixels.
#' @param shadow Box shadow CSS string used for cards and surfaces.
#'
#' @return A `shiny::tagList()` that injects CSS variables into the page `<head>`.
#' @export
use_dash_theme <- function(
    bg = "#f5f6f8",
    surface = "#ffffff",
    border = "#e2e3e7",
    text = "#1d1f23",
    muted = "#6b6f76",
    accent = "#2f6f8f",
    radius = 12,
    shadow = "0 1px 3px rgba(0,0,0,0.07)"
) {
  dashkit_register_resources()

  vars <- sprintf(
    paste0(
      ":root{",
      "--dash-bg:%s;",
      "--dash-surface:%s;",
      "--dash-border:%s;",
      "--dash-text:%s;",
      "--dash-muted:%s;",
      "--dash-accent:%s;",
      "--dash-radius:%dpx;",
      "--dash-shadow:%s;",
      "}"
    ),
    bg, surface, border, text, muted, accent, radius, shadow
  )

  shiny::tagList(
    shiny::tags$head(
      shiny::tags$link(
        rel  = "stylesheet",
        type = "text/css",
        href = "bs4dashkit-assets/dash-theme.css"
      ),
      shiny::tags$style(shiny::HTML(vars))
    )
  )
}
