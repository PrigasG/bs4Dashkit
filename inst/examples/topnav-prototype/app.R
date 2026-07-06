library(shiny)
library(bs4Dash)
library(bs4Dashkit)

ttl <- dash_titles(
  brand_text = "Topnav Lab",
  app_name = "bs4Dashkit Topnav Prototype",
  icon = icon("compass"),
  collapsed = "icon-only",
  expanded = "icon-text",
  expanded_text = "Topnav Lab",
  brand_divider = TRUE
)

ui <- bs4DashPage(
  title = ttl$app_name,
  header = bs4DashNavbar(
    title = ttl$brand,
    rightUi = tagList(
      dash_nav_title("Topnav Lab", "Mirrored bs4Dash sidebar menu", align = "center"),
      dash_nav_status_item("Prototype", status = "info", icon = "flask"),
      dash_nav_refresh_item("refresh_topnav", label = ""),
      dash_nav_help_item("help_topnav", label = "")
    )
  ),
  sidebar = bs4DashSidebar(
    bs4SidebarMenu(
      id = "sidebar",
      bs4SidebarMenuItem("Overview", tabName = "overview", icon = icon("gauge-high")),
      bs4SidebarMenuItem(
        "Reports",
        icon = icon("chart-line"),
        bs4SidebarMenuSubItem("Monthly", tabName = "monthly"),
        bs4SidebarMenuSubItem("Quality", tabName = "quality")
      ),
      bs4SidebarMenuItem("Settings", tabName = "settings", icon = icon("gear")),
      bs4SidebarMenuItem("Tools", tabName = "tools", icon = icon("screwdriver-wrench")),
      bs4SidebarMenuItem("Audit", tabName = "audit", icon = icon("clipboard-check"))
    )
  ),
  body = bs4DashBody(
    use_bs4Dashkit_core(
      ttl,
      preset = "professional",
      layout = "topnav",
      topnav = dash_topnav_options(
        align = "left",
        gap = 6,
        style = "compact",
        mobile = "collapse",
        overflow = "more",
        more_after = 4,
        title = "auto",
        page_title = "tab"
      ),
      topbar_h = "58px"
    ),
    bs4TabItems(
      bs4TabItem(
        tabName = "overview",
        fluidRow(
          bs4Card(
            title = "Top Navigation",
            width = 8,
            status = "primary",
            p("The sidebar is hidden, but its menu drives this navbar."),
            p("Use the navbar links, dropdown items, More menu, hamburger menu, or server button below to switch tabs.")
          ),
          bs4Card(
            title = "Server State",
            width = 4,
            verbatimTextOutput("state_topnav")
          )
        ),
        fluidRow(
          bs4Card(
            title = "Server-side tab update",
            width = 12,
            actionButton("go_quality", "Open Quality Report", class = "btn-primary")
          )
        )
      ),
      bs4TabItem(
        tabName = "monthly",
        fluidRow(
          bs4Card(title = "Monthly Report", width = 6, "Dropdown sub-item routing works."),
          bs4Card(title = "Theme", width = 6, "Professional preset tokens style the page chrome.")
        )
      ),
      bs4TabItem(
        tabName = "quality",
        fluidRow(
          bs4Card(title = "Quality Report", width = 12, "This tab can be opened by navbar dropdown or updateTabItems().")
        )
      ),
      bs4TabItem(
        tabName = "settings",
        fluidRow(
          bs4Card(
            title = "Settings",
            width = 12,
            tags$span(class = "badge badge-success", "Ready"),
            tags$span(" "),
            tags$span(class = "badge badge-warning", "Prototype")
          )
        )
      ),
      bs4TabItem(
        tabName = "tools",
        fluidRow(
          bs4Card(
            title = "Tools",
            width = 12,
            p("This top-level tab helps exercise spacing and overflow behavior.")
          )
        )
      ),
      bs4TabItem(
        tabName = "audit",
        fluidRow(
          bs4Card(
            title = "Audit",
            width = 12,
            p("This tab is intentionally placed after the visible limit so it appears under More.")
          )
        )
      )
    )
  ),
  footer = dash_footer(
    left_text = "bs4Dashkit top-nav prototype",
    right_date = Sys.Date(),
    logo_src = NULL
  )
)

server <- function(input, output, session) {
  output$state_topnav <- renderPrint({
    selected_tab <- if (is.null(input$sidebar)) "(not selected yet)" else input$sidebar
    topnav_event <- input$bs4dashkit_topnav
    if (is.null(topnav_event)) {
      topnav_event <- "(no top-nav click yet)"
    }

    list(
      sidebar_input = selected_tab,
      topnav_event = topnav_event,
      refreshed_at = format(Sys.time(), "%Y-%m-%d %H:%M:%S")
    )
  })

  observeEvent(input$go_quality, {
    updateTabItems(session, "sidebar", "quality")
  })

  observeEvent(input$refresh_topnav, {
    session$reload()
  })

  observeEvent(input$help_topnav, {
    showModal(modalDialog(
      title = "Top-nav prototype",
          tags$ul(
          tags$li("Navbar links delegate back to the hidden sidebar menu."),
          tags$li("Dropdown sub-items map to bs4SidebarMenuSubItem()."),
          tags$li("Mobile widths keep the tabs in a horizontal navbar scroll row."),
          tags$li("The Audit tab is moved into More by topnav_overflow = \"more\"."),
          tags$li("The page title above the content follows the active top-nav tab."),
          tags$li("The server button calls updateTabItems() using the sidebar menu id.")
        ),
      easyClose = TRUE,
      footer = modalButton("Close")
    ))
  })
}

shinyApp(ui, server)
