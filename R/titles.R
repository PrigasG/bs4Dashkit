#' Dashboard brand and sidebar behavior — unified constructor
#'
#' Single entry point for all brand-related setup. Returns a list with
#' named slots that map directly to their correct placement in bs4DashPage.
#'
#' @return A named list:
#' \describe{
#'   \item{app_name}{Character — pass to `bs4DashPage(title = ...)`}
#'   \item{brand}{tagList — pass to `bs4DashNavbar(title = ...)` (and/or sidebar title)}
#'   \item{deps}{tagList — place once in `bs4DashBody(...)` (brand CSS + sidebar mode JS)}
#'   \item{behavior}{Deprecated alias of `deps` for backward compatibility}
#' }
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

  # resolve global defaults
  collapsed <- collapsed %||% dashkit_opt("sidebar.collapsed", "icon-only")
  expanded  <- expanded  %||% dashkit_opt("sidebar.expanded",  "icon-text")
  brand_divider <- brand_divider %||% dashkit_opt("brand_divider", TRUE)
  debug <- debug %||% dashkit_opt("debug", FALSE)

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
    deps     = deps,
    behavior = deps
  )
}

