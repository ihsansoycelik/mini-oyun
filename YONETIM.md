# Yönetim — İhsan için

## 1. Bu makinede yapılan hazırlık

- Yerel repo: `/home/ubuntu/game_dev/mini-oyun`
- GitHub repo: `https://github.com/ihsansoycelik/mini-oyun` (private)
- Branch'ler: `main` (yayın), `ihsan` (senin çalışma branch'in), `arkadas` (arkadaş)
- Yerel ayarlar:
  - `git config --local claude.role ihsan`
  - `git config --local core.hooksPath .githooks`
- `.githooks/pre-push`: arkadaş `main`'e push edemez; force push engellenir.
- `.claude/hooks/otomatik-kaydet.sh`: arkadaşın oturumu bittiğinde commit/push
  güvenlik ağı.
- `main` ve `ihsan` GitHub'a push edildi.

## 2. Arkadaşını davet et

Arkadaşın GitHub hesabını açıp kullanıcı adını sana söyledikten sonra:

```bash
gh api -X PUT repos/ihsansoycelik/mini-oyun/collaborators/ARKADAS_KULLANICI_ADI -f permission=push
```

veya GitHub'da:

**Repo → Settings → Collaborators → Add people → kullanıcı adı → Write**

Arkadaşın daveti kabul etsin. Sonra `ARKADAS-BASLANGIC.md` dosyasını ona gönder.

## 3. Branch koruması hakkında

GitHub Free planında **özel** repolarda sunucu tarafı branch protection yok.
Bu yüzden şu an:

- Arkadaşın agent'ı `CLAUDE.md` kurallarıyla sadece `arkadas` branch'inde çalışır.
- Arkadaşın klonunda `.githooks/pre-commit` `arkadas` dışındaki branch'lerde
  commit'i engeller.
- `.githooks/pre-merge-commit` `main`'de merge commit'ini engeller.
- `.githooks/pre-push` `main`'e push'u ve force push'u engeller.
- Stop hook'u arkadaş yanlış branch'te kaldıysa değişiklikleri `arkadas`'a taşır,
  commit eder ve pushlar.
- `.claude/settings.json` tehlikeli git komutlarını reddeder.

Daha güçlü bir garanti istersen:

1. Repoyu **public** yap → ücretsiz branch protection açılır; veya
2. GitHub Pro al → özel repoda branch protection açılır; veya
3. Arkadaşına **Read** yetkisi verip fork + PR akışına geç.

## 4. Günlük akış

### Kendi işin

```bash
git checkout ihsan
# Claude ile çalış
git status
git add -A
git commit -m "açıklayıcı mesaj"
git push origin ihsan
```

Senin agent'ın otomatik commit yapmaz; commit'i sen (veya açıkça söylediğinde
agent) atar.

### Arkadaşın işini alma

```bash
git fetch origin
git checkout ihsan
git merge origin/arkadas
# oyunu çalıştır, test et
git push origin ihsan
```

Çakışma çıkarsa çözmeden önce dur ve dosyalara bak. Çözdükten sonra mutlaka test et.

Claude'a yaptırmak için:

> "origin/arkadas branch'indeki son değişiklikleri ihsan branch'ime merge et.
> Çakışma varsa bana göster, kendi başına çözme. Sonra oyunu çalıştırıp test et."

### Yayınlama (main)

```bash
git checkout main
git merge ihsan
git push origin main
git checkout ihsan
git merge origin/main
git push origin ihsan
```

Claude'a:

> "ihsan branch'ini main'e merge et ve pushla. Önce oyunu çalıştırıp test et;
> sorun varsa dur ve bana rapor ver."

### Arkadaşın commit'lerini inceleme

```bash
git fetch origin
git log --oneline --graph ihsan..origin/arkadas
git diff ihsan...origin/arkadas
```

## 5. Bir şey bozulursa

- Panik yok: `arkadas` branch'i uzakta durur.
- Bozuk bir commit'i geçmişi silmeden geri al:

```bash
git checkout ihsan
git revert <commit-hash>
git push origin ihsan
```

- `git push --force` veya `git reset --hard` ile arkadaşının branch'ini ezme.
- Arkadaşının agent'ı çakışma/hatada durup sana haber vermek üzere kurulu.
- Sorun çözülene kadar arkadaştan yeni değişiklik istemeyebilirsin.

## 6. İlk kontrol listesi

- [ ] GitHub'da repo private ve `main` varsayılan branch.
- [ ] `origin/ihsan` branch'i var.
- [ ] Arkadaşın GitHub davetini kabul etti.
- [ ] Arkadaşın klonunda `git config --local claude.role` → `arkadas`.
- [ ] Arkadaşın klonunda `git config --local core.hooksPath` → `.githooks`.
- [ ] Arkadaşın `git branch --show-current` → `arkadas`.
- [ ] `origin/arkadas` branch'i oluştu.
- [ ] Arkadaşın agent'ı küçük bir değişiklikte otomatik commit + push yaptı.
- [ ] Arkadaşın `main`'e push denemesi `.githooks/pre-push` tarafından engellendi.

## 7. Önemli notlar

- İlk kez bu klasörde Claude Code açtığında proje ayarlarını/hook'ları onaylaman
  istenebilir. `/hooks` komutuyla kurabilir ve görebilirsin.
- Hook'ları devre dışı bırakma; arkadaşın otomatik kaydı bunlara bağlı.
- `gh auth status` ile GitHub girişini kontrol edebilirsin.
