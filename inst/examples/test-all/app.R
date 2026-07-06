library(shiny)
library(bs4Dash)
library(bs4Dashkit)

ttl <- dash_titles(
  brand_text = "Feature Lab",
  app_name = "bs4Dashkit Test All",
  icon = icon("shield-halved"),
  icon_size = "22px",
  collapsed = "text-only",
  expanded = "icon-text",
  collapsed_text = "LAB",
  expanded_text = "Feature Lab",
  collapsed_text_size = "12px",
  expanded_text_size = "16px",
  collapsed_text_weight = 800,
  expanded_text_weight = 700,
  brand_divider = TRUE
)

ttl_icon_only <- dash_titles(
  brand_text = NULL,
  app_name = "Icon Only",
  icon = icon("cloud"),
  collapsed = "icon-only",
  expanded = "icon-only"
)

ui <- bs4DashPage(
  title = ttl$app_name,
  header = bs4DashNavbar(
    title = ttl$brand,
    leftUi = dash_nav_title(
      "Feature Lab",
      "Center alignment check",
      icon = icon("compass"),
      align = "center"
    ),
    rightUi = tagList(
      dash_nav_status_item("Ready", status = "success", icon = "circle-check"),
      dash_nav_refresh_item("refresh_all", label = "Refresh"),
      dash_nav_help_item("help_all", label = "Guide"),
      dash_user_menu(
        dropdownMenu(
          type = "notifications",
          notificationItem("Collapsed text-only brand is centered."),
          notificationItem("Sidebar hover uses expanded text rules."),
          notificationItem("Navbar title alignment is live-tested here.")
        )
      )
    )
  ),
  sidebar = bs4DashSidebar(
    bs4SidebarMenu(
      bs4SidebarMenuItem("Overview", tabName = "overview", icon = icon("gauge-high")),
      bs4SidebarMenuItem("Brand", tabName = "brand", icon = icon("signature")),
      bs4SidebarMenuItem("Theme", tabName = "theme", icon = icon("palette")),
      bs4SidebarMenuItem("Status", tabName = "status", icon = icon("chart-line"))
    )
  ),
  body = bs4DashBody(
    use_bs4Dashkit_core(
      ttl,
      preset = "modern",
      topbar_h = 58,
      collapsed_w = 4.5,
      expanded_w = 280
    ),
    bs4TabItems(
      bs4TabItem(
        tabName = "overview",
        fluidRow(
          bs4Card(
            title = "Coverage",
            width = 6,
            p("This example intentionally drives the package a little harder."),
            tags$ul(
              tags$li("centered navbar title"),
              tags$li("collapsed text-only sidebar label"),
              tags$li("expanded icon-text sidebar label"),
              tags$li("collapsed and expanded text size / weight overrides"),
              tags$li("footer, buttons, alerts, badges, and theme preset tokens")
            )
          ),
          bs4Card(
            title = "Quick Values",
            width = 6,
            verbatimTextOutput("summary_all")
          )
        ),
        fluidRow(
          bs4Card(title = "Primary", width = 4, status = "primary", "Primary card"),
          bs4Card(title = "Warning", width = 4, status = "warning", "Warning card"),
          bs4Card(title = "Success", width = 4, status = "success", "Success card")
        )
      ),
      bs4TabItem(
        tabName = "brand",
        fluidRow(
          bs4Card(
            title = "Main Brand",
            width = 7,
            tags$p("This app uses `collapsed = \"text-only\"` and `expanded = \"icon-text\"`."),
            tags$pre(as.character(ttl$brand))
          ),
          bs4Card(
            title = "Icon-Only Variant",
            width = 5,
            tags$p("This exercises `brand_text = NULL` with both states set to icon-only."),
            div(
              style = "display:flex; align-items:center; gap:12px; font-size:18px;",
              ttl_icon_only$brand,
              tags$span("Icon-only brand object")
            )
          )
        )
      ),
      bs4TabItem(
        tabName = "theme",
        fluidRow(
          bs4Card(
            title = "Actions",
            width = 6,
            actionButton("primary_all", "Primary action", class = "btn-primary"),
            tags$span(" "),
            actionButton("secondary_all", "Secondary action", class = "btn btn-outline-secondary"),
            tags$hr(),
            tags$div(class = "alert alert-success", "Success styling"),
            tags$div(class = "alert alert-warning", "Warning styling"),
            tags$div(class = "alert alert-danger", "Danger styling")
          ),
          bs4Card(
            title = "Preset Tokens",
            width = 6,
            tableOutput("tokens_all")
          )
        )
      ),
      bs4TabItem(
        tabName = "status",
        fluidRow(
          bs4Card(
            title = "Badges",
            width = 4,
            tags$span(class = "badge badge-primary", "Primary"),
            tags$span(" "),
            tags$span(class = "badge badge-success", "Success"),
            tags$span(" "),
            tags$span(class = "badge badge-warning", "Warning")
          ),
          bs4Card(
            title = "Time",
            width = 4,
            textOutput("refresh_time_all")
          ),
          bs4Card(
            title = "Links",
            width = 4,
            tags$a(href = "#", "Sample link")
          )
        )
      )
    )
  ),
  footer = dash_footer(
    left_text = "bs4Dashkit all-features example",
    right_date = Sys.Date(),
    logo_src = NULL
  )
)

server <- function(input, output, session) {
  rv <- reactiveValues(last_refresh = Sys.time())

  output$summary_all <- renderPrint({
    print(list(
      main_brand = list(
        collapsed = "text-only",
        expanded = "icon-text",
        collapsed_text = "LAB",
        expanded_text = "Feature Lab",
        collapsed_text_size = "12px",
        expanded_text_size = "16px",
        collapsed_text_weight = 800,
        expanded_text_weight = 700
      ),
      icon_only_brand = list(
        brand_text = NULL,
        collapsed = "icon-only",
        expanded = "icon-only"
      )
    ))
  })

  output$tokens_all <- renderTable({
    tokens <- bs4dashkit_theme_presets(values = TRUE)
    token_values <- tokens$tokens[[match("modern", tokens$preset)]]
    data.frame(
      token = names(token_values),
      value = vapply(token_values, as.character, character(1)),
      stringsAsFactors = FALSE
    )
  }, striped = TRUE, bordered = TRUE, spacing = "s")

  output$refresh_time_all <- renderText({
    format(rv$last_refresh, "%Y-%m-%d %H:%M:%S")
  })

  observeEvent(input$refresh_all, {
    rv$last_refresh <- Sys.time()
  })

  observeEvent(input$help_all, {
    showModal(
      modalDialog(
        title = "Test-all guide",
        tags$ul(
          tags$li("Collapse the sidebar and check that the centered LAB label stays put."),
          tags$li("Hover over the collapsed sidebar and confirm the expanded rules take over."),
          tags$li("Resize the window to check the centered navbar title."),
          tags$li("Open the Brand tab to inspect the textless icon-only variant.")
        ),
        easyClose = TRUE,
        footer = modalButton("Close")
      )
    )
  })
}

shinyApp(ui, server)
