test_that("more_after must be a whole number or Inf", {
  expect_error(
    dash_topnav_options(more_after = 2.5),
    "`more_after` must be a single whole number (>= 1) or Inf.",
    fixed = TRUE
  )
  expect_error(
    dash_topnav_options(more_after = 0),
    "`more_after` must be a single whole number (>= 1) or Inf.",
    fixed = TRUE
  )
  expect_error(
    dash_topnav_options(more_after = -Inf),
    "`more_after` must be a single whole number (>= 1) or Inf.",
    fixed = TRUE
  )
  expect_error(
    dash_topnav_options(more_after = "3"),
    "`more_after` must be a single whole number (>= 1) or Inf.",
    fixed = TRUE
  )

  expect_s3_class(dash_topnav_options(more_after = 3), "bs4dashkit_topnav_options")
  expect_s3_class(dash_topnav_options(more_after = Inf), "bs4dashkit_topnav_options")
})

test_that("use_dash_topnav() rejects fractional more_after instead of truncating", {
  expect_error(
    use_dash_topnav(more_after = 2.5),
    "`more_after` must be a single whole number (>= 1) or Inf.",
    fixed = TRUE
  )
})

test_that("use_bs4Dashkit_core() rejects fractional topnav_more_after", {
  ttl <- dash_titles("Core Test", icon = shiny::icon("cloud"))
  expect_error(
    use_bs4Dashkit_core(ttl, layout = "topnav", topnav_more_after = 2.5),
    "`topnav_more_after` must be a single whole number (>= 1) or Inf.",
    fixed = TRUE
  )
})

test_that("non-finite CSS dimensions are rejected, not rendered as Infpx", {
  expect_error(
    use_dash_topnav(topbar_h = Inf),
    "`topbar_h` must be a positive number or a CSS length",
    fixed = TRUE
  )
  expect_error(
    use_dash_sidebar_behavior(collapsed_w = Inf),
    "`collapsed_w` must be a positive number or a CSS length",
    fixed = TRUE
  )
  expect_error(
    use_dash_theme(radius = Inf),
    "`radius` must be a single positive number (px).",
    fixed = TRUE
  )
})

test_that("use_dash_sidebar_brand_divider() validates show", {
  expect_error(
    use_dash_sidebar_brand_divider(show = NA),
    "`show` must be TRUE or FALSE.",
    fixed = TRUE
  )
  expect_error(
    use_dash_sidebar_brand_divider(show = "yes"),
    "`show` must be TRUE or FALSE.",
    fixed = TRUE
  )

  shown <- use_dash_sidebar_brand_divider(show = TRUE)
  expect_true(length(shown) == 0)

  hidden <- htmltools::renderTags(use_dash_sidebar_brand_divider(show = FALSE))$head
  expect_match(hidden, "border-bottom: 0", fixed = TRUE)
})

test_that("nav buttons accept shiny::icon() tags like other icon args", {
  help_btn <- dash_nav_help_button("help_btn", icon = shiny::icon("cloud"))
  help_html <- htmltools::renderTags(help_btn)$html
  expect_match(help_html, "fa-cloud", fixed = TRUE)

  refresh_btn <- dash_nav_refresh_button("refresh_btn", icon = shiny::icon("cloud"))
  refresh_html <- htmltools::renderTags(refresh_btn)$html
  expect_match(refresh_html, "fa-cloud", fixed = TRUE)

  expect_error(
    dash_nav_help_button("help_btn", icon = 123),
    "`icon` must be a single character icon name or NULL.",
    fixed = TRUE
  )
})

test_that("dash_footer() validates logo_src", {
  expect_error(
    dash_footer(logo_src = 123),
    "`logo_src` must be a single string (path or URL) or NULL.",
    fixed = TRUE
  )
  expect_s3_class(dash_footer(logo_src = NULL), "shiny.tag")
})
