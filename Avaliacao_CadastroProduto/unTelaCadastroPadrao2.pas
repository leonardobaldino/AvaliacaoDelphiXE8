unit unTelaCadastroPadrao2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, System.Actions,
  FMX.ActnList, FMX.Ani, FMX.Layouts, FMX.ListBox, FMX.Controls.Presentation, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FMX.Edit, System.Rtti, FMX.Memo;

type
  TframeTelaCadastroPadrao2 = class(TFrame)
    LayoutPrincipal: TLayout;
    CalloutPanelPrincipal: TCalloutPanel;
    GroupBoxTodos: TGroupBox;
    ListBoxLista: TListBox;
    RectAnimation1: TRectAnimation;
    GroupBoxDetalhes: TGroupBox;
    ActionList: TActionList;
    ActionNovoRegistro: TAction;
    ActionExcluirRegistro: TAction;
    FDQueryExec: TFDQuery;
    FDQuery: TFDQuery;
    LayoutTitulo: TLayout;
    LabelTitulo: TLabel;
    LayoutButtons: TLayout;
    ButtonNovo: TButton;
    ButtonExcluir: TButton;
    PanelButtons: TPanel;
    ButtonReturn: TButton;
    ActionVoltarTela: TAction;
    procedure ActionNovoRegistroExecute(Sender: TObject);
    procedure ActionExcluirRegistroExecute(Sender: TObject);
    procedure ListBoxListaClick(Sender: TObject);
    procedure ListBoxListaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    GFrameTabela: String;
    GId: Integer;
    GEditando, GNovoRegistro: Boolean;
    GTabelaMestreID: Integer;
    GTabelaMestre: String;
    procedure NovoRegistro;
    procedure AtualizarListagem;
    procedure CarregarRegistro(xId: Integer);
    procedure AbrirTabela;
    procedure DoClearClick(Sender: TObject);
    procedure Editar;
    procedure SalvarRegistro(Sender: TObject);
    procedure SalvarAutomatico(frame: TFrame);
    procedure EditMascaraData(Sender: TObject);
    procedure EditMascaraCPF(Sender: TObject);
    procedure EditMascaraHora(Sender: TObject);
    procedure EditSomenteNumeroKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure EditLetraMaiusculaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure AtulizarRegistro;
  end;

implementation

{$R *.fmx}

uses unLib, unMain;

{ TframeTelaCadastroPadrao2 }

procedure TframeTelaCadastroPadrao2.AbrirTabela;
var
  LIdx: Integer;
begin
  if FDQuery.Active then
    FDQuery.Close;

  FDQuery.Open;

  for LIdx := 0 to Self.ComponentCount - 1 do
  begin
    if Self.Components[LIdx] is TEdit then
    begin
      TEdit(Self.Components[LIdx]).StylesData[CCLEARCLICK] := TValue.From<TNotifyEvent>(DoClearClick);
    end;
  end;
  GroupBoxDetalhes.Enabled := False;
end;

procedure TframeTelaCadastroPadrao2.ActionExcluirRegistroExecute(Sender: TObject);
var
  LIdx: Integer;
begin
  if ListBoxLista.Items.Count > 0 then
  begin
    TLib.Select('SELECT sistema.' + GFrameTabela + '_remove(' + ListBoxLista.Selected.StylesData['id'].AsString + ')');
    LIdx := ListBoxLista.ItemIndex;
    ListBoxLista.Items.Delete(ListBoxLista.ItemIndex);
    if LIdx = 0 then
      ListBoxLista.ItemIndex := 0
    else
      ListBoxLista.ItemIndex := LIdx - 1;
  end;

  if ListBoxLista.Items.Count = 0 then
  begin
    GroupBoxDetalhes.Enabled := False;
  end;
end;

procedure TframeTelaCadastroPadrao2.ActionNovoRegistroExecute(Sender: TObject);
begin
  NovoRegistro;
end;

procedure TframeTelaCadastroPadrao2.AtualizarListagem;
var
  LItem: TListBoxItem;
begin
  FDQuery.Close;
  FDQuery.Open;

  TLib.ListBoxClear(ListBoxLista);

  while not FDQuery.Eof do
  begin
    LItem := TListBoxItem.Create(ListBoxLista);
    LItem.Parent := ListBoxLista;
    LItem.StylesData['id'] := FDQuery.FieldByName('id').AsString;;
    LItem.Text := FDQuery.Fields[1].AsString;
    FDQuery.Next;
  end;

  ListBoxLista.ItemIndex := 0;
  ListBoxLista.SetFocus;
  // ListBoxListaClick(Self);
end;

procedure TframeTelaCadastroPadrao2.AtulizarRegistro;
begin
  try
    ListBoxLista.Selected.Text := FDQuery.FieldByName('descricao').AsString;
  except
  end;
end;

procedure TframeTelaCadastroPadrao2.CarregarRegistro(xId: Integer);
begin
  FDQuery.Locate('id', xId, [loCaseInsensitive]);
  FDQuery.Edit;
  GroupBoxDetalhes.Enabled := True;
  GNovoRegistro := False;
end;

procedure TframeTelaCadastroPadrao2.DoClearClick(Sender: TObject);
begin
  TEdit(TFMXObject(Sender).Parent.Parent).Text := EmptyStr;
  TEdit(TFMXObject(Sender).Parent.Parent).SetFocus;
end;

procedure TframeTelaCadastroPadrao2.Editar;
begin
  if FDQuery.State in [dsBrowse] then
  begin
    FDQuery.Edit;
  end;
end;

procedure TframeTelaCadastroPadrao2.EditLetraMaiusculaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  LStart: Integer;
begin
  LStart := TEdit(Sender).SelStart;
  TEdit(Sender).Text := AnsiUpperCase(TEdit(Sender).Text);
  TEdit(Sender).SelStart := LStart;
end;

procedure TframeTelaCadastroPadrao2.EditSomenteNumeroKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if not(AnsiChar(KeyChar) in ['0' .. '9', #8]) then
    Abort;
end;

procedure TframeTelaCadastroPadrao2.EditMascaraCPF(Sender: TObject);
begin
  TLib.MascaraCPF(TEdit(Sender));
end;

procedure TframeTelaCadastroPadrao2.EditMascaraData(Sender: TObject);
begin
  TLib.MascaraData(TEdit(Sender));
end;

procedure TframeTelaCadastroPadrao2.EditMascaraHora(Sender: TObject);
begin
  TLib.MascaraHora(TEdit(Sender));
end;

procedure TframeTelaCadastroPadrao2.ListBoxListaClick(Sender: TObject);
begin
  if ListBoxLista.Items.Count > 0 then
  begin
    CarregarRegistro(StrToInt(ListBoxLista.Selected.StylesData['id'].AsString));
  end;
end;

procedure TframeTelaCadastroPadrao2.ListBoxListaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if ListBoxLista.Items.Count > 0 then
  begin
    CarregarRegistro(StrToInt(ListBoxLista.Selected.StylesData['id'].AsString));
  end;
end;

procedure TframeTelaCadastroPadrao2.NovoRegistro;
var
  LIdx: Integer;
  LItem: TListBoxItem;
  LStr: String;
begin
  GNovoRegistro := True;
  FDQueryExec.Close;
  LStr := 'SELECT sistema.' + GFrameTabela + '_insert(' + QuotedStr(AnsiUpperCase(GFrameTabela) + IntToStr(ListBoxLista.Items.Count - 1)) + ') as id';
  FDQueryExec.Open(LStr);
  GId := FDQueryExec.FieldByName('id').AsInteger;
  FDQueryExec.Close;
  FDQuery.Close;
  FDQuery.Open;

  AtualizarListagem;

  for LIdx := 0 to ListBoxLista.Items.Count - 1 do
  begin
    LItem := ListBoxLista.ItemByIndex(LIdx);
    if GId = StrToInt(LItem.StylesData['id'].AsString) then
    begin
      ListBoxLista.ItemIndex := LIdx;
      Break;
    end;
  end;

  ListBoxListaClick(Self);
  GNovoRegistro := True;
end;

procedure TframeTelaCadastroPadrao2.SalvarAutomatico(frame: TFrame);
var
  LIdx: Integer;
  LComponent: TComponent;
begin
  for LIdx := 0 to frame.ComponentCount - 1 do
  begin
    LComponent := frame.Components[LIdx];
    if LComponent is TEdit then
    begin
      if TEdit(LComponent).Tag = 1 then
      begin
        TEdit(LComponent).OnChange := SalvarRegistro;
        TEdit(LComponent).OnEnter := SalvarRegistro;
        TEdit(LComponent).OnExit := SalvarRegistro;
        TEdit(LComponent).OnKeyUp := EditLetraMaiusculaKeyUp;
      end
      else if Pos('data', LowerCase(TEdit(LComponent).Name)) > 0 then
      begin
        TEdit(LComponent).OnChange := EditMascaraData;
        TEdit(LComponent).OnKeyUp := EditSomenteNumeroKeyUp;
      end
      else if Pos('cpf', LowerCase(TEdit(LComponent).Name)) > 0 then
      begin
        TEdit(LComponent).OnChange := EditMascaraCPF;
        TEdit(LComponent).OnKeyUp := EditSomenteNumeroKeyUp;
      end
      else if Pos('hora', LowerCase(TEdit(LComponent).Name)) > 0 then
      begin
        TEdit(LComponent).OnChange := EditMascaraHora;
        TEdit(LComponent).OnKeyUp := EditSomenteNumeroKeyUp;
      end;
    end
    else if LComponent is TCheckBox then
    begin
      TCheckBox(LComponent).OnChange := SalvarRegistro;
      TCheckBox(LComponent).OnEnter := SalvarRegistro;
      TCheckBox(LComponent).OnExit := SalvarRegistro;
    end
    else if LComponent is TMemo then
    begin
      TMemo(LComponent).OnChange := SalvarRegistro;
      TMemo(LComponent).OnEnter := SalvarRegistro;
      TMemo(LComponent).OnExit := SalvarRegistro;
    end;
  end;
end;

procedure TframeTelaCadastroPadrao2.SalvarRegistro(Sender: TObject);
begin
  if GEditando then
  begin
    if FDQuery.State in [dsInsert, dsEdit] then
    begin
      FDQuery.Post;
      AtulizarRegistro;
    end;
  end;
end;

end.
