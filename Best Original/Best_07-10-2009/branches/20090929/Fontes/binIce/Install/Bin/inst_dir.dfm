object frm_shell: Tfrm_shell
  Left = 407
  Top = 365
  Width = 352
  Height = 290
  Caption = 'Diret'#243'rios'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object st: TShellTreeView
    Left = 0
    Top = 0
    Width = 344
    Height = 263
    ObjectTypes = [otFolders]
    Root = 'rfMyComputer'
    UseShellImages = True
    Align = alClient
    AutoRefresh = False
    Indent = 19
    ParentColor = False
    RightClickSelect = True
    ShowRoot = False
    TabOrder = 0
    Visible = False
  end
end
