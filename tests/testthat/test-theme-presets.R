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
