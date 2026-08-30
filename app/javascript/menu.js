document.addEventListener("click", (event) => {
  const menuButton = event.target.closest("#menu-button");
  const siteMenu = document.querySelector("#site-menu");
  
  if (menuButton) {
  siteMenu.classList.toggle("is-open");
  menuButton.classList.toggle("is-open");
  return;
  }

  const menuLink = event.target.closest("#site-menu a");

  if (menuLink) {
    siteMenu.classList.remove("is-open");
    const button = document.querySelector("#menu-button");

    if (button) {
      button.classList.remove("is-open");
    }
  }
});