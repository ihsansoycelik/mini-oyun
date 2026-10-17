# Arkadaşına Göndereceğin Mesaj

Aşağıdaki metni olduğu gibi kopyalayıp arkadaşına gönder (WhatsApp, e-posta vb.).
O, Claude Code'u açıp bu metni yapıştıracak.

---

Merhaba! İhsan'la ortak bir mini oyun yapacağız. Ben Git ve GitHub bilmiyorum.
Bana Claude Code ile yardım edeceksin. Senin görevin, aşağıdaki kurulumu benim
bilgisayarımda yapmak. Git komutlarını sen çalıştır; bana sadece gerçekten benim
yapmam gerekenleri söyle (tarayıcıda hesap açmak, giriş yapmak gibi). Bana Git
terimleri kullanma.

Repo: https://github.com/ihsansoycelik/mini-oyun
İhsan'ın GitHub kullanıcı adı: ihsansoycelik

Lütfen şu adımları sırayla yap:

1. Git kurulu mu kontrol et (`git --version`). Kurulu değilse işletim sistemime
   uygun şekilde kur ve doğrula.
2. GitHub hesabım yok. Benimle birlikte https://github.com/signup adresini aç;
   hesabı ben oluşturayım. Sonra kullanıcı adımı sana söyleyeyim.
   (Hesabım varsa bu adımı atla; kullanıcı adımı sana söyleyeyim.)
3. İhsan'ın beni repoya davet etmesi gerekiyor. Kullanıcı adımı İhsan'a
   göndermeme yardım et. Davet gelince kabul etmem için bana linki göster.
4. GitHub CLI (`gh`) kurulu mu bak. Değilse kur. Sonra GitHub'a giriş yapmam
   için `gh auth login` komutunu çalıştır; tarayıcıdaki adımları ben yapacağım.
   Gerekirse bana `! gh auth login` yazdır.
5. Repoyu HTTPS ile klonla:
   `git clone https://github.com/ihsansoycelik/mini-oyun.git`
   Sonra klasöre gir.
6. Şu yerel ayarları yap:
   - `git config user.name "<GitHub kullanıcı adım>"`
   - `git config user.email "<GitHub kullanıcı adım>@users.noreply.github.com"`
   - `git config --local claude.role arkadas`
   - `git config --local core.hooksPath .githooks`
7. `arkadas` branch'ini oluştur ve geç:
   `git checkout -b arkadas`
   Sonra `git push -u origin arkadas`.
8. Repodaki `KURULUM.md` dosyasını oku ve "Kurulum bitti mi?" kontrol listesini
   tamamla. Eksik varsa düzelt.
9. Bana her adımı çok basit Türkçe ile anlat. Takılırsan uydurma;
   "İhsan'a soralım" de.

Önemli: Bu projede benim agent'ım her iş bitince otomatik commit ve push
yapacak. Bunun için repodaki `CLAUDE.md` ve `.claude/hooks/otomatik-kaydet.sh`
dosyalarını kullan. Bana Git komutu yazdırma. `main` branch'ine asla
commit/push yapma. Sadece `arkadas` branch'inde çalış.

---
