#include once "oyun_turleri.bi"
#include once "cekirdek_istemci.bi"
#include once "arayuz.bi"

Dim kabuk As OyunKabukDurumu

ElitexfBaslat kabuk

Do While kabuk.calisiyor = 1
    DurumOzetiYaz kabuk
    KomutSecimiIsle kabuk
Loop

Print "Elitexf kapatildi."
