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
