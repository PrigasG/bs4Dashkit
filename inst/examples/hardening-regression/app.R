library(shiny)
library(bs4Dash)
library(bs4Dashkit)

safe_result <- function(expr) {
  tryCatch(
    {
      force(expr)
      list(status = "pass", message = "completed")
    },
    error = function(e) {
      list(status = "error", message = conditionMessage(e))
    },
    warning = function(w) {
      list(status = "warning", message = conditionMessage(w))
    }
  )
}

status_badge <- function(status) {
  class <- switch(status,
    pass = "badge badge-success",
    error = "badge badge-danger",
    warning = "badge badge-warning",
    "badge badge-secondary"
  )
  tags$span(class = class, status)
}

initial_ttl <- dash_titles(
  brand_text = "Trace Lab",
  app_name = "bs4Dashkit Hardening Regression",
  icon = icon("shield-halved"),
  icon_size = "22px",
  collapsed = "icon-text",
  expanded = "icon-text",
  collapsed_text = "O'B\\Lab",
  expanded_text = "Line one\n</script> still text",
  collapsed_text_size = "11px",
  expanded_text_size = "15px",
  collapsed_text_weight = 800,
  expanded_text_weight = 700,
  brand_divider = TRUE
)

ui <- bs4DashPage(
  title = initial_ttl$app_name,
  header = bs4DashNavbar(
    title = initial_ttl$brand,
    leftUi = dash_nav_title(
      "Hardening Regression",
      "Runtime trace and guardrail checks",
      icon = icon("bug"),
      align = "center"
    ),
    rightUi = tagList(
      dash_nav_refresh_item("refresh_trace", label = "Refresh"),
      dash_nav_help_item("help_trace", label = "Trace Guide")
    )
  ),
  sidebar = bs4DashSidebar(
    bs4SidebarMenu(
      bs4SidebarMenuItem("Runtime", tabName = "runtime", icon = icon("gauge-high")),
      bs4SidebarMenuItem("Validation", tabName = "validation", icon = icon("shield")),
      bs4SidebarMenuItem("Theme", tabName = "theme", icon = icon("palette")),
      bs4SidebarMenuItem("Trace", tabName = "trace", icon = icon("list-check"))
    )
  ),
  body = bs4DashBody(
    tags$script(HTML("
      (function(){
        function readTrace(){
          var label = document.querySelector('aside.main-sidebar .brand-link .dash-brand-label');
          var icons = document.querySelectorAll('aside.main-sidebar .brand-link .dash-brand-icon');
          var sidebar = document.querySelector('aside.main-sidebar, .main-sidebar');
          var payload = {
            label_text: label ? label.textContent : null,
            label_display: label ? label.style.display : null,
            icon_count: icons.length,
            body_class: document.body.className,
            sidebar_class: sidebar ? sidebar.className : null,
            timestamp: Date.now()
          };
          var target = document.getElementById('client_dom_trace');
          if(target){
            target.textContent = JSON.stringify(payload, null, 2);
          }
          if(typeof Shiny !== 'undefined' && typeof Shiny.setInputValue === 'function'){
            Shiny.setInputValue('dom_trace', payload, {priority: 'event'});
          } else if(typeof Shiny !== 'undefined' && typeof Shiny.onInputChange === 'function'){
            Shiny.onInputChange('dom_trace', payload);
          }
        }

        document.addEventListener('DOMContentLoaded', function(){
          setTimeout(readTrace, 150);
          document.body.addEventListener('click', function(){ setTimeout(readTrace, 75); });
          var sidebar = document.querySelector('aside.main-sidebar, .main-sidebar');
          if(sidebar){
            sidebar.addEventListener('mouseenter', function(){ setTimeout(readTrace, 75); });
            sidebar.addEventListener('mouseleave', function(){ setTimeout(readTrace, 75); });
          }
          new MutationObserver(readTrace).observe(document.body, {
            attributes: true,
            attributeFilter: ['class']
          });
        });
      })();
    ")),
    uiOutput("core_trace"),
    bs4TabItems(
      bs4TabItem(
        tabName = "runtime",
        fluidRow(
          bs4Card(
            title = "Sidebar Brand Inputs",
            width = 5,
            textInput("brand_text", "Brand text", value = "Trace Lab"),
            textInput("collapsed_text", "Collapsed label", value = "O'B\\Lab"),
            textAreaInput(
              "expanded_text",
              "Expanded label",
              value = "Line one\n</script> still text",
              rows = 3
            ),
            selectInput(
              "collapsed_mode",
              "Collapsed mode",
              choices = c("icon-text", "icon-only", "text-only"),
              selected = "icon-text"
            ),
            selectInput(
              "expanded_mode",
              "Expanded mode",
              choices = c("icon-text", "icon-only", "text-only"),
              selected = "icon-text"
            ),
            numericInput("collapsed_size", "Collapsed text size", value = 11, min = 8, max = 18, step = 1),
            numericInput("expanded_size", "Expanded text size", value = 15, min = 10, max = 24, step = 1)
          ),
          bs4Card(
            title = "Runtime DOM Trace",
            width = 7,
            tags$p("Collapse and hover the sidebar, then compare the live DOM trace with the expected labels."),
            tableOutput("runtime_expectations"),
            tags$hr(),
            tags$pre(id = "client_dom_trace", "Waiting for client trace..."),
            tags$hr(),
            verbatimTextOutput("dom_trace_out")
          )
        )
      ),
      bs4TabItem(
        tabName = "validation",
        fluidRow(
          bs4Card(
            title = "Guardrail Matrix",
            width = 12,
            tableOutput("validation_matrix")
          )
        ),
        fluidRow(
          bs4Card(
            title = "Ad Hoc CSS Probe",
            width = 6,
            textInput("probe_css", "Probe CSS value", value = "#fff;display:none"),
            actionButton("run_probe", "Run Probe", class = "btn-primary"),
            tags$hr(),
            uiOutput("probe_result")
          ),
          bs4Card(
            title = "Expected Error Targets",
            width = 6,
            tags$ul(
              tags$li("Theme color/style failures should name the theme argument."),
              tags$li("Brand style failures should name the brand styling argument."),
              tags$li("Sidebar dimension failures should name the dimension argument."),
              tags$li("Unsafe-looking label text should render as text, not break scripts.")
            )
          )
        )
      ),
      bs4TabItem(
        tabName = "theme",
        fluidRow(
          bs4Card(
            title = "Safe Theme Overrides",
            width = 5,
            selectInput(
              "preset",
              "Preset",
              choices = bs4dashkit_theme_presets()$preset,
              selected = "modern"
            ),
            selectInput(
              "accent",
              "Accent",
              choices = c("#2563eb", "#2d8a56", "#8b5cf6", "#b94a48"),
              selected = "#2563eb"
            ),
            numericInput("topbar_h", "Topbar height", value = 58, min = 48, max = 88, step = 2),
            numericInput("collapsed_w", "Collapsed width", value = 4.5, min = 3.5, max = 7, step = 0.1),
            numericInput("expanded_w", "Expanded width", value = 280, min = 220, max = 340, step = 10)
          ),
          bs4Card(
            title = "Visual Fixtures",
            width = 7,
            actionButton("primary_trace", "Primary action", class = "btn-primary"),
            tags$span(" "),
            actionButton("secondary_trace", "Secondary action", class = "btn btn-outline-secondary"),
            tags$hr(),
            tags$div(class = "alert alert-success", "Success alert"),
            tags$div(class = "alert alert-warning", "Warning alert"),
            tags$div(class = "alert alert-danger", "Danger alert"),
            tags$span(class = "badge badge-success", "Success"),
            tags$span(" "),
            tags$span(class = "badge badge-warning", "Warning"),
            tags$span(" "),
            tags$span(class = "badge badge-danger", "Danger")
          )
        )
      ),
      bs4TabItem(
        tabName = "trace",
        fluidRow(
          bs4Card(
            title = "Package and Session",
            width = 6,
            verbatimTextOutput("package_trace")
          ),
          bs4Card(
            title = "Generated Dependency Markers",
            width = 6,
            verbatimTextOutput("dependency_trace")
          )
        )
      )
    )
  ),
  footer = dash_footer(
    left_text = "bs4Dashkit hardening regression example",
    right_date = Sys.Date(),
    logo_src = NULL
  )
)

server <- function(input, output, session) {
  rv <- reactiveValues(last_refresh = Sys.time(), probe = NULL)

  current_ttl <- reactive({
    req(input$brand_text, input$collapsed_mode, input$expanded_mode)
    dash_titles(
      brand_text = input$brand_text,
      icon = icon("shield-halved"),
      icon_size = "22px",
      collapsed = input$collapsed_mode,
      expanded = input$expanded_mode,
      collapsed_text = if (nzchar(input$collapsed_text)) input$collapsed_text else input$brand_text,
      expanded_text = if (nzchar(input$expanded_text)) input$expanded_text else input$brand_text,
      collapsed_text_size = paste0(input$collapsed_size, "px"),
      expanded_text_size = paste0(input$expanded_size, "px"),
      collapsed_text_weight = 800,
      expanded_text_weight = 700
    )
  })

  output$core_trace <- renderUI({
    use_bs4Dashkit_core(
      current_ttl(),
      preset = input$preset,
      accent = input$accent,
      topbar_h = input$topbar_h,
      collapsed_w = input$collapsed_w,
      expanded_w = input$expanded_w
    )
  })

  output$runtime_expectations <- renderTable({
    data.frame(
      state = c("Collapsed", "Expanded or hover-expanded"),
      expected_label = c(
        if (identical(input$collapsed_mode, "icon-only")) "" else input$collapsed_text,
        if (identical(input$expanded_mode, "icon-only")) "" else input$expanded_text
      ),
      expected_icon = c(
        input$collapsed_mode %in% c("icon-only", "icon-text"),
        input$expanded_mode %in% c("icon-only", "icon-text")
      ),
      stringsAsFactors = FALSE
    )
  }, striped = TRUE, bordered = TRUE, spacing = "s")

  output$dom_trace_out <- renderPrint({
    input$dom_trace
  })

  output$validation_matrix <- renderTable({
    checks <- list(
      list(
        area = "JavaScript labels",
      call = "dash_titles(... collapsed_text = \"O'B\\\\Lab\", expanded_text = \"</script>\")",
        result = safe_result(dash_titles(
          "Trace Lab",
          icon = icon("shield-halved"),
          collapsed = "icon-text",
          expanded = "icon-text",
          collapsed_text = "O'B\\Lab",
          expanded_text = "Line one\n</script> still text"
        )),
        expected = "pass"
      ),
      list(
        area = "Theme CSS",
        call = "use_dash_theme(accent = \"#fff;display:none\")",
        result = safe_result(use_dash_theme(accent = "#fff;display:none")),
        expected = "error"
      ),
      list(
        area = "Brand CSS",
        call = "dash_brand_ui(color = \"#fff;background:red\")",
        result = safe_result(dash_brand_ui("Trace Lab", color = "#fff;background:red")),
        expected = "error"
      ),
      list(
        area = "Sidebar dimensions",
        call = "use_dash_sidebar_behavior(collapsed_w = -1)",
        result = safe_result(use_dash_sidebar_behavior(collapsed_w = -1)),
        expected = "error"
      ),
      list(
        area = "Valid preset override",
        call = "use_dash_theme_preset(\"modern\", accent = \"#2563eb\")",
        result = safe_result(use_dash_theme_preset("modern", accent = "#2563eb")),
        expected = "pass"
      )
    )

    data.frame(
      area = vapply(checks, `[[`, character(1), "area"),
      call = vapply(checks, `[[`, character(1), "call"),
      expected = vapply(checks, `[[`, character(1), "expected"),
      actual = vapply(checks, function(x) x$result$status, character(1)),
      message = vapply(checks, function(x) x$result$message, character(1)),
      stringsAsFactors = FALSE
    )
  }, striped = TRUE, bordered = TRUE, spacing = "s")

  observeEvent(input$run_probe, {
    rv$probe <- safe_result(use_dash_theme(accent = input$probe_css))
  })

  output$probe_result <- renderUI({
    if (is.null(rv$probe)) {
      return(tags$span(class = "text-muted", "Probe has not run yet."))
    }

    tagList(
      status_badge(rv$probe$status),
      tags$pre(rv$probe$message)
    )
  })

  output$package_trace <- renderPrint({
    list(
      package_version = as.character(utils::packageVersion("bs4Dashkit")),
      shiny_version = as.character(utils::packageVersion("shiny")),
      bs4Dash_version = as.character(utils::packageVersion("bs4Dash")),
      last_refresh = format(rv$last_refresh, "%Y-%m-%d %H:%M:%S")
    )
  })

  output$dependency_trace <- renderPrint({
    html <- as.character(current_ttl()$deps)
    list(
      has_json_encoded_short_label = grepl("O'B\\\\Lab", html, fixed = TRUE),
      has_script_closing_text_escaped = grepl("<\\\\/script>", html),
      has_sidebar_cleanup = grepl("__bs4DashkitSidebarBrandCleanup", html, fixed = TRUE),
      has_font_weight_hook = grepl("setProperty('font-weight'", html, fixed = TRUE)
    )
  })

  observeEvent(input$refresh_trace, {
    rv$last_refresh <- Sys.time()
  })

  observeEvent(input$help_trace, {
    showModal(
      modalDialog(
        title = "Trace guide",
        tags$ol(
          tags$li("Open Runtime, collapse the sidebar, and hover it."),
          tags$li("Confirm DOM trace label text changes without script errors."),
          tags$li("Open Validation and confirm expected and actual statuses match."),
          tags$li("Try an unsafe CSS probe and confirm the error names the argument."),
          tags$li("Open Theme and resize or recolor the dashboard with safe values.")
        ),
        easyClose = TRUE,
        footer = modalButton("Close")
      )
    )
  })
}

shinyApp(ui, server)
