unit unManutencaoTipoContato;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, unTelaCadastroPadrao2, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Actions, FMX.ActnList, FMX.Ani, FMX.Layouts, FMX.ListBox,
  FMX.Controls.Presentation, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope, FMX.Edit;

type
  TframeManutencaoTipoContato = class(TframeTelaCadastroPadrao2)
    EditDescricao: TEdit;
    LabelDescricao: TLabel;
    FDQueryid: TLargeintField;
    FDQuerydescricao: TWideMemoField;
    FDQueryimagem: TWideMemoField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    procedure ActionVoltarTelaExecute(Sender: TObject);
    procedure ActionNovoRegistroExecute(Sender: TObject);
    procedure ListBoxListaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure FDQueryBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AtulizarRegistro;
    procedure Inicializar;
  end;

var
  frameManutencaoTipoContato: TframeManutencaoTipoContato;

implementation

{$R *.fmx}

uses unManutencaoSistema, unLib, unMain;

procedure TframeManutencaoTipoContato.ActionNovoRegistroExecute(Sender: TObject);
begin
  inherited;
  EditDescricao.SetFocus;
end;

procedure TframeManutencaoTipoContato.ActionVoltarTelaExecute(Sender: TObject);
begin
  inherited;
  frameManutencaoSistema.LayoutSistema.Visible := True;
//  FreeAndNil(frameManutencaoTipoContato);
  Self.Visible := False;
end;

procedure TframeManutencaoTipoContato.AtulizarRegistro;
var
  LItem: TListBoxItem;
begin
  LItem := ListBoxLista.Selected;
  LItem.Text := FDQuerydescricao.AsString;
end;

procedure TframeManutencaoTipoContato.FDQueryBeforePost(DataSet: TDataSet);
begin
  inherited;
  if not GNovoRegistro then
  begin
    TLib.Select('select sistema.tipocontato_update(' + ListBoxLista.Selected.StylesData['id'].AsString + ',' + IntToStr(frmMain.GUsuarioID) + ')');
  end;
end;

procedure TframeManutencaoTipoContato.Inicializar;
begin
  GEditando := False;
  GFrameTabela := 'TipoContato';
  SalvarAutomatico(Self);
  AbrirTabela;
  AtualizarListagem;
  TLib.LimparEdit(frameManutencaoTipoContato);
  GEditando := True;
end;

procedure TframeManutencaoTipoContato.ListBoxListaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  inherited;
  if Key = vkReturn then
  begin
    EditDescricao.SetFocus;
  end;
end;

end.
