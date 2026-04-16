## Test environments

- Local: Windows (R release)
- GitHub Actions:
  - macOS-latest (R release)
  - windows-latest (R release)
  - ubuntu-latest (R devel)
  - ubuntu-latest (R release)
  - ubuntu-latest (R oldrel-1)

## R CMD check results

0 errors | 0 warnings | 0 notes

## Resubmission

This is a resubmission. In response to the previous CRAN review:

* improved API ergonomics in `dash_titles()` by accepting simple
  `shiny::icon()` inputs and adding more targeted validation errors for
  unsupported icon objects
* added collapsed and expanded sidebar brand text controls for size and
  weight
* added `bs4dashkit_theme_presets()` to make preset discovery explicit
  and improved preset validation messages
* added `bs4dashkit_example_app()` as a minimal runnable example of the
  recommended setup
* updated README and vignette content so the documentation now matches
  the shipped API and current preset names
* expanded test coverage for the new behaviors and reran checks

Thank you for your time and review
