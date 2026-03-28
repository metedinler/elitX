#ifndef __ELITEXF_ARAYUZ_BI__
#define __ELITEXF_ARAYUZ_BI__

#include once "oyun_turleri.bi"
#include once "cekirdek_istemci.bi"

Private Sub EventleriYaz(ByRef sonuc As KomutSonucu)
    Dim i As Integer

    Print "Sonuc: "; sonuc.basarili; " | Mesaj: "; Trim(sonuc.mesaj)
    If Len(Trim(sonuc.hataKodu)) > 0 Then
        Print "Hata: "; Trim(sonuc.hataKodu)
    End If

    If sonuc.eventSayisi > 0 Then
        Print "Eventler:"
        For i = 1 To sonuc.eventSayisi
            Print " - "; Trim(sonuc.eventler(i).eventTuru); " | kaynak="; Trim(sonuc.eventler(i).kaynak); " | hedef="; Trim(sonuc.eventler(i).hedef); " | yuk="; Trim(sonuc.eventler(i).yuk)
        Next i
    End If
End Sub

Sub DurumOzetiYaz(ByRef kabuk As OyunKabukDurumu)
    Print ""
    Print "=== ELITEXF DURUM OZETI ==="
    Print "Oyuncu: "; Trim(kabuk.oyun.oyuncu.oyuncuId)
    Print "Kredi: "; kabuk.oyun.oyuncu.kredi; " | Yakit: "; kabuk.oyun.oyuncu.yakit; " | Hiper: "; kabuk.oyun.oyuncu.hiperYakit
    Print "Sistem: "; kabuk.oyun.oyuncu.bulunduguSistemId; " | Tur: "; kabuk.oyun.turNo; " | Surum: "; kabuk.oyun.surum
    Print "Gorev: "; Trim(kabuk.oyun.aktifGorev); " | Diplomasi: "; kabuk.oyun.diplomasiPuani; " | Savunma: "; kabuk.oyun.savunmaModu
    Print ""
End Sub

Private Sub MenuYaz()
    Print "[1] Tur Ilerlet"
    Print "[2] Sisteme Git"
    Print "[3] Ticaret Al"
    Print "[4] Ticaret Sat"
    Print "[5] Yakit Al"
    Print "[6] Hiper Yakit Al"
    Print "[7] Gorev Kabul"
    Print "[8] Gorev Iptal"
    Print "[9] Diplomasi Komutu"
    Print "[10] Savunma Modu"
    Print "[11] Saldiri Baslat"
    Print "[12] Tarama Yap"
    Print "[13] Oyun Kaydet"
    Print "[14] Oyun Yukle"
    Print "[0] Cikis"
    Print "Secim: ";
End Sub

Sub KomutSecimiIsle(ByRef kabuk As OyunKabukDurumu)
    Dim secim As String
    Dim veri As String

    MenuYaz
    Line Input secim
    secim = Trim(secim)

    Select Case secim
        Case "1"
            CekirdekKomutGonder kabuk, "TUR_ILERLET", ""
        Case "2"
            Print "Hedef sistem id: ";
            Line Input veri
            CekirdekKomutGonder kabuk, "SISTEME_GIT", veri
        Case "3"
            Print "Alis maliyeti: ";
            Line Input veri
            CekirdekKomutGonder kabuk, "TICARET_AL", veri
        Case "4"
            Print "Satis geliri: ";
            Line Input veri
            CekirdekKomutGonder kabuk, "TICARET_SAT", veri
        Case "5"
            Print "Yakit miktari: ";
            Line Input veri
            CekirdekKomutGonder kabuk, "YAKIT_AL", veri
        Case "6"
            Print "Hiper yakit miktari: ";
            Line Input veri
            CekirdekKomutGonder kabuk, "HIPER_YAKIT_AL", veri
        Case "7"
            Print "Gorev kodu: ";
            Line Input veri
            CekirdekKomutGonder kabuk, "GOREV_KABUL", veri
        Case "8"
            CekirdekKomutGonder kabuk, "GOREV_IPTAL", ""
        Case "9"
            Print "Diplomasi veri (gonderen=...;hedef=...;karar=TEKLIF|ONAY|RET;etki=...): ";
            Line Input veri
            CekirdekKomutGonder kabuk, "DIPLOMASI_TEKLIF", veri
        Case "10"
            Print "Savunma modu (ON/OFF): ";
            Line Input veri
            CekirdekKomutGonder kabuk, "SAVUNMA_MODU", veri
        Case "11"
            CekirdekKomutGonder kabuk, "SALDIRI_BASLAT", ""
        Case "12"
            CekirdekKomutGonder kabuk, "TARAMA_YAP", ""
        Case "13"
            Print "Kayit dosya yolu (bos=build\\elitexf_save.dat): ";
            Line Input veri
            If Len(Trim(veri)) = 0 Then veri = "build\\elitexf_save.dat"
            CekirdekKomutGonder kabuk, "OYUN_KAYDET", veri
        Case "14"
            Print "Yukleme dosya yolu (bos=build\\elitexf_save.dat): ";
            Line Input veri
            If Len(Trim(veri)) = 0 Then veri = "build\\elitexf_save.dat"
            CekirdekKomutGonder kabuk, "OYUN_YUKLE", veri
        Case "0"
            kabuk.calisiyor = 0
            kabuk.sonSonuc.basarili = 1
            kabuk.sonSonuc.mesaj = "Cikis secildi."
        Case Else
            kabuk.sonSonuc.basarili = 0
            kabuk.sonSonuc.hataKodu = "GECERSIZ_MENU_SECIMI"
            kabuk.sonSonuc.mesaj = "Menu secimi gecersiz."
            kabuk.sonSonuc.eventSayisi = 0
    End Select

    EventleriYaz kabuk.sonSonuc
End Sub

#endif
