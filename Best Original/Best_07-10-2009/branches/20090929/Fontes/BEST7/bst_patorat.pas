
unit bst_patorat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  STD_PREL, Qrctrls, QuickRpt, ExtCtrls,  jpeg,bstdb, gtQrCtrls,
  gtQRXport_WMF, gtQRXport_Metafile, gtQRXport_EMF, gtQRXport_BMP,
  gtQRXport_JPEG, gtQRXport_Graphic, gtQRXport_GIF, gtQRXport_Text,
  gtQRXport_Excel, gtQRXport_RTF, gtQRXport_XHTML, gtQRXport_HTML,
  gtQRXport, gtQRXport_Doc, gtQRXport_PDF, gtQRXport_Hub;

type
  Tfrm_patorat = class(Tfrm_pvertstd)
    db: TQRBand;
    gtQRDBRichText1: TgtQRDBRichText;
    db2: TQRSubDetail;
    QRDBText1: TgtQRDBText;
    QRBand3: TQRBand;
    gtQRLabel2: TgtQRLabel;
    gtQRShape2: TgtQRShape;
    gtQRShape1: TgtQRShape;
    gtQRLabel1: TgtQRLabel;
    ChildBand1: TQRChildBand;
    gtQRLabel3: TgtQRLabel;
    gtQRLabel4: TgtQRLabel;
    ChildBand2: TQRChildBand;
    gtQRLabel5: TgtQRLabel;
    gtQRDBText1: TgtQRDBText;
    ppes: TgtQRMemo;
    gtQRLabel6: TgtQRLabel;
    patorativ: TgtQRLabel;
    gtQRDBText2: TgtQRDBText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qr_atBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure db2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
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
  frm_patorat: Tfrm_patorat;
  
implementation

uses bst_main;

{$R *.DFM}

procedure Tfrm_patorat.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   
   frm_patorat := nil;
   action := caFree;
end;

procedure Tfrm_patorat.qr_atBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);

begin
  inherited;
 // iAp.Connection := bdx;
  {iAp.Get_PaisCorrelatos(qrp.DataSet.fieldbyname('CLI_ID').asinteger,
                         qrp.DataSet.fieldbyname('PRJ_ID').asinteger,
                         'AP',
                         qrp.DataSet.fieldbyname('IDF_CODIGO').asinteger,'CA','IDF_AP'); }
                           


end;

procedure Tfrm_patorat.SetiAp(const Value: Tdados_tab);
begin
  FiAp := Value;
end;

procedure Tfrm_patorat.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  ppes.Lines.Clear;
  with Tdados_tab.Create(self) do
   Begin
     //Get_Correlatos(qrp.dataset.fieldbyname('CLI_ID').asinteger,qrp.dataset.fieldbyname('PRJ_ID').asinteger,'CA',qrp.dataset.fieldbyname('IDF_CODIGO').asinteger,'PS','IDF_PS') ;
     while not eof do
      Begin
        ppes.Lines.Add(fieldbyname('IDF_DESIGNACAO').asstring);
        next;
      end;
      free;
   end;
end;

procedure Tfrm_patorat.db2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  If db2.DataSet.FieldByName('ATOR_CATEGORIA').asstring = 'Respons�vel' then
   pAtorativ.Caption := def45
  else
  If db2.DataSet.FieldByName('ATOR_CATEGORIA').asstring = 'Participante' then
   pAtorativ.Caption := def46
  else
   pAtorativ.Caption := def47  ;
end;

procedure Tfrm_patorat.FormCreate(Sender: TObject);
begin
  inherited;
   ////
 //QRLabel1.Caption    := 'Data Vers�o '  ;
 //QRLabel8.Caption    := 'Respons�vel' ;
 //QRLabel9.Caption    := 'Vers�o'  ;
 //QRLabel2.Caption    := 'Aprova��o'  ;
 gtQRLabel1.Caption  := uppercase(defm8);//'MISS�O' ;
 gtQRLabel2.Caption  := uppercase(dim1);//'PROCESSOS'   ;
 gtQRLabel3.Caption  := def39;//'Descri��o' ;
 gtQRLabel4.Caption  := def450 +'  '+lowercase(defo5)+'  '+def46  ;//'Respons�vel ou Participante' ;
 gtQRLabel5.Caption  := def105;//'Manual de Processos' ;
 GtQRLabel6. Caption := def450;//'Respons�vel '  ;

end;

end.
