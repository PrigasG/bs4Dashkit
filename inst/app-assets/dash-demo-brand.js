/* bs4Dashkit demo-only live brand updater */
(function () {
  'use strict';

  if (!window.Shiny || !window.Shiny.addCustomMessageHandler) return;

  window.Shiny.addCustomMessageHandler('bs4dashkit-demo-brand', function (message) {
    function updateLabel(label) {
      if (!label) return;
      label.textContent = message.brand_text || '';
    }

    function updateIcon(label) {
      if (!label || !label.parentElement) return;

      var parent = label.parentElement;
      var icon = parent.querySelector('.dash-brand-icon');
      var hasIcon = !!(message.icon && message.icon.length);

      if (!hasIcon) {
        if (icon) icon.style.display = 'none';
        return;
      }

      if (!icon) {
        icon = document.createElement('i');
        parent.insertBefore(icon, label);
      }

      icon.className = 'fas fa-' + message.icon + ' fa-fw dash-brand-icon';
      icon.style.display = '';
      icon.style.fontSize = message.icon_size || '';
    }

    var labels = document.querySelectorAll(
      '.main-header .dash-brand-label, .main-sidebar .dash-brand-label'
    );
    labels.forEach(function (label) {
      updateLabel(label);
      updateIcon(label);
    });
  });
})();
