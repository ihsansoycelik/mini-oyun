// Arayüz katmanı: skor ve ekran bilgilerini günceller.
// Oyun mekaniği burada değil; src/oyun/oyun.js dosyasında.
window.Arayuz = {
  skoruGuncelle(skor) {
    const el = document.getElementById('skor');
    if (el) el.textContent = `Skor: ${skor}`;
  },

  mesajGoster(mesaj) {
    const el = document.getElementById('mesaj');
    if (el) el.textContent = mesaj;
  }
};
