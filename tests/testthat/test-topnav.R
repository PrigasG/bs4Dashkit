test_that("use_dash_topnav() emits dependency, variables, and init options", {
  rendered <- htmltools::renderTags(use_dash_topnav(
    topbar_h = "4rem",
    align = "right",
    gap = "0.5rem",
    style = "pill",
    mobile = "collapse",
    overflow = "more",
    more_after = 3,
    title = "compact",
    page_title = "tab",
    brand = FALSE,
    debug = TRUE
  ))
  html <- paste(rendered$head, rendered$html, sep = "\n")
  deps <- vapply(rendered$dependencies, `[[`, character(1), "name")

  expect_true("bs4dashkit-topnav" %in% deps)
  expect_equal(rendered$dependencies[[1]]$stylesheet, "dash-topnav.css")
  expect_equal(rendered$dependencies[[1]]$script, "dash-topnav.js")
  expect_match(html, "--dash-topbar-h:4rem", fixed = TRUE)
  expect_match(html, "--dash-topnav-gap:0.5rem", fixed = TRUE)
  expect_match(html, "\"right\"", fixed = TRUE)
  expect_match(html, 'style:"pill"', fixed = TRUE)
  expect_match(html, 'mobile:"collapse"', fixed = TRUE)
  expect_match(html, 'overflow:"more"', fixed = TRUE)
  expect_match(html, "moreAfter:3", fixed = TRUE)
  expect_match(html, 'title:"compact"', fixed = TRUE)
  expect_match(html, 'pageTitle:"tab"', fixed = TRUE)
  expect_match(html, "brand:false", fixed = TRUE)
  expect_match(html, "debug:true", fixed = TRUE)
})

test_that("dash_topnav_options() normalizes and validates options", {
  opts <- dash_topnav_options(
    align = "center",
    gap = 6,
    style = "compact",
    mobile = "scroll",
    overflow = "more",
    more_after = 4,
    title = "auto",
    page_title = "tab",
    brand = FALSE,
    debug = TRUE
  )

  expect_s3_class(opts, "bs4dashkit_topnav_options")
  expect_equal(opts$align, "center")
  expect_equal(opts$gap, "6px")
  expect_equal(opts$style, "compact")
  expect_equal(opts$mobile, "scroll")
  expect_equal(opts$overflow, "more")
  expect_equal(opts$more_after, 4)
  expect_equal(opts$title, "auto")
  expect_equal(opts$page_title, "tab")
  expect_false(opts$brand)
  expect_true(opts$debug)

  expect_error(dash_topnav_options(align = "bad"), "`align` must be")
  expect_error(dash_topnav_options(gap = "wide"), "gap")
  expect_error(dash_topnav_options(more_after = 0), "`more_after`")
})

test_that("dash_topnav_options() warns when scroll mode forces a visible title", {
  expect_warning(
    dash_topnav_options(mobile = "scroll", title = "show"),
    "may crowd the tab row"
  )
  expect_silent(dash_topnav_options(mobile = "scroll", title = "auto"))
})

test_that("use_dash_topnav() validates scalar options", {
  expect_error(use_dash_topnav(align = "bad"), "`align` must be")
  expect_error(use_dash_topnav(brand = c(TRUE, FALSE)), "`brand` must be TRUE or FALSE", fixed = TRUE)
  expect_error(use_dash_topnav(debug = NA), "`debug` must be TRUE or FALSE", fixed = TRUE)
  expect_error(use_dash_topnav(topbar_h = "56"), "CSS length")
  expect_error(use_dash_topnav(gap = "wide"), "gap")
  expect_error(use_dash_topnav(style = "card"), "`style`")
  expect_error(use_dash_topnav(mobile = "drawer"), "`mobile`")
  expect_error(use_dash_topnav(overflow = "wrap"), "`overflow`")
  expect_error(use_dash_topnav(title = "float"), "`title`")
  expect_error(use_dash_topnav(page_title = "crumb"), "`page_title`")
  expect_error(use_dash_topnav(more_after = 0), "`more_after`")
})
