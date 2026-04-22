//= require active_admin/base

// Polyfill for missing rails-ujs in Rails 8. Handles 'data-method' links (like Delete buttons in ActiveAdmin)
document.addEventListener("DOMContentLoaded", function() {
  document.addEventListener("click", function(e) {
    let element = e.target.closest('a[data-method]');
    if (!element) return;
    
    let method = element.getAttribute("data-method").toUpperCase();
    if (method === "GET") return;
    
    e.preventDefault();
    
    let message = element.getAttribute("data-confirm");
    if (message && !window.confirm(message)) return;
    
    let form = document.createElement("form");
    form.method = "POST";
    form.action = element.getAttribute("href");
    form.style.display = "none";
    
    let csrfToken = document.querySelector('meta[name="csrf-token"]')?.content;
    let csrfParam = document.querySelector('meta[name="csrf-param"]')?.content;
    
    let methodInput = document.createElement("input");
    methodInput.type = "hidden";
    methodInput.name = "_method";
    methodInput.value = method;
    form.appendChild(methodInput);
    
    if (csrfParam && csrfToken) {
      let csrfInput = document.createElement("input");
      csrfInput.type = "hidden";
      csrfInput.name = csrfParam;
      csrfInput.value = csrfToken;
      form.appendChild(csrfInput);
    }
    
    document.body.appendChild(form);
    form.submit();
  });
});
