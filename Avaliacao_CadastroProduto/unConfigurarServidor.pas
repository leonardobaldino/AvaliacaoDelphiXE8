unit unConfigurarServidor;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,
  System.Actions, FMX.ActnList, FMX.Objects;

type
  TframeConfigurarServidor = class(TFrame)
    EditDB: TEdit;
    EditServidorIP: TEdit;
    EditServidorNome: TEdit;
    ButtonConfigurar: TButton;
    ActionList: TActionList;
    ActionConfigurar: TAction;
    ActionSair: TAction;
    PanelConfigurandoServidor: TPanel;
    PanelTitulo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    ButtonSair: TButton;
    LabelDB: TLabel;
    LabelServidorIP: TLabel;
    LabelServidorNome: TLabel;
    procedure ActionConfigurarExecute(Sender: TObject);
    procedure ActionSairExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frameConfigurarServidor: TframeConfigurarServidor;

implementation

{$R *.fmx}

uses unMain, unLib;

procedure TframeConfigurarServidor.ActionConfigurarExecute(Sender: TObject);
begin
  if (Trim(EditDB.Text) = EmptyStr) or (Trim(EditServidorIP.Text) = EmptyStr) or (Trim(EditServidorNome.Text) = EmptyStr) then
  begin
    MessageDlg('Necessário preencher todos os campos.', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
    Abort;
  end;
//  TLib.SetRegistro('DB', EditDB.Text);
//  TLib.SetRegistro('SERVIDOR', EditServidorIP.Text);
//  TLib.SetRegistro('SERVIDORNOME', EditServidorNome.Text);
//  TLib.AppRestart;
end;

procedure TframeConfigurarServidor.ActionSairExecute(Sender: TObject);
begin
  FreeAndNil(Self);
  Application.Terminate;
end;

end.
