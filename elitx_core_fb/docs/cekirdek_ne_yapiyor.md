# Cekirdek Ne Yapiyor?

Bu belge, elitx_core_fb cekirdeginin mevcut sorumluluklarini ve akis modelini ozetler.

## 1) Temel Gorev
- Komut zarfini alir.
- Oyun durumunu mutasyona ugratarak isler.
- Standart sonuc + event listesi uretir.

## 2) Durum Modeli
- Oyuncu: oyuncuId, kredi, yakit, hiperYakit, sistem.
- Oyun: surum, tohum, turNo, aktifGorev, diplomasiPuani, savunmaModu.

## 3) Komut Isleme Prensibi
- Tek giris noktasi: KomutIsle.
- Her komuttan once sonuc temizlenir.
- Komutlar Select Case ile ilgili handler'a yonlenir.
- Bilinmeyen komutlar BILINMEYEN_KOMUT ile reddedilir.

## 4) Event Uretimi
- Her anlamli yan etki event listesine yazilir.
- Event alani: eventTuru, eventId, kaynak, hedef, yuk.
- Event listesi sonuc zarfinda geri doner.

## 5) Is Kurallari Ornekleri
- SISTEME_GIT: hedef sistem >= 1 olmali ve en az 5 yakit olmalidir.
- TICARET_AL: kredi yetersizse islem reddedilir.
- HIPER_YAKIT_AL: kredi azalir, hiperYakit artar ve tavan uygulanir.
- GOREV_KABUL: aktif gorev varken yeni gorev kabul edilmez.
- SALDIRI_BASLAT: hiper yakit yoksa islem reddedilir.

## 6) Diplomasi Komutu Semantigi
- Komut: DIPLOMASI_TEKLIF
- veri alani semantik parametreler tasir:
  - gonderen=<id>
  - hedef=<id>
  - karar=TEKLIF|ONAY|RET
  - etki=<pozitif tamsayi>
- Etki:
  - TEKLIF: diplomasiPuani + etki
  - ONAY: diplomasiPuani + (etki + 1)
  - RET: diplomasiPuani - etki
- Event:
  - event_turu=DIPLOMASI_DEGISTI
  - kaynak=gonderen
  - hedef=hedef
  - yuk=karar ve etki bilgisi

## 7) Determinizm
- CekirdekBaslat tohum tabanli Randomize uygular.
- Ayni komut sirasi + ayni tohum, ayni final durum imzasi uretir.

## 8) Dis Istemciye Acilim
- core_io.bi JSON/TXT parse-serilestirme yapar.
- bridge_main.bas dosyadan zarf alip dosyaya sonucu yazar.
- Boylece GUI, Python, C#, C++ gibi istemciler cekirdegi process seviyesinde kullanabilir.
