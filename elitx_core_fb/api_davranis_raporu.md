# API Davranis Raporu (Faz C)

Tarih: 2026-03-28
Modul: elitx_core_fb
Sozlesme Kaynagi: .copılot/cekirdek_api_sozlesmesi_v1.md

## Kapsam
Bu rapor, v1 komutlarinin FreeBASIC referans cekirdekteki davranisini ve sonuc/event sozlesmesi uyumunu ozetler.

## Komut Sonuc Sozlesmesi
Her komut su alanlari dondurur:
- basarili
- hataKodu
- mesaj
- yeniSurum
- eventSayisi
- eventler[]

## Uygulanan Komutlar ve Beklenen Davranis
1. OYUN_BASLAT
- Etki: OyunDurumu varsayilanlar ile yeniden kurulur.
- Event: OYUNCU_DURUMU_DEGISTI

2. OYUN_KAYDET
- Etki: Durum key=value formatinda diske yazilir.
- Varsayilan yol: build\\savegame.dat
- Event: DOSYA_KAYDEDILDI

3. OYUN_YUKLE
- Etki: Durum key=value dosyasindan yuklenir.
- Hata: KAYIT_BULUNAMADI
- Event: DOSYA_YUKLENDI

4. SISTEME_GIT
- Etki: Sistem degisir, 5 birim yakit tuketir.
- Hata: GECERSIZ_HEDEF, YAKIT_YETERSIZ
- Event: OYUNCU_DURUMU_DEGISTI

5. TICARET_AL / TICARET_SAT
- Etki: Kredi azalir/artar.
- Hata: KREDI_YETERSIZ
- Event: FIYAT_DEGISTI

6. YAKIT_AL / HIPER_YAKIT_AL
- Etki: Kredi azaltip yakit depolarini arttirir.
- Hata: KREDI_YETERSIZ
- Event: OYUNCU_DURUMU_DEGISTI

7. GOREV_KABUL / GOREV_IPTAL
- Etki: aktifGorev atanir/temizlenir.
- Hata: AKTIF_GOREV_VAR, AKTIF_GOREV_YOK
- Event: GOREV_DURUMU_DEGISTI

8. DIPLOMASI_TEKLIF
- Etki: `veri` icindeki semantik parametrelere gore degisir.
	- `gonderen=<id>`
	- `hedef=<id>`
	- `karar=TEKLIF|ONAY|RET`
	- `etki=<pozitif tamsayi>`
	- TEKLIF: diplomasiPuani + etki
	- ONAY: diplomasiPuani + (etki + 1)
	- RET: diplomasiPuani - etki
- Event: DIPLOMASI_DEGISTI

9. SAVUNMA_MODU
- Etki: savunmaModu acik/kapali olur.
- Event: SAVAS_DURUMU_DEGISTI

10. SALDIRI_BASLAT
- Etki: 1 birim hiper yakit tuketir.
- Hata: HIPER_YAKIT_YETERSIZ
- Event: SAVAS_DURUMU_DEGISTI

11. TARAMA_YAP
- Etki: tarama sonucu olay tetiklenir.
- Event: OLAY_TETIKLENDI

12. TUR_ILERLET
- Etki: turNo artar, deterministik ekonomik dalga uygulanir.
- Event: EKONOMI_GUNCELLENDI

## Determinizm Sonucu
Ayni tohum (42) ve ayni komut sirasi ile senaryo iki kez calistirilmis,
final durum imzalari eslesmistir.
Beklenen cikti: Deterministik Kontrol: BASARILI

## Notlar
- DOSYA_KAYDEDILDI ve DOSYA_YUKLENDI event tipleri, v1 listesine ek observability eventleri olarak kullanilmistir.
- v1 event sozlesmesindeki isimlendirme ile uyum icin diplomasi eventi DIPLOMASI_DEGISTI olarak uretilmektedir.
- Dis istemci entegrasyonu icin JSON/TXT parse-serilestirme katmani (`src/core_io.bi`) ve bridge girisi (`src/bridge_main.bas`) eklenmistir.
