test_that("hardening regression example constructs a shiny app", {
  app_file <- system.file("examples", "hardening-regression", "app.R", package = "bs4Dashkit")

  expect_true(file.exists(app_file))

  env <- new.env(parent = globalenv())
  sourced <- suppressWarnings(source(app_file, local = env))

  expect_s3_class(sourced$value, "shiny.appobj")
})

test_that("topnav prototype example constructs a shiny app", {
  app_file <- system.file("examples", "topnav-prototype", "app.R", package = "bs4Dashkit")

  expect_true(file.exists(app_file))

  env <- new.env(parent = globalenv())
  sourced <- suppressWarnings(source(app_file, local = env))

  expect_s3_class(sourced$value, "shiny.appobj")
})
