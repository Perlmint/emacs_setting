Set objShell = WScript.CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

If WScript.Arguments.Count = 2 Then

  strComputer = "."

  Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")

  Set colItems = objWMIService.ExecQuery("Select * From Win32_Process")

  Dim isRunning
  isRunning = False

  For Each objItem in colItems
    If InStr(objItem.CommandLine, "emacs.exe") Then
      isRunning = True
    End If
  Next

  If StrComp(WScript.Arguments(0), "open") = 0 or StrComp(WScript.Arguments(0), "open_new") = 0 Then
    If isRunning Then
      Dim mode
      If StrComp(WScript.Arguments(0),"open_new") = 0 Then
        mode = " -c "
      Else
        mode = ""
      End If
      objShell.Run("""" & fso.GetParentFolderName(WScript.ScriptFullName) & "/emacsclientw.exe""" & mode & " --server-file ""%USERPROFILE%\AppData\Roaming\.emacs.d\server\server"" -n """ & WScript.Arguments(1) & """")
    Else
      objShell.Run("""" & fso.GetParentFolderName(WScript.ScriptFullName) & "/runemacs.exe"" """ & WScript.Arguments(1) & """")
    End If
  End If

Else

  If StrComp(WScript.Arguments(0), "open") = 0 Then
    objShell.Run("""" & fso.GetParentFolderName(WScript.ScriptFullName) & "\runemacs.exe"" ")
  End If
End If