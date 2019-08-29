<!-- #include virtual="/data_root/conn.asp" -->
<%

on error resume next

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
    if id = "" then
        id = 41
    end if

    SQL="select detay_url from makrogem_btso_uye_listesi where id = " & id
    set cek = baglanti.execute(SQL)

    Dim sResult : sResult = GetTextFromUrl("http://www.btso.org.tr/" & cek("detay_url"))
    'Dim sResult : sResult = GetTextFromUrl("http://www.btso.org.tr/members/membersopen.asp?qfirmid=13472&cnt=71694")
    
    asd = sResult
    
    if not instr(sResult, "<strong style=""font-size:14px"">") = 0 then


    
        firma_adi = mid(sResult,instr(sResult, "<strong style=""font-size:14px"">") +  len("<strong style=""font-size:14px"">"), instr(sResult, "</strong>") - len("</strong>")-1)
        firma_adi = left(firma_adi,  instr(firma_adi, "</strong>") -1)



        if instr(sResult, "Kayıt Tarihi") = 0 then
            kayit_tarihi = ""
        else
            kayit_tarihi = left(mid(sResult,instr(sResult, "Kayıt Tarihi") + 26, 500), instr(mid(sResult,instr(sResult, "Kayıt Tarihi") + 26, 500), "</td>")-1)
        end if
        kayit_tarihi = trim(kayit_tarihi)




        if instr(sResult, "Üyelik Durumu") = 0 then
            durum = ""
        else
            durum = left(mid(sResult,instr(sResult, "Üyelik Durumu") + 27, 500), instr(mid(sResult,instr(sResult, "Üyelik Durumu") + 27, 500), "</td>")-1)
        end if
        durum = trim(durum)



        if instr(sResult, "Nace Kodu") = 0 then
            nace_kodu = ""
        else
            nace_kodu = left(mid(sResult,instr(sResult, "Nace Kodu") + 27, 500), instr(mid(sResult,instr(sResult, "Nace Kodu") + 27, 500), "</td>")-1)
        end if
        nace_kodu = trim(nace_kodu)


        if instr(sResult, "Meslek Grubu") = 0 then
            meslek_grubu = ""
        else
            meslek_grubu = left(mid(sResult,instr(sResult, "Meslek Grubu") + 27, 500), instr(mid(sResult,instr(sResult, "Meslek Grubu") + 27, 500), "</td>")-1)
        end if
        meslek_grubu = trim(meslek_grubu)


        if instr(sResult, "Adres") = 0 then
            adres = ""
        else
            adres = left(mid(sResult,instr(sResult, "Adres") + 20, 500), instr(mid(sResult,instr(sResult, "Adres") + 20, 500), "</td>")-1)
        end if
        adres = trim(adres)



        if instr(sResult, "Telefon") = 0 then
            Telefon = ""
        else
            Telefon = left(mid(sResult,instr(sResult, "Telefon") + 22, 500), instr(mid(sResult,instr(sResult, "Telefon") + 22, 500), "</td>")-1)
        end if
        Telefon = trim(Telefon)



        if instr(sResult, "Faks") = 0 then
            Faks = ""
        else
            Faks = left(mid(sResult,instr(sResult, "Faks") + 4, 500), instr(mid(sResult,instr(sResult, "Faks") + 4, 500), "</td>")-1)
        end if
        Faks = trim(Faks)



        if instr(sResult, "E-mail") = 0 then
            mail = ""
        else
            mail = left(mid(sResult,instr(sResult, "E-mail") + 21, 500), instr(mid(sResult,instr(sResult, "E-mail") + 21, 500), "</td>")-1)
        end if
        mail = trim(mail)

        if instr(sResult, "Web") = 0 then
            web = ""
        else
            web = left(mid(sResult,instr(sResult, "target=""_blank"">") + 16, 500), instr(mid(sResult,instr(sResult, "target=""_blank"">") + 16, 500), "</a>")-1)
        end if
        web = trim(web)


        Response.Write "Firma Adı : " & firma_adi & "<br>"
        Response.Write "Kayıt Tarihi : " & kayit_tarihi & "<br>"
        Response.Write "Durum : " & durum & "<br>"
        Response.Write "Nace Kodu : " & nace_kodu & "<br>"
        Response.Write "Meslek Grubu : " & meslek_grubu & "<br>"
        Response.Write "Adres : " & adres & "<br>"
        Response.Write "Telefon : " & Telefon & "<br>"
        Response.Write "Faks : " & Faks & "<br>"
        Response.Write "Mail : " & mail & "<br>"
        Response.Write "Web : " & web & "<br>"






        SQL="update makrogem_btso_uye_listesi set detay_url = '"& detay_url &"', firma_adi = '"& firma_adi &"', kayit_tarihi = '"& kayit_tarihi &"', durum = '"& durum &"', nace_kodu = '"& nace_kodu &"', meslek_grubu = '"& meslek_grubu &"', adres = '"& adres &"', Telefon = '"& Telefon &"', Faks = '"& Faks &"', mail = '"& mail &"', web = '"& web &"' where id = '"& id &"'"
        set guncelle = baglanti.execute(SQL)

    end if

%>
<meta http-equiv="refresh" content="0; url=/btso2.asp?id=<%=cdbl(id)+1 %>" />
