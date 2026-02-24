#' Standard footer for dashboards
#'
#' @param logo_src Path/URL for image under www/ or external URL.
#'   If NULL or empty, no logo is rendered.
#' @param left_text Text content for footer.
#' @param right_text Right side text. Defaults to today's date.
#' @param logo_height Height in px.
#' @param logo_position Where the logo should appear: "left" or "right".
#' @param text_position Where the left_text should appear: "left" or "right".
#' @param fixed Fixed footer (TRUE/FALSE).
#'
#' @return A bs4DashFooter object
#' @export
dash_footer <- function(
    logo_src = NULL,
    left_text = NULL,
    right_text = format(Sys.Date(), "%B %d, %Y"),
    logo_height = 20,
    logo_position = c("left", "right"),
    text_position = c("left", "right"),
    fixed = TRUE
) {

  logo_position <- match.arg(logo_position)
  text_position <- match.arg(text_position)

  has_logo <- !is.null(logo_src) &&
    nzchar(logo_src) &&
    !identical(logo_src, "your_logo.png")

  logo_tag <- if (isTRUE(has_logo)) {
    shiny::tags$img(
      src = logo_src,
      height = logo_height,
      style = "vertical-align: middle; margin-right:10px; opacity:0.9;"
    )
  } else NULL

  text_tag <- if (!is.null(left_text) && nzchar(left_text)) {
    shiny::tags$span(
      left_text,
      style = "font-size:13px; color:#6c757d;"
    )
  } else NULL

  date_tag <- if (!is.null(right_text) && nzchar(right_text)) {
    shiny::tags$span(
      right_text,
      style = "font-size:13px; color:#8e8e93;"
    )
  } else NULL

  # Construct left and right blocks dynamically
  left_block  <- list()
  right_block <- list()

  if (logo_position == "left") {
    left_block <- append(left_block, list(logo_tag))
  } else {
    right_block <- append(right_block, list(logo_tag))
  }

  if (text_position == "left") {
    left_block <- append(left_block, list(text_tag))
  } else {
    right_block <- append(right_block, list(text_tag))
  }

  # Date always stays on right unless user moves text there
  right_block <- append(right_block, list(date_tag))

  bs4Dash::bs4DashFooter(
    fixed = fixed,
    left  = shiny::tagList(left_block),
    right = shiny::tagList(right_block)
  )
}
