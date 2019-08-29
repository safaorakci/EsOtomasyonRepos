<!-- #include virtual="/data_root/conn.asp" -->
<% 
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    Sub ParcaParcaDosyaIndir(FilePath, FileName)
        Const clChunkSize = 1048576 ' 1MB
        Dim oStream, i
        Response.Buffer = False
        Response.ContentType = "application/octet-stream"
        Response.AddHeader "Content-Disposition", _
        "attachment; Filename=" & FileName
        Set oStream = Server.CreateObject("ADODB.Stream")
        oStream.Type = 1 
        oStream.Open
        oStream.LoadFromFile FilePath
        For i = 1 To oStream.Size \ clChunkSize
            Response.BinaryWrite oStream.Read(clChunkSize)
        Next
        If (oStream.Size Mod clChunkSize) <> 0 Then
            Response.BinaryWrite oStream.Read(oStream.Size Mod clChunkSize)
        End If
        oStream.Close
    End Sub

    if request("tip")="is" then

        dosya_id = request("dosya_id")

        SQL="select * from ucgem_is_dosya_listesi where id = '"& dosya_id &"'"
        set cek = baglanti.execute(SQL)

        ParcaParcaDosyaIndir Server.MapPath(cek("dosya_yolu")), (cek("dosya_adi") & "." & split(right(cek("dosya_yolu"), 7), ".")(1))

    end if


%>
