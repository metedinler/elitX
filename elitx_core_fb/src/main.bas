#include once "core_types.bi"
#include once "core_commands.bi"
#include once "core_engine.bi"

Private Sub SonucYaz(ByRef sonuc As KomutSonucu)
    Dim i As Integer

    Print "Basarili: "; sonuc.basarili
    Print "Mesaj: "; Trim(sonuc.mesaj)
    Print "Surum: "; sonuc.yeniSurum
    Print "Event Sayisi: "; sonuc.eventSayisi

    For i = 1 To sonuc.eventSayisi
        Print " - "; Trim(sonuc.eventler(i).eventTuru); " | "; Trim(sonuc.eventler(i).yuk)
    Next i
    Print ""
End Sub

Private Sub KomutCalistir(ByRef oyun As OyunDurumu, ByRef komut As KomutZarfi, ByRef sonuc As KomutSonucu, ByVal komutId As String, ByVal ad As String, ByVal veri As String)
    komut.komutId = komutId
    komut.komutTuru = KomutMetnindenTure(ad)
    komut.veri = veri
    KomutIsle oyun, komut, sonuc
    SonucYaz sonuc
End Sub

Private Function DurumImza(ByRef oyun As OyunDurumu) As String
    Dim parca As String
    parca = "surum=" & Trim(Str(oyun.surum))
    parca &= ";tur=" & Trim(Str(oyun.turNo))
    parca &= ";kredi=" & Trim(Str(oyun.oyuncu.kredi))
    parca &= ";yakit=" & Trim(Str(oyun.oyuncu.yakit))
    parca &= ";hiper=" & Trim(Str(oyun.oyuncu.hiperYakit))
    parca &= ";sistem=" & Trim(Str(oyun.oyuncu.bulunduguSistemId))
    parca &= ";gorev=" & Trim(oyun.aktifGorev)
    parca &= ";dip=" & Trim(Str(oyun.diplomasiPuani))
    parca &= ";savunma=" & Trim(Str(oyun.savunmaModu))
    Return parca
End Function

Private Sub SenaryoCalistir(ByRef oyun As OyunDurumu, ByRef komut As KomutZarfi, ByRef sonuc As KomutSonucu)
    CekirdekBaslat oyun, 42
    komut.zamanDamgasi = 1
    komut.oyuncuId = oyun.oyuncu.oyuncuId

    KomutCalistir oyun, komut, sonuc, "CMD-1", "OYUN_BASLAT", ""
    KomutCalistir oyun, komut, sonuc, "CMD-2", "SISTEME_GIT", "5"
    KomutCalistir oyun, komut, sonuc, "CMD-3", "TICARET_AL", "25"
    KomutCalistir oyun, komut, sonuc, "CMD-4", "TUR_ILERLET", ""
    KomutCalistir oyun, komut, sonuc, "CMD-5", "YAKIT_AL", "20"
    KomutCalistir oyun, komut, sonuc, "CMD-6", "HIPER_YAKIT_AL", "3"
    KomutCalistir oyun, komut, sonuc, "CMD-7", "GOREV_KABUL", "TESLIMAT-42"
    KomutCalistir oyun, komut, sonuc, "CMD-8", "DIPLOMASI_TEKLIF", "2"
    KomutCalistir oyun, komut, sonuc, "CMD-9", "SAVUNMA_MODU", "ON"
    KomutCalistir oyun, komut, sonuc, "CMD-10", "OYUN_KAYDET", "build\\savegame.dat"
    KomutCalistir oyun, komut, sonuc, "CMD-11", "GOREV_IPTAL", ""
    KomutCalistir oyun, komut, sonuc, "CMD-12", "OYUN_YUKLE", "build\\savegame.dat"
End Sub

Dim oyun As OyunDurumu
Dim komut As KomutZarfi
Dim sonuc As KomutSonucu
Dim tekrar As OyunDurumu
Dim imza1 As String
Dim imza2 As String

SenaryoCalistir oyun, komut, sonuc
imza1 = DurumImza(oyun)

SenaryoCalistir tekrar, komut, sonuc
imza2 = DurumImza(tekrar)

Print "Son Oyun Durumu"
Print "Oyuncu: "; Trim(oyun.oyuncu.oyuncuId)
Print "Kredi: "; oyun.oyuncu.kredi
Print "Yakit: "; oyun.oyuncu.yakit
Print "Hiper Yakit: "; oyun.oyuncu.hiperYakit
Print "Sistem: "; oyun.oyuncu.bulunduguSistemId
Print "Aktif Gorev: "; Trim(oyun.aktifGorev)
Print "Diplomasi: "; oyun.diplomasiPuani
Print "Savunma Modu: "; oyun.savunmaModu
Print "Tur: "; oyun.turNo
Print "Surum: "; oyun.surum
Print "Imza: "; imza1

If imza1 = imza2 Then
    Print "Deterministik Kontrol: BASARILI"
Else
    Print "Deterministik Kontrol: BASARISIZ"
End If
