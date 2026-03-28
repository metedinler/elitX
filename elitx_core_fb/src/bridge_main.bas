#include once "core_types.bi"
#include once "core_commands.bi"
#include once "core_engine.bi"
#include once "core_io.bi"

Private Function DosyaOku(ByVal yol As String) As String
    Dim ff As Integer
    Dim metin As String
    Dim satir As String

    ff = FreeFile
    Open yol For Input As #ff
    If Err <> 0 Then
        Return ""
    End If

    metin = ""
    While Not Eof(ff)
        Line Input #ff, satir
        metin &= satir & Chr(10)
    Wend
    Close #ff

    Return metin
End Function

Private Function DosyaYaz(ByVal yol As String, ByVal metin As String) As Integer
    Dim ff As Integer

    ff = FreeFile
    Open yol For Output As #ff
    If Err <> 0 Then
        Return 0
    End If

    Print #ff, metin
    Close #ff
    Return 1
End Function

Private Sub DurumuYukle(ByRef oyun As OyunDurumu, ByVal durumDosyasi As String)
    Dim komut As KomutZarfi
    Dim sonuc As KomutSonucu

    komut.komutTuru = KOMUT_OYUN_YUKLE
    komut.komutId = "AUTO-LOAD"
    komut.zamanDamgasi = 0
    komut.oyuncuId = oyun.oyuncu.oyuncuId
    komut.veri = Left(durumDosyasi, AZAMI_KOMUT_VERI)
    KomutIsle oyun, komut, sonuc
End Sub

Private Sub DurumuKaydet(ByRef oyun As OyunDurumu, ByVal durumDosyasi As String)
    Dim komut As KomutZarfi
    Dim sonuc As KomutSonucu

    komut.komutTuru = KOMUT_OYUN_KAYDET
    komut.komutId = "AUTO-SAVE"
    komut.zamanDamgasi = 0
    komut.oyuncuId = oyun.oyuncu.oyuncuId
    komut.veri = Left(durumDosyasi, AZAMI_KOMUT_VERI)
    KomutIsle oyun, komut, sonuc
End Sub

Dim girisBicimi As String
Dim cikisBicimi As String
Dim girisDosyasi As String
Dim cikisDosyasi As String
Dim durumDosyasi As String
Dim girisMetni As String
Dim cikisMetni As String
Dim oyun As OyunDurumu

If Command(1) = "" Then
    Print "Kullanim: elitx_core_bridge.exe <giris_bicimi:json|txt> <giris_dosyasi> <cikis_bicimi:json|txt> <cikis_dosyasi> [durum_dosyasi]"
    End 1
End If

girisBicimi = UCase(Trim(Command(1)))
girisDosyasi = Trim(Command(2))
cikisBicimi = UCase(Trim(Command(3)))
cikisDosyasi = Trim(Command(4))

If Len(Trim(Command(5))) > 0 Then
    durumDosyasi = Trim(Command(5))
Else
    durumDosyasi = "build\\bridge_state.dat"
End If

If (girisBicimi <> "JSON" And girisBicimi <> "TXT") Or (cikisBicimi <> "JSON" And cikisBicimi <> "TXT") Then
    Print "Hata: giris/cikis bicimi JSON veya TXT olmali."
    End 2
End If

If Len(girisDosyasi) = 0 Or Len(cikisDosyasi) = 0 Then
    Print "Hata: giris ve cikis dosyalari zorunludur."
    End 3
End If

CekirdekBaslat oyun, 42
DurumuYukle oyun, durumDosyasi

girisMetni = DosyaOku(girisDosyasi)
If Len(girisMetni) = 0 Then
    Print "Hata: giris dosyasi okunamadi veya bos."
    End 4
End If

KomutCalistirMetinGirdi oyun, girisBicimi, girisMetni, cikisMetni, cikisBicimi
If DosyaYaz(cikisDosyasi, cikisMetni) = 0 Then
    Print "Hata: cikis dosyasina yazilamadi."
    End 5
End If

DurumuKaydet oyun, durumDosyasi
Print "Tamamlandi. Cikis: " & cikisDosyasi
