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
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gbCliente: TGroupBox
    Left = 0
    Top = 0
    Width = 805
    Height = 60
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Align = alTop
    Caption = 'Cliente'
    Padding.Left = 10
    Padding.Top = 5
    Padding.Right = 10
    Padding.Bottom = 5
    TabOrder = 0
    object lCliente: TLabel
      Left = 77
      Top = 20
      Width = 366
      Height = 33
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object eCliente: TEdit
      Left = 12
      Top = 20
      Width = 55
      Height = 33
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 3
      NumbersOnly = True
      ParentFont = False
      TabOrder = 0
      OnChange = eClienteChange
      OnExit = eClienteExit
      OnKeyDown = eClienteKeyDown
      ExplicitHeight = 32
    end
  end
  object gbProduto: TGroupBox
    Left = 0
    Top = 120
    Width = 805
    Height = 60
    Align = alTop
    Caption = 'Produto'
    Padding.Left = 10
    Padding.Top = 5
    Padding.Right = 10
    Padding.Bottom = 5
    TabOrder = 2
    object lProduto: TLabel
      Left = 73
      Top = 25
      Width = 416
      Height = 24
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lQuantidade: TLabel
      Left = 504
      Top = 7
      Width = 56
      Height = 13
      Alignment = taCenter
      Caption = 'Quantidade'
    end
    object lValorUnitario: TLabel
      Left = 582
      Top = 7
      Width = 120
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'Valor Unit'#225'rio'
    end
    object meValor: TMaskEdit
      Left = 573
      Top = 22
      Width = 98
      Height = 32
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = ''
    end
    object seQuantidade: TSpinEdit
      Left = 504
      Top = 20
      Width = 63
      Height = 34
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxValue = 0
      MinValue = 0
      ParentFont = False
      TabOrder = 1
      Value = 0
    end
    object bIncluirProduto: TButton
      Left = 719
      Top = 20
      Width = 75
      Height = 32
      Caption = 'Incluir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = bIncluirProdutoClick
    end
    object eProduto: TEdit
      Left = 12
      Top = 20
      Width = 55
      Height = 33
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 3
      NumbersOnly = True
      ParentFont = False
      TabOrder = 0
      OnChange = eProdutoChange
      OnExit = eProdutoExit
      ExplicitTop = 19
    end
  end
  object gbRodape: TGroupBox
    Left = 0
    Top = 405
    Width = 805
    Height = 60
    Align = alBottom
    Caption = 'Rodap'#233
    TabOrder = 4
    ExplicitTop = 409
    object lValorTotalPedido: TLabel
      Left = 2
      Top = 15
      Width = 662
      Height = 43
      Align = alClient
      Alignment = taRightJustify
      Caption = 'R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitLeft = 10
    end
    object bSalvarPedido: TButton
      Left = 664
      Top = 15
      Width = 139
      Height = 43
      Align = alRight
      Caption = 'Salvar Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = bSalvarPedidoClick
      ExplicitLeft = 632
      ExplicitTop = 32
      ExplicitHeight = 25
    end
  end
  object gbItens: TGroupBox
    Left = 0
    Top = 180
    Width = 805
    Height = 225
    Align = alClient
    Caption = 'Itens'
    TabOrder = 3
    object dbgItens: TDBGrid
      Left = 2
      Top = 15
      Width = 801
      Height = 208
      Align = alClient
      DataSource = dsItens
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnKeyDown = dbgItensKeyDown
    end
  end
  object gbPedido: TGroupBox
    Left = 0
    Top = 60
    Width = 805
    Height = 60
    Align = alTop
    Caption = 'Pedido'
    Padding.Left = 10
    Padding.Top = 5
    Padding.Right = 10
    Padding.Bottom = 5
    TabOrder = 1
    ExplicitTop = 61
    object ePedido: TEdit
      Left = 12
      Top = 20
      Width = 55
      Height = 33
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 3
      NumbersOnly = True
      ParentFont = False
      TabOrder = 0
      OnChange = eProdutoChange
      OnExit = eProdutoExit
      ExplicitLeft = 3
      ExplicitTop = 15
      ExplicitHeight = 43
    end
    object bPesquisar: TButton
      Left = 95
      Top = 20
      Width = 99
      Height = 32
      Caption = 'Pesquisar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = bPesquisarClick
    end
    object bCancelar: TButton
      Left = 200
      Top = 21
      Width = 89
      Height = 32
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = bCancelarClick
    end
  end
  object fdmtItens: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 648
    Top = 212
    object fdmtItensItemID: TIntegerField
      FieldName = 'ItemID'
      Visible = False
    end
    object fdmtItensCodProduto: TIntegerField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 10
      FieldName = 'CodProduto'
    end
    object fdmtItensDescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 60
      FieldName = 'Descricao'
      Size = 100
    end
    object fdmtItensQuantidade: TIntegerField
      DisplayWidth = 10
      FieldName = 'Quantidade'
    end
    object fdmtItensValor: TCurrencyField
      DisplayWidth = 14
      FieldName = 'Valor'
    end
    object fdmtItensValorTotal: TCurrencyField
      DisplayLabel = 'Valor Total'
      DisplayWidth = 17
      FieldName = 'ValorTotal'
    end
  end
  object dsItens: TDataSource
    DataSet = fdmtItens
    Left = 680
    Top = 284
  end
end
