# Oyun Cekirdegi Tam Plan (Oyun Odakli)

Tarih: 2026-03-28
Kapsam: elitx_core_fb cekirdegini oyun tarafinda kullanilabilir ve semantik olarak net hale getirmek.

## Faz D - Semantik Netlestirme
1. Komut semantik sozlugu
- Her komut icin actor, target, precondition, effect, event tanimlanir.
- Cikti: komut_sozlugu.md

2. Diplomasi sureci modelleme
- Durumlar: TEKLIF_EDILDI, ONAYLANDI, REDDEDILDI, SURE_DOLDU
- Komutlar:
  - Kisa vadede: DIPLOMASI_TEKLIF + karar parametresi
  - Orta vadede: DIPLOMASI_YANIT (v1.1)
- Oyun varliklari:
  - teklifId
  - gonderenTarafId
  - hedefTarafId
  - teklifTuru (saldirmazlik, ticaret, ittifak)
  - sonTarihTur

3. Veri alma stratejisi
- Cekirdek sonuc ve eventleri tek kaynak kabul edilir.
- Sarmalayan programin modeli eventlerden derive edilir.
- UI dogrudan cekirdek degistirmez, sadece komut gonderir.

## Faz E - Cekirdek API Genisletme (v1.1)
1. Yeni komutlar
- DURUM_OZETI_AL
- EVENT_AKISI_AL
- DIPLOMASI_YANIT
- DIPLOMASI_DURUM_SORGULA

2. Yeni eventler
- DIPLOMASI_TEKLIF_OLUSTU
- DIPLOMASI_YANITLANDI
- DIPLOMASI_SURE_DOLDU

3. Yeni domain alanlari
- OyunDurumu.icin aktif diplomasi kayitlari listesi
- Event offset/cursor

## Faz F - Adaptor ve Entegrasyon
1. Process bridge kararliligi
- Birden fazla komut batch isleme
- Timeout ve retry politikasi

2. JSON/TXT protokol surumleme
- envelope_version alani
- backward compatibility kurallari

3. Test istemcileri
- Python ve C# ornek istemci
- Ornek senaryolar: ticaret dongusu, diplomasi dongusu

## Faz G - Oyun Icinde Uc Uca Kullanım
1. HUD / log paneli
- Event tiplerine gore filtreli log

2. Komut gecmisi
- Son 100 komut ve sonuc kaydi

3. Telemetri
- Tur basina komut sayisi, hata oranlari, event dagilimi

## Diplomasi Icin Net Cevaplar
1. Kim kime teklif ediyor?
- gonderen ve hedef alanlari veri icinde zorunlu kabul edilmelidir.

2. Onay/ret nasil oluyor?
- Mevcut v1'de karar=ONAY|RET parametresi ile ayni komuttan gecirilebilir.
- v1.1'de DIPLOMASI_YANIT ayri komut yapilmalidir.

3. Cekirdek verisi nasil alinacak?
- Kisa vadede: her komutun KomutSonucu + event listesi
- Orta vadede: DURUM_OZETI_AL + event cursor modeli
- Uzun vadede: stream/event bus katmani

## Basari Olcutleri
- Semantik belirsizlik kalmamis olmali.
- UI katmani cekirdekten bagimsiz test edilebilmeli.
- Ayni senaryo farkli istemcilerde ayni event sirasi ile calismali.
