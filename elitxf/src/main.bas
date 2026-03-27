#include once "types.bi"
#include once "flight.bi"
#include once "economy.bi"
#include once "ui.bi"

Dim Shared Game As GameState
Dim lastT As Double
Dim nowT As Double
Dim dt As Double

ScreenRes 1280, 760, 32
Color RGB(240, 240, 240), RGB(6, 12, 18)
Cls

InitGame Game
lastT = Timer

Do While Game.running <> 0
    nowT = Timer
    dt = nowT - lastT

    If dt < 0 Then dt = 0
    If dt > 0.25 Then dt = 0.25
    lastT = nowT

    HandleInput Game
    TickGame Game, dt

    If Game.forceRedraw <> 0 Then
        DrawUI Game
        Game.forceRedraw = 0
    End If

    Sleep 33, 1
Loop

Cls
Draw String (20, 30), "Cikis yapildi.", RGB(255,255,255)
Draw String (20, 55), "Toplam kar/zarar: " & Str(Int(Game.player.profitTotal)), RGB(255,255,255)
Draw String (20, 80), "Odenen toplam vergi: " & Str(Int(Game.player.taxPaidTotal)), RGB(255,255,255)
Sleep
