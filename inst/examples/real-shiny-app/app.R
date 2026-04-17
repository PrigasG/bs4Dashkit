library(shiny)
library(bs4Dash)
library(bs4Dashkit)

initial_ttl <- dash_titles(
  brand_text = "BS4DASHKIT DASHBOARD",
  icon = icon("globe"),
  icon_size = "20px",
  collapsed = "icon-text",
  expanded = "icon-text",
  collapsed_text = "BS4",
  expanded_text = "BS4DASHKIT DASHBOARD",
  collapsed_text_weight = 700,
  expanded_text_weight = 800
)

ui <- bs4DashPage(
  title = "bs4Dashkit Demo",
  header = bs4DashNavbar(
    title = initial_ttl$brand,
    leftUi = uiOutput("header_left_ui"),
    rightUi = tagList(
      uiOutput("header_title_right_ui"),
      dash_nav_item(dash_nav_refresh_button("refresh_demo", label = "Refresh")),
      dash_nav_item(dash_nav_help_button("help_demo", label = "Guide")),
      dash_nav_item(
        dash_user_menu(
          dropdownMenu(
            type = "notifications",
            notificationItem("Sidebar hover uses the expanded label rules."),
            notificationItem("Leave expanded_text blank to use brand_text."),
            notificationItem("Collapsed icon-text can use a shorter label.")
          )
        )
      )
    )
  ),
  sidebar = bs4DashSidebar(
    bs4SidebarMenu(
      bs4SidebarMenuItem(
        "Playground",
        tabName = "playground",
        icon = icon("sliders")
      ),
      bs4SidebarMenuItem(
        "Theme Preview",
        tabName = "theme_preview",
        icon = icon("palette")
      ),
      bs4SidebarMenuItem(
        "Status",
        tabName = "status",
        icon = icon("chart-line")
      )
    )
  ),
  body = bs4DashBody(
    tags$script(HTML("
      Shiny.addCustomMessageHandler('bs4dashkit-demo-brand', function(message) {
        function updateLabel(label) {
          if (!label) return;
          label.textContent = message.brand_text || '';
        }

        function updateIcon(label) {
          if (!label || !label.parentElement) return;
          var parent = label.parentElement;
          var icon = parent.querySelector('.dash-brand-icon');
          var hasIcon = !!(message.icon && message.icon.length);

          if (!hasIcon) {
            if (icon) icon.style.display = 'none';
            return;
          }

          if (!icon) {
            icon = document.createElement('i');
            parent.insertBefore(icon, label);
          }

          icon.className = 'fas fa-' + message.icon + ' fa-fw dash-brand-icon';
          icon.style.display = '';
          icon.style.fontSize = message.icon_size || '';
        }

        var labels = document.querySelectorAll('.main-header .dash-brand-label, .main-sidebar .dash-brand-label');
        labels.forEach(function(label) {
          updateLabel(label);
          updateIcon(label);
        });
      });
    ")),
    uiOutput("core_ui"),
    bs4TabItems(
      bs4TabItem(
        tabName = "playground",
        fluidRow(
          bs4Card(
            title = "Brand Configuration",
            width = 5,
            textInput("brand_text_demo", "Brand text", value = "BS4DASHKIT DASHBOARD"),
            textInput("collapsed_text_demo", "Collapsed text", value = "BS4"),
            textInput("expanded_text_demo", "Expanded text", value = "BS4DASHKIT DASHBOARD"),
            selectInput(
              "icon_demo",
              "Icon",
              choices = c("(none)" = "", "globe", "cloud", "chart-line", "palette", "shield-halved", "bolt"),
              selected = "globe"
            ),
            selectInput(
              "collapsed_mode_demo",
              "Collapsed mode",
              choices = c("icon-only", "icon-text", "text-only"),
              selected = "icon-text"
            ),
            selectInput(
              "expanded_mode_demo",
              "Expanded mode",
              choices = c("icon-text", "icon-only", "text-only"),
              selected = "icon-text"
            ),
            sliderInput("icon_size_demo", "Icon size", min = 16, max = 36, value = 20, step = 1),
            sliderInput(
              "collapsed_size_demo",
              "Collapsed text size",
              min = 9,
              max = 18,
              value = 11,
              step = 1
            ),
            sliderInput(
              "expanded_size_demo",
              "Expanded text size",
              min = 10,
              max = 22,
              value = 14,
              step = 1
            ),
            sliderInput(
              "collapsed_weight_demo",
              "Collapsed text weight",
              min = 400,
              max = 900,
              value = 700,
              step = 100
            ),
            sliderInput(
              "expanded_weight_demo",
              "Expanded text weight",
              min = 400,
              max = 900,
              value = 800,
              step = 100
            )
          ),
          bs4Card(
            title = "Behavior and Theme",
            width = 7,
            selectInput(
              "preset_demo",
              "Preset",
              choices = bs4dashkit_theme_presets()$preset,
              selected = "professional"
            ),
            textInput("accent_demo", "Accent override", value = ""),
            numericInput("topbar_h_demo", "Topbar height", value = 56, min = 48, max = 88, step = 2),
            numericInput("collapsed_w_demo", "Collapsed width (rem)", value = 4.2, min = 3.5, max = 8, step = 0.1),
            numericInput("expanded_w_demo", "Expanded width (px)", value = 250, min = 220, max = 340, step = 10),
            selectInput(
              "navbar_align_demo",
              "Navbar title alignment",
              choices = c("Left" = "left", "Center" = "center", "Right" = "right"),
              selected = "right"
            ),
            div(
              style = "margin-top:12px;",
              strong("Try this next"),
              tags$ul(
                tags$li("Collapse the sidebar, then hover over it."),
                tags$li("Switch between BS4 and BS4DASHKIT DASHBOARD as you hover."),
                tags$li("Switch Icon to (none) to test the text-only fallback warnings."),
                tags$li("Flip the navbar title between left, center, and right to check placement.")
              )
            )
          )
        ),
        fluidRow(
          bs4Card(
            title = "Resolved Sidebar Rules",
            width = 6,
            verbatimTextOutput("resolved_sidebar_demo")
          ),
          bs4Card(
            title = "Live Notes",
            width = 6,
            uiOutput("live_notes_demo")
          )
        )
      ),
      bs4TabItem(
        tabName = "theme_preview",
        fluidRow(
          bs4Card(
            title = "Buttons and Links",
            width = 6,
            tags$p("Open the controls, switch presets, and compare how the chrome colors settle in."),
            actionButton("primary_demo", "Primary action", class = "btn-primary"),
            tags$span(" "),
            actionButton("secondary_demo", "Secondary action", class = "btn btn-outline-secondary"),
            tags$hr(),
            tags$p(
              "Preset links should feel coherent with cards, navbar, and sidebar. ",
              tags$a(href = "#", "Sample link")
            )
          ),
          bs4Card(
            title = "Status Colors",
            width = 6,
            tags$div(class = "alert alert-success", "Success styling"),
            tags$div(class = "alert alert-warning", "Warning styling"),
            tags$div(class = "alert alert-danger", "Danger styling"),
            tags$div(
              style = "display:flex; gap:10px; flex-wrap:wrap; margin-top:12px;",
              tags$span(class = "badge badge-success", "Success"),
              tags$span(class = "badge badge-warning", "Warning"),
              tags$span(class = "badge badge-danger", "Danger")
            )
          )
        ),
        fluidRow(
          bs4Card(
            title = "Preset Tokens",
            width = 12,
            tableOutput("preset_tokens_demo")
          )
        )
      ),
      bs4TabItem(
        tabName = "status",
        fluidRow(
          bs4Card(
            title = "Session Status",
            width = 4,
            strong("Last refresh"),
            tags$p(textOutput("last_refresh_demo"))
          ),
          bs4Card(
            title = "Current Label Preview",
            width = 4,
            strong("Navbar / expanded default"),
            tags$p(textOutput("expanded_preview_demo")),
            strong("Collapsed preview"),
            tags$p(textOutput("collapsed_preview_demo"))
          ),
          bs4Card(
            title = "Current Preset",
            width = 4,
            textOutput("preset_preview_demo")
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
  rv <- reactiveValues(last_refresh = Sys.time())

  demo_ttl <- reactive({
    req(input$brand_text_demo)

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
      icon = if (nzchar(input$icon_demo)) icon(input$icon_demo) else NULL,
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

  observe({
    req(input$brand_text_demo, input$icon_size_demo)
    session$sendCustomMessage("bs4dashkit-demo-brand", list(
      brand_text = input$brand_text_demo,
      icon = if (nzchar(input$icon_demo)) input$icon_demo else "",
      icon_size = paste0(input$icon_size_demo, "px")
    ))
  })

  output$header_left_ui <- renderUI({
    req(input$navbar_align_demo)
    if (!identical(input$navbar_align_demo, "left")) {
      return(NULL)
    }

    dash_nav_title(
      "bs4Dashkit Demo",
      "Interactive sidebar and theme playground",
      align = "left"
    )
  })

  output$header_title_right_ui <- renderUI({
    req(input$navbar_align_demo)
    if (identical(input$navbar_align_demo, "left")) {
      return(NULL)
    }

    dash_nav_title(
      "bs4Dashkit Demo",
      "Interactive sidebar and theme playground",
      align = input$navbar_align_demo
    )
  })

  output$core_ui <- renderUI({
    use_bs4Dashkit_core(
      demo_ttl(),
      preset = input$preset_demo,
      accent = if (nzchar(input$accent_demo)) input$accent_demo else NULL,
      topbar_h = input$topbar_h_demo,
      collapsed_w = input$collapsed_w_demo,
      expanded_w = input$expanded_w_demo
    )
  })

  output$resolved_sidebar_demo <- renderPrint({
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

  output$live_notes_demo <- renderUI({
    expanded_label <- if (nzchar(input$expanded_text_demo)) input$expanded_text_demo else input$brand_text_demo
    notes <- list(
      tags$li("Hover-expanded sidebars follow the expanded mode rules."),
      tags$li(sprintf("Expanded label right now: %s", expanded_label)),
      tags$li(sprintf("Collapsed mode: %s", input$collapsed_mode_demo)),
      tags$li(sprintf("Expanded mode: %s", input$expanded_mode_demo)),
      tags$li(sprintf("Icon size: %spx", input$icon_size_demo)),
      tags$li(sprintf("Collapsed text size: %spx", input$collapsed_size_demo)),
      tags$li(sprintf("Expanded text size: %spx", input$expanded_size_demo))
    )

    if (!nzchar(input$icon_demo) && input$expanded_mode_demo %in% c("icon-only", "icon-text")) {
      notes <- c(notes, tags$li("No icon is selected, so the expanded sidebar falls back to text-only."))
    }

    tags$ul(notes)
  })

  output$preset_tokens_demo <- renderTable({
    tokens <- bs4dashkit_theme_presets(values = TRUE)
    token_values <- tokens$tokens[[match(input$preset_demo, tokens$preset)]]
    data.frame(
      token = names(token_values),
      value = vapply(token_values, as.character, character(1)),
      stringsAsFactors = FALSE
    )
  }, striped = TRUE, bordered = TRUE, spacing = "s")

  output$last_refresh_demo <- renderText({
    format(rv$last_refresh, "%Y-%m-%d %H:%M:%S")
  })

  output$expanded_preview_demo <- renderText({
    if (nzchar(input$expanded_text_demo)) input$expanded_text_demo else input$brand_text_demo
  })

  output$collapsed_preview_demo <- renderText({
    if (nzchar(input$collapsed_text_demo)) input$collapsed_text_demo else input$brand_text_demo
  })

  output$preset_preview_demo <- renderText({
    paste("Preset:", input$preset_demo)
  })

  observeEvent(input$refresh_demo, {
    rv$last_refresh <- Sys.time()
  })

  observeEvent(input$help_demo, {
    showModal(
      modalDialog(
        title = "Demo guide",
        tags$ul(
          tags$li("Use Brand Configuration to change sidebar text behavior."),
          tags$li("Collapse the sidebar and hover over it to verify the expanded text rules."),
          tags$li("Switch presets to compare navbar, sidebar, footer, and alert styling together.")
        ),
        easyClose = TRUE,
        footer = modalButton("Close")
      )
    )
  })
}

shinyApp(ui, server)
