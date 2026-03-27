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

Dim oyun As OyunDurumu
Dim komut As KomutZarfi
Dim sonuc As KomutSonucu

CekirdekBaslat oyun, 42

komut.komutId = "CMD-1"
komut.zamanDamgasi = 1
komut.oyuncuId = oyun.oyuncu.oyuncuId

komut.komutTuru = KomutMetnindenTure("OYUN_BASLAT")
komut.veri = ""
KomutIsle oyun, komut, sonuc
SonucYaz sonuc

komut.komutId = "CMD-2"
komut.komutTuru = KomutMetnindenTure("SISTEME_GIT")
komut.veri = "5"
KomutIsle oyun, komut, sonuc
SonucYaz sonuc

komut.komutId = "CMD-3"
komut.komutTuru = KomutMetnindenTure("TICARET_AL")
komut.veri = "25"
KomutIsle oyun, komut, sonuc
SonucYaz sonuc

komut.komutId = "CMD-4"
komut.komutTuru = KomutMetnindenTure("TUR_ILERLET")
komut.veri = ""
KomutIsle oyun, komut, sonuc
SonucYaz sonuc

Print "Son Oyun Durumu"
Print "Oyuncu: "; Trim(oyun.oyuncu.oyuncuId)
Print "Kredi: "; oyun.oyuncu.kredi
Print "Yakit: "; oyun.oyuncu.yakit
Print "Sistem: "; oyun.oyuncu.bulunduguSistemId
Print "Tur: "; oyun.turNo
Print "Surum: "; oyun.surum

Sleep
