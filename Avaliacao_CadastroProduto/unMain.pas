unit unMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.FMXUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FMX.Effects, FMX.Filter.Effects,
  FMX.Layouts, FMX.TabControl, System.Rtti, unLib, FMX.ExtCtrls, FireDAC.Phys.FBDef, FMX.Controls.Presentation, FMX.Objects, FMX.Edit, FMX.ListBox,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FMX.Ani, FMX.Colors, FMX.TreeView;

type
  TfrmMain = class(TForm)
    FDConnection: TFDConnection;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDQuery: TFDQuery;
    GloomEffect1: TGloomEffect;
    LayoutButtons: TLayout;
    LayoutTelas: TLayout;
    PanelExpand: TPanel;
    PanelButton: TPanel;
    ButtonMenuFornecedor: TButton;
    TabControl: TTabControl;
    PopupBoxTabs: TPopupBox;
    FDTransaction: TFDTransaction;
    StyleBook: TStyleBook;
    FDPhysPgDriverLink: TFDPhysPgDriverLink;
    ButtonMenuManutencaoSistema: TButton;
    ButtonMenuProduto: TButton;
    ImageEmpresa: TImage;
    PanelTop: TPanel;
    PanelFecharSistema: TPanel;
    PanelMinimizarSistema: TPanel;
    PanelMaximizarSistema: TPanel;
    TextInfamatV5: TText;
    LayoutLogoInfamat: TLayout;
    ImageLogoInfamat: TImage;
    PanelStatus: TPanel;
    TextStatus: TText;
    Line1: TLine;
    Text2: TText;
    ImageBackground: TImage;
    PanelLogoInfamat: TPanel;
    Layout1: TLayout;
    Line2: TLine;
    TimerBackGround: TTimer;
    Line3: TLine;
    LayoutMainTop: TLayout;
    Panel4: TPanel;
    ButtonMenuAjuda: TButton;
    LayoutMain: TLayout;
    procedure FormCreate(Sender: TObject);
    procedure PanelExpandClick(Sender: TObject);
    procedure ButtonMenuComicsClick(Sender: TObject);
    procedure PopupBoxTabsChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonMenuManutencaoSistemaClick(Sender: TObject);
    procedure ButtonMenuProdutoClick(Sender: TObject);
    procedure PanelMinimizarSistemaClick(Sender: TObject);
    procedure PanelMaximizarSistemaClick(Sender: TObject);
    procedure PanelFecharSistemaClick(Sender: TObject);
    procedure TimerBackGroundTimer(Sender: TObject);
    procedure ButtonMenuAjudaClick(Sender: TObject);
    procedure PanelTopDblClick(Sender: TObject);
    procedure ButtonMenuFornecedorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    GUsuarioNome: String;
    GUsuarioID: Integer;
    procedure OnCloseTabItem(Sender: TObject);
    function CreateTabItem(xOwner: TTabControl; xText, xStyle: String): TTabItem; overload;
    function CreateTabItem(xOwner: TObject; Sender: TObject): TTabItem; overload;
    function LocateTabItem(xTabItem: String): TTabItem;
    function LoadStreamPicture(xFileName: String): TBitmap;
  end;

var
  frmMain: TfrmMain;
  GStyleBook: TStyleBook;
  GFrame: TFrame;
  GBDHOST, GBDNAME, GHOSTNAME: String;
  GDeletandoAba: Boolean;

implementation

{$R *.fmx}

uses unManutencaoSistema, unAjuda, unLogin, unCadastroFornecedor, unCadastroProduto;

procedure TfrmMain.ButtonMenuManutencaoSistemaClick(Sender: TObject);
begin
  CreateTabItem(TabControl, Sender);
  frameManutencaoSistema := TframeManutencaoSistema.Create(TabControl.ActiveTab);
  TLib.LoadFrame(TFrame(frameManutencaoSistema), TabControl.ActiveTab);
end;

procedure TfrmMain.ButtonMenuAjudaClick(Sender: TObject);
begin
  CreateTabItem(TabControl, Sender);
  frameAjuda := TframeAjuda.Create(TabControl.ActiveTab);
  TLib.LoadFrame(TFrame(frameAjuda), TabControl.ActiveTab);
  frameAjuda.IniciarFrame;
end;

procedure TfrmMain.ButtonMenuProdutoClick(Sender: TObject);
begin
  CreateTabItem(TabControl, Sender);
  frameCadastroProduto := TframeCadastroProduto.Create(TabControl.ActiveTab);
  TLib.LoadFrame(TFrame(frameCadastroProduto), TabControl.ActiveTab);
  frameCadastroProduto.Inicializar;
end;

procedure TfrmMain.ButtonMenuComicsClick(Sender: TObject);
begin
  CreateTabItem(TabControl, Sender);
end;

procedure TfrmMain.ButtonMenuFornecedorClick(Sender: TObject);
begin
  CreateTabItem(TabControl, Sender);
  frameCadastroFornecedor := TframeCadastroFornecedor.Create(TabControl.ActiveTab);
  TLib.LoadFrame(TFrame(frameCadastroFornecedor), TabControl.ActiveTab);
  frameCadastroFornecedor.Inicializar;
end;

function TfrmMain.CreateTabItem(xOwner: TTabControl; xText, xStyle: String): TTabItem;
var
  LTabItem: TTabItem;
  LBitmap: TBitmap;
begin
  LTabItem := LocateTabItem(xText);
  if LTabItem <> nil then
  begin
    TabControl.ActiveTab := LTabItem;
    Abort;
  end;

  Result := TTabItem.Create(xOwner);
  Result.Parent := xOwner;
  Result.WordWrap := False;
  Result.AutoSize := False;
  Result.Height := 35;
  Result.Width := 150;
  Result.IsSelected := True;
  Result.Text := Trim(xText);
  Result.StyleLookup := 'TabItemMainMenuStyle';
  Result.Tag := xOwner.TabIndex;
  LBitmap := TBitmap.Create;
  try
    LBitmap.LoadFromFile(ExtractFileDir(ParamStr(0)) + '\imagens\' + xStyle + '-icon48x48.png');
    Result.StylesData['icon.Bitmap'] := LBitmap;

    // LStream := TStringStream.Create;
    // try
    // LStream.LoadFromFile(ExtractFileDir(ParamStr(0)) + '\imagens\' + xStyle + '-icon48x48.png');
    // Image1.MultiResBitmap.LoadFromStream(LStream);
    // finally
    // FreeAndNil(LStream);
    // end;
  finally
    FreeAndNil(LBitmap);
  end;
  Result.StylesData['Exit.OnClick'] := TValue.From<TNotifyEvent>(OnCloseTabItem);
  TTabControl(xOwner).ActiveTab := Result;

  PopupBoxTabs.Items.Add(Trim(TTabControl(xOwner).ActiveTab.Text));
end;

function TfrmMain.CreateTabItem(xOwner, Sender: TObject): TTabItem;
begin
  Result := CreateTabItem(TTabControl(xOwner), TButton(Sender).Text, StringReplace(TButton(Sender).Name, 'ButtonMenu', EmptyStr, [rfReplaceAll]));
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  StyleBook.FileName := 'style.style';
  TLib.ConectDB(FDConnection);
  frameLogin := TframeLogin.Create(Self);
  frameLogin.Inicializar;
  TLib.LoadFrame(TFrame(frameLogin), Self);
  frameLogin.EditUsuario.SetFocus;
  // Application.ProcessMessages;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  LButton: TButton;
begin
  // frameLogin := TframeLogin.Create(frmMain);
  // TLib.LoadFrame(frameLogin);
  GDeletandoAba := False;
  ImageBackground.Bitmap.LoadFromFile(ExtractFileDir(ParamStr(0)) + '\imagens\background.png');
  ImageEmpresa.Bitmap.LoadFromFile(ExtractFileDir(ParamStr(0)) + '\imagens\logo_empresa.png');

  LButton := ButtonMenuProduto;
  TLib.CarregarImagemButtonMenu(LButton);

  LButton := ButtonMenuFornecedor;
  TLib.CarregarImagemButtonMenu(LButton);

  LButton := ButtonMenuManutencaoSistema;
  TLib.CarregarImagemButtonMenu(LButton);

  LButton := ButtonMenuAjuda;
  TLib.CarregarImagemButtonMenu(LButton);

  PanelExpandClick(Sender);
end;

function TfrmMain.LoadStreamPicture(xFileName: String): TBitmap;
var
  LStream: TMemoryStream;
  LBitmap: TBitmap;
begin
  LStream := TMemoryStream.Create;
  LBitmap := TBitmap.Create;
  try
    LStream.LoadFromFile(ExtractFileDir(ParamStr(0)) + '\images\' + xFileName);
    LBitmap.LoadFromStream(LStream);
    Result := LBitmap;
  finally
    FreeAndNil(LStream);
    FreeAndNil(LBitmap);
  end;
end;

function TfrmMain.LocateTabItem(xTabItem: String): TTabItem;
var
  LCount: Integer;
begin
  Result := nil;
  for LCount := 0 to TabControl.ComponentCount - 1 do
  begin
    if TabControl.Components[LCount] is TTabItem then
    begin
      if TTabItem(TabControl.Components[LCount]).Text = xTabItem then
      begin
        Result := TTabItem(TabControl.Components[LCount]);
        Break;
      end;
    end;
  end;
end;

procedure TfrmMain.OnCloseTabItem(Sender: TObject);
var
  LTabItem: TTabItem;
  LTabIndex: Integer;
begin
  GDeletandoAba := True;
  LTabItem := TabControl.ActiveTab;
  if LTabItem <> nil then
  begin
    // try
    PopupBoxTabs.Items.Delete(PopupBoxTabs.Items.IndexOf(LTabItem.Text));
    // except
    // end;
    LTabIndex := TabControl.TabIndex;
    if TabControl.TabIndex <> 0 then
    begin
      TabControl.TabIndex := TabControl.TabIndex - 1;
    end;

    FreeAndNil(LTabItem);

    if (LTabIndex = 0) and (TabControl.TabCount >= 1) then
    begin
      TabControl.TabIndex := 1;
      Application.ProcessMessages;
      TabControl.TabIndex := 0;
      TabControl.ActiveTab.SetFocus;
    end;
  end
  else
  begin
    // try
    PopupBoxTabs.Items.Delete(PopupBoxTabs.Items.Count - 1);
    // except
    // end;
    TabControl.ActiveTab := TTabItem(TabControl.Components[TabControl.ComponentCount - 1]);
    LTabItem := TabControl.ActiveTab;
    FreeAndNil(LTabItem);
  end;
  GDeletandoAba := False;
end;

procedure TfrmMain.PanelFecharSistemaClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.PanelMinimizarSistemaClick(Sender: TObject);
begin
  frmMain.WindowState := TWindowState.wsMinimized;
end;

procedure TfrmMain.PanelMaximizarSistemaClick(Sender: TObject);
begin
  if frmMain.WindowState = TWindowState.wsMaximized then
    frmMain.WindowState := TWindowState.wsNormal
  else
    frmMain.WindowState := TWindowState.wsMaximized;
end;

procedure TfrmMain.PanelExpandClick(Sender: TObject);
begin
  if not PanelButton.Visible then
  begin
    PanelButton.Visible := True;
    LayoutButtons.Width := 180;
  end
  else
  begin
    PanelButton.Visible := False;
    LayoutButtons.Width := PanelExpand.Width;
  end;
end;

procedure TfrmMain.PanelTopDblClick(Sender: TObject);
begin
  PanelMaximizarSistemaClick(Sender);
end;

procedure TfrmMain.PopupBoxTabsChange(Sender: TObject);
var
  LTabItem: TTabItem;
begin
  if not GDeletandoAba then
  begin
    LTabItem := LocateTabItem(PopupBoxTabs.Items.Strings[PopupBoxTabs.ItemIndex]);
    TabControl.ActiveTab := LTabItem;
    TabControl.ActiveTab.SetFocus;
  end;
end;

procedure TfrmMain.TimerBackGroundTimer(Sender: TObject);
begin
  if TabControl.TabCount > 0 then
  begin
    ImageBackground.Visible := False;
    TabControl.Visible := True;
  end
  else
  begin
    ImageBackground.Visible := True;
    TabControl.Visible := False;
  end;
  PopupBoxTabs.Visible := TabControl.Visible;
end;

end.
