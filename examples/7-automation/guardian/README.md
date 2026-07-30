# حارس صندوق الوارد

المثال المرجعي للمشروع الختامي في الكتاب السابع «مِن الأمر إلى
الأتمتة». يعمل على بيانات مختبر فقط، ولا يحذف ملفات ولا يكتب فوق
وجهة موجودة.

يتطلب بايثون 3.10 أو أحدث، ويستعمل المكتبة القياسية فقط.

## الاستخدام

أنشئ `~/automation-lab/inbox` وضع داخله ملفات مصطنعة، ثم:

```bash
python3 guardian.py --config config.example.json doctor
python3 guardian.py --config config.example.json plan
python3 guardian.py --config config.example.json run
```

لاستعادة تشغيل، مرّر دفتره صراحة:

```bash
python3 guardian.py --config config.example.json restore \
  --journal ~/automation-lab/logs/journal-ID.jsonl
```

## الاختبارات

```bash
python3 -m unittest -v test_guardian.py
```

الشيفرة الأصلية في هذا المثال تحت رخصة MIT وفق
`LICENSES/README.md`.

## حدود المثال

هذا مثال تعليمي محلي، لا خدمة إنتاجية. يعيد فحص التعارض قبل بدء
الدفعة، لكنه لا يستطيع منع برنامج خارجي من إنشاء ملف في اللحظة نفسها.
وقد تكتمل الاستعادة جزئيًا إذا وقع عطل في نظام الملفات أثناءها؛ لذلك
استخدم نسخة اختبار واحتفظ بدفتر التشغيل ونسخة احتياطية مستقلة.
