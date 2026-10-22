/* bs4Dashkit back-to-top button: reveal after scrolling, smooth scroll home. */
(function () {
  "use strict";

  function init(scope) {
    var root = scope || document;
    var buttons = root.querySelectorAll
      ? root.querySelectorAll(".dash-back-to-top")
      : [];
    Array.prototype.forEach.call(buttons, function (btn) {
      if (btn.getAttribute("data-dash-btt-init") === "1") return;
      btn.setAttribute("data-dash-btt-init", "1");

      var showAfter = parseFloat(btn.getAttribute("data-show-after"));
      if (!isFinite(showAfter) || showAfter < 0) showAfter = 400;

      var onScroll = function () {
        var y =
          window.pageYOffset ||
          document.documentElement.scrollTop ||
          document.body.scrollTop ||
          0;
        if (y > showAfter) {
          btn.classList.add("dash-back-to-top-visible");
        } else {
          btn.classList.remove("dash-back-to-top-visible");
        }
      };

      window.addEventListener("scroll", onScroll, { passive: true });
      onScroll();

      btn.addEventListener("click", function () {
        window.scrollTo({ top: 0, behavior: "smooth" });
      });
    });
  }

  function boot() {
    init(document);
    // Re-scan for buttons inserted later (e.g. renderUI); init is idempotent.
    if (window.MutationObserver && document.body) {
      new MutationObserver(function () {
        init(document);
      }).observe(document.body, { childList: true, subtree: true });
    }
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", boot);
  } else {
    boot();
  }
})();
