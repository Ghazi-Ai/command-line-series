<div align="center">

# مِن الصِّفر إلى الجَذر · From Zero to Root

**الدليل الشامل إلى سطر الأوامر ولِينُكس — من أوّل أمرٍ إلى احتراف النظام**
*The complete, beautifully‑typeset Arabic guide to the command line & Linux.*

المتطلّب الوحيد: أن تعرف القراءة والكتابة.
The only prerequisite: you can read and write.

</div>

---

## 📖 عن الكتاب

كتابٌ تعليميّ عربيّ (وإنجليزيّ) يأخذ القارئ من الصِّفر المطلق — لا معرفة سابقة بالحاسوب — حتى احتراف سطر الأوامر ولِينُكس. يُبنى كلّ فصلٍ على ثلاث: **مفهومٌ** يُشرح ببساطة، ثم **مثالٌ تجرّبه** بيدك، ثم **تحدٍّ** يرسّخ الفكرة.

المسارات: الأساسيات ← النظام والمستخدمون ← النصوص وتدفّق البيانات ← الصدفة والأتمتة ← إدارة النظام ← الشبكات ← مسار المطوّر ← الأمن السيبراني ← عوالم يونِكس الأخرى (BSD وماك).

المنهج الكامل في [`docs/OUTLINE.md`](docs/OUTLINE.md).

## 🎨 لماذا هذا الكتاب مختلف؟

«العين تقرأ قبل العقل». أغلب كتب التقنية تهمل الجمال؛ هذا الكتاب يجعله أولويّة: تنضيدٌ عربيّ رفيع (RTL)، ألوانٌ مدروسة، صناديقُ تعليميّة أنيقة، وأكوادٌ واضحة — كلّه مقاس A5 قابل للطباعة والنشر.

## 🛠️ البناء (Build)

يعتمد الكتاب على [Typst](https://typst.app). لبناء نسخة PDF:

```bash
# ثبّت Typst (بلا صلاحيات جذر)
curl -fsSL https://github.com/typst/typst/releases/latest/download/typst-x86_64-unknown-linux-musl.tar.xz \
  | tar -xJ && cp typst-*/typst ~/.local/bin/

# ثبّت الخطوط (دبيان/أوبونتو)
sudo apt install fonts-hosny-amiri fonts-jetbrains-mono fonts-ibm-plex fonts-noto-core

# ابنِ النسخة العربية
./build.sh
# أو:
typst compile src/ar/main.typ build/zero-to-root-ar.pdf --root .
```

الناتج في مجلّد `build/`. لمعاينةٍ حيّة أثناء الكتابة: `make watch-ar`.

## 📁 بنية المشروع

```
zero-to-root/
├── src/
│   ├── lib/          ← نظام التصميم (الألوان، الخطوط، القالب، الصناديق)
│   ├── ar/           ← النسخة العربية (الأصل)
│   │   ├── frontmatter/   العنوان، الحقوق، المقدمة، كيف تقرأ
│   │   ├── chapters/      الفصول موزّعة على الأجزاء
│   │   ├── appendices/    الملاحق
│   │   └── main.typ       الملفّ الرئيس
│   └── en/           ← النسخة الإنجليزية (مرآة)
├── docs/             ← المنهج، دليل الأسلوب، خارطة الطريق
├── assets/           ← الغلاف، الخطوط، الرسوم
├── tools/            ← مولّد الهيكل
└── build/            ← مخرجات PDF (غير محفوظة في Git)
```

## 📜 الرخصة

هذا العمل منشور برخصة **[CC BY‑ND 4.0](LICENSE)** (النَّسْب — بلا اشتقاق).
لك أن تقرأه وتحمّله وتشاركه وتعيد نشره **كاملًا وحرفيًّا** مع نَسْبه لمؤلّفه، حتى تجاريًّا.
ولا يُسمح بنشر نسخةٍ **معدّلة** أو مشتقّة إلا بإذنٍ خطّيّ من المؤلف. انظر [`CONTRIBUTING.md`](CONTRIBUTING.md).

## ✍️ المؤلف

**المهندس غازي السيف** (أبو هيثم) — `https://github.com/Ghazi-Ai/command-line-series/issues`

<div align="center">
<sub>صُنع بشغفٍ، وبأداة Typst · Made with passion, typeset with Typst</sub>
</div>
