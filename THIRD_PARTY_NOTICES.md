# إشعارات الأطراف الثالثة

لا تغيّر تراخيص المشروع رخص المواد الآتية. تبقى كل مادة تحت رخصة
صاحبها الأصلي، وتنطبق الإشعارات التالية على الملفات المنسوخة أو
المضمّنة في التوزيع.

## الخطوط

| العائلة | الملفات | الرخصة والمصدر |
|---|---|---|
| IBM Plex Sans وIBM Plex Sans Arabic | `fonts/IBMPlexSans*.ttf` و`fonts/IBMPlexSansArabic*.ttf` | SIL Open Font License 1.1؛ © IBM Corp.، والاسم المحجوز “Plex”. [المصدر الرسمي](https://github.com/IBM/plex/blob/master/LICENSE.txt) |
| Noto Kufi Arabic | `fonts/NotoKufiArabic*.ttf` | SIL Open Font License 1.1؛ © The Noto Project Authors. [ملف الرخصة](https://github.com/google/fonts/blob/main/ofl/notokufiarabic/OFL.txt) |
| JetBrains Mono | `fonts/JetBrainsMono*.ttf` | SIL Open Font License 1.1؛ © The JetBrains Mono Project Authors. [ملف الرخصة](https://github.com/JetBrains/JetBrainsMono/blob/master/OFL.txt) |
| DejaVu Sans | `fonts/DejaVuSans*.ttf` | رخصة DejaVu المركبة من شروط Bitstream Vera وإشعارات المساهمات اللاحقة؛ وليست رخصة OFL. [النص الرسمي](https://dejavu-fonts.github.io/License.html) |

النص الكامل لـOFL 1.1 مع إشعارات العائلات الثلاث محفوظ في
`LICENSES/OFL-1.1-FONTS.txt`، ونص DejaVu في
`LICENSES/DEJAVU-FONTS.txt`.

## PDF.js

تنزّل عملية نشر قارئ الويب PDF.js، الإصدار المحدد داخل
`.github/workflows/deploy-pages.yml`، من مشروع Mozilla الرسمي. PDF.js
مرخّص بموجب Apache License 2.0. يحفظ سير العمل ملف الرخصة مع ملفات
النشر ويتحقق من قيمة SHA-256 للحزمة.

- المصدر: <https://github.com/mozilla/pdf.js>
- الرخصة: <https://github.com/mozilla/pdf.js/blob/master/LICENSE>
- نص Apache 2.0 الرسمي: <https://www.apache.org/licenses/LICENSE-2.0.txt>

## تبعيات البناء والنشر

تُستعمل Typst وPython وGitHub Actions وأدوات النظام لبناء المشروع.
لا تصبح هذه الأدوات جزءًا من المحتوى المرخّص للمشروع، وتبقى تحت
تراخيصها الأصلية. كذلك تبقى إجراءات GitHub Actions المشار إليها في
ملفات سير العمل تحت تراخيص مستودعاتها.

## الأصول البصرية

وثّق صاحب المشروع أن جميع صور الأغلفة وُلّدت بالكامل عبر ChatGPT
Images من OpenAI، من أوصاف نصية أصلية ودون مدخلات بصرية خارجية، ثم
أضيفت النصوص والهوية والتنسيق النهائي بأداة Typst. تبقى مسارات الصور
المحددة في `LICENSES/README.md` مستثناة من CC BY-SA 4.0، فلا تمنح
رخصة المحتوى إذنًا تلقائيًا بإعادة استخدامها. يسجل
[`docs/COVER-RIGHTS-AUDIT.md`](docs/COVER-RIGHTS-AUDIT.md) المصدر
وحدود الحكم، من دون ادعاء مراجعة قانونية أو ضمان الحصرية.
