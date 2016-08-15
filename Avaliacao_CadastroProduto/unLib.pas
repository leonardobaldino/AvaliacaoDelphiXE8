unit unLib;

interface

uses
  System.Classes, FMX.Forms, System.SysUtils, FMX.Dialogs,
  FMX.TabControl, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  FireDAC.Comp.UI, FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Stan.ExprFuncs,
  FMX.Controls, FMX.StdCtrls, FMX.Layouts, FMX.Types, FMX.Objects, FMX.ListBox,
  System.Types, System.UITypes, FMX.Graphics, FMX.Colors, FMX.Pickers, inifiles,
{$IFDEF MSWINDOWS}
  Winapi.Windows, System.Rtti,
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  Posix.Dlfcn, Posix.Fcntl, Posix.SysStat, Posix.SysTime, Posix.SysTypes,
{$ENDIF POSIX}
{$IF defined(POSIX) and not defined(IOS) and not defined(ANDROID)}
  System.Internal.Unwinder,
{$ENDIF POSIX and !IOS}
{$IFDEF MACOS}
  Macapi.Mach, Macapi.CoreServices, Macapi.CoreFoundation,
{$ENDIF MACOS}
  System.SysConst, FMX.ExtCtrls, FMX.ComboEdit, FMX.Edit, FMX.DateTimeCtrls, FMX.Memo,
  ShellAPI;

const
  CHeight4Linhas = 96;
  CHeight3Linhas = 80;
  CHeight2Linhas = 66;
  CHeight1Linha = 50;
  CTamanhoLabelMaxino2Linhas = 60;
  CTamanhoLabelMaxino3LInhas = 120;
  CTamanhoLabelMaxino4LInhas = 180;
  CPositionY = 16;

type
  TMyForms = record
    InstanceClass: TComponentClass;
    Reference: TForm;
    Frame: TFrame;
    ActiveModule: String;
    ActiveTable: String;
    OrderBy: String;
    FieldOrderBy: String;
    ColunmTotal: Integer;
    PrimaryKey: String;
    Detail: Boolean;
    ChildModule: String;
    ListBox: String;
    TabItem: TTabItem;
    CreateTable: String;
  end;

type
  TParameters = record
    FieldName: String;
    Value: String;
  end;

  // Impressão de Prontuarios
type
  TProntuarios = class
  public
    // class function CriaCdsAnexo(xOwner: TComponent): TClientDataSet;
    // class function CriaCdsProntuario(xOwner: TComponent): TClientDataSet;
    // class procedure GeraProntuario(cdsProntuario, cdsAnexo: TClientDataSet; xId: Integer; xAvaliacao, xTitulo1, xTitulo2, xTitulo3, xTitulo4, xDescricao1, xObs: String);
    // class procedure GeraAnexo(cdsAnexo: TClientDataSet);
    class procedure MudarCorLegendaPopupBox(xCor: TAlphaColor; Sender: TObject);
    class procedure CriaItem(var xListBox: TListBox; xText, xID, xIDAgendamento, xIDCriterioAvaliacao, xIDTipoAvaliacao, xObservacaoAvaliacao: String;
      xCriaPopupBox: Boolean; xCriaEdit: Boolean);
    class function TamanhoLabelMaxino4Linhas: Currency;
    class function TamanhoLabelMaxino3Linhas: Currency;
    class function TamanhoLabelMaxino2Linhas: Currency;
    class procedure DoOnChange(Sender: TObject);
    // class procedure CriaItemSetores(ListBox: TListBox; xText: string);
  end;

type
  TPopupBoxColor = class
  public
    class procedure PopupBoxClickCor(Sender: TObject);
    class procedure LocalizarItemAvaliado(LListBoxItem: TListBoxItem; xTipoAvaliacao: String);
    class function LocalizaCor(xCor: String): TAlphaColor;
  end;

type
  TLib = class
  private
  public
    class function ConectDB(SQLConn: TFDConnection): Boolean;
    class function InsertRecord(InstanceClass: TComponentClass; Reference: TForm; ActiveModule: String; ActiveTable: String; OrderBy: String;
      FieldOrderBy: String; ColunmTotal: Integer; PrimaryKey: String; Detail: Boolean; ChildModule: String; ListBox: String; TabItem: TTabItem;
      CreateTable: String): TMyForms;
    class function Select(P_Qry: TFDQuery; P_SQLWhere, P_SQLFields, P_SQLOrderBy: Array of TParameters; P_Table: String): Integer; overload;
    class function Select(xSelect: string; xOwner: TFmxObject): TFDQuery; overload;
    class function Select(xSelect: string): Variant; overload;
    class function DataServidor: TDateTime;
    class function Select(xTabela, xCampoSelect, xCampoOrderBy, xValorWhere: string): Integer; overload;
    class function AddParameters(P_FieldName, P_Value: String): TParameters;
    class function SetSQLFields(P_Reset: Boolean = False): Integer;
    class function SetSQLWhere(P_Reset: Boolean = False): Integer;
    class function SetSQLOrderBy(P_Reset: Boolean = False): Integer;
    class function AddRecord(P_Action, P_ActiveTable: String; P_Param: Array of TParameters; var P_Qry: TFDQuery): Integer;
    class function AutoInc(campo, tabela: string): Integer;
    class function ExecutaSQL(sql: String): Integer;
    // class function FileExists(const FileName: string; FollowLink: Boolean = True): Boolean;
    class procedure ListBoxClear(xListBox: TListBox);
    class procedure SearchListBox(xText, xText2: string; xList: TListBox);
    class function OpenTable(xQry: TFDQuery): Boolean;
    class procedure LoadComboBox(xQry: TFDQuery; xComboBox: TComboBox);
    class procedure LoadFrame(var xFrame: TFrame; xOwner: TFmxObject);
    class procedure CarregarPopupBox(xPopupBox: TPopupBox; xTabela, xCampo: String; xSelect: String = '');
    class procedure CarregarComboEdit(xComboEdit: TComboEdit; xTabela, xCampo: String; xSelect: String = '');
    class procedure CarregarPopupBoxMunucipio(xPopupBox: TPopupBox; xTabela, xCampo1, xCampo2: String);
    class function LocalizarItemPopupBox(xPopupBox: TPopupBox; xSelect: String): Integer;
    class function LocalizarItemComboEdit(xComboEdit: TComboEdit; xSelect: String): Integer;
    class function LocalizarItemID(xSelect: String): Integer; overload;
    class function SalvarFoto(xCaminhoFoto: String; xImagem: TImage): Integer;
    class procedure CarregarFoto(xID: Integer; xImagem: TImage);
    class procedure RemoverFoto(xImagem: TImage);
    class function Procura(xFiltros: TStringlist; xLocal, xFiltroUnico: String): Boolean;
    class procedure CarregarImagemButtonMenu(xButton: TButton);
    class procedure LimparEdit(Frame: TFrame);
    class procedure SelecionarPopupBoxItemBoolean(xCondicao: Boolean; xPopupBox: TPopupBox);
    class function Mascara(edt: String; str: String): string;
    class procedure MascaraData(xEdit: TEdit);
    class procedure CarregarData(xEdit: TEdit; xData: TDate);
    class procedure MascaraCPF(xEdit: TEdit);
    class procedure CarregarCPF(xEdit: TEdit; xCPF: String);
    class procedure MascaraHora(xEdit: TEdit);
    class procedure CarregarHora(xEdit: TEdit; xHora: String);
    class function SomenteNumero(xStr: String): String;
    class function isNumero(xStr: String): Boolean;
    class function VersaoExe: String;
    class function isCPF(CPF: string): Boolean;
    class procedure ValidaCPF(Sender: TObject);
    class function ValidaData(Sender: TObject): Boolean;
    class function ValidaHora(Sender: TObject): Boolean;
    class procedure AppRestart;
    class procedure ImprimirRelatorio(xConsulta, xRelatorio, xTitulo: String);
    class function SalvarAnexo(xCaminhoAnexo: String): String;
    class procedure CarregarAnexo(xID: Integer);
    class function Configuracao(xGrupo, xConfig: String): String;
  end;

type
  TAcesso = class
  const
    admLogin = 'ADMINISTRADOR';
  private
  public
    class function ValidaAcesso(xModulo: String; xTela, xMsg: Boolean): Boolean;
    class function ValidarAdmin(xUser, xSenha: String): Boolean;
    class function admSenha: String;
    class function ValidarUsuario(xUser: String): Boolean;
    class function ValidarSenha(xUser, xSenha: String): Boolean;
  end;

Const
  QtdeModules = 7;
  CCLEARCLICK = 'clear.OnClick';
  CHSCROLLBAR = 'hscrollbar';
  CSEARCHCLICK = 'search.OnClick';
  CLISTCLICK = 'list.OnClick';

var
  G_SQLFields, G_SQLWhere, G_SQLOrderBy: Array of TParameters;

const
  Raiz: String = 'SOFTWARE\Wow6432Node\INFAMAT_SOCIAL';

implementation

uses unMain, Soap.EncdDecd, StrUtils, unConfigurarServidor;

{ TLib }

class function TLib.AddParameters(P_FieldName, P_Value: String): TParameters;
begin
  Result.FieldName := P_FieldName;
  Result.Value := P_Value;
end;

class function TLib.AddRecord(P_Action, P_ActiveTable: String; P_Param: array of TParameters; var P_Qry: TFDQuery): Integer;
var
  i, tam: Integer;
  Qry: TFDQuery;
begin
  Result := -1;
  try
    Qry := TFDQuery.Create(nil);
    // Qry.Connection := frmMain.FDConn;
    tam := Length(P_Param);

    if P_Action = 'Insert' then
    begin
      with Qry do
      begin
        Close;
        with sql do
        begin
          Clear;
          Add('INSERT INTO ' + P_ActiveTable + '(');
          for i := 0 to tam - 1 do
          begin
            if i < tam - 1 then
              Add(P_Param[i].FieldName + ', ')
            else
              Add(P_Param[i].FieldName)
          end;
          Add(') VALUES (');
          for i := 0 to tam - 1 do
          begin
            if i < tam - 1 then
              Add(P_Param[i].Value + ', ')
            else
              Add(P_Param[i].Value)
          end;
          Add(')');
          ShowMessage(Text);
        end; // with SQL do
        ExecSQL;
      end; // with P_Qry do
    end // if P_Action = 'Insert' then
    else

      if P_Action = 'Update' then
    begin

    end; // if P_Action = 'Update' then
  except
    on e: Exception do
    begin
      ShowMessage(e.Message);
      Abort;
    end;
  end;
end;

class procedure TLib.AppRestart;
var
  AppName: PChar;
begin
  AppName := PChar(ExtractFileName(ParamStr(0)));
  Application.Title := 'Infamat';
  ShellExecute(0, 'open', AppName, nil, nil, SW_SHOWNORMAL);
  Application.Terminate;
end;

class function TLib.AutoInc(campo, tabela: string): Integer;
var
  qryAutoInc: TFDQuery;
begin
  qryAutoInc := TFDQuery.Create(nil);
  // qryAutoInc.Connection := frmMain.FDConn;
  qryAutoInc.Close;
  with qryAutoInc.sql do
  begin
    Clear;
    Add('Select Max(' + campo + ')+1 as Cod From ' + tabela);
  end;
  qryAutoInc.Open;
  try
    Result := qryAutoInc.FieldByName('Cod').AsInteger
  except
    Result := 0;
  end;
end;

class function TLib.SalvarAnexo(xCaminhoAnexo: String): String;
var
  LInput: TBytesStream;
  LOutput: TStringStream;
  // LQry: TFDQuery;
begin
  Result := EmptyStr;
  LInput := TBytesStream.Create;
  try
    LInput.LoadFromFile(xCaminhoAnexo);
    LInput.Position := 0;
    LOutput := TStringStream.Create('', TEncoding.ASCII);
    try
      Soap.EncdDecd.EncodeStream(LInput, LOutput);
      // LQry := Select('select sistema.anexo_salvar_arquivo(' + IntToStr(xId) + ',' + QuotedStr(LOutput.DataString) + ')', nil);
      Result := LOutput.DataString;
    finally
      FreeAndNil(LOutput);
      // FreeAndNil(LQry);
    end;
  finally
    FreeAndNil(LInput);
  end;
end;

class function TLib.SalvarFoto(xCaminhoFoto: String; xImagem: TImage): Integer;
var
  LInput: TBytesStream;
  LOutput: TStringStream;
  LQry: TFDQuery;
begin
  Result := -1;
  xImagem.Bitmap.CreateFromFile(xCaminhoFoto);
  LQry := TFDQuery.Create(nil);
  LInput := TBytesStream.Create;
  try
    LQry.Connection := frmMain.FDConnection;
    LQry.Close;
    xImagem.Bitmap.SaveToStream(LInput);
    LInput.Position := 0;
    LOutput := TStringStream.Create('', TEncoding.ASCII);
    try
      Soap.EncdDecd.EncodeStream(LInput, LOutput);
      LQry.Open('select sistema.imagem_insert(' + QuotedStr(LOutput.DataString) + ',' + IntToStr(frmMain.GUsuarioID) + ')');
      Result := LQry.Fields[0].AsInteger;
    finally
      FreeAndNil(LOutput);
      FreeAndNil(LQry);
    end;
  finally
    FreeAndNil(LInput);
  end;
end;

class procedure TLib.CarregarAnexo(xID: Integer);
var
  LOutput: TBytesStream;
  LInput: TStringStream;
  LQry: TFDQuery;
  LArquivo: String;
begin
  LQry := TLib.Select('select arquivo_nome, arquivo from sistema.anexo_view where id = ' + IntToStr(xID), nil);

  LInput := TStringStream.Create(LQry.FieldByName('arquivo').AsString, TEncoding.ASCII);
  try
    LOutput := TBytesStream.Create;
    try
      Soap.EncdDecd.DecodeStream(LInput, LOutput);
      LOutput.Position := 0;
      LArquivo := 'C:\INFAMAT_WIN_V5_SOCIAL\anexos\' + LQry.FieldByName('arquivo_nome').AsString;
      LOutput.SaveToFile(LArquivo);

{$IFDEF MSWINDOWS}
      ShellExecute(0, 'OPEN', PChar(LArquivo), '', '', SW_SHOWNORMAL);
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
      _system(PAnsiChar('open ' + AnsiString(LArquivo)));
{$ENDIF POSIX}
    finally
      FreeAndNil(LOutput);
    end;
  finally
    FreeAndNil(LInput);
    FreeAndNil(LQry);
  end;
end;

class procedure TLib.CarregarComboEdit(xComboEdit: TComboEdit; xTabela, xCampo, xSelect: String);
  function ProcuraItem(xComboEdit: TComboEdit; xValor: String): Boolean;
  var
    LIdx: Integer;
  begin
    Result := False;
    for LIdx := 0 to xComboEdit.Items.Count - 1 do
    begin
      if xValor = xComboEdit.Items.Strings[LIdx] then
      begin
        Result := True;
        Break;
      end;
    end;
  end;

var
  LQry: TFDQuery;
begin
  LQry := TFDQuery.Create(nil);
  try
    LQry.Connection := frmMain.FDConnection;
    LQry.Close;
    if xSelect = EmptyStr then
    begin
      LQry.Open('select id, ' + xCampo + ' from sistema.' + xTabela + '_view order by ' + xCampo);
    end
    else
    begin
      LQry.Open(xSelect);
    end;
    LQry.First;
    xComboEdit.Items.Clear;
    while not LQry.Eof do
    begin
      if not ProcuraItem(xComboEdit, LQry.FieldByName(xCampo).AsString) then
      begin
        xComboEdit.Items.Add(LQry.FieldByName(xCampo).AsString);
      end;
      LQry.Next;
    end;
    if xComboEdit.Items.Count > 0 then
    begin
      xComboEdit.ItemIndex := 0;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

class procedure TLib.CarregarCPF(xEdit: TEdit; xCPF: String);
begin
  if xCPF <> EmptyStr then
  begin
    xEdit.Text := xCPF;
  end
  else
    xEdit.Text := EmptyStr;
end;

class procedure TLib.CarregarData(xEdit: TEdit; xData: TDate);
begin
  if xData <> 0 then
    xEdit.Text := FormatDateTime('dd/mm/yyyy', xData)
  else
    xEdit.Text := EmptyStr;
end;

class procedure TLib.CarregarFoto(xID: Integer; xImagem: TImage);
var
  LOutput: TBytesStream;
  LInput: TStringStream;
  LQry: TFDQuery;
begin
  LQry := TLib.Select('select * from sistema.imagem_view where id = ' + IntToStr(xID), nil);

  LInput := TStringStream.Create(LQry.FieldByName('arquivo').AsString, TEncoding.ASCII);
  try
    LOutput := TBytesStream.Create;
    try
      Soap.EncdDecd.DecodeStream(LInput, LOutput);
      LOutput.Position := 0;
      xImagem.Bitmap.LoadFromStream(LOutput);
    finally
      FreeAndNil(LOutput);
    end;
  finally
    FreeAndNil(LInput);
    FreeAndNil(LQry);
  end;
end;

class procedure TLib.CarregarHora(xEdit: TEdit; xHora: String);
begin
  if xHora <> EmptyStr then
  begin
    xEdit.Text := xHora;
  end
  else
    xEdit.Text := EmptyStr;
end;

class procedure TLib.CarregarImagemButtonMenu(xButton: TButton);
var
  LBitmap: FMX.Graphics.TBitmap;
begin
  LBitmap := FMX.Graphics.TBitmap.Create;
  try
    LBitmap.LoadFromFile(ExtractFileDir(ParamStr(0)) + '\imagens\' + StringReplace(xButton.Name, 'ButtonMenu', EmptyStr, [rfReplaceAll]) +
      '-icon48x48.png');
    xButton.StyleLookup := 'ButtonMenuStyle';
    xButton.StylesData['icon.Bitmap'] := LBitmap;
  finally
    FreeAndNil(LBitmap);
  end;
end;

class procedure TLib.CarregarPopupBox(xPopupBox: TPopupBox; xTabela, xCampo: String; xSelect: String = '');
  function ProcuraItem(xPopupBox: TPopupBox; xValor: String): Boolean;
  var
    LIdx: Integer;
  begin
    Result := False;
    for LIdx := 0 to xPopupBox.Items.Count - 1 do
    begin
      if xValor = xPopupBox.Items.Strings[LIdx] then
      begin
        Result := True;
        Break;
      end;
    end;
  end;

var
  LQry: TFDQuery;
begin
  if xSelect = EmptyStr then
  begin
    LQry := TLib.Select('select id, ' + xCampo + ' from sistema.' + xTabela + '_view order by ' + xCampo, nil);
  end
  else
  begin
    LQry := TLib.Select(xSelect, nil);
  end;

  try
    LQry.First;
    xPopupBox.Items.Clear;
    while not LQry.Eof do
    begin
      if not ProcuraItem(xPopupBox, LQry.FieldByName(xCampo).AsString) then
      begin
        xPopupBox.Items.Add(Trim(LQry.FieldByName(xCampo).AsString));
      end;
      LQry.Next;
    end;

    xPopupBox.ItemIndex := -1;
  finally
    FreeAndNil(LQry);
  end;
end;

class procedure TLib.CarregarPopupBoxMunucipio(xPopupBox: TPopupBox; xTabela, xCampo1, xCampo2: String);
  function ProcuraItem(xPopupBox: TPopupBox; xValor: String): Boolean;
  var
    LIdx: Integer;
  begin
    Result := False;
    for LIdx := 0 to xPopupBox.Items.Count - 1 do
    begin
      if xValor = xPopupBox.Items.Strings[LIdx] then
      begin
        Result := True;
        Break;
      end;
    end;
  end;

var
  LQry: TFDQuery;
begin
  LQry := TFDQuery.Create(nil);
  try
    LQry.Connection := frmMain.FDConnection;
    LQry.Close;
    LQry.Open('select id, ' + xCampo1 + ',' + xCampo2 + ' from sistema.' + xTabela + '_view order by ' + xCampo2 + ',' + xCampo1);
    LQry.First;
    xPopupBox.Items.Clear;
    while not LQry.Eof do
    begin
      if not ProcuraItem(xPopupBox, LQry.FieldByName(xCampo1).AsString + '/' + LQry.FieldByName(xCampo2).AsString) then
      begin
        xPopupBox.Items.Add(LQry.FieldByName(xCampo1).AsString + '/' + LQry.FieldByName(xCampo2).AsString);
      end;
      LQry.Next;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

class function TLib.ConectDB(SQLConn: TFDConnection): Boolean;
begin
  Result := False;
  try
    frmMain.FDPhysPgDriverLink.VendorLib := ExtractFileDir(ParamStr(0)) + '\libpq.dll';
    SQLConn.Connected := False;
    SQLConn.Params.Clear;
    SQLConn.Params.Values['Server'] := Configuracao('Configuracoes', 'DBIP');
    SQLConn.Params.Values['Database'] := Configuracao('Configuracoes', 'DBNAME');
    SQLConn.Params.Values['User_Name'] := 'postgres';
    SQLConn.Params.Values['Password'] := 'Z?:3H3!G_4`n';
    // SQLConn.Params.Values['VendorLib'] := ExtractFileDir(ParamStr(0)) + '\libpq.dll';
    SQLConn.Params.Values['DriverID'] := 'pG';
    SQLConn.Connected := True;
    Result := True;
  except
    on e: Exception do
    begin
      Result := False;
      ShowMessage('Falha na conexão.' + #13 + 'Entrar em contato com o suporte.' + #13 + e.Message);
    end;
  end;
end;

class function TLib.Configuracao(xGrupo, xConfig: String): String;
var
  LConfigFile: TIniFile;
  LStr, LPath: String;
begin
  LPath := ExtractFilePath(ParamStr(0)) + 'sys\config.system';
  LConfigFile := TIniFile.Create(LPath);
  try
    LStr := LConfigFile.ReadString(xGrupo, xConfig, EmptyStr);
    Result := LStr;
  finally
    FreeAndNil(LConfigFile);
  end;
end;

class function TLib.DataServidor: TDateTime;
var
  LQry: TFDQuery;
begin
  LQry := TFDQuery.Create(nil);
  try
    LQry.Connection := frmMain.FDConnection;
    LQry.Close;
    LQry.Open('select now() as datahora');
    Result := LQry.FieldByName('datahora').AsDateTime;
  finally
    FreeAndNil(LQry);
  end;
end;

class function TLib.ExecutaSQL(sql: String): Integer;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  // qry.Connection := frmMain.FDConn;
  Qry.Close;
  Qry.sql.Clear;
  Qry.sql.Add(sql);
  Qry.ExecSQL;
  Result := Qry.RowsAffected;
end;

// class function TLib.FileExists(const FileName: string; FollowLink: Boolean): Boolean;
// {$IFDEF MSWINDOWS}
// function ExistsLockedOrShared(const FileName: string): Boolean;
// var
// FindData: TWin32FindData;
// LHandle: THandle;
// begin
// { Either the file is locked/share_exclusive or we got an access denied }
// LHandle := FindFirstFile(PChar(LowerCase(FileName)), FindData);
// if LHandle <> INVALID_HANDLE_VALUE then
// begin
// Winapi.Windows.FindClose(LHandle);
// Result := FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY = 0;
// end
// else
// Result := False;
// end;
//
// var
// Flags: Cardinal;
// Handle: THandle;
// LastError: Cardinal;
// begin
// Flags := GetFileAttributes(PChar(LowerCase(FileName)));
//
// if Flags <> INVALID_FILE_ATTRIBUTES then
// begin
// if faSymLink and Flags <> 0 then
// begin
// if not FollowLink then
// Exit(True)
// else
// begin
// if faDirectory and Flags <> 0 then
// Exit(False)
// else
// begin
// Handle := CreateFile(PChar(LowerCase(FileName)), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, 0, 0);
// if Handle <> INVALID_HANDLE_VALUE then
// begin
// CloseHandle(Handle);
// Exit(True);
// end;
// LastError := GetLastError;
// Exit(LastError = ERROR_SHARING_VIOLATION);
// end;
// end;
// end;
//
// Exit(faDirectory and Flags = 0);
// end;
//
// LastError := GetLastError;
// Result := (LastError <> ERROR_FILE_NOT_FOUND) and (LastError <> ERROR_PATH_NOT_FOUND) and (LastError <> ERROR_INVALID_NAME) and
// ExistsLockedOrShared(LowerCase(FileName));
// end;
// {$ENDIF MSWINDOWS}
// {$IFDEF POSIX}
//
// var
// StatBuf: _stat;
// M: TMarshaller;
// begin
// if lstat(M.AsAnsi(LowerCase(FileName), CP_UTF8).ToPointer, StatBuf) = 0 then
// begin
// if S_ISLNK(StatBuf.st_mode) then
// begin
// if not FollowLink then
// Exit(True)
// else
// begin
// if stat(M.AsAnsi(LowerCase(FileName), CP_UTF8).ToPointer, StatBuf) = 0 then
// Exit(not S_ISDIR(StatBuf.st_mode));
// Exit(False);
// end;
// end;
//
// Exit(not S_ISDIR(StatBuf.st_mode));
// end;
//
// Result := False;
// end;
// {$ENDIF POSIX}

class procedure TLib.ImprimirRelatorio(xConsulta, xRelatorio, xTitulo: String);
var
  LRelatorioExe: String;
begin
  LRelatorioExe := Configuracao('Configuracoes', 'REPORT_EXE_PATH');
  ShellExecute(0, 'open', PChar(LRelatorioExe + '\InfamatV5_SocialXE5_Relatorios.exe'),
    PChar('-' + xConsulta + ' ' + '-' + xRelatorio + ' ' + '-' + xTitulo), '', SW_SHOWNORMAL);
end;

class function TLib.InsertRecord(InstanceClass: TComponentClass; Reference: TForm; ActiveModule, ActiveTable, OrderBy, FieldOrderBy: String;
  ColunmTotal: Integer; PrimaryKey: String; Detail: Boolean; ChildModule, ListBox: String; TabItem: TTabItem; CreateTable: String): TMyForms;
begin
  Result.InstanceClass := InstanceClass;
  Result.Reference := Reference;
  Result.ActiveModule := ActiveModule;
  Result.ActiveTable := ActiveTable;
  Result.OrderBy := OrderBy;
  Result.FieldOrderBy := FieldOrderBy;
  Result.ColunmTotal := ColunmTotal;
  Result.PrimaryKey := PrimaryKey;
  Result.Detail := Detail;
  Result.ChildModule := ChildModule;
  Result.ListBox := ListBox;
  Result.TabItem := TabItem;
  Result.CreateTable := CreateTable;
end;

class function TLib.isCPF(CPF: string): Boolean;
var
  dig10, dig11: string;
  s, i, r, peso: Integer;
begin
  // length - retorna o tamanho da string do CPF (CPF é um número formado por 11 dígitos)
  if ((CPF = '00000000000') or (CPF = '11111111111') or (CPF = '22222222222') or (CPF = '33333333333') or (CPF = '44444444444') or
    (CPF = '55555555555') or (CPF = '66666666666') or (CPF = '77777777777') or (CPF = '88888888888') or (CPF = '99999999999') or (Length(CPF) <> 11))
  then
  begin
    isCPF := False;
    Exit;
  end;

  // "try" - protege o código para eventuais erros de conversão de tipo através da função "StrToInt"
  try
    { *-- Cálculo do 1o. Digito Verificador --* }
    s := 0;
    peso := 10;
    for i := 1 to 9 do
    begin
      // StrToInt converte o i-ésimo caractere do CPF em um número
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11)) then
      dig10 := '0'
    else
      str(r: 1, dig10); // converte um número no respectivo caractere numérico

    { *-- Cálculo do 2o. Digito Verificador --* }
    s := 0;
    peso := 11;
    for i := 1 to 10 do
    begin
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11)) then
      dig11 := '0'
    else
      str(r: 1, dig11);

    { Verifica se os digitos calculados conferem com os digitos informados. }
    if ((dig10 = CPF[10]) and (dig11 = CPF[11])) then
      isCPF := True
    else
      isCPF := False;
  except
    isCPF := False
  end;
end;

class function TLib.isNumero(xStr: String): Boolean;
begin
  // Result := False;
  try
    StrToInt(xStr);
    Result := True;
  except
    Result := False;
  end;
end;

class procedure TLib.LimparEdit(Frame: TFrame);
var
  LIdx: Integer;
  LComponent: TComponent;
begin
  for LIdx := 0 to Frame.ComponentCount - 1 do
  begin
    LComponent := Frame.Components[LIdx];
    if LComponent is TEdit then
    begin
      TEdit(LComponent).Text := EmptyStr;
    end
    else if LComponent is TDateEdit then
    begin
      TDateEdit(LComponent).Date := TLib.DataServidor;
    end
    else if LComponent is TCheckBox then
    begin
      TCheckBox(LComponent).IsChecked := False;
    end
    else if LComponent is TMemo then
    begin
      TMemo(LComponent).Lines.Clear;
    end
    else if LComponent is TPopupBox then
    begin
      TPopupBox(LComponent).ItemIndex := -1;
    end;
  end;
end;

class procedure TLib.ListBoxClear(xListBox: TListBox);
var
  LItem: TListBoxItem;
  LIdx: Integer;
begin
  while xListBox.Items.Count <> 0 do
  begin
    for LIdx := 0 to xListBox.Items.Count - 1 do
    begin
      LItem := xListBox.ItemByIndex(LIdx);
      LItem.Free;
    end;
  end;
end;

class procedure TLib.LoadComboBox(xQry: TFDQuery; xComboBox: TComboBox);
begin
  xQry.First;
  xComboBox.Items.Clear;
  while not xQry.Eof do
  begin
    xComboBox.Items.Add(xQry.Fields[1].AsString);
    xComboBox.StylesData['id'] := xQry.Fields[0].AsString;
    xQry.Next;
  end;
end;

class procedure TLib.LoadFrame(var xFrame: TFrame; xOwner: TFmxObject);
begin
  xFrame.Parent := xOwner;
  xFrame.Visible := True;
  xFrame.Align := TAlignLayout.Client;
  GStyleBook := TStyleBook.Create(xFrame);
  GStyleBook.Parent := xFrame;
  GStyleBook.FileName := 'style.style';
end;

class function TLib.LocalizarItemComboEdit(xComboEdit: TComboEdit; xSelect: String): Integer;
var
  LCount: Integer;
  LQry: TFDQuery;
begin
  Result := -1;
  LQry := Select(xSelect, nil);
  try
    for LCount := 0 to xComboEdit.Items.Count - 1 do
    begin
      if xComboEdit.Items.Strings[LCount] = LQry.Fields[0].AsString then
      begin
        Result := LCount;
        Break;
      end;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

class function TLib.LocalizarItemID(xSelect: String): Integer;
var
  LQry: TFDQuery;
begin
  // Result := -1;
  LQry := Select(xSelect, nil);
  try
    if LQry.IsEmpty then
      Result := -1
    else
      Result := LQry.FieldByName('id').AsInteger;
  finally
    FreeAndNil(LQry);
  end;
end;

class function TLib.LocalizarItemPopupBox(xPopupBox: TPopupBox; xSelect: String): Integer;
var
  LCount: Integer;
  LQry: TFDQuery;
begin
  Result := -1;
  LQry := Select(xSelect, nil);
  try
    for LCount := 0 to xPopupBox.Items.Count - 1 do
    begin
      if xPopupBox.Items.Strings[LCount] = LQry.Fields[0].AsString then
      begin
        Result := LCount;
        Break;
      end;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

class function TLib.Mascara(edt, str: String): string;
var
  i: Integer;
begin
  for i := 1 to Length(edt) do
  begin
    if (str[i] = '9') and not(AnsiChar(edt[i]) in ['0' .. '9']) and (Length(edt) = Length(str) + 1) then
      delete(edt, i, 1);
    if (str[i] <> '9') and (AnsiChar(edt[i]) in ['0' .. '9']) then
      insert(str[i], edt, i);
  end;
  Result := edt;
end;

class procedure TLib.MascaraCPF(xEdit: TEdit);
var
  LCPF: String;
begin
  LCPF := TLib.SomenteNumero(xEdit.Text);
  if Length(LCPF) <= 11 then
  begin
    xEdit.Text := TLib.Mascara(xEdit.Text, '999.999.999-99');
    xEdit.SelStart := Length(xEdit.Text);
  end;
end;

class procedure TLib.MascaraData(xEdit: TEdit);
begin
  xEdit.Text := TLib.Mascara(xEdit.Text, '99/99/9999');
  xEdit.SelStart := Length(xEdit.Text);
end;

class procedure TLib.MascaraHora(xEdit: TEdit);
var
  LHora: string;
begin
  LHora := Trim(SomenteNumero(xEdit.Text));
  if Length(LHora) in [1, 2, 3, 4] then
  begin
    case Length(LHora) of
      1:
        xEdit.Text := '0' + LHora + '00';
      2:
        xEdit.Text := LHora + '00';
      3:
        xEdit.Text := LHora + '0';
    end;
    xEdit.Text := TLib.Mascara(xEdit.Text, '99:99');
    xEdit.SelStart := Length(xEdit.Text);
  end;
end;

class function TLib.OpenTable(xQry: TFDQuery): Boolean;
begin
  try
    xQry.Close;
    xQry.Open;
    Result := xQry.Active;
  except
    Result := False;
  end;
end;

class function TLib.Procura(xFiltros: TStringlist; xLocal, xFiltroUnico: String): Boolean;
var
  LCount: Integer;
begin
  Result := False;
  if Assigned(xFiltros) then
  begin
    for LCount := 0 to xFiltros.Count - 1 do
    begin
      if AnsiContainsText(Soundex(xLocal), Soundex(xFiltros[LCount])) or AnsiContainsText(xLocal, xFiltros[LCount]) then
      begin
        Result := True;
        Exit;
      end;
    end;
  end
  else
  begin
    if AnsiContainsText(Soundex(xLocal), Soundex(xFiltroUnico)) or AnsiContainsText(xLocal, xFiltroUnico) then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

class procedure TLib.RemoverFoto(xImagem: TImage);
begin
  xImagem.Bitmap.LoadFromFile(ExtractFileDir(ParamStr(0)) + '\imagens\Image-icon128x128.png');
end;

class procedure TLib.SearchListBox(xText, xText2: string; xList: TListBox);
var
  LIdx: Integer;
begin
  if xText = EmptyStr then
  begin
    xList.ItemIndex := 0;
    Exit;
  end;

  for LIdx := 0 to xList.Items.Count - 1 do
  begin
    xList.ItemIndex := LIdx;
    if Pos(AnsiUpperCase(xText), AnsiUpperCase(xList.Selected.StylesData[xText2].AsString)) > 0 then
    begin
      Break;
    end;
  end; // for LIdx := 0 to ListBoxList.Items.Count-1 do
end;

class procedure TLib.SelecionarPopupBoxItemBoolean(xCondicao: Boolean; xPopupBox: TPopupBox);
begin
  if xCondicao then
    xPopupBox.ItemIndex := 1
  else
    xPopupBox.ItemIndex := 0;
end;

class function TLib.Select(xTabela, xCampoSelect, xCampoOrderBy, xValorWhere: string): Integer;
var
  LQry: TFDQuery;
begin
  // Result := -1;
  LQry := TFDQuery.Create(nil);
  try
    LQry.Connection := frmMain.FDConnection;
    LQry.Close;
    LQry.Open('select ' + xCampoSelect + ' from ' + xTabela + ' where ' + xCampoOrderBy + ' = ' + xValorWhere);
    if LQry.IsEmpty then
      Result := -1
    else
      Result := LQry.FieldByName(xCampoSelect).AsInteger;
  finally
    FreeAndNil(LQry);
  end;
end;

class function TLib.Select(xSelect: string): Variant;
var
  LQry: TFDQuery;
begin
  Result := EmptyStr;
  LQry := TFDQuery.Create(nil);
  try
    LQry.Connection := frmMain.FDConnection;
    LQry.Close;
    LQry.Open(xSelect);
    if not LQry.IsEmpty then
    begin
      Result := LQry.Fields[0].AsString;
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

class function TLib.Select(xSelect: string; xOwner: TFmxObject): TFDQuery;
begin
  try
    Result := TFDQuery.Create(nil);
    Result.Connection := frmMain.FDConnection;
    Result.Transaction := frmMain.FDTransaction;
    Result.Open(xSelect);
  except
    on e: Exception do
    begin
      MessageDlg(e.Message, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
      Result := nil;
    end;
  end;
end;

class function TLib.Select(P_Qry: TFDQuery; P_SQLWhere, P_SQLFields, P_SQLOrderBy: array of TParameters; P_Table: String): Integer;
var
  i, tam: Integer;
begin
  Result := -1;
  try
    with P_Qry do
    begin
      Close;
      with sql do
      begin
        Clear;
        Add('Select ');
        tam := Length(P_SQLFields);
        if tam = 0 then
          Add(' * ')
        else
          for i := 0 to tam - 1 do
          begin
            if i < tam - 1 then
              Add(P_SQLFields[i].FieldName + ', ')
            else
              Add(P_SQLFields[i].FieldName);
          end; // for i := 1 to Length(P_SQLWhere) do

        Add('From ' + P_Table + ' ');

        tam := Length(P_SQLWhere);
        if tam > 0 then
        begin
          Add('Where ');
          for i := 0 to tam - 1 do
          begin
            if i < tam - 1 then
              Add(P_SQLWhere[i].FieldName + ' = ' + P_SQLWhere[i].Value + ' and ')
            else
              Add(P_SQLWhere[i].FieldName + ' = ' + P_SQLWhere[i].Value + ' ')
          end;
        end; // if Length(P_SQLWhere) > 0 then

        tam := Length(P_SQLOrderBy);
        if tam > 0 then
        begin
          Add('Order by ');
          for i := 0 to tam - 1 do
          begin
            if i < tam - 1 then
              Add(P_SQLOrderBy[i].FieldName + ', ')
            else
              Add(P_SQLOrderBy[i].FieldName)
          end;
        end; // if Length(P_SQLWhere) > 0 then
      end; // with SQL do
      Open;
    end; // with P_Qry do
  except
    on e: Exception do
    begin
      ShowMessage(e.Message);
      Abort;
    end;
  end;
end;

class function TLib.SetSQLFields(P_Reset: Boolean): Integer;
begin
  if P_Reset then
    SetLength(G_SQLFields, 1)
  else
    SetLength(G_SQLFields, Length(G_SQLFields) + 1);

  Result := Length(G_SQLFields);
end;

class function TLib.SetSQLOrderBy(P_Reset: Boolean): Integer;
begin
  if P_Reset then
    SetLength(G_SQLOrderBy, 1)
  else
    SetLength(G_SQLOrderBy, Length(G_SQLOrderBy) + 1);

  Result := Length(G_SQLOrderBy);
end;

class function TLib.SetSQLWhere(P_Reset: Boolean): Integer;
begin
  if P_Reset then
    SetLength(G_SQLWhere, 1)
  else
    SetLength(G_SQLWhere, Length(G_SQLWhere) + 1);

  Result := Length(G_SQLWhere);
end;

class function TLib.SomenteNumero(xStr: String): String;
begin
  Result := EmptyStr;
  Result := StringReplace(xStr, '.', EmptyStr, [rfReplaceAll]);
  Result := StringReplace(Result, '-', EmptyStr, [rfReplaceAll]);
  Result := StringReplace(Result, ':', EmptyStr, [rfReplaceAll]);
end;

class procedure TLib.ValidaCPF(Sender: TObject);
var
  LCPF: String;
begin
  LCPF := TLib.SomenteNumero(TEdit(Sender).Text);
  inherited;
  if LCPF <> EmptyStr then
  begin
    if not TLib.isCPF(LCPF) then
    begin
      MessageDlg('CPF inválido.', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
      TEdit(Sender).SetFocus;
      Abort;
    end;
  end;
end;

class function TLib.ValidaData(Sender: TObject): Boolean;
begin
  Result := True;
  if Trim(TEdit(Sender).Text) <> EmptyStr then
  begin
    try
      StrToDate(TEdit(Sender).Text);
    except
      MessageDlg('Data inválida.', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
      TEdit(Sender).SetFocus;
      Result := False;
      Abort;
    end;
  end;
end;

class function TLib.ValidaHora(Sender: TObject): Boolean;
begin
  Result := True;
  try
    StrToTime(TEdit(Sender).Text);
  except
    MessageDlg('Hora inválida.', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
    Result := False;
    TEdit(Sender).SetFocus;
    Abort;
  end;
end;

class function TLib.VersaoExe: String;
type
  PFFI = ^vs_FixedFileInfo;
var
  F: PFFI;
  Handle: Dword;
  Len: Longint;
  Data: PChar;
  Buffer: Pointer;
  Tamanho: Dword;
  Parquivo: PChar;
  Arquivo: String;
begin
  Arquivo := ExtractFileName(ParamStr(0));
  Parquivo := StrAlloc(Length(Arquivo) + 1);
  StrPcopy(Parquivo, Arquivo);
  Len := GetFileVersionInfoSize(Parquivo, Handle);
  Result := '';
  if Len > 0 then
  begin
    Data := StrAlloc(Len + 1);
    if GetFileVersionInfo(Parquivo, Handle, Len, Data) then
    begin
      VerQueryValue(Data, '', Buffer, Tamanho);
      F := PFFI(Buffer);
      Result := Format('%d.%d.%d.%d', [HiWord(F^.dwFileVersionMs), LoWord(F^.dwFileVersionMs), HiWord(F^.dwFileVersionLs),
        LoWord(F^.dwFileVersionLs)]);
    end;
    StrDispose(Data);
  end;
  StrDispose(Parquivo);
end;

{ TProntuarios }

class procedure TProntuarios.CriaItem(var xListBox: TListBox; xText, xID, xIDAgendamento, xIDCriterioAvaliacao, xIDTipoAvaliacao,
  xObservacaoAvaliacao: String; xCriaPopupBox, xCriaEdit: Boolean);
var
  LItem: TListBoxItem;
  LPopup: TPopupBox;
  LEdit: TEdit;
  LLayout: TLayout;
  LLabel: TLabel;
  LLegendaCor: TRectangle;
  LQry: TFDQuery;
  LTipoAvaliacao, LCor, LDataHoraAtendimentoFim: String;
  LIdx: Integer;
begin
  { TGroupBox(xListBox.Parent).Width
    xListBox.Width := 500; }

  LDataHoraAtendimentoFim := TLib.Select('SELECT datahora_atendimento_fim FROM sistema.agendamento_view WHERE id = ' + xIDAgendamento);

  LItem := TListBoxItem.Create(nil);
  if (not xCriaEdit) and (not xCriaPopupBox) then
  begin
    LItem.StyleLookup := '';
    // ListBoxItem1LinhaStyle
  end
  else
  begin
    LItem.StyleLookup := 'ListBoxItem2Linhas1Popup1EditStyle';
  end;

  if (xCriaEdit) and (not xCriaPopupBox) then
  begin
    LItem.StylesData['text.margins.left'] := 10;
  end; {
    else
    begin
    LItem.StylesData['text.margins.left'] := 90;
    end; }

  LItem.Parent := xListBox;
  LItem.Text := xText;

  if Length(LItem.Text) > CTamanhoLabelMaxino4LInhas then
  begin
    LItem.Height := CHeight4Linhas;
  end
  else if Length(LItem.Text) > CTamanhoLabelMaxino3LInhas then
  begin
    LItem.Height := CHeight3Linhas;
  end
  else if Length(LItem.Text) > CTamanhoLabelMaxino2Linhas then
  begin
    LItem.Height := CHeight2Linhas;
  end
  else
  begin
    LItem.Height := CHeight1Linha;
  end;

  if xCriaPopupBox then
  begin
    LLabel := TLabel.Create(LItem);
    LLabel.Parent := LItem;
    LLabel.Position.X := 0;
    LLabel.Position.Y := 0;
    LLabel.TextAlign := TTextAlign.taCenter;
    LLabel.Text := 'Avaliação';

    LPopup := TPopupBox.Create(LItem);
    // LPopup.Anchors := [TAnchorKind.akBottom];
    LPopup.Parent := LItem;
    LPopup.OnChange := TPopupBoxColor.PopupBoxClickCor;
    LPopup.Position.X := 5;
    if Length(LItem.Text) > CTamanhoLabelMaxino4LInhas then
    begin
      LPopup.Position.Y := TamanhoLabelMaxino4Linhas;
    end
    else if Length(LItem.Text) > CTamanhoLabelMaxino3LInhas then
    begin
      LPopup.Position.Y := TamanhoLabelMaxino3Linhas;
    end
    else if Length(LItem.Text) > CTamanhoLabelMaxino2Linhas then
    begin
      LPopup.Position.Y := TamanhoLabelMaxino2Linhas;
    end
    else
    begin
      LPopup.Position.Y := CPositionY;
    end;
    LPopup.Items.Clear;

    LQry := TLib.Select('SELECT id, descricao, cor  FROM sistema.prontuariotipoavaliacao_view', nil);
    try
      LQry.First;
      while not LQry.Eof do
      begin
        LPopup.Items.Add(LQry.FieldByName('descricao').AsString);
        if LQry.FieldByName('id').AsInteger = StrToInt(xIDTipoAvaliacao) then
        begin
          LTipoAvaliacao := LQry.FieldByName('descricao').AsString;
        end;
        LQry.Next;
      end;
    finally
      FreeAndNil(LQry);
    end;

    LPopup.ItemIndex := LPopup.Items.IndexOf(LTipoAvaliacao);
    LPopup.Enabled := not(LDataHoraAtendimentoFim <> EmptyStr);
  end; // if xCriaPopupBox then

  if xCriaEdit then
  begin
    LEdit := TEdit.Create(LItem);
    LEdit.Parent := LItem;
    LEdit.StyleLookup := 'EditProntuarioStyle';
    LEdit.StylesData['id'] := xID;
    LEdit.StylesData['id_agendamento'] := xIDAgendamento;
    LEdit.StylesData['id_criterioavaliacao'] := xIDCriterioAvaliacao;
    LEdit.StylesData['id_tipoavalicao'] := xIDTipoAvaliacao;
    LEdit.OnChange := DoOnChange;
    if xObservacaoAvaliacao = '0' then
      LEdit.Text := EmptyStr
    else
      LEdit.Text := xObservacaoAvaliacao;
    LEdit.Tag := 0;
    LEdit.Width := 280;
    if not xCriaPopupBox then
    begin
      if Length(LItem.Text) > CTamanhoLabelMaxino4LInhas then
      begin
        LEdit.Position.Y := TamanhoLabelMaxino4Linhas;
      end
      else if Length(LItem.Text) > CTamanhoLabelMaxino3LInhas then
      begin
        LEdit.Position.Y := TamanhoLabelMaxino3Linhas;
      end
      else if Length(LItem.Text) > CTamanhoLabelMaxino2Linhas then
      begin
        LEdit.Position.Y := TamanhoLabelMaxino2Linhas;
      end
      else
      begin
        LEdit.Position.Y := CPositionY;
      end;
      LEdit.Position.X := 5;
      LEdit.Width := 400;
    end
    else
    begin
      LEdit.Position.Y := LPopup.Position.Y; // 16;
      LEdit.Position.X := LPopup.Width + 11;
    end;
    LEdit.MaxLength := 200;

    LEdit.Enabled := not(LDataHoraAtendimentoFim <> EmptyStr);
    // LEdit.Anchors := [TAnchorKind.akBottom, TAnchorKind.akLeft];
  end; // if xCriaEdit then

  if xCriaPopupBox then
  begin
    LLegendaCor := TRectangle.Create(LItem);
    LLegendaCor.Parent := LItem;
    LLegendaCor.Position.Y := LEdit.Position.Y - 5;
    LLegendaCor.Position.X := LEdit.Position.X + LEdit.Width + 5;
    LLegendaCor.XRadius := 4;
    LLegendaCor.YRadius := 4;
    LLegendaCor.Width := 30;
    LLegendaCor.Height := 30;

    LPopup.OnChange(LPopup);
    // if LTipoAvaliacao <> EmptyStr then
    // begin
    // LCor := TLib.Select('SELECT cor  FROM sistema.prontuariotipoavaliacao_view where descricao = ' +
    // QuotedStr(LPopup.Items.Strings[LPopup.Items.IndexOf(LTipoAvaliacao)]));;
    // end;
    // LLegendaCor.Fill.Color := TPopupBoxColor.LocalizaCor(LCor);
  end; // if xCriaPopupBox then
end;

class procedure TProntuarios.DoOnChange(Sender: TObject);
var
  LStr: String;
begin
  // if TEdit(Sender).StylesData['id'].AsString = '0' then
  // begin
  LStr := TLib.Select('SELECT sistema.agendamentoprontuarioavaliacao_insert(' + TEdit(Sender).StylesData['id'].AsString + ',' + TEdit(Sender)
    .StylesData['id_agendamento'].AsString + ',' + TEdit(Sender).StylesData['id_criterioavaliacao'].AsString + ',' + TEdit(Sender)
    .StylesData['id_tipoavalicao'].AsString + ',' + QuotedStr(TEdit(Sender).Text) + ',' + IntToStr(frmMain.GUsuarioID) + ') as id');
  TEdit(Sender).StylesData['id'] := LStr;
  // end;
end;

class procedure TProntuarios.MudarCorLegendaPopupBox(xCor: TAlphaColor; Sender: TObject);
var
  LCount: Integer;
begin
  for LCount := 0 to TPopupBox(Sender).Parent.ComponentCount - 1 do
  begin
    if TPopupBox(Sender).Parent.Components[LCount] is TRectangle then
    begin
      TRectangle(TPopupBox(Sender).Parent.Components[LCount]).Fill.Color := xCor;
    end;
  end;
end;

class function TProntuarios.TamanhoLabelMaxino2Linhas: Currency;
begin
  Result := (CPositionY * 2);
end;

class function TProntuarios.TamanhoLabelMaxino3Linhas: Currency;
begin
  Result := (CPositionY * 3) - 3;
end;

class function TProntuarios.TamanhoLabelMaxino4Linhas: Currency;
begin
  Result := (CPositionY * 4) - 3;
end;

{ TPopupBoxColor }

class function TPopupBoxColor.LocalizaCor(xCor: String): TAlphaColor;
var
  LColorComboBox: TColorComboBox;
  LIdx: Integer;
begin
  LColorComboBox := TColorComboBox.Create(nil);
  LColorComboBox.DropDownKind := TDropDownKind.Custom;
  LColorComboBox.Color := TAlphaColorRec.Null;
  LColorComboBox.DisableFocusEffect := False;
  LColorComboBox.Size.PlatformDefault := False;

  try
    Result := TAlphaColorRec.Azure;
    for LIdx := 0 to LColorComboBox.Items.Count - 1 do
    begin
      if xCor = LColorComboBox.Items.Strings[LIdx] then
      begin
        LColorComboBox.ItemIndex := LIdx;
        Result := LColorComboBox.Color;
        Break;
      end;
    end;
  finally
    FreeAndNil(LColorComboBox);
  end;
end;

class procedure TPopupBoxColor.LocalizarItemAvaliado(LListBoxItem: TListBoxItem; xTipoAvaliacao: String);
var
  LIdx: Integer;
  LStr: String;
  LIDTipoAvaliacao: String;
begin
  LIDTipoAvaliacao := IntToStr(TLib.Select('SELECT id FROM sistema.prontuariotipoavaliacao_view WHERE descricao = ' + QuotedStr(xTipoAvaliacao)));

  for LIdx := 0 to LListBoxItem.ComponentCount - 1 do
  begin
    if LListBoxItem.Components[LIdx] is TEdit then
    begin
      TEdit(LListBoxItem.Components[LIdx]).StylesData['id_tipoavalicao'] := LIDTipoAvaliacao;

      LStr := TLib.Select('SELECT sistema.agendamentoprontuarioavaliacao_insert(' + TEdit(LListBoxItem.Components[LIdx]).StylesData['id'].AsString +
        ',' + TEdit(LListBoxItem.Components[LIdx]).StylesData['id_agendamento'].AsString + ',' + TEdit(LListBoxItem.Components[LIdx])
        .StylesData['id_criterioavaliacao'].AsString + ',' + TEdit(LListBoxItem.Components[LIdx]).StylesData['id_tipoavalicao'].AsString + ',' +
        QuotedStr(TEdit(LListBoxItem.Components[LIdx]).Text) + ',' + IntToStr(frmMain.GUsuarioID) + ') as id');
      TEdit(LListBoxItem.Components[LIdx]).StylesData['id'] := LStr;
    end;
  end;
end;

class procedure TPopupBoxColor.PopupBoxClickCor(Sender: TObject);
var
  LCor: String;
begin
  if TPopupBox(Sender).ItemIndex <> -1 then
  begin
    LCor := TLib.Select('SELECT cor FROM sistema.prontuariotipoavaliacao_view where descricao = ' +
      QuotedStr(TPopupBox(Sender).Items.Strings[TPopupBox(Sender).ItemIndex]));
  end
  else
  begin
    LCor := EmptyStr;
  end;
  TProntuarios.MudarCorLegendaPopupBox(LocalizaCor(LCor), Sender);

  // case TPopupBox(Sender).ItemIndex of
  // { 1 } 0:
  // TProntuarios.MudarCorLegendaPopupBox(TAlphaColorRec.Black, Sender);
  // { 2 } 1:
  // TProntuarios.MudarCorLegendaPopupBox(TAlphaColorRec.Red, Sender);
  // { 3 } 2:
  // TProntuarios.MudarCorLegendaPopupBox(TAlphaColorRec.Blue, Sender);
  // { 4 } 3:
  // TProntuarios.MudarCorLegendaPopupBox(TAlphaColorRec.Yellow, Sender);
  // { 5 } 4:
  // TProntuarios.MudarCorLegendaPopupBox(TAlphaColorRec.Green, Sender);
  // else
  // TProntuarios.MudarCorLegendaPopupBox(TAlphaColorRec.Azure, Sender);
  // end;

  if TPopupBox(Sender).ItemIndex <> -1 then
  begin
    LocalizarItemAvaliado(TListBoxItem(TPopupBox(Sender).Parent), TPopupBox(Sender).Items.Strings[TPopupBox(Sender).ItemIndex]);
  end;
end;

{ TAcesso }

class function TAcesso.admSenha: String;
var
  senha: String;
  contador, verificador, cont: Integer;
begin
  contador := 0;
  verificador := 0;
  senha := FormatDateTime('yyyymmddhh', now);
  for cont := 1 to 10 do
  begin
    contador := contador + StrToInt(Copy(senha, cont, 1));
    verificador := verificador + (StrToInt(Copy(senha, cont, 1)) * cont * contador);
  end;
  senha := IntToStr(verificador) + IntToStr(contador);
  for cont := 1 to Length(senha) do
  begin
    contador := contador + StrToInt(Copy(senha, cont, 1));
    verificador := verificador + (StrToInt(Copy(senha, cont, 1)) * cont * contador);
  end;
  senha := IntToStr(verificador) + IntToStr(contador);
  for cont := 1 to Length(senha) do
  begin
    contador := contador + StrToInt(Copy(senha, cont, 1));
    verificador := verificador + (StrToInt(Copy(senha, cont, 1)) * cont * contador);
  end;
  senha := IntToStr(verificador) + IntToStr(contador);
  // Result := dm.CriptoAcesso.EncodeString(dm.CriptoAcesso.Key,senha);
  Result := senha;
end;

class function TAcesso.ValidaAcesso(xModulo: String; xTela, xMsg: Boolean): Boolean;
var
  LAchou: Integer;
  LModulo: String;
begin
  if frmMain.GUsuarioNome = TAcesso.admLogin then
  begin
    Result := True;
  end
  else
  begin
    Result := False;
    LModulo := UpperCase(xModulo);

    if xTela then
    begin
      LAchou := TLib.Select('SELECT coalesce(sistema.usuario_valida_acesso(' + IntToStr(frmMain.GUsuarioID) + ',' + QuotedStr(LModulo) +
        ',true),0) as id');
    end
    else
    begin
      LAchou := TLib.Select('SELECT coalesce(sistema.usuario_valida_acesso(' + IntToStr(frmMain.GUsuarioID) + ',' + QuotedStr(LModulo) +
        ',false),0) as id');
    end;

    if LAchou = 0 then
    begin
      Result := False;
      if xMsg then
        MessageDlg('Usuário não possui acesso liberado para acessar o modulo: ' + #13 + xModulo, TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
    end
    else
    begin
      Result := True;
    end;
  end;
end;

class function TAcesso.ValidarSenha(xUser, xSenha: String): Boolean;
var
  LAchou: Integer;
begin
  Result := False;

  LAchou := TLib.Select('select count(id) from sistema.usuario_view where usuario_nome = ' + QuotedStr(xUser) + ' and usuario_senha = ' +
    QuotedStr(xSenha));
  if LAchou = 0 then
  begin
    MessageDlg('Senha invalida.', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
  end
  else
  begin
    Result := True;
  end;
end;

class function TAcesso.ValidarUsuario(xUser: String): Boolean;
var
  LAchou: Integer;
begin
  Result := False;

  if xUser <> TAcesso.admLogin then
  begin
    LAchou := TLib.Select('select count(id) from sistema.usuario_view where usuario_nome = ' + QuotedStr(xUser));
    if LAchou = 0 then
    begin
      MessageDlg('Usuário não encontrado.', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
    end
    else
    begin
      Result := True;
    end;
  end
  else
  begin
    Result := True;
  end;
end;

class function TAcesso.ValidarAdmin(xUser, xSenha: String): Boolean;
var
  LAchou: Integer;
begin
  if xSenha = admSenha then
  begin
    Result := True;
  end
  else
  begin
    Result := False;
    MessageDlg('Senha invalida.', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
  end;
end;

end.
