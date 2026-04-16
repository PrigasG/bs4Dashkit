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
#' @param accent_soft Softer accent tone used for subtle fills, hover states,
#'   and focus treatments.
#' @param navbar_bg Navbar background color.
#' @param navbar_text Navbar text color.
#' @param sidebar_bg Sidebar background color.
#' @param sidebar_text Sidebar text color.
#' @param sidebar_hover Sidebar hover and active background color.
#' @param footer_bg Footer background color.
#' @param footer_text Footer text color.
#' @param success Success accent color.
#' @param warning Warning accent color.
#' @param danger Danger accent color.
#' @param radius Corner radius in pixels.
#' @param shadow Box shadow CSS string used for cards and surfaces.
#'
#' @return A \code{shiny.tag.list} containing stylesheet dependencies and inline CSS variables for the app theme.
#' @export
use_dash_theme <- function(
    bg = "#f5f6f8",
    surface = "#ffffff",
    border = "#e2e3e7",
    text = "#1d1f23",
    muted = "#6b6f76",
    accent = "#2f6f8f",
    accent_soft = "#e8f1f5",
    navbar_bg = "#ffffff",
    navbar_text = "#1d1f23",
    sidebar_bg = "#ffffff",
    sidebar_text = "#1d1f23",
    sidebar_hover = "#eef4f7",
    footer_bg = "#ffffff",
    footer_text = "#6b6f76",
    success = "#2d8a56",
    warning = "#c37a14",
    danger = "#b94a48",
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
      "--dash-accent-soft:%s;",
      "--dash-navbar-bg:%s;",
      "--dash-navbar-text:%s;",
      "--dash-sidebar-bg:%s;",
      "--dash-sidebar-text:%s;",
      "--dash-sidebar-hover:%s;",
      "--dash-footer-bg:%s;",
      "--dash-footer-text:%s;",
      "--dash-success:%s;",
      "--dash-warning:%s;",
      "--dash-danger:%s;",
      "--dash-radius:%dpx;",
      "--dash-shadow:%s;",
      "}"
    ),
    bg, surface, border, text, muted, accent, accent_soft,
    navbar_bg, navbar_text,
    sidebar_bg, sidebar_text, sidebar_hover,
    footer_bg, footer_text,
    success, warning, danger,
    radius, shadow
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
