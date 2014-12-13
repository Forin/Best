unit BST_pdata;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  STD_PREL, QuickRpt, Qrctrls, ExtCtrls,  jpeg, gtQrCtrls, gtQRXport_WMF,
  gtQRXport_Metafile, gtQRXport_EMF, gtQRXport_BMP, gtQRXport_JPEG,
  gtQRXport_Graphic, gtQRXport_GIF, gtQRXport_Text, gtQRXport_Excel,
  gtQRXport_RTF, gtQRXport_XHTML, gtQRXport_HTML, gtQRXport, gtQRXport_Doc,
  gtQRXport_PDF,bstdb, gtQRXport_Hub;

type
  Tfrm_Pdata = class(Tfrm_pvertstd)
    QRBand1: TQRBand;
    pfreq: TgtQRDBText;
    pvol: TgtQRDBText;
    pmid: TgtQRDBText;
    QRLabel5: TgtQRLabel;
    QRLabel6: TgtQRLabel;
    QRLabel7: TgtQRLabel;
    pver: TgtQRDBText;
    pdataver: TgtQRDBText;
    presp: TgtQRDBText;
    qr_de: TQRSubDetail;
    pdes: TgtQRDBText;
    QRLabel19: TgtQRLabel;
    pNome: TgtQRDBText;
    pdesc: TgtQRDBRichText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qr_deBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    Fide: Tdados_tab;
    Fidado: TDados_tab;
    procedure Setidado(const Value: TDados_tab);
    procedure Setide(const Value: Tdados_tab);
    { Private declarations }
  public
    { Public declarations }
  published
   property idado : TDados_tab read Fidado write Setidado;
   property ide : Tdados_tab read Fide write Setide;
  end;

var
  frm_Pdata: Tfrm_Pdata;
  pps : boolean;
implementation

uses bst_main;



{$R *.DFM}

procedure Tfrm_Pdata.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  frm_pdata := nil;
  action := cafree;
end;

procedure Tfrm_Pdata.qr_deBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  begin
    If pps then
    begin
      qrlabel19.caption :=def26 ;
      pps := false;
    end
  else
    qrlabel19.caption := '';
  end;
end;

procedure Tfrm_Pdata.FormCreate(Sender: TObject);
begin
  inherited;
  pps := true;
  idado :=  TDados_tab.create(self);
  iDe :=  TDados_tab.create(self);


  ////////////
 QRLabel5. Caption := defU1;//'Frequ�ncia/Time unit'  ;
 QRLabel6.Caption  := 'Volume'  ;
 Caption           := defM2;//'M�dia/Media' ;
 QRLabel19.Caption := def26;//'Elementos de dados/Data Elements' ;

end;

procedure Tfrm_Pdata.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  pps := true;
end;

procedure Tfrm_Pdata.Setidado(const Value: TDados_tab);
begin
  Fidado := Value;
end;

procedure Tfrm_Pdata.Setide(const Value: Tdados_tab);
begin
  Fide := Value;
end;

end.
