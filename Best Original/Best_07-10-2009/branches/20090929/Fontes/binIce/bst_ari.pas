unit bst_ari;

interface

uses
  Windows, bst_basefrm,Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, StdCtrls, cls_bd, Buttons,bst_main,bstdb, gtQrCtrls,bst_dm_rel,
  ImgList, ComCtrls, ToolWin;

type
  TFRM_ARI = class(TBaseFRm)
    Memo1: TMemo;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ImageList1: TImageList;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
     
    procedure FormCreate(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Loadconstantobj;override;

  end;

var
  FRM_ARI: TFRM_ARI;

implementation



{$R *.DFM}

procedure TFRM_ARI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If oAcesso.WACCESS = 2 then       //permite aatualiza��o
     memo1.Lines.SaveToFile(bdx.DirFluxo+'areas.txt');
  frm_ari := nil;
  action := cafree;
 end;

procedure TFRM_ARI.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TFRM_ARI.FormCreate(Sender: TObject);
begin
inherited;
 If (frm_main.viewer) or (oAcesso.WACCESS = 2) then
    memo1.ReadOnly := true;
 Begin
  If fileExists(bdx.DirFluxo+'areas.txt') then
     memo1.Lines.LoadFromFile(bdx.dirFluxo +'areas.txt' )
  else
     memo1.clear;   
 end;
end;

procedure TFRM_ARI.Loadconstantobj;
var
i : integer;

begin
  Caption :=  def3211;//'Areas de Interesse/Market'  ;
  //SpeedButton1.Caption := def901;//'Sair/Quit ';

end;

procedure TFRM_ARI.ToolButton1Click(Sender: TObject);
begin
  inherited;
  close;
end;

end.

