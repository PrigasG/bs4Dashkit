#' Floating back-to-top button
#'
#' Adds a floating button that appears once the page is scrolled down and
#' smoothly scrolls back to the top when clicked. Useful for long dashboard
#' pages.
#'
#' @param icon Font Awesome icon name or a simple \code{shiny::icon()} tag.
#' @param label Optional text label shown next to the icon. Screen-reader
#'   text is always included for accessibility.
#' @param show_after Pixels scrolled before the button appears. Must be a
#'   single non-negative number.
#' @param position Corner of the viewport: \code{"bottom-right"} (default) or
#'   \code{"bottom-left"}.
#' @param offset Distance from the viewport edges. Numeric values are treated
#'   as pixels; CSS lengths such as \code{"1.5rem"} are also accepted.
#' @param class Additional classes.
#'
#' @return A \code{shiny.tag.list} with the button and its JS dependency.
#' @export
dash_back_to_top <- function(
    icon = "arrow-up",
    label = NULL,
    show_after = 400,
    position = c("bottom-right", "bottom-left"),
    offset = 24,
    class = NULL
) {
  icon <- dashkit_normalize_icon(icon)
  position <- match.arg(position)

  if (
    !is.numeric(show_after) || length(show_after) != 1 ||
      !is.finite(show_after) || show_after < 0
  ) {
    stop("`show_after` must be a single non-negative number (pixels).", call. = FALSE)
  }

  if (!is.null(label) && !dashkit_is_scalar_character(label)) {
    stop("`label` must be a single string or NULL.", call. = FALSE)
  }

  offset <- dashkit_validate_css_dimension(offset, "offset", "px")

  side <- if (position == "bottom-right") "right" else "left"

  htmltools::tagList(
    dashkit_back_to_top_dependency(),
    shiny::tags$button(
      type = "button",
      class = paste(
        c("dash-back-to-top", if (!is.null(label)) "dash-back-to-top-labeled", class),
        collapse = " "
      ),
      `data-show-after` = show_after,
      style = sprintf("bottom: %s; %s: %s;", offset, side, offset),
      title = if (is.null(label)) "Back to top" else label,
      `aria-label` = "Back to top",
      shiny::icon(icon),
      if (!is.null(label)) shiny::span(class = "dash-back-to-top-label", label)
    )
  )
}
