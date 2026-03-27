# Degisiklikler

## 2026-03-27
- `src/ui.bi`
  - Yardim overlay eklendi (oyun basinda acik, F1 veya ? ile ac/kapat).
  - Ok tuslari baglamsal hale getirildi:
    - Ticaret: UP/DOWN mal secimi, LEFT/RIGHT hedef sistem secimi
    - Ucus/Tel-cerceve: kamera yaw/pitch kontrolu
  - Mod satiri ve alt bilgilendirme metinleri mode-bazli guncellendi.
- `src/types.bi`
  - `GameState` icine yardim durumu alanlari eklendi: `yardimAcik`, `yardimSayfa`.
- `src/economy.bi`
  - Baslangicta yardim ekranini acik getirecek init degerleri eklendi.
- `src/flight.bi`
  - Wireframe ciziminde kamera yaw/pitch etkisi aktif edildi.
- `.copılot/Kurallar.md`
  - Hedef git adresi `https://github.com/metedinler/elitX` olarak duzeltildi.
- `.copılot/plan.md`
  - Faz bazli uygulama plani dolduruldu, append-only guncelleme satirlari eklendi.
- `.copılot/istekler.md`
  - Gercek kullanici istekleri ve durumlari eklendi.
- `.copılot/programcı el kitabı.md`
  - elitxf modulleri, API giris/cikis ve akis detaylariyla dolduruldu.
- `README.md`
  - Yardim ve baglamsal ok tusu davranislari dokumante edildi.
- `git`
  - c:/Users/mete/Zotero/elıteX altinda yerel repo olusturuldu.
  - İlk yayin paketi elitxf + gerekli .copilot belgeleri olarak commit edildi.
  - `origin` uzak deposu `https://github.com/metedinler/elitX.git` olarak ayarlanip push edildi.
