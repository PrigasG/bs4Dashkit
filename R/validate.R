#' @keywords internal
dashkit_validate_titles <- function(
    brand_text,
    icon,
    icon_img,
    collapsed,
    expanded,
    collapsed_text,
    expanded_text,
    app_name = NULL
) {
  if (!is.null(icon) && !is.null(icon_img)) {
    warning("Both `icon` and `icon_img` supplied. `icon_img` will be used for the brand icon.")
  }
  if (!is.null(collapsed_text) && nchar(collapsed_text) > 10) {
    warning("`collapsed_text` should be short (<= 10 chars). When collapsed text is left blank, the sidebar falls back to `brand_text`.")
  }
  if (!is.null(expanded_text) && nchar(expanded_text) > 40) {
    warning("`expanded_text` should be moderate length (<= 40 chars).")
  }

  dashkit_resolve_sidebar_brand(
    brand_text = brand_text,
    icon = icon,
    icon_img = icon_img,
    collapsed = collapsed,
    expanded = expanded,
    collapsed_text = collapsed_text,
    expanded_text = expanded_text,
    app_name = app_name
  )
}

#' @keywords internal
dashkit_resolve_sidebar_brand <- function(
    brand_text = NULL,
    icon = NULL,
    icon_img = NULL,
    collapsed,
    expanded,
    collapsed_text = NULL,
    expanded_text = NULL,
    app_name = NULL
) {
  has_icon <- !is.null(icon) || !is.null(icon_img)
  has_brand_text <- dashkit_is_scalar_character(brand_text) && nzchar(trimws(brand_text))

  if (!has_brand_text) {
    allows_textless_brand <- has_icon &&
      identical(collapsed, "icon-only") &&
      identical(expanded, "icon-only")

    if (!allows_textless_brand) {
      stop(
        "`brand_text` must be a non-empty string unless both sidebar modes are `icon-only` and an icon or image logo is supplied.",
        call. = FALSE
      )
    }

    if (is.null(app_name) || !dashkit_is_scalar_character(app_name) || !nzchar(trimws(app_name))) {
      warning(
        "`brand_text` is empty, so the browser title will fall back to `bs4Dashkit`. Supply `app_name=` if you want a custom page title.",
        call. = FALSE
      )
    }
  }

  if (!has_icon && collapsed == "icon-only") {
    stop("`collapsed = \"icon-only\"` requires `icon=` or `icon_img=`.", call. = FALSE)
  }
  if (!has_icon && expanded == "icon-only") {
    stop("`expanded = \"icon-only\"` requires `icon=` or `icon_img=`.", call. = FALSE)
  }

  resolved_collapsed_text <- if (!is.null(collapsed_text) && nzchar(collapsed_text)) collapsed_text else brand_text
  resolved_expanded_text <- if (!is.null(expanded_text) && nzchar(expanded_text)) expanded_text else brand_text

  if (collapsed %in% c("icon-text", "text-only") && !dashkit_is_scalar_character(resolved_collapsed_text)) {
    stop(
      sprintf("`collapsed = \"%s\"` needs visible text. Supply `collapsed_text=` or `brand_text=`.", collapsed),
      call. = FALSE
    )
  }

  if (expanded %in% c("icon-text", "text-only") && !dashkit_is_scalar_character(resolved_expanded_text)) {
    stop(
      sprintf("`expanded = \"%s\"` needs visible text. Supply `expanded_text=` or `brand_text=`.", expanded),
      call. = FALSE
    )
  }

  list(
    collapsed_text = if (!is.null(resolved_collapsed_text)) resolved_collapsed_text else "",
    expanded_text = if (!is.null(resolved_expanded_text)) resolved_expanded_text else "",
    has_icon = has_icon,
    has_brand_text = has_brand_text
  )
}
