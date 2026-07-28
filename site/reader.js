let pdfjsPromise;
function loadPdfJs() {
  if (!pdfjsPromise) {
    pdfjsPromise = import("./vendor/pdf.mjs").then((pdfjsLib) => {
      pdfjsLib.GlobalWorkerOptions.workerSrc = "./vendor/pdf.worker.mjs";
      return pdfjsLib;
    });
  }
  return pdfjsPromise;
}

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
  totalPages: 1,
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
  const total = state.totalPages;
  ui.page.value = state.page;
  ui.page.max = total;
  ui.total.textContent = total;
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
  ui.image.alt = `صفحة ${state.page} من ${state.totalPages} — ${ui.title.textContent}`;
  ui.image.src = `reader-pages/${book}/page-${page}.jpg`;
  localStorage.setItem(progressKey(), String(state.page));
  updateControls();
}

async function openBook(source, title, totalPages) {
  state.openToken += 1;
  const token = state.openToken;
  state.source = source;
  state.document = null;
  state.totalPages = Math.max(Number(totalPages) || 1, 1);
  state.fit = true;
  state.zoom = 100;
  state.page = 1;

  ui.title.textContent = title;
  ui.download.href = source;
  ui.loading.innerHTML = "<span></span><strong>نفتح الكتاب…</strong><small>تُحمّل صفحاته عند الحاجة</small>";
  ui.loading.hidden = false;
  ui.image.removeAttribute("src");
  ui.total.textContent = state.totalPages;
  document.body.classList.add("reader-open");
  ui.dialog.showModal();
  const saved = Number(localStorage.getItem(progressKey()));
  state.page = Number.isInteger(saved) && saved > 0
    ? clamp(saved, 1, state.totalPages)
    : 1;
  renderPage();

  try {
    const pdfjsLib = await loadPdfJs();
    state.document = await pdfjsLib.getDocument({ url: source }).promise;
    if (token !== state.openToken) return;
    state.totalPages = state.document.numPages;
    const validPage = clamp(state.page, 1, state.totalPages);
    if (validPage !== state.page) {
      state.page = validPage;
      renderPage();
    } else {
      updateControls();
    }
  } catch (error) {
    if (token !== state.openToken) return;
    announce("تعذّر تفعيل البحث؛ تصفح الصفحات ما زال متاحًا", true);
    console.error(error);
  }
}

function closeBook() {
  state.openToken += 1;
  if (ui.dialog.open) ui.dialog.close();
  document.body.classList.remove("reader-open");
  ui.image.removeAttribute("src");
  const currentDocument = state.document;
  state.document = null;
  currentDocument?.destroy();
}

function goToPage(pageNumber) {
  state.page = clamp(Number(pageNumber) || 1, 1, state.totalPages);
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
window.closeSeriesReader = closeBook;
for (const queued of window.seriesReaderQueue) {
  queued.button.disabled = false;
  queued.button.textContent = queued.button.dataset.readyLabel;
  openBook(queued.source, queued.title, queued.pages);
}
window.seriesReaderQueue.length = 0;
ui.image.addEventListener("load", () => {
  ui.loading.hidden = true;
  if (!state.fit) ui.image.style.width = `${Math.round(ui.image.naturalWidth * state.zoom / 100)}px`;
});
ui.image.addEventListener("error", () => {
  ui.loading.innerHTML = "<strong>تعذّر عرض الصفحة</strong><small>يمكنك تنزيل الكتاب من الزر العلوي.</small>";
  ui.loading.hidden = false;
});
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
ui.searchForm.addEventListener("submit", (event) => {
  event.preventDefault();
  searchDocument(ui.search.value);
});
window.addEventListener("keydown", (event) => {
  if (!ui.dialog.open || event.target.matches("input")) return;
  if (event.key === "ArrowLeft") goToPage(state.page + 1);
  if (event.key === "ArrowRight") goToPage(state.page - 1);
});
