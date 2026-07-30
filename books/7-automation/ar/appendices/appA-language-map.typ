#import "/lib/book.typ": appendix, section, subsection
#import "/lib/components.typ": note, warn

#appendix("أ", "خريطة الألسنة")

هذا الملحق جسر مفاهيم، لا جدول ترجمة حرفية. كل لغة لها طريقتها،
والمهم أن ترى القرار نفسه وراء الصياغة.

#section[بنية الأداة]

| المفهوم | باش/زِد شِل | باورشِل | بايثون |
|---|---|---|---|
| الوسائط | `$1` و`getopts` | `param(...)` | `argparse` |
| متغير | `name=value` | `$Name = value` | `name = value` |
| شرط | `if ...; then` | `if (...) {}` | `if ...:` |
| حلقة | `for` و`while` | `foreach` | `for` و`while` |
| دالة | `name() {}` | `function Name {}` | `def name():` |
| حالة خروج | `exit N` | `exit N` | `return N` من `main` |
| خطأ | `>&2` | `Write-Error` | `print(..., file=sys.stderr)` |
| جيسون (`JSON`) | `jq` | `ConvertFrom-Json` | `json` |
| مسار | نص مقتبس | `Join-Path` و`-LiteralPath` | `pathlib.Path` |

#section[فحص المسارات]

#subsection[ملف عادي]

```bash
[ -f "$path" ]
```

```powershell
Test-Path -LiteralPath $Path -PathType Leaf
```

```python
path.is_file()
```

#subsection[مجلد]

```bash
[ -d "$path" ]
```

```powershell
Test-Path -LiteralPath $Path -PathType Container
```

```python
path.is_dir()
```

#section[إخراج منظم]

باش يربط أدوات صغيرة، ولذلك نستعمل `jq` لإنشاء جيسون صحيح:

```bash
jq -n --arg action "move" --arg source "$file" \
  '{action: $action, source: $source}'
```

باورشِل يحول كائنًا:

```powershell
[ordered]@{ action = "move"; source = $File } |
  ConvertTo-Json -Compress
```

وبايثون:

```python
json.dumps(
    {"action": "move", "source": str(path)},
    ensure_ascii=False,
)
```

#section[تشغيل برنامج خارجي]

في باش تكون الوسائط منفصلة بالاقتباس أو المصفوفة:

```bash
command_name --input "$path"
```

في باورشِل:

```powershell
& $CommandName --input $Path
if ($LASTEXITCODE -ne 0) { throw "فشل البرنامج" }
```

وفي بايثون:

```python
subprocess.run(
    [command_name, "--input", str(path)],
    check=True,
)
```

#warn[
  التشابه في الجدول لا يعني تطابق السلوك. اختبر حالات الفراغ
  والترميز والخطأ على اللغة والنظام الفعليين.
]

#note[
  إذا وجدت نفسك تترجم كل سطر من لغة إلى أخرى، فتوقف واسأل عن
  المفهوم والعقد. النسخة الطبيعية في اللغة خير من تقليد تركيب لغة
  أخرى.
]
