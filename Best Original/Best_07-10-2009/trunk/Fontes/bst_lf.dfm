inherited frm_lf: Tfrm_lf
  Left = 316
  Top = 150
  Caption = 'Local de Processamento'
  ClientHeight = 360
  ClientWidth = 521
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel3: TPanel
    Width = 521
    Color = clBtnFace
    Visible = False
    inherited sp2: TSpeedButton
      Left = 588
    end
    inherited sp_print: TSpeedButton
      OnClick = sp_printClick
    end
    inherited sp_insert: TSpeedButton
      Width = 123
    end
    inherited SP_X: TSpeedButton
      Left = 702
      Top = -6
    end
    inherited DBEdit6: TDBEdit
      Left = 257
      Width = 144
    end
  end
  inherited BitBtn1: TBitBtn
    Left = 658
    Top = 414
  end
  inherited pgcp: TPageControl
    Width = 521
    Height = 311
    inherited tb_geral: TTabSheet
      inherited docext: TSpeedButton
        Left = 10
        Top = 256
      end
      object Label3: TLabel [1]
        Left = 11
        Top = 3
        Width = 32
        Height = 14
        Caption = 'Nome'
        FocusControl = DBEdit2
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel [2]
        Left = 11
        Top = 46
        Width = 97
        Height = 14
        Caption = 'Localiza'#231#227'o F'#237'sica'
        FocusControl = DBEdit1
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel [3]
        Left = 11
        Top = 89
        Width = 53
        Height = 14
        Caption = 'Descri'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
      end
      inherited DBEdit12: TDBEdit
        Left = 179
        Top = 256
        Width = 330
        TabOrder = 3
      end
      object DBEdit2: TDBEdit
        Left = 11
        Top = 19
        Width = 495
        Height = 22
        DataField = 'IDF_DESIGNACAO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object DBEdit1: TDBEdit
        Left = 11
        Top = 62
        Width = 497
        Height = 22
        DataField = 'IDF_LOCALIZACAO_FISICA'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object DBRichEdit1: TDBRichEdit
        Left = 11
        Top = 105
        Width = 497
        Height = 148
        DataField = 'IDF_DESCRICAO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
    end
    inherited Tb_atv: TTabSheet
      inherited lv: TListView
        Left = 0
        Top = 0
        Height = 257
        Columns = <
          item
            Caption = 'Envolvimento Ator/Actor Involvement'
            Width = 300
          end
          item
            AutoSize = True
            Caption = 'Atividade'
          end>
      end
    end
    inherited tb_dados: TTabSheet
      inherited lb1: TLabel
        Top = 4
      end
      inherited gb_dom: TGroupBox
        Top = 211
        Height = 103
        inherited db_dom: TDBMemo
          Height = 71
        end
      end
    end
    inherited tb_ger: TTabSheet
      inherited gb: TGroupBox
        inherited db_versao: TDBEdit
          Height = 23
          Font.Name = 'Calibri'
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'M'#233'trica'
      ImageIndex = 4
      object Label4: TLabel
        Left = 12
        Top = 8
        Width = 65
        Height = 14
        Caption = 'Custo Anual'
      end
      object Memo1: TMemo
        Left = 11
        Top = 47
        Width = 154
        Height = 152
        Lines.Strings = (
          'Levar para atividade')
        TabOrder = 0
        Visible = False
      end
      object DBEdit3: TDBEdit
        Left = 12
        Top = 21
        Width = 153
        Height = 22
        DataField = 'IDF_CUSTOAMBIENTE'
        TabOrder = 1
      end
    end
  end
  inherited CoolBar1: TCoolBar
    Width = 521
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 22
        Width = 521
      end
      item
        Control = StandardToolBar
        ImageIndex = -1
        MinHeight = 22
        Width = 521
      end>
    inherited StandardToolBar: TToolBar
      Width = 508
    end
    inherited ToolBar1: TToolBar
      Width = 508
    end
  end
  inherited ToolbarImages: TImageList
    Left = 480
    Top = 433
  end
  inherited fnt: TFontDialog
    Left = 420
    Top = 428
  end
  inherited PopupMenu1: TPopupMenu
    Left = 451
    Top = 431
  end
  inherited OD: TOpenDialog
    Left = 510
    Top = 430
  end
  inherited MainMenu1: TMainMenu
    Left = 388
    Top = 427
  end
end
