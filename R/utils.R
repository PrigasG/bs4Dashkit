`%||%` <- function(x, y) if (!is.null(x)) x else y

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
