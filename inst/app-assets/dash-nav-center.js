(function(){
  var resizeObserver = null;
  var navObserver = null;
  var syncQueued = false;

  function setDashCenter(){
    var centerEl = document.querySelector('.dash-nav-center');
    if(!centerEl) return;
    var nav = document.querySelector('.main-header.navbar, .main-header .navbar');
    if(!nav) return;
    var leftNav = nav.querySelector('.navbar-nav:not(.ml-auto)');
    var right = nav.querySelector('.navbar-nav.ml-auto');
    if(!right) {
      nav.style.removeProperty('--dash-center-left');
      return;
    }

    var nb = nav.getBoundingClientRect();
    var rb = right.getBoundingClientRect();
    var lb = leftNav ? leftNav.getBoundingClientRect() : null;

    var leftEdge = lb ? lb.right : nb.left;
    var rightEdge = rb.left;
    if(rightEdge <= leftEdge) {
      nav.style.setProperty('--dash-center-left', '50%');
      return;
    }

    var mid = (leftEdge + rightEdge) / 2;
    var half = centerEl.getBoundingClientRect().width / 2;
    var minMid = leftEdge + half;
    var maxMid = rightEdge - half;

    if(maxMid < minMid) {
      mid = (leftEdge + rightEdge) / 2;
    } else {
      if (mid < minMid) mid = minMid;
      if (mid > maxMid) mid = maxMid;
    }

    var pct = ((mid - nb.left) / nb.width) * 100;
    nav.style.setProperty('--dash-center-left', pct.toFixed(3) + '%');
  }

  function moveLeftTitle(){
    var leftWrap = document.querySelector('li.dash-nav-left-wrap');
    if(!leftWrap) return;
    var nav = document.querySelector('.main-header.navbar, .main-header .navbar');
    if(!nav) return;
    var leftNav = nav.querySelector('.navbar-nav:not(.ml-auto)');
    if(!leftNav) return;
    if(leftNav.contains(leftWrap)) return;
    leftNav.appendChild(leftWrap);
  }

  function queueSync(){
    if(syncQueued) return;
    syncQueued = true;
    window.requestAnimationFrame(function(){
      syncQueued = false;
      moveLeftTitle();
      setDashCenter();
    });
  }

  function watchLayout(){
    var nav = document.querySelector('.main-header.navbar, .main-header .navbar');
    if(!nav) return;

    if(typeof ResizeObserver !== 'undefined' && !resizeObserver){
      resizeObserver = new ResizeObserver(queueSync);
      resizeObserver.observe(nav);
      Array.prototype.forEach.call(
        nav.querySelectorAll('.navbar-nav, .navbar-brand, .dash-nav-center'),
        function(el){ resizeObserver.observe(el); }
      );
    }

    if(typeof MutationObserver !== 'undefined' && !navObserver){
      navObserver = new MutationObserver(queueSync);
      navObserver.observe(nav, { childList: true, subtree: true, attributes: true, attributeFilter: ['class', 'style'] });
    }
  }

  function init(){
    queueSync();
    watchLayout();
  }

  window.addEventListener('load', init);
  window.addEventListener('resize', queueSync);

  setTimeout(init, 50);
  setTimeout(init, 250);

  document.addEventListener('click', function(e){
    var t = e.target;
    if(!t) return;
    if(t.closest && t.closest('.sidebar-toggle')){
      setTimeout(queueSync, 50);
      setTimeout(queueSync, 250);
    }
  });

})();
