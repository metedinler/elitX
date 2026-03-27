#ifndef __ELITX_CORE_TYPES_BI__
#define __ELITX_CORE_TYPES_BI__

Const AZAMI_EVENT = 256
Const AZAMI_KOMUT_VERI = 256

Enum KomutTuru
    KOMUT_BILINMEYEN = 0
    KOMUT_OYUN_BASLAT
    KOMUT_OYUN_YUKLE
    KOMUT_OYUN_KAYDET
    KOMUT_SISTEME_GIT
    KOMUT_TICARET_AL
    KOMUT_TICARET_SAT
    KOMUT_YAKIT_AL
    KOMUT_HIPER_YAKIT_AL
    KOMUT_GOREV_KABUL
    KOMUT_GOREV_IPTAL
    KOMUT_DIPLOMASI_TEKLIF
    KOMUT_SALDIRI_BASLAT
    KOMUT_SAVUNMA_MODU
    KOMUT_TARAMA_YAP
    KOMUT_TUR_ILERLET
End Enum

Type OyuncuDurumu
    oyuncuId As String * 24
    kredi As Double
    yakit As Double
    hiperYakit As Double
    bulunduguSistemId As Integer
End Type

Type OyunDurumu
    surum As Long
    tohum As Integer
    turNo As Long
    oyuncu As OyuncuDurumu
    aktifGorev As String * 64
    diplomasiPuani As Integer
    savunmaModu As Integer
End Type

Type KomutZarfi
    komutTuru As KomutTuru
    komutId As String * 36
    zamanDamgasi As Long
    oyuncuId As String * 24
    veri As String * AZAMI_KOMUT_VERI
End Type

Type EventZarfi
    eventTuru As String * 32
    eventId As String * 36
    kaynak As String * 24
    hedef As String * 24
    yuk As String * AZAMI_KOMUT_VERI
End Type

Type KomutSonucu
    basarili As Integer
    hataKodu As String * 32
    mesaj As String * 128
    yeniSurum As Long
    eventSayisi As Integer
    eventler(1 To AZAMI_EVENT) As EventZarfi
End Type

Declare Sub CekirdekBaslat(ByRef oyun As OyunDurumu, ByVal tohum As Integer)
Declare Sub KomutIsle(ByRef oyun As OyunDurumu, ByRef komut As KomutZarfi, ByRef sonuc As KomutSonucu)
Declare Function KomutMetnindenTure(ByVal ad As String) As KomutTuru

#endif
