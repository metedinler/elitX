#include once "core_types.bi"

Function KomutMetnindenTure(ByVal ad As String) As KomutTuru
    Dim ust As String
    ust = UCase(Trim(ad))

    Select Case ust
        Case "OYUN_BASLAT"
            Return KOMUT_OYUN_BASLAT
        Case "OYUN_YUKLE"
            Return KOMUT_OYUN_YUKLE
        Case "OYUN_KAYDET"
            Return KOMUT_OYUN_KAYDET
        Case "SISTEME_GIT"
            Return KOMUT_SISTEME_GIT
        Case "TICARET_AL"
            Return KOMUT_TICARET_AL
        Case "TICARET_SAT"
            Return KOMUT_TICARET_SAT
        Case "YAKIT_AL"
            Return KOMUT_YAKIT_AL
        Case "HIPER_YAKIT_AL"
            Return KOMUT_HIPER_YAKIT_AL
        Case "GOREV_KABUL"
            Return KOMUT_GOREV_KABUL
        Case "GOREV_IPTAL"
            Return KOMUT_GOREV_IPTAL
        Case "DIPLOMASI_TEKLIF"
            Return KOMUT_DIPLOMASI_TEKLIF
        Case "SALDIRI_BASLAT"
            Return KOMUT_SALDIRI_BASLAT
        Case "SAVUNMA_MODU"
            Return KOMUT_SAVUNMA_MODU
        Case "TARAMA_YAP"
            Return KOMUT_TARAMA_YAP
        Case "TUR_ILERLET"
            Return KOMUT_TUR_ILERLET
        Case Else
            Return KOMUT_BILINMEYEN
    End Select
End Function
