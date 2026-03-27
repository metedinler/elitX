#include once "types.bi"

Private Sub SetV(ByRef m As WireModel, ByVal idx As Integer, ByVal x As Double, ByVal y As Double, ByVal z As Double)
    m.verts(idx).x = x
    m.verts(idx).y = y
    m.verts(idx).z = z
End Sub

Private Sub SetE(ByRef m As WireModel, ByVal idx As Integer, ByVal a As Integer, ByVal b As Integer)
    m.edgeA(idx) = a
    m.edgeB(idx) = b
End Sub

Sub InitWireModels(ByRef game As GameState)
    Dim i As Integer
    For i = 1 To MAX_MODELS
        game.models(i).vCount = 0
        game.models(i).eCount = 0
    Next i

    ' 1) Elmas
    game.models(1).name = "Elmas"
    game.models(1).vCount = 6
    SetV game.models(1), 1, 0, 0, 18
    SetV game.models(1), 2, 0, 0, -18
    SetV game.models(1), 3, 10, 0, 0
    SetV game.models(1), 4, -10, 0, 0
    SetV game.models(1), 5, 0, 7, 0
    SetV game.models(1), 6, 0, -7, 0
    game.models(1).eCount = 12
    SetE game.models(1), 1, 1, 3: SetE game.models(1), 2, 1, 4
    SetE game.models(1), 3, 1, 5: SetE game.models(1), 4, 1, 6
    SetE game.models(1), 5, 2, 3: SetE game.models(1), 6, 2, 4
    SetE game.models(1), 7, 2, 5: SetE game.models(1), 8, 2, 6
    SetE game.models(1), 9, 3, 5: SetE game.models(1), 10, 5, 4
    SetE game.models(1), 11, 4, 6: SetE game.models(1), 12, 6, 3

    ' 2) Kup
    game.models(2).name = "Kup"
    game.models(2).vCount = 8
    SetV game.models(2), 1, -12, -12, -12
    SetV game.models(2), 2, 12, -12, -12
    SetV game.models(2), 3, 12, 12, -12
    SetV game.models(2), 4, -12, 12, -12
    SetV game.models(2), 5, -12, -12, 12
    SetV game.models(2), 6, 12, -12, 12
    SetV game.models(2), 7, 12, 12, 12
    SetV game.models(2), 8, -12, 12, 12
    game.models(2).eCount = 12
    SetE game.models(2), 1, 1, 2: SetE game.models(2), 2, 2, 3
    SetE game.models(2), 3, 3, 4: SetE game.models(2), 4, 4, 1
    SetE game.models(2), 5, 5, 6: SetE game.models(2), 6, 6, 7
    SetE game.models(2), 7, 7, 8: SetE game.models(2), 8, 8, 5
    SetE game.models(2), 9, 1, 5: SetE game.models(2), 10, 2, 6
    SetE game.models(2), 11, 3, 7: SetE game.models(2), 12, 4, 8

    ' 3) Avci (daha uzay gemisi gibi)
    game.models(3).name = "Avci"
    game.models(3).vCount = 10
    SetV game.models(3), 1, 0, 0, 24
    SetV game.models(3), 2, 0, 0, -20
    SetV game.models(3), 3, 14, 2, 2
    SetV game.models(3), 4, -14, 2, 2
    SetV game.models(3), 5, 18, 0, -6
    SetV game.models(3), 6, -18, 0, -6
    SetV game.models(3), 7, 6, 5, -8
    SetV game.models(3), 8, -6, 5, -8
    SetV game.models(3), 9, 6, -5, -8
    SetV game.models(3), 10, -6, -5, -8
    game.models(3).eCount = 18
    SetE game.models(3), 1, 1, 3: SetE game.models(3), 2, 1, 4
    SetE game.models(3), 3, 1, 7: SetE game.models(3), 4, 1, 8
    SetE game.models(3), 5, 1, 9: SetE game.models(3), 6, 1, 10
    SetE game.models(3), 7, 3, 5: SetE game.models(3), 8, 4, 6
    SetE game.models(3), 9, 5, 2: SetE game.models(3), 10, 6, 2
    SetE game.models(3), 11, 7, 2: SetE game.models(3), 12, 8, 2
    SetE game.models(3), 13, 9, 2: SetE game.models(3), 14, 10, 2
    SetE game.models(3), 15, 7, 8: SetE game.models(3), 16, 9, 10
    SetE game.models(3), 17, 5, 7: SetE game.models(3), 18, 6, 8

    ' 4) Yuk gemisi
    game.models(4).name = "Nakliye"
    game.models(4).vCount = 10
    SetV game.models(4), 1, 0, 0, 22
    SetV game.models(4), 2, 0, 0, -24
    SetV game.models(4), 3, 12, 8, 8
    SetV game.models(4), 4, -12, 8, 8
    SetV game.models(4), 5, 12, -8, 8
    SetV game.models(4), 6, -12, -8, 8
    SetV game.models(4), 7, 10, 8, -10
    SetV game.models(4), 8, -10, 8, -10
    SetV game.models(4), 9, 10, -8, -10
    SetV game.models(4), 10, -10, -8, -10
    game.models(4).eCount = 20
    SetE game.models(4), 1, 1, 3: SetE game.models(4), 2, 1, 4
    SetE game.models(4), 3, 1, 5: SetE game.models(4), 4, 1, 6
    SetE game.models(4), 5, 3, 4: SetE game.models(4), 6, 5, 6
    SetE game.models(4), 7, 3, 7: SetE game.models(4), 8, 4, 8
    SetE game.models(4), 9, 5, 9: SetE game.models(4), 10, 6, 10
    SetE game.models(4), 11, 7, 8: SetE game.models(4), 12, 9, 10
    SetE game.models(4), 13, 7, 2: SetE game.models(4), 14, 8, 2
    SetE game.models(4), 15, 9, 2: SetE game.models(4), 16, 10, 2
    SetE game.models(4), 17, 7, 9: SetE game.models(4), 18, 8, 10
    SetE game.models(4), 19, 3, 5: SetE game.models(4), 20, 4, 6
End Sub

Sub InitObjects(ByRef game As GameState)
    Dim i As Integer
    For i = 1 To MAX_OBJECTS
        game.objects(i).active = 0
    Next i

    game.objects(1).active = 1: game.objects(1).modelId = 3
    game.objects(1).pos.z = 220: game.objects(1).pos.x = -40: game.objects(1).vel.z = -8

    game.objects(2).active = 1: game.objects(2).modelId = 4
    game.objects(2).pos.z = 340: game.objects(2).pos.x = 70: game.objects(2).vel.z = -5

    game.objects(3).active = 1: game.objects(3).modelId = 1
    game.objects(3).pos.z = 280: game.objects(3).pos.x = 10: game.objects(3).vel.z = -6

    game.objects(4).active = 1: game.objects(4).modelId = 2
    game.objects(4).pos.z = 440: game.objects(4).pos.x = 0: game.objects(4).vel.z = -3

    game.camYaw = 0
    game.camPitch = 0
    game.camRoll = 0
End Sub

Sub TickFlightObjects(ByRef game As GameState, ByVal dt As Double)
    Dim i As Integer
    For i = 1 To MAX_OBJECTS
        If game.objects(i).active <> 0 Then
            game.objects(i).pos.z += game.objects(i).vel.z * dt * 30
            game.objects(i).yaw += dt * 0.9
            game.objects(i).roll += dt * 0.6
            If game.objects(i).pos.z < 60 Then
                game.objects(i).pos.z = 420 + Rnd * 260
                game.objects(i).pos.x = (Rnd - 0.5) * 180
                game.objects(i).pos.y = (Rnd - 0.5) * 80
            End If
        End If
    Next i
End Sub

Private Sub RotateY(ByVal x As Double, ByVal z As Double, ByVal a As Double, ByRef ox As Double, ByRef oz As Double)
    Dim ca As Double, sa As Double
    ca = Cos(a): sa = Sin(a)
    ox = x * ca + z * sa
    oz = -x * sa + z * ca
End Sub

Private Sub RotateX(ByVal y As Double, ByVal z As Double, ByVal a As Double, ByRef oy As Double, ByRef oz As Double)
    Dim ca As Double, sa As Double
    ca = Cos(a): sa = Sin(a)
    oy = y * ca - z * sa
    oz = y * sa + z * ca
End Sub

Sub DrawWireframeLayer(ByRef game As GameState, ByVal x As Integer, ByVal y As Integer, ByVal w As Integer, ByVal h As Integer)
    Dim i As Integer, e As Integer
    Dim m As WireModel
    Dim obj As SpaceObject
    Dim cx As Integer, cy As Integer
    Dim fov As Double
    cx = x + w \ 2
    cy = y + h \ 2
    fov = 420

    ' Alan cercevesi
    Line (x, y)-(x + w, y + h), RGB(40, 110, 140), B

    For i = 1 To MAX_OBJECTS
        If game.objects(i).active <> 0 Then
            obj = game.objects(i)
            If obj.modelId >= 1 And obj.modelId <= MAX_MODELS Then
                m = game.models(obj.modelId)

                For e = 1 To m.eCount
                    Dim a As Integer, b As Integer
                    Dim ax As Double, ay As Double, az As Double
                    Dim bx As Double, by As Double, bz As Double
                    Dim rx As Double, rz As Double
                    Dim ry As Double, rz2 As Double

                    a = m.edgeA(e): b = m.edgeB(e)
                    If a < 1 Or b < 1 Or a > m.vCount Or b > m.vCount Then Continue For

                    ax = m.verts(a).x: ay = m.verts(a).y: az = m.verts(a).z
                    bx = m.verts(b).x: by = m.verts(b).y: bz = m.verts(b).z

                    RotateY ax, az, obj.yaw, rx, rz
                    ax = rx: az = rz
                    RotateX ay, az, obj.roll, ry, rz2
                    ay = ry: az = rz2

                    RotateY bx, bz, obj.yaw, rx, rz
                    bx = rx: bz = rz
                    RotateX by, bz, obj.roll, ry, rz2
                    by = ry: bz = rz2

                    ax += obj.pos.x: ay += obj.pos.y: az += obj.pos.z
                    bx += obj.pos.x: by += obj.pos.y: bz += obj.pos.z

                    ' Oyuncu kamerasi: sahneyi ters acilarla dondur.
                    RotateY ax, az, -game.camYaw, rx, rz
                    ax = rx: az = rz
                    RotateX ay, az, -game.camPitch, ry, rz2
                    ay = ry: az = rz2

                    RotateY bx, bz, -game.camYaw, rx, rz
                    bx = rx: bz = rz
                    RotateX by, bz, -game.camPitch, ry, rz2
                    by = ry: bz = rz2

                    If az > 8 And bz > 8 Then
                        Dim sx1 As Integer, sy1 As Integer
                        Dim sx2 As Integer, sy2 As Integer
                        sx1 = cx + CInt((ax / az) * fov)
                        sy1 = cy - CInt((ay / az) * fov)
                        sx2 = cx + CInt((bx / bz) * fov)
                        sy2 = cy - CInt((by / bz) * fov)
                        If sx1 >= x And sx1 <= x + w And sy1 >= y And sy1 <= y + h Then
                            Line (sx1, sy1)-(sx2, sy2), RGB(0, 255, 170)
                        End If
                    End If
                Next e
            End If
        End If
    Next i

    Line (cx - 8, cy)-(cx + 8, cy), RGB(255, 255, 255)
    Line (cx, cy - 8)-(cx, cy + 8), RGB(255, 255, 255)
End Sub
