<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.CharSet = "UTF-8"%>

<%



'Main Configiration of this page
yol = request("yol")
dbsource = "/db/access.mdb"
savefolder = "/upload/" 'big images
maxheight = 750
maxwidth = 950
savethumbsfolder = "/thumbnails/"
thumbstype = "fitin.square" ' or you can use "croped.square" 
thumbssize = 150 ' square edge
' Dont forget to give write permisions to uploading folder and database

'Connection String
ConnectionStr = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & Server.MapPath(dbsource)


'Internet Explorer and Opera do not yet support XMLHTTPRequest file uploads, so iframe based uploads require a Content-type of text/plain
strUserAgent = UCase(CStr(Request.ServerVariables("HTTP_USER_AGENT")))
if InStr(strUserAgent, "OPERA") or InStr(strUserAgent, "MSIE") then
    response.ContentType = "text/html"
else
    response.ContentType = "application/json"
end if



'For delete pictures small code
'dont forget the control who accessing of this page or anybody can delete any picture of your system
islem=request.QueryString("islem")

if islem="delete" then
imagefileid=request.QueryString("id")
	if not isnumeric(imagefileid) then
	response.End()
	end if
							'Database connection to learn filename from id
							SQLStrFileName = "SELECT * FROM pictures WHERE pictureid="&cint(imagefileid)
							set ConnectionObjFileName = Server.CreateObject("ADODB.Connection")
							ConnectionObjFileName.Open ConnectionStr
							set objRsFileName = Server.CreateObject("ADODB.Recordset")
							 objRsFileName.CursorType = 2
							 objRsFileName.CursorLocation = 2
							 objRsFileName.LockType = 3
							 objRsFileName.Open SQLStrFileName, ConnectionObjFileName, , , &H0001
									 if objRsFileName.eof then
									 response.End()
									 End if
							 filename=objRsFileName("filename")
	'delete the file
 	Set fso = CreateObject("Scripting.FileSystemObject" )  
	if fso.FileExists (Server.MapPath(savefolder & filename)) Then
	fso.DeleteFile(Server.MapPath(savefolder & filename)) 
			'delete from database
			delsql="DELETE * FROM pictures WHERE pictureid="&cint(imagefileid)
			set objConnDel = Server.CreateObject("ADODB.Connection")
			objConnDel.Open ConnectionStr
			objConnDel.Execute delsql
			objConnDel.Close
			SET objConnDel = Nothing
					'delete thumb image
					Set fsothumb = CreateObject("Scripting.FileSystemObject" )  
					if fsothumb.FileExists (Server.MapPath(savethumbsfolder & filename)) Then
					fsothumb.DeleteFile(Server.MapPath(savethumbsfolder & filename)) 
					end if
	end if
response.End()
end if




'Create new filenames function
Function newfilename( nNoChars, sValidChars )
	Const szDefault = "abcdefghijklmnopqrstuvxyzABCDEFGHIJKLMNOPQRSTUVXYZ0123456789"
	Dim nCount
	Dim sRet
	Dim nNumber
	Dim nLength
	Randomize
	If sValidChars = "" Then
		sValidChars = szDefault		
	End If
	nLength = Len( sValidChars )
	For nCount = 1 To nNoChars
		nNumber = Int((nLength * Rnd) + 1)
		sRet = sRet & Mid( sValidChars, nNumber, 1 )
	Next
	newfilename = sRet	
End Function
'usage ->   newname = "YourSite.com_"+Now()+"_" + newfilename(5,"")

    Function trn(strVeri)
        if not isnull(strVeri) then
            strVeri=Replace(strVeri,"%20"," ")
            strVeri=Replace(strVeri,"%5B","[")
            strVeri=Replace(strVeri,"%5D","]")
            strVeri=Replace(strVeri,"Ä±","ı")
            strVeri=Replace(strVeri,"ÄŸ","ğ")
            strVeri=Replace(strVeri,"Ã¼","ü")
            strVeri=Replace(strVeri,"Ã§","ç")
            strVeri=Replace(strVeri,"Ä°","İ")
            strVeri=Replace(strVeri,"Ä","Ğ")
            strVeri=Replace(strVeri,"Ã‡","Ç")
            strVeri=Replace(strVeri,"Ãœ","Ü")
            strVeri=Replace(strVeri,"Ã¶","ö")
            strVeri=Replace(strVeri,"Ã–","Ö")
            strVeri=Replace(strVeri,"ÅŸ","ş")
            strVeri=Replace(strVeri,"Å","Ş")
            strVeri=Replace(strVeri,"'","''")
        end if
        trn = strVeri
    End Function


'create Date format convert and setting time diffirence between u.s.a and iran
nowtime=DateAdd("h",9,Now()) 'local time diffirence with server and your country
if cint(Day(nowtime))<10 then
    daystr=("0"+cstr(Day(nowtime)))
else
    daystr=(Day(nowtime))
end if
if cint(Month(nowtime))<10 then
    monthstr=("0"+cstr(Month(nowtime)))
else
    monthstr=(Month(nowtime))
end if
if cint(Hour(nowtime))<10 then
    hourstr=("0"+cstr(Hour(nowtime)))
else
    hourstr=(Hour(nowtime))
end if
if cint(Minute(nowtime))<10 then
    minstr=("0"+cstr(Minute(nowtime)))
else
    minstr=(Minute(nowtime))
end if
if cint(Second(nowtime))<10 then
    secstr=("0"+cstr(Second(nowtime)))
else
    secstr=(Second(nowtime))
end if
newtimeformat=daystr&"."&monthstr&"."&Year(nowtime)&"_"&hourstr&"."&minstr&"."&secstr


'VBScript ASP JSON 2.0.3 codes by Salih Şahin @ 2012 
Const JSON_OBJECT	= 0
Const JSON_ARRAY	= 1
Class jsCore
	Public Collection
	Public Count
	Public QuotedVars
	Public Kind 
	Private Sub Class_Initialize
		Set Collection = CreateObject("Scripting.Dictionary")
		QuotedVars = True
		Count = 0
	End Sub
	Private Sub Class_Terminate
		Set Collection = Nothing
	End Sub
	Private Property Get Counter 
		Counter = Count
		Count = Count + 1
	End Property
	Public Property Let Pair(p, v)
		If IsNull(p) Then p = Counter
		Collection(p) = v
	End Property
	Public Property Set Pair(p, v)
		If IsNull(p) Then p = Counter
		If TypeName(v) <> "jsCore" Then
			Err.Raise &hD, "class: class", "Incompatible types: '" & TypeName(v) & "'"
		End If
		Set Collection(p) = v
	End Property
	Public Default Property Get Pair(p)
		If IsNull(p) Then p = Count - 1
		If IsObject(Collection(p)) Then
			Set Pair = Collection(p)
		Else
			Pair = Collection(p)
		End If
	End Property
	Public Sub Clean
		Collection.RemoveAll
	End Sub
	Public Sub Remove(vProp)
		Collection.Remove vProp
	End Sub
	Function jsEncode(str)
		Dim charmap(127), haystack()
		charmap(8)  = "\b"
		charmap(9)  = "\t"
		charmap(10) = "\n"
		charmap(12) = "\f"
		charmap(13) = "\r"
		charmap(34) = "\"""
		charmap(47) = "\/"
		charmap(92) = "\\"
		Dim strlen : strlen = Len(str) - 1
		ReDim haystack(strlen)
		Dim i, charcode
		For i = 0 To strlen
			haystack(i) = Mid(str, i + 1, 1)
			charcode = AscW(haystack(i)) And 65535
			If charcode < 127 Then
				If Not IsEmpty(charmap(charcode)) Then
					haystack(i) = charmap(charcode)
				ElseIf charcode < 32 Then
					haystack(i) = "\u" & Right("000" & Hex(charcode), 4)
				End If
			Else
				haystack(i) = "\u" & Right("000" & Hex(charcode), 4)
			End If
		Next
		jsEncode = Join(haystack, "")
	End Function
	Public Function toJSON(vPair)
		Select Case VarType(vPair)
			Case 0
				toJSON = "null"
			Case 1
				toJSON = "null"
			Case 7
				toJSON = """" & CStr(vPair) & """"
			Case 8
				toJSON = """" & jsEncode(vPair) & """"
			Case 9
				Dim bFI,i 
				bFI = True
				If vPair.Kind Then toJSON = toJSON & "[" Else toJSON = toJSON & "{"
				For Each i In vPair.Collection
					If bFI Then bFI = False Else toJSON = toJSON & ","
					If vPair.Kind Then 
						toJSON = toJSON & toJSON(vPair(i))
					Else
						If QuotedVars Then
							toJSON = toJSON & """" & i & """:" & toJSON(vPair(i))
						Else
							toJSON = toJSON & i & ":" & toJSON(vPair(i))
						End If
					End If
				Next
				If vPair.Kind Then toJSON = toJSON & "]" Else toJSON = toJSON & "}"
			Case 11
				If vPair Then toJSON = "true" Else toJSON = "false"
			Case 12, 8192, 8204
				toJSON = RenderArray(vPair, 1, "")
			Case Else
				toJSON = Replace(vPair, ",", ".")
		End select
	End Function
	Function RenderArray(arr, depth, parent)
		Dim first : first = LBound(arr, depth)
		Dim last : last = UBound(arr, depth)
		Dim index, rendered
		Dim limiter : limiter = ","
		RenderArray = "["
		For index = first To last
			If index = last Then
				limiter = ""
			End If 
			On Error Resume Next
			rendered = RenderArray(arr, depth + 1, parent & index & "," )
			If Err = 9 Then
				On Error GoTo 0
				RenderArray = RenderArray & toJSON(Eval("arr(" & parent & index & ")")) & limiter
			Else
				RenderArray = RenderArray & rendered & "" & limiter
			End If
		Next
		RenderArray = RenderArray & "]"
	End Function
	Public Property Get jsString
		jsString = toJSON(Me)
	End Property
	Sub Flush
		If TypeName(Response) <> "Empty" Then 
			Response.Write(jsString)
		ElseIf WScript <> Empty Then 
			WScript.Echo(jsString)
		End If
	End Sub
	Public Function Clone
		Set Clone = ColClone(Me)
	End Function
	Private Function ColClone(core)
		Dim jsc, i
		Set jsc = new jsCore
		jsc.Kind = core.Kind
		For Each i In core.Collection
			If IsObject(core(i)) Then
				Set jsc(i) = ColClone(core(i))
			Else
				jsc(i) = core(i)
			End If
		Next
		Set ColClone = jsc
	End Function
End Class
Function jsObject
	Set jsObject = new jsCore
	jsObject.Kind = JSON_OBJECT
End Function
Function jsArray
	Set jsArray = new jsCore
	jsArray.Kind = JSON_ARRAY
End Function
Function toJSON(val)
	toJSON = (new jsCore).toJSON(val)
End Function


'Persits ASPUpload
Set Upload = Server.CreateObject("Persits.Upload")
Upload.IgnoreNoPost = True ' It needs becouse, first loading the uploader page doesnt post anything to this page 
Upload.CodePage = 65001 'Charset
Upload.OverwriteFiles = False 'It is not important, because always stytem generate a new image name. 

Upload.SetMaxSize 10000000, True
on error resume next
' Save to memory. Path parameter is omitted
Upload.Save


' Build path string
Path = Server.Mappath(savefolder & "upload/")

' Create path, ignore "already exists" error
Upload.CreateDirectory Path, True

'salih



							'Database connection object
							SQLStr = "SELECT * FROM pictures"
							set ConnectionObj = Server.CreateObject("ADODB.Connection")
							ConnectionObj.Open ConnectionStr
							set objRs = Server.CreateObject("ADODB.Recordset")
							 objRs.CursorType = 2
							 objRs.CursorLocation = 2
							 objRs.LockType = 3
							 objRs.Open SQLStr, ConnectionObj, , , &H0001


						'we must learn how many files uploaded (for opera browser)
						totalfile=0
						For Each File in Upload.Files
						totalfile=totalfile+1
						Next
				
			response.Write("[")
			i=1
			For Each File in Upload.Files



			'new file name
			newname = "proskop_"+newtimeformat+"_" + newfilename(5,"")

            ismim = File.OriginalFileName

            for q = 0 to ubound(split(ismim,"."))
                filetypesssss = split(ismim,".")(q)
            next

            if filetypesssss = "asp" or filetypesssss = "aspx"  or filetypesssss = "php" then
                Response.End
            end if

		    File.SaveAs Server.Mappath(savefolder & "upload/") & "\" & newname & "." & filetypesssss
                             

							 			'write json data			
										dim jsn
										Set jsn = jsObject()
										jsn("name")=File.OriginalFileName
										jsn("size")=readfilesize
										jsn("url")=   savefolder & "upload/" & newname & "." & filetypesssss
										jsn("thumbnail_url")=savethumbsfolder & "upload/" & newname & "." & filetypesssss
										jsn("delete_url")="/upload.asp?islem=delete&id="&picid
										jsn("delete_type")="POST"
                                        if len(telif)>1 then
                                            jsn("telif")="@" & telif
                                        else
                                        if not Upload.Form("sutun")="tatilprintresim" then
                                                jsn("telif")=""
                                            else
                                                jsn("telif")="@" & server.HTMLEncode(request.Cookies("v1cnt")("kullanici_adsoyad"))
                                            end if
                                        end if
                                        jsn("sutun")=Upload.Form("sutun")
										jsn.Flush	
										
									
				if totalfile>1 and totalfile<>i then
				response.Write(",")
				end if	
			i=i+1	
			'remove the temp file which is the orjinal file
			'File.Delete
			Next
			response.Write("]")		

	%>