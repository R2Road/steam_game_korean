﻿REM  *****  BASIC  *****

Option Explicit


Const StartY = 2



Function CalculateSheetActiveArea( sheet as Variant ) as Integer
	
	Dim i, j, h as Integer
	
	
	'
	' H
	'
	j = sheet.Rows.Count - 1
	For i = 2 to j
		If sheet.getCellByPosition( 0, i ).String = "" Then
			Exit For
		EndIf
	Next i	
	
	'
	' Return
	'
	CalculateSheetActiveArea = i - 1
	
End Function



Sub Main

	'
	'
	'
	GlobalScope.BasicLibraries.LoadLibrary("Tools") ' for Tools
	GlobalScope.BasicLibraries.LoadLibrary("ScriptForge") ' for FileSystem
	
	
	'
	' File Open
	'
	Dim file_path as String
	file_path = ( Tools.Strings.DirectoryNameoutofPath(ThisComponent.getURL(),"/" ) & "/" & "rme.txt" )
	MsgBox( file_path )
	
	Dim file_system As Variant
	file_system = CreateScriptService("FileSystem")
	
	Dim pf As Variant
	Set pf = file_system.CreateTextFile(file_path, Overwrite := true)
	
	
	'
	'
	'
    Dim sheet as Object
    sheet = ThisComponent.Sheets.getByName( "list" )
    
    
    '
    ' Max X, Y
    '
    Dim active_area_h as Integer
    active_area_h = CalculateSheetActiveArea( sheet )
    MsgBox( active_area_h )
    
    
    '
    ' Write : Korean List
    '
    Dim s as String
    Dim i, j as Integer
    For i = StartY to active_area_h
    
    	'
    	' Check Export Flag
    	'
    	If sheet.getCellByPosition( 0, i ).String = "x" Then
    		GoTo Continue
    	EndIf
    	
    	If sheet.getCellByPosition( 1, i ).String = "" Then
    		Exit For
    	EndIf
    	
    	s = _
    			"####" _
    		& 	" " _
    		& 	"[" & sheet.getCellByPosition( 1, i ).String & " | " & sheet.getCellByPosition( 2, i ).String & "]( " &  sheet.getCellByPosition( 3, i ).String & " )" _
    		& 	" " _
    		&	"( " _
	    		& 	sheet.getCellByPosition( 4, i ).String _
	    		& 	" | " & sheet.getCellByPosition( 5, i ).String _
	    		& 	" | " & sheet.getCellByPosition( 6, i ).String _
	    		&	" | " & sheet.getCellByPosition( 7, i ).String _
    		& " )"
    	
    	pf.WriteLine( s )
    	'MsgBox( s )
    	
    Continue:
    Next i
    
    
    '
    ' File Close
    '
    pf.CloseFile()
	pf = pf.Dispose()
    
End Sub











