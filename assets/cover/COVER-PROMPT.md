# برومبت تصميم الغلاف (أماميّ + خلفيّ) · Cover Design Prompt

> جاهزٌ للّصق في مولّد صور (ChatGPT / DALL·E / Midjourney). الكتاب **٥٩١ صفحة A5**، فالتجليد **غِراء (perfect binding)** لا تدبيس.

## قاعدة ذهبيّة قبل التوليد

مولّدات الصور تُفسد النصّ العربيّ. لذلك **ولّد الفنّ بلا أيّ نصّ**، ثم أضِف العنوان والنبذة لاحقًا بخطٍّ عربيّ نظيف (Noto Kufi Arabic / Amiri) في Figma أو Inkscape أو Affinity. هكذا تضمن دقّة الحروف.

## لوحة الألوان (التزم بها في الوجهين)

- أخضر صنوبريّ عميق `#1F6F5C` / `#164A3E` (الأساس)
- طوبيّ دافئ `#C0592B` (لمسة/تمييز)
- ورقٌ دافئ فاتح `#FCFBF9` (الخلفية)
- حبرٌ داكن `#26242E` (النصّ)

---

## ١) الغلاف الأماميّ — برومبت الفنّ (إنجليزيّ)

```
A refined, minimalist book-cover illustration, A5 portrait, print quality.
Central motif: a single elegant terminal command-line cursor (a small block) glowing
softly in a calm dark-green space, with a subtle "$" prompt beside it. From the cursor,
fine delicate ROOTS grow downward as thin elegant line-art — a visual pun on "root".
Deep pine-green (#1F6F5C, #164A3E) with warm terracotta (#C0592B) accents on a warm
off-white paper background (#FCFBF9). Lots of negative space, editorial Apple-like
restraint, timeless, high craft, flat vector aesthetic, soft paper texture.
Absolutely NO text, NO letters, NO words anywhere in the image.
```

**النصّ يُضاف فوقه لاحقًا:** العنوان **مِن الصِّفر إلى الجَذر** (Noto Kufi، `#164A3E`)، تحته خطٌّ طوبيّ قصير `#C0592B`، ثم العنوان الفرعيّ *الدليل الشامل إلى سطر الأوامر ولِينُكس* (IBM Plex Sans Arabic)، وأسفل الغلاف **المهندس غازي السيف**.

---

## ٢) الغلاف الخلفيّ — برومبت الفنّ (إنجليزيّ)

```
Back cover for the same A5 book, matching style: the SAME warm off-white paper
background (#FCFBF9) with a very subtle continuation of the thin root-lines motif
rising faintly from the bottom edge in deep pine-green, kept light so text stays
readable over it. Minimal, calm, lots of empty space in the upper two-thirds for a
text block. A thin terracotta (#C0592B) horizontal rule near the top. Flat vector,
print quality. NO text, NO letters anywhere in the image.
```

**النصّ الذي يُضاف على الغلاف الخلفيّ** (انسخه كما هو):

> **مِن الصِّفر إلى الجَذر**
>
> شاشةٌ سوداء ومؤشّرٌ يومض… من هنا يبدأ كلّ محترف. هذا الكتاب يأخذ بيدك من الصِّفر المطلق — لا يفترض معرفةً سابقة سوى أن تعرف القراءة والكتابة — حتى تُتقن سطر الأوامر ولِينُكس وتصير سيّدَ الآلة لا مستخدمَها.
>
> رحلةٌ في تسعة أجزاء وسبعةٍ وأربعين فصلًا: من أوّل أمرٍ تكتبه، إلى النظام والصلاحيات، ومعالجة النصوص، والأتمتة، وإدارة الأنظمة، والشبكات، والبرمجة، والأمن السيبرانيّ، وعوالم BSD وماك — بأسلوب: **مفهوم ← جرّب بنفسك ← تحدٍّ**.
>
> وفي زمن الذكاء الاصطناعيّ، لم يعُد فهم هذا الأساس ترفًا: فمن يملك ناصية الطرفية يقود أدواته، ومن يجهلها يبقى أسيرَ الاعتماد.
>
> *«العين تقرأ قبل العقل» — كتابٌ عربيٌّ صُمِّم ليكون جميلًا بقدر ما هو دقيق.*
>
> ——
> **المؤلف:** المهندس غازي السيف (أبو هيثم)
> مهندسٌ شغِف بلِينُكس والتقنية هوايةً، فكتب الكتاب الذي تمنّى وجوده يوم بدأ.
>
> مفتوح المصدر · رخصة CC BY‑ND 4.0 · github.com/Ghazi-Ai/zero-to-root

**عناصر الغلاف الخلفيّ:** النبذة أعلى، ثم سطر المؤلف، وأسفل اليسار مربّعٌ فارغ للباركود/ISBN (إن سُجّل)، وشعار «مفتوح المصدر» صغير.

---

## ٣) الغلاف الكامل الملفوف (Full Wrap) للطباعة

للطباعة النهائيّة، صمّم لوحةً واحدة: **[الغلاف الخلفيّ] — [الكعب/Spine] — [الغلاف الأماميّ]** (يمينًا إلى يسارًا للكتاب العربيّ، فالتجليد على اليمين).

- **المقاس:** كلّ وجهٍ A5 (148×210mm) + **هامش قصّ (bleed) 3mm** على الأطراف الخارجية.
- **الكعب (Spine):** الكتاب ٥٩١ صفحة؛ عرض الكعب يعتمد على وزن الورق (اسأل المطبعة، وغالبًا ~٣٠mm لورقٍ ٨٠غم). ضع عليه: **مِن الصِّفر إلى الجَذر · المهندس غازي السيف** بخطٍّ عموديّ أخضر.
- **التجليد:** غِراء (perfect binding) لأنّ الكتاب سميك.

## بعد التوليد

احفظ الملفّات هنا:
`assets/cover/cover-front.png` · `assets/cover/cover-back.png` · `assets/cover/cover-wrap.pdf`
وأرسلها لي لأدمجها في المشروع وأربطها ببناء النسخة المطبوعة.
