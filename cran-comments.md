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
* fixed reactive sidebar mode updates by clearing stale mode classes and
  cleaning up old hover/listener state before applying new settings
* allowed `brand_text = NULL` for fully icon-only brands when both
  sidebar states are `"icon-only"` and an icon or image brand is
  supplied
* improved navbar title centering under resize/layout changes and added
  alignment controls to the interactive demo
* added `bs4dashkit_theme_presets()` to make preset discovery explicit
  and improved preset validation messages
* added `bs4dashkit_example_app()` as a minimal runnable example of the
  recommended setup
* added packaged smoke-test and full-feature example apps for manual
  verification
* updated README and vignette content so the documentation now matches
  the shipped API and current preset names
* expanded test coverage for the new behaviors and reran checks

## Versioning note

These changes remain part of the in-development 0.2.0 work. We did not
create an additional release tag because the previous development tag
has not been submitted to CRAN yet.

Thank you for your time and review
