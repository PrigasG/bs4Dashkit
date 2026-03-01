#' Load bs4Dashkit core dependencies in one call
#'
#' Recommended entry point for bs4Dashkit in bs4DashBody().
#'
#' @param ttl Output from dash_titles()
#' @param preset Optional theme preset name (e.g. "professional").
#'   If NULL, uses option bs4Dashkit.theme_preset (if set).
#' @param accent Optional accent override. If NULL, uses option bs4Dashkit.accent.
#'   If preset is used, this overrides the preset accent.
#' @param ... Optional overrides passed to use_dash_theme_preset() when preset is used.
#' @param topbar_h Height (px) for topbar + brand strip
#' @param collapsed_w Sidebar collapsed width (rem)
#' @param expanded_w Sidebar expanded width (px)
#' @export
use_bs4Dashkit_core <- function(
    ttl,
    preset = NULL,
    accent = NULL,
    ...,
    topbar_h = 56,
    collapsed_w = 4.2,
    expanded_w = 250
) {
  if (!is.list(ttl) || is.null(ttl$deps)) {
    stop("`ttl` must be the result of dash_titles() and contain `$deps`.")
  }

  if (!is.numeric(collapsed_w) || length(collapsed_w) != 1 || is.na(collapsed_w) || collapsed_w <= 0) {
    stop("`collapsed_w` must be a single positive number (rem).")
  }
  if (!is.numeric(expanded_w) || length(expanded_w) != 1 || is.na(expanded_w) || expanded_w <= 0) {
    stop("`expanded_w` must be a single positive number (px).")
  }
  if (!is.numeric(topbar_h) || length(topbar_h) != 1 || is.na(topbar_h) || topbar_h <= 0) {
    stop("`topbar_h` must be a single positive number (px).")
  }

  preset <- preset %||% dashkit_opt("theme_preset", NULL)
  if (!is.null(preset) && length(preset) != 1) {
    stop("`preset` must be a single preset name, or NULL.")
  }
  if (!is.null(preset) && nzchar(preset)) preset <- as.character(preset)

  accent <- accent %||% dashkit_opt("accent", "#2f6f8f")
  if (!is.null(accent) && length(accent) != 1) {
    stop("`accent` must be a single string (CSS color), or NULL.")
  }

  theme_tag <- if (!is.null(preset) && nzchar(preset)) {
    use_dash_theme_preset(preset, accent = accent, ...)
  } else {
    use_dash_theme(accent = accent, ...)
  }

  shiny::tagList(
    use_bs4Dashkit(),
    ttl$deps,
    theme_tag,
    use_dash_sidebar_behavior(
      topbar_h    = topbar_h,
      collapsed_w = collapsed_w,
      expanded_w  = expanded_w
    )
  )
}
