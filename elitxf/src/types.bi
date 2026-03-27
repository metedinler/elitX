#ifndef __ELITXF_TYPES_BI__
#define __ELITXF_TYPES_BI__

Const MAX_GOODS = 12
Const MAX_SYSTEMS = 16
Const MAX_PASSENGERS = 24
Const MAX_VERTS = 20
Const MAX_EDGES = 40
Const MAX_MODELS = 4
Const MAX_OBJECTS = 10

Const MODE_FLIGHT = 0
Const MODE_TRADE = 1
Const MODE_WIREFRAME = 2

Type Good
    name As String * 24
    basePrice As Double
    price As Double
    stock As Integer
    volatility As Double
    trend As Double
End Type

Type Market
    systemRisk As Double
    systemId As Integer
    productionGood As Integer
    goods(1 To MAX_GOODS) As Good
    updateIntervalSec As Double
    updateCountdownSec As Double
    lastTax As Double
End Type

Type Upgrade
    hyperBoost As Integer
    cargoBonus As Integer
    fuelTankBonus As Integer
End Type

Type Passenger
    originStar As Integer
    destStar As Integer
    fare As Double
    risk As Double
    active As Integer
End Type

Type Player
    credits As Double
    fuel As Double
    fuelMax As Double
    hyperFuel As Double
    hyperFuelMax As Double
    ammo As Integer
    cargoCapacity As Integer
    cargoUsed As Integer
    cargoQty(1 To MAX_GOODS) As Integer
    currentSystemId As Integer
    taxPaidTotal As Double
    profitTotal As Double
End Type

Type StarSystem
    id As Integer
    name As String * 24
    risk As Double
    productionGood As Integer
    taxRate As Double
    market As Market
End Type

Type Mission
    active As Integer
    originSystemId As Integer
    targetSystemId As Integer
    reward As Double
    title As String * 64
End Type

Type Vec3
    x As Double
    y As Double
    z As Double
End Type

Type WireModel
    name As String * 24
    vCount As Integer
    eCount As Integer
    verts(1 To MAX_VERTS) As Vec3
    edgeA(1 To MAX_EDGES) As Integer
    edgeB(1 To MAX_EDGES) As Integer
End Type

Type SpaceObject
    active As Integer
    modelId As Integer
    pos As Vec3
    vel As Vec3
    yaw As Double
    pitch As Double
    roll As Double
End Type

Type GameState
    player As Player
    systems(1 To MAX_SYSTEMS) As StarSystem
    passengers(1 To MAX_PASSENGERS) As Passenger
    upgrades As Upgrade
    mission As Mission
    selectedGood As Integer
    selectedSystem As Integer
    uiMode As Integer
    running As Integer
    infoText As String * 96
    lastHyperFuelUse As Double
    models(1 To MAX_MODELS) As WireModel
    objects(1 To MAX_OBJECTS) As SpaceObject
    camYaw As Double
    camPitch As Double
    camRoll As Double
    uiRefreshIntervalSec As Double
    uiRefreshCountdownSec As Double
    forceRedraw As Integer
    yardimAcik As Integer
    yardimSayfa As Integer
End Type

Declare Sub InitGame(ByRef game As GameState)
Declare Sub TickGame(ByRef game As GameState, ByVal dt As Double)
Declare Sub TickAllMarkets(ByRef game As GameState, ByVal dt As Double)
Declare Sub TickMarket(ByRef m As Market, ByVal dt As Double)
Declare Sub ApplySystemEconomy(ByRef game As GameState, ByVal systemId As Integer)

Declare Sub RecalcCargoUsed(ByRef p As Player)
Declare Function BuyGood(ByRef p As Player, ByRef m As Market, ByVal goodId As Integer, ByVal qty As Integer, ByRef msg As String) As Integer
Declare Function SellGood(ByRef p As Player, ByRef m As Market, ByVal goodId As Integer, ByVal qty As Integer, ByRef msg As String) As Integer
Declare Function BuyFuel(ByRef p As Player, ByRef m As Market, ByVal amount As Double, ByRef msg As String) As Integer
Declare Function BuyHyperFuel(ByRef p As Player, ByRef m As Market, ByVal amount As Double, ByRef msg As String) As Integer
Declare Function BuyAmmo(ByRef p As Player, ByRef m As Market, ByVal amount As Integer, ByRef msg As String) As Integer
Declare Function BuyCargoUpgrade(ByRef game As GameState, ByRef msg As String) As Integer
Declare Function BuyFuelTankUpgrade(ByRef game As GameState, ByRef msg As String) As Integer
Declare Function BuyHyperUpgrade(ByRef game As GameState, ByRef msg As String) As Integer

Declare Sub GenerateMission(ByRef game As GameState)
Declare Function JumpToSystem(ByRef game As GameState, ByVal targetId As Integer, ByRef msg As String) As Integer
Declare Sub TrySpawnPassengers(ByRef game As GameState)
Declare Function BoardPassenger(ByRef game As GameState, ByRef msg As String) As Integer
Declare Sub ResolveArrivedPassengers(ByRef game As GameState, ByRef msg As String)

Declare Sub DrawUI(ByRef game As GameState)
Declare Sub HandleInput(ByRef game As GameState)
Declare Sub InitWireModels(ByRef game As GameState)
Declare Sub InitObjects(ByRef game As GameState)
Declare Sub TickFlightObjects(ByRef game As GameState, ByVal dt As Double)
Declare Sub DrawWireframeLayer(ByRef game As GameState, ByVal x As Integer, ByVal y As Integer, ByVal w As Integer, ByVal h As Integer)

#endif
