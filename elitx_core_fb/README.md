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
- src/core_io.bi
- src/bridge_main.bas
- src/main.bas
- api_davranis_raporu.md
- docs/cekirdek_ne_yapiyor.md
- docs/dis_istemci_json_txt.md
- docs/oyun_cekirdegi_tam_plan.md

## Derleme
- `./build.ps1`

## Calistirma
- `./run.ps1`

## Dis Istemci Bridge
- Derleme sonrasi `build/elitx_core_bridge.exe` uretilir.
- Bridge, giris dosyasindan komut zarfini okur ve cikis dosyasina sonuc+event yazar.
- Cekirdek durumunu varsayilan `build/bridge_state.dat` dosyasinda surdurur.

### Kullanim
- `./run_bridge.ps1 <giris_bicimi> <giris_dosyasi> <cikis_bicimi> <cikis_dosyasi> [durum_dosyasi]`
- Bicimler: `json` veya `txt`

### JSON Komut Zarfi Ornegi
```json
{
	"komut_turu": "DIPLOMASI_TEKLIF",
	"komut_id": "CMD-900",
	"zaman": 1700000000,
	"oyuncu_id": "OYUNCU-1",
	"veri": "gonderen=OYUNCU-1;hedef=FAKSIYON-ALFA;karar=TEKLIF;etki=2"
}
```

### TXT Komut Zarfi Ornegi
```txt
komut_turu=DIPLOMASI_TEKLIF
komut_id=CMD-901
zaman=1700000001
oyuncu_id=OYUNCU-1
veri=gonderen=OYUNCU-1;hedef=FAKSIYON-ALFA;karar=ONAY;etki=2
```

## Dogrulama
- `src/main.bas` icindeki smoke senaryosu tum v1 komutlarini sirayla calistirir.
- Ayni senaryo ayni tohum ile iki kez kosulur ve durum imzalari karsilastirilir.
- Basarili durumda cikti sonunda `Deterministik Kontrol: BASARILI` gorulur.
- Bridge dogrulamasi icin `run_bridge.ps1` ile JSON ve TXT girisleri calistirilip cikis dosyalari kontrol edilir.
