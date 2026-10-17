# Mini Oyun

İki kişinin Claude Code ile birlikte geliştirdiği mini oyun.

## Çalıştırma

`index.html` dosyasını tarayıcıda aç. Ya da proje klasöründe:

```bash
python3 -m http.server 8000
```

Sonra tarayıcıda `http://localhost:8000` adresini aç.

## Ortak çalışma rehberi

- **CLAUDE.md** — Agent'ların uyacağı çalışma kuralları (branch düzeni, otomatik
  commit, yasaklar).
- **KURULUM.md** — Arkadaşın bilgisayarındaki tek seferlik kurulum.
- **ARKADAS-BASLANGIC.md** — Arkadaşına kopyalayıp göndereceğin hazır mesaj.
- **YONETIM.md** — İhsan için merge, yayınlama ve kontrol listesi.

## Branch düzeni

| Branch | Amaç |
|---|---|
| `main` | Yayınlanan sürüm; sadece İhsan merge eder |
| `ihsan` | İhsan'ın çalışma branch'i |
| `arkadas` | Arkadaşın çalışma branch'i; agent otomatik commit + push yapar |
