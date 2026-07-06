/* bs4Dashkit top-nav layout
 *
 * Mirrors the (hidden) bs4Dash sidebar menu as a horizontal navbar menu.
 * Clicks on the horizontal menu are delegated back to the original sidebar
 * links, so all bs4Dash server-side machinery (input$<sidebar id>,
 * updateTabItems(), bookmarking) keeps working untouched.
 */
(function () {
  'use strict';

  var MENU_CLASS = 'dash-topnav-menu';
  var BRAND_CLASS = 'dash-topnav-brand';
  var TOGGLE_CLASS = 'dash-topnav-mobile-toggle';
  var INDICATOR_CLASS = 'dash-topnav-indicator';

  var state = {
    opts: {
      align: 'left',
      style: 'underline',
      mobile: 'collapse',
      overflow: 'auto',
      moreAfter: null,
      title: 'auto',
      pageTitle: 'none',
      brand: true,
      debug: false
    },
    rebuildTimer: null,
    menuObserver: null,
    stateObserver: null,
    activeTimer: null
  };

  function log(msg) {
    if (state.opts.debug && window.console) {
      console.info('[bs4Dashkit topnav] ' + msg);
    }
  }

  function getNavbar() {
    return document.querySelector('.main-header.navbar, nav.main-header');
  }

  function getSidebarMenu() {
    return document.querySelector('aside.main-sidebar .nav-sidebar, .main-sidebar .nav-sidebar');
  }

  function getBrandLink() {
    return document.querySelector('aside.main-sidebar .brand-link, .main-sidebar .brand-link');
  }

  function stripIdsAndBindings(el) {
    if (el.removeAttribute) {
      el.removeAttribute('id');
      el.removeAttribute('data-widget');
    }
    var all = el.querySelectorAll ? el.querySelectorAll('[id]') : [];
    for (var i = 0; i < all.length; i++) all[i].removeAttribute('id');
    return el;
  }

  function removeClonedSidebarControls(targetLink, opts) {
    opts = opts || {};

    var controls = targetLink.querySelectorAll(
      '.fa-angle-left, .fa-angle-right, .fa-angle-double-right, .fa-angles-right, [data-widget="treeview"]'
    );
    for (var i = 0; i < controls.length; i++) {
      controls[i].parentNode.removeChild(controls[i]);
    }

    if (opts.removeIcons) {
      var icons = targetLink.querySelectorAll('.nav-icon, .fa-angle-left, .fa-angle-right, .fa-angle-double-right, .fa-angles-right');
      for (var j = 0; j < icons.length; j++) {
        icons[j].parentNode.removeChild(icons[j]);
      }
    }
  }

  function cloneLinkContent(sourceLink, targetLink, opts) {
    targetLink.innerHTML = '';
    for (var i = 0; i < sourceLink.childNodes.length; i++) {
      targetLink.appendChild(stripIdsAndBindings(sourceLink.childNodes[i].cloneNode(true)));
    }
    removeClonedSidebarControls(targetLink, opts);
  }

  function linkText(link) {
    return link ? link.textContent.replace(/\s+/g, ' ').trim() : '';
  }

  function linkTab(sourceLink) {
    if (!sourceLink) return '';
    return sourceLink.getAttribute('data-value') ||
      sourceLink.getAttribute('data-tabname') ||
      sourceLink.getAttribute('data-tab-name') ||
      sourceLink.getAttribute('href') ||
      linkText(sourceLink);
  }

  function sendTopnavInput(sourceLink) {
    if (!window.Shiny || !window.Shiny.setInputValue) return;
    window.Shiny.setInputValue('bs4dashkit_topnav', {
      tab: linkTab(sourceLink),
      text: linkText(sourceLink),
      nonce: Math.random()
    }, { priority: 'event' });
  }

  function makeDelegatedLink(sourceLink) {
    var a = document.createElement('a');
    a.className = 'nav-link' + (sourceLink.classList.contains('active') ? ' active' : '');
    a.href = '#';
    a.setAttribute('role', 'menuitem');
    a.setAttribute('tabindex', '0');
    a.setAttribute('data-dash-tab', linkTab(sourceLink));
    cloneLinkContent(sourceLink, a);
    a.addEventListener('click', function (e) {
      e.preventDefault();
      sendTopnavInput(sourceLink);
      sourceLink.click();
      document.body.classList.remove('dash-topnav-open');
    });
    return a;
  }

  function buildMoreMenu(ul) {
    var limit = state.opts.moreAfter;
    if (state.opts.overflow !== 'more' || !limit || !isFinite(limit)) return;

    var items = Array.prototype.slice.call(ul.children);
    if (items.length <= limit) return;

    var moreLi = document.createElement('li');
    moreLi.className = 'nav-item dropdown dash-topnav-more';

    var moreToggle = document.createElement('a');
    moreToggle.className = 'nav-link dropdown-toggle';
    moreToggle.href = '#';
    moreToggle.setAttribute('aria-haspopup', 'true');
    moreToggle.setAttribute('aria-expanded', 'false');
    moreToggle.textContent = 'More';
    moreLi.appendChild(moreToggle);

    var dd = document.createElement('div');
    dd.className = 'dropdown-menu ' + MENU_CLASS + '-dropdown';

    for (var i = limit; i < items.length; i++) {
      var link = items[i].querySelector(':scope > a.nav-link');
      if (!link) continue;
      var drop = document.createElement('a');
      drop.className = 'dropdown-item' + (link.classList.contains('active') ? ' active' : '');
      drop.href = '#';
      drop.innerHTML = link.innerHTML;
      drop.addEventListener('click', (function (originalLink) {
        return function (e) {
          e.preventDefault();
          originalLink.click();
          document.body.classList.remove('dash-topnav-open');
        };
      })(link));
      dd.appendChild(drop);
      items[i].parentNode.removeChild(items[i]);
    }

    moreLi.appendChild(dd);
    ul.appendChild(moreLi);
  }

  function positionDropdown(toggle) {
    var dropdown = toggle ? toggle.parentNode.querySelector('.' + MENU_CLASS + '-dropdown') : null;
    if (!dropdown || !dropdown.classList.contains('show')) return;

    var navbar = getNavbar();
    var tb = rect(toggle);
    var nb = rect(navbar);
    if (!tb || !nb) return;

    var width = Math.max(dropdown.offsetWidth || 180, 180);
    var left = tb.left;
    var maxLeft = Math.max(8, window.innerWidth - width - 8);
    if (left > maxLeft) left = maxLeft;
    if (left < 8) left = 8;

    dropdown.style.setProperty('--dash-topnav-dropdown-left', left + 'px');
    dropdown.style.setProperty('--dash-topnav-dropdown-top', nb.bottom + 'px');
    dropdown.style.left = left + 'px';
    dropdown.style.top = nb.bottom + 'px';
    dropdown.style.transform = 'none';
  }

  function positionOpenDropdowns() {
    var navbar = getNavbar();
    if (!navbar) return;
    var toggles = navbar.querySelectorAll('.dropdown.show > .dropdown-toggle, .dropdown > .dropdown-toggle[aria-expanded="true"]');
    for (var i = 0; i < toggles.length; i++) {
      positionDropdown(toggles[i]);
    }
  }

  function closeDropdowns(exceptLi) {
    var navbar = getNavbar();
    if (!navbar) return;

    var dropdowns = navbar.querySelectorAll('.' + MENU_CLASS + ' > .dropdown');
    for (var i = 0; i < dropdowns.length; i++) {
      var li = dropdowns[i];
      if (exceptLi && li === exceptLi) continue;

      li.classList.remove('show');
      var toggle = li.querySelector(':scope > .dropdown-toggle');
      var menu = li.querySelector(':scope > .' + MENU_CLASS + '-dropdown');
      if (toggle) toggle.setAttribute('aria-expanded', 'false');
      if (menu) {
        menu.classList.remove('show');
        menu.style.left = '';
        menu.style.top = '';
        menu.style.transform = '';
      }
    }
  }

  function toggleDropdown(toggle) {
    var li = toggle ? toggle.parentNode : null;
    var dropdown = li ? li.querySelector(':scope > .' + MENU_CLASS + '-dropdown') : null;
    if (!li || !dropdown) return;

    var willOpen = !dropdown.classList.contains('show');
    closeDropdowns(li);

    li.classList.toggle('show', willOpen);
    dropdown.classList.toggle('show', willOpen);
    toggle.setAttribute('aria-expanded', willOpen ? 'true' : 'false');
    if (willOpen) positionDropdown(toggle);
  }

  function wireDropdownPositioning(menu) {
    menu.addEventListener('click', function (e) {
      var toggle = e.target.closest ? e.target.closest('.dropdown-toggle') : null;
      if (!toggle || !menu.contains(toggle)) return;
      e.preventDefault();
      e.stopPropagation();
      toggleDropdown(toggle);
    });
  }

  function buildMenu(sidebarMenu) {
    var ul = document.createElement('ul');
    ul.className = 'navbar-nav ' + MENU_CLASS;

    var items = sidebarMenu.children;
    for (var i = 0; i < items.length; i++) {
      var item = items[i];
      if (!item.classList || !item.classList.contains('nav-item')) continue;

      var link = item.querySelector(':scope > a.nav-link');
      if (!link) continue;

      var li = document.createElement('li');
      var treeview = item.querySelector(':scope > ul.nav-treeview');

      if (treeview) {
        li.className = 'nav-item dropdown';
        var toggle = document.createElement('a');
        toggle.className = 'nav-link dropdown-toggle' +
          (item.querySelector('.nav-link.active') ? ' active' : '');
        toggle.href = '#';
        toggle.setAttribute('aria-haspopup', 'true');
        toggle.setAttribute('aria-expanded', 'false');
        cloneLinkContent(link, toggle);
        li.appendChild(toggle);

        var dd = document.createElement('div');
        dd.className = 'dropdown-menu ' + MENU_CLASS + '-dropdown';
        var subLinks = treeview.querySelectorAll(':scope > li.nav-item > a.nav-link');
        for (var j = 0; j < subLinks.length; j++) {
          (function (src) {
            var subA = document.createElement('a');
            subA.className = 'dropdown-item' + (src.classList.contains('active') ? ' active' : '');
            subA.href = '#';
            cloneLinkContent(src, subA, { removeIcons: true });
            subA.addEventListener('click', function (e) {
              e.preventDefault();
              src.click();
            });
            dd.appendChild(subA);
          })(subLinks[j]);
        }
        li.appendChild(dd);
      } else {
        li.className = 'nav-item';
        li.appendChild(makeDelegatedLink(link));
      }

      ul.appendChild(li);
    }

    buildMoreMenu(ul);
    return ul;
  }

  function buildBrand(brandLink) {
    var a = document.createElement('a');
    a.className = 'navbar-brand ' + BRAND_CLASS;
    a.href = '#';
    cloneLinkContent(brandLink, a);
    a.addEventListener('click', function (e) { e.preventDefault(); });
    return a;
  }

  function removeExisting(navbar) {
    var oldMenu = navbar.querySelector('.' + MENU_CLASS);
    if (oldMenu) oldMenu.parentNode.removeChild(oldMenu);
    var oldBrand = navbar.querySelector('.' + BRAND_CLASS);
    if (oldBrand) oldBrand.parentNode.removeChild(oldBrand);
    var oldToggle = navbar.querySelector('.' + TOGGLE_CLASS);
    if (oldToggle) oldToggle.parentNode.removeChild(oldToggle);
    var oldIndicator = navbar.querySelector('.' + INDICATOR_CLASS);
    if (oldIndicator) oldIndicator.parentNode.removeChild(oldIndicator);
  }

  function rect(el) {
    return el ? el.getBoundingClientRect() : null;
  }

  function applyTitleMode(forceCompact) {
    document.body.classList.remove('dash-topnav-title-compact', 'dash-topnav-title-hide');
    if (state.opts.title === 'hide') {
      document.body.classList.add('dash-topnav-title-hide');
    } else if (state.opts.title === 'compact' || forceCompact) {
      document.body.classList.add('dash-topnav-title-compact');
    }
  }

  function syncTitleCenter() {
    var navbar = getNavbar();
    var menu = navbar ? navbar.querySelector('.' + MENU_CLASS) : null;
    var title = navbar ? navbar.querySelector('.dash-nav-center') : null;
    if (!navbar || !menu || !title) return;
    if (state.opts.title === 'hide') {
      applyTitleMode(false);
      return;
    }

    if (state.opts.title !== 'show' && window.innerWidth < 1200) {
      document.body.classList.add('dash-topnav-title-hide');
      return;
    }

    var nb = rect(navbar);
    var mb = rect(menu);
    var tb = rect(title);
    var rightNav = navbar.querySelector('.navbar-nav.ml-auto');
    var rightEdge = nb.right;

    if (rightNav) {
      var rightChildren = rightNav.children;
      for (var i = 0; i < rightChildren.length; i++) {
        if (!rightChildren[i].classList.contains('dash-nav-center-wrap')) {
          rightEdge = rect(rightChildren[i]).left;
          break;
        }
      }
    }

    var leftEdge = mb.right;
    var half = tb.width / 2;
    var mid = (leftEdge + rightEdge) / 2;
    var minMid = leftEdge + half + 12;
    var maxMid = rightEdge - half - 12;

    if (maxMid < minMid && state.opts.title === 'auto') {
      applyTitleMode(true);
      tb = rect(title);
      half = tb.width / 2;
      minMid = leftEdge + half + 12;
      maxMid = rightEdge - half - 12;
    } else {
      applyTitleMode(false);
    }

    if (maxMid < minMid && state.opts.title !== 'show') {
      document.body.classList.add('dash-topnav-title-hide');
      return;
    }

    if (mid < minMid) mid = minMid;
    if (mid > maxMid) mid = maxMid;

    var pct = ((mid - nb.left) / nb.width) * 100;
    navbar.style.setProperty('--dash-topnav-center-left', pct.toFixed(3) + '%');
  }

  function buildMobileToggle() {
    var btn = document.createElement('button');
    btn.type = 'button';
    btn.className = TOGGLE_CLASS;
    btn.setAttribute('aria-label', 'Toggle top navigation');
    btn.setAttribute('aria-expanded', 'false');
    btn.innerHTML = '<i class="fas fa-bars" aria-hidden="true"></i>';
    btn.addEventListener('click', function () {
      var open = !document.body.classList.contains('dash-topnav-open');
      document.body.classList.toggle('dash-topnav-open', open);
      btn.setAttribute('aria-expanded', open ? 'true' : 'false');
    });
    return btn;
  }

  function buildIndicator() {
    var indicator = document.createElement('span');
    indicator.className = INDICATOR_CLASS;
    indicator.setAttribute('aria-hidden', 'true');
    return indicator;
  }

  function syncIndicator() {
    var navbar = getNavbar();
    var indicator = navbar ? navbar.querySelector('.' + INDICATOR_CLASS) : null;
    var active = navbar ? navbar.querySelector('.' + MENU_CLASS + ' > .nav-item > .nav-link.active') : null;
    if (!navbar || !indicator || !active || state.opts.style !== 'underline') {
      if (indicator) indicator.style.opacity = '0';
      return;
    }
    var nb = rect(navbar);
    var ab = rect(active);
    indicator.style.width = Math.max(0, ab.width) + 'px';
    indicator.style.transform = 'translateX(' + (ab.left - nb.left) + 'px)';
    indicator.style.opacity = '1';
  }

  function ensurePageTitle() {
    if (state.opts.pageTitle !== 'tab') return;
    var wrapper = document.querySelector('.content-wrapper');
    if (!wrapper || wrapper.querySelector('.dash-topnav-page-title')) return;

    var title = document.createElement('div');
    title.className = 'dash-topnav-page-title';
    title.innerHTML = '<span class="dash-topnav-page-title-text"></span>';
    wrapper.insertBefore(title, wrapper.firstChild);
  }

  function syncPageTitle() {
    if (state.opts.pageTitle !== 'tab') return;
    ensurePageTitle();
    var title = document.querySelector('.dash-topnav-page-title-text');
    var active = document.querySelector('.' + MENU_CLASS + ' > .nav-item > .nav-link.active, .' + MENU_CLASS + '-dropdown .dropdown-item.active');
    if (title && active) title.textContent = linkText(active);
  }

  function wireKeyboard(menu) {
    menu.addEventListener('keydown', function (e) {
      if (!['ArrowLeft', 'ArrowRight', 'Home', 'End', 'Enter', ' '].includes(e.key)) return;
      var links = Array.prototype.slice.call(menu.querySelectorAll('a.nav-link, a.dropdown-item'));
      var current = document.activeElement;
      var index = links.indexOf(current);
      if (e.key === 'Enter' || e.key === ' ') return;
      e.preventDefault();
      if (!links.length) return;
      if (e.key === 'Home') index = 0;
      else if (e.key === 'End') index = links.length - 1;
      else if (e.key === 'ArrowLeft') index = index <= 0 ? links.length - 1 : index - 1;
      else if (e.key === 'ArrowRight') index = index >= links.length - 1 ? 0 : index + 1;
      links[index].focus();
    });
  }

  function render() {
    var navbar = getNavbar();
    var sidebarMenu = getSidebarMenu();

    if (!navbar) { log('no navbar found; skipping render.'); return; }
    if (!sidebarMenu) { log('no sidebar menu found; skipping render.'); return; }

    removeExisting(navbar);

    if (state.opts.brand) {
      var brandLink = getBrandLink();
      // bs4DashSidebar(disable = TRUE) already moves the brand into the
      // navbar, in which case there is nothing to mirror.
      var nativeBrand = navbar.querySelector('.brand-link');
      if (brandLink && !nativeBrand) {
        navbar.insertBefore(buildBrand(brandLink), navbar.firstChild);
      }
    }

    var menu = buildMenu(sidebarMenu);
    menu.setAttribute('role', 'menubar');
    wireKeyboard(menu);
    wireDropdownPositioning(menu);
    var navLists = navbar.querySelectorAll(':scope > ul.navbar-nav');
    if (navLists.length > 0) {
      // insert right after the first (left) navbar-nav block
      navLists[0].parentNode.insertBefore(menu, navLists[0].nextSibling);
    } else {
      navbar.appendChild(menu);
    }

    navbar.insertBefore(buildMobileToggle(), menu);
    navbar.appendChild(buildIndicator());
    ensurePageTitle();
    syncTitleCenter();
    syncIndicator();
    syncPageTitle();
    log('rendered ' + menu.children.length + ' top-nav items.');
  }

  function scheduleRebuild() {
    if (state.rebuildTimer) clearTimeout(state.rebuildTimer);
    state.rebuildTimer = setTimeout(render, 60);
    if (state.activeTimer) clearTimeout(state.activeTimer);
    state.activeTimer = setTimeout(syncIndicator, 90);
  }

  function observe() {
    var sidebarMenu = getSidebarMenu();
    if (!sidebarMenu) return;

    if (state.menuObserver) state.menuObserver.disconnect();
    state.menuObserver = new MutationObserver(scheduleRebuild);
    // watches both structural changes (renderMenu) and active-state flips
    // (clicks, updateTabItems); a debounced full rebuild keeps both in sync.
    state.menuObserver.observe(sidebarMenu, {
      childList: true,
      subtree: true,
      attributes: true,
      attributeFilter: ['class']
    });
  }

  function applyBodyClasses() {
    document.body.classList.add('dash-topnav-mode');
    document.body.classList.add('layout-top-nav');
    document.body.classList.remove(
      'dash-topnav-center',
      'dash-topnav-align-left',
      'dash-topnav-align-center',
      'dash-topnav-align-right',
      'dash-topnav-style-underline',
      'dash-topnav-style-pill',
      'dash-topnav-style-compact',
      'dash-topnav-mobile-collapse',
      'dash-topnav-mobile-scroll',
      'dash-topnav-overflow-auto',
      'dash-topnav-overflow-more',
      'dash-topnav-overflow-scroll',
      'dash-topnav-page-title-none',
      'dash-topnav-page-title-tab',
      'dash-topnav-title-auto',
      'dash-topnav-title-show',
      'dash-topnav-title-compact',
      'dash-topnav-title-hide',
      'dash-topnav-debug'
    );
    document.body.classList.add('dash-topnav-align-' + state.opts.align);
    document.body.classList.add('dash-topnav-style-' + state.opts.style);
    document.body.classList.add('dash-topnav-mobile-' + state.opts.mobile);
    document.body.classList.add('dash-topnav-overflow-' + state.opts.overflow);
    document.body.classList.add('dash-topnav-page-title-' + state.opts.pageTitle);
    document.body.classList.add('dash-topnav-title-' + state.opts.title);
    if (state.opts.align === 'center') document.body.classList.add('dash-topnav-center');
    if (state.opts.debug) document.body.classList.add('dash-topnav-debug');
    applyTitleMode(false);
  }

  function init(opts) {
    if (opts && typeof opts === 'object') {
      for (var k in opts) {
        if (Object.prototype.hasOwnProperty.call(opts, k)) state.opts[k] = opts[k];
      }
    }

    var start = function () {
      applyBodyClasses();
      render();
      observe();
      setTimeout(syncTitleCenter, 120);
      setTimeout(syncTitleCenter, 320);
      setTimeout(syncIndicator, 140);
      setTimeout(syncIndicator, 340);
      setTimeout(syncPageTitle, 160);
      setTimeout(syncPageTitle, 360);
      window.addEventListener('resize', function () {
        syncTitleCenter();
        syncIndicator();
        positionOpenDropdowns();
      });
      window.addEventListener('scroll', positionOpenDropdowns, true);
      document.addEventListener('click', function (e) {
        var navbar = getNavbar();
        if (navbar && e.target && navbar.contains(e.target)) return;
        closeDropdowns();
      });
      document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') closeDropdowns();
      });
    };

    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', start);
    } else {
      start();
    }
  }

  window.bs4DashkitTopnav = { init: init, render: render };
})();
