#' Built-in bs4Dashkit theme presets
#'
#' Returns the theme presets shipped with bs4Dashkit so they are easy to
#' discover in code completion, validation errors, and documentation.
#'
#' @param values Logical. If `TRUE`, also returns the preset theme values as a
#'   list-column named `tokens`.
#'
#' @return A data frame with one row per preset and columns `preset` and
#'   `description`. If `values = TRUE`, the returned data frame also includes a
#'   `tokens` list-column.
#' @export
bs4dashkit_theme_presets <- function(values = FALSE) {
  presets <- dashkit_theme_preset_values()
  out <- data.frame(
    preset = names(presets),
    description = c(
      "Calm neutral palette with restrained contrast and soft depth",
      "Bright, crisp palette with clearer chrome and a stronger blue accent",
      "Dark surfaces with cooler contrast and a restrained violet accent"
    ),
    stringsAsFactors = FALSE
  )

  if (isTRUE(values)) {
    out$tokens <- unname(presets)
  }

  out
}

#' @keywords internal
dashkit_theme_preset_values <- function() {
  list(
    professional = list(
      bg = "#f4f6f8",
      surface = "#ffffff",
      border = "#dfe5eb",
      text = "#1f2933",
      muted = "#687280",
      accent = "#2f6f8f",
      accent_soft = "#e6f0f5",
      navbar_bg = "#ffffff",
      navbar_text = "#1f2933",
      sidebar_bg = "#fbfcfd",
      sidebar_text = "#334155",
      sidebar_hover = "#edf3f7",
      footer_bg = "#f8fafc",
      footer_text = "#687280",
      success = "#2d8a56",
      warning = "#c37a14",
      danger = "#b94a48",
      radius = 12,
      shadow = "0 2px 8px rgba(15,23,42,0.06)"
    ),
    modern = list(
      bg = "#f5f7fb",
      surface = "#ffffff",
      border = "#d9e2ec",
      text = "#102033",
      muted = "#5b6775",
      accent = "#2563eb",
      accent_soft = "#e7efff",
      navbar_bg = "#ffffff",
      navbar_text = "#102033",
      sidebar_bg = "#f8fbff",
      sidebar_text = "#1e3a5f",
      sidebar_hover = "#e8f1ff",
      footer_bg = "#f8fafc",
      footer_text = "#5b6775",
      success = "#1f8a70",
      warning = "#d18b16",
      danger = "#c24141",
      radius = 14,
      shadow = "0 10px 30px rgba(37,99,235,0.10)"
    ),
    `dark-lite` = list(
      bg = "#0e131a",
      surface = "#151c25",
      border = "#2a3442",
      text = "#e6edf6",
      muted = "#9aa8bc",
      accent = "#8b5cf6",
      accent_soft = "#241c3f",
      navbar_bg = "#121822",
      navbar_text = "#edf2f9",
      sidebar_bg = "#111720",
      sidebar_text = "#d7deea",
      sidebar_hover = "#1b2431",
      footer_bg = "#121822",
      footer_text = "#9aa8bc",
      success = "#3aa675",
      warning = "#d69b2d",
      danger = "#d26666",
      radius = 14,
      shadow = "0 10px 28px rgba(0,0,0,0.32)"
    )
  )
}

#' Apply a theme preset
#'
#' @param preset One of: "professional", "modern", "dark-lite"
#' @param ... Passed to use_dash_theme() to override preset values
#'
#' @return A \code{shiny.tag} or \code{shiny.tag.list} containing theme preset CSS and related UI dependencies.
#' @export
use_dash_theme_preset <- function(
    preset = c("professional", "modern", "dark-lite"),
    ...
) {
  presets <- dashkit_theme_preset_values()
  choices <- names(presets)

  if (length(preset) != 1 || !is.character(preset) || is.na(preset)) {
    stop("`preset` must be a single preset name.", call. = FALSE)
  }
  if (!preset %in% choices) {
    stop(
      sprintf(
        "Unknown preset `%s`. Available presets: %s.",
        preset,
        paste(sprintf('"%s"', choices), collapse = ", ")
      ),
      call. = FALSE
    )
  }

  base <- presets[[preset]]

  base <- utils::modifyList(base, list(...))
  do.call(use_dash_theme, base)
}
