unit bst_if;
    {MAXKEY inibido em 20/05/05 : verifica rproblema}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BST_TELAOBJ, Menus, ImgList, Mask, DBCtrls, ComCtrls, StdCtrls,
  Grids, DBGrids, Buttons, ToolWin, ExtCtrls,bstdb,CLS_UTILS, Qrctrls, QuickRpt, 
  cls_obj,strutils,fonctions,IDGLOBAL, OleCtrls,db,cls_codigo,bst_Basefrm,adodb,
  ActnList;

type
  Tfrm_if = class(Tfrm_obj)
    Label9: TLabel;
    DBEdit5: TDBEdit;
    Label5: TLabel;
    dbmemo1: TDBRichEdit;
    DBEdit3: TDBEdit;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    Label6: TLabel;
    SpeedButton8: TSpeedButton;
    SpeedButton11: TSpeedButton;
    dbgdom: TDBRadioGroup;
    CMB_TAB: TComboBox;
    DB_TAB: TDBEdit;
    Aberto: TLabel;
    Label1: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    ds1: TDataSource;
    Button1: TSpeedButton;
    Button2: TSpeedButton;
    DBEdit1: TDBEdit;
    cmb_tempo: TDBLookupComboBox;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure sp_printClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure pgcpChange(Sender: TObject);
    procedure DBEdit1Exit(Sender: TObject);
    procedure sListaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbg_dgTitleClick(Column: TColumn);
    procedure dbg_dgKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton5Click(Sender: TObject);

    procedure EliminarElementodeDado1Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure sp2Click(Sender: TObject);
    procedure dbgdomChange(Sender: TObject);
    procedure cmb_tabCloseUp(Sender: TObject);
    procedure GroupBox2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dbg_dgCellClick(Column: TColumn);
    procedure BLERClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure sp_insertClick(Sender: TObject);
    procedure dbg_dg1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbg_dgEnter(Sender: TObject);
    procedure dbg_dgDblClick(Sender: TObject);
  private
    FObjDir: string;
    FObjName: string;
    FObjeto: string;
    Fform_name: string;
    FNOME_UNIT: STRING;
    FNOME_DFM: STRING;
    FLASTARGUM: STRING;
    FTIPO_LASTARGUM: STRING;
    FFIRSTARGUM: STRING;
    FiTabRef: Tdad;
    
    procedure SetObjDir(const Value: string);
    procedure SetObjName(const Value: string);
    procedure SetObjeto(const Value: string);
    procedure Eliminar;
    procedure Setform_name(const Value: string);

    procedure SetNOME_DFM(const Value: STRING);
    procedure SetNOME_UNIT(const Value: STRING);

    
    function Cria_Panel: boolean;
    
    procedure SetLASTARGUM(const Value: STRING);
    procedure SetTIPO_LASTARGUM(const Value: STRING);
    procedure SetFIRSTARGUM(const Value: STRING);
    procedure SetiTabRef(const Value: Tdad);
    


    
    { Private declarations }
  public
    { Public declarations }
  published
   property ObjDir : string read FObjDir write SetObjDir;
   property ObjName : string read FObjName write SetObjName;  // nome da unit contendo as classes
   property Objeto : string read FObjeto write SetObjeto;
   property form_name : string read Fform_name write Setform_name;
   property NOME_UNIT : STRING read FNOME_UNIT write SetNOME_UNIT;
   PROPERTY NOME_DFM : STRING read FNOME_DFM write SetNOME_DFM;
   property LASTARGUM : STRING read FLASTARGUM write SetLASTARGUM; //NOME DO ATRIBUTO QUE � O �LTIMO ARGUMENTO DO PK (VIDE GET_MAXKEY);
   property FIRSTARGUM : STRING read FFIRSTARGUM write SetFIRSTARGUM;
   property TIPO_LASTARGUM : STRING read FTIPO_LASTARGUM write SetTIPO_LASTARGUM; //TIPO DE LASTARGUM;
   property iTabRef : Tdad  read FiTabRef write SetiTabRef;
   procedure Loadconstantobj; override;
  end;

var
  frm_if: Tfrm_if;
  idados : Tdad;
  iTab : Tdados_tab;
  wList,wtext : tstringList;
  iQuery : TADoquery;
  iSource : Tdatasource;
  SortField : string;
  
implementation

uses BST_pdata, BST_pdmig, bst_plf, bst_main, CAD_STD, bst_treeAtiv,
  bst_tabenga, bst_cimp, bst_de, UfrmViewED;

{$R *.dfm}

procedure Tfrm_if.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  freeandnil(idados);
  freeandnil(wtext);
  frm_if := nil;
  action := cafree;
end;

procedure Tfrm_if.FormShow(Sender: TObject);
begin
  inherited;
  Tb_atv.TabVisible := false;
 // tab_obj.TabVisible := true;
  If dbedit5.Text <> '' then
   Begin
      pgcp.ActivePage := Tb_Dados;
      pgcpChange(nil);
      dbEdit5.Enabled := False;
   end;
end;

procedure Tfrm_if.BitBtn1Click(Sender: TObject);
begin
  inherited;
  close;
end;

procedure Tfrm_if.sp_printClick(Sender: TObject);
var
  iTab : Tdados_tab;
  ide : Tdad;
  i : integer;
begin
  inherited;
  If frm_pdmig = nil then
    frm_pdmig := tfrm_pdmig.create(self);

  try
    iDe := Tdad.Create(self);
//    If not ide.get_ObjetobyDesc(CLIENTE,CENARIO,DBedit5.text,SortField) then
      if not ide.get_ObjetoDescricao(CLIENTE,CENARIO) then
       Raise exception.create(mens76);
       with frm_pdmig do
        begin
           for i := 0 to componentCount -1 do
            begin
             If (Components[i] is Tqrband) or  (Components[i] is TqrChildband) or  (Components[i] is TqrSubDetail)
                or  (Components[i] is Tqrgroup)then
                qrdataset(frm_pdmig.Components[i],iDe);
            end;
        end;

       frm_Pdmig.qrp.DataSet := ide;
       frm_Pdmig.titulo.caption  := uppercase(def12);
       frm_Pdmig.qRP.preview ;
       frm_Pdmig.close;
       
  finally
     freeandnil(iDe);
  end;
end;


procedure Tfrm_if.SpeedButton1Click(Sender: TObject);
begin
  inherited;
   dbg_dg.DataSource.DataSet.close;
   dbg_dg.DataSource.DataSet.open;
end;

{procedure Tfrm_if.pgcpChange(Sender: TObject);

begin
  //inherited;
  

  If pgcp.ActivePage = Tb_Dados then
    Begin
         SortField := 'IDF_DESIGNACAO';
         iQuery :=TAdoQuery.create(self);

         iSource := TdataSource.create(self);
         isource.DataSet := iQuery;
         If dbedit5.Text = '' then
            exit;
         with iQuery do
           begin
              try
                connection := bdx;

                sql.text := 'SELECT * FROM IDF_DADOS WHERE '+
                            ' CLI_ID = '+ ''+INTTOSTR(cliente)+''+' AND '+
                            ' PRJ_ID = '+ ''+INTTOSTR(cenario)+''+
                            ' AND IDF_TABELA = '+''''+dbedit5.Text+'''';

                open;

                If eof then   // tabela vazia-> cria a partir das correla��es (compatibiliade)
                 Begin
                   itab := Tdados_tab.Create(self);
                    Begin
                      itab.Get_Correlatos(Cliente,Cenario,TIPO,Id,'DE','IDF_DE') ;
                      while not itab.eof do
                       Begin
                         with Tdad.Create(self) do
                          Begin
                            CLI_ID := Cliente;
                            PRJ_ID := cenario;
                            IDF_CODIGO := itab.fieldbyname('IDF_CODIGO').asinteger;
                            Inclui(Dbedit5.text) ;
                            free;
                          end;
                        iTab.Next;
                       end;
                       freeandnil(itab);
                     iQuery.close;
                     iQuery.open;
                    end;

                 end;

                dbg_dg.DataSource    := isource;
                db_Desc.DataSource   := isource;
                db_Dom.DataSource    := isource;
                db_Tab.DataSource    := isource;
                dbgDom.DataSource    := isource;
                db_Desc.dataField    := 'IDF_DESCRICAO';
                db_Dom.dataField     := 'IDF_DOMINIO';
                db_Tab.dataField     := 'IDF_TABREF';
                dbgDom.dataField     := 'IDF_TIPODOMINIO';
              finally
                dbg_dg.cursor     := crDefault  ;

              end;
           end;
     caption := def22 +' - '+ isource.DataSet.fieldbyname('IDF_DESIGNACAO').asstring;   

    end;      

end;      }

procedure Tfrm_if.pgcpChange(Sender: TObject);

begin
  Mostra_dados;
  {If pgcp.ActivePage = Tb_Dados then
    Begin
         with iDados do
           begin
              try
                CLI_ID := cliente;
                PRJ_ID := Cenario;
                IDF_TABELA := Dbedit5.text;
                If dbedit5.Text = '' then
                 exit;
                //If not Get_dados(dbedit5.Text) then   // tabela vazia-> cria a partir das correla��es (compatibiliade)
                 //Begin
                   itab := Tdados_tab.Create(self);
                    Begin
                      itab.Get_Correlatos(Cliente,Cenario,TIPO,Id,'DE','IDF_DE') ;
                      //while not itab.eof do
                       //Begin
                         with Tdad.Create(self) do
                          Begin
                            //CLI_ID := Cliente;
                            //PRJ_ID := cenario;
                            //IDF_CODIGO := itab.fieldbyname('IDF_CODIGO').asinteger;
                            //Inclui(Dbedit5.text) ;
                            //free;
                            //Get_Correlatos(Cliente,Cenario,TIPO,Id,'DE','IDF_DE');
                            dbg_dg.DataSource    := dataext;
                            db_Desc.DataSource   := dataext;
                            db_Dom.DataSource    := dataext;
                            db_Desc.dataField    := 'IDF_DESCRICAO';
                            db_Dom.dataField     := 'IDF_DOMINIO';
                            //BeforePost           := DePost;
                            //AfterPost            := AftPost;
                            //AfterDelete          := AftDel;
                          end;
                        //iTab.Next;
                       //end;
                       freeandnil(itab);
                       //Get_dados(dbedit5.Text);
                    end;

                 //end;

                //dbg_dg.DataSource    := dataext;
                //db_Desc.DataSource   := dataext;
                //db_Dom.DataSource    := dataext;
                //db_Tab.DataSource    := dataext;
                //dbgDom.DataSource    := dataext;
                //db_Desc.dataField    := 'IDF_DESCRICAO';
                //db_Dom.dataField     := 'IDF_DOMINIO';
                //db_Tab.dataField     := 'IDF_TABREF';
                //dbgDom.dataField     := 'IDF_TIPODOMINIO';
              finally
                dbg_dg.cursor     := crDefault  ;
              end;
           end;
     //caption := def22 +' - '+ idatasource.DataSet.fieldbyname('IDF_DESIGNACAO').asstring;

    end;}

end;  



procedure Tfrm_if.SetObjDir(const Value: string);
begin
  FObjDir := Value;
end;

procedure Tfrm_if.SetObjName(const Value: string);
begin
  FObjName := Value;
end;

procedure Tfrm_if.DBEdit1Exit(Sender: TObject);
begin
  inherited;
 // ObjDir      := ExtractFileDir(dbedit1.Text);
 // ObjName     := ExtractFilename(dbedit1.Text);
  sp2.enabled := true;
end;



procedure Tfrm_if.SetObjeto(const Value: string);
begin
  FObjeto := Value;
end;

procedure Tfrm_if.sListaClick(Sender: TObject);
VAR
WTAbde : string;
oList : TList;
i : integer;
mLista : uListaMult;
begin
 with Tdados_tab.create(self) do
     begin
       ListaCli := Cliente ;
       ListaProj:= Cenario ;
       ListaDim := 'IDF_DE' ;
       ListaDim := 'IDF_DADOS' ;
       ListaTit := def26 ;
       ListaTag := 0 ;
       ListaEdit:= false ;
       ListaTree:= nil;
       ListaId  := 0;
       Listafecha:= true;
       oList := mostra_listaMult;

     If oList.Count = 0 then
        exit;

     for i := 0 to oList.Count -1 do
      begin
       mLista := oList[i];
       with Tdad.create(self) do
       Begin
          CLI_ID := Cliente;
          PRJ_ID := cenario;

          IDF_CODIGO := mLista.cod;
          wtabde := mLista.WBS;
          IncluiObj(wtabde,Dbedit5.text) ;
          idados.fClient.Refresh;
         // Get_dados(dbedit5.Text);

          free;
       end;

      end;
       pgcpChange(self);
     end;
end;

procedure Tfrm_if.FormCreate(Sender: TObject);
Var
Tempo : TDominios;
begin
  inherited;
  wtext :=  TStringList.create;
  idados :=  Tdad.create(self);

  with Tprov.create(self) do   // carrega tipos conforme provider no combo de dados
   Begin
    PROVIDER_NAME :=  bdx.Provider ;
    If not Get_Provider then
     Begin
       If frm_tabenga = nil then
        frm_tabenga := Tfrm_tabenga.create(self);
        
       frm_tabenga.Cria_provider(PROVIDER_NAME,bdx);
       frm_tabenga.CLOSE;
     end;
     get_provider;
     while not eof do
      Begin
       //dbg_dg.Columns[3].PickList.add(fieldbyname('TYPE_NAME').asstring);
       next;
      end;

   end;

   iTabRef := Tdad.create(self);
   iTabRef.Get_Tabelas(Cliente,Cenario,false,'')  ;
   while not iTabref.eof do
     Begin
      cmb_tab.Items.Add(iTabRef.fieldbyname('IDF_TABELA').asstring);
      iTabRef.Next;
     end;
   try
    tempo := Tdominios.create(self);
    tempo.Open_Dominio('TEM',frm_main.Idioma);
    cmb_tempo.ListSource := tempo.DataExt;

   finally
   End;

end;

procedure Tfrm_if.dbg_dgTitleClick(Column: TColumn);
var
i : integer;
begin
  inherited;
  with idados.fClient.IndexDefs do
  begin
    i := IndexOf(column.FieldName);
    If i < 0 then
      add(column.FieldName,column.FieldName,[]);
    idados.fclient.IndexName := column.FieldName;
    idados.fclient.First;
  end;
end;

{procedure Tfrm_if.dbg_dgTitleClick(Column: TColumn);
var
i : integer;
begin
  inherited;
  with iQuery do
  begin
    close;
    SortField := column.FieldName;
     sql.text := 'SELECT * FROM IDF_DADOS WHERE '+
                            ' CLI_ID = '+ ''+INTTOSTR(cliente)+''+' AND '+
                            ' PRJ_ID = '+ ''+INTTOSTR(cenario)+''+
                            ' AND IDF_TABELA = '+''''+dbedit5.Text+''''+
                            ' ORDER BY '+''+column.FieldName+'';
    OPEN;
  end;
end;   }

procedure Tfrm_if.dbg_dgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (shift = ([ssCtrl])) and (key = VK_DELETE) then
     eliminar;

end;

Procedure Tfrm_if.Eliminar ;
 Begin
  If MessageDlg(mens23,mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      raise exception.create(mens25);

    Begin
     with Tdad.create(self) do
      Begin
       If not Del_atrib(Cliente,Cenario,dbedit5.text,idados.fClient.FieldByName('IDF_CODIGO').asinteger) then
        Raise exception.create(mens92);
      end;

    end;
 end;

procedure Tfrm_if.SpeedButton5Click(Sender: TObject) ;
 Begin
   close;
   
 end;







procedure Tfrm_if.Setform_name(const Value: string);
begin
  Fform_name := Value;
end;



procedure Tfrm_if.SetNOME_DFM(const Value: STRING);
begin
  FNOME_DFM := Value;
end;

procedure Tfrm_if.SetNOME_UNIT(const Value: STRING);
begin
  FNOME_UNIT := Value;
end;



function Tfrm_if.Cria_Panel : boolean;
var
i,lin_ini,lin_fim,lin_proc,Lin_end: integer;
ws : string;

 Begin
   Lin_fim := 0;
   Lin_proc := 0;
   Lin_ini := 0;
   wList.loadfromfile(OBJDIR+'\'+NOME_UNIT);

   for i := 0 to  WLIST.count -1 do
    Begin
     ws := trim(wlist[i]);
     If Lin_ini  > 0 then
      Begin
        If pos('object', ws) = 1 then
          Lin_end := i
      end;
    end;
         {  wlist.Insert(Lin_end,' inherited Panel3: TPanel   ');
           wlist.Insert(Lin_end,'   Width = 1028  ');
           wlist.Insert(Lin_end,'   Height = 26  ');
           wlist.Insert(Lin_end,'    Font.Charset = DEFAULT_CHARSET  ');
           wlist.Insert(Lin_end,'   Font.Name = 'MS Sans Serif' ');
           wlist.Insert(Lin_end,'   ParentFont = False   ');
           wlist.Insert(Lin_end,'   inherited sp2: TSpeedButton ');
           wlist.Insert(Lin_end,'     Left = 896  ');
           wlist.Insert(Lin_end,'     Width = 127  ');
           wlist.Insert(Lin_end,'   end      ');
           wlist.Insert(Lin_end,'   inherited sp_print: TSpeedButton   ');
           wlist.Insert(Lin_end,'     Left = 21      ');
           wlist.Insert(Lin_end,'    Visible = False   ');
           wlist.Insert(Lin_end,'   end          ');
           wlist.Insert(Lin_end,'  inherited sp_insert: TSpeedButton  ');
           wlist.Insert(Lin_end,'     Left = 44  ');
           wlist.Insert(Lin_end,'   end        ');
           //wlist.Insert(Lin_end,'   inherited spb_del: TSpeedButton  ');
           wlist.Insert(Lin_end,'     Left = 118      ');
           wlist.Insert(Lin_end,'     Width = 75      ');
           wlist.Insert(Lin_end,'     Caption = 'Eliminar   '  ');
           wlist.Insert(Lin_end,'   end
           wlist.Insert(Lin_end,'   inherited SP_X: TSpeedButton  ');
           wlist.Insert(Lin_end,'     Left = 463           ');
           wlist.Insert(Lin_end,'     Top = 2       ');
           wlist.Insert(Lin_end,'     OnClick = nil   ');
           wlist.Insert(Lin_end,'   end     ');
           wlist.Insert(Lin_end,' 'end '); }


   wList.Savetofile(OBJDIR+'\'+NOME_UNIT);
end;

procedure Tfrm_if.SetLASTARGUM(const Value: STRING);
begin
  FLASTARGUM := Value;
end;

procedure Tfrm_if.SetTIPO_LASTARGUM(const Value: STRING);
begin
  FTIPO_LASTARGUM := Value;
end;





procedure Tfrm_if.SetFIRSTARGUM(const Value: STRING);
begin
  FFIRSTARGUM := Value;
end;




procedure Tfrm_if.EliminarElementodeDado1Click(Sender: TObject);
begin
  //inherited;   //delete original
    With Tdad.Create(self)   do
    Begin
     Del_object(dbg_dg.DataSource.DataSet.FieldByName('CLI_ID').asinteger,
                dbg_dg.DataSource.DataSet.FieldByName('PRJ_ID').asinteger,
                dbg_dg.DataSource.DataSet.FieldByName('IDF_CODIGO').asinteger,
                dbg_dg.DataSource.DataSet.FieldByName('IDF_TABELA').asstring,
                dbg_dg.DataSource.DataSet.FieldByName('IDF_SEQ').asinteger);
     free;
   //  dbg_dg.DataSource.DataSet.Refresh;
   pgcpChange (nil);
    end;


end;





procedure Tfrm_if.SpeedButton11Click(Sender: TObject);
begin
  inherited;
  
{  with Tdados_tab.create(self) do
     begin
       ListaCli := Cliente ;
       ListaProj:= Cenario ;
       ListaDim := 'IDF_DE' ;
       ListaTit := def26 ;
       ListaTag := 0 ;
       ListaEdit:= false ;
       ListaTree:= nil;
       ListaId  := 0;
       Listafecha:= true;
       mostra_lista;

       If ListaCodigo = 0 then
          exit;

       with Tdad.create(self) do
       Begin
          CLI_ID := Cliente;
          PRJ_ID := cenario;
          IDF_CODIGO := ListaCodigo;
          Inclui(Dbedit5.text) ;
          idados.fClient.Refresh;
          free;
       end;
       pgcpChange(self);
     end;}
end;

procedure Tfrm_if.sp2Click(Sender: TObject);
var
dados : TDados_tab;
wtnode : TTreeNode;
I : INTEGER;
begin
  inherited;
  If dbg_dg.DataSource <> nil then
   Begin
     If (dbg_dg.DataSource.DataSet.State = dsedit)  or (dbg_dg.DataSource.DataSet.State = dsinsert)  then
          dbg_dg.DataSource.DataSet.Post;
   end;
  If frm_Treeativ <> nil then
   Begin
     WtNode        := tv.get_filho(tv.selected,Id);
     If wtnode <> nil then
     begin
       If Dbedit5.text <> WtNode.text then
         Begin
           Wtnode.Text :=Dbedit5.Text;
           try

             with Tdiag_dados.create(self) do
              Begin
               SUB_NOME := dbedit5.Text;
               CLI_ID   := Cliente;
               PRJ_ID   := Cenario;
               IDG_ID   := udado(WtNode.Data)^.FDiag;
               udado(wtnode.Data)^.FNome := dbedit5.text;
               atualizar ;
              // free;
              end;
           finally
           end;
         end;
     end;
   end;
   dbEdit5.Enabled := false;
end;

procedure Tfrm_if.Loadconstantobj;
 Begin
    label5.caption := def39    ;//descri�a�
    label9.caption := def10005    ;//nome
    //speedbutton11.caption := def7610       ;//incluir atributos..
    speedbutton8.caption := def7611       ;//incluir atributos..
    dbgdom.Caption :=  def1210;//    tipo dominio;
    //dbgdom.Items[0] :=  defs20 + ' '+def55;// semdominio;
    //dbgdom.Items[1] :=  defa25;// aberto;
    //dbgdom.Items[2] :=  deff7;// fechado;
    label1.Caption   :=   deff7;// // fechado;
    aberto.Caption   :=  defa25;// aberto;
    
 end;

procedure Tfrm_if.dbgdomChange(Sender: TObject);
begin
 // inherited;
  {case dbgdom.ItemIndex of
   -1,0 :  Begin
         db_dom.Visible := false;
         //cmb_tab.Visible := false;
         //db_tab.Visible  := false;
         label1.Visible := false;
         //aberto.visible := false;
        end;
   1 :  Begin
         db_dom.Visible := false;
         cmb_tab.Visible := true;
         db_tab.Visible  := true;
         label1.Visible := false;
         aberto.visible := true;
        end;

   1 :  Begin
         db_dom.Visible := true;
         //cmb_tab.Visible := false;
         //db_tab.Visible  := false;
         label1.Visible := true;
         //aberto.visible := false;
        end;
  end;}
end;



procedure Tfrm_if.SetiTabRef(const Value: Tdad);
begin
  FiTabRef := Value;
end;

procedure Tfrm_if.cmb_tabCloseUp(Sender: TObject);
begin
  inherited;
  db_tab.DataSource.DataSet.Edit;
  db_tab.Field.Text := cmb_tab.items[cmb_tab.itemIndex];
end;

procedure Tfrm_if.GroupBox2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  dbgdomChange(NIL);
end;

procedure Tfrm_if.dbg_dgCellClick(Column: TColumn);
begin
  inherited;
  dbgdomChange(nil);
end;

procedure Tfrm_if.BLERClick(Sender: TObject);
VAR
ide : Tdad;
i ,j: integer;
wquery,wquery1 : string;
iQuery : TADOquery;
begin
  inherited;
    iQuery := TADOquery.create(self);
    iQuery.connection := bdx;

    iQuery.sql.text := 'SELECT * FROM IDF_DADOS WHERE '+
                      ' CLI_ID = '+ ''+INTTOSTR(cliente)+''+' AND '+
                      ' PRJ_ID = '+ ''+INTTOSTR(cenario)+''+
                      ' AND IDF_TABELA = '+''''+dbedit5.Text+''''+
                      ' AND IDF_DEFAULT_VALUE <> '+''''+''+''''+
                      '  ORDER BY IDF_SEQ';
     iquery.open;

     wquery := 'INSERT INTO PFUNC (';
     wquery1:= 'SELECT ';
     i := 0;
     j := 0;
   while not iQuery.eof do
     Begin
      inc(i)  ;
      If (i > 1) then
        begin
        If  iQuery.fieldbyname('IDF_DEFAULT_VALUE').asstring = ''  then
        else
          Begin
            wquery :=  wquery + ',';
            wquery1 :=  wquery1+ ',';
          end;

        end;
      wquery  := wquery + iQuery.fieLdbyname('IDF_DESIGNACAO').asstring;//+',';
      If uppercase(iQuery.fieLdbyname('IDF_VISIBLE').asstring) = 'S' then
         WQUERY1 := wquery1 +  ''+iQuery.fieldbyname('IDF_DEFAULT_VALUE').asstring+'' //+','
      else
         Begin
          If iQuery.fieldbyname('IDF_DEFAULT_VALUE').asstring = '' then
            // WQUERY1 := wquery1 + ''''+'' +''''
          else
             WQUERY1 := wquery1 + ''''+iQuery.fieldbyname('IDF_DEFAULT_VALUE').asstring+'''' //+','
         end;

      if i = 5 then
         Begin
           i := 0  ;
           wquery :=  wquery + ',';
           memo1.lines.add(wquery);
           wquery := '';

           wquery1 :=  wquery1+ ',';
           memo2.lines.add(wquery1);
           wquery1 := '';
         end;
      iQuery.Next;
     end;
     memo1.lines.add(wquery);
     memo2.lines.add(wquery1);
     memo1.lines[memo1.lines.count -1] :=    memo1.lines[memo1.lines.count -1]+')';
     memo1.Text := memo1.text + memo2.text;
     memo1.lines.SaveToFile('c:\develop\conversao_ind\queryConversaoFuncFIH.txt');
end;

procedure Tfrm_if.Button2Click(Sender: TObject);
begin
  inherited;
  //dbg_dg.ReadOnly := false;
  dbg_dg.DataSource.DataSet.Insert;
end;

procedure Tfrm_if.Button1Click(Sender: TObject);
begin
  inherited;
  //EliminarElementodeDado1Click(sender);
  Excluir1Click(sender);
end;

procedure Tfrm_if.sp_insertClick(Sender: TObject);
begin
  inherited;
  dbEdit5.Enabled := true;
end;

procedure Tfrm_if.dbg_dg1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  //dbg_dg.ReadOnly := true;
end;

procedure Tfrm_if.dbg_dgEnter(Sender: TObject);
begin
  inherited;
  //dbg_dg.ReadOnly := true;
end;

procedure Tfrm_if.dbg_dgDblClick(Sender: TObject);
Var
  wid : integer;
begin
  //inherited;
   wid := StrToInt(dbg_dg.Columns[10].Field.Value);
   frmViewED.CarregaItem(wid);
   frmViewED.Show;

end;

end.