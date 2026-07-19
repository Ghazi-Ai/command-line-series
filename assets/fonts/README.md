# الخطوط · Fonts

الكتاب يستعمل خطوطًا حرّة مفتوحة. لا نحفظها في المستودع؛ ثبّتها من مستودع نظامك.

| الدور | الخطّ | حزمة دبيان/أوبونتو |
|-------|-------|---------------------|
| متن العربية | IBM Plex Sans Arabic | `fonts-ibm-plex` |
| عناوين العربية | Noto Kufi Arabic | `fonts-noto-core` |
| بديل كلاسيكيّ | Amiri | `fonts-hosny-amiri` |
| الأكواد | JetBrains Mono | `fonts-jetbrains-mono` |
| اللاتينيّ | IBM Plex Sans / Serif | `fonts-ibm-plex` |

## التثبيت (دبيان/أوبونتو)

```bash
sudo apt install fonts-ibm-plex fonts-noto-core fonts-hosny-amiri fonts-jetbrains-mono
fc-cache -f
```

## على أرش

```bash
sudo pacman -S ttf-ibm-plex noto-fonts ttf-jetbrains-mono
# Amiri من AUR: ttf-amiri
```

## على فيدورا

```bash
sudo dnf install ibm-plex-fonts-all google-noto-fonts-common jetbrains-mono-fonts amiri-fonts
```

## تبديل الخطّ

كلّ أسماء الخطوط معرّفة في مكانٍ واحد: [`src/lib/theme.typ`](../../src/lib/theme.typ) في قاموس `FONT`. غيّرها هناك، يتغيّر الكتاب كله. مثلًا لطابعٍ كتابيّ كلاسيكيّ، بدّل `bodyAr` إلى `"Amiri"`.
