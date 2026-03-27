## Plan: ElitX Gelistirme ve Yayin

Bu plan, bos GitHub deposu ile yerel calisma alanini esitleyip elitxf oyununda kontrol/yardim/mimari adimlarini kademeli uygular.

**Adimlar**
1. Faz 1 - Belgeleri doldur ve kurallari esitle
1. Kurallar.md icindeki repo adresini elitX olarak duzelt.
2. Bu plan dosyasini faz bazli icerikle doldur.
3. istekler.md dosyasinda aktif talepleri durumlariyla kaydet.
4. programci el kitabi dosyasina elitxf modulleri ve API giris/cikislarini yaz.

2. Faz 2 - Oynanis kontrol cekirdegi
1. Yardim ekrani oyunun basinda acik gelsin.
2. Yardim ekrani F1 veya ? ile her an acilip kapanabilsin.
3. V tel-cerceve sayfasi ayri kalsin; geri donus T veya U ile olsun.
4. Ok tuslari baglamsal calissin:
	- Ticaret: up/down mal sec, left/right hedef sistem sec
	- Ucus/Tel-cerceve: kamera yaw/pitch kontrolu

3. Faz 3 - Dokumantasyon senkronu
1. README kontroller bolumunu yeni tus davranislarina gore guncelle.
2. degisiklikler.md dosyasina bu turdaki degisiklikleri ekle.

4. Faz 4 - Repo hazirligi ve yayin
1. İlk push kapsami: elitxf + gerekli belgeler.
2. PAT (HTTPS) ile origin https://github.com/metedinler/elitX uzerine push.

**İlgili Dosyalar**
- .copılot/Kurallar.md
- .copılot/plan.md
- .copılot/istekler.md
- .copılot/programcı el kitabı.md
- elitxf/src/types.bi
- elitxf/src/ui.bi
- elitxf/src/flight.bi
- elitxf/src/economy.bi
- elitxf/README.md
- elitxf/degisiklikler.md

**Doğrulama**
1. build.ps1 ile derleme basarili olmali.
2. Yardim ekrani acilis ve oyun icinde tetiklenmeli.
3. Ticaret ve ucus modlarinda ok tuslari baglama gore farkli davranmali.
4. V-T-U gecisleri calismali.

**Kararlar**
- Mimari hedef: kati nesne benzeri tasarim (Type + controller benzeri sorumluluk ayrimi).
- İlk push kapsamı: sadece elitxf ve gerekli belgeler.

**Gelecek Adımlar**
1. Controller ayristirma fazina gecis (InputController, HelpController, ScreenStateManager).

## Ek Plan Guncellemesi (Append-Only) - 2026-03-27
- [Tamamlandi] Faz 1.1: Kurallar.md repo adresi elitX yapildi.
- [Tamamlandi] Faz 1.2: Plan dosyasi faz bazli gercek icerikle dolduruldu.
- [Tamamlandi] Faz 2.1-2.4: Yardim ekrani + baglamsal ok tuslari + V/T/U akisi kodlandi.
- [Tamamlandi] Faz 3.1-3.2: README ve degisiklik kaydi guncelleniyor.
- [Kismi] Faz 4: Yerel push adimi bu turda kimlik dogrulama ortamina bagli.

