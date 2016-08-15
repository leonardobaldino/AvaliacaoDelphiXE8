unit unLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit, System.Actions, FMX.ActnList,
  FMX.Layouts, System.Rtti;

type
  TframeLogin = class(TFrame)
    GroupBoxLogin: TGroupBox;
    EditUsuario: TEdit;
    LabelUsuario: TLabel;
    EditSenha: TEdit;
    LabelSenha: TLabel;
    PanelTop: TPanel;
    ButtonFechar: TButton;
    ActionList: TActionList;
    ActionFechar: TAction;
    ButtonEntrar: TButton;
    ActionEntrar: TAction;
    LayoutPrincipal: TLayout;
    procedure ActionFecharExecute(Sender: TObject);
    procedure ActionEntrarExecute(Sender: TObject);
    procedure EditUsuarioKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure EditSenhaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Inicializar;
    procedure DoCloseClick(Sender: TObject);
    procedure EditKeyUpLetraMaiuscula(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  end;

var
  frameLogin: TframeLogin;

implementation

{$R *.fmx}

uses unLib, unMain;

procedure TframeLogin.ActionEntrarExecute(Sender: TObject);
begin
  if not TAcesso.ValidarUsuario(EditUsuario.Text) then
  begin
    EditUsuario.SetFocus;
    Abort;
  end
  else
  begin
    if EditUsuario.Text <> TAcesso.admLogin then
    begin
      if not TAcesso.ValidarSenha(EditUsuario.Text, EditSenha.Text) then
      begin
        EditSenha.SetFocus;
        Abort;
      end;
    end
    else
    begin
      if not TAcesso.ValidarAdmin(EditUsuario.Text, EditSenha.Text) then
      begin
        EditSenha.Text;
        Abort;
      end;
    end; // if EditUsuario.Text <> TAcesso.admLogin then
  end; // if not TAcesso.ValidarUsuario(EditUsuario.Text) then

  Visible := False;
  frmMain.GUsuarioNome := EditUsuario.Text;
  if EditUsuario.Text <> TAcesso.admLogin then
  begin
    frmMain.GUsuarioID := TLib.Select('select id from sistema.usuario_view where usuario_nome = ' + QuotedStr(EditUsuario.Text));
    with frmMain do
    begin
      if not TAcesso.ValidaAcesso('', True, False) then
      begin
        ButtonMenuProduto.Visible := TAcesso.ValidaAcesso('frameCadastroProduto', True, False);
        ButtonMenuFornecedor.Visible := TAcesso.ValidaAcesso('frameCadastroFornecedor', True, False);
        ButtonMenuManutencaoSistema.Visible := TAcesso.ValidaAcesso('frameManutencaoSistema', True, False);
      end;
    end;
  end
  else
  begin
    frmMain.GUsuarioID := 0;
  end;
  // FreeAndNil(frameLogin);
end;

procedure TframeLogin.ActionFecharExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TframeLogin.DoCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TframeLogin.EditKeyUpLetraMaiuscula(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  TEdit(Sender).Text := AnsiUpperCase(TEdit(Sender).Text);
  TEdit(Sender).SelStart := Length(TEdit(Sender).Text);
end;

procedure TframeLogin.EditSenhaKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkReturn then
  begin
    ButtonEntrar.SetFocus;
  end;
end;

procedure TframeLogin.EditUsuarioKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  LStart: Integer;
begin
  LStart := TEdit(Sender).SelStart;
  if Key = vkReturn then
  begin
    EditSenha.SetFocus;
  end;
  TEdit(Sender).Text := AnsiUpperCase(TEdit(Sender).Text);
  TEdit(Sender).SelStart := LStart;
end;

procedure TframeLogin.Inicializar;
begin
  LayoutPrincipal.Align := TAlignLayout.Center;
  GroupBoxLogin.StylesData['buttonexit.OnClick'] := TValue.From<TNotifyEvent>(DoCloseClick);
end;

end.
