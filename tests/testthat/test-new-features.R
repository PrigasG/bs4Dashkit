test_that("dash_nav_divider() renders a valid navbar child", {
  d <- dash_nav_divider()
  expect_s3_class(d, "shiny.tag")
  expect_equal(d$name, "li")
  expect_true("dropdown" %in% strsplit(d$attribs$class, "\\s+")[[1]])

  html <- htmltools::renderTags(d)$html
  expect_match(html, "dash-nav-divider", fixed = TRUE)

  expect_true(
    validate_bs4dash_navbar(
      shiny::tagList(
        dash_nav_item(shiny::span("x")),
        d
      )
    )
  )
})

test_that("dash_back_to_top() validates its inputs", {
  expect_error(
    dash_back_to_top(show_after = -1),
    "`show_after` must be a single non-negative number (pixels).",
    fixed = TRUE
  )
  expect_error(
    dash_back_to_top(show_after = Inf),
    "`show_after` must be a single non-negative number (pixels).",
    fixed = TRUE
  )
  expect_error(
    dash_back_to_top(label = 123),
    "`label` must be a single string or NULL.",
    fixed = TRUE
  )
  expect_error(
    dash_back_to_top(offset = "abc"),
    "`offset` must be a positive number or a CSS length",
    fixed = TRUE
  )
})

test_that("dash_back_to_top() renders the button with its dependency", {
  btt <- dash_back_to_top()
  html <- htmltools::renderTags(btt)$html
  expect_match(html, "dash-back-to-top", fixed = TRUE)
  expect_match(html, 'data-show-after="400"', fixed = TRUE)
  expect_match(html, "bottom: 24px; right: 24px;", fixed = TRUE)

  left <- htmltools::renderTags(dash_back_to_top(position = "bottom-left"))$html
  expect_match(left, "bottom: 24px; left: 24px;", fixed = TRUE)

  labeled <- htmltools::renderTags(dash_back_to_top(label = "Top"))$html
  expect_match(labeled, "dash-back-to-top-labeled", fixed = TRUE)

  icon_tag <- htmltools::renderTags(dash_back_to_top(icon = shiny::icon("cloud")))$html
  expect_match(icon_tag, "fa-cloud", fixed = TRUE)

  deps <- htmltools::findDependencies(btt)
  dep_names <- vapply(deps, function(d) d$name, character(1))
  expect_true("bs4dashkit-back-to-top" %in% dep_names)
})

test_that("bs4dashkit_example_app() supports the topnav layout", {
  expect_error(
    bs4dashkit_example_app(layout = "bogus"),
    "should be one of"
  )

  sidebar_app <- bs4dashkit_example_app()
  expect_s3_class(sidebar_app, "shiny.appobj")

  topnav_app <- bs4dashkit_example_app(layout = "topnav")
  expect_s3_class(topnav_app, "shiny.appobj")
})
