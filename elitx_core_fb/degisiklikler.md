# Degisiklikler

## 2026-03-28
- `src/core_types.bi`
  - Komut/Event/Result zarfi ve canonical OyunDurumu Type'lari eklendi.
- `src/core_engine.bi`
  - Komut dispatcher ve event kayitlama altyapisi eklendi.
  - V1 komutlari: OYUN_BASLAT, TUR_ILERLET, SISTEME_GIT, TICARET_AL/SAT, TARAMA_YAP.
- `src/core_commands.bi`
  - Metin tabanli komut->enum cevirici eklendi.
- `src/main.bas`
  - Cekirdek API test senaryosu eklendi.
- `build.ps1`
  - ASCII stage ile derleme eklendi.
- `run.ps1`
  - Derlenen cekirdek exe calistirma scripti eklendi.

## 2026-03-28 (Faz B Genisletme)
- `src/core_types.bi`
  - Oyuncu ve oyun durumuna `hiperYakit`, `aktifGorev`, `diplomasiPuani`, `savunmaModu` alanlari eklendi.
- `src/core_engine.bi`
  - Yeni komutlar eklendi: OYUN_KAYDET, OYUN_YUKLE, YAKIT_AL, HIPER_YAKIT_AL, GOREV_KABUL, GOREV_IPTAL, DIPLOMASI_TEKLIF, SAVUNMA_MODU, SALDIRI_BASLAT.
  - Kaydet/yukle icin dosya tabanli `key=value` formatinda serilestirme akisi eklendi.
  - Sistem gecisinde yakit kontrolu eklendi.
- `src/main.bas`
  - Yeni komutlar icin smoke test adimlari eklendi.
- `plan.md`
  - Faz B genisletme adimlari append-only guncellendi.
