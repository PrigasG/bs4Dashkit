package_name <- "bs4Dashkit"
output_dir <- file.path("tools", "download-tracker", "data")

fetch_downloads <- function(package = package_name, from = Sys.Date() - 365) {
  query <- sprintf(
    "https://cranlogs.r-pkg.org/downloads/daily.csv?package=%s&from=%s",
    utils::URLencode(package, reserved = TRUE),
    format(as.Date(from), "%Y-%m-%d")
  )

  stats <- utils::read.csv(query, stringsAsFactors = FALSE)
  stats$date <- as.Date(stats$date)
  stats$count <- as.numeric(stats$count)
  stats
}

summarise_downloads <- function(stats) {
  latest_date <- max(stats$date, na.rm = TRUE)
  last_7_start <- latest_date - 6
  last_30_start <- latest_date - 29

  list(
    package = unique(stats$package)[1],
    latest_date = latest_date,
    latest_downloads = stats$count[stats$date == latest_date][1],
    total_downloads = sum(stats$count, na.rm = TRUE),
    downloads_7 = sum(stats$count[stats$date >= last_7_start], na.rm = TRUE),
    downloads_30 = sum(stats$count[stats$date >= last_30_start], na.rm = TRUE),
    peak_date = stats$date[which.max(stats$count)],
    peak_downloads = max(stats$count, na.rm = TRUE)
  )
}

write_summary_md <- function(summary, path) {
  lines <- c(
    sprintf("# %s CRAN Downloads", summary$package),
    "",
    sprintf("Updated: %s UTC", format(Sys.time(), tz = "UTC", usetz = TRUE)),
    "",
    sprintf("- Latest day: %s (%s downloads)", summary$latest_date, summary$latest_downloads),
    sprintf("- Last 7 days: %s downloads", summary$downloads_7),
    sprintf("- Last 30 days: %s downloads", summary$downloads_30),
    sprintf("- Total in tracked period: %s downloads", summary$total_downloads),
    sprintf("- Peak day: %s (%s downloads)", summary$peak_date, summary$peak_downloads)
  )
  writeLines(lines, path, useBytes = TRUE)
}

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

downloads <- fetch_downloads()
summary <- summarise_downloads(downloads)

utils::write.csv(
  downloads,
  file = file.path(output_dir, "downloads-daily.csv"),
  row.names = FALSE
)

write_summary_md(summary, file.path(output_dir, "download-summary.md"))

cat("Updated download tracker data for", summary$package, "\n")
