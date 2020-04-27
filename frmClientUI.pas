unit frmClientUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Win.ScktComp,
  Vcl.ExtDlgs, Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    txtMessage: TEdit;
    btnCOnnectSV: TButton;
    btnSend: TButton;
    client: TClientSocket;
    txtLog: TMemo;
    cbMessageType: TComboBox;
    txtFile: TEdit;
    btnSelectFile: TButton;
    pictureSelect: TOpenPictureDialog;
    imgSelect: TImage;
    procedure btnCOnnectSVClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure clientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure clientConnecting(Sender: TObject; Socket: TCustomWinSocket);
    procedure clientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure clientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure clientLookup(Sender: TObject; Socket: TCustomWinSocket);
    procedure clientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure clientWrite(Sender: TObject; Socket: TCustomWinSocket);
    procedure btnSelectFileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.btnCOnnectSVClick(Sender: TObject);
begin
  client.Active := true;
end;

procedure TForm2.btnSelectFileClick(Sender: TObject);
begin
  if pictureSelect.Execute then
  begin
    txtFile.Text := pictureSelect.FileName;
    imgSelect.Picture.LoadFromFile(pictureSelect.FileName);
  end;
end;

procedure TForm2.btnSendClick(Sender: TObject);
var
  bMessage : string;
  ms: TMemoryStream;
  size: Integer;
  FileName: array [0..255] of char;
begin
  ms := TMemoryStream.Create;

  case cbMessageType.ItemIndex of
      0 : begin
          bMessage := txtMessage.Text;
          client.Socket.SendText(bMessage);
          txtLog.Lines.Add('Text Sent..');
      end;

      1 : begin
          ms:= TMemoryStream.Create;
          try
            ms.LoadFromFile(pictureSelect.FileName);
            ms.Position:= 0;
            Size:= MS.Size;
            Client.Socket.SendBuf(Size,SizeOf(Size));
            StrPLCopy(FileName, ExtractFileName(pictureSelect.FileName), High(FileName));
            Client.Socket.SendBuf(FileName, SizeOf(FileName));
            client.Socket.SendStream(ms);
          except
            ms.Free;
          end;
      end;
  end;
end;

procedure TForm2.clientConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
    txtLog.Lines.Add('Connected..');
end;

procedure TForm2.clientConnecting(Sender: TObject; Socket: TCustomWinSocket);
begin
   txtLog.Lines.Add('Connecting..');
end;

procedure TForm2.clientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  txtLog.Lines.Add('Disconnected..');
end;

procedure TForm2.clientError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  txtLog.Lines.Add('On Error..');
end;

procedure TForm2.clientLookup(Sender: TObject; Socket: TCustomWinSocket);
begin
txtLog.Lines.Add('On Lookup..');
end;

procedure TForm2.clientRead(Sender: TObject; Socket: TCustomWinSocket);
begin
  txtLog.Lines.Add(Format('From Client Sent Message %s',[Socket.ReceiveText]));
end;

procedure TForm2.clientWrite(Sender: TObject; Socket: TCustomWinSocket);
begin
txtLog.Lines.Add('Write..');
end;

end.
