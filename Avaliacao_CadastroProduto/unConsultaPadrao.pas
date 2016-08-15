unit unConsultaPadrao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FMX.Layouts, FMX.ListBox, FMX.Edit, FMX.Controls.Presentation, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Actions,
  FMX.ActnList, FMX.Objects;

type
  TframeConsultaPadrao = class(TFrame)
    ActionListConsulta: TActionList;
    ActionFechar: TAction;
    FDQueryConsulta: TFDQuery;
    ButtonFechar: TButton;
    PanelPesquisa: TPanel;
    EditPesquisa: TEdit;
    ListBoxLista: TListBox;
    PanelMain: TPanel;
    PanelTop: TPanel;
    TextConsulta: TText;
    procedure ActionFecharExecute(Sender: TObject);
    procedure EditPesquisaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    GSelect, GCampo, GSender, GTabela: String;
    procedure Consultar(xCampo: String);
    function ExisteItem(xItem: String): Boolean;
  end;

implementation

{$R *.fmx}
{ TFrame1 }

procedure TframeConsultaPadrao.ActionFecharExecute(Sender: TObject);
begin
  ListBoxLista.ItemIndex := -1;
  Visible := False;
  Application.ProcessMessages;
end;

procedure TframeConsultaPadrao.Consultar(xCampo: String);
var
  LItem: TListBoxItem;
begin
  FDQueryConsulta.Close;
  FDQueryConsulta.Open(GSelect);
  FDQueryConsulta.First;
  ListBoxLista.Items.Clear;
  while not FDQueryConsulta.Eof do
  begin
    if not ExisteItem(FDQueryConsulta.FieldByName(xCampo).AsString) then
    begin
      LItem := TListBoxItem.Create(ListBoxLista);
      LItem.Parent := ListBoxLista;
      LItem.StylesData['id'] := FDQueryConsulta.FieldByName('id').AsString;
      LItem.Text := FDQueryConsulta.FieldByName(xCampo).AsString;
    end;
    FDQueryConsulta.Next;
  end;
end;

procedure TframeConsultaPadrao.EditPesquisaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    if ListBoxLista.ItemIndex <> -1 then
    begin
      ListBoxLista.ItemIndex := 0;
    end;
    ListBoxLista.SetFocus;
  end
  else if Key = vkEscape then
  begin
    ActionFechar.Execute;
  end;
end;

function TframeConsultaPadrao.ExisteItem(xItem: String): Boolean;
var
  LIdx: Integer;
begin
  Result := False;
  for LIdx := 0 to ListBoxLista.Items.Count - 1 do
  begin
    if ListBoxLista.Items.Strings[LIdx] = xItem then
    begin
      Result := True;
      Break;
    end;
  end;
end;

end.
