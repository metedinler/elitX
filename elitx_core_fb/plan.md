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
