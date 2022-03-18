object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Teste - Cadastro de Pedido'
  ClientHeight = 465
  ClientWidth = 805
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object gbCliente: TGroupBox
    Left = 0
    Top = 0
    Width = 805
    Height = 60
    Align = alTop
    Caption = 'Cliente'
    TabOrder = 0
  end
  object gbProduto: TGroupBox
    Left = 0
    Top = 60
    Width = 805
    Height = 60
    Align = alTop
    Caption = 'Produto'
    TabOrder = 1
  end
  object gbRodape: TGroupBox
    Left = 0
    Top = 405
    Width = 805
    Height = 60
    Align = alBottom
    Caption = 'Rodap'#233
    TabOrder = 3
    ExplicitTop = 411
  end
  object gbItens: TGroupBox
    Left = 0
    Top = 120
    Width = 805
    Height = 285
    Align = alClient
    Caption = 'Itens'
    TabOrder = 2
    ExplicitLeft = 344
    ExplicitTop = 200
    ExplicitWidth = 185
    ExplicitHeight = 105
  end
end
