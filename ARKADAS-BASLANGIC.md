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
3. İhsan beni repoya davet etti. Daveti şu adresten kabul etmeme yardım et:
   https://github.com/ihsansoycelik/mini-oyun/invitations
   GitHub'da doğru hesapla giriş yaptığımdan emin ol.
4. GitHub CLI (`gh`) kurulu mu bak. Değilse kur. Sonra GitHub'a giriş yapmam
   için `gh auth login --git-protocol https --web` komutunu çalıştır;
   tarayıcıdaki adımları ben yapacağım. Gerekirse bana
   `! gh auth login --git-protocol https --web` yazdır.
   (HTTPS seçilmesi önemli; SSH değil.)
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
10. Kurulum bittikten sonra bana şunu hatırlat: "Bundan sonra Claude Code'u
    her zaman `mini-oyun` klasöründe açmalıyım." Proje kuralları (`CLAUDE.md`,
    `.claude/settings.json` ve otomatik commit hook'u) ancak Claude Code bu
    klasörde açıldığında yüklenir. Bana klasörü nasıl açacağımı adım adım anlat.

Önemli: Bu projede benim agent'ım her iş bitince otomatik commit ve push
yapacak. Bunun için repodaki `CLAUDE.md` ve `.claude/hooks/otomatik-kaydet.sh`
dosyalarını kullan. Bana Git komutu yazdırma. `main` branch'ine asla
commit/push yapma. Sadece `arkadas` branch'inde çalış.

---
