object FormGotoLine: TFormGotoLine
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1055#1077#1088#1077#1081#1090#1080' '#1085#1072' '#1089#1090#1088#1086#1082#1091
  ClientHeight = 107
  ClientWidth = 289
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001000F0D000001001800CC02000016000000280000000F0000001A00
    0000010018000000000070020000000000000000000000000000000000000000
    00000000000000000000A8A8A8553F2A553F2A553F2A553F2A553F2A553F2A55
    3F2A553F2A553F2A808080000000000000000000000000000000808080AAFFFF
    98F7FF98F7FF98F7FF98F7FF98F7FF98F7FF98F7FF98F7FF553F2A0000000000
    00000000000000000000808080AAFFFFD9A77D8F6F1C8F6F1C8F6F1C8F6F1C8F
    6F1C8F6F1C98F7FF553F2A000000553F2A00000000000000000080808098F7FF
    98F7FF98F7FF98F7FF98F7FF98F7FF98F7FF98F7FF98F7FF553F2A000000553F
    2A553F2A000000000000808080FFE49EFFE49EFFE49EFFE49EFFE49EFFE49EFF
    E49EFFE49EFFE49E553F2A000000553F2A553F2A553F2A000000808080FFE49E
    D9A77D8F6F1C8F6F1C8F6F1C8F6F1C8F6F1C8F6F1CFFE49E553F2A000000553F
    2A553F2A000000000000808080FFE49EFFE49EFFE49EFFE49EFFE49EFFE49EFF
    E49EFFE49EFFE49E553F2A000000553F2A000000000000000000808080AAFFFF
    98F7FF98F7FF98F7FF98F7FF98F7FF98F7FF98F7FF98F7FF553F2A0000000000
    00000000000000000000808080AAFFFFD9A77D8F6F1C8F6F1C8F6F1C98F7FF55
    DFFF55DFFF55DFFF553F2A000000000000000000000000000000808080AAFFFF
    98F7FF98F7FF98F7FF98F7FF98F7FF808080808080808080553F2A0000000000
    00000000000000000000808080AAFFFF98F7FFD9A77D8F6F1C8F6F1C98F7FF80
    808098F7FFAAFFFF553F2A000000000000000000000000000000808080AAFFFF
    98F7FF98F7FF98F7FF98F7FF98F7FF808080AAFFFF553F2A0000000000000000
    0000000000000000000091919180808080808080808080808080808080808080
    8080553F2A000000000000000000F0000000F0000000F0000000700000003000
    0000100000003000000070000000F0000000F0000000F0000000F0020000F006
    0000}
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 289
    Height = 66
    Align = alClient
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 10
      Width = 69
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1089#1090#1088#1086#1082#1080
    end
    object ComboBox1: TComboBox
      Left = 8
      Top = 29
      Width = 275
      Height = 21
      TabOrder = 0
      OnKeyPress = ComboBox1KeyPress
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 66
    Width = 289
    Height = 41
    Align = alBottom
    TabOrder = 1
    object Button1: TButton
      Left = 125
      Top = 9
      Width = 75
      Height = 25
      Caption = #1054#1050
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 210
      Top = 9
      Width = 75
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      ModalResult = 11
      TabOrder = 1
    end
  end
end