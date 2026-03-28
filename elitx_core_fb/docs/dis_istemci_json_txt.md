# Dis Istemci JSON/TXT Komut Zarfi Entegrasyonu

Bu belge, cekirdegi sarmalayan programin (UI, launcher, bot, test istemcisi) JSON/TXT ile nasil komut gonderecegini ve sonucu nasil alacagini tarif eder.

## 1) Bridge Programi
- Exe: build/elitx_core_bridge.exe
- Giris: komut zarfi dosyasi
- Cikis: sonuc+event dosyasi
- Durum saklama: bridge_state.dat (varsayilan)

Kullanim:
- run_bridge.ps1 <giris_bicimi> <giris_dosyasi> <cikis_bicimi> <cikis_dosyasi> [durum_dosyasi]

## 2) JSON Giris Formati
Zorunlu alanlar:
- komut_turu
- komut_id
- zaman
- oyuncu_id
- veri

Ornek:
{
  "komut_turu": "SISTEME_GIT",
  "komut_id": "CMD-1001",
  "zaman": 1700000100,
  "oyuncu_id": "OYUNCU-1",
  "veri": "5"
}

## 3) TXT Giris Formati
Zorunlu anahtarlar:
- komut_turu=
- komut_id=
- zaman=
- oyuncu_id=
- veri=

Ornek:
komut_turu=YAKIT_AL
komut_id=CMD-1002
zaman=1700000101
oyuncu_id=OYUNCU-1
veri=20

## 4) JSON Cikis Formati
- basarili
- hata_kodu
- mesaj
- yeni_surum
- event_sayisi
- eventler[]

Her event:
- event_turu
- event_id
- kaynak
- hedef
- yuk

## 5) TXT Cikis Formati
- basarili=<0|1>
- hata_kodu=<kod>
- mesaj=<metin>
- yeni_surum=<sayisal>
- event_sayisi=<n>
- event1_turu, event1_id, event1_kaynak, event1_hedef, event1_yuk
- event2_...

## 6) Diplomasi Icin Veri Semantigi
Komut: DIPLOMASI_TEKLIF
veri:
- gonderen=OYUNCU-1;hedef=FAKSIYON-ALFA;karar=TEKLIF;etki=2
- gonderen=FAKSIYON-ALFA;hedef=OYUNCU-1;karar=ONAY;etki=2
- gonderen=FAKSIYON-ALFA;hedef=OYUNCU-1;karar=RET;etki=1

## 7) Sarmalayan Program Akisi (Referans)
1. UI aksiyonu -> komut zarfi olustur.
2. Zarfi JSON veya TXT dosyasina yaz.
3. Bridge exe'yi calistir.
4. Cikis dosyasini oku.
5. Event listesini event bus'a dagit.
6. UI ve HUD'i eventlerden guncelle.

## 8) Hata Yonetimi
- Parse hatasi: GECERSIZ_ZARF
- Bilinmeyen komut: BILINMEYEN_KOMUT
- Is kurali hatalari: YAKIT_YETERSIZ, KREDI_YETERSIZ vb.
- Sarmalayan program, hata_kodu bazli mesaj katalogu kullanmalidir.
