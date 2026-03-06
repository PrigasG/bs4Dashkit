#' Toggle the sidebar header divider (line under the brand area)
#'
#' @param show Logical. TRUE keeps divider (default). FALSE hides it.
#' @return If \code{show} is \code{TRUE}, an empty \code{shiny.tag.list}. If
#'   \code{show} is \code{FALSE}, a \code{shiny.tag} object containing CSS that
#'   hides the sidebar brand divider.
#' @export
use_dash_sidebar_brand_divider <- function(show = TRUE) {
  if (isTRUE(show)) return(shiny::tagList())

  shiny::tags$head(
    shiny::tags$style(shiny::HTML("
      /* Hide any top seam on the scroll container and nav area */
      aside.main-sidebar .sidebar,
      .main-sidebar .sidebar{
        border-top: 0 !important;
        box-shadow: none !important;
        background-image: none !important;
      }

      aside.main-sidebar .sidebar nav.mt-2,
      .main-sidebar .sidebar nav.mt-2{
        border-top: 0 !important;
        box-shadow: none !important;
        background-image: none !important;
      }

      /* If the brand strip itself draws a line, remove it */
      aside.main-sidebar .brand-link,
      .main-sidebar .brand-link{
        border-bottom: 0 !important;
        box-shadow: none !important;
        background-image: none !important;
      }

      /* IMPORTANT: do NOT change aside.main-sidebar shadow here,
         so the vertical separation stays intact */
    "))
  )
}
