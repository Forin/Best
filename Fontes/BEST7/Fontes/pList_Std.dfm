object frm_pList: Tfrm_pList
  Left = 222
  Top = 113
  Width = 805
  Height = 639
  Caption = '0'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object qrp: TQuickRep
    Left = 4
    Top = -1
    Width = 794
    Height = 1123
    Frame.Color = clBlack
    Frame.DrawTop = True
    Frame.DrawBottom = True
    Frame.DrawLeft = True
    Frame.DrawRight = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial Narrow'
    Font.Style = []
    Functions.Strings = (
      'PAGENUMBER'
      'COLUMNNUMBER'
      'REPORTTITLE')
    Functions.DATA = (
      '0'
      '0'
      #39#39)
    Options = [FirstPageHeader, LastPageFooter]
    Page.Columns = 1
    Page.Orientation = poPortrait
    Page.PaperSize = A4
    Page.Values = (
      100.000000000000000000
      2970.000000000000000000
      100.000000000000000000
      2100.000000000000000000
      50.000000000000000000
      50.000000000000000000
      0.000000000000000000)
    PrinterSettings.Copies = 1
    PrinterSettings.OutputBin = Auto
    PrinterSettings.Duplex = False
    PrinterSettings.FirstPage = 0
    PrinterSettings.LastPage = 0
    PrinterSettings.ExtendedDuplex = 0
    PrinterSettings.UseStandardprinter = False
    PrinterSettings.UseCustomBinCode = False
    PrinterSettings.CustomBinCode = 0
    PrinterSettings.UseCustomPaperCode = False
    PrinterSettings.CustomPaperCode = 0
    PrinterSettings.PrintMetaFile = False
    PrintIfEmpty = True
    SnapToGrid = True
    Units = MM
    Zoom = 100
    PrevFormStyle = fsNormal
    PreviewInitialState = wsNormal
    object PageHeaderBand1: TQRBand
      Left = 19
      Top = 38
      Width = 756
      Height = 99
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      Size.Values = (
        261.937500000000000000
        2000.250000000000000000)
      BandType = rbPageHeader
      object pTit: TQRLabel
        Left = 10
        Top = 0
        Width = 615
        Height = 65
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          171.979166666666700000
          26.458333333333330000
          0.000000000000000000
          1627.187500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = False
        AutoStretch = False
        Caption = '               '
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Arial Black'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 14
      end
      object pTit1: TQRLabel
        Left = 8
        Top = 56
        Width = 181
        Height = 28
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          74.083333333333340000
          21.166666666666670000
          148.166666666666700000
          478.895833333333400000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = '                              '
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Arial Black'
        Font.Style = []
        ParentFont = False
        Transparent = False
        WordWrap = True
        FontSize = 14
      end
      object QRSysData1: TQRSysData
        Left = 653
        Top = 40
        Width = 35
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1727.729166666667000000
          105.833333333333300000
          92.604166666666680000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        Color = clWhite
        Data = qrsDate
        Transparent = False
        FontSize = 9
      end
      object QRSysData2: TQRSysData
        Left = 653
        Top = 56
        Width = 37
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1727.729166666667000000
          148.166666666666700000
          97.895833333333340000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        Color = clWhite
        Data = qrsTime
        Transparent = False
        FontSize = 9
      end
      object QRSysData3: TQRSysData
        Left = 646
        Top = 78
        Width = 45
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1709.208333333333000000
          206.375000000000000000
          119.062500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        Color = clWhite
        Data = qrsPageNumber
        Transparent = False
        FontSize = 9
      end
      object QRLabel1: TQRLabel
        Left = 605
        Top = 40
        Width = 36
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1600.729166666667000000
          105.833333333333300000
          95.250000000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Data : '
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 9
      end
      object QRLabel2: TQRLabel
        Left = 605
        Top = 56
        Width = 34
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1600.729166666667000000
          148.166666666666700000
          89.958333333333340000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Hora :'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 9
      end
      object QRLabel3: TQRLabel
        Left = 630
        Top = 78
        Width = 14
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          1666.875000000000000000
          206.375000000000000000
          37.041666666666670000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'Fl.'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 9
      end
    end
    object db: TQRBand
      Left = 19
      Top = 177
      Width = 756
      Height = 18
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        47.625000000000000000
        2000.250000000000000000)
      BandType = rbDetail
    end
    object bd_foot: TQRBand
      Left = 19
      Top = 195
      Width = 756
      Height = 32
      Frame.Color = clBlack
      Frame.DrawTop = True
      Frame.DrawBottom = True
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = True
      Color = clWhite
      ForceNewColumn = False
      ForceNewPage = False
      LinkBand = db
      Size.Values = (
        84.666666666666680000
        2000.250000000000000000)
      BandType = rbSummary
      object ptot: TQRLabel
        Left = 24
        Top = 8
        Width = 21
        Height = 17
        Frame.Color = clBlack
        Frame.DrawTop = False
        Frame.DrawBottom = False
        Frame.DrawLeft = False
        Frame.DrawRight = False
        Size.Values = (
          44.979166666666670000
          63.500000000000000000
          21.166666666666670000
          55.562500000000000000)
        Alignment = taLeftJustify
        AlignToBand = False
        AutoSize = True
        AutoStretch = False
        Caption = 'ptot'
        Color = clWhite
        Transparent = False
        WordWrap = True
        FontSize = 9
      end
    end
    object ch: TQRBand
      Left = 19
      Top = 137
      Width = 756
      Height = 40
      Frame.Color = clBlack
      Frame.DrawTop = False
      Frame.DrawBottom = False
      Frame.DrawLeft = False
      Frame.DrawRight = False
      AlignToBottom = False
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ForceNewColumn = False
      ForceNewPage = False
      ParentFont = False
      Size.Values = (
        105.833333333333300000
        2000.250000000000000000)
      BandType = rbColumnHeader
    end
  end
end
