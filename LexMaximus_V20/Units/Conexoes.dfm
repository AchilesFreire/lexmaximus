object DMConexoes: TDMConexoes
  OldCreateOrder = False
  Height = 416
  Width = 514
  object Conexao: TSQLConnection
    ConnectionName = 'FireBirdConnection'
    DriverName = 'Firebird'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbexpint.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Firebird'
      'Database=Dados\ENCICLOPEDIA.GDB'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    VendorLib = 'fbClient.dll'
    Left = 40
    Top = 16
  end
  object SQLQuery_InsertTextoLei: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'CodLei'
        ParamType = ptInput
      end
      item
        DataType = ftBlob
        Name = 'TextoLei'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'Insert into TextoLei'
      '('
      'Lei,'
      'Texto'
      ')'
      'Values'
      '('
      ':CodLei,'
      ':TextoLei'
      ');')
    SQLConnection = Conexao
    Left = 112
    Top = 112
  end
  object SQLQuery_Insert_OcorrenciaLei: TSQLQuery
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'CodLei'
        ParamType = ptInput
      end
      item
        DataType = ftBlob
        Name = 'Ementa'
        ParamType = ptInput
      end
      item
        DataType = ftBlob
        Name = 'Texto'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'Insert into OcorrenciaLei'
      '('
      'Lei,'
      'Palavras_Ementa,'
      'Palavras_Texto'
      ')'
      'Values'
      '('
      ':CodLei ,'
      ':Ementa ,'
      ':Texto '
      ')')
    SQLConnection = Conexao
    Left = 344
    Top = 48
  end
end
