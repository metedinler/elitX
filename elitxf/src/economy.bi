#include once "types.bi"

Private Sub InitGood(ByRef g As Good, ByVal nm As String, ByVal baseP As Double, ByVal st As Integer, ByVal vol As Double)
    g.name = nm
    g.basePrice = baseP
    g.price = baseP
    g.stock = st
    g.volatility = vol
    g.trend = 0
End Sub

Sub RecalcCargoUsed(ByRef p As Player)
    Dim i As Integer
    p.cargoUsed = 0
    For i = 1 To MAX_GOODS
        p.cargoUsed += p.cargoQty(i)
    Next i
End Sub

Sub ApplySystemEconomy(ByRef game As GameState, ByVal systemId As Integer)
    Dim i As Integer
    If systemId < 1 Or systemId > MAX_SYSTEMS Then Exit Sub

    Dim risk As Double
    risk = game.systems(systemId).risk

    game.systems(systemId).market.systemId = systemId
    game.systems(systemId).market.systemRisk = risk
    game.systems(systemId).market.productionGood = game.systems(systemId).productionGood
    game.systems(systemId).market.updateIntervalSec = 30
    game.systems(systemId).market.updateCountdownSec = game.systems(systemId).market.updateIntervalSec

    For i = 1 To MAX_GOODS
        game.systems(systemId).market.goods(i).price = game.systems(systemId).market.goods(i).basePrice * (0.85 + Rnd * 0.3)
        game.systems(systemId).market.goods(i).stock = 40 + Int(Rnd * 170)

        If i = game.systems(systemId).productionGood Then
            game.systems(systemId).market.goods(i).stock = game.systems(systemId).market.goods(i).stock + 90
            game.systems(systemId).market.goods(i).price = game.systems(systemId).market.goods(i).price * 0.72
        End If

        If i = 8 Then
            game.systems(systemId).market.goods(i).price = game.systems(systemId).market.goods(i).price * (1 + risk * 0.65)
        End If

        If game.systems(systemId).market.goods(i).stock < 1 Then game.systems(systemId).market.goods(i).stock = 1
        If game.systems(systemId).market.goods(i).stock > 999 Then game.systems(systemId).market.goods(i).stock = 999
    Next i
End Sub

Sub InitGame(ByRef game As GameState)
    Randomize Timer

    Dim names(1 To MAX_SYSTEMS) As String = { _
        "Arel", "Boren", "Cygra", "Demer", "Ektor", "Faris", "Galen", "Helix", _
        "Ionas", "Jovar", "Ketra", "Lunor", "Mensa", "Nerid", "Orlan", "Phera" _
    }

    Dim i As Integer
    For i = 1 To MAX_SYSTEMS
        game.systems(i).id = i
        game.systems(i).name = names(i)
        game.systems(i).risk = ((i * 3) Mod 8) / 10.0 + 0.1
        game.systems(i).productionGood = ((i * 7) Mod MAX_GOODS) + 1
        game.systems(i).taxRate = 0.015 + game.systems(i).risk * 0.06

        InitGood(game.systems(i).market.goods(1), "GIDA", 12, 180, 0.35)
        InitGood(game.systems(i).market.goods(2), "TEKSTIL", 18, 120, 0.25)
        InitGood(game.systems(i).market.goods(3), "METAL", 40, 80, 0.45)
        InitGood(game.systems(i).market.goods(4), "ELEKTRONIK", 95, 40, 0.60)
        InitGood(game.systems(i).market.goods(5), "MAKINE", 75, 55, 0.50)
        InitGood(game.systems(i).market.goods(6), "KIMYA", 52, 70, 0.40)
        InitGood(game.systems(i).market.goods(7), "SAGLIK", 110, 30, 0.55)
        InitGood(game.systems(i).market.goods(8), "YAKIT", 28, 160, 0.35)
        InitGood(game.systems(i).market.goods(9), "LUKS", 160, 18, 0.70)
        InitGood(game.systems(i).market.goods(10), "ALASIM", 62, 60, 0.45)
        InitGood(game.systems(i).market.goods(11), "YEDEK", 46, 85, 0.35)
        InitGood(game.systems(i).market.goods(12), "MERMI", 20, 140, 0.28)

        ApplySystemEconomy(game, i)
    Next i

    game.player.credits = 1200
    game.player.fuelMax = 160
    game.player.fuel = 120
    game.player.hyperFuelMax = 70
    game.player.hyperFuel = 45
    game.player.ammo = 30
    game.player.cargoCapacity = 26
    game.player.currentSystemId = 1
    game.player.taxPaidTotal = 0
    game.player.profitTotal = 0

    game.upgrades.hyperBoost = 0
    game.upgrades.cargoBonus = 0
    game.upgrades.fuelTankBonus = 0

    For i = 1 To MAX_GOODS
        game.player.cargoQty(i) = 0
    Next i
    RecalcCargoUsed(game.player)

    For i = 1 To MAX_PASSENGERS
        game.passengers(i).active = 0
    Next i

    game.selectedGood = 1
    game.selectedSystem = 2
    game.uiMode = MODE_FLIGHT
    game.running = 1
    game.lastHyperFuelUse = 0
    game.uiRefreshIntervalSec = 30
    game.uiRefreshCountdownSec = game.uiRefreshIntervalSec
    game.forceRedraw = 1
    game.yardimAcik = 1
    game.yardimSayfa = 1
    game.infoText = "Sisteme hos geldin komutan."

    InitWireModels(game)
    InitObjects(game)
    GenerateMission(game)
    TrySpawnPassengers(game)
End Sub

Sub TickMarket(ByRef m As Market, ByVal dt As Double)
    Dim i As Integer
    Dim scarcity As Double
    Dim noise As Double
    Dim drift As Double

    For i = 1 To MAX_GOODS
        If m.goods(i).stock > 0 Then
            scarcity = (95 - m.goods(i).stock) / 95.0
        Else
            scarcity = 1
        End If

        If scarcity > 1 Then scarcity = 1
        If scarcity < -1 Then scarcity = -1

        noise = (Rnd - 0.5) * m.goods(i).volatility * 0.22
        m.goods(i).trend = m.goods(i).trend * 0.9 + noise
        drift = (m.goods(i).trend * 0.11) + (scarcity * 0.16) + (m.systemRisk * 0.07)

        m.goods(i).price = m.goods(i).price * (1 + drift)
        If m.goods(i).price < m.goods(i).basePrice * 0.30 Then m.goods(i).price = m.goods(i).basePrice * 0.30
        If m.goods(i).price > m.goods(i).basePrice * 4.0 Then m.goods(i).price = m.goods(i).basePrice * 4.0

        m.goods(i).stock = m.goods(i).stock + Int((Rnd - 0.5) * 15)
        If i = m.productionGood Then m.goods(i).stock += Int(10 + Rnd * 14)
        If m.goods(i).stock < 1 Then m.goods(i).stock = 1
        If m.goods(i).stock > 999 Then m.goods(i).stock = 999
    Next i
End Sub

Sub TickAllMarkets(ByRef game As GameState, ByVal dt As Double)
    Dim i As Integer
    For i = 1 To MAX_SYSTEMS
        game.systems(i).market.updateCountdownSec -= dt
        If game.systems(i).market.updateCountdownSec <= 0 Then
            TickMarket(game.systems(i).market, game.systems(i).market.updateIntervalSec)
            game.systems(i).market.updateCountdownSec = game.systems(i).market.updateIntervalSec
        End If
    Next i
End Sub

Sub TickGame(ByRef game As GameState, ByVal dt As Double)
    TickAllMarkets(game, dt)

    game.uiRefreshCountdownSec -= dt
    If game.uiRefreshCountdownSec <= 0 Then
        game.uiRefreshCountdownSec = game.uiRefreshIntervalSec
        game.forceRedraw = 1
    End If

    ' Ucus modunda normal yakit zamanla tuketilir.
    If game.uiMode = MODE_FLIGHT Then
        game.player.fuel -= dt * 0.18
        If game.player.fuel < 0 Then game.player.fuel = 0
    End If

    If game.uiMode = MODE_FLIGHT Or game.uiMode = MODE_WIREFRAME Then
        TickFlightObjects game, dt
    End If
End Sub

Function BuyGood(ByRef p As Player, ByRef m As Market, ByVal goodId As Integer, ByVal qty As Integer, ByRef msg As String) As Integer
    Dim total As Double

    If goodId < 1 Or goodId > MAX_GOODS Then msg = "Gecersiz urun.": Exit Function
    If qty <= 0 Then msg = "Miktar sifirdan buyuk olmali.": Exit Function
    If m.goods(goodId).stock < qty Then msg = "Stok yetersiz.": Exit Function

    RecalcCargoUsed(p)
    If p.cargoUsed + qty > p.cargoCapacity Then msg = "Kargo kapasitesi dolu.": Exit Function

    total = m.goods(goodId).price * qty
    If p.credits < total Then msg = "Kredi yetersiz.": Exit Function

    p.credits -= total
    p.cargoQty(goodId) += qty
    m.goods(goodId).stock -= qty
    RecalcCargoUsed(p)

    msg = "Alis tamamlandi."
    BuyGood = 1
End Function

Function SellGood(ByRef p As Player, ByRef m As Market, ByVal goodId As Integer, ByVal qty As Integer, ByRef msg As String) As Integer
    Dim total As Double

    If goodId < 1 Or goodId > MAX_GOODS Then msg = "Gecersiz urun.": Exit Function
    If qty <= 0 Then msg = "Miktar sifirdan buyuk olmali.": Exit Function
    If p.cargoQty(goodId) < qty Then msg = "Gemide yeterli urun yok.": Exit Function

    total = m.goods(goodId).price * qty
    p.credits += total
    p.cargoQty(goodId) -= qty
    m.goods(goodId).stock += qty
    p.profitTotal += (m.goods(goodId).price - m.goods(goodId).basePrice) * qty
    RecalcCargoUsed(p)

    msg = "Satis tamamlandi."
    SellGood = 1
End Function

Function BuyFuel(ByRef p As Player, ByRef m As Market, ByVal amount As Double, ByRef msg As String) As Integer
    Dim unitPrice As Double
    Dim total As Double

    If amount <= 0 Then msg = "Miktar gecersiz.": Exit Function
    If p.fuel >= p.fuelMax Then msg = "Yakit deposu dolu.": Exit Function

    unitPrice = m.goods(8).price / 6.0
    If unitPrice < 1 Then unitPrice = 1

    If p.fuel + amount > p.fuelMax Then amount = p.fuelMax - p.fuel
    total = amount * unitPrice

    If p.credits < total Then msg = "Kredi yetersiz.": Exit Function

    p.credits -= total
    p.fuel += amount
    msg = "Normal yakit alindi."
    BuyFuel = 1
End Function

Function BuyHyperFuel(ByRef p As Player, ByRef m As Market, ByVal amount As Double, ByRef msg As String) As Integer
    Dim unitPrice As Double
    Dim total As Double

    If amount <= 0 Then msg = "Miktar gecersiz.": Exit Function
    If p.hyperFuel >= p.hyperFuelMax Then msg = "Hiper yakit tanki dolu.": Exit Function

    unitPrice = m.goods(8).price / 3.0
    If unitPrice < 2 Then unitPrice = 2

    If p.hyperFuel + amount > p.hyperFuelMax Then amount = p.hyperFuelMax - p.hyperFuel
    total = amount * unitPrice

    If p.credits < total Then msg = "Kredi yetersiz.": Exit Function

    p.credits -= total
    p.hyperFuel += amount
    msg = "Hiper yakit alindi."
    BuyHyperFuel = 1
End Function

Function BuyAmmo(ByRef p As Player, ByRef m As Market, ByVal amount As Integer, ByRef msg As String) As Integer
    Dim total As Double
    Dim unitPrice As Double

    If amount <= 0 Then msg = "Miktar gecersiz.": Exit Function
    unitPrice = m.goods(12).price
    total = unitPrice * amount

    If p.credits < total Then msg = "Kredi yetersiz.": Exit Function

    p.credits -= total
    p.ammo += amount
    msg = "Mermi satin alindi."
    BuyAmmo = 1
End Function

Function BuyCargoUpgrade(ByRef game As GameState, ByRef msg As String) As Integer
    Dim price As Double
    price = 420 + game.upgrades.cargoBonus * 190

    If game.player.credits < price Then msg = "Kredi yetersiz.": Exit Function

    game.player.credits -= price
    game.upgrades.cargoBonus += 1
    game.player.cargoCapacity += 10
    msg = "Kargo kapasitesi artirildi."
    BuyCargoUpgrade = 1
End Function

Function BuyFuelTankUpgrade(ByRef game As GameState, ByRef msg As String) As Integer
    Dim price As Double
    price = 360 + game.upgrades.fuelTankBonus * 180

    If game.player.credits < price Then msg = "Kredi yetersiz.": Exit Function

    game.player.credits -= price
    game.upgrades.fuelTankBonus += 1
    game.player.fuelMax += 25
    game.player.hyperFuelMax += 10
    msg = "Yakit tanki kapasitesi artirildi."
    BuyFuelTankUpgrade = 1
End Function

Function BuyHyperUpgrade(ByRef game As GameState, ByRef msg As String) As Integer
    Dim price As Double
    price = 520 + game.upgrades.hyperBoost * 250

    If game.player.credits < price Then msg = "Kredi yetersiz.": Exit Function

    game.player.credits -= price
    game.upgrades.hyperBoost += 1
    msg = "Hiper motor takviyesi alindi."
    BuyHyperUpgrade = 1
End Function

Sub GenerateMission(ByRef game As GameState)
    Dim srcId As Integer
    Dim dstId As Integer

    srcId = game.player.currentSystemId
    dstId = ((srcId + Int(Rnd * (MAX_SYSTEMS - 1))) Mod MAX_SYSTEMS) + 1
    If dstId = srcId Then dstId = (dstId Mod MAX_SYSTEMS) + 1

    game.mission.active = 1
    game.mission.originSystemId = srcId
    game.mission.targetSystemId = dstId
    game.mission.reward = 280 + Int(Rnd * 420)
    game.mission.title = "Kurye gorevi"
End Sub

Sub TrySpawnPassengers(ByRef game As GameState)
    Dim i As Integer
    Dim currentId As Integer

    currentId = game.player.currentSystemId
    For i = 1 To 4
        If game.passengers(i).active = 0 Then
            game.passengers(i).originStar = currentId
            game.passengers(i).destStar = ((currentId + i + Int(Rnd * 3)) Mod MAX_SYSTEMS) + 1
            If game.passengers(i).destStar = currentId Then game.passengers(i).destStar = (game.passengers(i).destStar Mod MAX_SYSTEMS) + 1
            game.passengers(i).fare = 45 + Int(Rnd * 160)
            game.passengers(i).risk = game.systems(currentId).risk
            game.passengers(i).active = 1
        End If
    Next i
End Sub

Function BoardPassenger(ByRef game As GameState, ByRef msg As String) As Integer
    Dim i As Integer
    For i = 1 To MAX_PASSENGERS
        If game.passengers(i).active = 1 And game.passengers(i).originStar = game.player.currentSystemId Then
            game.passengers(i).active = 2
            msg = "Yolcu gemiye alindi."
            BoardPassenger = 1
            Exit Function
        End If
    Next i
    msg = "Bu sistemde alinacak yolcu yok."
End Function

Sub ResolveArrivedPassengers(ByRef game As GameState, ByRef msg As String)
    Dim i As Integer
    Dim totalFare As Double
    totalFare = 0

    For i = 1 To MAX_PASSENGERS
        If game.passengers(i).active = 2 Then
            If game.passengers(i).destStar = game.player.currentSystemId Then
                game.player.credits += game.passengers(i).fare
                game.player.profitTotal += game.passengers(i).fare
                totalFare += game.passengers(i).fare
                game.passengers(i).active = 0
            End If
        End If
    Next i

    If totalFare > 0 Then
        msg = "Yolcu odemesi alindi: " & Str(Int(totalFare))
    End If
End Sub

Function JumpToSystem(ByRef game As GameState, ByVal targetId As Integer, ByRef msg As String) As Integer
    Dim srcId As Integer
    Dim dist As Double
    Dim hyperNeed As Double
    Dim tax As Double

    If targetId < 1 Or targetId > MAX_SYSTEMS Then msg = "Gecersiz sistem.": Exit Function
    srcId = game.player.currentSystemId
    If srcId = targetId Then msg = "Zaten bu sistemdesin.": Exit Function

    dist = Abs(targetId - srcId) * 18
    hyperNeed = (6 + dist / 24) / (1 + game.upgrades.hyperBoost * 0.28)
    If hyperNeed < 3 Then hyperNeed = 3

    If game.player.hyperFuel < hyperNeed Then
        msg = "Hiper yakit yetersiz."
        Exit Function
    End If

    game.player.hyperFuel -= hyperNeed
    game.lastHyperFuelUse = hyperNeed
    game.player.currentSystemId = targetId

    tax = game.systems(targetId).taxRate * (game.player.cargoUsed * 6 + 15)
    game.player.credits -= tax
    game.player.taxPaidTotal += tax
    game.systems(targetId).market.lastTax = tax

    If game.player.credits < 0 Then game.player.credits = 0

    ResolveArrivedPassengers(game, msg)
    If Len(msg) = 0 Then
        msg = "Sisteme atlandi. Vergi: " & Str(Int(tax))
    End If

    If game.mission.active = 1 And game.mission.targetSystemId = targetId Then
        game.player.credits += game.mission.reward
        game.player.profitTotal += game.mission.reward
        msg = "Gorev tamamlandi. Odul: " & Str(Int(game.mission.reward))
        GenerateMission(game)
    End If

    TrySpawnPassengers(game)
    JumpToSystem = 1
End Function
