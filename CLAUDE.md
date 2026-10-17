# Mini Oyun — Ortak Çalışma Kuralları

Bu repo, iki kişinin birlikte geliştirdiği bir mini oyun projesidir.

| Kişi | GitHub | Branch | Rol |
|---|---|---|---|
| İhsan | `ihsansoycelik` | `ihsan` | Proje sahibi; merge ve yayın onun kontrolünde |
| Arkadaş | (arkadaşın hesabı) | `arkadas` | İkinci geliştirici; Git/GitHub bilmiyor |

> **Her oturumun başında önce rolünü belirle.** Aşağıdaki 1. bölümü uygula.

## 1. Rolünü belirle

Terminalde şunu çalıştır:

```bash
git config --local claude.role
```

- Çıktı `arkadas` ise → **ARKADAŞ MODU** (bölüm 3).
- Çıktı `ihsan` ise → **İHSAN MODU** (bölüm 4).
- Çıktı boşsa:
  - `git branch --show-current` çıktısı `arkadas` ise → **ARKADAŞ MODU**.
  - Değilse → **İHSAN MODU**. Kullanıcıya bir kez şunu çalıştırmasını söyle:
    `git config --local claude.role ihsan`

Rolünü kendi kendine değiştirme. `claude.role` ayarını silme veya değiştirme.

## 2. Branch kuralları (herkes için)

| Branch | Kim çalışır? | Kural |
|---|---|---|
| `main` | Kimse doğrudan çalışmaz | Sadece İhsan, açıkça istendiğinde merge/push eder |
| `arkadas` | Arkadaş | Sadece arkadaş çalışır ve pushlar |
| `ihsan` | İhsan | Sadece İhsan çalışır ve pushlar |

- `main` branch'ine **asla** doğrudan commit atma. İhsan modunda bile main'e
  commit/push ancak kullanıcı açıkça "main'e merge et ve pushla" derse yapılır.
- Başka birinin branch'ine commit/push yapma.
- Arkadaş modunda çalışma branch'i her zaman `arkadas` olmalı. Değilse çalışmaya
  başlamadan `git checkout arkadas` yap.
- Branch silme, branch yeniden adlandırma, tag/release oluşturma yok.

### 2.1 Yerel zorlama (arkadaş klonunda)

Arkadaş modunda bu kurallar sadece tavsiye değildir; hook'larla zorlanır:

- `pre-commit`: `arkadas` dışındaki branch'lerde commit engellenir.
- `pre-merge-commit`: `main`'de merge commit'i engellenir.
- `pre-push`: `main`'e push ve force push engellenir.
- Stop hook: oturum biterken değişiklikler `arkadas` branch'ine taşınır,
  commit edilir ve pushlanır.

Bu hook'ları devre dışı bırakma; `.githooks` ve `.claude` ayarlarını değiştirme.

## 3. ARKADAŞ MODU

Kullanıcı Git/GitHub bilmiyor. Ona Git komutu yazdırma, Git terimi kullanma.
Tüm Git işlerini sen yap.

### 3.1 Oturum başında

1. `git fetch origin`
2. `git merge origin/main`
   - Çakışma (conflict) çıkarsa: `git merge --abort` çalıştır. Kullanıcıya sade
     dille "İhsan'ın değişiklikleriyle bir çakışma var; ben bunu kendi başıma
     çözmeyeceğim, İhsan'a haber ver" de ve dur. Çakışmayı çözmeye çalışma.
3. `.claude/PUSH-HATASI.txt` dosyası varsa kullanıcıya söyle: "Önceki
   değişiklikler GitHub'a gönderilememiş; İhsan'a haber vermeliyiz."
4. `git log origin/arkadas..HEAD --oneline` ile gönderilmemiş commit var mı bak.
   Varsa `git push origin arkadas` ile gönder.

### 3.2 Her görev tamamlandığında (otomatik — kullanıcı sormadan)

Bir görev/iş tamamlandığında, kullanıcı "commit et" demese bile:

1. Mümkünse oyunun hâlâ çalıştığını kontrol et (tarayıcıda aç veya basit bir
   sözdizimi kontrolü yap).
2. `git status` ve `git diff` ile ne değiştiğini gör.
3. Değişikliklerde `.env`, şifre, API anahtarı, token, büyük medya dosyası var mı
   kontrol et. Varsa commit etme; kullanıcıya sade dille söyle.
4. `git add -A`
5. Kısa, açıklayıcı **Türkçe** commit mesajıyla commit at:
   - İyi: `Zıplama hareketi eklendi`, `Altın toplama ve skor eklendi`,
     `Düşman çarpışma hatası düzeltildi`
   - Kötü: `update`, `değişiklik`, `fix`, `asdf`
   - Komut: `git commit -m "<mesaj>"`
6. `git push origin arkadas`
7. Kullanıcıya **tek cümlelik** basit özet ver:
   "Zıplama hareketini ekledim ve kaydettim." Git terimi kullanma.

**Önemli:** Her küçük dosya değişikliğinde değil, her anlamlı görev bitince
commit at. Ama işi yarım bırakıp kullanıcıya soru soracaksan, o ana kadarki
değişiklikleri de commit et (iş kaybolmasın).

### 3.3 Hata olursa

- Push reddedilirse, giriş (authentication) hatası olursa veya beklenmedik bir
  Git hatası çıkarsa: kendi başına karmaşık çözümler deneme. `git status`
  çıktısını kullanıcıya sade dille anlat ve "İhsan'a söyle" de.
- Çakışma çıkarsa çözme; `git merge --abort` yapıp haber ver.
- Bir dosya çok büyükse veya gizli bilgi içeriyorsa commit etme; kullanıcıya söyle.
- Emin olmadığın bir Git komutunu çalıştırma. Önce `git status` ile durumu gör.

### 3.4 Arkadaş modunda yasaklar

- `git push --force`, `git push -f`, `git push --force-with-lease`
- `git reset --hard`
- `git rebase`
- `git clean -fd`
- `git branch -D` / `git branch -d`
- `git commit --no-verify`, `git push --no-verify`
- `main` branch'ine commit/push
- `arkadas` dışında bir branch'e checkout
- GitHub ayarlarını (Settings, Collaborators, Branches, Actions) değiştirme
- Repo'yu silme, arşivleme, görünürlüğünü değiştirme
- `.claude/`, `.githooks/`, `.gitignore`, `CLAUDE.md` dosyalarını kullanıcı
  istemeden değiştirme
- `git config --local core.hooksPath` veya `git config --local claude.role`
  ayarlarını değiştirme / devre dışı bırakma

## 4. İHSAN MODU

Kullanıcı Git biliyor. Otomatik commit **yapma**; sadece kullanıcı açıkça
"commit et" dediğinde commit at. Otomatik push yapma; push için de açık istek bekle.

- Çalışma branch'i: `ihsan`.
- `main`'e doğrudan commit/push sadece kullanıcı açıkça söylediğinde.
- Arkadaşın işini almak için: `git fetch origin`, `git merge origin/arkadas`.
- Çakışma çıkarsa kullanıcıya göster; onay almadan çözme.
- Push öncesi oyunu çalıştırıp test et.
- Kullanıcı isterse `arkadas` → `ihsan` → `main` merge ve push işlemlerini
  yapabilirsin.
- Arkadaşın branch'ine (`arkadas`) doğrudan commit/push yapma; orası arkadaşın
  alanı.

## 5. Dosya bölüşümü (çakışmayı azaltmak için)

Aynı dosyayı iki kişi aynı anda düzenlememeye çalışın.

- **Arkadaş**: `src/oyun/` — oyun mekaniği, karakter, fizik, puan, düşmanlar.
- **İhsan**: `src/arayuz/`, `index.html` — menü, HUD, stiller, sayfa yapısı.
- **Ortak dosyalar**: `CLAUDE.md`, `.gitignore`, `.gitattributes`, `.claude/`,
  `.githooks/`, `README.md`, `KURULUM.md`, `YONETIM.md`.
  Bunlarda değişiklik gerekiyorsa önce kullanıcıya sor.

Yeni bir klasör/dosya eklerken hangi tarafın alanı olduğunu bu bölüme göre
belirle. Emin değilsen kullanıcıya sor.

## 6. Commit mesajı kuralı (her iki mod)

- Türkçe, kısa ve ne yapıldığını anlatan bir mesaj.
- Gerekirse ikinci satırda ayrıntı ver.
- Aynı commit'te birden fazla ilgisiz iş yapma; mümkünse ayır.
- Commit'i geri almak gerekirse `git revert` kullan; geçmişi yeniden yazma.

## 7. Güvenlik

- `.env`, `.env.*`, `*.pem`, `*.key`, `id_rsa*`, `*.p12` dosyalarını asla commit
  etme.
- API anahtarı, şifre, token içeren kodu commit etme.
- `node_modules/`, `dist/`, `build/`, büyük medya dosyalarını commit etme.
- Şüphelendiğin dosya varsa commit etme ve kullanıcıya söyle.
- GitHub'da bir şeyin görünürlüğünü değiştirme.
