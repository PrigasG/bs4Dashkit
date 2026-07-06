test_that("dash_nav_refresh_button() returns a shiny tag/tagList", {
  btn <- dash_nav_refresh_button("refresh")
  expect_true(inherits(btn, c("shiny.tag", "shiny.tag.list")))
})

test_that("dash_nav_refresh_button() respects custom label", {
  btn <- dash_nav_refresh_button("refresh", label = "Reload Page")
  expect_match(as.character(btn), "Reload Page", fixed = TRUE)
})

test_that("dash_nav_refresh_button() allows empty label (icon only)", {
  expect_no_error(dash_nav_refresh_button("refresh", label = ""))
})

test_that("dash_nav_help_button() returns a shiny tag/tagList", {
  btn <- dash_nav_help_button("help")
  expect_true(inherits(btn, c("shiny.tag", "shiny.tag.list")))
})

test_that("dash_nav_help_button() respects custom label", {
  btn <- dash_nav_help_button("help", label = "Support")
  expect_match(as.character(btn), "Support", fixed = TRUE)
})

test_that("complete navbar item helpers return valid li dropdown children", {
  help <- dash_nav_help_item("help")
  refresh <- dash_nav_refresh_item("refresh")
  status <- dash_nav_status_item("Live", icon = "circle-check")

  for (item in list(help, refresh, status)) {
    html <- as.character(item)
    expect_match(html, "<li", fixed = TRUE)
    expect_match(html, "nav-item", fixed = TRUE)
    expect_match(html, "dropdown", fixed = TRUE)
  }

  expect_no_error(validate_bs4dash_navbar(shiny::tagList(help, refresh, status)))
})

test_that("dash_nav_item() wraps content in a nav-item li", {
  item <- dash_nav_item(shiny::tags$span("inner"))
  html <- as.character(item)
  expect_match(html, "nav-item", fixed = TRUE)
  expect_match(html, "<li", fixed = TRUE)
})

test_that("validate_bs4dash_navbar() reports common custom item mistakes", {
  expect_error(
    validate_bs4dash_navbar(shiny::tagList(
      dash_nav_item(shiny::tags$span("ok")),
      shiny::tags$li(class = "nav-item", "bad")
    )),
    'Navbar item 2 is an <li> but is missing class "dropdown"',
    fixed = TRUE
  )

  expect_error(
    validate_bs4dash_navbar(shiny::tagList(
      shiny::tags$button("bad")
    )),
    "Wrap it with dash_nav_item()",
    fixed = TRUE
  )
})

test_that("dash_nav_status_badge() supports status classes and icons", {
  badge <- dash_nav_status_badge("Live", status = "success", icon = shiny::icon("circle-check"))
  html <- as.character(badge)

  expect_match(html, "badge-success", fixed = TRUE)
  expect_match(html, "fa-circle-check", fixed = TRUE)
  expect_error(dash_nav_status_badge("Live", status = "missing"))
})

test_that("dash_nav_title() returns a shiny tag/tagList", {
  result <- dash_nav_title("MY APP", "Subtitle here", icon = "shield-halved")
  expect_true(inherits(result, c("shiny.tag", "shiny.tag.list")))
})

test_that("dash_nav_title() includes title/subtitle text in HTML", {
  result <- dash_nav_title("UNIQUE TITLE XYZ", "UNIQUE SUB XYZ")
  html <- as.character(result)
  expect_match(html, "UNIQUE TITLE XYZ", fixed = TRUE)
  expect_match(html, "UNIQUE SUB XYZ", fixed = TRUE)
})

test_that("dash_nav_title() align argument accepts valid values", {
  expect_no_error(dash_nav_title("T", "S", align = "center"))
  expect_no_error(dash_nav_title("T", "S", align = "left"))
  expect_no_error(dash_nav_title("T", "S", align = "right"))
  expect_error(dash_nav_title("T", "S", align = "bad"))
})

test_that("dash_nav_title() works without icon argument", {
  expect_no_error(dash_nav_title("My App", "Subtitle"))
})

test_that("dash_user_menu() returns a nav <li>", {
  result <- dash_user_menu(bs4Dash::dropdownMenu(type = "notifications"))
  html <- as.character(result)
  expect_match(html, "<li", fixed = TRUE)
  expect_match(html, "dash-user-menu", fixed = TRUE)
})

test_that("bs4dashkit_example_app() returns a shiny app object", {
  app <- bs4dashkit_example_app()
  expect_s3_class(app, "shiny.appobj")
})
