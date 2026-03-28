#ifndef __ELITEXF_CEKIRDEK_ISTEMCI_BI__
#define __ELITEXF_CEKIRDEK_ISTEMCI_BI__

#include once "core_types.bi"
#include once "core_commands.bi"
#include once "core_engine.bi"
#include once "oyun_turleri.bi"

Sub CekirdekKomutGonder(ByRef kabuk As OyunKabukDurumu, ByVal komutAdi As String, ByVal veri As String)
    Dim komut As KomutZarfi

    kabuk.sonKomutNo += 1
    komut.komutTuru = KomutMetnindenTure(komutAdi)
    komut.komutId = Left("ELITEXF-CMD-" & Trim(Str(kabuk.sonKomutNo)), 36)
    komut.zamanDamgasi = kabuk.sonKomutNo
    komut.oyuncuId = kabuk.oyun.oyuncu.oyuncuId
    komut.veri = Left(Trim(veri), AZAMI_KOMUT_VERI)

    KomutIsle kabuk.oyun, komut, kabuk.sonSonuc
End Sub

Sub ElitexfBaslat(ByRef kabuk As OyunKabukDurumu)
    CekirdekBaslat kabuk.oyun, 42
    kabuk.sonKomutNo = 0
    kabuk.calisiyor = 1
    CekirdekKomutGonder kabuk, "OYUN_BASLAT", ""
End Sub

#endif
