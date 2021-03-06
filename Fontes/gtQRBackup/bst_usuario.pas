unit bst_usuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
Dialogs,Stdctrls,CAD_STAND, ComCtrls, Menus, Buttons, ExtCtrls,adodb,db_tier,BST_PERS,OOSEG,baseTier,
  Grids, Aligrid,cls_obj,bstdb, ActnList, ImgList, ToolWin;


type
  TFRM_usuario = class(TCAD_STAND)


       ID_USUARIO                          : Tedit;
     D_DATATU                            : TDateTimePicker;
     DATATU                              : Tedit;
     L_DATATU                            : Tlabel;
     US_NOME                             : Tedit;
     L_US_NOME                           : Tlabel;
    IncAllBtn: TSpeedButton;
    ExAllBtn: TSpeedButton;
    CLI_ID: TEdit;
    PRJ_ID: TEdit;
    gb_cliente: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    CMB_CLI: TComboBox;
    CMB_PROJ: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    GPB_PRIV: TGroupBox;
    SpeedButton1: TSpeedButton;
    spm1: TSpeedButton;
    gpb: TGroupBox;
    Panel4: TPanel;
    lb_uc: TListBox;
    rg1: TRadioGroup;
    GB_PRIV: TGroupBox;
    Panel2: TPanel;
    lb_priv: TListBox;
    ExcludeBtn: TSpeedButton;
    IncludeBtn: TSpeedButton;
    gpb_diagrama: TGroupBox;
    Edit3: TEdit;
    SpeedButton2: TSpeedButton;
    rdg: TRadioGroup;
    RDG_ACESSO: TRadioGroup;
    RDG_NIVEL: TRadioGroup;
    Label3: TLabel;
    Label4: TLabel;
    rdg11: TRadioGroup;

       procedure FormCreate (sender : TObject);
     procedure FormClose (Sender: TObject; var Action: TCloseAction);
     procedure FormShow (Sender: TObject);
     procedure DateClose(sender : Tobject);
     procedure lbClick(Sender: TObject);
     procedure sp2click(Sender: TObject);
     Procedure Monta_cab ;
     Procedure Mostra_Contatos ;
     Procedure Abre_Det(Sender: TObject);
     Procedure sp_inserDetClick(Sender: TObject);
     Procedure grid_contDblClick(Sender: TObject);
    procedure CMB_CLIClick(Sender: TObject);
    procedure CMB_PROJClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure lb_ucDblClick(Sender: TObject);
    procedure lb_privDblClick(Sender: TObject);
    procedure sp_insertClick(Sender: TObject);
    procedure IncludeBtnClick(Sender: TObject);
    procedure rg1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure spm1Click(Sender: TObject);
    procedure rdgClick(Sender: TObject);


  private
     FoContato: OPessoa;
    Fdiagrama: integer;
    FCLIENTE: integer;
    Fcenario: integer;
    FClasse: string;
    FNOME_DIAGRAMA: string;
     function  consiste : boolean;
     procedure ooMap;




      procedure SetoContato(const Value:OPessoa);
    procedure Mostra_Privilegios;
    procedure Mostra_Diagramas;
    procedure Setcenario(const Value: integer);
    procedure SetCLIENTE(const Value: integer);
    procedure Setdiagrama(const Value: integer);
    procedure SetClasse(const Value: string);
    procedure DelPriv(pCli, pCenario, pDiagrama, pUsu: integer ;pClasse : string);
    procedure SetNOME_DIAGRAMA(const Value: string);



  public


  published
     property iContatos :OPessoa read FoContato write SetoContato;
     property iObj;
     property CLIENTE : integer read FCLIENTE write SetCLIENTE;
     property cenario : integer read Fcenario write Setcenario;
     property diagrama : integer read Fdiagrama write Setdiagrama;
     property Classe : string read FClasse write SetClasse;
     property NOME_DIAGRAMA : string read FNOME_DIAGRAMA write SetNOME_DIAGRAMA;
     function  Mostra_Campos : boolean;
     procedure Mostra_Objeto(pNome : string);
     procedure Mostra_UC;
     procedure LoadCOnstantObj;override;

  end;

{defini��o dos campos a mostrar no grid (master-detail)}
const
cCampos  : array [0..1] of string = ('PES_NOME','DATATU');
cCaption  : array [0..1] of string = ('Usu�rio','Dt. Atualiza��o');
 {fim defini��o dos campos a mostrar no grid (master-detail)}



var
  FRM_usuario: TFRM_usuario;

implementation

uses BST_PRIVILEGIO, bst_treeAtiv, bst_main;

{$R *.dfm}



  
             {Monta Grid - Master/detail}  
procedure TFRM_usuario.Monta_cab;  
 var    
 i : integer;   
   begin;  
    Inherited;  
    grid_cont.ColCount := length(cCaption); 
    for i := 0 to length(ccaption)-1 do  
     begin  
       grid_cont.Objects[i,0] := TProp.create; 
       grid_cont.Cells[i,0]   := cCaption[i];  
       (grid_cont.Objects[i,0] as TProp).nomecampo := cCampos[i];
     end;  
   end;  
 {fim Monta Grid - Master/detail}


  
     {Mostra Contatos - Master/detail}  
procedure TFRM_usuario.Mostra_Contatos;
var
i : integer;
begin
 inherited;
 Limpa_grid(Grid_cont);
 iContatos           :=OPessoa.create;
 iContatos.ListaGrid := Grid_cont;
 iContatos.GetContatos(iObj.getitem(lb)) ;
end;
{fim Mostra COntatos - Master/detail}

procedure TFRM_usuario.Mostra_Privilegios;
var
i : integer;
begin
 inherited;
 lb_Priv.Clear;
 gb_priv.Visible := true;
 with oPrivilegio.create do
   Begin
     lb_priv.items := GetDoUsuario((iObj as oUsuario).ID_USUARIO,strtoint(self.Cli_id.text),
                                    strtoint(self.prj_id.text),rg1.itemIndex+1,frm_main.idioma) ;
     free;

   end;
 iContatos           :=OPessoa.create;
 iContatos.ListaGrid := Grid_cont;
 iContatos.GetContatos(inttostr(key_detail)) ;
end;

       {In�cio click Grid - Master/detail}  
procedure TFRM_usuario.Abre_det;
 var
  wpk : variant;
  i : integer;
  Begin
   Inherited;
   If Frm_pers = nil then
      Frm_pers := TFrm_pers.create(self);
   Frm_pers.grid_cont.visible := false;
   //Frm_pers.sp_print.visible := false;
   Frm_pers.panel1.visible := false;
   Frm_pers.Type_Form := 1;    //simples = detail
   Frm_pers.Key_master := self.Key_Detail;
   If (sender as TObject) is TSpeedButton then
      Frm_pers.sp_insertClick(nil)
   else
      Begin
        If grid_cont.Objects[0,grid_cont.row] <> nil then
           Begin
              wpk := TPK(grid_cont.Objects[0,grid_cont.row]).pk1 ;
              Frm_pers.Key_detail := wpk;
              Frm_pers.Mostra_Objeto(wpk);
           end;
      end;
     Frm_pers.showmodal;   
     Mostra_Contatos;    

  end;     
     {fim click Grid - Master/detail}


  procedure TFRM_usuario.sp_inserDetClick(Sender: TObject);
 Begin
   Abre_det(sp_insertDet);
 end;     

  procedure TFRM_usuario.grid_contDblClick(Sender: TObject);
 Begin
   abre_det(grid_cont);
 end;     

  
procedure TFRM_usuario.SetoContato(const Value:OPessoa);
begin  
  FoContato := Value;  
end; 

{ Popula os campos do Objeto de neg�cio com os edit da tela} 
procedure TFRM_usuario.ooMap;
{In�cio OOMAP}
 begin
   If self.ID_USUARIO.text ='' then
    (iObj as OUsuario).ID_USUARIO  := 0
   else
    (iObj as OUsuario).ID_USUARIO  := StrtoInt(self.ID_USUARIO.text);
   (iObj as OUsuario).DATATU                         := DATE;
   (iObj as OUsuario).US_NOME                        := self.US_NOME.text;
    If self.CLI_ID.text = '' then
      (iObj as OUsuario).CLI_ID                          := 0
    else
      (iObj as OUsuario).CLI_ID                         := StrtoInt(self.CLI_ID.text);
    If self.PRJ_ID.text = '' then
      (iObj as OUsuario).PRJ_ID                          := 0
    else
      (iObj as OUsuario).PRJ_ID                         := StrtoInt(self.PRJ_ID.text);
   (iObj as OUsuario).ddmap;
 end;
{Fim OOMAP}

procedure TFRM_usuario.FormCreate(Sender: TObject);
var
 wdir,wfile,P1,P2: string;
 wbd : TstringList;
  begin
   inherited;
   iObj := OUsuario.create;
   Monta_cab;
   grid_cont.OnDblClick := grid_contDBLClick ;
   sp_insertDet.OnClick := sp_inserDetClick ;
   GetCompanyinCombo(cmb_cli);
   grid_cont.FixedRowFont[0].Color := $00FFFEFD;
   If frm_Treeativ <>nil then
    speedbutton2.Visible := true
   else
     Begin
       rdg_nivel.visible := false;
      speedbutton2.Visible := false;
     end;      
 end;


  
procedure TFRM_usuario.FormClose(Sender: TObject; var Action: TCloseAction);
  begin;
   Inherited;
  FRM_usuario := nil;
   action := cafree;
 end;


procedure TFRM_usuario.FormShow(Sender: TObject);
  begin

   Inherited;
   If frm_TreeATiv = nil then
     Begin
       If CurrEmpresa <> nil then
         Begin
           CLIENTE := CurrEmpresa.cenarios.cli_id;
           CENARIO := CurrEmpresa.cenarios.PRJ_id;
         end;
     end ;

 If lb.Count > 0 then
     begin
         cli_id.text := inttostr(CLIENTE);
         prj_id.Text := inttostr(CENARIO);
         LB_UC.Clear;
         gb_priv.Visible := false;
         Edit3.Text := NOME_DIAGRAMA;
         ActiveControl := lb;
         lb.ItemIndex := 0;
       {  If lb.Items.Count > 0 then
           Begin
             lb.ItemIndex := 0;
             lbClick(nil);
           end;}
     end;
 end;
   
procedure TFRM_usuario.sp2click(Sender: TObject);
  Begin  
   If not Consiste then
     raise exception.create(Mens110);
   oomap;
   inherited;
   If Status = 'I' then
      begin
        If iObj.ID > 0 then //gravou novo 
        begin 
          (iObj as OUsuario).GetProperties; 
          iObj.PK.PK1  := iObj.ID;
          lb.ItemIndex := lb.Items.AddObject((iObJ as OUsuario).US_NOME,iObj.PK);
          Mostra_objeto(iObj.Getitem(lb)); 
        end;
      end
   else
      lb.Items[lb.ItemIndex]  := us_nome.text;   
 end;
  

   
{ Consiste Obrigatoriedade dos Campos antes da Inclus�o ou Atualiza��o} 
function TFRM_usuario.Consiste : boolean;
 begin
   inherited;
   result := true;
    If self.US_NOME.text ='' then 
         raise exception.create(Mens152);
 end;


{ Popula os campos Edit com os atributos da TABELA} 
function TFRM_usuario.Mostra_Campos : boolean;
 begin

   (iObj as OUsuario).GetProperties;
   self.ID_USUARIO.text               := InttoStr((iObj as OUsuario).ID_USUARIO);
   self.DATATU.text                   := DatetoStr((iObj as OUsuario).DATATU);
   self.US_NOME.text                  := (iObj as OUsuario).US_NOME;
 {  self.CLI_ID.text                   := InttoStr((iObj as OUsuario).CLI_ID);
   self.PRJ_ID.text                   := InttoStr((iObj as OUsuario).PRJ_ID); }
   with OCompany.create do
     Begin
       edit1.Text := GetDesc(inttostr(CLIENTE));
       free;
     end;
   with oScenario.create do
     Begin
       cli_id := CLIENTE;
       prj_id := CENARIO;
       ddmap;
       edit2.text := GetDesc(inttostr(CENARIO));
      free;
     end;

 end;
  
{ Popula os campos Edit com os atributos da tabela}
procedure TFRM_usuario.Mostra_Objeto(pNome : string);
 begin
   iObj.Load(pNome);
   Mostra_Campos;
   //spb_del.Enabled := true;
   //sp_Insert.Enabled := true;
 end;

{ Cria o click do ListBox}
procedure TFRM_usuario.lbClick(Sender: TObject);
 begin
  // Inherited;
   If lb.Items.count > 0 then
    Begin
       SPEEDBUTTON1.ENABLED:=true;
       spm1.Enabled        := true;
       gb_cliente.Enabled  := true;
       gpb_priv.Enabled    := true;
       gpb.Enabled         := true;
       sp_insertdet.Enabled:= true;
       grid_cont.Enabled   := true;
       cli_id.text := inttostr(CLIENTE);
       prj_id.Text := inttostr(CENARIO);
       LB_UC.Clear;
       Key_Detail := TPK(lb.Items.Objects[lb.ItemIndex]).PK1;
       gb_priv.Visible := false;
       Mostra_objeto(iObj.Getitem(lb));
       Mostra_Contatos;
       Edit3.Text := NOME_DIAGRAMA;
       speedbutton1click(nil);
    end;

 end;


procedure TFRM_usuario.DateClose(sender : TObject);
  begin;
   inherited;
   If uppercase(TDatetimePicker(sender as Tobject).name) = 'D_DATATU' then
    begin
          DATATU.text := DateToStr(TDatetimePicker(sender as Tobject).date);
          exit;
    end;
  end;


    
{Evento do Elimina}
procedure TFRM_usuario.CMB_CLIClick(Sender: TObject);
begin
  inherited;
  cli_id.Text := TPK(cmb_cli.Items.Objects[cmb_cli.ItemIndex] ).PK1;
  CLIENTE     :=  TPK(cmb_cli.Items.Objects[cmb_cli.ItemIndex] ).PK1;
  self.edit1.text := cmb_cli.Items[cmb_cli.ItemIndex];
  self.Edit2.Text := '';
  with OSCenario.create do
    Begin
      cmb_proj.Items := GetOfCOmpany(strtoint(self.cli_id.text));

      free;
    end;
  cmb_proj.Enabled := true;
end;

procedure TFRM_usuario.CMB_PROJClick(Sender: TObject);
begin
  inherited;
  prj_id.Text := TPK(cmb_proj.Items.Objects[cmb_proj.ItemIndex] ).PK1;
  CENARIO     := TPK(cmb_proj.Items.Objects[cmb_proj.ItemIndex] ).PK1;
  self.edit2.text := cmb_proj.Items[cmb_proj.ItemIndex];
  lb_Priv.Clear;
  Mostra_Privilegios;
 // Mostra_UC;
  rg1Click(nil);
  
end;

procedure TFRM_usuario.Mostra_UC;
begin
 with oUsecase.create do
    Begin
       UC_LING := FRM_MAIN.idioma;
       ddmap;
       self.lb_uc.items := GetAllNOT((iObj as oUsuario).ID_USUARIO,strtoint(Cli_id.text),strtoint(prj_id.text));
       free;
    end;
end;

procedure TFRM_usuario.Mostra_Diagramas;
begin
 with oDiagramas.create do
    Begin

       self.lb_uc.items := GetAllNOT((iObj as oUsuario).ID_USUARIO,strtoint(self.Cli_id.text),strtoint(self.prj_id.text));
       free;
    end;
end;

procedure TFRM_usuario.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  If frm_treeativ = nil then
    Begin
      If id_usuario.Text = '' then
         raise exception.Create('Escolher um Usu�rio');
      gb_priv.Visible := true;
      If (cli_id.Text <> '' ) and (prj_id.Text <> '') then
         Begin
        //  rg1.ItemIndex := 1;
          rg1Click(nil);;
         end;
    end
  else
     Begin
       with oPrivilegio.create do
       Begin
          Begin
             self.CLI_ID.Text :=  inttostr(self.cliente);
             self.PRJ_ID.Text := inttostr(self.cenario);
             If frm_privilegio  = nil  then
               frm_privilegio:= Tfrm_privilegio.create(self);

             frm_privilegio.IDG_ID.text := inttostr(self.diagrama);
             frm_privilegio.ID_USUARIO.text := self.ID_USUARIO.TEXT;
             frm_privilegio.PRV_DESCRICAO.text := NOME_DIAGRAMA;
             frm_privilegio.CLASSE := SELF.Classe;
             frm_privilegio.ID_USECASE.text := '0';
             frm_privilegio.CLI_ID.text :=  inttostr(self.cliente);
             frm_privilegio.PRJ_ID.text :=  inttostr(self.cenario);

             (frm_privilegio.iObj as oPrivilegio).ID_PRIV := CheckPrivilegio(0,self.diagrama,strtoint(self.ID_USUARIO.TEXT),self.cliente,self.cenario,frm_main.idioma);

             If (frm_privilegio.iObj as oPrivilegio).ID_PRIV = -1  then
                frm_privilegio.sp_insertClick(nil);

             frm_privilegio.caption := 'Privil�gios de ' + self.us_nome.text;
             frm_privilegio.showmodal;
          end ;



           // raise exception.create(mens151);
          free;
       end;
     end;      
end;

procedure TFRM_usuario.lb_ucDblClick(Sender: TObject);
var
i : integer;
wtodos : boolean;
begin
  inherited;
  wtodos := false;
  If (self.CLI_ID.text ='') or (self.CLI_ID.text ='0') then
      raise exception.create(Mens84);
  If (self.PRJ_ID.text ='') or (self.PRJ_ID.text ='0') then
       raise exception.create(mens85);
  iF LB_UC.SelCount = 0 then
     raise exception.Create (mens153);
  If lb_uc.SelCount > 1 then
    Begin
      wTodos := true;
      If rdg_acesso.ItemIndex < 0 then
         raise exception.Create (mens154);
      If rdg_nivel.Visible then
        Begin
          If rdg_nivel.ItemIndex >= 0 then
             raise exception.Create (mens155);
        end;
    end;
  
  
  for i := lb_uc.Items.Count -1 downto 0 do
    Begin
      If lb_uc.Selected[i] then
       begin
         If frm_privilegio  = nil  then
            frm_privilegio:= Tfrm_privilegio.create(self);

          frm_privilegio.sp_insertClick(nil);
          If rg1.ItemIndex = 0 then
            frm_privilegio.ID_USECASE.text := inttostr(TPK(lb_uc.Items.Objects[i] ).PK1)
          else
             frm_privilegio.IDG_ID.text := inttostr(TPK(lb_uc.Items.Objects[i] ).PK3);
          frm_privilegio.ID_USUARIO.text    := self.ID_USUARIO.text;
          frm_privilegio.PRV_DESCRICAO.text := lb_uc.Items[i];
          frm_privilegio.NIVEIS_ABAIXO.text := '1';
          frm_privilegio.CLI_ID.text        := self.CLI_ID.text;
          frm_privilegio.PRJ_ID.text        := self.PRJ_ID.text;
          If frm_Treeativ = nil then
           frm_privilegio.rdg_nivel.Visible := false;

          If wTodos then
            Begin
              frm_privilegio.RDG_ACESSO.ItemIndex :=  rdg_acesso.ItemIndex;
              If rdg_nivel.Visible then
              Begin
                 frm_privilegio.rdg_nivel.ItemIndex := rdg_nivel.ItemIndex;
              end;
              frm_privilegio.sp2click(nil);
            end
          else
            frm_privilegio.showmodal ;               
          Mostra_Privilegios;
          lb_uc.Items.Delete(i);
       end;
    end;



end;

procedure TFRM_usuario.lb_privDblClick(Sender: TObject);
begin
  inherited;
  If frm_privilegio  = nil  then
    frm_privilegio:= Tfrm_privilegio.create(self);
   Frm_privilegio.Key_detail := TPK(lb_priv.Items.Objects[lb_priv.ItemIndex]).pk1;
   Frm_privilegio.Mostra_Objeto( TPK(lb_priv.items.Objects[lb_priv.ItemIndex]).pk1);
   frm_privilegio.RDG_NIVEL.Visible := false;
   frm_privilegio.ShowModal;
end;

procedure TFRM_usuario.sp_insertClick(Sender: TObject);
begin
  inherited;
  activecONTROL := us_nome;
end;


procedure TFRM_usuario.IncludeBtnClick(Sender: TObject);
var
i : integer;
begin
  inherited;
 for i := lb_priv.Items.Count - 1 downto 0 do
   Begin
    If lb_priv.Selected[i] then
      Begin
        with Oprivilegio.create do
          Begin
            DelDoUsuario(TPk(lb_Priv.Items.Objects[i]).PK1,rg1.itemindex,frm_main.idioma);
            //lb_Priv.DeleteSelected;
            lb_priv.Items.Delete(i);              
            free;
          end;
      end;

   end;
   rg1Click(nil);

end;

procedure TFRM_usuario.rg1Click(Sender: TObject);
begin
  inherited;
 case rg1.ItemIndex of
   0 :  Begin
          Mostra_uc;
          excludebtn.Visible := true;
          includebtn.Visible := true;
          rdg.ItemIndex := 0;
        end;

   1 :  Begin
          lb_uc.Clear;
          excludebtn.Visible := false;
          includebtn.Visible := false;
        end;

  end;
  Mostra_Privilegios;
end;

procedure TFRM_usuario.Setcenario(const Value: integer);
begin
  Fcenario := Value;
end;

procedure TFRM_usuario.SetCLIENTE(const Value: integer);
begin
  FCLIENTE := Value;
end;

procedure TFRM_usuario.Setdiagrama(const Value: integer);
begin
  Fdiagrama := Value;
end;

procedure TFRM_usuario.SetClasse(const Value: string);
begin
  FClasse := Value;
end;

procedure TFRM_usuario.DelPriv(pCli, pCenario, pDiagrama, pUsu: integer ;pClasse : string);
var
iDiag : TDiag_Dados;
begin
  inherited;
   iDiag := TDIag_dados.create(self);
   with oPrivilegio.Create do
    Begin
      DelDoUsuarioDiag(pUsu,pCli,pCenario,pDiagrama);
      free;
    end;
    
   iDiag.Get_Filhos(pCli,pCenario,pDiagrama,pClasse,'' );
   while not iDiag.eof do
     Begin
        DelPriv(pCli,pCenario,iDiag.fieldbyname('IDG_ID').ASINTEGER,pUsu,pClasse);
        iDiag.next;        
     end;
  iDiag.Free;
end;

procedure TFRM_usuario.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  If MessageDlg(mens156+ us_nome.text +mens157+ NOME_DIAGRAMA+ ' ?' ,mtConfirmation, [mbYes, mbNo], 0) = mrYes then

     DelPriv(self.CLIENTE,self.cenario,self.diagrama,strtoint(frm_usuario.ID_USUARIO.text),self.Classe);
end;

procedure TFRM_usuario.spm1Click(Sender: TObject);
begin
  inherited;
  If MessageDlg(mens158+ us_nome.text + ' ?' ,mtConfirmation, [mbYes, mbNo], 0) = mrYes then
     Begin
        with oPrivilegio.create do
          Begin
            If (self.CLI_ID.text ='') or (self.CLI_ID.text ='0') then
               raise exception.create(mens84);
            If (self.PRJ_ID.text ='') or (self.PRJ_ID.text ='0') then
               raise exception.create(mens85);
             DelAllDoUsuario(strtoint(self.CLI_ID.text),strtoint(self.PRJ_ID.text),
                             strtoint(self.ID_USUARIO.text),frm_main.idioma);
             lb_Priv.Items.Clear;                

             free;
          end;
     end;

end;

procedure TFRM_usuario.SetNOME_DIAGRAMA(const Value: string);
begin
  FNOME_DIAGRAMA := Value;
end;

procedure TFRM_usuario.rdgClick(Sender: TObject);
begin
  inherited;
  If rdg.ItemIndex >0 then
    with oUseCase.create do
      Begin
        UC_LING := FRM_MAIN.idioma;
        ddmap;
        self.lb_uc.Items :=  GetGrupo(rdg11.Items[rdg.ItemIndex-1],strtoint(self.ID_USUARIO.text),
                                      strtoint(self.CLI_ID.text),strtoint(self.PRJ_ID.text)) ;
        free;
      end
   else
     Mostra_uc;
end;

procedure TFRM_usuario.LoadCOnstantObj;
var
i :integer;
begin
  inherited;
  caption := defc2;//classe de pessoas
  l_us_nome.Caption :=     defc2;//usuario
  gb_cliente.Caption :=     def65;//empresa;
  label1.caption     :=    def65 ;//empresa;
  label2.caption     :=    defc16; //cenario;
  gpb_diagrama.Caption :=  defd12    ;//diagrama
 

  speedbutton2.Caption := defE29   ;//eliminar privilegios do diagrama
  speedbutton1.Caption :=  defm9  ;//mostrar privilegios
  spm1.Caption         :=  defE30  ;//liminar todos privilegios
  gpb.Caption          :=    def64   ;//casos de usos
  label3.caption     :=  DefP19   ; //par�metros default;
  rdg_acesso.Caption :=  defa26   ;//acesso
  rdg_acesso.Items[0] := defc12   ;//somente leitura
  rdg_acesso.Items[1] :=  DEFa28  ;//acesso total-
  label4.caption     :=   def64 ; //casos de usos
  gb_Priv.Caption    := DEFP18   ;//privilegios
  sp_insertDet.Caption:= def91;//nova peesoa da classe
  rdg_nivel.Caption   := defn5 ;// Niveis abaixo;
  rdg_nivel.Items[0]  := def935  ;// s
  rdg_nivel.Items[1]  :=  def240 ;// n

   rdg.Items[0]  := deft18      ;
   rdg.Items[1]  := defd1      ;
   rdg.Items[2]  := deft5      ;
   rdg.Items[3]  := frm_main.menu.Items[1].Items[11].Caption      ;
   rdg.Items[4]  :=  deft14     ;
   rdg.Items[5]  := frm_main.menu.Items[3].Caption    ;
   rdg.Items[6]  := defr7       ;
   rdg.Items[7]  := def35      ;
   











   //menu
  //sp_insert.Caption:= Def850;//novo
  //spb_del.Caption  := def84;//delete
  //sp2.caption      := def903;//confirmar;


end;

end.
