# Kullanıcı İstekleri ve Planlamaları

Bu dosya, konuşma boyunca kullanıcının yaptığı tüm istekleri buraya yazilir. ve geregi icin ne yapildi kisaca aciklanir. bir plan varsa o plan ve adimlari yazilir.

## Istek 1: Tel-cerceveyi ayri sayfa yap
- **Istek Tarihi**: 2026-03-27
- **Aciklama**: Ticaret tuslarina basildiginda tel-cerceve yenilenmesin, ayri sayfada olsun.
- **Planlama**: V ile ayri MODE_WIREFRAME sayfasi, geri donus T/U.
- **Uygulama**: UI modlari ayrildi ve tel-cerceve ayri panel sayfasina tasindi.
- **Durum**: Yapildi

## Istek 2: Acik kalan oyunu kapat
- **Istek Tarihi**: 2026-03-27
- **Aciklama**: Calisan elitxf.exe surecini bulup kapat.
- **Planlama**: Surec adini ve PID'i bul, guvenli sonlandir.
- **Uygulama**: elitxf.exe (PID 29004) bulundu ve terminate edildi.
- **Durum**: Yapildi

## Istek 3: Startrek klasorunu inceleyip entegrasyon plani hazirla
- **Istek Tarihi**: 2026-03-27
- **Aciklama**: STARTREK_UNIVERSE icinden elitxf ile baglanti kurulacak yapilarin cikartilmasi.
- **Planlama**: Durum yonetimi, input, gorev, ekonomi ve modul sorumluluklarinin eslestirilmesi.
- **Uygulama**: Faz bazli entegrasyon plani cikarildi.
- **Durum**: Yapildi

## Istek 4: Bos GitHub repo ile yerel farklari incele ve plani uygula
- **Istek Tarihi**: 2026-03-27
- **Aciklama**: elitX uzak repo bos, yerel proje dolu; belgeleri doldur ve plani uygulamaya al.
- **Planlama**: Once .copilot belgeleri, sonra oyun kontrol/yardim adimlari.
- **Uygulama**: Kurallar/plan/istekler/el kitabi dolduruldu; yardim ekrani ve baglamsal tuslar kodlandi.
- **Durum**: Kismi

## Istek 5: Cekirdek API + Kitap1cvc semasi + karar sistem secimi
- **Istek Tarihi**: 2026-03-27
- **Aciklama**: Dil bagimsiz cekirdek API sozlesmesi hazirla, Kitap1cvc verisini .txt/.json normalize semaya al, karar verici en iyi sistemleri sec.
- **Planlama**: 3 dosya grubu uretilmesi: API sozlesmesi, veri semasi, katman-bazli karar sistem belgesi.
- **Uygulama**: `.copılot/cekirdek_api_sozlesmesi_v1.md`, `.copılot/kitap1cvc_normalizasyonu.txt`, `.copılot/kitap1cvc_normalizasyonu_schema.json`, `.copılot/karar_verici_sistemler.md` olusturuldu.
- **Durum**: Yapildi

## Istek 6: FreeBASIC OOP cekirdege gecis
- **Istek Tarihi**: 2026-03-28
- **Aciklama**: Cekirdek API sozlesmesi ve planlara uyan yeni alt klasorde FreeBASIC OOP cekirdek baslat.
- **Planlama**: `elitx_core_fb` alt klasorunde command/event tabanli cekirdek ve derleme scriptleri.
- **Uygulama**: `elitx_core_fb/src` altinda canonical Type, dispatcher, event kaydi ve test girisi olusturuldu.
- **Durum**: Yapildi

## Istek 7: Eksikleri tamamla ve Faz C'ye gec
- **Istek Tarihi**: 2026-03-28
- **Aciklama**: Onceki islerde atlanan kisimlari tamamla, ardindan Faz C test ve dokumantasyonunu bitir.
- **Planlama**: Sozlesme uyumsuz event adlarini duzelt, deterministik test akisina gec, API davranis raporu uret, belgeleri senkron tut.
- **Uygulama**: `DIPLOMASI_DEGISTI` event uyumu saglandi; `src/main.bas` deterministik kontrol icerecek sekilde guncellendi; `api_davranis_raporu.md` eklendi; README/el kitabi/degisiklikler/plan append-only guncellendi.
- **Durum**: Yapildi