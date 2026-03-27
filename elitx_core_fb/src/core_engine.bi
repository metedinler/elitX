#include once "core_types.bi"

Private Sub SonucTemizle(ByRef sonuc As KomutSonucu)
    Dim i As Integer
    sonuc.basarili = 0
    sonuc.hataKodu = ""
    sonuc.mesaj = ""
    sonuc.yeniSurum = 0
    sonuc.eventSayisi = 0
    For i = 1 To AZAMI_EVENT
        sonuc.eventler(i).eventTuru = ""
        sonuc.eventler(i).eventId = ""
        sonuc.eventler(i).kaynak = ""
        sonuc.eventler(i).hedef = ""
        sonuc.eventler(i).yuk = ""
    Next i
End Sub

Private Sub EventEkle(ByRef sonuc As KomutSonucu, ByVal tur As String, ByVal kaynak As String, ByVal hedef As String, ByVal yuk As String)
    If sonuc.eventSayisi >= AZAMI_EVENT Then Exit Sub
    sonuc.eventSayisi += 1
    sonuc.eventler(sonuc.eventSayisi).eventTuru = Left(tur, 32)
    sonuc.eventler(sonuc.eventSayisi).eventId = "EVT-" & Trim(Str(sonuc.eventSayisi))
    sonuc.eventler(sonuc.eventSayisi).kaynak = Left(kaynak, 24)
    sonuc.eventler(sonuc.eventSayisi).hedef = Left(hedef, 24)
    sonuc.eventler(sonuc.eventSayisi).yuk = Left(yuk, AZAMI_KOMUT_VERI)
End Sub

Sub CekirdekBaslat(ByRef oyun As OyunDurumu, ByVal tohum As Integer)
    oyun.surum = 1
    oyun.tohum = tohum
    oyun.turNo = 0
    oyun.oyuncu.oyuncuId = "OYUNCU-1"
    oyun.oyuncu.kredi = 1000
    oyun.oyuncu.yakit = 100
    oyun.oyuncu.hiperYakit = 10
    oyun.oyuncu.bulunduguSistemId = 1
    oyun.aktifGorev = ""
    oyun.diplomasiPuani = 0
    oyun.savunmaModu = 0
    Randomize tohum
End Sub

Private Sub KomutOyunuBaslat(ByRef oyun As OyunDurumu, ByRef sonuc As KomutSonucu)
    CekirdekBaslat oyun, oyun.tohum
    oyun.surum += 1
    sonuc.basarili = 1
    sonuc.mesaj = "Oyun baslatildi."
    sonuc.yeniSurum = oyun.surum
    EventEkle sonuc, "OYUNCU_DURUMU_DEGISTI", "CEKIRDEK", oyun.oyuncu.oyuncuId, "baslangic"
End Sub

Private Sub KomutTurIlerlet(ByRef oyun As OyunDurumu, ByRef sonuc As KomutSonucu)
    oyun.turNo += 1

    ' Deterministik piyasa benzeri dalga
    Dim dalga As Double
    dalga = (Rnd - 0.5) * 10
    oyun.oyuncu.kredi += dalga
    If oyun.oyuncu.kredi < 0 Then oyun.oyuncu.kredi = 0

    oyun.surum += 1
    sonuc.basarili = 1
    sonuc.mesaj = "Tur ilerletildi."
    sonuc.yeniSurum = oyun.surum
    EventEkle sonuc, "EKONOMI_GUNCELLENDI", "EKONOMI", oyun.oyuncu.oyuncuId, "tur=" & Trim(Str(oyun.turNo))
End Sub

Private Sub KomutSistemeGit(ByRef oyun As OyunDurumu, ByRef komut As KomutZarfi, ByRef sonuc As KomutSonucu)
    Dim hedef As Integer
    hedef = Val(Trim(komut.veri))

    If hedef < 1 Then
        sonuc.basarili = 0
        sonuc.hataKodu = "GECERSIZ_HEDEF"
        sonuc.mesaj = "Sistem id gecersiz."
        Exit Sub
    End If

    If oyun.oyuncu.yakit < 5 Then
        sonuc.basarili = 0
        sonuc.hataKodu = "YAKIT_YETERSIZ"
        sonuc.mesaj = "Sistem gecisi icin yakit yetersiz."
        Exit Sub
    End If

    oyun.oyuncu.bulunduguSistemId = hedef
    oyun.oyuncu.yakit -= 5
    If oyun.oyuncu.yakit < 0 Then oyun.oyuncu.yakit = 0

    oyun.surum += 1
    sonuc.basarili = 1
    sonuc.mesaj = "Sistem gecisi tamam."
    sonuc.yeniSurum = oyun.surum
    EventEkle sonuc, "OYUNCU_DURUMU_DEGISTI", oyun.oyuncu.oyuncuId, "SISTEM", "hedef=" & Trim(Str(hedef))
End Sub

Private Function KayitYolu(ByRef komut As KomutZarfi) As String
    Dim yol As String
    yol = Trim(komut.veri)
    If Len(yol) = 0 Then
        yol = "build\\savegame.dat"
    End If
    Return yol
End Function

Private Sub KomutOyunuKaydet(ByRef oyun As OyunDurumu, ByRef komut As KomutZarfi, ByRef sonuc As KomutSonucu)
    Dim yol As String
    yol = KayitYolu(komut)

    Dim ff As Integer
    ff = FreeFile

    Open yol For Output As #ff
    If Err <> 0 Then
        sonuc.basarili = 0
        sonuc.hataKodu = "KAYIT_ACILAMADI"
        sonuc.mesaj = "Kayit dosyasi acilamadi."
        Exit Sub
    End If

    Print #ff, "surum=" & Trim(Str(oyun.surum))
    Print #ff, "tohum=" & Trim(Str(oyun.tohum))
    Print #ff, "turNo=" & Trim(Str(oyun.turNo))
    Print #ff, "oyuncuId=" & Trim(oyun.oyuncu.oyuncuId)
    Print #ff, "kredi=" & Trim(Str(oyun.oyuncu.kredi))
    Print #ff, "yakit=" & Trim(Str(oyun.oyuncu.yakit))
    Print #ff, "hiperYakit=" & Trim(Str(oyun.oyuncu.hiperYakit))
    Print #ff, "sistemId=" & Trim(Str(oyun.oyuncu.bulunduguSistemId))
    Print #ff, "aktifGorev=" & Trim(oyun.aktifGorev)
    Print #ff, "diplomasiPuani=" & Trim(Str(oyun.diplomasiPuani))
    Print #ff, "savunmaModu=" & Trim(Str(oyun.savunmaModu))
    Close #ff

    sonuc.basarili = 1
    sonuc.mesaj = "Oyun kaydedildi."
    sonuc.yeniSurum = oyun.surum
    EventEkle sonuc, "DOSYA_KAYDEDILDI", "CEKIRDEK", oyun.oyuncu.oyuncuId, yol
End Sub

Private Sub KomutOyunuYukle(ByRef oyun As OyunDurumu, ByRef komut As KomutZarfi, ByRef sonuc As KomutSonucu)
    Dim yol As String
    yol = KayitYolu(komut)

    Dim ff As Integer
    ff = FreeFile

    Open yol For Input As #ff
    If Err <> 0 Then
        sonuc.basarili = 0
        sonuc.hataKodu = "KAYIT_BULUNAMADI"
        sonuc.mesaj = "Kayit dosyasi bulunamadi."
        Exit Sub
    End If

    Dim satir As String
    Dim p As Integer
    Dim anahtar As String
    Dim deger As String

    While Not Eof(ff)
        Line Input #ff, satir
        p = InStr(satir, "=")
        If p > 0 Then
            anahtar = Left(satir, p - 1)
            deger = Mid(satir, p + 1)

            Select Case anahtar
                Case "surum"
                    oyun.surum = Val(deger)
                Case "tohum"
                    oyun.tohum = Val(deger)
                Case "turNo"
                    oyun.turNo = Val(deger)
                Case "oyuncuId"
                    oyun.oyuncu.oyuncuId = Left(Trim(deger), 24)
                Case "kredi"
                    oyun.oyuncu.kredi = Val(deger)
                Case "yakit"
                    oyun.oyuncu.yakit = Val(deger)
                Case "hiperYakit"
                    oyun.oyuncu.hiperYakit = Val(deger)
                Case "sistemId"
                    oyun.oyuncu.bulunduguSistemId = Val(deger)
                Case "aktifGorev"
                    oyun.aktifGorev = Left(Trim(deger), 64)
                Case "diplomasiPuani"
                    oyun.diplomasiPuani = Val(deger)
                Case "savunmaModu"
                    oyun.savunmaModu = Val(deger)
            End Select
        End If
    Wend
    Close #ff

    Randomize oyun.tohum
    sonuc.basarili = 1
    sonuc.mesaj = "Oyun yuklendi."
    sonuc.yeniSurum = oyun.surum
    EventEkle sonuc, "DOSYA_YUKLENDI", "CEKIRDEK", oyun.oyuncu.oyuncuId, yol
End Sub

Private Sub KomutYakitAl(ByRef oyun As OyunDurumu, ByRef komut As KomutZarfi, ByRef sonuc As KomutSonucu)
    Dim miktar As Double
    Dim birimFiyat As Double
    Dim toplam As Double

    miktar = Val(Trim(komut.veri))
    If miktar <= 0 Then
        If komut.komutTuru = KOMUT_HIPER_YAKIT_AL Then
            miktar = 5
        Else
            miktar = 10
        End If
    End If

    If komut.komutTuru = KOMUT_HIPER_YAKIT_AL Then
        birimFiyat = 5
    Else
        birimFiyat = 2
    End If

    toplam = miktar * birimFiyat
    If oyun.oyuncu.kredi < toplam Then
        sonuc.basarili = 0
        sonuc.hataKodu = "KREDI_YETERSIZ"
        sonuc.mesaj = "Yakit alimi icin kredi yetersiz."
        Exit Sub
    End If

    oyun.oyuncu.kredi -= toplam

    If komut.komutTuru = KOMUT_HIPER_YAKIT_AL Then
        oyun.oyuncu.hiperYakit += miktar
        If oyun.oyuncu.hiperYakit > 50 Then oyun.oyuncu.hiperYakit = 50
        EventEkle sonuc, "OYUNCU_DURUMU_DEGISTI", "PAZAR", oyun.oyuncu.oyuncuId, "hiperYakit+=" & Trim(Str(miktar))
    Else
        oyun.oyuncu.yakit += miktar
        If oyun.oyuncu.yakit > 200 Then oyun.oyuncu.yakit = 200
        EventEkle sonuc, "OYUNCU_DURUMU_DEGISTI", "PAZAR", oyun.oyuncu.oyuncuId, "yakit+=" & Trim(Str(miktar))
    End If

    oyun.surum += 1
    sonuc.basarili = 1
    sonuc.mesaj = "Yakit alimi tamamlandi."
    sonuc.yeniSurum = oyun.surum
End Sub

Private Sub KomutGorevKabul(ByRef oyun As OyunDurumu, ByRef komut As KomutZarfi, ByRef sonuc As KomutSonucu)
    Dim gorev As String
    gorev = Trim(komut.veri)
    If Len(gorev) = 0 Then gorev = "KARGO-BASLANGIC"

    If Len(Trim(oyun.aktifGorev)) > 0 Then
        sonuc.basarili = 0
        sonuc.hataKodu = "AKTIF_GOREV_VAR"
        sonuc.mesaj = "Yeni gorev icin once mevcut gorevi bitir veya iptal et."
        Exit Sub
    End If

    oyun.aktifGorev = Left(gorev, 64)
    oyun.surum += 1
    sonuc.basarili = 1
    sonuc.mesaj = "Gorev kabul edildi."
    sonuc.yeniSurum = oyun.surum
    EventEkle sonuc, "GOREV_DURUMU_DEGISTI", "GOREV_SISTEMI", oyun.oyuncu.oyuncuId, "kabul=" & Trim(oyun.aktifGorev)
End Sub

Private Sub KomutGorevIptal(ByRef oyun As OyunDurumu, ByRef sonuc As KomutSonucu)
    If Len(Trim(oyun.aktifGorev)) = 0 Then
        sonuc.basarili = 0
        sonuc.hataKodu = "AKTIF_GOREV_YOK"
        sonuc.mesaj = "Iptal edilecek aktif gorev bulunmuyor."
        Exit Sub
    End If

    oyun.aktifGorev = ""
    oyun.surum += 1
    sonuc.basarili = 1
    sonuc.mesaj = "Gorev iptal edildi."
    sonuc.yeniSurum = oyun.surum
    EventEkle sonuc, "GOREV_DURUMU_DEGISTI", "GOREV_SISTEMI", oyun.oyuncu.oyuncuId, "iptal"
End Sub

Private Sub KomutDiplomasiTeklif(ByRef oyun As OyunDurumu, ByRef komut As KomutZarfi, ByRef sonuc As KomutSonucu)
    Dim etki As Integer
    etki = Val(Trim(komut.veri))
    If etki = 0 Then etki = 1

    oyun.diplomasiPuani += etki
    oyun.surum += 1
    sonuc.basarili = 1
    sonuc.mesaj = "Diplomasi teklifi isleme alindi."
    sonuc.yeniSurum = oyun.surum
    EventEkle sonuc, "DIPLOMASI_DURUMU_DEGISTI", "DIPLOMASI", oyun.oyuncu.oyuncuId, "etki=" & Trim(Str(etki))
End Sub

Private Sub KomutSavunmaModu(ByRef oyun As OyunDurumu, ByRef komut As KomutZarfi, ByRef sonuc As KomutSonucu)
    Dim deger As String
    deger = UCase(Trim(komut.veri))

    If deger = "0" Or deger = "OFF" Then
        oyun.savunmaModu = 0
    Else
        oyun.savunmaModu = 1
    End If

    oyun.surum += 1
    sonuc.basarili = 1
    sonuc.mesaj = "Savunma modu guncellendi."
    sonuc.yeniSurum = oyun.surum
    EventEkle sonuc, "SAVAS_DURUMU_DEGISTI", "SAVUNMA", oyun.oyuncu.oyuncuId, "savunma=" & Trim(Str(oyun.savunmaModu))
End Sub

Private Sub KomutSaldiriBaslat(ByRef oyun As OyunDurumu, ByRef sonuc As KomutSonucu)
    If oyun.oyuncu.hiperYakit < 1 Then
        sonuc.basarili = 0
        sonuc.hataKodu = "HIPER_YAKIT_YETERSIZ"
        sonuc.mesaj = "Saldiri manevrasi icin hiper yakit yetersiz."
        Exit Sub
    End If

    oyun.oyuncu.hiperYakit -= 1
    oyun.surum += 1
    sonuc.basarili = 1
    sonuc.mesaj = "Saldiri baslatildi."
    sonuc.yeniSurum = oyun.surum
    EventEkle sonuc, "SAVAS_DURUMU_DEGISTI", "SAVAS", oyun.oyuncu.oyuncuId, "saldiri"
End Sub

Private Sub KomutTicaret(ByRef oyun As OyunDurumu, ByRef komut As KomutZarfi, ByRef sonuc As KomutSonucu)
    Dim miktar As Double
    miktar = Val(Trim(komut.veri))
    If miktar <= 0 Then miktar = 10

    If komut.komutTuru = KOMUT_TICARET_AL Then
        If oyun.oyuncu.kredi < miktar Then
            sonuc.basarili = 0
            sonuc.hataKodu = "KREDI_YETERSIZ"
            sonuc.mesaj = "Alis icin kredi yetersiz."
            Exit Sub
        End If
        oyun.oyuncu.kredi -= miktar
        EventEkle sonuc, "FIYAT_DEGISTI", "PAZAR", oyun.oyuncu.oyuncuId, "alis=" & Trim(Str(miktar))
    Else
        oyun.oyuncu.kredi += miktar
        EventEkle sonuc, "FIYAT_DEGISTI", "PAZAR", oyun.oyuncu.oyuncuId, "satis=" & Trim(Str(miktar))
    End If

    oyun.surum += 1
    sonuc.basarili = 1
    sonuc.mesaj = "Ticaret komutu uygulandi."
    sonuc.yeniSurum = oyun.surum
End Sub

Private Sub KomutTaramaYap(ByRef oyun As OyunDurumu, ByRef sonuc As KomutSonucu)
    oyun.surum += 1
    sonuc.basarili = 1
    sonuc.mesaj = "Tarama tamamlandi."
    sonuc.yeniSurum = oyun.surum
    EventEkle sonuc, "OLAY_TETIKLENDI", "SENSOR", oyun.oyuncu.oyuncuId, "tarama"
End Sub

Private Sub KomutBilinmeyen(ByRef sonuc As KomutSonucu)
    sonuc.basarili = 0
    sonuc.hataKodu = "BILINMEYEN_KOMUT"
    sonuc.mesaj = "Komut turu desteklenmiyor."
End Sub

Sub KomutIsle(ByRef oyun As OyunDurumu, ByRef komut As KomutZarfi, ByRef sonuc As KomutSonucu)
    SonucTemizle sonuc

    Select Case komut.komutTuru
        Case KOMUT_OYUN_BASLAT
            KomutOyunuBaslat oyun, sonuc
        Case KOMUT_OYUN_KAYDET
            KomutOyunuKaydet oyun, komut, sonuc
        Case KOMUT_OYUN_YUKLE
            KomutOyunuYukle oyun, komut, sonuc
        Case KOMUT_TUR_ILERLET
            KomutTurIlerlet oyun, sonuc
        Case KOMUT_SISTEME_GIT
            KomutSistemeGit oyun, komut, sonuc
        Case KOMUT_TICARET_AL, KOMUT_TICARET_SAT
            KomutTicaret oyun, komut, sonuc
        Case KOMUT_YAKIT_AL, KOMUT_HIPER_YAKIT_AL
            KomutYakitAl oyun, komut, sonuc
        Case KOMUT_GOREV_KABUL
            KomutGorevKabul oyun, komut, sonuc
        Case KOMUT_GOREV_IPTAL
            KomutGorevIptal oyun, sonuc
        Case KOMUT_DIPLOMASI_TEKLIF
            KomutDiplomasiTeklif oyun, komut, sonuc
        Case KOMUT_SAVUNMA_MODU
            KomutSavunmaModu oyun, komut, sonuc
        Case KOMUT_SALDIRI_BASLAT
            KomutSaldiriBaslat oyun, sonuc
        Case KOMUT_TARAMA_YAP
            KomutTaramaYap oyun, sonuc
        Case Else
            KomutBilinmeyen sonuc
    End Select
End Sub
