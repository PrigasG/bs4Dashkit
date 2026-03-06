#' Standard footer for bs4Dash dashboards
#'
#' @param logo_src Path under `www/` or an external URL.
#' @param left_text Text rendered on the left side (optional).
#' @param right_text Text rendered on the right side (optional).
#' @param right_date Optional Date to render on the right. Ignored if `right_text` is set.
#' @param date_format Format used when `right_date` is provided.
#' @param logo_height Height in px for the logo image.
#' @param logo_position Where the logo should appear: "left" or "right".
#' @param fixed Logical. Fixed footer (TRUE/FALSE).
#'
#' @return A \code{shiny.tag} object representing a \code{bs4DashFooter} UI component.
#' @export
dash_footer <- function(
    logo_src = NULL,
    left_text = NULL,
    right_text = NULL,
    right_date = NULL,
    date_format = "%B %d, %Y",
    logo_height = 20,
    logo_position = c("left", "right"),
    fixed = TRUE
) {
  logo_position <- match.arg(logo_position)

  has_logo <- !is.null(logo_src) &&
    nzchar(logo_src) &&
    !identical(logo_src, "your_logo.png")

  logo_tag <- if (isTRUE(has_logo)) {
    shiny::tags$img(
      src = logo_src,
      height = logo_height,
      style = "vertical-align:middle; opacity:0.9;"
    )
  } else {
    NULL
  }

  left_text_tag <- if (!is.null(left_text) && nzchar(left_text)) {
    shiny::tags$span(left_text, style = "font-size:13px; color:#6c757d;")
  } else {
    NULL
  }

  if (is.null(right_text) || !nzchar(right_text)) {
    if (!is.null(right_date)) {
      right_text <- format(as.Date(right_date), date_format)
    }
  }

  right_text_tag <- if (!is.null(right_text) && nzchar(right_text)) {
    shiny::tags$span(right_text, style = "font-size:13px; color:#8e8e93;")
  } else {
    NULL
  }

  left_items <- Filter(Negate(is.null), list(
    if (logo_position == "left") logo_tag else NULL,
    left_text_tag
  ))

  right_items <- Filter(Negate(is.null), list(
    right_text_tag,
    if (logo_position == "right") logo_tag else NULL
  ))

  wrap_side <- function(items) {
    if (length(items) == 0) return(NULL)
    shiny::tags$div(
      style = paste0(
        "display:flex; align-items:center;",
        if (length(items) > 1) " gap:10px;" else ""
      ),
      items
    )
  }

  bs4Dash::bs4DashFooter(
    fixed = fixed,
    left  = wrap_side(left_items),
    right = wrap_side(right_items)
  )
}
