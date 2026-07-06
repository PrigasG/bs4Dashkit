#' Navbar help button (styled)
#'
#' @param id inputId for actionButton
#' @param label Button label
#' @param icon Font Awesome icon name
#' @param class Additional classes
#' @param ... Passed to shiny::actionButton
#'
#' @return A \code{shiny.tag} object representing a styled navbar action button.
#' @export
dash_nav_help_button <- function(
    id,
    label = "Help",
    icon = "circle-question",
    class = NULL,
    ...
) {
  shiny::actionButton(
    inputId = id,
    label   = shiny::tagList(shiny::icon(icon), shiny::span(label)),
    class = paste(c("btn btn-nav-pill", class), collapse = " "),
    ...
  )
}

#' Navbar help item (complete bs4Dash rightUi child)
#'
#' @inheritParams dash_nav_help_button
#'
#' @return A complete \code{<li class="nav-item dropdown">} navbar child for
#'   use in \code{bs4DashNavbar(rightUi = ...)}.
#' @export
dash_nav_help_item <- function(
    id,
    label = "Help",
    icon = "circle-question",
    class = NULL,
    ...
) {
  dash_nav_item(
    dash_nav_help_button(
      id = id,
      label = label,
      icon = icon,
      class = class,
      ...
    )
  )
}

#' Navbar refresh button (styled)
#'
#' @param id inputId for actionButton
#' @param label Button label
#' @param icon Font Awesome icon name
#' @param class Additional classes
#' @param ... Passed to shiny::actionButton
#'
#' @return A \code{shiny.tag} object representing a styled navbar refresh button.
#' @export
dash_nav_refresh_button <- function(
    id,
    label = "Refresh",
    icon = "rotate-right",
    class = NULL,
    ...
) {
  shiny::actionButton(
    inputId = id,
    label   = label,
    icon    = shiny::icon(icon),
    class = paste(c("btn btn-nav-pill", class), collapse = " "),
    title   = "Reload app",
    ...
  )
}

#' Navbar refresh item (complete bs4Dash rightUi child)
#'
#' @inheritParams dash_nav_refresh_button
#'
#' @return A complete \code{<li class="nav-item dropdown">} navbar child for
#'   use in \code{bs4DashNavbar(rightUi = ...)}.
#' @export
dash_nav_refresh_item <- function(
    id,
    label = "Refresh",
    icon = "rotate-right",
    class = NULL,
    ...
) {
  dash_nav_item(
    dash_nav_refresh_button(
      id = id,
      label = label,
      icon = icon,
      class = class,
      ...
    )
  )
}

#' Navbar status badge
#'
#' @param label Badge label.
#' @param status Bootstrap status color. One of \code{"primary"},
#'   \code{"secondary"}, \code{"success"}, \code{"info"}, \code{"warning"},
#'   \code{"danger"}, \code{"light"}, or \code{"dark"}.
#' @param icon Optional Font Awesome icon name or simple \code{shiny::icon()} tag.
#' @param class Additional classes.
#'
#' @return A \code{shiny.tag} badge suitable for wrapping in \code{dash_nav_item()}.
#' @export
dash_nav_status_badge <- function(
    label,
    status = c("success", "primary", "secondary", "info", "warning", "danger", "light", "dark"),
    icon = NULL,
    class = NULL
) {
  status <- match.arg(status)
  icon <- dashkit_normalize_icon(icon)

  shiny::span(
    class = paste(c("badge", paste0("badge-", status), "dash-nav-status-badge", class), collapse = " "),
    if (!is.null(icon)) shiny::icon(icon),
    shiny::span(label)
  )
}

#' Navbar status item (complete bs4Dash rightUi child)
#'
#' @inheritParams dash_nav_status_badge
#'
#' @return A complete \code{<li class="nav-item dropdown">} navbar child for
#'   use in \code{bs4DashNavbar(rightUi = ...)}.
#' @export
dash_nav_status_item <- function(
    label,
    status = c("success", "primary", "secondary", "info", "warning", "danger", "light", "dark"),
    icon = NULL,
    class = NULL
) {
  status <- match.arg(status)

  dash_nav_item(
    dash_nav_status_badge(
      label = label,
      status = status,
      icon = icon,
      class = class
    )
  )
}

#' Wrap a navbar control in a list item (bs4Dash rightUi convention)
#'
#' @param ... UI elements
#'
#' @return A \code{shiny.tag} object containing an HTML list item for use in bs4Dash navbar UI.
#' @export
dash_nav_item <- function(...) {
  shiny::tags$li(class = "nav-item dropdown", ...)
}

#' Validate bs4Dash navbar rightUi structure
#'
#' Checks that each direct child supplied to \code{bs4DashNavbar(rightUi = ...)}
#' is a complete navbar list item with the \code{dropdown} class expected by
#' bs4Dash/AdminLTE.
#'
#' @param rightUi A \code{shiny::tagList()} or tag intended for
#'   \code{bs4DashNavbar(rightUi = ...)}.
#'
#' @return Invisibly returns \code{TRUE} when valid; otherwise errors with a
#'   targeted message.
#' @export
validate_bs4dash_navbar <- function(rightUi) {
  children <- dashkit_navbar_children(rightUi)

  for (i in seq_along(children)) {
    child <- children[[i]]
    if (is.null(child)) {
      next
    }

    if (!inherits(child, "shiny.tag")) {
      stop(
        sprintf("Navbar item %d is not an HTML tag. Wrap custom controls with dash_nav_item().", i),
        call. = FALSE
      )
    }

    if (!identical(tolower(child$name), "li")) {
      stop(
        sprintf(
          "Navbar item %d is a <%s>, but bs4Dash rightUi expects <li class=\"dropdown\"> children. Wrap it with dash_nav_item().",
          i,
          child$name
        ),
        call. = FALSE
      )
    }

    classes <- dashkit_tag_classes(child)
    if (!"dropdown" %in% classes) {
      stop(
        sprintf(
          "Navbar item %d is an <li> but is missing class \"dropdown\". Wrap it with dash_nav_item().",
          i
        ),
        call. = FALSE
      )
    }
  }

  invisible(TRUE)
}

dashkit_navbar_children <- function(ui) {
  if (is.null(ui)) {
    return(list())
  }

  if (inherits(ui, "shiny.tag.list")) {
    return(unclass(ui))
  }

  if (is.list(ui) && !inherits(ui, "shiny.tag")) {
    return(ui)
  }

  list(ui)
}

dashkit_tag_classes <- function(tag) {
  classes <- unlist(tag$attribs["class"], use.names = FALSE)
  if (!length(classes) || anyNA(classes)) {
    return(character())
  }

  unique(strsplit(classes, "\\s+")[[1]])
}
