inherited frm_data: Tfrm_data
  Left = 384
  Top = 191
  Caption = 'Fluxo de Dados'
  ClientHeight = 442
  ClientWidth = 617
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel3: TPanel
    Width = 617
    Visible = False
    inherited sp2: TSpeedButton
      Left = 740
    end
    inherited sp_print: TSpeedButton
      OnClick = sp_printClick
    end
    inherited sp_insert: TSpeedButton
      Width = 123
    end
    inherited DBEdit6: TDBEdit
      Left = 306
      Width = 453
    end
  end
  inherited BitBtn1: TBitBtn
    Top = 458
    OnClick = BitBtn1Click
  end
  inherited pgcp: TPageControl
    Top = 51
    Width = 617
    Height = 391
    ActivePage = tb_dados
    inherited tb_geral: TTabSheet
      Font.Name = 'Calibri'
      inherited docext: TSpeedButton
        Left = 8
        Top = 338
        Width = 169
      end
      object Label9: TLabel [1]
        Left = 11
        Top = 1
        Width = 69
        Height = 14
        Caption = 'Nome/Name'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel [2]
        Left = 10
        Top = 86
        Width = 121
        Height = 14
        Caption = 'Descri'#231#227'o/Description'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel [3]
        Left = 10
        Top = 43
        Width = 42
        Height = 14
        Caption = 'Volume'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel [4]
        Left = 290
        Top = 42
        Width = 72
        Height = 14
        Caption = 'Midia/Media'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel [5]
        Left = 91
        Top = 63
        Width = 41
        Height = 14
        Caption = 'por/per'
      end
      object cmb_tempo: TDBLookupComboBox [6]
        Left = 140
        Top = 58
        Width = 138
        Height = 22
        DataField = 'IDF_UNIDADE_TEMPO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        KeyField = 'DI_DESCRICAO'
        ListField = 'DI_DESCRICAO'
        ParentFont = False
        TabOrder = 2
        OnCloseUp = cmb_tempoCloseUp
      end
      inherited DBEdit12: TDBEdit
        Left = 184
        Top = 338
        Width = 425
        TabOrder = 6
      end
      object DBEdit5: TDBEdit
        Left = 10
        Top = 18
        Width = 599
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
      object dbmemo1: TDBRichEdit
        Left = 10
        Top = 104
        Width = 596
        Height = 227
        DataField = 'IDF_OBJETIVO'
        ScrollBars = ssVertical
        TabOrder = 1
      end
      object DBEdit3: TDBEdit
        Left = 9
        Top = 58
        Width = 78
        Height = 22
        DataField = 'IDF_VOLUME_PROC'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object cmb_midia: TDBLookupComboBox
        Left = 290
        Top = 57
        Width = 319
        Height = 22
        DataField = 'IDF_MEDIA'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        KeyField = 'DI_DESCRICAO'
        ListField = 'DI_DESCRICAO'
        ParentFont = False
        TabOrder = 4
      end
      object Edit1: TEdit
        Left = 504
        Top = 82
        Width = 101
        Height = 22
        ParentColor = True
        ReadOnly = True
        TabOrder = 5
        Visible = False
      end
      object DBEdit1: TDBEdit
        Left = 139
        Top = 58
        Width = 121
        Height = 22
        DataField = 'IDF_UNIDADE_TEMPO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
    end
    inherited Tb_atv: TTabSheet
      Font.Name = 'Calibri'
      inherited lv: TListView
        Left = 0
        Width = 609
        Height = 353
        Columns = <
          item
            Caption = 'Atividade'
            Width = 390
          end
          item
            Caption = 'Envolvimento Ator/Actor Involvement'
            Width = 200
          end>
      end
    end
    inherited tb_dados: TTabSheet
      Font.Name = 'Calibri'
      inherited lb1: TLabel
        Top = 10
      end
      inherited lb2: TLabel
        Top = 222
      end
      inherited sLista: TSpeedButton
        Left = 538
        Height = 25
        Glyph.Data = {00000000}
      end
      inherited lb3: TLabel
        Width = 12
        Height = 14
      end
      object Button1: TSpeedButton [5]
        Left = 396
        Top = 0
        Width = 70
        Height = 25
        Caption = 'Novo'
        Flat = True
        OnClick = Button1Click
      end
      object SpeedButton1: TSpeedButton [6]
        Left = 467
        Top = 0
        Width = 70
        Height = 25
        Caption = 'Excluir'
        Flat = True
        OnClick = SpeedButton1Click
      end
      inherited db_desc: TDBMemo
        Top = 238
        Height = 102
      end
      inherited dbg_dg: TDBGrid
        Top = 26
        Width = 601
        FixedColor = clBtnFace
        ReadOnly = True
        TitleFont.Name = 'Calibri'
        Columns = <
          item
            Expanded = False
            FieldName = 'IDF_SEQ'
            Title.Caption = 'Seq.'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'IDF_DESIGNACAO'
            Title.Caption = 'Nome'
            Width = 313
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IDF_CAPTION'
            Title.Caption = 'T'#237'tulo'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'IDF_DATA_TYPE'
            PickList.Strings = (
              'C'
              'D'
              'I'
              'M'
              'N'
              'T')
            Title.Caption = 'Tipo'
            Width = 53
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IDF_TYPE_QUALIFIERS'
            Title.Caption = 'Tamanho'
            Width = 59
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IDF_DECIMAL'
            Title.Caption = 'Dec.'
            Width = 31
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IDF_PK'
            Title.Caption = 'PK'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'IDF_OBRIG'
            Title.Caption = 'Obrigat'#243'rio'
            Width = 67
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IDF_VISIBLE'
            Title.Caption = 'Mostr.'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'IDF_DEFAULT_VALUE'
            Title.Caption = 'Default'
            Visible = False
          end>
      end
      inherited gb_dom: TGroupBox
        Top = 229
        Height = 109
        inherited db_dom: TDBMemo
          Top = 18
          Height = 83
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
  end
  inherited CoolBar1: TCoolBar
    Width = 617
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 22
        Width = 617
      end
      item
        Control = StandardToolBar
        ImageIndex = -1
        MinHeight = 26
        Width = 617
      end>
    inherited StandardToolBar: TToolBar
      Width = 604
      Height = 26
    end
    inherited ToolBar1: TToolBar
      Width = 604
    end
  end
  inherited ToolbarImages: TImageList
    Left = 744
    Top = 457
  end
  inherited fnt: TFontDialog
    Left = 710
    Top = 454
  end
  inherited PopupMenu1: TPopupMenu
    Left = 809
    Top = 457
  end
  inherited OD: TOpenDialog
    Left = 774
    Top = 454
  end
  inherited MainMenu1: TMainMenu
    Left = 844
    Top = 451
  end
end
