VERSION 5.00
Object = "*\ACylinder\Cylinder.vbp"
Object = "*\ATray\Project2.vbp"
Object = "{A18AEC58-08CF-4A76-A805-965BD9C0A299}#1.0#0"; "xShape.ocx"
Begin VB.Form frmMach 
   BackColor       =   &H00FFFFFF&
   Caption         =   "Form1"
   ClientHeight    =   6375
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7410
   Icon            =   "frmMach.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   6375
   ScaleWidth      =   7410
   WindowState     =   2  'Maximized
   Begin xShape.Shape Shape 
      Height          =   435
      Index           =   0
      Left            =   3360
      TabIndex        =   9
      Top             =   4980
      Visible         =   0   'False
      Width           =   435
      _extentx        =   767
      _extenty        =   767
      moveshape       =   0   'False
   End
   Begin VB.Frame Frame1 
      Caption         =   "Frame1"
      Height          =   1755
      Left            =   5640
      TabIndex        =   4
      Top             =   660
      Width           =   1635
      Begin VB.OptionButton Option4 
         Caption         =   "Left"
         Height          =   315
         Left            =   120
         TabIndex        =   8
         Top             =   1320
         Value           =   -1  'True
         Width           =   1215
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Down"
         Height          =   255
         Left            =   120
         TabIndex        =   7
         Top             =   960
         Width           =   975
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Right"
         Height          =   315
         Left            =   120
         TabIndex        =   6
         Top             =   600
         Width           =   1155
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Up"
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Top             =   300
         Width           =   1275
      End
   End
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   4380
      TabIndex        =   3
      Text            =   "100"
      Top             =   1260
      Width           =   1155
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Operate"
      Height          =   435
      Left            =   4380
      TabIndex        =   2
      Top             =   660
      Width           =   1095
   End
   Begin Project2.Tray tray 
      Height          =   555
      Index           =   0
      Left            =   2460
      TabIndex        =   1
      Top             =   5340
      Visible         =   0   'False
      Width           =   615
      _extentx        =   1085
      _extenty        =   979
      font            =   "frmMach.frx":030A
   End
   Begin Project1.Cylinder cyl 
      Height          =   435
      Index           =   0
      Left            =   600
      TabIndex        =   0
      Top             =   5520
      Visible         =   0   'False
      Width           =   975
      _extentx        =   1931
      _extenty        =   1085
      font            =   "frmMach.frx":0336
   End
End
Attribute VB_Name = "frmMach"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'********************************************************
' Machine form...allows for constructing of machines
' Written by Chuck Bolin, November 2003
'********************************************************
Option Explicit
Private intXOffset, intYOffset As Integer 'used for drag and drop operations
Private mintObject As Integer 'number of object

Private Sub Command1_Click()
 If mintObject > 0 Then
   cyl(mintObject).speed = CInt(Text1.Text)
   cyl(mintObject).Extend = Not cyl(mintObject).Extend
 End If
End Sub

Private Sub cyl_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
  
  If Button = 1 Then
    intXOffset = X: intYOffset = -Y
    cyl(Index).Drag vbBeginDrag
    mintObject = Index
    cyl(Index).MousePointer = 5
  End If
  If Button = 2 Then
     mintObject = Index
  End If
End Sub

Private Sub Form_Click()
  Command1.SetFocus

End Sub

Private Sub Form_DragDrop(Source As Control, X As Single, Y As Single)
  Source.Move X - intXOffset, Y - intYOffset 'drops whatever control is being dragged
End Sub

Private Sub Form_Load()
  frmMach.Caption = "Machine Layout and Design"
  frmMain.EnableToolbar True
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
  frmMain.sbrStatus.Panels(1) = "X: " & X
  frmMain.sbrStatus.Panels(2) = "Y: " & CInt(Y)
End Sub

Private Sub Form_Resize()
  frmMach.ScaleTop = frmMach.Height
  frmMach.ScaleHeight = -frmMach.Height
End Sub

Private Sub Form_Unload(Cancel As Integer)
  frmMain.mnuFileNew.Enabled = True
  frmMain.EnableToolbar False
End Sub

Private Sub Shape_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
  If Button = 1 Then
    intXOffset = X: intYOffset = -Y
    Shape(Index).Drag vbBeginDrag
    mintObject = Index
  End If
  If Button = 2 Then
     mintObject = Index
  End If
End Sub

Private Sub tray_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
  If Button = 1 Then
    intXOffset = X: intYOffset = Y
    tray(Index).Drag vbBeginDrag
  End If
End Sub
