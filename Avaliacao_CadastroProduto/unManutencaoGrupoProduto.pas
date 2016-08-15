unit unManutencaoGrupoProduto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, unTelaCadastroPadrao2, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Actions,
  FMX.ActnList, FMX.Ani, FMX.Layouts, FMX.ListBox,
  FMX.Controls.Presentation, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, FMX.Edit;

type
  TframeManutencaoGrupoProduto = class(TframeTelaCadastroPadrao2)
    EditDescricao: TEdit;
    LabelDescricao: TLabel;
    FDQueryid: TLargeintField;
    FDQuerydescricao: TWideMemoField;
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
  frameManutencaoGrupoProduto: TframeManutencaoGrupoProduto;

implementation

{$R *.fmx}

uses unManutencaoSistema, unLib, unMain;

procedure TframeManutencaoGrupoProduto.ActionNovoRegistroExecute(Sender: TObject);
begin
  inherited;
  EditDescricao.SetFocus;
end;

procedure TframeManutencaoGrupoProduto.ActionVoltarTelaExecute(Sender: TObject);
begin
  inherited;
  frameManutencaoSistema.LayoutSistema.Visible := True;
  Self.Visible := False;
end;

procedure TframeManutencaoGrupoProduto.AtulizarRegistro;
var
  LItem: TListBoxItem;
begin
  LItem := ListBoxLista.Selected;
  LItem.Text := FDQuerydescricao.AsString;
end;

procedure TframeManutencaoGrupoProduto.FDQueryBeforePost(DataSet: TDataSet);
begin
  inherited;
  if not GNovoRegistro then
  begin
    TLib.Select('select sistema.grupo_produto_update(''descricao'', ' + QuotedStr(EditDescricao.Text) + ', False, ' + ListBoxLista.Selected.StylesData
      ['id'].AsString + ')');
  end;
end;

procedure TframeManutencaoGrupoProduto.Inicializar;
begin
  GEditando := False;
  GFrameTabela := 'grupo_produto';
  SalvarAutomatico(Self);
  AbrirTabela;
  AtualizarListagem;
  TLib.LimparEdit(frameManutencaoGrupoProduto);
  GEditando := True;
end;

procedure TframeManutencaoGrupoProduto.ListBoxListaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = vkReturn then
  begin
    EditDescricao.SetFocus;
  end;
end;

end.
