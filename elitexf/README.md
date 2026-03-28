# elitexf

`elitx_core_fb` cekirdegini kullanan yeni oyun kabugu (yeniden tasarim).

## Hedef
- Oyun mantigini cekirdekte toplamak
- Oyun kabugunu sadece komut gonderen ve event okuyan katman yapmak
- Cekirdekle uyumlu, genisletilebilir bir `Elitexf` giris uygulamasi kurmak

## Mimari
- `src/oyun_turleri.bi`: oyun kabugu durum tipi
- `src/cekirdek_istemci.bi`: cekirdege komut zarfi gonderen adapter
- `src/arayuz.bi`: menuler, durum ozeti, event yazdirma
- `src/main.bas`: ana dongu

## Derleme
- `./build.ps1`

## Calistirma
- `./run.ps1`

## Kontroller
- Menuden komut secimi yapilir.
- Her secim cekirdege komut olarak gider.
- Sonuc ve event listesi ekranda gorulur.
