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

const bookStack = document.querySelector("[data-book-stack]");
if (bookStack) {
  const stackBooks = [...bookStack.querySelectorAll(".stack-book")];
  const position = document.querySelector("[data-stack-position]");
  const title = document.querySelector("[data-stack-title]");
  const previous = document.querySelector("[data-stack-prev]");
  const next = document.querySelector("[data-stack-next]");
  const finePointer = window.matchMedia("(hover: hover) and (pointer: fine)");
  const reduceMotion = window.matchMedia("(prefers-reduced-motion: reduce)");
  let activeIndex = stackBooks.length - 1;
  let frame = 0;
  let pointerStart = null;
  let suppressClick = false;

  const selectBook = (index) => {
    activeIndex = (index + stackBooks.length) % stackBooks.length;
    stackBooks.forEach((book, bookIndex) => {
      book.classList.toggle("is-active", bookIndex === activeIndex);
    });
    const selected = stackBooks[activeIndex];
    position.textContent = `الكتاب ${activeIndex + 1} من ${stackBooks.length}`;
    title.textContent = "";
    if (selected.dataset.title.startsWith("10+")) {
      const prefix = document.createElement("bdi");
      prefix.dir = "ltr";
      prefix.textContent = "10+";
      title.append(prefix, ` ${selected.dataset.title.slice(3).trim()}`);
    } else {
      title.textContent = selected.dataset.title;
    }
    bookStack.setAttribute(
      "aria-label",
      `فتح الكتاب ${activeIndex + 1} من ${stackBooks.length}: ${selected.dataset.title}`,
    );
  };

  const openSelectedBook = () => {
    const selected = stackBooks[activeIndex];
    const matchingButton = [...document.querySelectorAll(".read-button")]
      .find((button) => button.dataset.pdf === selected.dataset.pdf);
    matchingButton?.click();
  };

  const step = (amount) => selectBook(activeIndex + amount);
  previous.addEventListener("click", () => step(-1));
  next.addEventListener("click", () => step(1));

  bookStack.addEventListener("pointermove", (event) => {
    if (!finePointer.matches && event.pointerType !== "mouse") return;
    const box = bookStack.getBoundingClientRect();
    const x = (event.clientX - box.left) / box.width;
    const y = (event.clientY - box.top) / box.height;
    cancelAnimationFrame(frame);
    frame = requestAnimationFrame(() => {
      selectBook(Math.min(stackBooks.length - 1, Math.max(0, Math.floor(x * stackBooks.length))));
      if (!reduceMotion.matches) {
        bookStack.style.setProperty("--tilt-y", `${(x - 0.5) * 7}deg`);
        bookStack.style.setProperty("--tilt-x", `${(0.5 - y) * 5}deg`);
      }
    });
  });

  bookStack.addEventListener("pointerleave", () => {
    bookStack.style.setProperty("--tilt-x", "0deg");
    bookStack.style.setProperty("--tilt-y", "0deg");
  });

  bookStack.addEventListener("pointerdown", (event) => {
    if (finePointer.matches || event.pointerType === "mouse") return;
    pointerStart = { x: event.clientX, y: event.clientY };
  });

  bookStack.addEventListener("pointerup", (event) => {
    if (!pointerStart || finePointer.matches || event.pointerType === "mouse") return;
    const deltaX = event.clientX - pointerStart.x;
    const deltaY = event.clientY - pointerStart.y;
    pointerStart = null;
    if (Math.abs(deltaX) < 36 || Math.abs(deltaX) < Math.abs(deltaY)) return;
    suppressClick = true;
    step(deltaX < 0 ? 1 : -1);
    setTimeout(() => { suppressClick = false; }, 0);
  });

  bookStack.addEventListener("pointercancel", () => { pointerStart = null; });
  bookStack.addEventListener("click", (event) => {
    if (suppressClick) {
      event.preventDefault();
      return;
    }
    openSelectedBook();
  });

  bookStack.addEventListener("keydown", (event) => {
    if (event.key === "ArrowLeft") {
      event.preventDefault();
      step(-1);
    } else if (event.key === "ArrowRight") {
      event.preventDefault();
      step(1);
    }
  });

  selectBook(activeIndex);
}
