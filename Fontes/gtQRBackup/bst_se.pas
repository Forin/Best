unit bst_se;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BST_TELAOBJ, ComCtrls, StdCtrls, Grids, DBGrids, DBCtrls, Mask,
  ImgList, Buttons, ToolWin, ExtCtrls, Menus,db,bstDB, Qrctrls, QuickRpt,cls_utils, gtQrCtrls,
  OleCtrls, ActnList;

type
  Tfrm_se = class(Tfrm_obj)
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    Label4: TLabel;
    DBEdit3: TDBEdit;
    Label3: TLabel;
    spp: TSpeedButton;
    DBRichEdit1: TDBRichEdit;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Memo1: TMemo;
    Label6: TLabel;
    DBEdit1: TDBEdit;
    cmb_aplic: TDBLookupComboBox;
    SpeedButton1: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    //procedure BitBtn1Click(Sender: TObject);
    procedure sppClick(Sender: TObject);
    procedure sp_printClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure sp2Click(Sender: TObject);
   
  private
    FID: INTEGER;
    FSIGLA: STRING;
    FiAplic: TDados_tab;
    procedure SetID(const Value: INTEGER);
    procedure SetSIGLA(const Value: STRING);
    procedure SetiAplic(const Value: TDados_tab);
    { Private declarations }
  public
    { Public declarations }
  published
   property SIGLA : STRING read FSIGLA write SetSIGLA;
   property ID : INTEGER read FID write SetID;
   property iAplic : TDados_tab read FiAplic write SetiAplic;
   procedure LoadCOnstantObj;override;
  end;

var
  frm_se: Tfrm_se;
  Ide : Tdados_tab;
  iCodigo : integer;
implementation

uses bst_Telastd, bst_main, bst_pse, bst_ppessoa, bst_aplic;

{$R *.dfm}

procedure Tfrm_se.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frm_se := nil;
  action := caFree;
end;

{procedure Tfrm_se.BitBtn1Click(Sender: TObject);
begin
  inherited;
  close;
end;}

procedure Tfrm_se.sppClick(Sender: TObject);
begin
  inherited;
   Mostra_Dir(self);
   iDataSource.DataSet.edit;
   //Dbedit3.field.text := arquivo;
    Dbedit3.field.text := fil;
end;

procedure Tfrm_se.sp_printClick(Sender: TObject);
var
i : integer;
iTab : TDados_tab;
begin
  inherited;
   If frm_pse = nil then
      frm_pse := tfrm_pse.create(self);
     try
      //frm_pse.qrp.DataSet := iDataSource.DataSet;

     iTab := Tdados_tab.create(self);
     iTab.Get_PaisCorrelatos(Cliente,cenario,'AP',Id,'SE','IDF_AP','');
     frm_pse.qr_at.dataset := iTab;
     qrDataset(frm_pse.qr_at,iTab);



     with frm_pse do
      begin
         for i := 0 to componentCount -1 do
          begin
           If (Components[i] is Tqrband) or  (Components[i] is TqrChildband) then
              qrdataset(Components[i],idatasource.dataset);
          end;

      //titulo.caption := uppercase (def112);
      //subtitulo.caption := dbedit2.text;
      //qrp.preview;
      CLOSE;
      end;

    finally

    end;
end;

procedure Tfrm_se.FormCreate(Sender: TObject);
begin
  inherited;
  tb_dados.TabVisible := false;
  iAplic := TDados_tab.Create(self);
  iAplic.OpenAll(Cliente,cenario,'IDF_TX','','',0);
   with cmb_aplic do
    Begin
     ListSource := iAplic.DataExt;
     ListField := 'IDF_DESIGNACAO';
     KeyField :=  'IDF_CODIGO';
     datasource := dbedit4.DataSource;
     DataField := 'IDF_COD_APLIC';
    end;
end;

procedure Tfrm_se.SpeedButton1Click(Sender: TObject);
var
existe : boolean;
iTab : Tdados_tab;
begin
  inherited;
   iTab :=  Tdados_tab.create(self);
   If frm_aplic   = nil then
      frm_aplic := tfrm_aplic.Create(self);
      existe := itab.Open_Objeto(Cliente,cenario,dbedit2.DataSource.DataSet.fieldbyname('IDF_COD_APLIC').asinteger ,'IDF_TX') ;

   with frm_aplic do
    begin
      Tipo        := 'TX';
      Visivel     := 'N';
      Mode        := 'M';
      AutoFecha   := false;
      idatasource := iTab.DataExt;
      CLIENTE     := self.Cliente ;
      CENARIO     := self.Cenario ;

      If not existe then
        Begin
          Mode := 'I';
          sp_insertClick(self);
        end;
      showmodal;
    end;
    iAplic.OpenAll(Cliente,cenario,'IDF_TX','','',0);
end;

procedure Tfrm_se.SetID(const Value: INTEGER);
begin
  FID := Value;
end;

procedure Tfrm_se.SetSIGLA(const Value: STRING);
begin
  FSIGLA := Value;
end;

procedure Tfrm_se.SetiAplic(const Value: TDados_tab);
begin
  FiAplic := Value;
end;

procedure Tfrm_se.LoadCOnstantObj;
var
i :integer;
begin

  Caption :=def49;// 'Mecanismo Aplicado'  ;
  tb_geral. Caption := def49;// 'Mecanismo;/Programs'   ;
  Label2.Caption := def10005;//9'Nome/Name'   ;
 // Caption := def321;//'Sistema Aplicativo/Application'   ;
  Label4.Caption := 'Id'    ;
  Label5.Caption := def321;//      aplicativo
  Label3. Caption := def39;//'Descrição/Description'  ;
  spp.Hint := defd3 ;//'Diretórios'         ;
  //SpeedButton1.Caption := def321;//'Aplicativos' ;
  tb_dados.Caption := def62;//'Características/Data' ;
  TabSheet1.Caption :=defi1;// 'Indicadores/Indicators'  ;
  Label1.Caption := defc5;//'Custo Anual' ;
  Label6.Caption := defc5;//'Custo Anual Aplicativo/Yeraly Application Cost '  ;



  
end;

procedure Tfrm_se.sp2Click(Sender: TObject);
begin
  inherited;
  close;
end;

end.
