#include once "types.bi"

Private Function PadRight(ByVal t As String, ByVal w As Integer) As String
    Dim s As String
    s = Left(t, w)
    If Len(s) < w Then s &= String(w - Len(s), " ")
    Return s
End Function

Private Function PadLeft(ByVal t As String, ByVal w As Integer) As String
    Dim s As String
    s = Trim(t)
    If Len(s) < w Then s = String(w - Len(s), " ") & s
    Return Left(s, w)
End Function

Private Function Fmt2(ByVal v As Double) As String
    Return Trim(Str(Int(v * 100) / 100))
End Function

Private Sub Txt(ByVal x As Integer, ByVal y As Integer, ByVal s As String, ByVal col As UInteger = RGB(230,230,230))
    Draw String (x, y), s, col
End Sub

Private Sub DrawBox(ByVal x As Integer, ByVal y As Integer, ByVal w As Integer, ByVal h As Integer, ByVal title As String)
    Line (x, y)-(x + w, y + h), RGB(80, 120, 140), B
    Line (x + 1, y + 1)-(x + w - 1, y + h - 1), RGB(25, 50, 60), B
    If Len(title) > 0 Then Txt x + 8, y + 6, "[" & title & "]", RGB(180, 220, 240)
End Sub

Private Sub DrawTradePanel(ByRef game As GameState, ByVal x As Integer, ByVal y As Integer, ByVal w As Integer, ByVal h As Integer)
    Dim cur As Integer, i As Integer, rowY As Integer
    Dim m As Market
    Dim lineText As String

    cur = game.player.currentSystemId
    m = game.systems(cur).market

    DrawBox x, y, w, h, "Ticaret (Sol Panel)"

    Txt x + 12, y + 28, PadRight("#", 3) & PadRight("Mal", 18) & PadLeft("Fiyat", 10) & PadLeft("Stok", 8) & PadLeft("Trend", 9) & PadLeft("Gemide", 9), RGB(200,220,255)

    rowY = y + 50
    For i = 1 To MAX_GOODS
        lineText = PadLeft(Str(i), 2) & " "
        If i = game.selectedGood Then lineText &= ">" Else lineText &= " "
        lineText &= PadRight(Trim(m.goods(i).name), 17)
        lineText &= PadLeft(Fmt2(m.goods(i).price), 10)
        lineText &= PadLeft(Str(m.goods(i).stock), 8)
        lineText &= PadLeft(Fmt2(m.goods(i).trend), 9)
        lineText &= PadLeft(Str(game.player.cargoQty(i)), 9)

        If i = game.selectedGood Then
            Line (x + 8, rowY - 1)-(x + w - 8, rowY + 14), RGB(70, 70, 30), BF
            Txt x + 12, rowY, lineText, RGB(255, 245, 140)
        Else
            Txt x + 12, rowY, lineText, RGB(220, 230, 230)
        End If
        rowY += 16
    Next i

    Txt x + 12, y + h - 44, "Tuslar: W/S sec  B al  N sat  F yakit  H hiper  A mermi", RGB(165, 220, 185)
    Txt x + 12, y + h - 24, "Upgrade: C kargo+  Y tank+  M hiper+", RGB(165, 220, 185)
End Sub

Private Sub DrawRightPanel(ByRef game As GameState, ByVal x As Integer, ByVal y As Integer, ByVal w As Integer, ByVal h As Integer)
    Dim cur As Integer, i As Integer, row As Integer
    Dim m As Market

    cur = game.player.currentSystemId
    m = game.systems(cur).market

    DrawBox x, y, w, h, "Gemi Durumu / Vergi / Yolcu (Sag Panel)"

    Txt x + 12, y + 28, "Sistem: " & Trim(game.systems(cur).name)
    Txt x + 12, y + 46, "Kredi:       " & PadLeft(Fmt2(game.player.credits), 12)
    Txt x + 12, y + 64, "Kar/Zarar:   " & PadLeft(Fmt2(game.player.profitTotal), 12)
    Txt x + 12, y + 82, "Vergi Top.:  " & PadLeft(Fmt2(game.player.taxPaidTotal), 12)
    Txt x + 12, y + 100, "Son Vergi:   " & PadLeft(Fmt2(m.lastTax), 12)

    Txt x + 12, y + 126, "Normal Yakit:" & PadLeft(Fmt2(game.player.fuel), 8) & "/" & PadLeft(Fmt2(game.player.fuelMax), 8)
    Txt x + 12, y + 144, "Hiper Yakit: " & PadLeft(Fmt2(game.player.hyperFuel), 8) & "/" & PadLeft(Fmt2(game.player.hyperFuelMax), 8)
    Txt x + 12, y + 162, "Hiper Tuketim:" & PadLeft(Fmt2(game.lastHyperFuelUse), 10)
    Txt x + 12, y + 180, "Mermi:       " & PadLeft(Str(game.player.ammo), 12)

    Txt x + 12, y + 206, "Kargo:       " & PadLeft(Str(game.player.cargoUsed), 5) & "/" & PadLeft(Str(game.player.cargoCapacity), 5)

    Txt x + 12, y + 234, "Gemideki Yukler", RGB(200, 220, 255)
    row = y + 254
    For i = 1 To MAX_GOODS
        If game.player.cargoQty(i) > 0 Then
            Txt x + 12, row, PadRight("- " & Trim(m.goods(i).name), 24) & PadLeft(Str(game.player.cargoQty(i)), 6)
            row += 16
            If row > y + 350 Then Exit For
        End If
    Next i
    If row = y + 254 Then Txt x + 12, row, "- bos -"

    Txt x + 12, y + h - 110, "Yolcular", RGB(200, 220, 255)
    row = y + h - 90
    For i = 1 To MAX_PASSENGERS
        If game.passengers(i).active = 2 Then
            Txt x + 12, row, PadRight("- " & Trim(game.systems(game.passengers(i).destStar).name), 22) & PadLeft(Fmt2(game.passengers(i).fare), 8)
            row += 16
            If row > y + h - 32 Then Exit For
        End If
    Next i
    If row = y + h - 90 Then Txt x + 12, row, "- yolcu yok -"
End Sub

Sub DrawUI(ByRef game As GameState)
    Dim cur As Integer
    Dim m As Market
    Dim modeName As String

    cur = game.player.currentSystemId
    m = game.systems(cur).market

    Select Case game.uiMode
        Case MODE_TRADE
            modeName = "TICARET"
        Case MODE_FLIGHT
            modeName = "UCUS"
        Case MODE_WIREFRAME
            modeName = "TEL-CERCEVE"
        Case Else
            modeName = "BILINMEYEN"
    End Select

    ScreenLock
    Cls

    Txt 12, 10, "elitxf - ROOT GameState Mimari (FreeBASIC)", RGB(255,255,255)
    Txt 12, 32, "Mod: " & modeName & "   Sistem: " & Trim(game.systems(cur).name) & "   Hedef Sistem: " & Trim(game.systems(game.selectedSystem).name), RGB(210,230,255)
    Txt 12, 54, "Borsa guncellemesine kalan sure: " & PadLeft(Str(Int(m.updateCountdownSec)), 3) & " sn", RGB(255,220,120)
    Txt 430, 54, "Uretilen mal: " & Trim(m.goods(m.productionGood).name), RGB(200,255,180)

    If game.uiMode = MODE_WIREFRAME Then
        DrawBox 12, 80, 1258, 620, "Tel-Cerceve Ucus Sayfasi"
        DrawWireframeLayer game, 40, 120, 1200, 520
        Txt 48, 650, "Gercekci gemi siluetleri: Avci / Nakliye + Elmas / Kup", RGB(160,220,180)
        Txt 48, 674, "Bu ekran ayridir; ticaret tuslari burada etkisizdir.", RGB(160,220,180)
    Else
        DrawTradePanel game, 12, 80, 760, 620
        DrawRightPanel game, 790, 80, 480, 620
    End If

    If game.uiMode = MODE_TRADE Then
        Txt 12, 710, "UP/DOWN mal sec | LEFT/RIGHT hedef sistem | B/N al-sat | T/U/V mod | F1/? yardim", RGB(180,220,255)
    ElseIf game.uiMode = MODE_FLIGHT Then
        Txt 12, 710, "UP/DOWN/LEFT/RIGHT kamera | J atla | P yolcu | G gorev | T/U/V mod | F1/? yardim", RGB(180,220,255)
    Else
        Txt 12, 710, "UP/DOWN/LEFT/RIGHT kamera | T ticaret | U ucus | V tel-cerceve | F1/? yardim", RGB(180,220,255)
    End If
    Txt 12, 730, "Bilgi: " & Trim(game.infoText), RGB(255,245,170)

    If game.yardimAcik <> 0 Then
        DrawBox 120, 80, 1040, 600, "Yardim - Sayfa " & Trim(Str(game.yardimSayfa)) & "/2"
        Line (130, 120)-(1150, 660), RGB(8, 20, 26), BF

        If game.yardimSayfa = 1 Then
            Txt 150, 140, "Genel Kontroller", RGB(220, 245, 255)
            Txt 150, 170, "ESC: Oyundan cik", RGB(210, 230, 230)
            Txt 150, 195, "T / U / V: Mod degistir (Ticaret / Ucus / Tel-Cerceve)", RGB(210, 230, 230)
            Txt 150, 220, "F1 veya ?: Yardimi ac/kapat", RGB(210, 230, 230)
            Txt 150, 245, "J: Secili sisteme atla", RGB(210, 230, 230)
            Txt 150, 270, "G: Yeni gorev olustur", RGB(210, 230, 230)
            Txt 150, 295, "P: Yolcu al", RGB(210, 230, 230)
            Txt 150, 320, "", RGB(210, 230, 230)
            Txt 150, 345, "Ticaret Modu", RGB(220, 245, 255)
            Txt 150, 370, "UP/DOWN: Mal secimi", RGB(210, 230, 230)
            Txt 150, 395, "LEFT/RIGHT: Hedef sistem secimi", RGB(210, 230, 230)
            Txt 150, 420, "B/N: Al/Sat", RGB(210, 230, 230)
            Txt 150, 445, "F/H/A: Yakit/Hiper/Mermi al", RGB(210, 230, 230)
            Txt 150, 470, "C/Y/M: Kargo/Tank/Hiper upgrade", RGB(210, 230, 230)
        Else
            Txt 150, 140, "Ucus ve Tel-Cerceve Kontrolleri", RGB(220, 245, 255)
            Txt 150, 170, "UP/DOWN: Kamera pitch", RGB(210, 230, 230)
            Txt 150, 195, "LEFT/RIGHT: Kamera yaw", RGB(210, 230, 230)
            Txt 150, 220, "Ucus modunda yakit zamanla azalir.", RGB(210, 230, 230)
            Txt 150, 245, "V modunda tel-cerceve ayri sayfada cizilir.", RGB(210, 230, 230)
            Txt 150, 270, "V modundan geri donus: T (ticaret) veya U (ucus)", RGB(210, 230, 230)
            Txt 150, 295, "", RGB(210, 230, 230)
            Txt 150, 320, "Ipuclari", RGB(220, 245, 255)
            Txt 150, 345, "Borsa her 30 saniyede guncellenir.", RGB(210, 230, 230)
            Txt 150, 370, "Bilgi satiri (alt kisim) son olayi gosterir.", RGB(210, 230, 230)
            Txt 150, 395, "Kargo doluysa alis engellenir.", RGB(210, 230, 230)
            Txt 150, 420, "Hedef sistemi LEFT/RIGHT ile ayarlayip J ile atla.", RGB(210, 230, 230)
        End If

        Txt 150, 620, "Sayfa degistir: UP/DOWN  | Yardimi kapat: F1 veya ?", RGB(255, 235, 140)
    End If

    ScreenUnlock
End Sub

Sub HandleInput(ByRef game As GameState)
    Dim k As String
    Dim ext As Integer
    Dim cur As Integer
    Dim msg As String

    cur = game.player.currentSystemId
    k = Inkey
    If Len(k) = 0 Then Exit Sub

    game.forceRedraw = 1

    ext = -1
    If Len(k) = 2 Then
        If Asc(Left(k, 1)) = 255 Then ext = Asc(Right(k, 1))
    End If

    If ext = 59 Or k = "?" Then
        If game.yardimAcik = 0 Then
            game.yardimAcik = 1
            game.yardimSayfa = 1
        Else
            game.yardimAcik = 0
        End If
        Exit Sub
    End If

    If game.yardimAcik <> 0 Then
        Select Case ext
            Case 72
                game.yardimSayfa -= 1
                If game.yardimSayfa < 1 Then game.yardimSayfa = 1
            Case 80
                game.yardimSayfa += 1
                If game.yardimSayfa > 2 Then game.yardimSayfa = 2
        End Select

        If LCase(k) = Chr(27) Then game.yardimAcik = 0
        Exit Sub
    End If

    If game.uiMode = MODE_TRADE Then
        Select Case ext
            Case 72
                game.selectedGood -= 1
                If game.selectedGood < 1 Then game.selectedGood = MAX_GOODS
                Exit Sub
            Case 80
                game.selectedGood += 1
                If game.selectedGood > MAX_GOODS Then game.selectedGood = 1
                Exit Sub
            Case 75
                game.selectedSystem -= 1
                If game.selectedSystem < 1 Then game.selectedSystem = MAX_SYSTEMS
                Exit Sub
            Case 77
                game.selectedSystem += 1
                If game.selectedSystem > MAX_SYSTEMS Then game.selectedSystem = 1
                Exit Sub
        End Select
    ElseIf game.uiMode = MODE_FLIGHT Or game.uiMode = MODE_WIREFRAME Then
        Select Case ext
            Case 72
                game.camPitch -= 0.06
                game.infoText = "Kamera Pitch: " & Trim(Str(Int(game.camPitch * 100) / 100))
                Exit Sub
            Case 80
                game.camPitch += 0.06
                game.infoText = "Kamera Pitch: " & Trim(Str(Int(game.camPitch * 100) / 100))
                Exit Sub
            Case 75
                game.camYaw -= 0.08
                game.infoText = "Kamera Yaw: " & Trim(Str(Int(game.camYaw * 100) / 100))
                Exit Sub
            Case 77
                game.camYaw += 0.08
                game.infoText = "Kamera Yaw: " & Trim(Str(Int(game.camYaw * 100) / 100))
                Exit Sub
        End Select
    End If

    Select Case LCase(k)
        Case Chr(27)
            game.running = 0

        Case "t"
            game.uiMode = MODE_TRADE
        Case "u"
            game.uiMode = MODE_FLIGHT
        Case "v"
            game.uiMode = MODE_WIREFRAME

        Case "w"
            game.selectedGood -= 1
            If game.selectedGood < 1 Then game.selectedGood = MAX_GOODS
        Case "s"
            game.selectedGood += 1
            If game.selectedGood > MAX_GOODS Then game.selectedGood = 1

        Case ","
            game.selectedSystem -= 1
            If game.selectedSystem < 1 Then game.selectedSystem = MAX_SYSTEMS
        Case "."
            game.selectedSystem += 1
            If game.selectedSystem > MAX_SYSTEMS Then game.selectedSystem = 1

        Case "b"
            If game.uiMode = MODE_WIREFRAME Then
                game.infoText = "Tel-cerceve ekraninda ticaret yok. T veya U ile geri don."
            Else
                If BuyGood(game.player, game.systems(cur).market, game.selectedGood, 1, msg) = 0 Then game.infoText = msg Else game.infoText = msg
            End If

        Case "n"
            If game.uiMode = MODE_WIREFRAME Then
                game.infoText = "Tel-cerceve ekraninda ticaret yok. T veya U ile geri don."
            Else
                If SellGood(game.player, game.systems(cur).market, game.selectedGood, 1, msg) = 0 Then game.infoText = msg Else game.infoText = msg
            End If

        Case "f"
            If BuyFuel(game.player, game.systems(cur).market, 10, msg) = 0 Then game.infoText = msg Else game.infoText = msg

        Case "h"
            If BuyHyperFuel(game.player, game.systems(cur).market, 6, msg) = 0 Then game.infoText = msg Else game.infoText = msg

        Case "a"
            If BuyAmmo(game.player, game.systems(cur).market, 10, msg) = 0 Then game.infoText = msg Else game.infoText = msg

        Case "c"
            If BuyCargoUpgrade(game, msg) = 0 Then game.infoText = msg Else game.infoText = msg

        Case "y"
            If BuyFuelTankUpgrade(game, msg) = 0 Then game.infoText = msg Else game.infoText = msg

        Case "m"
            If BuyHyperUpgrade(game, msg) = 0 Then game.infoText = msg Else game.infoText = msg

        Case "p"
            If BoardPassenger(game, msg) = 0 Then game.infoText = msg Else game.infoText = msg

        Case "g"
            GenerateMission(game)
            game.infoText = "Yeni gorev atandi."

        Case "j"
            If JumpToSystem(game, game.selectedSystem, msg) = 0 Then game.infoText = msg Else game.infoText = msg
    End Select
End Sub
