unit unCadastroFornecedor;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, unTelaCadastroPadrao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, System.Actions, FMX.ActnList, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Edit, FMX.Layouts, FMX.ListBox,
  FMX.TabControl, FMX.Controls.Presentation, FMX.Objects, FMX.ExtCtrls, FMX.ComboEdit, FMX.CalendarEdit, FMX.Effects, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  FMX.ScrollBox, FMX.Memo, unTelaCadastroPadrao2, unCadastroContato, unConsultaPadrao;

type
  TframeCadastroFornecedor = class(TframeTelaCadastroPadrao)
    ActionAbrirFoto: TAction;
    ActionRemoverFoto: TAction;
    LayoutInformacoes1: TLayout;
    GroupBoxInformacoes1: TGroupBox;
    EditRazaoSocial: TEdit;
    LabelRazaoSocial: TLabel;
    EditNomeFantasia: TEdit;
    LabelNomeFantasia: TLabel;
    PanelLogotipo: TPanel;
    ButtonRemoverLogotipo: TButton;
    ButtonAbrir: TButton;
    LabelLogotipo: TLabel;
    ShadowEffect1: TShadowEffect;
    PanelImagem: TPanel;
    Image1: TImage;
    ImageImagem: TImage;
    LabelCNPJ_CPF: TLabel;
    EditCNPJ_CPF: TEdit;
    LineTela1: TLine;
    PanelTela1: TPanel;
    LabelTela1: TLabel;
    LayoutContato: TLayout;
    frameCadastroContato: TframeCadastroContato;
    LineTela11: TLine;
    PanelTela11: TPanel;
    LabelTela11: TLabel;
    frameConsulta: TframeConsultaPadrao;
    FDQueryPrincipalid: TLargeintField;
    FDQueryPrincipalnome_fantasia: TWideMemoField;
    FDQueryPrincipalrazao_social: TWideMemoField;
    FDQueryPrincipaliseditando: TBooleanField;
    GroupBoxTipoPessoa: TGroupBox;
    RadioButtonPessoaFisica: TRadioButton;
    RadioButtonPessoaJuridica: TRadioButton;
    FDQueryPrincipallogotipo_id: TLargeintField;
    FDQueryPrincipaltipo_pessoa: TIntegerField;
    FDQueryPrincipalcnpj_cpf: TWideMemoField;
    procedure ActionAbrirFotoExecute(Sender: TObject);
    procedure ActionRemoverFotoExecute(Sender: TObject);
    procedure ActionVoltarTelaExecute(Sender: TObject);
    procedure ListBoxListDblClick(Sender: TObject);
    procedure ActionNovoRegistroExecute(Sender: TObject);
    procedure ActionAtualizarListaExecute(Sender: TObject);
    procedure EditPesquisaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure frameConsultaListBoxListaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure TabControlChange(Sender: TObject);
    procedure frameConsultaListBoxListaDblClick(Sender: TObject);
    procedure frameConsultaEditPesquisaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure frameCadastroContatoButtonConsultaTipoContatoClick(Sender: TObject);
    procedure frameCadastroContatoEditTipoContatoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure frameConsultaActionFecharExecute(Sender: TObject);
    procedure EditNomeFantasiaChange(Sender: TObject);
    procedure EditRazaoSocialChange(Sender: TObject);
    procedure EditCNPJ_CPFChange(Sender: TObject);
    procedure RadioButtonPessoaFisicaChange(Sender: TObject);
    procedure RadioButtonPessoaJuridicaChange(Sender: TObject);
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
    procedure CarregarContatoEndereco(xId: Integer);
    procedure Pesquisar;
    procedure SalvarRG(Sender: TObject);
    procedure Inicializar;
    procedure ConsultarPopup(xTabela, xSender: String);
    procedure PesquisarPopup(xTabela: String);
  end;

var
  frameCadastroFornecedor: TframeCadastroFornecedor;

implementation

{$R *.fmx}

uses unLib, unMain;

{ TframeCadastroColaborador2 }

procedure TframeCadastroFornecedor.ActionAbrirFotoExecute(Sender: TObject);
begin
  inherited;
  if GEditando then
  begin
    if OpenDialog.Execute then
    begin
      TLib.Select('select sistema.fornecedor_update(''logotipo_id'', null, null, null, null, null, ' + FDQueryPrincipalid.AsString + ', ' +
        IntToStr(TLib.SalvarFoto(OpenDialog.FileName, ImageImagem)) + ') as id');
      FDQueryPrincipal.Refresh;
    end;
  end;
end;

procedure TframeCadastroFornecedor.ActionAtualizarListaExecute(Sender: TObject);
begin
  inherited;
  LoadList;
end;

procedure TframeCadastroFornecedor.ActionNovoRegistroExecute(Sender: TObject);
begin
  GEditando := False;
  TLib.LimparEdit(Self);
  GSelectNovoRegistro := 'SELECT sistema.fornecedor_insert(' + QuotedStr(AnsiUpperCase('fornecedor')) + ',null,1,null) as id;';
  inherited;
  GEditando := False;
  LoadRecord(FDQueryPrincipalid.AsInteger);
  ActionRemoverFoto.Execute;
  CarregarPopupBox;
  GEditando := True;
  TabControl.ActiveTab := TabItemCad;
  EditNomeFantasia.SetFocus;
  EditNomeFantasia.SelectAll;
end;

procedure TframeCadastroFornecedor.ActionRemoverFotoExecute(Sender: TObject);
begin
  inherited;
  if GEditando then
  begin
    TLib.RemoverFoto(ImageImagem);
    TLib.Select('select sistema.fornecedor_update(''logotipo_id'', null, null, null, null, true, ' + FDQueryPrincipalid.AsString + ', 0) as id');
    FDQueryPrincipal.Refresh;
  end;
end;

procedure TframeCadastroFornecedor.ActionVoltarTelaExecute(Sender: TObject);
begin
  if ScrollBoxDetalhes.Enabled then
  begin
    TLib.Select('select sistema.fornecedor_update(''iseditando'', null, null, null, null, false, ' + FDQueryPrincipalid.AsString + ', null) as id');
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

procedure TframeCadastroFornecedor.CarregarContatoEndereco(xId: Integer);
begin
  frameCadastroContato.GEditando := False;
  frameCadastroContato.GTabelaMestreID := xId;
  frameCadastroContato.GTabelaMestre := 'fornecedor';
  frameCadastroContato.CarregarTipo;
  frameCadastroContato.AtualizarListagem;
  TLib.LimparEdit(frameCadastroContato);
end;

procedure TframeCadastroFornecedor.CarregarLista(xQry: TFDQuery; xPesquisa: Boolean);
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

procedure TframeCadastroFornecedor.CarregarPopupBox;
begin
end;

procedure TframeCadastroFornecedor.ConsultarPopup(xTabela, xSender: String);
begin
  frameConsulta.Visible := True;
  ScrollBoxDetalhes.Enabled := False;
  frameConsulta.GTabela := xTabela;
  frameConsulta.GSender := xSender;
  frameConsulta.EditPesquisa.SetFocus;

  frameConsulta.GSelect := ('SELECT id, descricao from sistema.' + xTabela + '_pesquisar_listagem(' + QuotedStr('') + ')');

  frameConsulta.Consultar('descricao');
end;

procedure TframeCadastroFornecedor.EditCNPJ_CPFChange(Sender: TObject);
begin
  inherited;
  if GEditando then
  begin
    TLib.Select('select sistema.fornecedor_update(''cnpj_cpf'', null, null, null, null, ' + QuotedStr(TEdit(Sender).Text) + ', ' +
      FDQueryPrincipalid.AsString + ', null) as id');
    FDQueryPrincipal.Refresh;
  end;
end;

procedure TframeCadastroFornecedor.EditNomeFantasiaChange(Sender: TObject);
begin
  inherited;
  if GEditando then
  begin
    TLib.Select('select sistema.fornecedor_update(''nome_fantasia'', ' + QuotedStr(TEdit(Sender).Text) + ', null, null, null, null, ' +
      FDQueryPrincipalid.AsString + ', null) as id');
    FDQueryPrincipal.Refresh;
  end;
end;

procedure TframeCadastroFornecedor.EditPesquisaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  Pesquisar;
end;

procedure TframeCadastroFornecedor.EditRazaoSocialChange(Sender: TObject);
begin
  inherited;
  if GEditando then
  begin
    TLib.Select('select sistema.fornecedor_update(''razao_social'', null, ' + QuotedStr(TEdit(Sender).Text) + ', null, null, null, ' +
      FDQueryPrincipalid.AsString + ', null) as id');
    FDQueryPrincipal.Refresh;
  end;
end;

procedure TframeCadastroFornecedor.frameConsultaListBoxListaDblClick(Sender: TObject);
var
  LID: Integer;
begin
  inherited;
  if frameConsulta.ListBoxLista.Items.Count > 0 then
  begin
    LID := StrToInt(frameConsulta.ListBoxLista.Selected.StylesData['id'].AsString);

    if frameConsulta.GSender = 'tipocontato' then
    begin
      if GEditando then
      begin
        frameCadastroContato.EditTipoContato.Text := frameConsulta.ListBoxLista.Selected.Text;
        frameCadastroContato.Editar;
        frameCadastroContato.FDQuerytipocontato_id.AsInteger := LID;
        frameCadastroContato.SalvarRegistro;
      end;
    end;
  end;

  frameConsultaActionFecharExecute(Sender);
end;

procedure TframeCadastroFornecedor.frameConsultaListBoxListaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = vkReturn then
  begin
    frameConsultaListBoxListaDblClick(Sender);
  end;
end;

procedure TframeCadastroFornecedor.frameCadastroContatoButtonConsultaTipoContatoClick(Sender: TObject);
begin
  inherited;
  ConsultarPopup('tipocontato', 'tipocontato');
end;

procedure TframeCadastroFornecedor.frameCadastroContatoEditTipoContatoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if Key = vkReturn then
  begin
    frameCadastroContatoButtonConsultaTipoContatoClick(Sender);
  end;
end;

procedure TframeCadastroFornecedor.frameConsultaActionFecharExecute(Sender: TObject);
begin
  ScrollBoxDetalhes.Enabled := True;
  inherited;
  if frameConsulta.GSender = 'tipocontato' then
  begin
    frameCadastroContato.EditTipoContato.SetFocus;
  end;

  frameConsulta.ActionFecharExecute(Sender);
end;

procedure TframeCadastroFornecedor.frameConsultaEditPesquisaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  PesquisarPopup(frameConsulta.GTabela);
  inherited;
  frameConsulta.EditPesquisaKeyUp(Sender, Key, KeyChar, Shift);
end;

procedure TframeCadastroFornecedor.Inicializar;
begin
  GEditando := False;
  GCampoSelect := 'id, nome_fantasia, razao_social, tipo_pessoa, cnpj_cpf, logotipo_id, iseditando';
  GFrameTabela := 'fornecedor';
  SalvarAutomatico(frameCadastroFornecedor);
  // SalvarAutomatico(frameCadastroContato);
  // SalvarAutomatico(frameCadastroEndereco);
  LoadList;
  TabControl.ActiveTab := TabItemList;
end;

procedure TframeCadastroFornecedor.ListBoxItem(xQry: TFDQuery; xItem: TListBoxItem);
begin
  xItem.StylesData['id'] := xQry.FieldByName('id').AsString;
  xItem.Text := 'Nome Fantasia: ' + xQry.FieldByName('nome_fantasia').AsString;
  xItem.StylesData['linha1a'] := EmptyStr;
  xItem.StylesData['linha1a.Width'] := 2000;
  xItem.StylesData['linha1b.visible'] := False;
  if xQry.FieldByName('tipo_pessoa').AsInteger = 0 then
    xItem.StylesData['linha2a'] := 'CPF: ' + TLib.Mascara(xQry.FieldByName('cnpj_cpf').AsString, '999.999.999-99')
  else
    xItem.StylesData['linha2a'] := 'CNPJ: ' + TLib.Mascara(xQry.FieldByName('cnpj_cpf').AsString, '99.999.999/9999-99');
  xItem.StylesData['linha2b'] := EmptyStr;
end;

procedure TframeCadastroFornecedor.ListBoxListDblClick(Sender: TObject);
begin
  LoadRecord(StrToInt(ListBoxList.Selected.StylesData['id'].AsString));
  inherited;
end;

procedure TframeCadastroFornecedor.LoadList;
var
  LQry: TFDQuery;
begin
  LQry := TLib.Select('SELECT id, nome_fantasia, razao_social, tipo_pessoa, cnpj_cpf FROM sistema.fornecedor_listagem_view', nil);

  try
    CarregarLista(LQry, True);
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TframeCadastroFornecedor.LoadNewRecord;
var
  LItem: TListBoxItem;
begin
  LItem := TListBoxItem.Create(ListBoxList);
  LItem.Parent := ListBoxList;
  ListBoxItem(FDQueryPrincipal, LItem);

  ListBoxList.ItemIndex := ListBoxList.Items.Count - 1;
  ListBoxList.SetFocus;
end;

procedure TframeCadastroFornecedor.LoadRecord(xId: Integer);
begin
  GEditando := False;
  CarregarRegistro(xId);
  CarregarContatoEndereco(xId);
  CarregarPopupBox;

  EditNomeFantasia.Text := FDQueryPrincipalnome_fantasia.AsString;
  EditRazaoSocial.Text := FDQueryPrincipalrazao_social.AsString;

  if FDQueryPrincipaltipo_pessoa.AsInteger = 0 then
    RadioButtonPessoaFisica.IsChecked := True
  else
    RadioButtonPessoaJuridica.IsChecked := True;

  TLib.CarregarCPF(EditCNPJ_CPF, FDQueryPrincipalcnpj_cpf.AsString);

  if FDQueryPrincipallogotipo_id.AsInteger <> 0 then
  begin
    TLib.CarregarFoto(FDQueryPrincipallogotipo_id.AsInteger, ImageImagem);
  end
  else
  begin
    TLib.RemoverFoto(ImageImagem);
  end;

  EditNomeFantasia.SetFocus;
  EditNomeFantasia.SelStart := Length(EditNomeFantasia.Text) + 1;

  if (GNovoRegistro) then
  begin
    TLib.Select('select sistema.fornecedor_update(''iseditando'', null, null, null, null, True, ' + FDQueryPrincipalid.AsString + ', null) as id');
    FDQueryPrincipal.Refresh;
    GEditando := True;
    ScrollBoxDetalhes.Enabled := GEditando;
  end
  else
  begin
    if (not FDQueryPrincipaliseditando.AsBoolean) then
    begin
      TLib.Select('select sistema.fornecedor_update(''iseditando'', null, null, null, null, True, ' + FDQueryPrincipalid.AsString + ', null) as id');
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

  frameCadastroContato.GEditando := True;
end;

procedure TframeCadastroFornecedor.Pesquisar;
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
    LQry := TLib.Select('SELECT id, nome_fantasia, razao_social, tipo_pessoa, cnpj_cpf from sistema.fornecedor_pesquisar_listagem(' + LPesquisa + ','
      + LPesquisa + ',' + LPesquisa + ',' + LPesquisa + ')', nil);
    try
      CarregarLista(LQry, False);
    finally
      FreeAndNil(LQry);
    end;
  end;
end;

procedure TframeCadastroFornecedor.PesquisarPopup(xTabela: String);
var
  LPesquisa: String;
begin
  frameConsulta.GCampo := 'descricao';
  LPesquisa := QuotedStr(Trim(frameConsulta.EditPesquisa.Text));
  if (Trim(frameConsulta.EditPesquisa.Text) = EmptyStr) then
  begin
    frameConsulta.GSelect := ('SELECT id, descricao from sistema.' + xTabela + '_pesquisar_listagem(' + QuotedStr('') + ')');
  end
  else
  begin
    frameConsulta.GSelect := ('SELECT id, descricao from sistema.' + xTabela + '_pesquisar_listagem(' + LPesquisa + ')');
  end;
  frameConsulta.Consultar(frameConsulta.GCampo);
end;

procedure TframeCadastroFornecedor.RadioButtonPessoaFisicaChange(Sender: TObject);
begin
  inherited;
  if GEditando then
  begin
    TLib.Select('select sistema.fornecedor_update(''tipo_pessoa'', null, null, 0, null, null, ' + FDQueryPrincipalid.AsString + ', null) as id');
    FDQueryPrincipal.Refresh;
  end;
end;

procedure TframeCadastroFornecedor.RadioButtonPessoaJuridicaChange(Sender: TObject);
begin
  inherited;
  if GEditando then
  begin
    TLib.Select('select sistema.fornecedor_update(''tipo_pessoa'', null, null, 1, null, null, ' + FDQueryPrincipalid.AsString + ', null) as id');
    FDQueryPrincipal.Refresh;
  end;
end;

procedure TframeCadastroFornecedor.SalvarRG(Sender: TObject);
begin
end;

procedure TframeCadastroFornecedor.TabControlChange(Sender: TObject);
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

procedure TframeCadastroFornecedor.UpdateRecord;
var
  LItem: TListBoxItem;
begin
  LItem := ListBoxList.Selected;
  ListBoxItem(FDQueryPrincipal, LItem);
end;

end.
