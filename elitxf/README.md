# elitxf (FreeBASIC)

Bu proje, eski kodu bozmadan sifirdan olusturulmus **TYPE-merkezli** bir galaksi + ekonomi + gorev cekirdegidir.

## Klasorler
- `src/` : Oyun kaynak kodlari
- `build/` : Derleme ciktisi (ara)
- `dist/` : Calisan oyun exe
- `backup/` : Eski derlemelerin yedegi
- `docs/` : Mimari notlar

## Calistirma
1. PowerShell ac
2. Proje kokune gel
3. `./build.ps1`
4. `./run.ps1`

## Kontroller
- `T` / `U`: Ticaret/Ucus gorunumu
- `V`: Tel-cerceve sayfasi
- `W` / `S`: Ticaret listesinde secim (alternatif)
- `UP` / `DOWN`: Ticarette mal secimi, ucus/tel-cercevede kamera pitch
- `LEFT` / `RIGHT`: Ticarette hedef sistem, ucus/tel-cercevede kamera yaw
- `B` / `N`: Al/Sat
- `F`: Normal yakit al
- `H`: Hiper yakit al
- `A`: Mermi al
- `C`: Kargo kapasitesi upgrade
- `Y`: Yakit tanki upgrade
- `M`: Hiper motor upgrade
- `P`: Yolcu al
- `,` / `.`: Hedef sistem sec
- `J`: Secili sisteme hiper atla
- `G`: Yeni gorev uret
- `F1` veya `?`: Yardim ekranini ac/kapat
- `ESC`: Cikis

## Notlar
- Borsa guncellemesi her 30 saniyede bir olur.
- Sol panel: kutulu ticaret tablosu
- Sag panel: kargo, yakit, vergi, yolcu bilgileri
- Tel-cerceve `V` ile ayri sayfada acilir, `T` veya `U` ile geri donulur.
- Sayilar sabit-genislikte hizalanir.
