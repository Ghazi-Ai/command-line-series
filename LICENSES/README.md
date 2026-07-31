# خريطة التراخيص الدقيقة — الإصدار المنشور 2.0.0

هذه الخريطة هي المرجع لتحديد نطاق كل رخصة. لا يعني وجود ملف داخل
المستودع أنه مشمول تلقائيًا بأي رخصة.

## 1. المحتوى العام تحت CC BY-SA 4.0

تعرض مساهمات صاحب المشروع القابلة للترخيص في المسارات الآتية بموجب
[CC BY-SA 4.0](CC-BY-SA-4.0.txt):

- النص العربي للكتب العشرة المنشورة داخل:
  - `books/1-linux/ar/**`
  - `books/2-macos/ar/**`
  - `books/3-windows/ar/**`
  - `books/4-bsd/ar/**`
  - `books/5-workbook/ar/**`
  - `books/6-unix-story/ar/**`
  - `books/7-automation/ar/**`
  - `books/8-server/ar/**`
  - `books/9-network/ar/**`
  - `books/10-projects/ar/**`
- الوثائق التحريرية العامة التالية فقط:
  - `README.md`
  - `README.en.md`
  - `AUTHORS.md`
  - `ATTRIBUTION.md`
  - `CONTRIBUTING.md`
  - `CONTRIBUTING.en.md`
  - `TRANSLATION-GUIDE.md`
  - `OFFICIAL-EDITIONS.md`
  - `BRAND-POLICY.md`
  - `TRADEMARKS.md`
  - `GOVERNANCE.md`
  - `SUCCESSION.md`
  - `PROJECT-STATUS.md`
  - `CHANGELOG.md`
  - `CODE_OF_CONDUCT.md`
  - `SECURITY.md`
  - `THIRD_PARTY_NOTICES.md`
  - `LICENSES/README.md`
  - `docs/README.md`
  - `docs/ROADMAP.md`
  - `docs/STYLE-GUIDE.md`
  - `docs/COVER-RIGHTS-AUDIT.md`
  - `docs/PRINTING.md`
  - `docs/PDF-ACCESSIBILITY.md`
  - `docs/PUBLISHING-CHECKLIST.md`
  - `docs/RELEASE-AUDIT-v2.0.0.md`
  - `COVER-PERMISSION.md`
  - `docs/future-books/README.md`
  - `docs/future-books/07-automation.md`
  - `docs/future-books/08-server.md`
  - `docs/future-books/09-network.md`
  - `docs/future-books/10-projects.md`
  - `docs/audits/book-8-adversarial-v2.0.0.md`
  - `docs/audits/book-9-adversarial-v2.0.0.md`
  - `docs/audits/book-10-adversarial-v2.0.0.md`
  - `fonts/README.md`
- النصوص التحريرية الأصلية الظاهرة في `site/index.html`.

### استثناءات داخل مسارات الكتب

حتى داخل المسارات السابقة، لا يشمل عرض CC BY-SA 4.0:

- كل ملف يطابق `books/*/ar/assets/cover*.png`.

صور الأغلفة مستثناة بقرار نطاق الترخيص، مع توثيق مصدرها في
`docs/COVER-RIGHTS-AUDIT.md`.

## 2. الشيفرة الأصلية تحت MIT

تعرض الشيفرة الأصلية في المسارات الآتية بموجب
[رخصة MIT](MIT.txt):

- `tools/*.py`
- `tools/*.sh`
- `tools/*.typ`
- `lib/*.typ`
- `build.sh`
- `Makefile`
- `.github/workflows/*.yml`
- `.github/ISSUE_TEMPLATE/*.yml`
- `.github/pull_request_template.md`
- `.gitignore`
- `site/script.js`
- `site/reader.js`
- `site/styles.css`
- `examples/7-automation/**`
- تعليمات Typst الأصلية ومقاطع الشيفرة البرمجية الأصلية داخل
  `books/*/ar/**/*.typ`، من حيث كونها شيفرة فقط؛ ويبقى النثر والمحتوى
  التعليمي المحيط بها تحت CC BY-SA 4.0، وتبقى أي مادة خارجية تحت
  رخصتها الأصلية.
- بنية HTML والقالب البرمجي في `site/index.html`، مع بقاء النصوص
  التحريرية في الملف نفسه تحت CC BY-SA 4.0.

لا يمتد MIT إلى أي مادة غير مدرجة لمجرد احتوائها شيفرة أو قالبًا.

## 3. مواد الأطراف الثالثة

لا تخضع المواد الآتية لـCC BY-SA أو MIT الخاصين بالمشروع:

- `fonts/*.ttf`
- نصوص رخص الخطوط المرفقة داخل `LICENSES/`.
- PDF.js الذي تجلبه عملية بناء قارئ الموقع.
- GitHub Actions وأي مكتبة أو أداة خارجية مستخدمة في البناء.

تبقى هذه المواد تحت رخص أصحابها. راجع
[`THIRD_PARTY_NOTICES.md`](../THIRD_PARTY_NOTICES.md).

## 4. حدود العرض

ينطبق عرض الترخيص على الملفات والمسارات العامة المسماة صراحة في هذه
الخريطة فقط. لا يعني وجود مادة في تاريخ Git أنها تدخل تلقائيًا في
عرض CC BY-SA 4.0 أو MIT الحالي، ولا يغيّر حذف ملف من الشجرة الحالية
الحقوق التي مُنحت سابقًا.

## 5. أصول بصرية مستثناة من عرض الترخيص

وثّق صاحب المشروع أن صور الأغلفة وُلّدت بالكامل عبر ChatGPT Images
من OpenAI، اعتمادًا على أوصاف نصية أصلية كتبها، دون صور مرجعية أو
أعمال بصرية خارجية، ثم أضيفت العناوين والنصوص والهوية والتنسيق
النهائي بأداة Typst. ومع توثيق المصدر والمدخلات، لا يشمل عرض
CC BY-SA 4.0 المسارات الآتية:

- `books/*/ar/assets/cover*.png`
- `docs/readme-brand/*.png`
- `docs/readme-covers/*.png`
- `docs/site-preview.png`

قد تعرض ملفات PDF أو الموقع هذه الأصول ضمن النسخة الرسمية. يسمح
`COVER-PERMISSION.md` بطباعة النسخة الرسمية غير المعدلة وتوزيعها
ككتاب كامل، لكنه لا يمنح إذنًا باقتطاع الغلاف أو تعديله أو استعماله
لهوية نسخة مشتقة. على صانع النسخة المشتقة استبداله بأصل يملك حق
استعماله أو الحصول على إذن مستقل. راجع `docs/COVER-RIGHTS-AUDIT.md`.

## 6. حدود عامة

تنطبق العروض السابقة فقط على العناصر التي يملك صاحب المشروع حق
ترخيصها. ولا تنقل حقوق العلامات التجارية، أو حقوق الأطراف الثالثة، أو
أي حقوق حصرية لا يملكها صاحب المشروع أو لا تنشأ أصلًا وفق القانون
الواجب التطبيق.

لا تمنح CC BY-SA صفة رسمية أو اعتمادًا لنسخة معدلة، ولا تمنح حق
استعمال الهوية بما يوحي بالتأييد. راجع `OFFICIAL-EDITIONS.md` و
`BRAND-POLICY.md`.

## 7. تاريخ الرخصة

نُشر الإصدار 1.2 سابقًا تحت CC BY-ND 4.0. ابتداءً من الإصدار 1.3،
يعرض صاحب المشروع مساهماته القابلة للترخيص تحت CC BY-SA 4.0، مع فصل
الشيفرة تحت MIT. لا يسحب الإصدار 1.3 الحقوق السابقة بأثر رجعي.
