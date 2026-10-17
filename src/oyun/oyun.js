// Oyun mantığı: oyuncu, altın, çarpışma ve skor.
// Arayüz ayrıntıları için src/arayuz/arayuz.js.
(() => {
  const canvas = document.getElementById('oyun-alani');
  if (!canvas) return;

  const ctx = canvas.getContext('2d');
  const durum = {
    skor: 0,
    tuslar: new Set(),
    oyuncu: { x: 380, y: 220, boyut: 40, hiz: 4 },
    altin: { x: 0, y: 0, yaricap: 12 }
  };

  function altinYerlestir() {
    const kenar = 30;
    durum.altin.x = kenar + Math.random() * (canvas.width - kenar * 2);
    durum.altin.y = kenar + Math.random() * (canvas.height - kenar * 2);
  }

  function guncelle() {
    const p = durum.oyuncu;

    if (durum.tuslar.has('ArrowLeft')) p.x -= p.hiz;
    if (durum.tuslar.has('ArrowRight')) p.x += p.hiz;
    if (durum.tuslar.has('ArrowUp')) p.y -= p.hiz;
    if (durum.tuslar.has('ArrowDown')) p.y += p.hiz;

    p.x = Math.max(0, Math.min(canvas.width - p.boyut, p.x));
    p.y = Math.max(0, Math.min(canvas.height - p.boyut, p.y));

    const merkezX = p.x + p.boyut / 2;
    const merkezY = p.y + p.boyut / 2;
    const dx = merkezX - durum.altin.x;
    const dy = merkezY - durum.altin.y;

    if (Math.hypot(dx, dy) < p.boyut / 2 + durum.altin.yaricap) {
      durum.skor += 1;
      Arayuz.skoruGuncelle(durum.skor);
      altinYerlestir();
    }
  }

  function ciz() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    ctx.fillStyle = '#10131a';
    ctx.fillRect(0, 0, canvas.width, canvas.height);

    ctx.beginPath();
    ctx.arc(durum.altin.x, durum.altin.y, durum.altin.yaricap, 0, Math.PI * 2);
    ctx.fillStyle = '#f2b544';
    ctx.fill();

    ctx.fillStyle = '#5ad1ff';
    ctx.fillRect(durum.oyuncu.x, durum.oyuncu.y, durum.oyuncu.boyut, durum.oyuncu.boyut);
  }

  function dongu() {
    guncelle();
    ciz();
    requestAnimationFrame(dongu);
  }

  window.addEventListener('keydown', (event) => {
    if (['ArrowUp', 'ArrowDown', 'ArrowLeft', 'ArrowRight'].includes(event.key)) {
      event.preventDefault();
      durum.tuslar.add(event.key);
    }
  });

  window.addEventListener('keyup', (event) => {
    durum.tuslar.delete(event.key);
  });

  altinYerlestir();
  Arayuz.skoruGuncelle(0);
  requestAnimationFrame(dongu);
})();
