#!/usr/bin/env bash
# Arkadaş agent'ı için otomatik commit + push güvenlik ağı.
# Sadece claude.role=arkadas VE branch=arkadas iken çalışır.
# Çıktı: Claude Code Stop hook JSON'u (systemMessage / decision).
set -u

cd "${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}" 2>/dev/null || exit 0
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

git_dir="$(git rev-parse --git-dir 2>/dev/null || echo .git)"
log_file="$git_dir/claude-otomatik-kayit.log"
hata_dosyasi=".claude/PUSH-HATASI.txt"
log() { printf '%s %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" >> "$log_file" 2>/dev/null || true; }

role="$(git config --local claude.role 2>/dev/null || true)"
branch="$(git branch --show-current 2>/dev/null || true)"

# Rol ayarlanmamışsa branch adından çıkar (arkadaş kurulumu böyle de olabilir).
if [ -z "$role" ]; then
  if [ "$branch" = "arkadas" ]; then
    role="arkadas"
  else
    exit 0
  fi
fi

# Bu hook yalnızca arkadaş modunda ve arkadas branch'inde çalışır.
[ "$role" = "arkadas" ] || exit 0
[ "$branch" = "arkadas" ] || exit 0

# Çözülmemiş çakışma varsa kesinlikle commit yapma.
if [ -n "$(git ls-files -u 2>/dev/null)" ]; then
  printf '{"decision":"block","reason":"Repoda çözülmemiş bir çakışma (merge conflict) var. Commit yapma. git merge --abort çalıştır, kullanıcıya sade dille anlat ve İhsan'"'"'a haber vermesini söyle."}\n'
  exit 0
fi

# 1) Değişiklikleri stage'le
git add -A 2>/dev/null || true

if ! git diff --cached --quiet 2>/dev/null; then
  # 1a) Gizli bilgi içerebilecek dosyaları ayır
  secret_files=""
  while IFS= read -r -d '' f; do
    case "$f" in
      .env|*/.env|.env.*|*/.env.*|*.pem|*.key|id_rsa*|*/id_rsa*|*.p12)
        secret_files="$secret_files $f"
        git restore --staged -- "$f" 2>/dev/null || git reset -q HEAD -- "$f" 2>/dev/null || true
        ;;
    esac
  done < <(git diff --cached --name-only -z 2>/dev/null)

  if [ -n "$secret_files" ]; then
    clean="$(printf '%s' "$secret_files" | tr '\n' ' ' | sed 's/[\\"]/ /g')"
    log "GÜVENLİK: commit edilmedi:$secret_files"
    printf '{"decision":"block","reason":"GÜVENLİK: Şu dosyalar gizli bilgi içerebilir ve commit edilmedi:%s. Bu dosyaları .gitignore dosyasına ekle, sonra kalan değişiklikleri commit et. Kullanıcıya sade dille haber ver."}\n' "$clean"
    exit 0
  fi

  # 1b) 20 MB'tan büyük dosyaları ayır
  big_files=""
  while IFS= read -r -d '' f; do
    [ -f "$f" ] || continue
    size="$(wc -c < "$f" 2>/dev/null || echo 0)"
    if [ "${size:-0}" -gt 20971520 ] 2>/dev/null; then
      big_files="$big_files $f"
      git restore --staged -- "$f" 2>/dev/null || git reset -q HEAD -- "$f" 2>/dev/null || true
    fi
  done < <(git diff --cached --name-only -z 2>/dev/null)

  if [ -n "$big_files" ]; then
    clean="$(printf '%s' "$big_files" | tr '\n' ' ' | sed 's/[\\"]/ /g')"
    log "BÜYÜK DOSYA: commit edilmedi:$big_files"
    printf '{"decision":"block","reason":"UYARI: 20 MB üzerindeki şu dosyalar commit edilmedi:%s. Gerekirse .gitignore dosyasına ekle veya kullanıcıya sor."}\n' "$clean"
    exit 0
  fi

  # 1c) Commit
  if ! git diff --cached --quiet 2>/dev/null; then
    files="$(git diff --cached --name-only 2>/dev/null | head -20 | sed 's/^/- /')"
    msg="Otomatik kayıt: $(date '+%Y-%m-%d %H:%M')"
    if ! git commit -q -m "$msg" -m "$files" >>"$log_file" 2>&1; then
      log "Commit başarısız"
      printf '{"decision":"block","reason":"Otomatik commit başarısız oldu. git status ve hata çıktısını kontrol et; sorunu çözüp tekrar commit et. Çözemiyorsan kullanıcıya sade dille anlat."}\n'
      exit 0
    fi
    log "Commit atıldı: $msg"
  fi
fi

# 2) origin/arkadas'a göre gönderilmemiş commit varsa pushla
ahead=0
if git rev-parse --verify --quiet refs/remotes/origin/arkadas >/dev/null 2>&1; then
  ahead="$(git rev-list --count origin/arkadas..HEAD 2>/dev/null || echo 0)"
else
  ahead=1
fi

if [ "${ahead:-0}" -gt 0 ] 2>/dev/null; then
  if git push -q origin arkadas >>"$log_file" 2>&1; then
    log "Push başarılı (origin/arkadas)"
    rm -f "$hata_dosyasi" 2>/dev/null || true
    printf '{"systemMessage":"Değişiklikler kaydedildi ve GitHub'"'"'a gönderildi."}\n'
  else
    log "Push başarısız"
    printf 'Push hatası: %s\n' "$(date '+%Y-%m-%d %H:%M')" > "$hata_dosyasi" 2>/dev/null || true
    printf '{"systemMessage":"Değişiklikler bilgisayarına kaydedildi ama GitHub'"'"'a gönderilemedi. İhsan'"'"'a haber ver."}\n'
  fi
fi

exit 0
