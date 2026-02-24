#' @keywords internal
dashkit_validate_titles <- function(icon, icon_img, collapsed_text, expanded_text) {
  if (!is.null(icon) && !is.null(icon_img)) {
    warning("Both `icon` and `icon_img` supplied. `icon_img` will be used for the brand icon.")
  }
  if (!is.null(collapsed_text) && nchar(collapsed_text) > 10) {
    warning("`collapsed_text` should be short (<= 10 chars).")
  }
  if (!is.null(expanded_text) && nchar(expanded_text) > 40) {
    warning("`expanded_text` should be moderate length (<= 40 chars).")
  }
}
