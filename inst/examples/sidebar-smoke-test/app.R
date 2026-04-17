library(shiny)
library(bs4Dash)
library(bs4Dashkit)

ttl <- dash_titles(
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
  title = "Sidebar Smoke Test",
  header = bs4DashNavbar(
    title = ttl$brand
  ),
  sidebar = bs4DashSidebar(
    bs4SidebarMenu(
      bs4SidebarMenuItem("Playground", tabName = "playground", icon = icon("sliders")),
      bs4SidebarMenuItem("Reports", tabName = "reports", icon = icon("chart-line")),
      bs4SidebarMenuItem("Theme", tabName = "theme", icon = icon("palette")),
      bs4SidebarMenuItem("Settings", tabName = "settings", icon = icon("gear"))
    )
  ),
  body = bs4DashBody(
    use_bs4Dashkit_core(
      ttl,
      preset = "professional",
      topbar_h = 56,
      collapsed_w = 4.2,
      expanded_w = 250
    ),
    bs4TabItems(
      bs4TabItem(
        tabName = "playground",
        fluidRow(
          bs4Card(
            title = "Sidebar Smoke Test",
            width = 12,
            tags$ol(
              tags$li("Collapse the sidebar."),
              tags$li("Check that the sidebar title shows BS4 while collapsed."),
              tags$li("Hover the collapsed sidebar and check that the title changes to BS4DASHKIT DASHBOARD."),
              tags$li("Watch the first menu item and confirm it does not jump upward during hover-expand.")
            ),
            tags$hr(),
            tags$p(strong("Collapsed label:"), " BS4"),
            tags$p(strong("Expanded label:"), " BS4DASHKIT DASHBOARD"),
            tags$p(strong("Collapsed text weight:"), " 700"),
            tags$p(strong("Expanded text weight:"), " 800")
          )
        )
      ),
      bs4TabItem(
        tabName = "reports",
        fluidRow(
          bs4Card(
            title = "Reports",
            width = 12,
            "This tab exists only to give the sidebar a second stable item."
          )
        )
      ),
      bs4TabItem(
        tabName = "theme",
        fluidRow(
          bs4Card(
            title = "Theme",
            width = 12,
            "This tab exists only to give the sidebar a third stable item."
          )
        )
      ),
      bs4TabItem(
        tabName = "settings",
        fluidRow(
          bs4Card(
            title = "Settings",
            width = 12,
            "This tab exists only to give the sidebar a fourth stable item."
          )
        )
      )
    )
  ),
  footer = dash_footer(
    left_text = "bs4Dashkit sidebar smoke test",
    right_date = Sys.Date(),
    logo_src = NULL
  )
)

server <- function(input, output, session) {}

shinyApp(ui, server)
