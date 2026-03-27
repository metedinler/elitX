# ElitX Cekirdek API Sozlesmesi v1

Amac: Cekirdegin FreeBASIC referans uygulamasi olarak calismasi ve Python/C++/C#/Java tarafindan ayni komut-sozlesme ile kullanilabilmesi.

## 1) Tasarim Ilkeleri
- Dil bagimsiz komut/event protokolu
- Deterministik cekirdek: ayni girdi + ayni tohum = ayni sonuc
- UI ayri katman: cekirdek ekrana dogrudan baglanmaz
- Cekirdek mutasyonu yalnizca komut ile olur
- Tum yan etkiler event kaydina duser

## 2) Cekirdek Nesneleri (Canonical Domain)
- OyunDurumu
- Oyuncu
- YildizSistemi
- Irk/Faksiyon
- Pazar
- Gorev
- Olay
- NPCKaptan
- Konfig

## 3) Komut Arabirimi (Command API)
Her komut tek bir zarf ile gonderilir:
- komut_turu: string
- komut_id: string
- zaman: long
- oyuncu_id: string
- veri: object

Komut listesi (v1):
- OYUN_BASLAT
- OYUN_YUKLE
- OYUN_KAYDET
- SISTEME_GIT
- TICARET_AL
- TICARET_SAT
- YAKIT_AL
- HIPER_YAKIT_AL
- GOREV_KABUL
- GOREV_IPTAL
- DIPLOMASI_TEKLIF
- SALDIRI_BASLAT
- SAVUNMA_MODU
- TARAMA_YAP
- TUR_ILERLET

## 4) Cikti Arabirimi (Result + Event API)
Her komut icin standart sonuc:
- basarili: bool
- hata_kodu: string
- mesaj: string
- yeni_surumu: long
- eventler: Event[]

Event zarfı:
- event_turu: string
- event_id: string
- kaynak: string
- hedef: string
- yuk: object

Event tipleri (v1):
- EKONOMI_GUNCELLENDI
- FIYAT_DEGISTI
- DIPLOMASI_DEGISTI
- GOREV_DURUMU_DEGISTI
- SAVAS_DURUMU_DEGISTI
- OLAY_TETIKLENDI
- NPC_KARARI_URETILDI
- OYUNCU_DURUMU_DEGISTI

## 5) Dil Entegrasyon Modlari
### A) JSON-RPC (hizli baslangic)
- stdin/stdout veya soket
- Avantaj: tum dillere hizli baglanti
- Dezavantaj: buyuk veri hiz limiti

### B) gRPC/Protobuf (olcekli)
- Sert tipli sozlesme
- Avantaj: performans + versiyonlama
- Dezavantaj: ilk kurulum maliyeti

### C) C ABI DLL (en hizli yerel)
- Cagri: extern C benzeri C ABI
- Avantaj: dusuk gecikme
- Dezavantaj: bellek yonetimi dikkat ister

## 6) Versiyonlama Kurali
- API surumu: major.minor.patch
- Major: kirici degisiklik
- Minor: geriye uyumlu yeni komut/event
- Patch: hata duzeltme

## 7) Test Sozlesmesi
- Komut testleri: girdi/cikti altin dosya
- Determinizm testleri: ayni tohum ayni event sirasi
- Yuk testleri: NPC turu + olay fazi + ekonomi fazi

## 8) Ilk Uygulama Sirasi
1. JSON komut zarfini FreeBASIC tarafinda parse/uret
2. Komut dispatcher ekle
3. Event kayitlayici ekle
4. Python test istemcisiyle komut senaryolari kos
