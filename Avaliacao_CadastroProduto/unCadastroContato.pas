unit unCadastroContato;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, unTelaCadastroPadrao2, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Actions, FMX.ActnList,
  FMX.Ani, FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation, FMX.ExtCtrls, FMX.Edit, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope;

type
  TframeCadastroContato = class(TframeTelaCadastroPadrao2)
    EditAdicionais: TEdit;
    EditDescricaoContato: TEdit;
    LabelAdicionais: TLabel;
    LabelContato: TLabel;
    LabelDescricao: TLabel;
    LabelTipo: TLabel;
    BindSourceDBContato: TBindSourceDB;
    BindingsListContato: TBindingsList;
    ContatoDescricao: TLinkControlToField;
    ContatoAdicional: TLinkControlToField;
    FDQueryid: TLargeintField;
    FDQuerytipocontato_id: TLargeintField;
    FDQueryvalor: TWideMemoField;
    FDQueryadicional: TWideMemoField;
    EditTipoContato: TEdit;
    ButtonConsultaTipoContato: TButton;
    procedure ListBoxListaClick(Sender: TObject);
    procedure FDQueryAfterPost(DataSet: TDataSet);
    procedure EditDescricaoContatoChange(Sender: TObject);
    procedure EditDescricaoContatoEnter(Sender: TObject);
    procedure EditDescricaoContatoExit(Sender: TObject);
    procedure ActionExcluirRegistroExecute(Sender: TObject);
    procedure ActionNovoRegistroExecute(Sender: TObject);
    procedure FDQueryBeforePost(DataSet: TDataSet);
    procedure EditAdicionaisChange(Sender: TObject);
    procedure EditAdicionaisEnter(Sender: TObject);
    procedure EditAdicionaisExit(Sender: TObject);
    procedure ListBoxListaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure EditLetraMaiusculaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CarregarTipo;
    procedure AtualizarListagem;
    procedure CarregarRegistro(xId: Integer);
    procedure SalvarRegistro;
    procedure NovoRegistro;
  end;

var
  frameCadastroContato: TframeCadastroContato;

implementation

{$R *.fmx}

uses unLib, unMain;

{ TframeTelaCadastroPadrao1 }

procedure TframeCadastroContato.ActionExcluirRegistroExecute(Sender: TObject);
var
  LIdx: Integer;
begin
  // inherited;
  if ListBoxLista.Items.Count > 0 then
  begin
    TLib.Select('SELECT sistema.' + GTabelaMestre + '_contato_remove(' + IntToStr(GTabelaMestreID) + ',' + ListBoxLista.Selected.StylesData['id']
      .AsString + ')');
    LIdx := ListBoxLista.ItemIndex;
    ListBoxLista.Items.Delete(ListBoxLista.ItemIndex);
    if LIdx = 0 then
      ListBoxLista.ItemIndex := 0
    else
      ListBoxLista.ItemIndex := LIdx - 1;
  end;

  if ListBoxLista.Items.Count = 0 then
  begin
    TLib.LimparEdit(frameCadastroContato);
    GroupBoxDetalhes.Enabled := False;
  end;
end;

procedure TframeCadastroContato.ActionNovoRegistroExecute(Sender: TObject);
begin
  // inherited;
  NovoRegistro;
end;

procedure TframeCadastroContato.AtualizarListagem;
var
  LItem: TListBoxItem;
  LQry: TFDQuery;
begin
  TLib.ListBoxClear(ListBoxLista);

  LQry := TFDQuery.Create(nil);
  try
    LQry.Connection := frmMain.FDConnection;
    LQry.Close;
    LQry.Open('SELECT id, tipocontato_id, valor, adicional, ' + GTabelaMestre + '_id FROM sistema.' + GTabelaMestre + '_contato_view ' + 'where ' +
      GTabelaMestre + '_id = ' + IntToStr(GTabelaMestreID));

    while not LQry.Eof do
    begin
      LItem := TListBoxItem.Create(ListBoxLista);
      LItem.Parent := ListBoxLista;
      LItem.StylesData['id'] := LQry.FieldByName('id').AsString;;
      LItem.StylesData['idaux'] := LQry.FieldByName('tipocontato_id').AsString;;
      LItem.Text := LQry.FieldByName('valor').AsString;
      LItem.StylesData['linha1'] := LQry.FieldByName('adicional').AsString;;
      LQry.Next;
    end;
  finally
    FreeAndNil(LQry);
  end;

  ListBoxLista.ItemIndex := 0;
  ListBoxLista.SetFocus;
end;

procedure TframeCadastroContato.CarregarRegistro(xId: Integer);
begin
  GEditando := False;
  FDQuery.Close;
  FDQuery.Open('select * from sistema.contato_view where id = ' + IntToStr(xId));
  FDQuery.Edit;

  EditTipoContato.Text := TLib.Select('select descricao from sistema.tipocontato_view where id = ' + IntToStr(FDQuerytipocontato_id.AsInteger));
  FDQuery.Edit;
  GroupBoxDetalhes.Enabled := True;
  GEditando := True;
end;

procedure TframeCadastroContato.CarregarTipo;
begin
  GroupBoxDetalhes.Enabled := False;
end;

procedure TframeCadastroContato.EditAdicionaisChange(Sender: TObject);
begin
  inherited;
  SalvarRegistro;
end;

procedure TframeCadastroContato.EditAdicionaisEnter(Sender: TObject);
begin
  inherited;
  SalvarRegistro;
end;

procedure TframeCadastroContato.EditAdicionaisExit(Sender: TObject);
begin
  inherited;
  TEdit(Sender).Text := AnsiUpperCase(TEdit(Sender).Text);
  SalvarRegistro;
end;

procedure TframeCadastroContato.EditDescricaoContatoChange(Sender: TObject);
begin
  inherited;
  SalvarRegistro;
end;

procedure TframeCadastroContato.EditDescricaoContatoEnter(Sender: TObject);
begin
  inherited;
  SalvarRegistro;
end;

procedure TframeCadastroContato.EditDescricaoContatoExit(Sender: TObject);
begin
  inherited;
  TEdit(Sender).Text := AnsiUpperCase(TEdit(Sender).Text);
  SalvarRegistro;
end;

procedure TframeCadastroContato.EditLetraMaiusculaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TEdit(Sender).Text := AnsiUpperCase(TEdit(Sender).Text);
  TEdit(Sender).SelStart := Length(TEdit(Sender).Text);
end;

procedure TframeCadastroContato.FDQueryAfterPost(DataSet: TDataSet);
var
  LItem: TListBoxItem;
begin
  inherited;
  LItem := ListBoxLista.Selected;
  LItem.Text := EditDescricaoContato.Text;
  LItem.StylesData['linha1'] := EditAdicionais.Text;
end;

procedure TframeCadastroContato.FDQueryBeforePost(DataSet: TDataSet);
begin
  inherited;
  FDQueryExec.Close;
  FDQueryExec.SQL.Clear;
  FDQueryExec.SQL.Add('update sistema.' + GTabelaMestre + '_contato set dtupdate = now() where ' + GTabelaMestre + '_id = ' +
    IntToStr(GTabelaMestreID) + ' and contato_id = ' + ListBoxLista.Selected.StylesData['id'].AsString);
  FDQueryExec.ExecSQL;
end;

procedure TframeCadastroContato.ListBoxListaClick(Sender: TObject);
begin
  // inherited;
  if ListBoxLista.Items.Count > 0 then
  begin
    CarregarRegistro(StrToInt(ListBoxLista.Selected.StylesData['id'].AsString));
  end;
end;

procedure TframeCadastroContato.ListBoxListaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  // inherited;
  ListBoxListaClick(Sender);
  if Key = vkReturn then
  begin
    EditTipoContato.SetFocus;
  end;
end;

procedure TframeCadastroContato.NovoRegistro;
var
  LIdx: Integer;
  LItem: TListBoxItem;
  LIdContato: Integer;
begin
  LIdContato := TLib.Select('SELECT sistema.contato_insert(1,' + QuotedStr('NOVOCONTATO' + IntToStr(ListBoxLista.Items.Count - 1)) + ',null,' +
    IntToStr(frmMain.GUsuarioID) + ') as id');;

  TLib.Select('SELECT sistema.' + GTabelaMestre + '_contato_insert(' + IntToStr(GTabelaMestreID) + ',' + IntToStr(LIdContato) + ',' +
    IntToStr(frmMain.GUsuarioID) + ') as id');

  AtualizarListagem;

  for LIdx := 0 to ListBoxLista.Items.Count - 1 do
  begin
    LItem := ListBoxLista.ItemByIndex(LIdx);
    if LIdContato = StrToInt(LItem.StylesData['id'].AsString) then
    begin
      ListBoxLista.ItemIndex := LIdx;
      Break;
    end;
  end;

  ListBoxListaClick(Self);
end;

procedure TframeCadastroContato.SalvarRegistro;
begin
  if GEditando then
  begin
    if FDQuery.State in [dsInsert, dsEdit] then
    begin
      FDQuery.Post;
    end;
  end;
end;

end.
