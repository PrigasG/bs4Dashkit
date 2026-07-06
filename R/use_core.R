#' Load bs4Dashkit core dependencies in one call
#'
#' Recommended entry point for bs4Dashkit in bs4DashBody().
#' For most apps, this should be the first element inside `bs4DashBody(...)`.
#'
#' @param ttl Output from dash_titles()
#' @param preset Optional theme preset name (e.g. "professional").
#'   If NULL, uses option bs4Dashkit.theme_preset (if set).
#' @param accent Optional accent override. If NULL, uses option bs4Dashkit.accent.
#'   If preset is used, this overrides the preset accent.
#' @param ... Optional overrides passed to use_dash_theme_preset() when preset is used.
#' @param topbar_h Height for topbar + brand strip. Numeric values are treated
#'   as pixels; CSS lengths such as \code{"3.5rem"} are also accepted.
#' @param collapsed_w Sidebar collapsed width. Numeric values are treated as
#'   rem; CSS lengths such as \code{"4.25rem"} are also accepted.
#' @param expanded_w Sidebar expanded width. Numeric values are treated as
#'   pixels; CSS lengths such as \code{"270px"} are also accepted.
#' @param layout Layout behavior to apply. \code{"sidebar"} keeps the default
#'   bs4Dash sidebar with hover-expand behavior. \code{"topnav"} hides the
#'   sidebar and mirrors its menu into the navbar with \code{use_dash_topnav()}.
#' @param topnav Optional output from \code{dash_topnav_options()}. When
#'   supplied, its values are used for the top-navigation settings below.
#' @param topnav_align Horizontal alignment for the mirrored top-nav menu when
#'   \code{layout = "topnav"}: \code{"left"}, \code{"center"}, or
#'   \code{"right"}. If a centered \code{dash_nav_title()} is also present,
#'   \code{"left"} or \code{"right"} usually leaves the title more readable.
#' @param topnav_gap Space between mirrored top-nav items. Numeric values are
#'   treated as pixels; CSS lengths such as \code{"0.5rem"} are also accepted.
#' @param topnav_style Visual style for top-nav tabs: \code{"underline"},
#'   \code{"pill"}, or \code{"compact"}.
#' @param topnav_mobile Mobile behavior: \code{"collapse"} shows a hamburger
#'   for tabs; \code{"scroll"} keeps a horizontal tab row.
#' @param topnav_overflow Desktop overflow behavior: \code{"auto"},
#'   \code{"more"}, or \code{"scroll"}.
#' @param topnav_more_after Number of top-level items kept visible when
#'   \code{topnav_overflow = "more"}.
#' @param topnav_title How centered \code{dash_nav_title()} behaves when tabs
#'   need space: \code{"auto"}, \code{"show"}, \code{"compact"}, or
#'   \code{"hide"}.
#' @param topnav_page_title Optional content title synced from the active
#'   top-nav tab: \code{"none"} or \code{"tab"}.
#' @param topnav_brand Logical. If \code{TRUE}, mirror the sidebar brand into
#'   the navbar when bs4Dash has not already placed one there.
#' @param topnav_debug Logical. If \code{TRUE}, print top-nav diagnostics to the
#'   browser console.
#'
#' @return A \code{shiny.tag.list} containing core CSS and/or JavaScript dependencies for bs4Dashkit.
#' @export
use_bs4Dashkit_core <- function(
    ttl,
    preset = NULL,
    accent = NULL,
    ...,
    topbar_h = 56,
    collapsed_w = 4.2,
    expanded_w = 250,
    layout = c("sidebar", "topnav"),
    topnav = NULL,
    topnav_align = c("left", "center", "right"),
    topnav_gap = 0,
    topnav_style = c("underline", "pill", "compact"),
    topnav_mobile = c("collapse", "scroll"),
    topnav_overflow = c("auto", "more", "scroll"),
    topnav_more_after = Inf,
    topnav_title = c("auto", "show", "compact", "hide"),
    topnav_page_title = c("none", "tab"),
    topnav_brand = TRUE,
    topnav_debug = FALSE
) {
  if (!is.list(ttl) || is.null(ttl$deps)) {
    stop("`ttl` must be the result of dash_titles() and contain `$deps`.")
  }

  if (identical(layout, c("sidebar", "topnav"))) {
    layout <- "sidebar"
  }
  if (identical(topnav_align, c("left", "center", "right"))) {
    topnav_align <- "left"
  }

  if (!is.null(topnav)) {
    if (!is.list(topnav)) {
      stop("`topnav` must be the result of dash_topnav_options() or a named list.", call. = FALSE)
    }
    topnav_align <- topnav$align %||% topnav_align
    topnav_gap <- topnav$gap %||% topnav_gap
    topnav_style <- topnav$style %||% topnav_style
    topnav_mobile <- topnav$mobile %||% topnav_mobile
    topnav_overflow <- topnav$overflow %||% topnav_overflow
    topnav_more_after <- topnav$more_after %||% topnav_more_after
    topnav_title <- topnav$title %||% topnav_title
    topnav_page_title <- topnav$page_title %||% topnav_page_title
    topnav_brand <- topnav$brand %||% topnav_brand
    topnav_debug <- topnav$debug %||% topnav_debug
  }

  if (!dashkit_is_scalar_character(layout) || !(layout %in% c("sidebar", "topnav"))) {
    stop('`layout` must be either "sidebar" or "topnav".', call. = FALSE)
  }
  if (!dashkit_is_scalar_character(topnav_align) || !(topnav_align %in% c("left", "center", "right"))) {
    stop('`topnav_align` must be one of "left", "center", or "right".', call. = FALSE)
  }
  topnav_style <- dashkit_match_choice(topnav_style, c("underline", "pill", "compact"), "topnav_style")
  topnav_mobile <- dashkit_match_choice(topnav_mobile, c("collapse", "scroll"), "topnav_mobile")
  topnav_overflow <- dashkit_match_choice(topnav_overflow, c("auto", "more", "scroll"), "topnav_overflow")
  topnav_title <- dashkit_match_choice(topnav_title, c("auto", "show", "compact", "hide"), "topnav_title")
  topnav_page_title <- dashkit_match_choice(topnav_page_title, c("none", "tab"), "topnav_page_title")
  if (!is.numeric(topnav_more_after) || length(topnav_more_after) != 1 || is.na(topnav_more_after) || topnav_more_after < 1) {
    stop("`topnav_more_after` must be a single positive number or Inf.", call. = FALSE)
  }
  if (!is.logical(topnav_brand) || length(topnav_brand) != 1 || is.na(topnav_brand)) {
    stop("`topnav_brand` must be TRUE or FALSE.", call. = FALSE)
  }
  if (!is.logical(topnav_debug) || length(topnav_debug) != 1 || is.na(topnav_debug)) {
    stop("`topnav_debug` must be TRUE or FALSE.", call. = FALSE)
  }
  collapsed_w <- dashkit_validate_css_dimension(collapsed_w, "collapsed_w", "rem")
  expanded_w <- dashkit_validate_css_dimension(expanded_w, "expanded_w", "px")
  topbar_h <- dashkit_validate_css_dimension(topbar_h, "topbar_h", "px")
  topnav_gap <- dashkit_validate_css_dimension(topnav_gap, "topnav_gap", "px", allow_zero = TRUE)

  preset <- preset %||% dashkit_opt("theme_preset", NULL)
  if (!is.null(preset) && length(preset) != 1) {
    stop("`preset` must be a single preset name, or NULL.")
  }
  if (!is.null(preset) && nzchar(preset)) preset <- as.character(preset)

  accent <- accent %||% dashkit_opt("accent", "#2f6f8f")
  if (!is.null(accent) && length(accent) != 1) {
    stop("`accent` must be a single string (CSS color), or NULL.")
  }

  theme_tag <- if (!is.null(preset) && nzchar(preset)) {
    use_dash_theme_preset(preset, accent = accent, ...)
  } else {
    use_dash_theme(accent = accent, ...)
  }

  shiny::tagList(
    use_bs4Dashkit(),
    ttl$deps,
    theme_tag,
    if (identical(layout, "topnav")) {
      use_dash_topnav(
        topbar_h = topbar_h,
        align = topnav_align,
        gap = topnav_gap,
        style = topnav_style,
        mobile = topnav_mobile,
        overflow = topnav_overflow,
        more_after = topnav_more_after,
        title = topnav_title,
        page_title = topnav_page_title,
        brand = topnav_brand,
        debug = topnav_debug
      )
    } else {
      use_dash_sidebar_behavior(
        topbar_h    = topbar_h,
        collapsed_w = collapsed_w,
        expanded_w  = expanded_w
      )
    }
  )
}

#' Minimal bs4Dashkit example app
#'
#' Returns a tiny runnable `shiny.appobj` that demonstrates the recommended
#' `dash_titles()` plus `use_bs4Dashkit_core()` flow.
#'
#' @return A `shiny.appobj`.
#' @export
bs4dashkit_example_app <- function() {
  ttl <- dash_titles(
    brand_text = "bs4Dashkit",
    icon = shiny::icon("cloud"),
    collapsed = "icon-text",
    expanded = "icon-text",
    collapsed_text = "bs4",
    expanded_text = "bs4Dashkit"
  )

  ui <- bs4Dash::bs4DashPage(
    title = ttl$app_name,
    header = bs4Dash::bs4DashNavbar(title = ttl$brand),
    sidebar = bs4Dash::bs4DashSidebar(
      bs4Dash::bs4SidebarMenu(
        bs4Dash::bs4SidebarMenuItem(
          "Dashboard",
          tabName = "dashboard",
          icon = shiny::icon("gauge-high")
        )
      )
    ),
    body = bs4Dash::bs4DashBody(
      use_bs4Dashkit_core(ttl, preset = "professional"),
      bs4Dash::bs4TabItems(
        bs4Dash::bs4TabItem(
          tabName = "dashboard",
          shiny::fluidRow(
            bs4Dash::bs4Card(
              title = "Minimal Example",
              width = 12,
              "This app shows the recommended bs4Dashkit setup."
            )
          )
        )
      )
    ),
    footer = dash_footer(left_text = "bs4Dashkit example", logo_src = NULL)
  )

  shiny::shinyApp(ui, function(input, output, session) {})
}

#' Interactive bs4Dashkit demo app
#'
#' Returns a richer runnable `shiny.appobj` for testing sidebar brand states,
#' hover-expand behavior, theme presets, navbar controls, and footer styling in
#' one place.
#'
#' @return A `shiny.appobj`.
#' @export
bs4dashkit_demo_app <- function() {
  initial_ttl <- dash_titles(
    brand_text = "BS4DASHKIT DASHBOARD",
    icon = shiny::icon("globe"),
    icon_size = "20px",
    collapsed = "icon-text",
    expanded = "icon-text",
    collapsed_text = "BS4",
    expanded_text = "BS4DASHKIT DASHBOARD",
    collapsed_text_weight = 700,
    expanded_text_weight = 800
  )

  ui <- bs4Dash::bs4DashPage(
    title = "bs4Dashkit Demo",
    header = bs4Dash::bs4DashNavbar(
      title = initial_ttl$brand,
      leftUi = shiny::uiOutput("header_left_ui"),
      rightUi = shiny::tagList(
        shiny::uiOutput("header_title_right_ui"),
        dash_nav_status_item("Ready", status = "success", icon = "circle-check"),
        dash_nav_refresh_item("refresh_demo", label = "Refresh"),
        dash_nav_help_item("help_demo", label = "Guide"),
        dash_user_menu(
          bs4Dash::dropdownMenu(
            type = "notifications",
            bs4Dash::notificationItem("Sidebar hover uses the expanded label rules."),
            bs4Dash::notificationItem("Leave expanded_text blank to use brand_text."),
            bs4Dash::notificationItem("Collapsed icon-text can use a shorter label.")
          )
        )
      )
    ),
    sidebar = bs4Dash::bs4DashSidebar(
      bs4Dash::bs4SidebarMenu(
        bs4Dash::bs4SidebarMenuItem(
          "Playground",
          tabName = "playground",
          icon = shiny::icon("sliders")
        ),
        bs4Dash::bs4SidebarMenuItem(
          "Theme Preview",
          tabName = "theme_preview",
          icon = shiny::icon("palette")
        ),
        bs4Dash::bs4SidebarMenuItem(
          "Status",
          tabName = "status",
          icon = shiny::icon("chart-line")
        )
      )
    ),
    body = bs4Dash::bs4DashBody(
      dashkit_demo_brand_dependency(),
      shiny::uiOutput("core_ui"),
      bs4Dash::bs4TabItems(
        bs4Dash::bs4TabItem(
          tabName = "playground",
          shiny::fluidRow(
            bs4Dash::bs4Card(
              title = "Brand Configuration",
              width = 5,
              shiny::textInput("brand_text_demo", "Brand text", value = "BS4DASHKIT DASHBOARD"),
              shiny::textInput("collapsed_text_demo", "Collapsed text", value = "BS4"),
              shiny::textInput("expanded_text_demo", "Expanded text", value = "BS4DASHKIT DASHBOARD"),
              shiny::selectInput(
                "icon_demo",
                "Icon",
                choices = c("(none)" = "", "globe", "cloud", "chart-line", "palette", "shield-halved", "bolt"),
                selected = "globe"
              ),
              shiny::selectInput(
                "collapsed_mode_demo",
                "Collapsed mode",
                choices = c("icon-only", "icon-text", "text-only"),
                selected = "icon-text"
              ),
              shiny::selectInput(
                "expanded_mode_demo",
                "Expanded mode",
                choices = c("icon-text", "icon-only", "text-only"),
                selected = "icon-text"
              ),
              shiny::sliderInput("icon_size_demo", "Icon size", min = 16, max = 36, value = 20, step = 1),
              shiny::sliderInput("collapsed_size_demo", "Collapsed text size", min = 9, max = 18, value = 11, step = 1),
              shiny::sliderInput("expanded_size_demo", "Expanded text size", min = 10, max = 22, value = 14, step = 1),
              shiny::sliderInput("collapsed_weight_demo", "Collapsed text weight", min = 400, max = 900, value = 700, step = 100),
              shiny::sliderInput("expanded_weight_demo", "Expanded text weight", min = 400, max = 900, value = 800, step = 100)
            ),
            bs4Dash::bs4Card(
              title = "Behavior and Theme",
              width = 7,
              shiny::selectInput(
                "preset_demo",
                "Preset",
                choices = bs4dashkit_theme_presets()$preset,
                selected = "professional"
              ),
              shiny::textInput("accent_demo", "Accent override", value = ""),
              shiny::numericInput("topbar_h_demo", "Topbar height", value = 56, min = 48, max = 88, step = 2),
              shiny::numericInput("collapsed_w_demo", "Collapsed width (rem)", value = 4.2, min = 3.5, max = 8, step = 0.1),
              shiny::numericInput("expanded_w_demo", "Expanded width (px)", value = 250, min = 220, max = 340, step = 10),
              shiny::selectInput(
                "navbar_align_demo",
                "Navbar title alignment",
                choices = c("Left" = "left", "Center" = "center", "Right" = "right"),
                selected = "right"
              ),
              shiny::div(
                style = "margin-top:12px;",
                shiny::strong("Try this next"),
                shiny::tags$ul(
                  shiny::tags$li("Collapse the sidebar, then hover over it."),
                  shiny::tags$li("Switch between BS4 and BS4DASHKIT DASHBOARD as you hover."),
                  shiny::tags$li("Switch Icon to (none) to test the text-only fallback warnings."),
                  shiny::tags$li("Flip the navbar title between left, center, and right to check placement.")
                )
              )
            )
          ),
          shiny::fluidRow(
            bs4Dash::bs4Card(
              title = "Resolved Sidebar Rules",
              width = 6,
              shiny::verbatimTextOutput("resolved_sidebar_demo")
            ),
            bs4Dash::bs4Card(
              title = "Live Notes",
              width = 6,
              shiny::uiOutput("live_notes_demo")
            )
          )
        ),
        bs4Dash::bs4TabItem(
          tabName = "theme_preview",
          shiny::fluidRow(
            bs4Dash::bs4Card(
              title = "Buttons and Links",
              width = 6,
              shiny::tags$p("Open the controls, switch presets, and compare how the chrome colors settle in."),
              shiny::actionButton("primary_demo", "Primary action", class = "btn-primary"),
              shiny::tags$span(" "),
              shiny::actionButton("secondary_demo", "Secondary action", class = "btn btn-outline-secondary"),
              shiny::tags$hr(),
              shiny::tags$p(
                "Preset links should feel coherent with cards, navbar, and sidebar. ",
                shiny::tags$a(href = "#", "Sample link")
              )
            ),
            bs4Dash::bs4Card(
              title = "Status Colors",
              width = 6,
              shiny::tags$div(class = "alert alert-success", "Success styling"),
              shiny::tags$div(class = "alert alert-warning", "Warning styling"),
              shiny::tags$div(class = "alert alert-danger", "Danger styling"),
              shiny::tags$div(
                style = "display:flex; gap:10px; flex-wrap:wrap; margin-top:12px;",
                shiny::tags$span(class = "badge badge-success", "Success"),
                shiny::tags$span(class = "badge badge-warning", "Warning"),
                shiny::tags$span(class = "badge badge-danger", "Danger")
              )
            )
          ),
          shiny::fluidRow(
            bs4Dash::bs4Card(
              title = "Preset Tokens",
              width = 12,
              shiny::tableOutput("preset_tokens_demo")
            )
          )
        ),
        bs4Dash::bs4TabItem(
          tabName = "status",
          shiny::fluidRow(
            bs4Dash::bs4Card(
              title = "Session Status",
              width = 4,
              shiny::strong("Last refresh"),
              shiny::tags$p(shiny::textOutput("last_refresh_demo"))
            ),
            bs4Dash::bs4Card(
              title = "Current Label Preview",
              width = 4,
              shiny::strong("Navbar / expanded default"),
              shiny::tags$p(shiny::textOutput("expanded_preview_demo")),
              shiny::strong("Collapsed preview"),
              shiny::tags$p(shiny::textOutput("collapsed_preview_demo"))
            ),
            bs4Dash::bs4Card(
              title = "Current Preset",
              width = 4,
              shiny::textOutput("preset_preview_demo")
            )
          )
        )
      )
    ),
    footer = dash_footer(
      left_text = "bs4Dashkit interactive demo",
      right_date = Sys.Date(),
      logo_src = NULL
    )
  )

  server <- function(input, output, session) {
    rv <- shiny::reactiveValues(last_refresh = Sys.time())

    demo_ttl <- shiny::reactive({
      shiny::req(input$brand_text_demo)

      collapsed_text_resolved <- if (identical(input$collapsed_mode_demo, "icon-only")) {
        NULL
      } else if (nzchar(input$collapsed_text_demo)) {
        input$collapsed_text_demo
      } else {
        input$brand_text_demo
      }

      expanded_text_resolved <- if (identical(input$expanded_mode_demo, "icon-only")) {
        NULL
      } else if (nzchar(input$expanded_text_demo)) {
        input$expanded_text_demo
      } else {
        input$brand_text_demo
      }

      dash_titles(
        brand_text = input$brand_text_demo,
        icon = if (nzchar(input$icon_demo)) shiny::icon(input$icon_demo) else NULL,
        icon_size = paste0(input$icon_size_demo, "px"),
        collapsed = input$collapsed_mode_demo,
        expanded = input$expanded_mode_demo,
        collapsed_text = collapsed_text_resolved,
        expanded_text = expanded_text_resolved,
        collapsed_text_size = paste0(input$collapsed_size_demo, "px"),
        expanded_text_size = paste0(input$expanded_size_demo, "px"),
        collapsed_text_weight = input$collapsed_weight_demo,
        expanded_text_weight = input$expanded_weight_demo
      )
    })

    shiny::observe({
      shiny::req(input$brand_text_demo, input$icon_size_demo)
      session$sendCustomMessage("bs4dashkit-demo-brand", list(
        brand_text = input$brand_text_demo,
        icon = if (nzchar(input$icon_demo)) input$icon_demo else "",
        icon_size = paste0(input$icon_size_demo, "px")
      ))
    })

    output$header_left_ui <- shiny::renderUI({
      shiny::req(input$navbar_align_demo)
      if (!identical(input$navbar_align_demo, "left")) {
        return(NULL)
      }

      dash_nav_title(
        "bs4Dashkit Demo",
        "Interactive sidebar and theme playground",
        align = "left"
      )
    })

    output$header_title_right_ui <- shiny::renderUI({
      shiny::req(input$navbar_align_demo)
      if (identical(input$navbar_align_demo, "left")) {
        return(NULL)
      }

      dash_nav_title(
        "bs4Dashkit Demo",
        "Interactive sidebar and theme playground",
        align = input$navbar_align_demo
      )
    })

    output$core_ui <- shiny::renderUI({
      use_bs4Dashkit_core(
        demo_ttl(),
        preset = input$preset_demo,
        accent = if (nzchar(input$accent_demo)) input$accent_demo else NULL,
        topbar_h = input$topbar_h_demo,
        collapsed_w = input$collapsed_w_demo,
        expanded_w = input$expanded_w_demo
      )
    })

    output$resolved_sidebar_demo <- shiny::renderPrint({
      print(list(
        brand_text = input$brand_text_demo,
        collapsed_mode = input$collapsed_mode_demo,
        expanded_mode = input$expanded_mode_demo,
        collapsed_text = if (identical(input$collapsed_mode_demo, "icon-only")) "" else if (nzchar(input$collapsed_text_demo)) input$collapsed_text_demo else input$brand_text_demo,
        expanded_text = if (identical(input$expanded_mode_demo, "icon-only")) "" else if (nzchar(input$expanded_text_demo)) input$expanded_text_demo else input$brand_text_demo,
        collapsed_text_size = paste0(input$collapsed_size_demo, "px"),
        expanded_text_size = paste0(input$expanded_size_demo, "px"),
        has_icon = nzchar(input$icon_demo)
      ))
    })

    output$live_notes_demo <- shiny::renderUI({
      expanded_label <- if (nzchar(input$expanded_text_demo)) input$expanded_text_demo else input$brand_text_demo
      notes <- list(
        shiny::tags$li("Hover-expanded sidebars follow the expanded mode rules."),
        shiny::tags$li(sprintf("Expanded label right now: %s", expanded_label)),
        shiny::tags$li(sprintf("Collapsed mode: %s", input$collapsed_mode_demo)),
        shiny::tags$li(sprintf("Expanded mode: %s", input$expanded_mode_demo)),
        shiny::tags$li(sprintf("Icon size: %spx", input$icon_size_demo)),
        shiny::tags$li(sprintf("Collapsed text size: %spx", input$collapsed_size_demo)),
        shiny::tags$li(sprintf("Expanded text size: %spx", input$expanded_size_demo))
      )

      if (!nzchar(input$icon_demo) && input$expanded_mode_demo %in% c("icon-only", "icon-text")) {
        notes <- c(notes, shiny::tags$li("No icon is selected, so the expanded sidebar falls back to text-only."))
      }

      shiny::tags$ul(notes)
    })

    output$preset_tokens_demo <- shiny::renderTable({
      tokens <- bs4dashkit_theme_presets(values = TRUE)
      token_values <- tokens$tokens[[match(input$preset_demo, tokens$preset)]]
      data.frame(
        token = names(token_values),
        value = vapply(token_values, as.character, character(1)),
        stringsAsFactors = FALSE
      )
    }, striped = TRUE, bordered = TRUE, spacing = "s")

    output$last_refresh_demo <- shiny::renderText({
      format(rv$last_refresh, "%Y-%m-%d %H:%M:%S")
    })

    output$expanded_preview_demo <- shiny::renderText({
      if (nzchar(input$expanded_text_demo)) input$expanded_text_demo else input$brand_text_demo
    })

    output$collapsed_preview_demo <- shiny::renderText({
      if (nzchar(input$collapsed_text_demo)) input$collapsed_text_demo else input$brand_text_demo
    })

    output$preset_preview_demo <- shiny::renderText({
      paste("Preset:", input$preset_demo)
    })

    shiny::observeEvent(input$refresh_demo, {
      rv$last_refresh <- Sys.time()
    })

    shiny::observeEvent(input$help_demo, {
      shiny::showModal(
        shiny::modalDialog(
          title = "Demo guide",
          shiny::tags$ul(
            shiny::tags$li("Use Brand Configuration to change sidebar text behavior."),
            shiny::tags$li("Collapse the sidebar and hover over it to verify the expanded text rules."),
            shiny::tags$li("Switch presets to compare navbar, sidebar, footer, and alert styling together.")
          ),
          easyClose = TRUE,
          footer = shiny::modalButton("Close")
        )
      )
    })
  }

  shiny::shinyApp(ui, server)
}
