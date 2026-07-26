const header = document.querySelector("[data-header]");
const menuButton = document.querySelector("[data-menu]");
const nav = document.querySelector("#site-nav");

const updateHeader = () => header.classList.toggle("scrolled", window.scrollY > 24);
updateHeader();
window.addEventListener("scroll", updateHeader, { passive: true });

menuButton.addEventListener("click", () => {
  const open = nav.classList.toggle("open");
  menuButton.setAttribute("aria-expanded", String(open));
});

nav.addEventListener("click", (event) => {
  if (event.target.closest("a")) {
    nav.classList.remove("open");
    menuButton.setAttribute("aria-expanded", "false");
  }
});

const observer = new IntersectionObserver((entries) => {
  for (const entry of entries) {
    if (entry.isIntersecting) {
      entry.target.classList.add("visible");
      observer.unobserve(entry.target);
    }
  }
}, { threshold: 0.12 });

document.querySelectorAll(".reveal").forEach((element, index) => {
  element.style.transitionDelay = `${Math.min(index % 4, 3) * 70}ms`;
  observer.observe(element);
});

document.querySelectorAll(".book-card").forEach((card) => {
  card.addEventListener("pointermove", (event) => {
    if (window.matchMedia("(pointer: coarse)").matches) return;
    const box = card.getBoundingClientRect();
    const x = (event.clientX - box.left) / box.width - 0.5;
    const y = (event.clientY - box.top) / box.height - 0.5;
    card.style.transform = `perspective(900px) rotateY(${x * -2.2}deg) rotateX(${y * 2.2}deg) translateY(-7px)`;
  });
  card.addEventListener("pointerleave", () => {
    card.style.transform = "";
  });
});

const reader = document.querySelector("[data-reader]");
const readerFrame = document.querySelector("[data-reader-frame]");
const readerTitle = document.querySelector("[data-reader-title]");
const readerOpen = document.querySelector("[data-reader-open]");
const closeReader = () => {
  reader.close();
  readerFrame.removeAttribute("src");
  document.body.classList.remove("reader-open");
};

document.querySelectorAll("[data-pdf]").forEach((button) => {
  button.addEventListener("click", () => {
    const source = button.dataset.pdf;
    readerTitle.textContent = button.dataset.title;
    readerFrame.src = `${source}#view=FitH`;
    readerOpen.href = source;
    reader.showModal();
    document.body.classList.add("reader-open");
  });
});

document.querySelector("[data-reader-close]").addEventListener("click", closeReader);
reader.addEventListener("click", (event) => {
  if (event.target === reader) closeReader();
});
reader.addEventListener("cancel", (event) => {
  event.preventDefault();
  closeReader();
});
