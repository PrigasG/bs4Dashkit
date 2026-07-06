`%||%` <- function(x, y) if (!is.null(x)) x else y

.dashkit_uid_env <- new.env(parent = emptyenv())
.dashkit_uid_env$counter <- 0L

dashkit_uid <- function(prefix = "dbl") {
  .dashkit_uid_env$counter <- .dashkit_uid_env$counter + 1L
  paste0(prefix, "-", sprintf("%07x", .dashkit_uid_env$counter))
}

dashkit_is_scalar_character <- function(x) {
  is.character(x) && length(x) == 1 && !is.na(x)
}

dashkit_extract_icon_name <- function(icon) {
  if (!inherits(icon, "shiny.tag") || !identical(icon$name, "i")) {
    return(NULL)
  }

  classes <- unlist(icon$attribs["class"], use.names = FALSE)
  if (!length(classes)) {
    return(NULL)
  }

  classes <- strsplit(classes, "\\s+")[[1]]
  classes <- unique(classes[nzchar(classes)])
  style_classes <- c(
    "fa", "fas", "far", "fal", "fab", "fat",
    "fa-solid", "fa-regular", "fa-light", "fa-brands", "fa-thin",
    "fa-fw"
  )

  icon_class <- classes[
    startsWith(classes, "fa-") &
      !(classes %in% style_classes)
  ][1]

  if (is.na(icon_class) || !nzchar(icon_class)) {
    return(NULL)
  }

  sub("^fa-", "", icon_class)
}

dashkit_normalize_icon <- function(icon, arg = "icon") {
  if (is.null(icon)) {
    return(NULL)
  }

  if (dashkit_is_scalar_character(icon)) {
    return(icon)
  }

  icon_name <- dashkit_extract_icon_name(icon)
  if (!is.null(icon_name)) {
    return(icon_name)
  }

  if (inherits(icon, "shiny.tag")) {
    stop(
      sprintf(
        "`%s` must be a Font Awesome icon name like \"cloud\" or a simple shiny::icon(\"cloud\") tag.",
        arg
      ),
      call. = FALSE
    )
  }

  stop(
    sprintf("`%s` must be a single character icon name or NULL.", arg),
    call. = FALSE
  )
}

dashkit_match_choice <- function(value, choices, arg) {
  if (identical(value, choices)) {
    return(choices[[1]])
  }
  if (!dashkit_is_scalar_character(value) || !(value %in% choices)) {
    stop(
      sprintf(
        "`%s` must be one of %s.",
        arg,
        paste(sprintf('"%s"', choices), collapse = ", ")
      ),
      call. = FALSE
    )
  }
  value
}

dashkit_validate_positive_number <- function(value, arg, unit) {
  if (!is.numeric(value) || length(value) != 1 || is.na(value) || value <= 0) {
    stop(sprintf("`%s` must be a single positive number (%s).", arg, unit), call. = FALSE)
  }

  value
}

dashkit_validate_css_dimension <- function(value, arg, default_unit, allow_zero = FALSE) {
  min_ok <- if (isTRUE(allow_zero)) 0 else 0
  if (
    is.numeric(value) &&
      length(value) == 1 &&
      !is.na(value) &&
      if (isTRUE(allow_zero)) value >= min_ok else value > min_ok
  ) {
    return(paste0(value, default_unit))
  }

  value <- dashkit_validate_css_value(value, arg, allow_null = FALSE)
  value <- trimws(value)

  css_unit_pattern <- "(px|rem|em|vh|vw|vmin|vmax|ch|ex|cm|mm|in|pt|pc|%)"
  standard_dimension_pattern <- paste0("^([0-9]*\\.?[0-9]+)", css_unit_pattern, "$")
  css_function_pattern <- "^(calc|clamp|min|max)\\(.+\\)$"

  is_standard_dimension <- grepl(standard_dimension_pattern, value, ignore.case = TRUE)
  is_css_function <- grepl(css_function_pattern, value, ignore.case = TRUE)

  if (is_standard_dimension) {
    numeric_part <- as.numeric(sub(standard_dimension_pattern, "\\1", value, ignore.case = TRUE))
    if (is.na(numeric_part) || if (isTRUE(allow_zero)) numeric_part < 0 else numeric_part <= 0) {
      msg <- if (isTRUE(allow_zero)) {
        sprintf("`%s` must be a non-negative CSS length.", arg)
      } else {
        sprintf("`%s` must be a positive CSS length.", arg)
      }
      stop(msg, call. = FALSE)
    }
  }

  if (!is_standard_dimension && !is_css_function) {
    quantity <- if (isTRUE(allow_zero)) "non-negative" else "positive"
    stop(
      sprintf(
        "`%s` must be a %s number or a CSS length with units, such as \"4.25rem\" or \"270px\".",
        arg,
        quantity
      ),
      call. = FALSE
    )
  }

  value
}

dashkit_validate_css_value <- function(value, arg, allow_null = TRUE) {
  if (is.null(value)) {
    if (isTRUE(allow_null)) return(NULL)
    stop(sprintf("`%s` must be a single CSS value.", arg), call. = FALSE)
  }

  if (!dashkit_is_scalar_character(value) && !(is.numeric(value) && length(value) == 1 && !is.na(value))) {
    stop(sprintf("`%s` must be a single CSS value.", arg), call. = FALSE)
  }

  value <- as.character(value)

  if (!nzchar(value) || grepl("[\r\n\t]", value) || grepl("[<>;{}]", value)) {
    stop(sprintf("`%s` contains characters that are not supported in CSS values.", arg), call. = FALSE)
  }

  value
}

dashkit_validate_css_values <- function(values) {
  for (name in names(values)) {
    dashkit_validate_css_value(values[[name]], name)
  }

  invisible(TRUE)
}

dashkit_js_literal <- function(value) {
  jsonlite::toJSON(value %||% "", auto_unbox = TRUE, null = "null")
}
