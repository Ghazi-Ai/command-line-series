# نظام أغلفة السلسلة · Series Cover System

> ٦ كتبٍ بهويّةٍ واحدة: نفس الزخرفة (مؤشّر طرفيةٍ تتدلّى منه جذور) والخلفية الورقيّة الدافئة، ويتميّز كلُّ كتابٍ بلونِ تمييزٍ خاصّ فوق الأخضر الأساس — فتُقرأ كعائلةٍ واحدة على الرفّ.

## قاعدة ذهبيّة
مولّدات الصور تُفسد النصّ العربيّ. **ولّد الفنّ بلا أيّ نصّ**، ثم أضِف العنوان لاحقًا بخطّ Noto Kufi Arabic. ولّد كلّ غلافٍ بلونه من الجدول أدناه.

## الأسلوب المعتمد (معتّق / botanical) — اعتُمد 2026-07-20
خلفية **عاجيّة معتّقة** (aged ivory/cream، لا أبيض ناصع) بحبيبات ورقٍ خفيفة؛ في الأعلى-الوسط **هالة خضراء صنوبريّة ناعمة** يتوسّطها **مؤشّر طرفيةٍ متوهّج** (caret أبيض-أخضر) وبجانبه `$`؛ ومن قاعدته **جذورٌ رفيعة طبيعيّة** كالأغصان بخطوطٍ يدويّة خضراء داكنة، أطرافها شعريّة، مع **نقاطٍ صغيرة بلون التمييز**. الهالة والمؤشّر ثابتان لكل الكتب؛ يتغيّر لون التمييز (النقاط + الخطّ الخلفيّ) فقط. للألوان الداكنة اجعل المؤشّر/`$` بدرجةٍ فاتحةٍ لامعة.

**{ACCENT} المحدّث:** ١ طوبيّ `#C0592B` · ٢ أزرق فاتح `#5B8FB0` · ٣ كهرمانيّ `#B07A1E` · ٤ عنّابيّ `#A5342B` · ٥ بنفسجيّ `#6B4E9C` · ٦ بَرْوَنكل `#6E7BB8`.

البرومبت الكامل (أماميّ + خلفيّ) بهذا الأسلوب محفوظٌ في محادثة الإطلاق ويُستنسخ عند الحاجة.

## الألوان الثابتة
- الأخضر الأساس: `#1F6F5C` و`#164A3E` · الورق: `#FCFBF9` · الحبر: `#26242E`

## جدول الكتب (العنوان + لون التمييز)
| # | الكتاب | العنوان (يُضاف فوق الفنّ) | لون التمييز |
|---|--------|--------------------------|-------------|
| ١ | لِينُكس | مِن الصِّفر إلى الجَذر | طوبيّ `#C0592B` |
| ٢ | ماك | ماك من الطرفية | أزرق محيطيّ `#2C6084` |
| ٣ | ويندوز | مِن الصِّفر إلى المسؤول | كهرمانيّ `#B07A1E` |
| ٤ | BSD | مِن الصِّفر إلى العِفريت | عنّابيّ `#A5342B` |
| ٥ | التمارين | دفتر التمارين | بنفسجيّ `#6B4E9C` |
| ٦ | قصّة يونِكس | حكاية يونِكس | نيليّ `#33406B` |

---

## ١) برومبت الغلاف الأماميّ (إنجليزيّ — بدّل `{ACCENT}` بلون الكتاب)

```
A refined, minimalist book-cover illustration, A5 portrait, print quality.
Central motif: a single elegant terminal command-line cursor (a small rounded block)
glowing softly in a calm dark pine-green space (#1F6F5C, #164A3E), with a subtle "$"
prompt beside it. From the cursor, fine delicate ROOTS grow downward as thin elegant
line-art — a visual pun on "root". A warm off-white paper background (#FCFBF9).
Use {ACCENT} as the single accent color for the glowing highlights and the roots' tips.
Lots of negative space, editorial Apple-like restraint, timeless, high craft, flat
vector aesthetic, soft paper texture. Absolutely NO text, NO letters, NO words anywhere.
```

القيم لكلّ كتاب (ضعها مكان `{ACCENT}`):
- الكتاب ١: `warm terracotta #C0592B`
- الكتاب ٢: `ocean steel-blue #2C6084`
- الكتاب ٣: `warm amber gold #B07A1E`
- الكتاب ٤: `deep garnet red #A5342B`
- الكتاب ٥: `soft violet #6B4E9C`
- الكتاب ٦: `deep indigo #33406B`

## ٢) برومبت الغلاف الخلفيّ (لكلّ كتاب، بنفس اللون)

```
Back cover, same A5 book, matching style: same warm off-white paper (#FCFBF9) with a
subtle continuation of the thin root-lines rising faintly from the bottom edge in deep
pine-green, kept light so text stays readable over it. A thin {ACCENT} horizontal rule
near the top. Minimal, calm, empty upper two-thirds for a text block. Flat vector,
print quality. NO text, NO letters anywhere.
```

## ٣) لقطة السلسلة (اختياريّة، للتسويق)

```
Six matching A5 book covers standing in a row on a warm neutral surface, same design
family: a glowing terminal cursor with delicate roots, dark pine-green, warm off-white
paper. Each book uses a different single accent color, left to right: terracotta,
ocean blue, amber, garnet red, violet, indigo. Cohesive series, editorial, minimal,
soft studio light. NO readable text on the covers.
```

## بعد التوليد
- أضِف العنوان بخطّ **Noto Kufi Arabic** بلون `#164A3E`، وتحته خطٌّ قصيرٌ بلون تمييز الكتاب، ثم العنوان الفرعيّ، وأسفل الغلاف **المهندس غازي السيف**.
- احفظ: `shared/covers/book-N-front.png` و`book-N-back.png`.
- أرسِلها لي لأدمجها وأربطها بالنسخ المطبوعة.
