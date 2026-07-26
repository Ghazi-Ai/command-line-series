import * as pdfjsLib from "./vendor/pdf.mjs";

pdfjsLib.GlobalWorkerOptions.workerSrc = "./vendor/pdf.worker.mjs";

const ui = {
  dialog: document.querySelector("[data-reader]"),
  title: document.querySelector("[data-reader-title]"),
  download: document.querySelector("[data-reader-download]"),
  close: document.querySelector("[data-reader-close]"),
  previous: document.querySelector("[data-reader-prev]"),
  next: document.querySelector("[data-reader-next]"),
  page: document.querySelector("[data-reader-page]"),
  total: document.querySelector("[data-reader-total]"),
  zoomOut: document.querySelector("[data-reader-zoom-out]"),
  zoomIn: document.querySelector("[data-reader-zoom-in]"),
  zoom: document.querySelector("[data-reader-zoom]"),
  fit: document.querySelector("[data-reader-fit]"),
  fullscreen: document.querySelector("[data-reader-fullscreen]"),
  searchForm: document.querySelector("[data-reader-search-form]"),
  search: document.querySelector("[data-reader-search]"),
  imageWrap: document.querySelector("[data-reader-image-wrap]"),
  image: document.querySelector("[data-reader-image]"),
  loading: document.querySelector("[data-reader-loading]"),
  message: document.querySelector("[data-reader-message]"),
};

const state = {
  document: null,
  source: "",
  page: 1,
  zoom: 100,
  fit: true,
  openToken: 0,
};

const clamp = (number, min, max) => Math.min(Math.max(number, min), max);
const progressKey = () => `command-line-reader:${state.source}`;

function announce(message, error = false) {
  ui.message.textContent = message;
  ui.message.classList.toggle("error", error);
  if (message) setTimeout(() => {
    if (ui.message.textContent === message) ui.message.textContent = "";
  }, 3200);
}

function updateControls() {
  const total = state.document?.numPages || 1;
  ui.page.value = state.page;
  ui.page.max = total;
  ui.total.textContent = state.document?.numPages || "—";
  ui.previous.disabled = state.page <= 1;
  ui.next.disabled = state.page >= total;
  ui.zoom.textContent = state.fit ? "عرض الصفحة" : `${state.zoom}%`;
  ui.fit.classList.toggle("active", state.fit);
}

function renderPage() {
  if (!state.source) return;
  ui.loading.hidden = false;
  const book = state.source.split("/").pop().replace("-ar.pdf", "");
  const page = String(state.page).padStart(3, "0");
  ui.imageWrap.classList.toggle("fit", state.fit);
  ui.image.style.width = state.fit ? "" : `${Math.round(ui.image.naturalWidth * state.zoom / 100)}px`;
  ui.image.alt = `صفحة ${state.page} من ${state.document?.numPages || ""} — ${ui.title.textContent}`;
  ui.image.src = `reader-pages/${book}/page-${page}.jpg`;
  localStorage.setItem(progressKey(), String(state.page));
  updateControls();
}

async function openBook(source, title) {
  state.openToken += 1;
  const token = state.openToken;
  state.source = source;
  state.document = null;
  state.fit = true;
  state.zoom = 100;
  state.page = 1;

  ui.title.textContent = title;
  ui.download.href = source;
  ui.loading.innerHTML = "<span></span><strong>نفتح الكتاب…</strong><small>تُحمّل صفحاته عند الحاجة</small>";
  ui.loading.hidden = false;
  ui.image.removeAttribute("src");
  ui.total.textContent = "—";
  document.body.classList.add("reader-open");
  ui.dialog.showModal();

  try {
    state.document = await pdfjsLib.getDocument({ url: source }).promise;
    if (token !== state.openToken) return;
    const saved = Number(localStorage.getItem(progressKey()));
    state.page = Number.isInteger(saved) ? clamp(saved, 1, state.document.numPages) : 1;
    renderPage();
  } catch (error) {
    if (token !== state.openToken) return;
    ui.loading.innerHTML = "<strong>تعذّر فتح الكتاب</strong><small>يمكنك تنزيله من الزر العلوي.</small>";
    announce("تعذّر تحميل ملف PDF", true);
    console.error(error);
  }
}

function closeBook() {
  state.openToken += 1;
  state.document?.destroy();
  state.document = null;
  ui.image.removeAttribute("src");
  ui.dialog.close();
  document.body.classList.remove("reader-open");
}

function goToPage(pageNumber) {
  if (!state.document) return;
  state.page = clamp(Number(pageNumber) || 1, 1, state.document.numPages);
  renderPage();
}

function changeZoom(amount) {
  state.fit = false;
  state.zoom = clamp(state.zoom + amount, 50, 240);
  renderPage();
}

async function searchDocument(query) {
  if (!state.document || !query.trim()) return;
  const needle = query.trim().toLocaleLowerCase("ar");
  ui.search.disabled = true;
  announce("جارٍ البحث…");
  try {
    for (let pageNumber = 1; pageNumber <= state.document.numPages; pageNumber += 1) {
      const page = await state.document.getPage(pageNumber);
      const content = await page.getTextContent();
      const text = content.items.map((item) => item.str).join(" ").toLocaleLowerCase("ar");
      if (text.includes(needle)) {
        goToPage(pageNumber);
        announce(`وُجدت العبارة في الصفحة ${pageNumber}`);
        return;
      }
    }
    announce("لم تُوجد العبارة في الكتاب");
  } finally {
    ui.search.disabled = false;
    ui.search.focus();
  }
}

window.openSeriesReader = openBook;
window.dispatchEvent(new CustomEvent("series-reader-ready"));
ui.image.addEventListener("load", () => {
  ui.loading.hidden = true;
  if (!state.fit) ui.image.style.width = `${Math.round(ui.image.naturalWidth * state.zoom / 100)}px`;
});
ui.image.addEventListener("error", () => {
  ui.loading.innerHTML = "<strong>تعذّر عرض الصفحة</strong><small>يمكنك تنزيل الكتاب من الزر العلوي.</small>";
  ui.loading.hidden = false;
});
ui.close.addEventListener("click", closeBook);
ui.dialog.addEventListener("cancel", (event) => {
  event.preventDefault();
  closeBook();
});
ui.previous.addEventListener("click", () => goToPage(state.page - 1));
ui.next.addEventListener("click", () => goToPage(state.page + 1));
ui.page.addEventListener("change", () => goToPage(ui.page.value));
ui.zoomOut.addEventListener("click", () => changeZoom(-15));
ui.zoomIn.addEventListener("click", () => changeZoom(15));
ui.fit.addEventListener("click", () => {
  state.fit = true;
  renderPage();
});
ui.fullscreen.addEventListener("click", async () => {
  if (document.fullscreenElement) await document.exitFullscreen();
  else await ui.dialog.requestFullscreen();
});
ui.searchForm.addEventListener("submit", (event) => {
  event.preventDefault();
  searchDocument(ui.search.value);
});
window.addEventListener("keydown", (event) => {
  if (!ui.dialog.open || event.target.matches("input")) return;
  if (event.key === "ArrowLeft") goToPage(state.page + 1);
  if (event.key === "ArrowRight") goToPage(state.page - 1);
});
