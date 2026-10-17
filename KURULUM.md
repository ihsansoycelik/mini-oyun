# Kurulum — Arkadaş için (tek seferlik)

Bu dosya, Git/GitHub bilmeyen arkadaşın içindir. Kurulumun çoğunu Claude Code
onun bilgisayarında yapar.

## 0. Ön koşullar

- Bilgisayarında **Claude Code** kurulu olmalı.
- İnternet bağlantısı olmalı.
- İhsan'ın GitHub kullanıcı adı: `ihsansoycelik`
- Repo: `https://github.com/ihsansoycelik/mini-oyun`

## 1. İhsan'ın önceden yapması gereken

1. GitHub'da `ihsansoycelik/mini-oyun` reposunu oluşturur (bu makinede yapıldı).
2. Arkadaşın GitHub kullanıcı adını öğrenir.
3. Repo → Settings → Collaborators → Add people → arkadaşın kullanıcı adı →
   **Write**.
4. `ARKADAS-BASLANGIC.md` dosyasındaki mesajı arkadaşına gönderir.

## 2. Arkadaşın yapması gereken

1. Claude Code'u aç.
2. `ARKADAS-BASLANGIC.md` içindeki mesajı kopyalayıp Claude Code'a yapıştır.
3. Claude'un söylediği adımları izle. Tarayıcıda GitHub hesabı açmak, daveti
   kabul etmek ve GitHub'a giriş yapmak için senden yardım isteyecek.
4. Claude kurulumu bitirince "Kurulum tamam mı?" diye sor.

## 3. Claude Code ne yapacak?

1. Git kurulu mu kontrol eder; değilse kurar.
2. GitHub hesabı açman için tarayıcıyı açar.
3. İhsan'a kullanıcı adını göndermene yardım eder; İhsan seni davet eder.
4. Daveti kabul edersin.
5. GitHub CLI (`gh`) kurulur; `gh auth login --git-protocol https --web` ile
   GitHub'a giriş yaparsın (HTTPS seçilmesi önemli).
6. Repoyu HTTPS ile klonlar.
7. Şu yerel ayarları yapar:
   - `git config user.name "<GitHub kullanıcı adın>"`
   - `git config user.email "<GitHub kullanıcı adın>@users.noreply.github.com"`
   - `git config --local claude.role arkadas`
   - `git config --local core.hooksPath .githooks`
8. `arkadas` branch'ini oluşturur: `git checkout -b arkadas`
9. `git push -u origin arkadas` ile branch'i GitHub'a gönderir.
10. `KURULUM.md` dosyasını okuyup aşağıdaki kontrol listesini tamamlar.

## 4. Kurulum bitti mi? Kontrol listesi

Claude'a şunu sor: **"Kurulum tamam mı? Tek tek kontrol et."**

- [ ] `git branch --show-current` → `arkadas`
- [ ] `git config --local claude.role` → `arkadas`
- [ ] `git config --local core.hooksPath` → `.githooks`
- [ ] `git remote -v` → `origin https://github.com/ihsansoycelik/mini-oyun.git`
- [ ] `git log --oneline -1` → en az bir commit var
- [ ] `git status` → `working tree clean`
- [ ] `git push --dry-run origin arkadas` → hata yok
- [ ] `git push --dry-run origin HEAD:main` → "main branch'ine push engellendi"
      hatası vermeli (bu beklenen ve istenen sonuçtur; gerçek push yapılmaz)
- [ ] GitHub'da `arkadas` branch'i görünüyor (İhsan kontrol edebilir)

## 5. Günlük kullanım

1. Claude Code'u aç.
2. Proje klasörünü seç (adı `mini-oyun`).
3. Ne istediğini normal Türkçe yaz:
   - "Oyuna zıplama ekle."
   - "Skoru ekranın sağ üstüne taşı."
   - "Altınlar çok hızlı kayboluyor, yavaşlat."
   - "Bir hata var: ..."
4. Claude işi bitirince kendisi commit ve push yapar. Sen hiçbir Git komutu yazma.
5. Claude "İhsan'a haber ver" derse, mesajı/ekran görüntüsünü İhsan'a gönder.

## 6. Altın kurallar

- Git komutu yazma; Claude yazsın.
- `main` branch'i hakkında bir şey söyleme; Claude kuralları biliyor.
- GitHub'da Settings, Collaborators, Branches gibi yerlere dokunma.
- Bir şey bozulursa panik yapma; Claude'a "son iyi hale dönmek istiyorum,
  bana basitçe anlat" de ve İhsan'a haber ver.
- Claude'a "commit etme" demedikçe otomatik kayıt açık kalır.

## 7. Sık sorunlar

| Sorun | Ne yapmalı |
|---|---|
| `gh: command not found` | Claude'a "GitHub CLI kurulu değil, kur" de. |
| `Permission denied (publickey)` | Claude'a "Repoyu HTTPS ile klonla" de. |
| `Authentication failed` | Claude'a "GitHub girişimi yenile" de; `gh auth login --git-protocol https --web` tekrar çalışır. |
| `Push rejected` | Claude'a "push reddedildi, bana basitçe anlat, İhsan'a soracağım" de. |
| Claude "hook" onayı istiyor | Onayla; bu, otomatik kaydın çalışması için gerekli. |
| Otomatik commit olmuyor | Claude'a "proje hook'larını kontrol et" de; İhsan'a haber ver. |
