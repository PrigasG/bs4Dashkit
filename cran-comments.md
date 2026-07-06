## Test environments

- Local: Windows 11, R 4.5.1
- GitHub Actions:
  - macOS-latest (R release)
  - windows-latest (R release)
  - ubuntu-latest (R devel)
  - ubuntu-latest (R release)
  - ubuntu-latest (R oldrel-1)

## R CMD check results

0 errors | 0 warnings | 1 note

The note was:

* checking for future file timestamps ... NOTE
  unable to verify current time

This appears to be a local system-clock verification issue in the check
environment. No future timestamps were reported.

## Release summary

This is a minor release focused on navbar ergonomics, reusable branding
configuration, and clearer sidebar sizing inputs.

Notable changes:

- Added complete navbar item helpers:
  `dash_nav_help_item()`, `dash_nav_refresh_item()`, and
  `dash_nav_status_item()`.
- Added `dash_nav_status_badge()` for compact navbar state indicators.
- Added `validate_bs4dash_navbar()` for targeted validation of custom
  `bs4DashNavbar(rightUi = ...)` children.
- Added `dash_brand_options()` and `dash_titles_from()` for reusable brand
  configuration.
- Allowed explicit CSS lengths for sidebar sizing arguments such as
  `collapsed_w = "4.25rem"` and `expanded_w = "270px"` while retaining
  backwards-compatible numeric inputs.
- Updated README, vignettes, examples, pkgdown reference navigation, and tests.

Thank you for your time and review.
