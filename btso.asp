    <!-- #include visrtual="/data_root/conn.asp" -->

<%
    id = request("id")
    if id = "" then
        id = 0
    end if


    kid = request("kid")
    if kid = "" then
        kid = 12
    end if

    Function GetTextFromUrl(url)

          Dim oXMLHTTP
          Dim strStatusTest

          Set oXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP.3.0")

          oXMLHTTP.Open "GET", url, False
          oXMLHTTP.Send

          If oXMLHTTP.Status = 200 Then
            GetTextFromUrl = oXMLHTTP.responseText
          End If

    End Function

    id = request("id")

    Dim sResult : sResult = GetTextFromUrl("http://www.btso.org.tr/?page=members/members.asp&qpage="& id &"&qcommittee="& kid &".%20GRUP&qorder=")
    asd = sResult
    
    x = 0
    son_url = ""
    sql=""
    Do While x = 0
        if not instr(sResult, "<a href=""members/membersopen.asp?") = 0 then
            firma_url = mid(sResult, instr(sResult, "members/membersopen.asp?"), instr(sResult, """ rel=""modal:open""") - instr(sResult, "members/membersopen.asp?") )
            sResult = right(sResult, len(sResult) - instr(sResult, """ rel=""modal:open"""))
            if not son_url = firma_url then
                son_url  = firma_url
                response.Write firma_url & "<br>"

                SQL=SQL & "insert into makrogem_btso_uye_listesi(detay_url) values('"& firma_url &"');"
            end if
    
        else
            x = 1
        end if
    loop
    if len(sql)=0 then
        kid = kid + 1
        id = 1
    if kid = 64 then
        Response.End
    end if
        Response.Redirect "/btso.asp?id="& id &"&kid=" & kid
        Response.End
    end if

    set ekle = baglanti.execute(SQL)


%>
<meta http-equiv="refresh" content="0; url=/btso.asp?id=<%=cdbl(id)+1 %>&kid=<%=kid %>" />
