(function(){

  /* ── CENTER: calculate midpoint and set CSS variable ── */
  function setDashCenter(){
    var centerEl = document.querySelector('.dash-nav-center');
    if(!centerEl) return;
    var nav = document.querySelector('.main-header.navbar, .main-header .navbar');
    if(!nav) return;
    var brand = nav.querySelector('.navbar-brand');
    var right = nav.querySelector('.navbar-nav.ml-auto');
    if(!brand || !right) {
      nav.style.removeProperty('--dash-center-left');
      return;
    }
    var nb = nav.getBoundingClientRect();
    var bb = brand.getBoundingClientRect();
    var rb = right.getBoundingClientRect();
    var mid = (bb.right + rb.left) / 2;
    if (mid < nb.left) mid = nb.left;
    if (mid > nb.right) mid = nb.right;
    var pct = ((mid - nb.left) / nb.width) * 100;
    nav.style.setProperty('--dash-center-left', pct.toFixed(3) + '%');
  }

  /* ── LEFT: physically move the left title into the left navbar-nav ── */
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

  /* ── run both ── */
  function init(){
    moveLeftTitle();
    setDashCenter();
  }

  window.addEventListener('load', init);
  window.addEventListener('resize', setDashCenter);

  setTimeout(init, 50);
  setTimeout(init, 250);

  document.addEventListener('click', function(e){
    var t = e.target;
    if(!t) return;
    if(t.closest && t.closest('.sidebar-toggle')){
      setTimeout(setDashCenter, 50);
      setTimeout(setDashCenter, 250);
    }
  });

})();
