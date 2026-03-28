## Plan: elitx_core_fb Cekirdek Baslangic

Bu alt calisma alani, `.copılot/cekirdek_api_sozlesmesi_v1.md` ile uyumlu FreeBASIC referans cekirdegi icin ayrilmistir.

### Faz A - Cekirdek Iskelet
1. Canonical Type tanimlari: OyunDurumu, KomutZarfi, EventZarfi, KomutSonucu.
2. Komut dispatcher: Komut turune gore tek giris noktasi.
3. Event kayitlayici: tum yan etkilerin event listesine yazilmasi.
4. Deterministik tohum: ayni girdide ayni sonuc.

### Faz B - V1 Komutlari
1. OYUN_BASLAT
2. TUR_ILERLET
3. TARAMA_YAP
4. TICARET_AL / TICARET_SAT
5. SISTEME_GIT

### Faz C - Test ve Dokumantasyon
1. Konsol test senaryosu
2. Derleme dogrulamasi
3. API davranis raporu

### Ek Plan Guncellemesi (Append-Only) - 2026-03-28 / faz-b-genisletme
- [Tamamlandi] V1 komut kapsamı genisletildi: OYUN_KAYDET, OYUN_YUKLE, YAKIT_AL, HIPER_YAKIT_AL, GOREV_KABUL, GOREV_IPTAL, DIPLOMASI_TEKLIF, SAVUNMA_MODU, SALDIRI_BASLAT.
- [Tamamlandi] Dosya tabanli kaydet/yukle yolu `build\\savegame.dat` varsayilani ile eklendi.
- [Tamamlandi] `main.bas` smoke test senaryosu yeni komutlari kapsayacak sekilde guncellendi.

### Ek Plan Guncellemesi (Append-Only) - 2026-03-28 / faz-c-kapanis
- [Tamamlandi] Faz C.1: Konsol smoke senaryosu tum v1 komutlarini kapsayacak sekilde teyit edildi.
- [Tamamlandi] Faz C.2: Derleme dogrulamasi `build.ps1` ile basarili.
- [Tamamlandi] Faz C.3: API davranis raporu `api_davranis_raporu.md` olarak eklendi.
- [Tamamlandi] Determinizm kontrolu icin ayni senaryo iki kez kosulup durum imzasi karsilastirma akisi eklendi.

### Ek Plan Guncellemesi (Append-Only) - 2026-03-28 / faz-d-io-ve-semantik
- [Tamamlandi] JSON/TXT komut zarfi parse-serilestirme katmani `src/core_io.bi` eklendi.
- [Tamamlandi] Dosya tabanli dis istemci bridge girisi `src/bridge_main.bas` ve `run_bridge.ps1` eklendi.
- [Tamamlandi] Build hatti bridge exe uretecek sekilde guncellendi.
- [Tamamlandi] Diplomasi komutu `gonderen/hedef/karar/etki` semantigi ile netlestirildi.
- [Tamamlandi] Cekirdek ozeti, dis istemci kilavuzu ve oyun odakli tam plan dokumanlari `docs/` altina eklendi.
