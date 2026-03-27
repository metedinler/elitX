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
    oyun.oyuncu.bulunduguSistemId = 1
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

    oyun.oyuncu.bulunduguSistemId = hedef
    oyun.oyuncu.yakit -= 5
    If oyun.oyuncu.yakit < 0 Then oyun.oyuncu.yakit = 0

    oyun.surum += 1
    sonuc.basarili = 1
    sonuc.mesaj = "Sistem gecisi tamam."
    sonuc.yeniSurum = oyun.surum
    EventEkle sonuc, "OYUNCU_DURUMU_DEGISTI", oyun.oyuncu.oyuncuId, "SISTEM", "hedef=" & Trim(Str(hedef))
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
        Case KOMUT_TUR_ILERLET
            KomutTurIlerlet oyun, sonuc
        Case KOMUT_SISTEME_GIT
            KomutSistemeGit oyun, komut, sonuc
        Case KOMUT_TICARET_AL, KOMUT_TICARET_SAT
            KomutTicaret oyun, komut, sonuc
        Case KOMUT_TARAMA_YAP
            KomutTaramaYap oyun, sonuc
        Case Else
            KomutBilinmeyen sonuc
    End Select
End Sub
