# bs4Dashkit Roadmap

This roadmap keeps the next feature wave focused on small, reusable
dashboard helpers rather than turning the package into a grab bag.

## Next Release Candidates

### 1. Navbar status badge

Goal:
- Add a small helper for environment and status labels in the navbar.

Why:
- Dashboard apps often need a visible `"DEV"`, `"TEST"`, `"UAT"`, or
  `"PROD"` marker.
- This fits the existing navbar helper family cleanly.

Proposed API:
- `dash_nav_status_badge(label, status = c("info", "success", "warn", "danger"))`
- optional color override for organization-specific environments

### 2. Theme preview helper

Goal:
- Let users preview built-in presets visually instead of relying on names
  alone.

Why:
- `bs4dashkit_theme_presets()` improves discoverability, but a visual
  preview makes selection much easier.

Proposed shape:
- `bs4dashkit_preview_themes()` for a simple Shiny preview
- or a pkgdown article with live examples if that proves lighter-weight

### 3. Brand config helper

Goal:
- Reduce the argument sprawl in `dash_titles()` for apps that reuse the
  same brand settings repeatedly.

Why:
- Teams often want one central brand definition reused across several
  dashboards.

Possible direction:
- `dash_brand_options(...)`
- `dash_titles_from(brand_opts, ...)`

### 4. Reusable content helpers

Goal:
- Add a very small set of high-frequency layout helpers.

Good candidates:
- `dash_empty_state()`
- `dash_section_header()`
- `dash_info_strip()`

Rule:
- Only add helpers that eliminate repeated bs4Dash boilerplate across
  multiple apps.

## Guardrails

- Prefer declarative helpers over one-off style tweaks.
- Keep public functions small and composable.
- Avoid adding package dependencies unless the gain is clear.
- Put maintainer tooling in repo-level `tools/` rather than exporting it.

## Maintainer Tooling

- `tools/download-tracker/` provides a lightweight Shiny app for viewing
  CRAN download status for `bs4Dashkit`.
