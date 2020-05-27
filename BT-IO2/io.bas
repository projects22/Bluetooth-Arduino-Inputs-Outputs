B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=9.801
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	Dim out1, out2, out3, out4 As Byte
	Dim temp As Float
End Sub

Sub Globals
	Private tbtn1, tbtn2, tbtn3, tbtn4 As ToggleButton
	Private in1, in2, in3, in4 As ImageView
	Private analog1, analog2 As EditText

	Private temp1 As EditText
	Private bar1 As SeekBar
End Sub

Sub Activity_Create(FirstTime As Boolean)
	Activity.LoadLayout("io")		' load the layout

End Sub

Public Sub UpdateState
	'Button1.Enabled = Starter.Manager.ConnectionState
	'Button2.Enabled = Starter.Manager.ConnectionState
End Sub

Public Sub NewMessage (msg() As Byte)
	Dim a1, a2 As Int
	'Log("L" & msg.Length)
	'Log("V" & msg(0))
	
	If msg.Length > 9 Then

		If msg(0) = 1 Then in1.Color=(Colors.Green) Else in1.Color=(Colors.Red)
		If msg(1) = 1 Then in2.Color=(Colors.Green) Else in2.Color=(Colors.Red)
		If msg(2) = 1 Then in3.Color=(Colors.Green) Else in3.Color=(Colors.Red)
		If msg(3) = 1 Then in4.Color=(Colors.Green) Else in4.Color=(Colors.Red)
		
		If msg(4) < 0 Then a1=msg(4)+255 Else a1=msg(4)
		If msg(6) < 0 Then a2=msg(6)+255 Else a2=msg(6)
		analog1.Text = NumberFormat((a1 + msg(5)*256)*5/1024,1,3) & " V"
		analog2.Text = NumberFormat((a2 + msg(7)*256)*5/1024,1,3) & " V"
		
		If msg(8) < 0 Then a1=msg(8)+255 Else a1=msg(8)
		temp = (a1 + msg(9)*256) / 100.0
		temp1.Text = NumberFormat(temp,1,1) & " °C"
		
		send
	End If
	


End Sub


Sub send
	Dim outB As Byte
	Dim Bout(1) As Byte
	Dim str1 As String

	outB=out1 + out2*2 + out3*4 + out4*8
	Bout(0)=bar1.value
	str1=BytesToString(Bout,0,1,"UTF-8")
	
	Starter.Manager.SendMessage(outB)	
	Starter.Manager.SendMessage(str1)

End Sub

Sub tbtn1_CheckedChange(Checked As Boolean)
	If Checked Then out1=1 Else out1=0
End Sub

Sub tbtn2_CheckedChange(Checked As Boolean)
	If Checked Then out2=1 Else out2=0
End Sub

Sub tbtn3_CheckedChange(Checked As Boolean)
	If Checked Then out3=1 Else out3=0
End Sub

Sub tbtn4_CheckedChange(Checked As Boolean)
	If Checked Then out4=1 Else out4=0
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub
