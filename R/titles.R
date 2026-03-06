#' Dashboard brand and sidebar configuration
#'
#' Single entry point for branding and sidebar brand behavior. Creates a
#' reusable object you place into \code{bs4DashPage()}, \code{bs4DashNavbar()},
#' and \code{bs4DashBody()}.
#'
#' @param brand_text Visible brand label shown in the navbar/sidebar.
#' @param app_name Browser tab title. If \code{NULL}, defaults to \code{brand_text}.
#' @param icon Font Awesome icon name for the brand (e.g. \code{"project-diagram"}).
#'   Ignored when \code{icon_img} is supplied.
#' @param icon_img Path (www relative) or URL to an image logo. Overrides \code{icon}.
#' @param icon_shape Shape mask for image logos. One of \code{"circle"},
#'   \code{"rounded"}, \code{"square"}.
#' @param icon_size CSS size for the icon/image (e.g. \code{"20px"}, \code{"1.2em"}).
#' @param icon_color CSS color for the Font Awesome icon. For image icons, a subtle
#'   tint may be applied.
#' @param weight CSS font-weight for the brand text.
#' @param spacing CSS letter-spacing for the brand text.
#' @param size CSS font-size for the brand text (e.g. \code{"14px"}).
#' @param italic Logical. If \code{TRUE}, renders brand text in italics.
#' @param font_family CSS font-family string (e.g. \code{"'Inter', sans-serif"}).
#' @param color Solid CSS text color for the brand label (ignored when \code{gradient} is set).
#' @param gradient Character vector of length 2 giving gradient colors for the brand label.
#'   When set, gradient styling is applied.
#' @param effect Visual effect for the brand label. One of \code{"none"}, \code{"glow"},
#'   \code{"shimmer"}, \code{"emboss"}. If \code{gradient} is set, gradient styling is used.
#' @param glow_color Color used for glow/shimmer effects (when applicable).
#' @param collapsed Sidebar brand mode when the sidebar is collapsed. One of
#'   \code{"icon-only"}, \code{"icon-text"}, \code{"text-only"}. If \code{NULL}, uses
#'   option \code{bs4Dashkit.sidebar.collapsed}.
#' @param expanded Sidebar brand mode when the sidebar is expanded. One of
#'   \code{"icon-only"}, \code{"icon-text"}, \code{"text-only"}. If \code{NULL}, uses
#'   option \code{bs4Dashkit.sidebar.expanded}.
#' @param collapsed_text Short label used in collapsed mode (recommended <= 8 chars).
#' @param expanded_text Label used in expanded mode (recommended <= 30 chars).
#' @param brand_divider Logical. If \code{TRUE}, shows a divider under the brand block.
#'   If \code{NULL}, uses option \code{bs4Dashkit.brand_divider}.
#' @param debug Logical. If \code{TRUE}, emits console warnings for missing icons, etc.
#'   If \code{NULL}, uses option \code{bs4Dashkit.debug}.
#'
#' @return A named list with components:
#' \describe{
#'   \item{app_name}{A character string for use in \code{bs4DashPage(title = ...)}.}
#'   \item{brand}{A \code{shiny.tag} object for use in \code{bs4DashNavbar(title = ...)} and, if desired, as sidebar title UI.}
#'   \item{deps}{A \code{shiny.tag.list} containing CSS and JavaScript dependencies to include once in \code{bs4DashBody(...)}.}
#' }
#'
#' @export
dash_titles <- function(
    brand_text,
    app_name = NULL,
    icon = NULL,
    icon_img = NULL,
    icon_shape = c("circle", "rounded", "square"),
    icon_size = NULL,
    icon_color = NULL,
    weight = 700,
    spacing = "-0.02em",
    size = NULL,
    italic = FALSE,
    font_family = NULL,
    color = NULL,
    gradient = NULL,
    effect = c("none", "glow", "shimmer", "emboss"),
    glow_color = NULL,
    collapsed = NULL,
    expanded = NULL,
    collapsed_text = NULL,
    expanded_text = NULL,
    brand_divider = NULL,
    debug = NULL
) {
  collapsed      <- collapsed      %||% dashkit_opt("sidebar.collapsed", "icon-only")
  expanded       <- expanded       %||% dashkit_opt("sidebar.expanded",  "icon-text")
  brand_divider  <- brand_divider  %||% dashkit_opt("brand_divider", TRUE)
  debug          <- debug          %||% dashkit_opt("debug", FALSE)

  collapsed  <- match.arg(collapsed, c("icon-only", "icon-text", "text-only"))
  expanded   <- match.arg(expanded,  c("icon-text", "icon-only", "text-only"))
  icon_shape <- match.arg(icon_shape)
  effect     <- if (!is.null(gradient)) "gradient" else match.arg(effect)

  brand_obj <- dash_brand_ui(
    brand_text  = brand_text,
    icon        = icon,
    icon_img    = icon_img,
    icon_shape  = icon_shape,
    icon_size   = icon_size,
    icon_color  = icon_color,
    weight      = weight,
    spacing     = spacing,
    size        = size,
    italic      = italic,
    font_family = font_family,
    color       = color,
    gradient    = gradient,
    effect      = effect,
    glow_color  = glow_color
  )

  mode_js <- use_dash_sidebar_brand_mode(
    icon           = icon,
    collapsed      = collapsed,
    expanded       = expanded,
    collapsed_text = collapsed_text,
    expanded_text  = expanded_text,
    debug          = debug
  )

  dashkit_validate_titles(icon, icon_img, collapsed_text, expanded_text)

  deps <- shiny::tagList(
    brand_obj$dep,
    mode_js,
    use_dash_sidebar_brand_divider(show = brand_divider)
  )

  list(
    app_name = app_name %||% brand_text,
    brand    = brand_obj$ui,
    deps     = deps
  )
}
