# elitxf Mimari (ROOT GameState)

## Temel Ilke
Bu projede tum oyun verisi **tek bir kok nesnede** toplanir:

`GameState`

Ornek erisim:
- `Game.player.credits`
- `Game.systems(i).market.goods(j).price`

Bu sayede save/load, test ve AI simulasyonu kolaylasir.

## TYPE Yapilari
- `Good`
- `Market`
- `Upgrade`
- `Passenger`
- `Player`
- `StarSystem`
- `Mission`
- `GameState` (ROOT)

## Kurallara Uyum
- TYPE yapilari korunmustur.
- Flat global diziye donusum yapilmamistir.
- Ekonomi nesnesi `Market` icinde tutulmustur.
- Islevler `ByRef` TYPE parametreleri ile calisir.

## Sistemler
1. Borsa (30 sn)
- Her sistemin marketi bagimsiz sayacla guncellenir.
- `Market.updateCountdownSec`

2. Ticaret
- Sol panelde mal listesi (fiyat/stok/trend/gemide)
- Sag panelde kargo, kredi, vergi, yakit, yolcu

3. Yakit
- Normal yakit: ucus tuketimi
- Hiper yakit: sistemler arasi atlama tuketimi
- Hiper tuketim miktari HUD/Panelde gorunur

4. Vergi
- Yeni sisteme giriste vergi kesilir
- Son vergi ve toplam vergi panelde gosterilir

5. Gorev
- Sistemler arasi kurye gorevi
- Varis sisteminde odul kredisi

6. Yolcu
- Sistemlerde yolcu dogar
- Oyuncu yolcu alabilir
- Hedefe varisla ucret tahsil edilir

7. Upgrade
- Hiper motor takviyesi
- Kargo kapasite takviyesi
- Yakit tanki takviyesi
- Mermi satin alma

## Moduller
- `types.bi`: TYPE tanimlari ve deklarasyonlar
- `economy.bi`: ekonomi + gorev + yolcu + atlama + satin alma
- `ui.bi`: kutulu panel cizimi + input
- `main.bas`: oyun dongusu
