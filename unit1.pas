unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls;

type
  TButton = class(StdCtrls.TButton)
  public
    OwnedThread: TThread;
    ProgressBar: TProgressBar;
  end;

  { TMyCustomThread }
  TMyCustomThread = class(TThread)
  private
    { Private Declaration, variable, function and procedure }
    FProgressBarObj: TProgressBar;
    FBtnCtrlObj: TButton;
    FLabelStatus: TLabel;
    FMaxValue: Integer;
    FPositionProgress: Integer;
    procedure ShowProgress;
    procedure SetProgressBar(const Value: TProgressBar);
    procedure SetBtnCtrl(const Value: TButton);
    procedure SetLabelStatus(const Value: TLabel);
  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: Boolean);
    property MaxValue: Integer read FMaxValue write FMaxValue;
    property PositionProgress: Integer read FPositionProgress write FPositionProgress;
    property ProgressBarObj: TProgressBar read FProgressBarObj write SetProgressBar;
    property BtnCtrlObj: TButton read FBtnCtrlObj write SetBtnCtrl;
    property LabelStatus: TLabel read FLabelStatus write SetLabelStatus;
  end;

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ProgressBar1: TProgressBar;
    ProgressBar2: TProgressBar;
    ProgressBar3: TProgressBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    procedure ShowStatusProg1(pPostition: Integer);
    procedure ShowStatusProg2(pPostition: Integer);
    procedure ShowStatusProg3(pPostition: Integer);
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TMyCustomThread }

procedure TMyCustomThread.Execute;
var i: integer;
begin
  FProgressBarObj.Max:= FMaxValue;
  for i:= 0 to FMaxValue do begin
    FPositionProgress:= i;
    sleep(3);
    Synchronize(@ShowProgress);
  end;
  FBtnCtrlObj.Caption:= 'Start';
  FBtnCtrlObj.OwnedThread:= nil;
end;

procedure TMyCustomThread.ShowProgress;
begin
  FProgressBarObj.Position:= FPositionProgress;
  FLabelStatus.Caption:= FormatFloat('#,##0.##%', FPositionProgress / FMaxValue * 100);
  FBtnCtrlObj.Caption:= 'Pause !';
end;

procedure TMyCustomThread.SetProgressBar(const Value: TProgressBar);
begin
  FProgressBarObj:= Value;
end;

procedure TMyCustomThread.SetBtnCtrl(const Value: TButton);
begin
  FBtnCtrlObj:= Value;
end;

procedure TMyCustomThread.SetLabelStatus(const Value: TLabel);
begin
  FLabelStatus:= Value;
end;

constructor TMyCustomThread.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  FreeOnTerminate:= True;

  FMaxValue:= maxExitCode;
  PositionProgress:= 0;
end;

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var vThreads1: TMyCustomThread;
begin
  if not Assigned(Button1.OwnedThread) then begin
    vThreads1:= TMyCustomThread.Create(True);
    vThreads1.ProgressBarObj:= ProgressBar1;
    vThreads1.BtnCtrlObj:= Button1;
    vThreads1.LabelStatus:= Label1;
    vThreads1.MaxValue:= maxExitCode div 16;

    Button1.OwnedThread:= vThreads1;
    vThreads1.Start;
    Button1.Caption:= 'Pause';
  end else begin
    if Button1.OwnedThread.Suspended then
      Button1.OwnedThread.Resume
    else Button1.OwnedThread.Suspend;
    Button1.Caption:= 'Run !';
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var vThreads2: TMyCustomThread;
begin
  if not Assigned(Button2.OwnedThread) then begin
    vThreads2:= TMyCustomThread.Create(True);
    vThreads2.ProgressBarObj:= ProgressBar2;
    vThreads2.BtnCtrlObj:= Button2;
    vThreads2.LabelStatus:= Label2;
    vThreads2.MaxValue:= maxExitCode div 16;

    Button2.OwnedThread:= vThreads2;
    vThreads2.Start;
    Button2.Caption:= 'Pause';
  end else begin
    if Button2.OwnedThread.Suspended then
      Button2.OwnedThread.Resume
    else Button2.OwnedThread.Suspend;
    Button2.Caption:= 'Run !';
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var vThreads3: TMyCustomThread;
begin
  if not Assigned(Button3.OwnedThread) then begin
    vThreads3:= TMyCustomThread.Create(True);
    vThreads3.ProgressBarObj:= ProgressBar3;
    vThreads3.BtnCtrlObj:= Button3;
    vThreads3.LabelStatus:= Label3;
    vThreads3.MaxValue:= maxExitCode div 16;

    Button3.OwnedThread:= vThreads3;
    vThreads3.Start;
    Button3.Caption:= 'Pause';
  end else begin
    if Button3.OwnedThread.Suspended then
      Button3.OwnedThread.Resume
    else Button3.OwnedThread.Suspend;
    Button3.Caption:= 'Run !';
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  ShowMessage(Edit1.Text);
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:= caFree;
  Form1:= nil;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.ShowStatusProg1(pPostition: Integer);
begin
end;

procedure TForm1.ShowStatusProg2(pPostition: Integer);
begin
end;

procedure TForm1.ShowStatusProg3(pPostition: Integer);
begin
end;

end.

