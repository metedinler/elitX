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

komut.komutId = "CMD-5"
komut.komutTuru = KomutMetnindenTure("YAKIT_AL")
komut.veri = "20"
KomutIsle oyun, komut, sonuc
SonucYaz sonuc

komut.komutId = "CMD-6"
komut.komutTuru = KomutMetnindenTure("HIPER_YAKIT_AL")
komut.veri = "3"
KomutIsle oyun, komut, sonuc
SonucYaz sonuc

komut.komutId = "CMD-7"
komut.komutTuru = KomutMetnindenTure("GOREV_KABUL")
komut.veri = "TESLIMAT-42"
KomutIsle oyun, komut, sonuc
SonucYaz sonuc

komut.komutId = "CMD-8"
komut.komutTuru = KomutMetnindenTure("DIPLOMASI_TEKLIF")
komut.veri = "2"
KomutIsle oyun, komut, sonuc
SonucYaz sonuc

komut.komutId = "CMD-9"
komut.komutTuru = KomutMetnindenTure("SAVUNMA_MODU")
komut.veri = "ON"
KomutIsle oyun, komut, sonuc
SonucYaz sonuc

komut.komutId = "CMD-10"
komut.komutTuru = KomutMetnindenTure("OYUN_KAYDET")
komut.veri = "build\\savegame.dat"
KomutIsle oyun, komut, sonuc
SonucYaz sonuc

komut.komutId = "CMD-11"
komut.komutTuru = KomutMetnindenTure("GOREV_IPTAL")
komut.veri = ""
KomutIsle oyun, komut, sonuc
SonucYaz sonuc

komut.komutId = "CMD-12"
komut.komutTuru = KomutMetnindenTure("OYUN_YUKLE")
komut.veri = "build\\savegame.dat"
KomutIsle oyun, komut, sonuc
SonucYaz sonuc

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

Sleep
