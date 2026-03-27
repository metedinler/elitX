# elitx_core_fb

FreeBASIC ile yazilan dil-bagimsiz cekirdek referans uygulamasi.

## Hedef
- Komut zarfi -> KomutSonucu + Event listesi modelini calistirmak
- UI'dan bagimsiz cekirdek mutasyonu
- Deterministik davranis

## Komut Kapsami (v1)
- OYUN_BASLAT, OYUN_YUKLE, OYUN_KAYDET
- SISTEME_GIT, TUR_ILERLET, TARAMA_YAP
- TICARET_AL, TICARET_SAT
- YAKIT_AL, HIPER_YAKIT_AL
- GOREV_KABUL, GOREV_IPTAL
- DIPLOMASI_TEKLIF
- SALDIRI_BASLAT, SAVUNMA_MODU

## Dosyalar
- src/core_types.bi
- src/core_engine.bi
- src/core_commands.bi
- src/main.bas
- api_davranis_raporu.md

## Derleme
- `./build.ps1`

## Calistirma
- `./run.ps1`

## Dogrulama
- `src/main.bas` icindeki smoke senaryosu tum v1 komutlarini sirayla calistirir.
- Ayni senaryo ayni tohum ile iki kez kosulur ve durum imzalari karsilastirilir.
- Basarili durumda cikti sonunda `Deterministik Kontrol: BASARILI` gorulur.
