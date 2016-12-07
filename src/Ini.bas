Attribute VB_Name = "modIni"
Option Explicit

' API Function to read information from INI File
Public Declare Function GetPrivateProfileString Lib "kernel32" _
    Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any _
    , ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long _
    , ByVal lpFileName As String) As Long

' API Function to write information to the INI File
Private Declare Function WritePrivateProfileString Lib "kernel32" _
    Alias "WritePrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any _
    , ByVal lpString As Any, ByVal lpFileName As String) As Long

' Get the INI Setting from the File
Public Function GetIniSetting(ByVal sHeading As String, ByVal sKey As String) As String
    Const cparmLen = 250
    Dim sReturn As String * cparmLen
    Dim sDefault As String * cparmLen
    Dim lLength As Long
    lLength = GetPrivateProfileString(sHeading, sKey, sDefault, sReturn, cparmLen, StringFormat("{0}\settings.ini", App.Path))
    GetIniSetting = Mid(sReturn, 1, lLength)
End Function

' Save Ini Setting in the File
Public Function PutIniSetting(ByVal sHeading As String, ByVal sKey As String, ByVal sSetting As String) As Boolean
    On Error GoTo HandleError
    Const cparmLen = 50
    Dim sReturn As String * cparmLen
    Dim sDefault As String * cparmLen
    Dim aLength As Long
    aLength = WritePrivateProfileString(sHeading, sKey, sSetting, StringFormat("{0}\settings.ini", App.Path))
    PutIniSetting = True
    Exit Function
    
HandleError:
    Debug.Print Err.Number & " " & Err.Description
End Function

