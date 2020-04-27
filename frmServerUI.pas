unit frmServerUI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Win.ScktComp,
  Vcl.ExtCtrls, Vcl.ExtDlgs;

type
  TForm1 = class(TForm)
    server: TServerSocket;
    btnStartSV: TButton;
    txtLog: TMemo;
    btnStopSV: TButton;
    imgRecieved: TImage;
    SavePicture: TSavePictureDialog;
    procedure btnStartSVClick(Sender: TObject);
    procedure serverThreadStart(Sender: TObject; Thread: TServerClientThread);
    procedure serverClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure serverAccept(Sender: TObject; Socket: TCustomWinSocket);
    procedure serverClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure serverListen(Sender: TObject; Socket: TCustomWinSocket);
    procedure serverThreadEnd(Sender: TObject; Thread: TServerClientThread);
    procedure serverGetSocket(Sender: TObject; Socket: NativeInt;
      var ClientSocket: TServerClientWinSocket);
    procedure serverGetThread(Sender: TObject;
      ClientSocket: TServerClientWinSocket;
      var SocketThread: TServerClientThread);
    procedure serverClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure serverClientWrite(Sender: TObject; Socket: TCustomWinSocket);
    procedure btnStopSVClick(Sender: TObject);
    procedure serverClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
  private
    FSize: Integer;
    writing: Boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnStartSVClick(Sender: TObject);
begin
  server.Active := true;
end;

procedure TForm1.btnStopSVClick(Sender: TObject);
begin
  Server.Active := false;
end;

procedure TForm1.serverAccept(Sender: TObject; Socket: TCustomWinSocket);
begin
  txtLog.Lines.Add('Accept Started...');
end;

procedure TForm1.serverClientConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  txtLog.Lines.Add('Client Connected...');
  Socket.SendText('Connected Server');
end;

procedure TForm1.serverClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
txtLog.Lines.Add('Client Disconnected...');
end;

procedure TForm1.serverClientError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  txtLog.Lines.Add('Error...');
end;

procedure TForm1.serverClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
    BytesReceived: Longint;
    CopyBuffer: Pointer; { buffer for copying }
    ChunkSize: Integer;
    TempSize: Integer;
    FileName: array [0..255] of char;
    ms : TMemoryStream;
  const
    MaxChunkSize: Longint = 8192; { copy in 8K chunks }
begin
  ms := TMemoryStream.Create;
  If FSize=0 then
      begin
        If Socket.ReceiveLength>SizeOf(TempSize) then
        begin
          Socket.ReceiveBuf(TempSize,SizeOf(TempSize));
          Socket.ReceiveBuf(FileName, sizeOf(FileName));
          SavePicture.FileName:= FileName; //I added
          ms := TMemoryStream.Create;
          ms.SetSize(TempSize);
          FSize:= TempSize; //Threadsafe code!
          writing:= True;
        End;
  End;

  If (FSize>0) and (writing) then
  begin
    GetMem(CopyBuffer, MaxChunkSize); { allocate the buffer }
    While Socket.ReceiveLength>0 do
    Begin
      ChunkSize:= Socket.ReceiveLength;
      If ChunkSize > MaxChunkSize then ChunkSize:= MaxChunkSize;
      BytesReceived:= Socket.ReceiveBuf(CopyBuffer^,ChunkSize);
      ms.Write(CopyBuffer^, BytesReceived); { ...write chunk }
      Dec(FSize,BytesReceived);
    End;

    If FSize=0 then begin
      If SavePicture.Execute then
      begin
        If FileExists(SavePicture.Filename) then
          DeleteFile(SavePicture.Filename);
        ms.SaveToFile(SavePicture.Filename);
        Socket.SendText('File received!');
        ms.SetSize(0);
        FSize:= 0;
      End;
      FreeMem(CopyBuffer,MaxChunkSize);
      Writing:= False;
    end;
  End;
end;


procedure TForm1.serverClientWrite(Sender: TObject; Socket: TCustomWinSocket);
begin
   txtLog.Lines.Add(Socket.ReceiveText);
end;

procedure TForm1.serverGetSocket(Sender: TObject; Socket: NativeInt;
  var ClientSocket: TServerClientWinSocket);
begin
  txtLog.Lines.Add('Get Socket...');
end;

procedure TForm1.serverGetThread(Sender: TObject;
  ClientSocket: TServerClientWinSocket; var SocketThread: TServerClientThread);
begin
txtLog.Lines.Add('Get Thread...');
end;

procedure TForm1.serverListen(Sender: TObject; Socket: TCustomWinSocket);
begin
  txtLog.Lines.Add('Listen Started...');
end;

procedure TForm1.serverThreadEnd(Sender: TObject; Thread: TServerClientThread);
begin
txtLog.Lines.Add('Thread Stopped...');
end;

procedure TForm1.serverThreadStart(Sender: TObject;
  Thread: TServerClientThread);
begin
  txtLog.Lines.Add('Thread Started...');
end;

end.
