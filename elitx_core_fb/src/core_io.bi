#include once "core_types.bi"
#include once "core_commands.bi"

Private Function JsonKacis(ByVal metin As String) As String
    Dim i As Integer
    Dim c As String
    Dim sonuc As String
    Dim kod As Integer

    sonuc = ""
    For i = 1 To Len(metin)
        c = Mid(metin, i, 1)
        kod = Asc(c)
        Select Case kod
            Case 92
                sonuc &= "\\\\"
            Case 34
                sonuc &= Chr(92) & Chr(34)
            Case 10
                sonuc &= "\\n"
            Case 13
                sonuc &= "\\r"
            Case Else
                sonuc &= c
        End Select
    Next i

    Return sonuc
End Function

Private Function JsonDegeriAl(ByVal json As String, ByVal anahtar As String, ByVal varsayilan As String) As String
    Dim aranan As String
    Dim p As Integer
    Dim kolon As Integer
    Dim basla As Integer
    Dim bitis As Integer
    Dim c As String

    aranan = Chr(34) & anahtar & Chr(34)
    p = InStr(json, aranan)
    If p <= 0 Then Return varsayilan

    kolon = InStr(p + Len(aranan), json, ":")
    If kolon <= 0 Then Return varsayilan

    basla = kolon + 1
    While basla <= Len(json)
        c = Mid(json, basla, 1)
        If c <> " " And c <> Chr(9) Then Exit While
        basla += 1
    Wend

    If basla > Len(json) Then Return varsayilan

    If Mid(json, basla, 1) = Chr(34) Then
        basla += 1
        bitis = basla
        While bitis <= Len(json)
            If Mid(json, bitis, 1) = Chr(34) And Mid(json, bitis - 1, 1) <> "\\" Then Exit While
            bitis += 1
        Wend
        If bitis > Len(json) Then Return varsayilan
        Return Mid(json, basla, bitis - basla)
    Else
        bitis = basla
        While bitis <= Len(json)
            c = Mid(json, bitis, 1)
            If c = "," Or c = "}" Or c = Chr(10) Or c = Chr(13) Then Exit While
            bitis += 1
        Wend
        Return Trim(Mid(json, basla, bitis - basla))
    End If
End Function

Private Function MetinDegeriAl(ByVal metin As String, ByVal anahtar As String, ByVal varsayilan As String) As String
    Dim aranan As String
    Dim p As Integer
    Dim basla As Integer
    Dim bitis As Integer
    Dim c As String

    aranan = LCase(Trim(anahtar)) & "="
    p = InStr(LCase(metin), aranan)
    If p <= 0 Then Return varsayilan

    basla = p + Len(aranan)
    bitis = basla
    While bitis <= Len(metin)
        c = Mid(metin, bitis, 1)
        If c = Chr(10) Or c = Chr(13) Then Exit While
        bitis += 1
    Wend

    Return Trim(Mid(metin, basla, bitis - basla))
End Function

Private Function KomutVarsayilanDoldur(ByRef komut As KomutZarfi) As Integer
    komut.komutTuru = KOMUT_BILINMEYEN
    komut.komutId = ""
    komut.zamanDamgasi = 0
    komut.oyuncuId = ""
    komut.veri = ""
    Return 1
End Function

Function KomutZarfiTxtOku(ByVal metin As String, ByRef komut As KomutZarfi) As Integer
    Dim komutAdi As String

    KomutVarsayilanDoldur komut

    komutAdi = MetinDegeriAl(metin, "komut_turu", "")
    If Len(komutAdi) = 0 Then
        komutAdi = MetinDegeriAl(metin, "komut", "")
    End If

    komut.komutTuru = KomutMetnindenTure(komutAdi)
    komut.komutId = Left(MetinDegeriAl(metin, "komut_id", "TXT-CMD"), 36)
    komut.zamanDamgasi = Val(MetinDegeriAl(metin, "zaman", "0"))
    komut.oyuncuId = Left(MetinDegeriAl(metin, "oyuncu_id", "OYUNCU-1"), 24)
    komut.veri = Left(MetinDegeriAl(metin, "veri", ""), AZAMI_KOMUT_VERI)

    If komut.komutTuru = KOMUT_BILINMEYEN Then Return 0
    Return 1
End Function

Function KomutZarfiJsonOku(ByVal json As String, ByRef komut As KomutZarfi) As Integer
    Dim komutAdi As String

    KomutVarsayilanDoldur komut

    komutAdi = JsonDegeriAl(json, "komut_turu", "")
    If Len(komutAdi) = 0 Then
        komutAdi = JsonDegeriAl(json, "komut", "")
    End If

    komut.komutTuru = KomutMetnindenTure(komutAdi)
    komut.komutId = Left(JsonDegeriAl(json, "komut_id", "JSON-CMD"), 36)
    komut.zamanDamgasi = Val(JsonDegeriAl(json, "zaman", "0"))
    komut.oyuncuId = Left(JsonDegeriAl(json, "oyuncu_id", "OYUNCU-1"), 24)
    komut.veri = Left(JsonDegeriAl(json, "veri", ""), AZAMI_KOMUT_VERI)

    If komut.komutTuru = KOMUT_BILINMEYEN Then Return 0
    Return 1
End Function

Function KomutSonucuTxtYaz(ByRef sonuc As KomutSonucu) As String
    Dim i As Integer
    Dim metin As String

    metin = "basarili=" & Trim(Str(sonuc.basarili)) & Chr(10)
    metin &= "hata_kodu=" & Trim(sonuc.hataKodu) & Chr(10)
    metin &= "mesaj=" & Trim(sonuc.mesaj) & Chr(10)
    metin &= "yeni_surum=" & Trim(Str(sonuc.yeniSurum)) & Chr(10)
    metin &= "event_sayisi=" & Trim(Str(sonuc.eventSayisi)) & Chr(10)

    For i = 1 To sonuc.eventSayisi
        metin &= "event" & Trim(Str(i)) & "_turu=" & Trim(sonuc.eventler(i).eventTuru) & Chr(10)
        metin &= "event" & Trim(Str(i)) & "_id=" & Trim(sonuc.eventler(i).eventId) & Chr(10)
        metin &= "event" & Trim(Str(i)) & "_kaynak=" & Trim(sonuc.eventler(i).kaynak) & Chr(10)
        metin &= "event" & Trim(Str(i)) & "_hedef=" & Trim(sonuc.eventler(i).hedef) & Chr(10)
        metin &= "event" & Trim(Str(i)) & "_yuk=" & Trim(sonuc.eventler(i).yuk) & Chr(10)
    Next i

    Return metin
End Function

Function KomutSonucuJsonYaz(ByRef sonuc As KomutSonucu) As String
    Dim i As Integer
    Dim metin As String

    metin = "{"
    metin &= Chr(34) & "basarili" & Chr(34) & ":" & Trim(Str(sonuc.basarili)) & ","
    metin &= Chr(34) & "hata_kodu" & Chr(34) & ":" & Chr(34) & JsonKacis(Trim(sonuc.hataKodu)) & Chr(34) & ","
    metin &= Chr(34) & "mesaj" & Chr(34) & ":" & Chr(34) & JsonKacis(Trim(sonuc.mesaj)) & Chr(34) & ","
    metin &= Chr(34) & "yeni_surum" & Chr(34) & ":" & Trim(Str(sonuc.yeniSurum)) & ","
    metin &= Chr(34) & "event_sayisi" & Chr(34) & ":" & Trim(Str(sonuc.eventSayisi)) & ","
    metin &= Chr(34) & "eventler" & Chr(34) & ":["

    For i = 1 To sonuc.eventSayisi
        If i > 1 Then metin &= ","
        metin &= "{"
        metin &= Chr(34) & "event_turu" & Chr(34) & ":" & Chr(34) & JsonKacis(Trim(sonuc.eventler(i).eventTuru)) & Chr(34) & ","
        metin &= Chr(34) & "event_id" & Chr(34) & ":" & Chr(34) & JsonKacis(Trim(sonuc.eventler(i).eventId)) & Chr(34) & ","
        metin &= Chr(34) & "kaynak" & Chr(34) & ":" & Chr(34) & JsonKacis(Trim(sonuc.eventler(i).kaynak)) & Chr(34) & ","
        metin &= Chr(34) & "hedef" & Chr(34) & ":" & Chr(34) & JsonKacis(Trim(sonuc.eventler(i).hedef)) & Chr(34) & ","
        metin &= Chr(34) & "yuk" & Chr(34) & ":" & Chr(34) & JsonKacis(Trim(sonuc.eventler(i).yuk)) & Chr(34)
        metin &= "}"
    Next i

    metin &= "]}"
    Return metin
End Function

Function KomutCalistirMetinGirdi(ByRef oyun As OyunDurumu, ByVal girisBicimi As String, ByVal girisMetni As String, ByRef cikisMetni As String, ByVal cikisBicimi As String) As Integer
    Dim komut As KomutZarfi
    Dim sonuc As KomutSonucu
    Dim basarili As Integer
    Dim bicim As String

    bicim = UCase(Trim(girisBicimi))

    If bicim = "JSON" Then
        basarili = KomutZarfiJsonOku(girisMetni, komut)
    Else
        basarili = KomutZarfiTxtOku(girisMetni, komut)
    End If

    If basarili = 0 Then
        sonuc.basarili = 0
        sonuc.hataKodu = "GECERSIZ_ZARF"
        sonuc.mesaj = "Komut zarfi parse edilemedi veya komut tanimsiz."
        sonuc.yeniSurum = oyun.surum
        sonuc.eventSayisi = 0
    Else
        KomutIsle oyun, komut, sonuc
    End If

    If UCase(Trim(cikisBicimi)) = "JSON" Then
        cikisMetni = KomutSonucuJsonYaz(sonuc)
    Else
        cikisMetni = KomutSonucuTxtYaz(sonuc)
    End If

    Return 1
End Function
