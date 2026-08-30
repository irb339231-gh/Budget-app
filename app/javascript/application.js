// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./fade_in"
import "./menu"
import "./home"

document.addEventListener("turbo:load", () => {
  const button = document.getElementById("money-settings-button");
  const menu = document.getElementById("money-settings-menu");
  if (!button || !menu) return;
  button.addEventListener("click", () => {
    button.classList.toggle("is-open");
    menu.classList.toggle("is-open");
  });
});


