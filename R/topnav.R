#' Top navigation options
#'
#' Bundles the top-navigation settings used by
#' \code{use_bs4Dashkit_core(layout = "topnav")}. This keeps app setup compact
#' while preserving the same options accepted by \code{use_dash_topnav()}.
#'
#' @inheritParams use_dash_topnav
#'
#' @return A named list with class \code{bs4dashkit_topnav_options}.
#'
#' @examples
#' dash_topnav_options(
#'   align = "left",
#'   gap = 6,
#'   style = "compact",
#'   mobile = "collapse",
#'   overflow = "more",
#'   more_after = 4,
#'   title = "auto",
#'   page_title = "tab"
#' )
#'
#' @export
dash_topnav_options <- function(
    align = c("left", "center", "right"),
    gap = 0,
    style = c("underline", "pill", "compact"),
    mobile = c("collapse", "scroll"),
    overflow = c("auto", "more", "scroll"),
    more_after = Inf,
    title = c("auto", "show", "compact", "hide"),
    page_title = c("none", "tab"),
    brand = TRUE,
    debug = FALSE
) {
  if (identical(align, c("left", "center", "right"))) {
    align <- "left"
  }
  if (!dashkit_is_scalar_character(align) || !(align %in% c("left", "center", "right"))) {
    stop('`align` must be one of "left", "center", or "right".', call. = FALSE)
  }

  gap <- dashkit_validate_css_dimension(gap, "gap", "px", allow_zero = TRUE)
  style <- dashkit_match_choice(style, c("underline", "pill", "compact"), "style")
  mobile <- dashkit_match_choice(mobile, c("collapse", "scroll"), "mobile")
  overflow <- dashkit_match_choice(overflow, c("auto", "more", "scroll"), "overflow")
  title <- dashkit_match_choice(title, c("auto", "show", "compact", "hide"), "title")
  page_title <- dashkit_match_choice(page_title, c("none", "tab"), "page_title")

  if (!is.numeric(more_after) || length(more_after) != 1 || is.na(more_after) || more_after < 1) {
    stop("`more_after` must be a single positive number or Inf.", call. = FALSE)
  }
  if (!is.logical(brand) || length(brand) != 1 || is.na(brand)) {
    stop("`brand` must be TRUE or FALSE.", call. = FALSE)
  }
  if (!is.logical(debug) || length(debug) != 1 || is.na(debug)) {
    stop("`debug` must be TRUE or FALSE.", call. = FALSE)
  }
  if (identical(mobile, "scroll") && identical(title, "show")) {
    warning(
      '`mobile = "scroll"` works best with `title = "auto"` or `title = "hide"`; `title = "show"` may crowd the tab row.',
      call. = FALSE
    )
  }

  structure(
    list(
      align = align,
      gap = gap,
      style = style,
      mobile = mobile,
      overflow = overflow,
      more_after = more_after,
      title = title,
      page_title = page_title,
      brand = brand,
      debug = debug
    ),
    class = "bs4dashkit_topnav_options"
  )
}

#' Top navigation layout: replace the sidebar with a navbar menu
#'
#' Turns a regular `bs4Dash` app into a top-navigation app, similar to
#' `bslib::page_navbar()`. The sidebar is hidden and its menu is mirrored as a
#' horizontal menu inside the navbar. Clicks on the horizontal menu are
#' delegated back to the original sidebar links, so everything wired to the
#' sidebar keeps working: `input$<sidebarMenu id>`, `bs4Dash::updateTabItems()`,
#' badges, and bookmarking.
#'
#' @details
#' Keep your app exactly as it is - `bs4DashSidebar()`, `bs4SidebarMenu()`,
#' `bs4TabItems()` - and add `use_dash_topnav()` (or
#' `use_bs4Dashkit_core(layout = "topnav")`) to the body. The sidebar stays in
#' the DOM as the single source of truth but is never shown.
#'
#' Menu items with sub-items (`bs4SidebarMenuSubItem()`) are rendered as
#' navbar dropdowns. Menus rendered on the fly (`renderMenu()`) and updates
#' via `updateTabItems()` are picked up automatically.
#'
#' On screens narrower than 992px the menu stays on one horizontally
#' scrollable row instead of collapsing into a hamburger.
#'
#' @param topbar_h Height for the navbar. Numeric values are treated as
#'   pixels; CSS lengths such as \code{"3.5rem"} are also accepted.
#' The mirrored menu can be aligned with \code{align}. If you also place a
#' centered \code{dash_nav_title()} in the navbar, the title is centered in the
#' remaining space between the mirrored menu and right-side controls. In that
#' case \code{align = "left"} or \code{"right"} usually gives the cleanest
#' result; \code{align = "center"} is best for apps without a centered title or
#' with only a small number of tabs.
#'
#' @param align Horizontal alignment of the mirrored menu inside the navbar:
#'   \code{"left"} (default), \code{"center"}, or \code{"right"}.
#' @param gap Space between mirrored top-nav items. Numeric values are treated
#'   as pixels; CSS lengths such as \code{"0.5rem"} are also accepted.
#' @param style Visual style for top-nav tabs: \code{"underline"} (default),
#'   \code{"pill"}, or \code{"compact"}.
#' @param mobile Mobile behavior: \code{"collapse"} (default) shows a hamburger
#'   that opens the mirrored tabs; \code{"scroll"} keeps tabs in one
#'   horizontally scrollable row.
#' @param overflow Desktop overflow behavior. \code{"auto"} (default) keeps the
#'   tab row intact. \code{"more"} moves items after \code{more_after} into a
#'   \code{More} dropdown. \code{"scroll"} allows horizontal scrolling.
#' @param more_after Number of top-level items to keep visible when
#'   \code{overflow = "more"}. Use \code{Inf} to disable moving items.
#' @param title How a centered \code{dash_nav_title()} behaves when top-nav tabs
#'   need space: \code{"auto"} (default) compacts then hides as needed,
#'   \code{"show"} always shows it, \code{"compact"} hides the subtitle, and
#'   \code{"hide"} hides it in top-nav mode. In \code{mobile = "scroll"},
#'   \code{"auto"} hides the centered title earlier so the tab row has room;
#'   \code{"show"} is allowed but may crowd the scroll row.
#' @param page_title Optional content title synced from the active top-nav tab.
#'   Use \code{"none"} (default) to disable or \code{"tab"} to show the selected
#'   tab label above the content area.
#' @param brand Logical. If \code{TRUE} (default), the sidebar brand
#'   (icon + label) is mirrored into the navbar. Ignored when
#'   \code{bs4Dash::bs4DashSidebar(disable = TRUE)} already placed the brand
#'   in the navbar.
#' @param debug Logical. If \code{TRUE}, prints diagnostic messages to the
#'   browser console when the navbar or sidebar menu cannot be found.
#'
#' @return A \code{shiny.tag.list} with the top-nav CSS/JS dependencies and the
#'   initialization script. Include it once in \code{bs4DashBody(...)}.
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(bs4Dash)
#'
#'   ttl <- dash_titles(brand_text = "Top-nav demo", icon = icon("bolt"))
#'
#'   ui <- bs4DashPage(
#'     title = ttl$app_name,
#'     header = bs4DashNavbar(title = ttl$brand),
#'     sidebar = bs4DashSidebar(
#'       bs4SidebarMenu(
#'         id = "sidebar",
#'         bs4SidebarMenuItem("Home", tabName = "home", icon = icon("house")),
#'         bs4SidebarMenuItem("Data", tabName = "data", icon = icon("table"))
#'       )
#'     ),
#'     body = bs4DashBody(
#'       use_bs4Dashkit_core(ttl, preset = "professional", layout = "topnav"),
#'       bs4TabItems(
#'         bs4TabItem(tabName = "home", "Home content"),
#'         bs4TabItem(tabName = "data", "Data content")
#'       )
#'     )
#'   )
#'
#'   shinyApp(ui, function(input, output, session) {})
#' }
#'
#' @export
use_dash_topnav <- function(
    topbar_h = 56,
    align = c("left", "center", "right"),
    gap = 0,
    style = c("underline", "pill", "compact"),
    mobile = c("collapse", "scroll"),
    overflow = c("auto", "more", "scroll"),
    more_after = Inf,
    title = c("auto", "show", "compact", "hide"),
    page_title = c("none", "tab"),
    brand = TRUE,
    debug = FALSE
) {
  topbar_h <- dashkit_validate_css_dimension(topbar_h, "topbar_h", "px")
  opts <- dash_topnav_options(
    align = align,
    gap = gap,
    style = style,
    mobile = mobile,
    overflow = overflow,
    more_after = more_after,
    title = title,
    page_title = page_title,
    brand = brand,
    debug = debug
  )

  init_js <- sprintf(
    "window.bs4DashkitTopnav && window.bs4DashkitTopnav.init({align:%s,style:%s,mobile:%s,overflow:%s,moreAfter:%s,title:%s,pageTitle:%s,brand:%s,debug:%s});",
    dashkit_js_literal(opts$align),
    dashkit_js_literal(opts$style),
    dashkit_js_literal(opts$mobile),
    dashkit_js_literal(opts$overflow),
    if (is.infinite(opts$more_after)) "null" else as.character(as.integer(opts$more_after)),
    dashkit_js_literal(opts$title),
    dashkit_js_literal(opts$page_title),
    tolower(opts$brand),
    tolower(isTRUE(opts$debug))
  )

  shiny::tagList(
    dashkit_topnav_dependency(),
    shiny::tags$head(
      shiny::tags$style(shiny::HTML(sprintf(
        ":root{--dash-topbar-h:%s;--dash-topnav-gap:%s;}", topbar_h, opts$gap
      )))
    ),
    shiny::tags$script(shiny::HTML(init_js))
  )
}
