unit unManutencaoSistema;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF MSWINDOWS}
  FMX.Controls.Presentation, FMX.Layouts, System.Actions, FMX.ActnList,
  ShellApi;

type
  TframeManutencaoSistema = class(TFrame)
    ActionList: TActionList;
    ActionTipoContato: TAction;
    LayoutSistema: TLayout;
    PanelSuperior: TPanel;
    ButtonTipoContato: TButton;
    LayoutTitulo: TLayout;
    LabelTitulo: TLabel;
    PanelInferior: TPanel;
    PanelDetalhe: TPanel;
    ActionGrupoProduto: TAction;
    Button1: TButton;
    procedure ActionTipoContatoExecute(Sender: TObject);
    procedure ActionGrupoProdutoExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Inicializar;
  end;

var
  frameManutencaoSistema: TframeManutencaoSistema;

implementation

{$R *.fmx}

uses unManutencaoTipoContato, unMain, unLib, unManutencaoGrupoProduto;

procedure TframeManutencaoSistema.ActionGrupoProdutoExecute(Sender: TObject);
begin
  if frameManutencaoGrupoProduto = nil then
  begin
    frameManutencaoGrupoProduto := TframeManutencaoGrupoProduto.Create(Self.Parent);
  end;

  LayoutSistema.Visible := False;
  TLib.LoadFrame(TFrame(frameManutencaoGrupoProduto), Self);
  frameManutencaoGrupoProduto.Inicializar;
end;

procedure TframeManutencaoSistema.ActionTipoContatoExecute(Sender: TObject);
begin
  if frameManutencaoTipoContato = nil then
  begin
    frameManutencaoTipoContato := TframeManutencaoTipoContato.Create(Self.Parent);
  end;

  LayoutSistema.Visible := False;
  TLib.LoadFrame(TFrame(frameManutencaoTipoContato), Self);
  frameManutencaoTipoContato.Inicializar;
end;

procedure TframeManutencaoSistema.Inicializar;
begin
end;

end.
