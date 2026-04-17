#' Create sidebar / navbar brand UI
#'
#' Produces an icon + text block for bs4Dash brand slots with rich styling
#' and optional visual effects. Supports Font Awesome icons or image logos.
#'
#' @param brand_text   Visible brand label (character). May be \code{NULL} for
#'   icon-only brands.
#' @param icon         Font Awesome icon name e.g. "shield-halved", or a simple
#'   \code{icon("shield-halved")} tag. NULL for none.
#' @param icon_img     URL or www-relative path to an image logo. Overrides `icon`
#'   when both are supplied.
#' @param icon_shape   Shape mask for image icons: "circle", "rounded", "square".
#'   Ignored for FA icons. Default "circle".
#' @param icon_size    Size of icon/image as CSS string e.g. "20px", "1.3em".
#'   NULL = inherits sidebar default.
#' @param icon_color   CSS color for FA icon e.g. "#2f6f8f". NULL = inherit.
#'   For image icons, applies a CSS tint via mix-blend-mode (subtle).
#' @param weight       CSS font-weight: numeric or keyword. Default 700.
#' @param spacing      CSS letter-spacing. Default "-0.02em".
#' @param size         CSS font-size for label e.g. "13px". NULL = inherit.
#' @param italic       Logical. Italicise the label. Default FALSE.
#' @param font_family  CSS font-family string e.g. "'Inter', sans-serif".
#' @param color        Solid CSS color for label text. NULL = inherit.
#'   Ignored when `gradient` is set.
#' @param gradient     Character vector of 2 hex colors for gradient text effect
#'   e.g. c("#2f6f8f", "#5ba3c9"). Automatically enables effect = "gradient".
#' @param effect       Visual effect on label: "none", "glow", "shimmer", "emboss".
#'   "gradient" is set automatically when `gradient` is supplied.
#' @param glow_color   CSS color for glow effect. Defaults to first gradient color
#'   or `color` or the package accent blue.
#'
#' @return A named list with components:
#' \describe{
#'   \item{ui}{A \code{shiny.tag.list} containing the generated brand UI.}
#'   \item{dep}{A \code{shiny.tag} object containing scoped CSS dependencies for the brand styling.}
#' }
#' @export
dash_brand_ui <- function(
    brand_text,
    icon        = NULL,
    icon_img    = NULL,
    icon_shape  = c("circle", "rounded", "square"),
    icon_size   = NULL,
    icon_color  = NULL,
    weight      = 700,
    spacing     = "-0.02em",
    size        = NULL,
    italic      = FALSE,
    font_family = NULL,
    color       = NULL,
    gradient    = NULL,
    effect      = c("none", "glow", "shimmer", "emboss"),
    glow_color  = NULL
) {
  icon <- dashkit_normalize_icon(icon)
  icon_shape <- match.arg(icon_shape)
  effect     <- if (!is.null(gradient)) "gradient" else match.arg(effect)

  # ── validation ---------------------------------------
  if (!is.null(gradient) && length(gradient) != 2) {
    stop("`gradient` must be a character vector of exactly 2 CSS color strings.")
  }

  # ── resolve glow color --------------------------------
  glow_col <- glow_color %||%
    if (!is.null(gradient)) gradient[[1]] else
      if (!is.null(color))    color         else
        "#2f6f8f"

  # ── unique id for scoped styles -------------------------------
  uid <- paste0("dbl-", substr(digest::digest(
    paste(brand_text, weight, size, effect, paste(gradient, collapse=""))
  ), 1, 7))

  # ── build label inline style (base) -------------------------
  base_style_parts <- c(
    sprintf("font-weight:%s", weight),
    sprintf("letter-spacing:%s", spacing),
    if (!is.null(size))        sprintf("font-size:%s",   size),
    if (isTRUE(italic))        "font-style:italic",
    if (!is.null(font_family)) sprintf("font-family:%s", font_family),
    if (!is.null(color) && effect != "gradient") sprintf("color:%s", color)
  )

  # ── build scoped CSS block ---------------------------
  scoped_css <- local({

    sel <- sprintf(".dash-brand-label.%s", uid)

    # base overrides (needed because AdminLTE has !important on brand font styles)
    base_overrides <- sprintf(
      "%s { font-weight:%s !important; %s%s%s%s }",
      sel,
      weight,
      if (!is.null(size))   sprintf("font-size:%s !important; ", size)        else "",
      if (isTRUE(italic))   "font-style:italic !important; "                  else "",
      if (!is.null(font_family)) sprintf("font-family:%s !important; ", font_family) else "",
      if (!is.null(color) && effect != "gradient") sprintf("color:%s !important; ", color) else ""
    )

    effect_css <- switch(effect,

                         gradient = sprintf("
        %s {
          background: linear-gradient(90deg, %s, %s);
          -webkit-background-clip: text;
          -webkit-text-fill-color: transparent;
          background-clip: text;
          text-fill-color: transparent;
        }",
                                            sel, gradient[[1]], gradient[[2]]
                         ),

                         glow = sprintf("
        %s {
          color: %s !important;
          text-shadow:
            0 0 8px %s99,
            0 0 16px %s55,
            0 0 2px  %scc;
        }",
                                        sel, glow_col, glow_col, glow_col, glow_col
                         ),

                         emboss = sprintf("
        %s {
          text-shadow:
            0 1px 0 rgba(255,255,255,0.4),
            0 -1px 0 rgba(0,0,0,0.25);
        }",
                                          sel
                         ),

                         shimmer = sprintf("
        @keyframes dash-shimmer-%s {
          0%%   { background-position: -200%% center; }
          100%% { background-position:  200%% center; }
        }
        %s {
          background: linear-gradient(
            90deg,
            %s 0%%,
            %s 40%%,
            #ffffff 50%%,
            %s 60%%,
            %s 100%%
          );
          background-size: 200%% auto;
          -webkit-background-clip: text;
          -webkit-text-fill-color: transparent;
          background-clip: text;
          animation: dash-shimmer-%s 3.5s linear infinite;
        }",
                                           uid, sel,
                                           glow_col, glow_col, glow_col, glow_col,
                                           uid
                         ),

                         # "none"
                         ""
    )

    paste(base_overrides, effect_css)
  })

  # ── icon element ----------------------------
  icon_el <- if (!is.null(icon_img)) {

    img_shape_css <- switch(icon_shape,
                            circle  = "border-radius:50%;",
                            rounded = "border-radius:6px;",
                            square  = "border-radius:2px;"
    )
    img_size_css <- if (!is.null(icon_size)) {
      sprintf("width:%s; height:%s; object-fit:cover;", icon_size, icon_size)
    } else {
      "width:1.4em; height:1.4em; object-fit:cover;"
    }
    tint_css <- if (!is.null(icon_color)) {
      # subtle tint via sepia + hue-rotate approximation
      "filter:saturate(1.2) brightness(0.95);"
    } else ""

    shiny::tags$img(
      src   = icon_img,
      class = "dash-brand-icon dash-brand-img",
      style = paste(img_shape_css, img_size_css, tint_css,
                    "vertical-align:middle; flex-shrink:0;")
    )

  } else if (!is.null(icon)) {

    icon_style <- if (!is.null(icon_size) || !is.null(icon_color)) {
      paste0(
        if (!is.null(icon_size))  sprintf("font-size:%s;", icon_size)  else "",
        if (!is.null(icon_color)) sprintf("color:%s !important;", icon_color) else ""
      )
    } else NULL

    shiny::icon(
      icon,
      class = "fa-fw dash-brand-icon",
      style = icon_style
    )

  } else NULL

  # ── assemble ---------------------------------
  dep <- shiny::tags$head(
    shiny::tags$style(shiny::HTML(scoped_css))
  )

  label_el <- NULL
  if (!is.null(brand_text) && dashkit_is_scalar_character(brand_text) && nzchar(trimws(brand_text))) {
    label_el <- shiny::span(
      class = paste("dash-brand-label", uid),
      style = paste(base_style_parts, collapse = "; "),
      brand_text
    )
  }

  ui <- shiny::tagList(
    icon_el,
    label_el
  )

  list(ui = ui, dep = dep)

}


# Sidebar brand behavior -----------------------

#' Set sidebar brand display mode for expanded and collapsed states
#'
#' Controls icon visibility, text visibility, and text content in both
#' collapsed and expanded sidebar states.
#'
#' Modes:
#' - "icon-only"  : icon shown, label hidden  — requires `icon`
#' - "text-only"  : label shown, icon hidden  — `collapsed_text` / `expanded_text` optional
#' - "icon-text"  : both shown               — requires `icon`; text args optional
#'
#' @param icon           Font Awesome icon name used in the brand, e.g. "shield-halved",
#'   or a simple \code{icon("shield-halved")} tag. Required when any mode includes "icon".
#' @param collapsed      Display mode when sidebar is collapsed:
#'   "icon-only", "icon-text", or "text-only"
#' @param expanded       Display mode when sidebar is expanded:
#'   "icon-text", "icon-only", or "text-only"
#' @param collapsed_text Short label for collapsed "icon-text" or "text-only" mode.
#'   Keep <= 8 chars. NULL falls back to the current brand label already present in
#'   the DOM. When using \code{dash_titles()}, the higher-level helper usually
#'   resolves this to \code{brand_text} for visible text modes.
#' @param expanded_text  Label for expanded "icon-text" or "text-only" mode.
#'   Keep <= 30 chars. NULL falls back to the current brand label already present
#'   in the DOM. When using \code{dash_titles()}, the higher-level helper usually
#'   resolves this to \code{brand_text} for visible text modes.
#' @param collapsed_text_size Optional CSS font-size applied to the sidebar brand
#'   label while collapsed.
#' @param expanded_text_size Optional CSS font-size applied to the sidebar brand
#'   label while expanded.
#' @param collapsed_text_weight Optional CSS font-weight applied to the sidebar
#'   brand label while collapsed.
#' @param expanded_text_weight Optional CSS font-weight applied to the sidebar
#'   brand label while expanded.
#' @param debug Logical. If `TRUE`, prints helpful messages to the browser console
#'   for diagnosing missing icons or brand label elements.
#'
#' @return A \code{shiny.tag} or \code{shiny.tag.list} containing sidebar brand mode styling or dependencies.
#' @export
use_dash_sidebar_brand_mode <- function(
    icon           = NULL,
    collapsed      = c("icon-only", "icon-text", "text-only"),
    expanded       = c("icon-text",  "icon-only", "text-only"),
    collapsed_text = NULL,
    expanded_text  = NULL,
    collapsed_text_size = NULL,
    expanded_text_size  = NULL,
    collapsed_text_weight = NULL,
    expanded_text_weight  = NULL,
    debug          = FALSE
) {
  icon <- dashkit_normalize_icon(icon)
  collapsed <- match.arg(collapsed)
  expanded  <- match.arg(expanded)

  cls_c <- paste0("dash-sb-collapsed-", gsub("-", "_", collapsed))
  cls_e <- paste0("dash-sb-expanded-",  gsub("-", "_", expanded))

  short     <- if (!is.null(collapsed_text)) collapsed_text else ""
  long      <- if (!is.null(expanded_text))  expanded_text  else ""
  icon_name <- if (!is.null(icon)) icon else ""

  short_size   <- if (!is.null(collapsed_text_size)) as.character(collapsed_text_size) else ""
  long_size    <- if (!is.null(expanded_text_size)) as.character(expanded_text_size) else ""
  short_weight <- if (!is.null(collapsed_text_weight)) as.character(collapsed_text_weight) else ""
  long_weight  <- if (!is.null(expanded_text_weight)) as.character(expanded_text_weight) else ""

  icon_collapsed <- tolower(collapsed) %in% c("icon-only", "icon-text")
  icon_expanded  <- tolower(expanded)  %in% c("icon-only", "icon-text")
  text_collapsed <- tolower(collapsed) %in% c("icon-text", "text-only")
  text_expanded  <- tolower(expanded)  %in% c("icon-text", "text-only")

  main_js <- sprintf("
    (function(){
      if(window.__bs4DashkitSidebarBrandCleanup){
        window.__bs4DashkitSidebarBrandCleanup();
      }

      var ICON_NAME      = '%s';
      var SHORT          = '%s';
      var LONG           = '%s';
      var SHORT_SIZE     = '%s';
      var LONG_SIZE      = '%s';
      var SHORT_WEIGHT   = '%s';
      var LONG_WEIGHT    = '%s';
      var ICON_COLLAPSED = %s;
      var ICON_EXPANDED  = %s;
      var TEXT_COLLAPSED = %s;
      var TEXT_EXPANDED  = %s;
      var DEBUG          = %s;
      var _orig          = null;
      var _sidebar       = null;
      var _onEnter       = null;
      var _onLeave       = null;

      function getBrandLink(){
        return document.querySelector('aside.main-sidebar .brand-link, .main-sidebar .brand-link');
      }
      function getLabel(){
        return document.querySelector('aside.main-sidebar .brand-link .dash-brand-label, .main-sidebar .brand-link .dash-brand-label');
      }
      function getIcons(){
        return document.querySelectorAll('aside.main-sidebar .brand-link .dash-brand-icon, .main-sidebar .brand-link .dash-brand-icon');
      }
      function hasImageIcon(){
        return !!document.querySelector('aside.main-sidebar .brand-link .dash-brand-img, .main-sidebar .brand-link .dash-brand-img');
      }
      function getSidebar(){
        return document.querySelector('aside.main-sidebar, .main-sidebar');
      }

      function ensureIconIfNeeded(){
        if(hasImageIcon()) return;
        if(!ICON_NAME) return;

        var bt = getBrandLink();
        if(!bt) return;

        // If any icon already exists, don't inject another
        if(getIcons().length) return;

        var i = document.createElement('i');
        i.className = 'fa-solid fa-' + ICON_NAME + ' fa-fw dash-brand-icon';
        bt.insertBefore(i, bt.firstChild);
      }

      function setIconVisible(show){
        var els = getIcons();
        els.forEach(function(el){ el.style.display = show ? '' : 'none'; });
      }
      function setLabelVisible(show){
        var el = getLabel();
        if(el) el.style.display = show ? '' : 'none';
      }
      function setLabelText(text){
        var el = getLabel();
        if(!el) return;
        if(_orig === null) _orig = el.textContent;
        el.textContent = text !== '' ? text : _orig;
      }
      function setLabelStyle(size, weight){
        var el = getLabel();
        if(!el) return;
        if(size !== ''){
          el.style.setProperty('font-size', size, 'important');
        } else {
          el.style.removeProperty('font-size');
        }
        if(weight !== ''){
          el.style.setProperty('font-weight', weight, 'important');
        } else {
          el.style.removeProperty('font-weight');
        }
      }

      function applyCollapsed(){
        setIconVisible(ICON_COLLAPSED);
        setLabelStyle(SHORT_SIZE, SHORT_WEIGHT);
        if(TEXT_COLLAPSED){
          setLabelVisible(true);
          setLabelText(SHORT);
        } else {
          setLabelVisible(false);
        }
      }

      function applyExpanded(){
        setIconVisible(ICON_EXPANDED);
        setLabelStyle(LONG_SIZE, LONG_WEIGHT);
        if(TEXT_EXPANDED){
          setLabelVisible(true);
          setLabelText(LONG);
        } else {
          setLabelVisible(false);
        }
      }

      function isCollapsed(){
        return document.body.classList.contains('sidebar-collapse');
      }

      function syncState(){
        ensureIconIfNeeded();
        if(isCollapsed()){
          applyCollapsed();
        } else {
          applyExpanded();
        }
      }

      var observer = new MutationObserver(function(mutations){
        mutations.forEach(function(m){
          if(m.attributeName === 'class') syncState();
        });
      });

      function init(){
        if(DEBUG && (ICON_COLLAPSED || ICON_EXPANDED) && !ICON_NAME && !hasImageIcon()){
          console.warn('[bs4Dashkit] Sidebar brand mode requested an icon, but no `icon` was supplied and no .dash-brand-img exists. Provide `icon=` or `icon_img=`.');
        }

        syncState();

        observer.observe(document.body, { attributes:true, attributeFilter:['class'] });

        _sidebar = getSidebar();
        if(_sidebar){
          _onEnter = function(){ if(isCollapsed()) applyExpanded(); };
          _onLeave = function(){ if(isCollapsed()) applyCollapsed(); };
          _sidebar.addEventListener('mouseenter', _onEnter);
          _sidebar.addEventListener('mouseleave', _onLeave);
        }

        window.__bs4DashkitSidebarBrandCleanup = function(){
          observer.disconnect();
          if(_sidebar && _onEnter) _sidebar.removeEventListener('mouseenter', _onEnter);
          if(_sidebar && _onLeave) _sidebar.removeEventListener('mouseleave', _onLeave);
          window.__bs4DashkitSidebarBrandCleanup = null;
        };
      }

      if(document.readyState === 'loading'){
        document.addEventListener('DOMContentLoaded', init);
      } else {
        init();
      }
    })();
  ",
                     icon_name,
                     gsub("'", "\\\\'", short),
                     gsub("'", "\\\\'", long),
                     gsub("'", "\\\\'", short_size),
                     gsub("'", "\\\\'", long_size),
                     gsub("'", "\\\\'", short_weight),
                     gsub("'", "\\\\'", long_weight),
                     tolower(icon_collapsed),
                     tolower(icon_expanded),
                     tolower(text_collapsed),
                     tolower(text_expanded),
                     tolower(isTRUE(debug))
  )

  shiny::tagList(
    shiny::tags$script(shiny::HTML(sprintf("
      (function(){
        function applyMode(){
          document.body.className = document.body.className
            .replace(/\\bdash-sb-collapsed-[^\\s]+/g, '')
            .replace(/\\bdash-sb-expanded-[^\\s]+/g, '')
            .replace(/\\s{2,}/g, ' ')
            .trim();
          document.body.classList.add('%s','%s');
        }
        if(document.readyState === 'loading'){
          document.addEventListener('DOMContentLoaded', applyMode);
        } else {
          applyMode();
        }
      })();
    ", cls_c, cls_e))),
    shiny::tags$script(shiny::HTML(main_js))
  )
}
