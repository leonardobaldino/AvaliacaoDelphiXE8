unit unAjuda;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, System.Actions, FMX.ActnList, ShellApi, FMX.Objects;

type
  TframeAjuda = class(TFrame)
    ActionList: TActionList;
    LayoutSistema: TLayout;
    PanelSuperior: TPanel;
    LayoutTitulo: TLayout;
    LabelTitulo: TLabel;
    PanelInferior: TPanel;
    PanelDetalhe: TPanel;
    TextInf: TText;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure IniciarFrame;
  end;

var
  frameAjuda: TframeAjuda;

implementation

{$R *.fmx}

{ TframeAjuda }

procedure TframeAjuda.IniciarFrame;
begin
  TextInf.Text :=
    'Sistema Desenvolvido por Leonardo Carlos Baldino'+#13+
    'Telefones para Contato: (19) 3468-6586/  (19) 98833-3619'+#13+
    'EMail: leonardobaldino@gmail.com';
end;

end.
