object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'frmMain'
  ClientHeight = 273
  ClientWidth = 506
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnAddClientes: TBitBtn
    Left = 39
    Top = 21
    Width = 193
    Height = 25
    Caption = 'Adicionar Clientes'
    TabOrder = 0
    OnClick = btnAddClientesClick
  end
  object btnAddCarros: TBitBtn
    Left = 39
    Top = 56
    Width = 193
    Height = 25
    Caption = 'Adicionar Carros'
    TabOrder = 1
    OnClick = btnAddCarrosClick
  end
  object btnAddVendas: TBitBtn
    Left = 39
    Top = 91
    Width = 193
    Height = 25
    Caption = 'Adicionar Vendas'
    TabOrder = 2
    OnClick = btnAddVendasClick
  end
end
