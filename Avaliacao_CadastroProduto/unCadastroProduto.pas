unit unCadastroProduto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, unTelaCadastroPadrao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, System.Actions, FMX.ActnList, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Edit, FMX.Layouts, FMX.ListBox,
  FMX.TabControl, FMX.Controls.Presentation, FMX.Objects, FMX.ExtCtrls, FMX.ComboEdit, FMX.CalendarEdit, FMX.Effects, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  FMX.ScrollBox, FMX.Memo, unTelaCadastroPadrao2, unCadastroContato, unConsultaPadrao, FMX.EditBox, FMX.NumberBox;

type
  TframeCadastroProduto = class(TframeTelaCadastroPadrao)
    LayoutInformacoes1: TLayout;
    GroupBoxInformacoes1: TGroupBox;
    LabelFornecedor: TLabel;
    EditDescricao: TEdit;
    LabelDescricao: TLabel;
    LabelUnidade: TLabel;
    EditUnidade: TEdit;
    LineTela1: TLine;
    PanelTela1: TPanel;
    LabelTela1: TLabel;
    frameConsulta: TframeConsultaPadrao;
    FDQueryPrincipalid: TLargeintField;
    EditFornecedor: TEdit;
    ButtonConsultaFornecedor: TButton;
    EditGrupo: TEdit;
    ButtonConsultaGrupo: TButton;
    LabelGrupo: TLabel;
    LabelValorUnitario: TLabel;
    LabelQtdeEstoque: TLabel;
    FDQueryPrincipaldescricao: TWideMemoField;
    FDQueryPrincipalgrupo_id: TLargeintField;
    FDQueryPrincipalfornecedor_id: TLargeintField;
    FDQueryPrincipaliseditando: TBooleanField;
    FDQueryPrincipalunidade: TWideMemoField;
    FDQueryPrincipalvalor_unitario: TFMTBCDField;
    FDQueryPrincipalqtde_estoque: TFMTBCDField;
    EditValorUnitario: TEdit;
    EditQtdeEstoque: TEdit;
    procedure ActionVoltarTelaExecute(Sender: TObject);
    procedure ListBoxListDblClick(Sender: TObject);
    procedure ActionNovoRegistroExecute(Sender: TObject);
    procedure ActionAtualizarListaExecute(Sender: TObject);
    procedure EditPesquisaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure frameConsultaListBoxListaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure TabControlChange(Sender: TObject);
    procedure frameConsultaListBoxListaDblClick(Sender: TObject);
    procedure frameConsultaEditPesquisaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure frameConsultaActionFecharExecute(Sender: TObject);
    procedure EditDescricaoChange(Sender: TObject);
    procedure EditRazaoSocialChange(Sender: TObject);
    procedure EditUnidadeChange(Sender: TObject);
    procedure EditFornecedorKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure ButtonConsultaFornecedorClick(Sender: TObject);
    procedure EditGrupoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure EditDescricaoExit(Sender: TObject);
    procedure EditDescricaoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure EditUnidadeExit(Sender: TObject);
    procedure EditUnidadeKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure NumberBoxValorUnitarioExit(Sender: TObject);
    procedure NumberBoxQtdeEstoqueExit(Sender: TObject);
    procedure ButtonConsultaGrupoClick(Sender: TObject);
    procedure EditValorUnitarioExit(Sender: TObject);
    procedure EditQtdeEstoqueExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadList;
    procedure CarregarLista(xQry: TFDQuery; xPesquisa: Boolean);
    procedure ListBoxItem(xQry: TFDQuery; xItem: TListBoxItem);
    procedure UpdateRecord;
    procedure LoadNewRecord;
    procedure LoadRecord(xId: Integer);
    procedure CarregarPopupBox;
    procedure Pesquisar;
    procedure SalvarRG(Sender: TObject);
    procedure Inicializar;
    procedure ConsultarPopup(xTabela, xSender: String);
    procedure PesquisarPopup(xTabela: String);
    procedure SalvarRegistro(Sender: TObject; Campo, ValorID, ValorDescricao: String);
  end;

var
  frameCadastroProduto: TframeCadastroProduto;

implementation

{$R *.fmx}

uses unLib, unMain;

{ TframeCadastroColaborador2 }

procedure TframeCadastroProduto.ActionAtualizarListaExecute(Sender: TObject);
begin
  inherited;
  LoadList;
end;

procedure TframeCadastroProduto.ActionNovoRegistroExecute(Sender: TObject);
begin
  GEditando := False;
  TLib.LimparEdit(Self);
  GSelectNovoRegistro := 'SELECT sistema.produto_insert(' + QuotedStr(AnsiUpperCase('produto')) + ') as id;';
  inherited;
  GEditando := False;
  LoadRecord(FDQueryPrincipalid.AsInteger);
  CarregarPopupBox;
  GEditando := True;
  TabControl.ActiveTab := TabItemCad;
  EditDescricao.SetFocus;
  EditDescricao.SelectAll;
end;

procedure TframeCadastroProduto.ActionVoltarTelaExecute(Sender: TObject);
begin
  if ScrollBoxDetalhes.Enabled then
  begin
    TLib.Select('select sistema.produto_update(''iseditando'', null, null, null, null, null, null, false, ' + FDQueryPrincipalid.AsString +
      ') as id');
    FDQueryPrincipal.Refresh;
  end;
  inherited;
  // if ListBoxList.ItemIndex <> -1 then
  // UpdateRecord
  // else
  // LoadNewRecord;
  if Trim(EditPesquisa.Text) = EmptyStr then
  begin
    LoadList;
  end
  else
  begin
    Pesquisar;
  end;
end;

procedure TframeCadastroProduto.ButtonConsultaFornecedorClick(Sender: TObject);
begin
  inherited;
  ConsultarPopup('fornecedor', 'fornecedor');
end;

procedure TframeCadastroProduto.ButtonConsultaGrupoClick(Sender: TObject);
begin
  inherited;
  ConsultarPopup('grupo_produto', 'grupo_produto');
end;

procedure TframeCadastroProduto.CarregarLista(xQry: TFDQuery; xPesquisa: Boolean);
var
  LItem: TListBoxItem;
begin
  TLib.ListBoxClear(ListBoxList);
  xQry.First;
  while not xQry.Eof do
  begin
    LItem := TListBoxItem.Create(ListBoxList);
    LItem.Parent := ListBoxList;
    ListBoxItem(xQry, LItem);
    xQry.Next;
  end;

  ListBoxList.ItemIndex := 0;
  if xPesquisa then
  begin
    ListBoxList.SetFocus;
  end;
end;

procedure TframeCadastroProduto.CarregarPopupBox;
begin
end;

procedure TframeCadastroProduto.ConsultarPopup(xTabela, xSender: String);
begin
  frameConsulta.Visible := True;
  ScrollBoxDetalhes.Enabled := False;
  frameConsulta.GTabela := xTabela;
  frameConsulta.GSender := xSender;
  frameConsulta.EditPesquisa.SetFocus;

  if xSender = 'fornecedor' then
    frameConsulta.GSelect := ('SELECT id, nome_fantasia as descricao from sistema.' + xTabela + '_pesquisar_listagem(' + QuotedStr('') +
      ', '''', '''')')
  else
    frameConsulta.GSelect := ('SELECT id, descricao from sistema.' + xTabela + '_pesquisar_listagem(' + QuotedStr('') + ')');

  frameConsulta.Consultar('descricao');
end;

procedure TframeCadastroProduto.EditUnidadeChange(Sender: TObject);
begin
  inherited;
  SalvarRegistro(Sender, 'unidade', EmptyStr, EmptyStr);
end;

procedure TframeCadastroProduto.EditUnidadeExit(Sender: TObject);
begin
  inherited;
  SalvarRegistro(Sender, 'unidade', EmptyStr, EmptyStr);
end;

procedure TframeCadastroProduto.EditUnidadeKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  LetraMaiuscula(Sender);
end;

procedure TframeCadastroProduto.EditValorUnitarioExit(Sender: TObject);
begin
  inherited;
  SalvarRegistro(Sender, 'valor_unitario', EmptyStr, EmptyStr);
end;

procedure TframeCadastroProduto.EditFornecedorKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = vkReturn then
  begin
    ButtonConsultaFornecedorClick(Sender);
  end
  else if Key in [vkDelete, vkBack] then
  begin
    SalvarRegistro(Sender, 'Fornecedor_id', 'null', EmptyStr);
  end;
end;

procedure TframeCadastroProduto.EditGrupoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = vkReturn then
  begin
    ButtonConsultaGrupoClick(Sender);
  end
  else if Key in [vkDelete, vkBack] then
  begin
    SalvarRegistro(Sender, 'grupo_id', 'null', EmptyStr);
  end;
end;

procedure TframeCadastroProduto.EditDescricaoChange(Sender: TObject);
begin
  inherited;
  SalvarRegistro(Sender, 'descricao', EmptyStr, EmptyStr);
end;

procedure TframeCadastroProduto.EditDescricaoExit(Sender: TObject);
begin
  inherited;
  SalvarRegistro(Sender, 'descricao', EmptyStr, EmptyStr);
end;

procedure TframeCadastroProduto.EditDescricaoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  LetraMaiuscula(Sender);
end;

procedure TframeCadastroProduto.EditPesquisaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  Pesquisar;
end;

procedure TframeCadastroProduto.EditQtdeEstoqueExit(Sender: TObject);
begin
  inherited;
  SalvarRegistro(Sender, 'qtde_estoque', EmptyStr, EmptyStr);
end;

procedure TframeCadastroProduto.EditRazaoSocialChange(Sender: TObject);
begin
  inherited;
  if GEditando then
  begin
    TLib.Select('select sistema.produto_update(''razao_social'', null, ' + QuotedStr(TEdit(Sender).Text) + ', null, null, null, ' +
      FDQueryPrincipalid.AsString + ', null) as id');
    FDQueryPrincipal.Refresh;
  end;
end;

procedure TframeCadastroProduto.frameConsultaListBoxListaDblClick(Sender: TObject);
var
  LID: Integer;
begin
  inherited;
  if frameConsulta.ListBoxLista.Items.Count > 0 then
  begin
    LID := StrToInt(frameConsulta.ListBoxLista.Selected.StylesData['id'].AsString);

    if frameConsulta.GSender = 'fornecedor' then
    begin
      SalvarRegistro(EditFornecedor, 'fornecedor_id', IntToStr(LID), frameConsulta.ListBoxLista.Selected.Text);
    end
    else if frameConsulta.GSender = 'grupo_produto' then
    begin
      SalvarRegistro(EditGrupo, 'grupo_id', IntToStr(LID), frameConsulta.ListBoxLista.Selected.Text);
    end;
  end;

  frameConsultaActionFecharExecute(Sender);
end;

procedure TframeCadastroProduto.frameConsultaListBoxListaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = vkReturn then
  begin
    frameConsultaListBoxListaDblClick(Sender);
  end;
end;

procedure TframeCadastroProduto.frameConsultaActionFecharExecute(Sender: TObject);
begin
  ScrollBoxDetalhes.Enabled := True;
  inherited;

  if frameConsulta.GSender = 'fornecedor' then
  begin
    EditFornecedor.SetFocus;
  end
  else if frameConsulta.GSender = 'grupo_produto' then
  begin
    EditGrupo.SetFocus;
  end;

  frameConsulta.ActionFecharExecute(Sender);
end;

procedure TframeCadastroProduto.frameConsultaEditPesquisaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  PesquisarPopup(frameConsulta.GTabela);
  inherited;
  frameConsulta.EditPesquisaKeyUp(Sender, Key, KeyChar, Shift);
end;

procedure TframeCadastroProduto.Inicializar;
begin
  GEditando := False;
  GCampoSelect := 'id, descricao, grupo_id, fornecedor_id, valor_unitario, qtde_estoque, unidade, iseditando';
  GFrameTabela := 'produto';
  SalvarAutomatico(frameCadastroProduto);
  // SalvarAutomatico(frameCadastroContato);
  LoadList;
  TabControl.ActiveTab := TabItemList;
end;

procedure TframeCadastroProduto.ListBoxItem(xQry: TFDQuery; xItem: TListBoxItem);
begin
  xItem.StylesData['id'] := xQry.FieldByName('id').AsString;
  xItem.Text := 'Descrição: ' + xQry.FieldByName('descricao').AsString;
  xItem.StylesData['linha1a'] := EmptyStr;
  xItem.StylesData['linha1a.Width'] := 2000;
  xItem.StylesData['linha1b.visible'] := False;
  xItem.StylesData['linha2a'] := EmptyStr;
  xItem.StylesData['linha2b'] := EmptyStr;
end;

procedure TframeCadastroProduto.ListBoxListDblClick(Sender: TObject);
begin
  LoadRecord(StrToInt(ListBoxList.Selected.StylesData['id'].AsString));
  inherited;
end;

procedure TframeCadastroProduto.LoadList;
var
  LQry: TFDQuery;
begin
  LQry := TLib.Select('SELECT id, descricao, grupo_produto, fornecedor, unidade FROM sistema.produto_listagem_view', nil);

  try
    CarregarLista(LQry, True);
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TframeCadastroProduto.LoadNewRecord;
var
  LItem: TListBoxItem;
begin
  LItem := TListBoxItem.Create(ListBoxList);
  LItem.Parent := ListBoxList;
  ListBoxItem(FDQueryPrincipal, LItem);

  ListBoxList.ItemIndex := ListBoxList.Items.Count - 1;
  ListBoxList.SetFocus;
end;

procedure TframeCadastroProduto.LoadRecord(xId: Integer);
begin
  GEditando := False;
  CarregarRegistro(xId);
  CarregarPopupBox;

  EditDescricao.Text := FDQueryPrincipaldescricao.AsString;
  EditUnidade.Text := FDQueryPrincipalunidade.AsString;
  EditValorUnitario.Text := FormatFloat('R$ #,##0.00', FDQueryPrincipalvalor_unitario.AsFloat);
  EditQtdeEstoque.Text := FormatFloat('#,###0.000', FDQueryPrincipalqtde_estoque.AsFloat);

  EditFornecedor.Text := TLib.Select('select nome_fantasia from sistema.fornecedor_view where id = ' +
    IntToStr(FDQueryPrincipalfornecedor_id.AsInteger));
  EditGrupo.Text := TLib.Select('select descricao from sistema.grupo_produto_view where id = ' + IntToStr(FDQueryPrincipalgrupo_id.AsInteger));

  EditDescricao.SetFocus;
  EditDescricao.SelStart := Length(EditDescricao.Text) + 1;

  if (GNovoRegistro) then
  begin
    TLib.Select('select sistema.produto_update(''iseditando'', null, null, null, null, null, null, True, ' + FDQueryPrincipalid.AsString + ') as id');
    FDQueryPrincipal.Refresh;
    GEditando := True;
    ScrollBoxDetalhes.Enabled := GEditando;
  end
  else
  begin
    if (not FDQueryPrincipaliseditando.AsBoolean) then
    begin
      TLib.Select('select sistema.produto_update(''iseditando'', null, null, null, null, null, null, True, ' + FDQueryPrincipalid.AsString +
        ') as id');
      FDQueryPrincipal.Refresh;
      GEditando := True;
      ScrollBoxDetalhes.Enabled := GEditando;
    end
    else
    begin
      GEditando := not FDQueryPrincipaliseditando.AsBoolean;
      ScrollBoxDetalhes.Enabled := GEditando;
    end;
  end;
end;

procedure TframeCadastroProduto.NumberBoxQtdeEstoqueExit(Sender: TObject);
begin
  inherited;
  SalvarRegistro(Sender, 'qtde_estoque', EmptyStr, EmptyStr);
end;

procedure TframeCadastroProduto.NumberBoxValorUnitarioExit(Sender: TObject);
begin
  inherited;
  SalvarRegistro(Sender, 'valor_unitario', EmptyStr, EmptyStr);
end;

procedure TframeCadastroProduto.Pesquisar;
var
  LQry: TFDQuery;
  LPesquisa: String;
begin
  if Trim(EditPesquisa.Text) = EmptyStr then
  begin
    LoadList;
    EditPesquisa.SetFocus;
  end
  else
  begin
    LPesquisa := QuotedStr('%' + Trim(EditPesquisa.Text) + '%');
    LQry := TLib.Select('SELECT id, descricao, grupo_produto, fornecedor, unidade from sistema.produto_pesquisar_listagem(' + LPesquisa + ',' +
      LPesquisa + ',' + LPesquisa + ',' + LPesquisa + ')', nil);
    try
      CarregarLista(LQry, False);
    finally
      FreeAndNil(LQry);
    end;
  end;
end;

procedure TframeCadastroProduto.PesquisarPopup(xTabela: String);
var
  LPesquisa: String;
begin
  frameConsulta.GCampo := 'descricao';
  LPesquisa := QuotedStr('%' + Trim(frameConsulta.EditPesquisa.Text) + '%');
  if frameConsulta.GSender = 'fornecedor' then
  begin
    if (Trim(frameConsulta.EditPesquisa.Text) = EmptyStr) then
    begin
      frameConsulta.GSelect := ('SELECT id, nome_fantasia as descricao from sistema.' + xTabela + '_pesquisar_listagem('''','''','''')');
    end
    else
    begin
      frameConsulta.GSelect := ('SELECT id, nome_fantasia as descricao from sistema.' + xTabela + '_pesquisar_listagem(' + LPesquisa + ', ' +
        LPesquisa + ', ' + LPesquisa + ')');
    end;
  end
  else
  begin
    if (Trim(frameConsulta.EditPesquisa.Text) = EmptyStr) then
    begin
      frameConsulta.GSelect := ('SELECT id, descricao from sistema.' + xTabela + '_pesquisar_listagem(' + QuotedStr('') + ')');
    end
    else
    begin
      frameConsulta.GSelect := ('SELECT id, descricao from sistema.' + xTabela + '_pesquisar_listagem(' + LPesquisa + ')');
    end;
  end;
  frameConsulta.Consultar(frameConsulta.GCampo);
end;

procedure TframeCadastroProduto.SalvarRegistro(Sender: TObject; Campo, ValorID, ValorDescricao: String);
var
  LValor: String;
begin
  if Campo = 'descricao' then
  begin
    if GEditando then
    begin
      TLib.Select('select sistema.produto_update(''descricao'', ' + QuotedStr(TEdit(Sender).Text) + ', null, null, null, null, null, null, ' +
        FDQueryPrincipalid.AsString + ') as id');
      FDQueryPrincipal.Refresh;
    end;
  end
  else if Campo = 'unitario' then
  begin
    if GEditando then
    begin
      TLib.Select('select sistema.produto_update(''unitario'', null, null, null, null, null, ' + QuotedStr(TEdit(Sender).Text) + ', null, ' +
        FDQueryPrincipalid.AsString + ') as id');
      FDQueryPrincipal.Refresh;
    end;
  end
  else if Campo = 'valor_unitario' then
  begin
    if GEditando then
    begin
      LValor := StringReplace(TEdit(Sender).Text, ',', '.', [rfReplaceAll]);
      LValor := Trim(StringReplace(TEdit(Sender).Text, 'R$', EmptyStr, [rfReplaceAll]));
      TLib.Select('select sistema.produto_update(''valor_unitario'', null, null, null, ' + LValor + ', null, null, null, ' + FDQueryPrincipalid.AsString + ') as id');
      FDQueryPrincipal.Refresh;
    end;
  end
  else if Campo = 'qtde_estoque' then
  begin
    if GEditando then
    begin
      TLib.Select('select sistema.produto_update(''qtde_estoque'', null, null, null, null, ' + StringReplace(TEdit(Sender).Text, ',', '.',
        [rfReplaceAll]) + ', null, null, ' + FDQueryPrincipalid.AsString + ') as id');
      FDQueryPrincipal.Refresh;
    end;
  end
  else if Campo = 'fornecedor_id' then
  begin
    if GEditando then
    begin
      TLib.Select('select sistema.produto_update(''fornecedor_id'', null, null, ' + ValorID + ', null, null, null, null, ' +
        FDQueryPrincipalid.AsString + ') as id');
      FDQueryPrincipal.Refresh;
      TEdit(Sender).Text := ValorDescricao;
    end;
  end
  else if Campo = 'grupo_id' then
  begin
    if GEditando then
    begin
      TLib.Select('select sistema.produto_update(''grupo_id'', null, ' + ValorID + ', null, null, null, null, null, ' + FDQueryPrincipalid.AsString +
        ') as id');
      FDQueryPrincipal.Refresh;
      TEdit(Sender).Text := ValorDescricao;
    end;
  end;
end;

procedure TframeCadastroProduto.SalvarRG(Sender: TObject);
begin
end;

procedure TframeCadastroProduto.TabControlChange(Sender: TObject);
begin
  inherited;
  if not GNovoRegistro then
  begin
    if not GEditando then
    begin
      ScrollBoxDetalhes.Enabled := False;
    end;
  end;
end;

procedure TframeCadastroProduto.UpdateRecord;
var
  LItem: TListBoxItem;
begin
  LItem := ListBoxList.Selected;
  ListBoxItem(FDQueryPrincipal, LItem);
end;

end.
