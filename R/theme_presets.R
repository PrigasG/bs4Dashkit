#' Apply a theme preset
#'
#' @param preset One of: "professional", "modern", "dark-lite"
#' @param ... Passed to use_dash_theme() to override preset values
#' @export
use_dash_theme_preset <- function(
    preset = c("professional", "modern", "dark-lite"),
    ...
) {
  preset <- match.arg(preset)

  base <- switch(
    preset,
    professional = list(
      bg = "#f5f6f8", surface = "#ffffff", border = "#e2e3e7",
      text = "#1d1f23", muted = "#6b6f76", accent = "#2f6f8f",
      radius = 12, shadow = "0 1px 3px rgba(0,0,0,0.07)"
    ),
    modern = list(
      bg = "#f6f7fb", surface = "#ffffff", border = "#e7e8ee",
      text = "#14161a", muted = "#5f6670", accent = "#3b82f6",
      radius = 14, shadow = "0 6px 18px rgba(0,0,0,0.08)"
    ),
    `dark-lite` = list(
      bg = "#0f1115", surface = "#151922", border = "#232836",
      text = "#e9edf5", muted = "#a2acc0", accent = "#8b5cf6",
      radius = 14, shadow = "0 8px 24px rgba(0,0,0,0.35)"
    )
  )

  base <- utils::modifyList(base, list(...))
  do.call(use_dash_theme, base)
}
