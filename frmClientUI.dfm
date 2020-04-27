object Form2: TForm2
  Left = 0
  Top = 0
  ActiveControl = txtMessage
  Caption = 'Form2'
  ClientHeight = 315
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object imgSelect: TImage
    Left = 407
    Top = 8
    Width = 220
    Height = 240
    Stretch = True
  end
  object txtMessage: TEdit
    Left = 16
    Top = 256
    Width = 321
    Height = 21
    TabOrder = 0
    Text = 'txtMessage'
  end
  object btnCOnnectSV: TButton
    Left = 512
    Top = 254
    Width = 115
    Height = 25
    Caption = 'Connect'
    TabOrder = 1
    OnClick = btnCOnnectSVClick
  end
  object btnSend: TButton
    Left = 512
    Top = 285
    Width = 115
    Height = 25
    Caption = 'Send'
    TabOrder = 2
    OnClick = btnSendClick
  end
  object txtLog: TMemo
    Left = 8
    Top = 8
    Width = 393
    Height = 242
    Lines.Strings = (
      'txtLog')
    TabOrder = 3
  end
  object cbMessageType: TComboBox
    Left = 343
    Top = 256
    Width = 163
    Height = 21
    Style = csDropDownList
    TabOrder = 4
    Items.Strings = (
      'String'
      'File')
  end
  object txtFile: TEdit
    Left = 16
    Top = 287
    Width = 321
    Height = 21
    TabOrder = 5
    Text = 'txtFilename'
  end
  object btnSelectFile: TButton
    Left = 343
    Top = 282
    Width = 34
    Height = 25
    Caption = '...'
    TabOrder = 6
    OnClick = btnSelectFileClick
  end
  object client: TClientSocket
    Active = False
    Address = '127.0.0.1'
    ClientType = ctNonBlocking
    Port = 5050
    OnLookup = clientLookup
    OnConnecting = clientConnecting
    OnConnect = clientConnect
    OnDisconnect = clientDisconnect
    OnRead = clientRead
    OnWrite = clientWrite
    OnError = clientError
    Left = 16
    Top = 16
  end
  object pictureSelect: TOpenPictureDialog
    Left = 72
    Top = 16
  end
end
