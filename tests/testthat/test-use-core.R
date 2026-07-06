test_that("use_bs4Dashkit_core() requires dash_titles output", {
  expect_error(
    use_bs4Dashkit_core(list()),
    "`ttl` must be the result of dash_titles()",
    fixed = TRUE
  )
})

test_that("use_bs4Dashkit_core() loads sidebar behavior by default", {
  ttl <- dash_titles("Core Test", icon = shiny::icon("cloud"))
  rendered <- htmltools::renderTags(use_bs4Dashkit_core(ttl))
  html <- rendered$head
  deps <- vapply(rendered$dependencies, `[[`, character(1), "name")

  expect_true("bs4dashkit-sidebar" %in% deps)
  expect_match(html, "--dash-sidebar-collapsed-w:4.2rem", fixed = TRUE)
  expect_match(html, "--dash-sidebar-expanded-w:250px", fixed = TRUE)
})

test_that("use_bs4Dashkit_core() can prototype top-nav layout", {
  ttl <- dash_titles("Topnav Test", icon = shiny::icon("cloud"))
  rendered <- htmltools::renderTags(use_bs4Dashkit_core(
    ttl,
    layout = "topnav",
    topnav_align = "right",
    topnav_gap = 6,
    topnav_style = "compact",
    topnav_mobile = "collapse",
    topnav_overflow = "more",
    topnav_more_after = 2,
    topnav_title = "auto",
    topnav_page_title = "tab",
    topnav_brand = FALSE,
    topbar_h = "3.5rem"
  ))

  html <- paste(rendered$head, rendered$html, sep = "\n")
  deps <- vapply(rendered$dependencies, `[[`, character(1), "name")

  expect_true("bs4dashkit-topnav" %in% deps)
  expect_match(html, "--dash-topbar-h:3.5rem", fixed = TRUE)
  expect_match(html, "--dash-topnav-gap:6px", fixed = TRUE)
  expect_match(html, "\"right\"", fixed = TRUE)
  expect_match(html, 'style:"compact"', fixed = TRUE)
  expect_match(html, 'mobile:"collapse"', fixed = TRUE)
  expect_match(html, 'overflow:"more"', fixed = TRUE)
  expect_match(html, "moreAfter:2", fixed = TRUE)
  expect_match(html, 'title:"auto"', fixed = TRUE)
  expect_match(html, 'pageTitle:"tab"', fixed = TRUE)
  expect_match(html, "brand:false", fixed = TRUE)
  expect_false(grepl("--dash-sidebar-expanded-w", html, fixed = TRUE))
})

test_that("use_bs4Dashkit_core() accepts dash_topnav_options()", {
  ttl <- dash_titles("Topnav Test", icon = shiny::icon("cloud"))
  rendered <- htmltools::renderTags(use_bs4Dashkit_core(
    ttl,
    layout = "topnav",
    topnav = dash_topnav_options(
      align = "left",
      gap = 8,
      style = "compact",
      mobile = "scroll",
      overflow = "more",
      more_after = 4,
      title = "auto",
      page_title = "tab",
      brand = FALSE
    ),
    topbar_h = 58
  ))

  html <- paste(rendered$head, rendered$html, sep = "\n")

  expect_match(html, "--dash-topbar-h:58px", fixed = TRUE)
  expect_match(html, "--dash-topnav-gap:8px", fixed = TRUE)
  expect_match(html, 'mobile:"scroll"', fixed = TRUE)
  expect_match(html, 'overflow:"more"', fixed = TRUE)
  expect_match(html, "moreAfter:4", fixed = TRUE)
  expect_match(html, 'pageTitle:"tab"', fixed = TRUE)
  expect_match(html, "brand:false", fixed = TRUE)
})

test_that("use_bs4Dashkit_core() validates layout and top-nav options", {
  ttl <- dash_titles("Core Test", icon = shiny::icon("cloud"))

  expect_error(use_bs4Dashkit_core(ttl, layout = "bad"), "`layout` must be")
  expect_error(use_bs4Dashkit_core(ttl, topnav_align = "bad"), "`topnav_align` must be")
  expect_error(use_bs4Dashkit_core(ttl, topnav_gap = "wide"), "topnav_gap")
  expect_error(use_bs4Dashkit_core(ttl, topnav_style = "card"), "`topnav_style`")
  expect_error(use_bs4Dashkit_core(ttl, topnav_mobile = "drawer"), "`topnav_mobile`")
  expect_error(use_bs4Dashkit_core(ttl, topnav_overflow = "wrap"), "`topnav_overflow`")
  expect_error(use_bs4Dashkit_core(ttl, topnav_title = "float"), "`topnav_title`")
  expect_error(use_bs4Dashkit_core(ttl, topnav_page_title = "crumb"), "`topnav_page_title`")
  expect_error(use_bs4Dashkit_core(ttl, topnav_more_after = 0), "`topnav_more_after`")
  expect_error(use_bs4Dashkit_core(ttl, topnav_brand = NA), "`topnav_brand` must be TRUE or FALSE", fixed = TRUE)
  expect_error(use_bs4Dashkit_core(ttl, topnav_debug = NA), "`topnav_debug` must be TRUE or FALSE", fixed = TRUE)
})

test_that("dashkit_validate_css_dimension() accepts positive CSS functions", {
  expect_equal(
    dashkit_validate_css_dimension("clamp(48px, 5vw, 64px)", "topbar_h", "px"),
    "clamp(48px, 5vw, 64px)"
  )
})

test_that("dashkit_validate_css_dimension() rejects invalid dimensions", {
  expect_error(dashkit_validate_css_dimension(0, "size", "px"), "positive")
  expect_error(dashkit_validate_css_dimension("0px", "size", "px"), "positive CSS length")
  expect_error(dashkit_validate_css_dimension("56", "size", "px"), "CSS length")
  expect_error(dashkit_validate_css_dimension("bad()", "size", "px"), "CSS length")
})
