#' Internal helper: get bs4Dashkit option with fallback
#' @keywords internal
dashkit_opt <- function(name, default = NULL) {
  getOption(paste0("bs4Dashkit.", name), default = default)
}
