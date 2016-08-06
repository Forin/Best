unit bst_pac1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  STD_PREL, QuickRpt, ExtCtrls,  StdCtrls, jpeg, cls_utils, bstdb, 
  QrCtrls;

type
  Tfrm_pac1 = class(Tfrm_pvertstd)
    QRBand1: TQRBand;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    ChildBand1: TQRChildBand;
    QRLabel6: TQRLabel;
    pcausa: TQRDBRichText;
    QRDBRichText4: TQRDBRichText;
    QRBand2: TQRBand;
    QRLabel5: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBRichText2: TQRDBRichText;
    QRLabel3: TQRLabel;
    QRDBRichText3: TQRDBRichText;
    QRLabel14: TQRLabel;
    QRDBText2: TQRDBText;
    gtQRDBText1: TQRDBText;
    gtQRLabel1: TQRLabel;
    gtQRDBText2: TQRDBText;
    gtQRLabel2: TQRLabel;
    gtQRDBRichText2: TQRDBRichText;
    gtQRDBText3: TQRDBText;
    gtQRDBText4: TQRDBText;
    QRDBText13: TQRDBText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure ph1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qrpBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    FiAp: Tdados_tab;
    procedure SetiAp(const Value: Tdados_tab);
    { Private declarations }
  public
    { Public declarations }
  published
   property iAp : Tdados_tab read FiAp write SetiAp;
  end;

var
  frm_pac1: Tfrm_pac1;
  pps : Boolean;

implementation

uses bst_treeAtiv, bst_Escaspect, bst_main;

{$R *.DFM}

procedure Tfrm_pac1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  // freeandnil(iAp);
   frm_pac1 := nil;
   action := cafree;
end;

procedure Tfrm_pac1.QRSubDetail1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
 mtab ,mTipo: string;
begin
  inherited;


end;

procedure Tfrm_pac1.FormCreate(Sender: TObject);
begin
  inherited;
  QRLabel6.Caption := defe8;//'Expectativas de ganho'   ;
  QRLabel5.Caption := Mensasp1;//'Causa '  ;
  QRLabel4.Caption := Mensasp2;//'Efeito' ;
  QRLabel3.Caption := defa6;//'A��o Corretiva '  ;
  QRLabel14.Caption :=defp7;// 'Prazo para Conclus�o'  ;
  gtQRLabel1.Caption := def450;//'Respons�vel'  ;
  gtQRLabel2.Caption := def63;//'Atividade'  ;


end;

procedure Tfrm_pac1.ph1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
 iOper : TDiag_dados;
begin
  inherited;

  

end;

procedure Tfrm_pac1.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
  var
 mTipo,mtab : string;
 iOper : TDiag_dados;
begin
  inherited;
 If qrp.DataSet.fieldbyname('IDF_TIPO__ASPECTO').asstring =  def40 then
   QRDBRichText3.BringToFront
  else
   gtQRDBRichText2.BringToFront;
 
end;

procedure Tfrm_pac1.SetiAp(const Value: Tdados_tab);
begin
  FiAp := Value;
end;

procedure Tfrm_pac1.qrpBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
  var
  mtab,mTipo : string;
begin
  inherited;
  
end;

end.