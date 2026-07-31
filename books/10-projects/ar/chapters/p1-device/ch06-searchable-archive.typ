// المشروع الرابع: أرشيف يمكن سؤاله
#import "/lib/book.typ": chapter, section, subsection
#import "/lib/components.typ": note, tip, warn, try-it, define, challenge, objectives, session

#chapter[المشروع 4: أرشيف يمكن سؤاله]

#objectives((
  [تفهرس ملفات نصية في قاعدة إس كيو لايت (SQLite) محلية.],
  [تفصل مسار الوثيقة وعنوانها ومحتواها في بنية قابلة للتحديث.],
  [تسأل الأرشيف من الطرفية وتفهم حدود النتيجة.],
  [تعيد بناء الفهرس من المصادر بدل معاملته أصلًا وحيدًا.],
))

بعد أشهر من كتابة الملاحظات، تعرف أنك شرحت المشكلة من قبل ولا
تعرف أين. البحث النصي المباشر ممتاز للبداية، لكننا سنبني فهرسًا
محليًا بقاعدة إس كيو لايت، وهي قاعدة بيانات مدمجة لا تحتاج خادمًا.

#section[ابدأ بالأداة الأبسط]

قبل الشيفرة جرّب:

```bash
rg -n -i 'نسخة احتياطية|استعادة' input/
```

إن أجاب `rg` عن حاجتك فلا تخفِه خلف نظام أكبر. مشروع الفهرس مفيد
حين تريد نتيجة منظمة، أو تحديثًا متكررًا، أو واجهة تستطيع أداة أخرى
قراءتها.

#define("الفهرس المشتق", [
  بنية يمكن حذفها وإعادة إنشائها من المصادر. لا تصبح النسخة الوحيدة
  من المحتوى، ولا تُعدّل يدويًا بدل تعديل المصدر.
])

#section[العينة والتسليم]

```text
04-searchable-archive/
├── input/notes/*.md
├── tools/archive.py
├── output/archive.db
└── RUNBOOK.md
```

أنشئ ثلاث ملاحظات عربية مصطنعة، وضع عنوانًا في أول سطر يبدأ بـ`#`.

#section[ابنِ قاعدة قابلة لإعادة البناء]

أنشئ `tools/archive.py`:

```python
from __future__ import annotations

import argparse
import sqlite3
from pathlib import Path

root = Path(__file__).resolve().parents[1]
source = root / "input" / "notes"
db_path = root / "output" / "archive.db"

parser = argparse.ArgumentParser()
sub = parser.add_subparsers(dest="command", required=True)
sub.add_parser("build")
find = sub.add_parser("find")
find.add_argument("query")
args = parser.parse_args()

db_path.parent.mkdir(exist_ok=True)
con = sqlite3.connect(db_path)
con.execute("""
CREATE TABLE IF NOT EXISTS documents (
  path TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL
)
""")

if args.command == "build":
    seen = set()
    for path in sorted(source.rglob("*.md")):
        body = path.read_text(encoding="utf-8")
        first = body.splitlines()[0] if body.splitlines() else path.stem
        title = first.removeprefix("#").strip() or path.stem
        rel = path.relative_to(source).as_posix()
        seen.add(rel)
        con.execute(
            "INSERT INTO documents(path,title,body) VALUES(?,?,?) "
            "ON CONFLICT(path) DO UPDATE SET title=excluded.title, body=excluded.body",
            (rel, title, body),
        )
    for (old,) in con.execute("SELECT path FROM documents").fetchall():
        if old not in seen:
            con.execute("DELETE FROM documents WHERE path=?", (old,))
    con.commit()
    print(f"indexed={len(seen)}")

elif args.command == "find":
    pattern = f"%{args.query}%"
    rows = con.execute(
        "SELECT path,title FROM documents "
        "WHERE title LIKE ? OR body LIKE ? ORDER BY path",
        (pattern, pattern),
    ).fetchall()
    for path, title in rows:
        print(f"{path}\t{title}")
    raise SystemExit(0 if rows else 1)
```

استعملنا معاملات `?` بدل لصق عبارة البحث في SQL. هذا يمنع الحروف
الخاصة من تحويل السؤال إلى جزء من الاستعلام.

#section[ابنِ واسأل]

```bash
python3 tools/archive.py build
python3 tools/archive.py find استعادة
```

جرّب عبارة لا توجد. اخترنا رمز خروج `1` كي يستطيع سكربت آخر تمييز
«لا نتيجة» من «ظهرت نتائج». وثق ذلك في RUNBOOK.

#session("python3 tools/archive.py find استعادة", output: "backup.md\tتمرين الاستعادة")

#section[العربية والبحث]

المقارنة البسيطة في SQLite لا تفهم كل أشكال العربية. «مسؤول» قد
لا تطابق «مسئول»، والتشكيل يغير تسلسل المحارف. لا ندعي أننا بنينا
محرك بحث لغويًا. يمكن لاحقًا إضافة نسخة منقحة للفهرسة مع إبقاء
النص الأصلي للعرض.

#note[
  التطبيع اللغوي قرار بحث، لا «تنظيف» محايد. إزالة الهمزات أو
  التشكيل قد تحسن الاستدعاء وتزيد نتائج غير مقصودة. احتفظ بالأصل،
  ووثق ما تغير في حقل منفصل.
]

#section[اختبر الحذف والتحديث]

1. ابنِ الفهرس.
2. غير عنوان ملاحظة وأعد البناء؛ ينبغي أن تتحدث.
3. احذف ملاحظة من `input` وأعد البناء؛ ينبغي أن تختفي من القاعدة.
4. احذف `output/archive.db` وأعد البناء؛ ينبغي أن تعود النتائج.

هذا الاختبار الأخير يثبت أن القاعدة مشتقة وليست الأصل الوحيد.

#section[بيانات لا تفهرسها]

لا تضع في `input`:

- نسخة من مدير كلمات المرور.
- سجل محادثة يحوي رموز وصول.
- مفاتيح خاصة أو ملفات تعريف ارتباط.
- ملاحظات عملاء بلا غرض وإذن ومدة احتفاظ.

#warn[
  كون الفهرس محليًا لا يجعله بلا أثر. قاعدة واحدة تجمع محتوى ملفات
  كثيرة، وقد تسهل كشفها إن نُسخت أو فُتحت لغير صاحبها. طبق أقل جمع
  وصلاحيات مناسبة ونسخًا مشفرًا عند الحاجة.
]

#try-it[
  أضف أمر `stats` يعرض عدد الوثائق ومجموع محارفها وتاريخ بناء
  مسجلًا في جدول metadata. لا تجعل تاريخ البناء جزءًا من اختبار
  تطابق المحتوى.
]

#section[اختبارات القبول]

- [ ] يفهرس البرنامج ملفات Markdown فقط من جذر محدد.
- [ ] لا يبني SQL بلصق مدخل المستخدم.
- [ ] يحدّث الوثيقة ويحذف السجل الغائب عند إعادة البناء.
- [ ] يمكن حذف القاعدة وإعادتها من المصادر.
- [ ] يميز رمز الخروج بين وجود نتيجة وغيابها.
- [ ] توثق حدود البحث العربي والبيانات الممنوعة.

#section[ما تعلمناه]

بأربعة مشروعات أصبح الجهاز معروفًا، والمكان منظمًا، والدفعات قابلة
للتتبع، والملاحظات قابلة للسؤال. الآن ننتقل من ترتيب العمل إلى
حمايته: نسخة لا تثبت قيمتها حتى تعود منها البيانات.

#challenge[
  أضف إخراج JSON اختياريًا للنتائج، ثم اكتب اختبارًا يمرر عبارة
  تحتوي علامة اقتباس مفردة. يجب أن يعمل بلا خطأ وألا يغير بنية
  قاعدة البيانات.
]
