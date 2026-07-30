// الفصل التاسع عشر: حين تكبر الصدفة
#import "/lib/book.typ": chapter, section, subsection
#import "/lib/components.typ": note, tip, warn, try-it, define, challenge, objectives

#chapter[حين تكبر الصدفة]

#objectives((
  [تتعرف إشارات انتقال المهمة من الصدفة إلى بايثون.],
  [تحافظ على واجهة الأداة أثناء نقل القلب.],
  [تستخدم pathlib وargparse وjson بدل معالجة النص يدويًا.],
  [تشغل البرامج الخارجية بوسائط منفصلة دون صدفة وسيطة.],
))

قد تبدأ الورقة بقائمة مشتريات، ثم تتحول إلى مخزون وموردين وفواتير.
لا نلوم القلم؛ لكن جدولًا منظمًا صار أداة أنسب. الصدفة ممتازة لربط
برامج، وحين تصبح معظم الأسطر محاولات لحماية النصوص وبناء هياكل
بيانات، فقد حان وقت لغة عامة.

#section[إشارات الانتقال]

- ملفات JSON متداخلة كثيرة.
- قواعد تصنيف تتكاثر وتتشارك حالة.
- اختبارات تحتاج كائنات ووحدات.
- معالجة ترميز ونصوص معقدة.
- تشغيل متوازٍ مضبوط.
- واجهة ستعمل على أنظمة متعددة.
- أخطاء اقتباس أكثر من منطق المهمة.

لا تنتقل لأن بايثون «أرقى»، ولا تبق لأن إعادة الكتابة مخيفة.

#section[ثبّت العقد أولًا]

قبل النقل دوّن:

```text
guardian plan --config PATH [--json]
guardian run  --config PATH
guardian doctor
```

وحالات الخروج ومخطط السجل. بعدها يمكن أن يتغير الداخل ويبقى
المستخدم والجدولة والاختبارات الخارجية كما هي.

#section[هيكل بايثون صغير]

```python
#!/usr/bin/env python3
from __future__ import annotations

import argparse
from pathlib import Path


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("directory", type=Path)
    return parser.parse_args()


def count_files(directory: Path) -> int:
    if not directory.is_dir():
        raise NotADirectoryError(directory)
    return sum(1 for item in directory.iterdir() if item.is_file())


def main() -> int:
    args = parse_args()
    try:
        print(count_files(args.directory))
    except NotADirectoryError as error:
        print(f"ليس مجلدًا: {error}", file=__import__("sys").stderr)
        return 3
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
```

الدالة `main` تعيد حالة خروج، و`pathlib` تتعامل مع المسار بوصفه
كائنًا، و`argparse` يبني واجهة ومساعدة.

#section[جيسون بالمكتبة القياسية]

```python
import json

with config_path.open(encoding="utf-8") as stream:
    config = json.load(stream)

with report_path.open("w", encoding="utf-8") as stream:
    json.dump(report, stream, ensure_ascii=False, indent=2)
```

لا نكتب محلل JSON ولا نهرب العربية يدويًا.

#section[شغل أمرًا بلا نص مركب]

سيئ:

```python
subprocess.run(f"some-tool {user_value}", shell=True)
```

أفضل:

```python
subprocess.run(
    ["some-tool", "--input", str(input_path)],
    check=True,
    text=True,
    capture_output=True,
)
```

القائمة تحفظ حدود الوسائط، و`check=True` يحول حالة الفشل إلى
استثناء نعالجه. لا تستخدم `shell=True` إلا لحاجة حقيقية ومحتوى
مضبوط بالكامل.

#warn[
  الانتقال إلى بايثون لا يلغي مخاطر المسارات والكتابة فوق الملفات
  والأسرار. اللغة تزيل بعض فخاخ الاقتباس، لكنها لا تختار عقدًا
  آمنًا نيابة عنك.
]

#section[نقل تدريجي]

1. ثبّت اختبارات الواجهة القديمة.
2. انقل دالة قراءة أو تصنيف.
3. قارن مخرج النسختين على البيانات نفسها.
4. أبق غلافًا صغيرًا إن كانت الجدولة تعتمد اسمًا قديمًا.
5. أزل النسخة القديمة بعد فترة معلنة.

لا تعِد كتابة كل شيء دفعة واحدة بلا خط رجوع.

#try-it[
  نفذ أداة العد ببايثون، ثم شغّل حالات الاختبار التي كتبتها لنسخة
  الصدفة. يجب أن تتطابق النتيجة وحالات الفشل وفق العقد، ولو اختلف
  النص الداخلي.
]

#tip[
  ابدأ بمكتبة بايثون القياسية. أضف اعتمادًا خارجيًا حين يوفر قيمة
  حقيقية، وسجل اسمه وإصداره وطريقة تثبيته وتحديثه.
]

#section[خلاصة الفصل]

ننتقل حين تصبح بنية البيانات والمنطق أكبر من ميزة الصدفة. نحفظ
واجهة الأداة، ونستخدم مكتبات المسار والوسائط والبيانات، ونشغل
الأوامر بقوائم لا بسلاسل، وننقل تدريجيًا مع اختبارات مقارنة.

في الفصل التالي قد يساعدنا وكيل على الكتابة أو التنفيذ؛ وسنضع
للتفويض عقدًا لا يقل صرامة عن عقد الأداة.

#challenge[
  اختر دالة من مشروعك يصعب اختبارها في الصدفة. صمم واجهتها في
  بايثون واكتب اختبارين لها، لكن لا تنقل بقية الأداة. هل قلّ
  التعقيد فعلًا أم نقلته فقط؟
]
