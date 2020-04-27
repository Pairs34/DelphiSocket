object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 300
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
  object imgRecieved: TImage
    Left = 415
    Top = 48
    Width = 212
    Height = 244
    Stretch = True
  end
  object btnStartSV: TButton
    Left = 464
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Start SV'
    TabOrder = 0
    OnClick = btnStartSVClick
  end
  object txtLog: TMemo
    Left = 8
    Top = 48
    Width = 401
    Height = 243
    Lines.Strings = (
      'txtLog')
    TabOrder = 1
  end
  object btnStopSV: TButton
    Left = 552
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Stop SV'
    TabOrder = 2
    OnClick = btnStopSVClick
  end
  object server: TServerSocket
    Active = False
    Port = 5050
    ServerType = stNonBlocking
    OnListen = serverListen
    OnAccept = serverAccept
    OnGetThread = serverGetThread
    OnGetSocket = serverGetSocket
    OnThreadStart = serverThreadStart
    OnThreadEnd = serverThreadEnd
    OnClientConnect = serverClientConnect
    OnClientDisconnect = serverClientDisconnect
    OnClientRead = serverClientRead
    OnClientWrite = serverClientWrite
    OnClientError = serverClientError
    Left = 8
    Top = 8
  end
  object SavePicture: TSavePictureDialog
    Left = 56
    Top = 16
  end
end
