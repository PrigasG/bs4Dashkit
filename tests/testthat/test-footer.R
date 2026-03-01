test_that("dash_footer() returns a bs4Dash footer tag", {
  result <- dash_footer(left_text = "My Org", right_text = NULL, logo_src = NULL)
  expect_true(inherits(result, c("shiny.tag", "shiny.tag.list")))
})

test_that("dash_footer() works with all NULL content", {
  expect_no_error(dash_footer(logo_src = NULL, left_text = NULL, right_text = NULL))
})

test_that("dash_footer() works with logo_src = NULL", {
  expect_no_error(dash_footer(logo_src = NULL, left_text = "My Org", right_text = NULL))
})

test_that("dash_footer() works with a logo path", {
  expect_no_error(dash_footer(logo_src = "logo.png", left_text = "My Org", right_text = NULL))
})

test_that("dash_footer() accepts all logo_position values", {
  expect_no_error(dash_footer(logo_src = "logo.png", left_text = "My Org",
                              right_text = NULL, logo_position = "left"))
  expect_no_error(dash_footer(logo_src = "logo.png", left_text = "My Org",
                              right_text = NULL, logo_position = "right"))
})

test_that("left_text appears in rendered HTML when provided", {
  result <- dash_footer(logo_src = NULL, left_text = "Unique Org Name XYZ", right_text = NULL)
  expect_match(as.character(result), "Unique Org Name XYZ", fixed = TRUE)
})

test_that("right_text appears in rendered HTML when provided", {
  result <- dash_footer(logo_src = NULL, left_text = NULL, right_text = "Unique Right XYZ")
  expect_match(as.character(result), "Unique Right XYZ", fixed = TRUE)
})
