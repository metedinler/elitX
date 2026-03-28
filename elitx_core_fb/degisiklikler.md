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

## 2026-03-28 (Faz C Tamamlama)
- `src/core_engine.bi`
  - Diplomasi event adi sozlesme uyumlu `DIPLOMASI_DEGISTI` olarak duzeltildi.
- `src/main.bas`
  - Smoke test akisi fonksiyonlastirildi.
  - Sleep kaldirildi ve terminal otomasyonuna uygun cikis saglandi.
  - Determinizm kontrolu icin ayni senaryo iki kez kosulup durum imzasi karsilastirmasi eklendi.
- `README.md`
  - Komut kapsami, calistirma ve dogrulama bolumleri guncellendi.
- `api_davranis_raporu.md`
  - Faz C API davranis raporu eklendi.
- `plan.md`
  - Faz C kapanis maddeleri append-only eklendi.

## 2026-03-28 (Faz D: IO ve Semantik Netlestirme)
- `src/core_io.bi`
  - JSON/TXT komut zarfi okuma ve sonuc/event serilestirme eklendi.
  - `KomutCalistirMetinGirdi` ile parse -> KomutIsle -> serialize akisi eklendi.
- `src/bridge_main.bas`
  - Dosyadan komut alip dosyaya sonuc yazan dis istemci bridge girisi eklendi.
  - Varsayilan durum dosyasi ile auto load/save akisi eklendi.
- `build.ps1`
  - `elitx_core_bridge.exe` derlemesi eklendi.
- `run_bridge.ps1`
  - Bridge exe icin calistirma scripti eklendi.
- `src/core_engine.bi`
  - Diplomasi komutu `gonderen/hedef/karar/etki` parametreleri ile kim-kime ve onay/red semantigini isleyecek sekilde guncellendi.
- `docs/cekirdek_ne_yapiyor.md`
  - Cekirdegin gorev ve akis ozeti eklendi.
- `docs/dis_istemci_json_txt.md`
  - JSON/TXT dis istemci kullanim kilavuzu eklendi.
- `docs/oyun_cekirdegi_tam_plan.md`
  - Diplomasi ve veri alma modeli dahil oyun odakli tam yol haritasi eklendi.
