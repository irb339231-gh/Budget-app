document.addEventListener("turbo:load", () => {
  const tabs = document.querySelectorAll(".available-tab");
  const contents = document.querySelectorAll(".available-amount");

  if (!tabs.length || !contents.length) return;

  const showContent = (period) => {
    contents.forEach((content) => {
      content.style.display =
        content.dataset.periodContent === period ? "block" : "none";
    });
  };

  tabs.forEach((tab) => {
    tab.addEventListener("click", () => {
      const period = tab.dataset.period;
      showContent(period);
    });
  });

  showContent("all");
});

document.addEventListener("turbo:load", () => {
  const tabs = document.querySelectorAll(".transaction-tab");
  const forms = document.querySelectorAll(".transaction-form");
  if (!tabs.length || !forms.length) return;
  tabs.forEach((tab) => {
    tab.addEventListener("click", () => {
      const type = tab.dataset.transactionType;
      // タブの状態を変更
      tabs.forEach((tab) => {
        tab.classList.remove("active");
      });
      tab.classList.add("active");
      // フォームを切り替える
      forms.forEach((form) => {
        if (form.dataset.transactionForm === type) {
          form.style.display = "block";
        } else {
          form.style.display = "none";
        }
      });
    });
  });
});