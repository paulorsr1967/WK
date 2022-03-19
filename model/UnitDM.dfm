object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 415
  Width = 570
  object fdcWK: TFDConnection
    Params.Strings = (
      'Server=localhost'
      'Database=wk'
      'User_Name=wk'
      'Password=wk'
      'DriverID=MySQL')
    Left = 304
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 288
    Top = 208
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 448
    Top = 184
  end
  object FDTransaction1: TFDTransaction
    Connection = fdcWK
    Left = 176
    Top = 112
  end
end
