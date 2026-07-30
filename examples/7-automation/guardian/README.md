# حارس صندوق الوارد

المثال المرجعي للمشروع الختامي في الكتاب السابع «مِن الأمر إلى
الأتمتة». يعمل على بيانات مختبر تحمل علامة `.guardian-lab`، ولا
يحذف ملفات. يفحص تعارض الوجهة قبل النقل ويمنع تشغيل نسختين من
الأداة، لكنه لا يقدم ضمانًا ذريًا أمام برنامج خارجي يكتب في اللحظة
نفسها.

يتطلب بايثون 3.10 أو أحدث، ويستعمل المكتبة القياسية فقط.

## الاستخدام

أنشئ المختبر وضع داخله ملفات مصطنعة، ثم انسخ ملف الإعداد:

```bash
mkdir -p "$HOME/automation-lab/inbox"
: > "$HOME/automation-lab/.guardian-lab"
cp config.example.json "$HOME/automation-lab/config.local.json"
python3 guardian.py --config "$HOME/automation-lab/config.local.json" doctor
python3 guardian.py --config "$HOME/automation-lab/config.local.json" plan
python3 guardian.py --config "$HOME/automation-lab/config.local.json" run
```

لاستعادة تشغيل، مرّر دفتره صراحة:

```bash
python3 guardian.py --config "$HOME/automation-lab/config.local.json" restore \
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
الدفعة وقبل كل نقل، لكنه لا يستطيع منع برنامج خارجي من إنشاء ملف
بين الفحص والنقل. وقد يكتمل التشغيل أو الاستعادة جزئيًا إذا وقع عطل
في نظام الملفات؛ لذلك استخدم نسخة اختبار واحتفظ بدفتر التشغيل
ونسخة احتياطية مستقلة.

## الأنظمة المختبرة

| النظام | الحالة |
|---|---|
| لينكس مع بايثون 3.10 أو أحدث | الاختبارات الآلية ناجحة |
| ماك | لم تُنفّذ الاختبارات عليه في هذه الجولة |
| ويندوز | لم تُنفّذ الاختبارات عليه في هذه الجولة |
