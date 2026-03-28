# Degisiklikler

## 2026-03-28
- `src/oyun_turleri.bi`
  - Oyun kabugu durum modeli eklendi.
- `src/cekirdek_istemci.bi`
  - Cekirdege komut gonderen adapter eklendi.
- `src/arayuz.bi`
  - Konsol menu, durum ozeti ve event yazdirma eklendi.
- `src/main.bas`
  - Ana oyun dongusu ve komut dispatch akisi eklendi.
- `build.ps1`, `run.ps1`
  - Derleme ve calistirma scriptleri eklendi.
- `README.md`, `plan.md`
  - Yeniden tasarim hedefi ve fazlari belgelendi.

## 2026-03-28 (Derleme Duzeltmesi)
- `build.ps1`
  - Unicode yol kaynakli FreeBASIC include sorununu asmak icin stage derleme akisi eklendi.
  - `elitx_core_fb/src` include bagimliligi stage `core` klasorune kopyalanarak derlendi.
