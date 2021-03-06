unit CAD_STAND;

interface

{Type_form := 0 --> Tela com Listbox principal e datagrid para tela filho
 Type_form := 1 --> Tela sem Listbox principal e sem datagrid para tela filho
 Type_form := 2 --> Tela com Listbox principal e sem datagrid para tela filho }

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ComCtrls, ExtCtrls, Mask, Grids, DBGrids,
  Dialogs, ImgList, ToolWin,Activex, Menus,basetier,aligrid,
  frm_primar;



type
  TCAD_STAND = class(Tprimar)
    Panel3: TPanel;
    sp2: TSpeedButton;
    sp_print: TSpeedButton;
    sp_insert: TSpeedButton;
    spb_del: TSpeedButton;
    spb_close: TSpeedButton;
    PopupMenu1: TPopupMenu;
    Elimina1: TMenuItem;
    LTot: TLabel;
    grid_cont: TStringAlignGrid;
    Panel1: TPanel;
    lb: TListBox;
    sp_insertDet: TSpeedButton;
    procedure sp_insertClick(Sender: TObject);
    procedure sp2Click(Sender: TObject);
    procedure spb_closeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sp_printClick(Sender: TObject);
    procedure spb_delClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure lbClick(Sender: TObject);
   
  private

    Fstatus: string;

    FAcesso: boolean;
    FTitulo: string;
    FCONSULTA: boolean;
    FiObj: TOObject;
    FComLista: boolean;
    FType_Form: integer;
    FKey_master: integer;
    FKey_Detail: integer;
    fcCaption : array[0..15] of string;
    fcCampos  : array[0..15] of string;
    procedure Setstatus(const Value: string);
    procedure fChange(Sender: TObject);
    procedure SetAcesso(const Value: boolean);
    procedure SetTitulo(const Value: string);
    
    procedure SetiObj(const Value: TOObject);
    procedure SetComLista(const Value: boolean);
    procedure SetType_Form(const Value: integer);
    procedure SetKey_Detail(const Value: integer);
    procedure SetKey_master(const Value: integer);
   
    procedure grid_contDblClick(Sender: TObject);
    procedure sp_inserDetClick(Sender: TObject);
    function GetcCampos(Index: integer): string;
    procedure SetcCampos(Index: integer; const Value: string);
    function GetcCaption(Index: integer): string;
    procedure SetcCaption(Index: integer; const Value: string);


  protected
   procedure MontaCabecalho;virtual;
   procedure Monta_cab;virtual;abstract;
   procedure Mostra_Det;virtual;
   procedure Mostra_Contatos;virtual;abstract;
   function Mostra_Cpos : boolean;virtual;
   procedure Map_objects;virtual;
   procedure oomap ;virtual;abstract;
   function Checa : boolean;virtual;
   function  Consiste : boolean;virtual;abstract;

   function Mostra_campos : boolean;virtual;abstract;
   procedure Abre_detalhe(Sender: TObject);virtual;
   procedure Abre_det(Sender: TObject);virtual;abstract;
  public
  //  property cCampos[Index : integer] : string read GetcCampos write SetcCampos;
  //  property cCaption[Index : integer] : string  read GetcCaption write SetcCaption;
    function Limpa_campos: boolean;

  published
    property iObj : TOObject  read FiObj write SetiObj;
    property status : string read Fstatus write Setstatus;
    property Titulo : string read FTitulo write SetTitulo;
    { define se mostra o listbox de todos os objetos}
    property Type_Form : integer read FType_Form write SetType_Form ;
    property Key_master : integer read FKey_master write SetKey_master; //key do master
    property Key_Detail : integer read FKey_Detail write SetKey_Detail; //key do detail
    
    procedure Limpa_grid(pList: TStringAlignGrid);
    procedure Limpa_tela;
    procedure Mostra_Objeto(pKey: integer);
  end;



resourcestring

menscadstd1 = 'N�o foi poss�vel completar a atualiza��o! Verifique os dados!';

{const
cCampos  : array [0..7] of string = ('DESC_LANC','VALOR','DC','DATA_LANCAM','DEDUCAO','ACRESCIMOS','JUROS','NO_CHEQUE');
ccaption : array [0..7] of string = ('Descri��o','Valor','DC','Dt.Pagto','Descto','Acr�scimo','Juros','No. Cheque'); }

var

  s : string;
  wtext : string;
  larg_ant,alt_ant,top_ant,left_ant : integer;

implementation

{$R *.dfm}

procedure TCAD_STAND.sp_insertClick(Sender: TObject);
begin
  inherited;
  sp2.enabled       := true;
  spb_del.enabled   := false;
  sp_insert.enabled := false;
  STATUS            := 'I';
  Limpa_tela;
  Limpa_grid(Grid_cont);
end;

procedure TCAD_STAND.Limpa_tela;
var i : integer;
Begin
  for i := 0 to componentcount -1 do
   Begin
    If Components[i] is Tedit then
     (Components[i] as Tedit).text := '';
   end;
end;

procedure TCAD_STAND.sp2Click(Sender: TObject);
begin
   map_objects;
   If not Checa then
     raise exception.create('Inclus�o n�o efetuada!');
   
   sp_insert.enabled := TRUE;
   spb_del.Enabled   := true;
   iObj.save;
   //  showmessage( iObj.resulta);
  inherited;          
end;

procedure TCAD_STAND.Map_objects;
begin
  oomap;
end;

function TCAD_STAND.Checa : boolean;
begin
  result := Consiste;
end;

procedure TCAD_STAND.MontaCabecalho ;
begin
  Monta_cab;
end;

procedure TCAD_STAND.Setstatus(const Value: string);
begin
  Fstatus := Value;
end;    

procedure TCAD_STAND.spb_closeClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TCAD_STAND.fChange(Sender: TObject);
begin
  sp2.enabled := true;
end;

procedure TCAD_STAND.FormShow(Sender: TObject);
var
i : integer;
 Begin
  If Status <> 'I' then
    status := 'M';

   If Type_form = 1 then   //filho (sem data grid) e sem listbox principal
    Begin
     panel1.Visible := false;
     grid_cont.Visible := false;
     sp_insertdet.Visible := false;
     for i := 0 to ControlCount-1 do
        Controls[i].Left :=  Controls[i].Left - lb.width;
      width := width - lb.width;
      sp2.Left := sp2.Left - lb.width;
     end
   else
     begin
       If Type_form = 0 then   //pai - (filho = 1)com data grid e com listbox principal
         begin
          height               := lb.height + grid_cont.height + 150 ;
           {master/detail}
          grid_cont.DefaultRowHeight := 20;
          grid_cont.OnDblClick := grid_contDBLClick ;
          sp_insertDet.OnClick := sp_inserDetClick ;
          MontaCabecalho;
        end
      else
        If Type_form = 2 then   //normal (sem data grid) e com listbox principal
          Begin
             panel1.Visible       := true;
             grid_cont.Visible    := false;
             sp_insertdet.Visible := false;
          end;
      iObj.GetAll;
      If iObj.lista <> nil then
          begin
           lb.items := iObj.Lista;
           lTot.Caption := 'Total : '+inttostr(lb.Items.count);
           If lb.Count > 0 then
             begin
               lb.ItemIndex := 0;
               lbClick(nil);
               ActiveControl := lb;
             end
           else
             lb.ItemIndex := -1;
             ActiveControl := lb;
          end;
     end; 
 end;


procedure TCAD_STAND.SetAcesso(const Value: boolean);
begin
  FAcesso := Value;
end;

procedure TCAD_STAND.SetTitulo(const Value: string);
begin
  FTitulo := Value;
end;

procedure TCAD_STAND.sp_printClick(Sender: TObject);
begin
  inherited;
 // ListPrt(dbgrid1,caption,'');
end;

procedure TCAD_STAND.spb_delClick(Sender: TObject);
begin
  inherited;
  
  If Type_form in [0,2] then // instancia m�ltipla (com listbox)
   begin
      If lb.itemIndex < 0 then
        raise exception.create('Escolher um �tem da Lista!');
   end;
   If MessageDlg('Confirma a Elimina��o ?',mtConfirmation, [mbYes, mbNo], 0) = mrYes then
        begin
          iObj.Delete;
          If Type_form in [0,2] then // instancia m�ltipla (com listbox)
             lb.Items.Delete(lb.ItemIndex);
       //   showmessage( iObj.resulta);
          Limpa_Campos;
       end
end;

procedure TCAD_STAND.FormClose(Sender: TObject; var Action: TCloseAction);
var
i : integer;
begin
  If Type_form = 0 then
    Begin
      for i := 0 to lb.Items.Count -1 do   // destroi objetos do �tem
         begin
           If  (lb.Items.Objects[i]) <> nil then
           (lb.Items.Objects[i]).Free;
         end;
    end;

end;


{ Cria o click do ListBox} 
procedure TCAD_STAND.lbClick(Sender: TObject);
 begin
   Inherited;
   limpa_campos;
   KEY_DETAIL := strtoint(iObj.Getitem(lb));
   Mostra_objeto(strtoint(iObj.Getitem(lb)));
   If Type_form  = 0 then
      Mostra_Det;
 end;

 procedure TCAD_STAND.Mostra_det;
 begin
   Inherited;
   Mostra_Contatos;
 end;

 procedure TCAD_STAND.Abre_detalhe(Sender: TObject);
 begin
   Inherited;
   Abre_det(Sender);
 end;

{ Popula os campos Edit com os atributos da tabela} 
procedure TCAD_STAND.Mostra_Objeto(pKey : integer);
 begin
   iObj.Load(pKey);
   Mostra_Cpos;
   spb_del.Enabled   := true;
   sp_Insert.Enabled := true;
 end;

function TCAD_STAND.Mostra_Cpos : boolean;
 begin
   Mostra_Campos;
 end;


{ Limpa os Tedits}
function TCAD_STAND.Limpa_campos : boolean;
var
i : integer;
 begin
   inherited;
     for i := 0 to componentCount -1 do
      begin
       If Components[i] is Tedit then
          (Components[i] as Tedit).Text := '';
      end;
 end;

procedure TCAD_STAND.Limpa_grid(pList : TStringAlignGrid);  //somente master
var
i,j,m,n : integer;
begin
  j := pList.FixedCols ;
  i := pList.FixedRows;
  for m := i to pList.RowCount-1 do
   begin
     for n := j to pList.ColCount-1 do
      pList.cells[n,m] := '';
   end;
end;


procedure TCAD_STAND.SetiObj(const Value: TOObject);
begin
  FiObj := Value;
end;

procedure TCAD_STAND.FormCreate(Sender: TObject);
begin
  inherited;
  iObj := TOObject.create;
 
end;

procedure TCAD_STAND.grid_contDblClick(Sender: TObject);
 Begin
   abre_det(grid_cont);
 end;

  procedure TCAD_STAND.sp_inserDetClick(Sender: TObject);
 Begin
   Abre_det(sp_insertDet);
 end;


procedure TCAD_STAND.SetComLista(const Value: boolean);
begin
  FComLista := Value;
end;


procedure TCAD_STAND.SetType_Form(const Value: integer);
begin
  FType_Form := Value;
end;

procedure TCAD_STAND.SetKey_Detail(const Value: integer);
begin
  FKey_Detail := Value;
end;

procedure TCAD_STAND.SetKey_master(const Value: integer);
begin
  FKey_master := Value;
end;

function TCAD_STAND.GetcCampos(Index: integer): string;
begin
  result := fcCampos[index];
end;

procedure TCAD_STAND.SetcCampos(Index: integer; const Value: string);
begin
  fcCampos[index] := value;
end;

function TCAD_STAND.GetcCaption(Index: integer): string;
begin
  result := fcCaption[index];
end;

procedure TCAD_STAND.SetcCaption(Index: integer; const Value: string);
begin
  fcCaption[index] := value;
end;

end.
