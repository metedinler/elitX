# elitx_core_fb

FreeBASIC ile yazilan dil-bagimsiz cekirdek referans uygulamasi.

## Hedef
- Komut zarfi -> KomutSonucu + Event listesi modelini calistirmak
- UI'dan bagimsiz cekirdek mutasyonu
- Deterministik davranis

## Dosyalar
- src/core_types.bi
- src/core_engine.bi
- src/core_commands.bi
- src/main.bas

## Derleme
- fbc src/main.bas -x build/elitx_core_fb.exe
