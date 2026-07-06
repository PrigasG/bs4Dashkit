test_that("bs4dashkit_theme_presets() lists available presets", {
  presets <- bs4dashkit_theme_presets()

  expect_s3_class(presets, "data.frame")
  expect_named(presets, c("preset", "description"))
  expect_equal(
    presets$preset,
    c("professional", "modern", "dark-lite")
  )
})

test_that("bs4dashkit_theme_presets(values = TRUE) exposes tokens", {
  presets <- bs4dashkit_theme_presets(values = TRUE)

  expect_named(presets, c("preset", "description", "tokens"))
  expect_type(presets$tokens, "list")
  expect_true(all(vapply(presets$tokens, is.list, logical(1))))
  expect_true(all(vapply(presets$tokens, function(x) "navbar_bg" %in% names(x), logical(1))))
})

test_that("use_dash_theme_preset() errors list available presets", {
  expect_error(
    use_dash_theme_preset("unknown"),
    'Available presets: "professional", "modern", "dark-lite"'
  )
})

test_that("use_dash_theme() emits expanded theme variables", {
  html <- htmltools::renderTags(use_dash_theme())$head

  expect_match(html, "--dash-navbar-bg", fixed = TRUE)
  expect_match(html, "--dash-sidebar-bg", fixed = TRUE)
  expect_match(html, "--dash-footer-bg", fixed = TRUE)
  expect_match(html, "--dash-accent-soft", fixed = TRUE)
  expect_match(html, "--dash-success", fixed = TRUE)
})

test_that("use_dash_theme() validates CSS variable values", {
  expect_error(use_dash_theme(accent = "#fff;display:none"), "accent")
  expect_error(use_dash_theme(shadow = "</style>"), "shadow")
  expect_error(use_dash_theme(radius = -1), "radius")
})

test_that("use_dash_sidebar_behavior() validates dimensions directly", {
  expect_error(use_dash_sidebar_behavior(collapsed_w = -1), "collapsed_w")
  expect_error(use_dash_sidebar_behavior(expanded_w = NA), "expanded_w")
  expect_error(use_dash_sidebar_behavior(topbar_h = c(56, 60)), "topbar_h")
})

test_that("use_dash_sidebar_behavior() accepts explicit CSS units", {
  html <- htmltools::renderTags(use_dash_sidebar_behavior(
    topbar_h = "3.5rem",
    collapsed_w = "4.25rem",
    expanded_w = "270px"
  ))$head

  expect_match(html, "--dash-topbar-h:3.5rem", fixed = TRUE)
  expect_match(html, "--dash-sidebar-collapsed-w:4.25rem", fixed = TRUE)
  expect_match(html, "--dash-sidebar-expanded-w:270px", fixed = TRUE)
  expect_error(use_dash_sidebar_behavior(collapsed_w = "4.25"), "CSS length")
  expect_error(use_dash_sidebar_behavior(collapsed_w = "0px"), "positive CSS length")
})

test_that("demo app helper returns a shiny app object", {
  app <- bs4dashkit_demo_app()

  expect_s3_class(app, "shiny.appobj")
})
