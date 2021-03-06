unit bst_pess;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Stdctrls,CAD_STAND, ComCtrls, Menus, Buttons, ExtCtrls,adodb,db_tier,OOSEG,baseTier,
  Grids, Aligrid,fonctions;
type
  TFRM_pess = class(TCAD_STAND)
     ID_PESSOA                           : Tedit;
     D_DATATU                            : TDateTimePicker;
     DATATU                              : Tedit;
     L_DATATU                            : Tlabel;
     ID_USUARIO                          : Tedit;
     PES_NOME                            : Tedit;
     L_PES_NOME                          : Tlabel;
     PES_SENHA                           : Tedit;
     L_PES_SENHA                         : Tlabel;

       procedure FormCreate (sender : TObject);
     procedure FormClose (Sender: TObject; var Action: TCloseAction);
     procedure FormShow (Sender: TObject);
     procedure DateClose(sender : Tobject);
     procedure lbClick(Sender: TObject);
     procedure sp2click(Sender: TObject);


  private
  
     function  consiste : boolean;
     procedure ooMap;
    function Encripta(pSenha: string): string;


  public

    
  published
   
     property iObj; 
     function  Mostra_Campos : boolean;
     procedure Mostra_Objeto(pNome : string);

  end;

var
  FRM_pess: TFRM_pess;

implementation

{$R *.dfm}



{ Popula os campos do Objeto de neg�cio com os edit da tela} 
procedure TFRM_pess.ooMap;
{In�cio OOMAP}
 begin
   If self.ID_PESSOA.text ='' then
    (iObj as OPessoa).ID_PESSOA  := 0
   else
    (iObj as OPessoa).ID_PESSOA  := StrtoInt(self.ID_PESSOA.text);
   (iObj as OPessoa).DATATU                          := Strtodate(self.DATATU.text);
    If self.ID_USUARIO.text = '' then
      (iObj as OPessoa).ID_USUARIO                       := 0
    else
      (iObj as OPessoa).ID_USUARIO                      := StrtoInt(self.ID_USUARIO.text);
   (iObj as OPessoa).PES_NOME                        := self.PES_NOME.text;
   (iObj as OPessoa).PES_SENHA                       := encripta(self.PES_SENHA.text);
   (iObj as OPESSOA).ID_USUARIO := Key_master;

   (iObj as OPessoa).ddmap;
 end;
{Fim OOMAP}

procedure TFRM_pess.FormCreate(Sender: TObject);
var
 wdir,wfile,P1,P2: string;
 wbd : TstringList;
  begin
   inherited;

   iObj := OPessoa.create;

 end;


  
procedure TFRM_pess.FormClose(Sender: TObject; var Action: TCloseAction);
  begin;
   Inherited;
  FRM_pess := nil;
   action := cafree;
 end;

  
procedure TFRM_pess.FormShow(Sender: TObject);
  begin
   Inherited;
   If lb.Count > 0 then
     begin
       lb.ItemIndex := 0;
       lbClick(nil);
       ActiveControl := lb;
     end;
 end;

   
procedure TFRM_pess.sp2click(Sender: TObject);
  Begin  
   If not Consiste then
     raise exception.create('Inclus�o n�o efetuada!');
   oomap;
   inherited;
   If Status = 'I' then
      begin
        If iObj.ID > 0 then //gravou novo 
        begin 
          (iObj as OPessoa).GetProperties; 
          iObj.PK.PK1  := iObj.ID;
          lb.ItemIndex := lb.Items.AddObject(Inttostr((iObJ as OPessoa).ID_PESSOA),iObj.PK);
          Mostra_objeto(iObj.Getitem(lb)); 
        end;
      end;
 end;
  

   
{ Consiste Obrigatoriedade dos Campos antes da Inclus�o ou Atualiza��o} 
function TFRM_pess.Consiste : boolean;
 begin
   inherited;
   result := true;
    If self.DATATU.text ='' then 
         raise exception.create('Informar o campo Dt. Atualiza��o');
    
    If self.PES_NOME.text ='' then 
         raise exception.create('Informar o campo Pessoa');
    If self.PES_SENHA.text ='' then 
         raise exception.create('Informar o campo Senha');
    
 end;


{ Popula os campos Edit com os atributos da TABELA} 
function TFRM_pess.Mostra_Campos : boolean;
 begin
   (iObj as OPessoa).GetProperties;
   self.ID_PESSOA.text                := InttoStr((iObj as OPessoa).ID_PESSOA);
   self.DATATU.text                   := DatetoStr((iObj as OPessoa).DATATU);
   self.ID_USUARIO.text               := InttoStr((iObj as OPessoa).ID_USUARIO);
   self.PES_NOME.text                 := (iObj as OPessoa).PES_NOME;
   self.PES_SENHA.text                := Encripta((iObj as OPessoa).PES_SENHA);
 end;
  
{ Popula os campos Edit com os atributos da tabela} 
procedure TFRM_pess.Mostra_Objeto(pNome : string);
 begin
   iObj.Load(pNome);
   Mostra_Campos;
   spb_del.Enabled := true;
   sp_Insert.Enabled := true;
 end;
  
{ Cria o click do ListBox} 
procedure TFRM_pess.lbClick(Sender: TObject);
 begin
   Inherited;
   Mostra_objeto(iObj.Getitem(lb));
 end;
  
  
procedure TFRM_pess.DateClose(sender : TObject);
  begin;
   inherited;
   If uppercase(TDatetimePicker(sender as Tobject).name) = 'D_DATATU' then 
    begin
          DATATU.text := DateToStr(TDatetimePicker(sender as Tobject).date);
          exit;
    end;
  end; 


    
{Evento do Elimina}
function TFRM_pess.Encripta(pSenha : string) : string;
var
i : integer;
a1,a2 : integer;

begin
   result := '';
   for i := 1 to length(pSenha) do
     Begin
       a1 := 255 - ord(pSenha[i]);
       result  :=  result + chr(a1);
     end;

end;





end.
