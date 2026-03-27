# Programci El Kitabi: ElitX / elitxf

## Genel Bakis
elitxf, FreeBASIC ile yazilmis TYPE-merkezli bir oyun cekirdegidir. ROOT nesne `GameState` olup tum oyuncu, ekonomi, gorev, yolcu, wireframe ve UI durumunu tek yerde tutar.

## Kod Yapisi
- `elitxf/src/main.bas`: ana oyun dongusu, dt hesaplama, redraw kontrolu.
- `elitxf/src/types.bi`: tum TYPE ve sabit deklarasyonlari.
- `elitxf/src/economy.bi`: pazar guncellemesi, ticaret, yakit, gorev, yolcu akisi.
- `elitxf/src/flight.bi`: wireframe modeller, sahne nesneleri, perspektif cizim.
- `elitxf/src/ui.bi`: panel cizimi, yardim overlay, input dispatch.
- `elitx_core_fb/src/main.bas`: dil-bagimsiz cekirdek API referans giris noktasi.
- `elitx_core_fb/src/core_types.bi`: KomutZarfi, EventZarfi, KomutSonucu, OyunDurumu canonical tanimlari.
- `elitx_core_fb/src/core_engine.bi`: komut dispatcher ve event kayit mantigi.
- `elitx_core_fb/src/core_commands.bi`: metin->komut turu cevirimi.

## Moduller

### main.bas
- `InitGame(GameState)`: oyunu baslatir.
- Ana loop:
	- `HandleInput(GameState)`
	- `TickGame(GameState, dt)`
	- `DrawUI(GameState)` sadece `forceRedraw` aktifken

### types.bi
- `GameState`: ROOT veri yapisi.
	- Giris: tum moduller `ByRef game As GameState`
	- Cikis: state mutasyonu
	- Kritik alanlar:
		- `uiMode` (MODE_TRADE, MODE_FLIGHT, MODE_WIREFRAME)
		- `yardimAcik`, `yardimSayfa`
		- `camYaw`, `camPitch`, `camRoll`

### economy.bi
- `InitGame(game)`: sistemleri, marketleri, oyuncuyu, gorev/yolcu state'ini kurar.
- `TickGame(game, dt)`: pazar zamanlayicisi ve ucus nesne guncellemesi.
- `BuyGood/SellGood`: al-sat islemleri.
- `BuyFuel/BuyHyperFuel/BuyAmmo`: kaynak satin alimlari.
- `BuyCargoUpgrade/BuyFuelTankUpgrade/BuyHyperUpgrade`: upgrade islemleri.
- `JumpToSystem`: sistem gecisi.

### flight.bi
- `InitWireModels(game)`: wireframe model tanimlari.
- `InitObjects(game)`: sahne nesnelerini baslatir.
- `TickFlightObjects(game, dt)`: nesne animasyonunu gunceller.
- `DrawWireframeLayer(game, x, y, w, h)`: kamera yaw/pitch'e gore perspektif cizim yapar.

### ui.bi
- `DrawUI(game)`: aktif moda gore paneli veya tel-cerceve sayfasini cizer.
- `HandleInput(game)`: global ve mod-bazli tus yonlendirmesi.
	- Global: `ESC`, `T/U/V`, `F1/?` yardim
	- Ticaret: `UP/DOWN` mal, `LEFT/RIGHT` hedef sistem
	- Ucus/Tel-cerceve: `UP/DOWN/LEFT/RIGHT` kamera
- Yardim overlay:
	- Oyun basinda acik gelir (`yardimAcik=1`)
	- `F1` veya `?` ile ac/kapat

## Oyun Akisi
1. Baslangicta `InitGame` cagrilir, yardim ekrani acik olur.
2. Kullanici mod secer: Ticaret / Ucus / Tel-cerceve.
3. Market her 30 saniyede bir guncellenir.
4. Input olaylari mode-bazli islenir.
5. Cikis sirasinda ozet kar/zarar ve vergi degeri yazdirilir.

## Veri Tipleri ve Sinirlar
- `MAX_GOODS = 12`
- `MAX_SYSTEMS = 16`
- `MAX_PASSENGERS = 24`
- `MAX_OBJECTS = 10`
- `infoText`: `String * 96` (sabit uzunluk)

## Gelistirme Notlari
- UI titremesini azaltmak icin redraw olay bazli yapilir.
- Tel-cerceve cizimi ayrik sayfaya alinmistir.
- Yardim ekrani globaldir ve oyun akisini bozmadan acilir.

## Hata Ayiklama
- Derleme: `elitxf/build.ps1`
- Calistirma: `elitxf/run.ps1`
- Acik kalan surec kontrolu: `Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'elitxf.exe' }`

## Cekirdek API Referans Modulu (elitx_core_fb)
- Hedef: `.copılot/cekirdek_api_sozlesmesi_v1.md` uyumlu command/event cekirdek.
- Giris: `KomutIsle(ByRef oyun, ByRef komut, ByRef sonuc)`
- Cikis: `KomutSonucu` + event listesi.
- Determinizm: `CekirdekBaslat` icinde tohum tabanli `Randomize`.
