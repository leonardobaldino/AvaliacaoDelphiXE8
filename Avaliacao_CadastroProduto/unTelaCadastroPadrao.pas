unit unTelaCadastroPadrao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Objects, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.Rtti, FMX.Grid, FMX.ListBox, FMX.TabControl, FMX.Edit, FMX.Controls.Presentation,
  System.Actions, FMX.ActnList, FMX.Memo, FMX.DateTimeCtrls, FMX.CalendarEdit;

type
  TframeTelaCadastroPadrao = class(TFrame)
    TabControl: TTabControl;
    TabItemList: TTabItem;
    LayoutList: TLayout;
    ListBoxList: TListBox;
    TabItemCad: TTabItem;
    ButtonReturn: TButton;
    Panel: TPanel;
    PanelButtons: TPanel;
    PanelList: TPanel;
    PanelBottom: TPanel;
    ButtonRefresh: TButton;
    PanelPesquisa: TPanel;
    EditPesquisa: TEdit;
    ScrollBoxDetalhes: TScrollBox;
    ActionList: TActionList;
    PanelTop: TPanel;
    LabelTitulo: TLabel;
    PanelSuperior: TPanel;
    ButtonNovoRegistro: TButton;
    ActionNovoRegistro: TAction;
    OpenDialog: TOpenDialog;
    LayoutPrincipal: TLayout;
    ActionAtualizarLista: TAction;
    ButtonExcluirRegistro: TButton;
    ActionExcluirRegistro: TAction;
    ActionVoltarTela: TAction;
    LayoutTitulo: TLayout;
    FDQueryPrincipal: TFDQuery;
    procedure ListBoxListDblClick(Sender: TObject);
    procedure FrameKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure ActionNovoRegistroExecute(Sender: TObject);
    procedure ActionExcluirRegistroExecute(Sender: TObject);
    procedure ActionVoltarTelaExecute(Sender: TObject);
    procedure ActionAtualizarListaExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    GEditando, GNovoRegistro: Boolean;
    GFrameTabela: String;
    GCampoSelect, GSelectNovoRegistro: String;
    function AutoInc(xTable, xPrimaryKey: String): Integer;
    procedure DoClearClick(Sender: TObject);
    procedure CarregarRegistro(xID: Integer);
    procedure SalvarRegistro(Sender: TObject);
    procedure SalvarAutomatico(frame: TFrame);
    procedure Editar;
    procedure EditMascaraData(Sender: TObject);
    procedure EditMascaraCPF(Sender: TObject);
    procedure EditMascaraHora(Sender: TObject);
    procedure EditKeyUpSomenteNumero(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure EditKeyUpLetraMaiuscula(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure LetraMaiuscula(Sender: TObject);
  end;

implementation

{$R *.fmx}

uses unMain, unLib;

{ TframeStandardFrame }

procedure TframeTelaCadastroPadrao.ActionAtualizarListaExecute(Sender: TObject);
begin
  EditPesquisa.Text := EmptyStr;
end;

procedure TframeTelaCadastroPadrao.ActionExcluirRegistroExecute(Sender: TObject);
var
  LIdx: Integer;
begin
  if ListBoxList.Items.Count > 0 then
  begin
    TLib.Select('SELECT sistema.' + GFrameTabela + '_remove(' + ListBoxList.Selected.StylesData['id'].AsString + ')');
    LIdx := ListBoxList.ItemIndex;
    ListBoxList.Items.Delete(ListBoxList.ItemIndex);
    if LIdx = 0 then
      ListBoxList.ItemIndex := 0
    else
      ListBoxList.ItemIndex := LIdx - 1;
  end;
end;

procedure TframeTelaCadastroPadrao.ActionNovoRegistroExecute(Sender: TObject);
var
  LId: Integer;
begin
  GEditando := False;
  ListBoxList.ItemIndex := -1;
  CarregarRegistro(TLib.Select(GSelectNovoRegistro));
  GEditando := True;
  GNovoRegistro := True;
end;

procedure TframeTelaCadastroPadrao.ActionVoltarTelaExecute(Sender: TObject);
begin
  // if FDQueryPrincipal.State in [dsInsert, dsEdit] then
  // begin
  // FDQueryPrincipal.Post;
  // end;

  TabControl.ActiveTab := TabItemList;
  GEditando := False;
  GNovoRegistro := False;
end;

function TframeTelaCadastroPadrao.AutoInc(xTable, xPrimaryKey: String): Integer;
var
  LFDQuery: TFDQuery;
begin
  LFDQuery := TFDQuery.Create(nil);
  try
    LFDQuery.Connection := frmMain.FDConnection;
    LFDQuery.Close;
    LFDQuery.SQL.Clear;
    LFDQuery.SQL.Add('Select Max(' + xPrimaryKey + ')+1 From ' + xTable);
    LFDQuery.Open;
    Result := LFDQuery.Fields[0].AsInteger;
  finally
    FreeAndNil(LFDQuery);
  end;
end;

procedure TframeTelaCadastroPadrao.CarregarRegistro(xID: Integer);
begin
  FDQueryPrincipal.Close;
  FDQueryPrincipal.SQL.Text := 'SELECT ' + GCampoSelect + ' FROM sistema.' + GFrameTabela + '_view where ID = ' + IntToStr(xID);
  // FDQueryPrincipal.SQL.Text := 'SELECT * FROM sistema.' + GFrameTabela + '_view where ID = ' + IntToStr(xID);
  FDQueryPrincipal.Open;
  // FDQuery.Locate('id', xId, [loCaseInsensitive]);
  FDQueryPrincipal.Edit;
end;

procedure TframeTelaCadastroPadrao.DoClearClick(Sender: TObject);
begin
  TEdit(TFMXObject(Sender).Parent.Parent).Text := EmptyStr;
  TEdit(TFMXObject(Sender).Parent.Parent).SetFocus;
end;

procedure TframeTelaCadastroPadrao.Editar;
begin
  if FDQueryPrincipal.State in [dsBrowse] then
  begin
    FDQueryPrincipal.Edit;
  end;
end;

procedure TframeTelaCadastroPadrao.EditKeyUpLetraMaiuscula(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  LStart: Integer;
begin
  LStart := TEdit(Sender).SelStart;
  TEdit(Sender).Text := AnsiUpperCase(TEdit(Sender).Text);
  TEdit(Sender).SelStart := LStart;
end;

procedure TframeTelaCadastroPadrao.EditKeyUpSomenteNumero(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if not(AnsiChar(KeyChar) in ['0' .. '9', #8]) then
  begin
    KeyChar := #0;
    Abort;
  end;
end;

procedure TframeTelaCadastroPadrao.EditMascaraCPF(Sender: TObject);
begin
  TLib.MascaraCPF(TEdit(Sender));
end;

procedure TframeTelaCadastroPadrao.EditMascaraData(Sender: TObject);
begin
  TLib.MascaraData(TEdit(Sender));
end;

procedure TframeTelaCadastroPadrao.EditMascaraHora(Sender: TObject);
begin
  TLib.MascaraHora(TEdit(Sender));
end;

procedure TframeTelaCadastroPadrao.LetraMaiuscula(Sender: TObject);
var
  LStart: Integer;
begin
  LStart := TEdit(Sender).SelStart;
  TEdit(Sender).Text := AnsiUpperCase(TEdit(Sender).Text);
  TEdit(Sender).SelStart := LStart;
end;

procedure TframeTelaCadastroPadrao.FrameKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkS then
    SalvarRegistro(Self);
end;

procedure TframeTelaCadastroPadrao.ListBoxListDblClick(Sender: TObject);
begin
  TabControl.ActiveTab := TabItemCad;
  GNovoRegistro := False;
end;

procedure TframeTelaCadastroPadrao.SalvarAutomatico(frame: TFrame);
var
  LIdx: Integer;
  LComponent: TComponent;
begin
  for LIdx := 0 to frame.ComponentCount - 1 do
  begin
    LComponent := frame.Components[LIdx];
    if LComponent is TEdit then
    begin
      // if TEdit(LComponent).Tag = 1 then
      // begin
      // TEdit(LComponent).OnChange := SalvarRegistro;
      // TEdit(LComponent).OnEnter := SalvarRegistro;
      // TEdit(LComponent).OnExit := EditOnExitLetraMaiuscula;
      // TEdit(LComponent).OnKeyUp := EditKeyUpLetraMaiuscula;
      // end
      // else
      if Pos('data', LowerCase(TEdit(LComponent).Name)) > 0 then
      begin
        TEdit(LComponent).OnChange := EditMascaraData;
        TEdit(LComponent).OnKeyUp := EditKeyUpSomenteNumero;
      end
      else if Pos('cpf', LowerCase(TEdit(LComponent).Name)) > 0 then
      begin
        TEdit(LComponent).OnChange := EditMascaraCPF;
        TEdit(LComponent).OnKeyUp := EditKeyUpSomenteNumero;
      end
      else if Pos('hora', LowerCase(TEdit(LComponent).Name)) > 0 then
      begin
        TEdit(LComponent).OnChange := EditMascaraHora;
        TEdit(LComponent).OnKeyUp := EditKeyUpSomenteNumero;
      end;
    end
    else if LComponent is TCheckBox then
    begin
      // TCheckBox(LComponent).OnChange := SalvarRegistro;
      // TCheckBox(LComponent).OnEnter := SalvarRegistro;
      TCheckBox(LComponent).OnExit := SalvarRegistro;
    end
    else if LComponent is TMemo then
    begin
      // TMemo(LComponent).OnChange := SalvarRegistro;
      // TMemo(LComponent).OnEnter := SalvarRegistro;
      TMemo(LComponent).OnExit := SalvarRegistro;
    end;
  end;
end;

procedure TframeTelaCadastroPadrao.SalvarRegistro(Sender: TObject);
begin
  if GEditando then
  begin
    if FDQueryPrincipal.State in [dsInsert, dsEdit] then
    begin
      FDQueryPrincipal.Post;
    end;
  end;
end;

end.
