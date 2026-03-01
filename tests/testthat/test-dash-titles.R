test_that("dash_titles() returns expected slots", {
  ttl <- dash_titles("My App")
  expect_type(ttl, "list")
  expect_named(ttl, c("app_name", "brand", "deps"))
})

test_that("app_name defaults to brand_text when not supplied", {
  ttl <- dash_titles("My App")
  expect_equal(ttl$app_name, "My App")
})

test_that("app_name uses explicit value when supplied", {
  ttl <- dash_titles("My App", app_name = "Custom Title")
  expect_equal(ttl$app_name, "Custom Title")
})

test_that("brand slot is a shiny tag or tagList", {
  ttl <- dash_titles("My App", icon = "chart-line")
  expect_true(inherits(ttl$brand, c("shiny.tag", "shiny.tag.list")))
})

test_that("deps slot is a shiny tag or tagList", {
  ttl <- dash_titles("My App")
  expect_true(inherits(ttl$deps, c("shiny.tag", "shiny.tag.list")))
})

test_that("effect argument is validated", {
  expect_no_error(dash_titles("My App", effect = "none"))
  expect_no_error(dash_titles("My App", effect = "glow",    glow_color = "#333333"))
  expect_no_error(dash_titles("My App", effect = "shimmer", glow_color = "#333333"))
  expect_no_error(dash_titles("My App", effect = "emboss"))
  expect_error(dash_titles("My App", effect = "invalid_effect"))
})

test_that("gradient overrides effect argument without error", {
  expect_no_error(
    dash_titles("My App", gradient = c("#2f6f8f", "#5ba3c9"), effect = "glow")
  )
})

test_that("collapsed and expanded modes are validated", {
  expect_no_error(dash_titles("My App", collapsed = "icon-only"))
  expect_no_error(dash_titles("My App", collapsed = "icon-text"))
  expect_no_error(dash_titles("My App", collapsed = "text-only"))

  expect_no_error(dash_titles("My App", expanded  = "icon-only"))
  expect_no_error(dash_titles("My App", expanded  = "icon-text"))
  expect_no_error(dash_titles("My App", expanded  = "text-only"))

  expect_error(dash_titles("My App", collapsed = "bad-mode"))
  expect_error(dash_titles("My App", expanded  = "bad-mode"))
})

test_that("icon_shape is validated when icon_img is used", {
  expect_no_error(dash_titles("My App", icon_img = "logo.png", icon_shape = "circle"))
  expect_no_error(dash_titles("My App", icon_img = "logo.png", icon_shape = "rounded"))
  expect_no_error(dash_titles("My App", icon_img = "logo.png", icon_shape = "square"))
  expect_error(dash_titles("My App", icon_img = "logo.png", icon_shape = "hexagon"))
})
