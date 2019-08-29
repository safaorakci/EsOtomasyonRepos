<% 

    Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
    Response.CodePage = 65001

    gelenveri = Request.ServerVariables("QUERY_STRING") 
    gp = Split(gelenveri,"/")

    Function ConvertPhpToDate(numSeconds)
      Dim dEpoch
      dEpoch = DateSerial(1970,1,1)  
      ConvertPhpToDate = DateAdd("s",numSeconds,dEpoch) 
    End Function
    
    Function trn(strVeri)
        if not isnull(strVeri) then
            strVeri = Replace(strVeri,"Â°","°")
            strVeri = Replace(strVeri,"%20"," ")
            strVeri = Replace(strVeri,"%5B","[")
            strVeri = Replace(strVeri,"%5D","]")
            strVeri = Replace(strVeri,"Ä±","ı")
            strVeri = Replace(strVeri,"ÄŸ","ğ")
            strVeri = Replace(strVeri,"Ä°","İ")
            strVeri = Replace(strVeri,"Ä","Ğ")
            strVeri = Replace(strVeri,"Ã¼","ü")
            strVeri = Replace(strVeri,"Ã§","ç")
            strVeri = Replace(strVeri,"%C3%A7", "ç")
            strVeri = Replace(strVeri,"Ã‡","Ç")
            strVeri = Replace(strVeri,"Ãœ","Ü")
            strVeri = Replace(strVeri,"Ã¶","ö")
            strVeri = Replace(strVeri,"Ã–","Ö")
            strVeri = Replace(strVeri,"ÅŸ","ş")
            strVeri = Replace(strVeri,"Å","Ş")
            strVeri = Replace(strVeri,"'","''")
            strVeri = Replace(strVeri," uuml;","ü")
            strVeri = Replace(strVeri," Uuml;","Ü")
            strVeri = Replace(strVeri," ouml;","ö")
            strVeri = Replace(strVeri," Ouml;","Ö")
            strVeri = Replace(strVeri," #39;","'")
            strVeri = Replace(strVeri," ccedil;","ç")
            strVeri = Replace(strVeri," Ccedil;","Ç")
            strVeri = Replace(strVeri," quot;","""")
            strVeri = Replace(strVeri," rsquo;","'")
            strVeri = Replace(strVeri,"%7C","|")
            strVeri = Replace(strVeri, "%2B", "+")
            strVeri = Replace(strVeri,"Â","")
            strVeri = Replace(strVeri,"#38;","&")
        end if
        trn = strVeri
    End Function

    function AyinSonGunu(Gelen) 
        Dim TempDate 
        TempDate = Year(Gelen) & "-" & Month(Gelen) & "-" 
        If IsDate(TempDate & "28" ) Then AyinSonGunu = 28 
        If IsDate(TempDate & "29" ) Then AyinSonGunu = 29 
        If IsDate(TempDate & "30" ) Then AyinSonGunu = 30 
        If IsDate(TempDate & "31" ) Then AyinSonGunu = 31 
    End function 


    FUNCTION URLDecodes(str)

        DIM objScript
        SET objScript = Server.CreateObject("ScriptControl")
        objScript.Language = "JavaScript"
        URLDecodes = objScript.Eval("decodeURIComponent(""" & str & """.replace(/\+/g,"" ""))")
        SET objScript = NOTHING

    END FUNCTION

     Dim xmlResx
     Function initResources()
          ResourceFile = "/dil_cevirileri.xml"
          Set xmlResx=Server.CreateObject("Microsoft.XMLDOM") 
          xmlResx.async=false 
          xmlResx.load(Server.MapPath(ResourceFile))
     End Function

    initResources()

 
    Function LNG(english)

        LNG = english
      '  dil = Request.Cookies("kullanici")("dil_secenek")
      '  if dil = "" or isnull(dil) then
      '      dil = "turkce"
      '  end if
      '  LNG = english
      '  translatebulundumu = false
      '  if not dil = "turkce" then
      '      Set objLst = xmlResx.getElementsByTagName("dil")
      '      For i = 0 to (objLst.length -1)
      '          EnglishText = objLst.item(i).getElementsByTagName("turkce")(0).text
      '          If english = EnglishText Then
      '              LNG = objLst.item(i).getElementsByTagName(dil)(0).text
      '              translatebulundumu = true
      '              Exit For
      '          End If
      '      Next
      '      if translatebulundumu = false and 1 = 2 then
      '          SQL="EXEC dbo.dilayikla @kelimeler = '~"& trim(english) &"~', @cikisdili = 'ingilizce';"
      '          set ekle = baglanti.execute(SQL)
      '      end if
      '  end if
        
    End Function

    FUNCTION HTMLDecode(sText)
        Dim regEx
        Dim matches
        Dim match
        sText = Replace(sText, "&quot;", Chr(34))
        sText = Replace(sText, "&lt;"  , Chr(60))
        sText = Replace(sText, "&gt;"  , Chr(62))
        sText = Replace(sText, "&amp;" , Chr(38))
        sText = Replace(sText, "&nbsp;", Chr(32))
        Set regEx= New RegExp
        With regEx
         .Pattern = "&#(\d+);" 'Match html unicode escapes
         .Global = True
        End With
        Set matches = regEx.Execute(sText)
        'Iterate over matches
        For Each match in matches
            'For each unicode match, replace the whole match, with the ChrW of the digits.
            sText = Replace(sText, match.Value, ChrW(match.SubMatches(0)))
        Next
        HTMLDecode = sText
    END FUNCTION

    FUNCTION ciftparacevir(itutar,cins,cins2)
        SQL="select top 1 USD_SATIS as usd_kur, EUR_SATIS as eur_kur from DOVIZKURLARI order by KURID desc"
        SET kurumucek = baglanti.execute(SQL)
        dolars = kurumucek("usd_kur")
        euros = kurumucek("eur_kur")
        IF cins = "EUR" THEN
            itutar = cdbl(itutar) * cdbl(euros)
        END IF
        IF cins = "USD" THEN
            itutar = cdbl(itutar) * cdbl(dolars)
        END IF
        IF cins2 = "EUR" THEN
            itutar = cdbl(itutar) / cdbl(euros)
        END IF
        IF cins2 = "USD" THEN
            itutar = cdbl(itutar) / cdbl(dolars)
        END IF
        IF isnumeric(itutar)=true THEN
            itutar = Formatnumber(itutar, 2)
            itutar = itutar + 1
            itutar = itutar - 1
        END IF
        ciftparacevir = itutar
    END FUNCTION


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

    Function NoktalamaDegis(Deger)
        Deger = trim(Deger)
        if instr(Deger,",")>0 and instr(Deger,".")>0 then
            if instr(Deger,",")>instr(Deger,".") then
                Deger = replace(replace(Deger,".",""),",",".")
            else
                Deger = replace(Deger,",","")
            end if
        elseif instr(Deger,",")>0 then
            Deger = replace(Deger,",",".")
        end if
        if isnumeric(Deger)=false then
            Deger = 0
        end if
        Deger = trim(Deger)
        NoktalamaDegis = Deger
    End Function


    
    Function NoktalamaDegisMutlak(Deger)
        Deger = trim(Deger)
        if instr(Deger,",")>0 and instr(Deger,".")>0 then
            if instr(Deger,",")>instr(Deger,".") then
                Deger = replace(replace(Deger,".",""),",",".")
            else
                Deger = replace(Deger,",","")
            end if
        elseif instr(Deger,",")>0 then
            Deger = replace(Deger,",",".")
        end if
        if isnumeric(Deger)=false then
            Deger = 0
        end if
        Deger2 = Deger
        if cdbl(Deger2)<0 then
            Deger = 0
        end if
        Deger = trim(Deger)
        NoktalamaDegisMutlak = Deger
    End Function

    Function DakikadanSaatYap(Deger)

        Deger = replace(Deger, ".", ",")

        if isnumeric(Deger)=false then
            Deger = 0
        end if

        hours = Deger \ 60
        minutes = Deger mod 60

        eldeki_saat = hours
        eldeki_dakika = minutes

        if cint(eldeki_saat)<10 then
            eldeki_saat = "0" & cint(eldeki_saat)
        end if
        if cint(eldeki_dakika)<10 then
            eldeki_dakika = "0" & cint(eldeki_dakika)
        end if
        DakikadanSaatYap = eldeki_saat & ":" & eldeki_dakika
    End Function

    function toHourMin(minutes)

        minutes = replace(minutes, ".", ",")

        if isnumeric(minutes)=false then
            minutes = 0
        end if

        hours = minutes \ 60
        minutes = minutes mod 60

        eldeki_saat = hours
        eldeki_dakika = minutes

        if cint(eldeki_saat)<10 then
            eldeki_saat = "0" & cint(eldeki_saat)
        end if
        if cint(eldeki_dakika)<10 then
            eldeki_dakika = "0" & cint(eldeki_dakika)
        end if
        toHourMin = eldeki_saat & ":" & eldeki_dakika


    end function

    function iif(condition, truepart, falsepart)
        if condition then
            iif = truepart
        else
            iif = falsepart
        end if
    end function



    Function GETHTTPXML(adres, strMesaj) 
	    Set StrHTTP = Server.CreateObject("MSXML2.XMLHTTP")
		    StrHTTP.Open "POST" , adres, false 
            StrHTTP.setRequestHeader "Content-type:","text/xml"
		    StrHTTP.sEnd strMesaj
		    GETHTTPXML = StrHTTP.Responsetext 
	    Set StrHTTP = Nothing 
    End Function 

    Function NetGSM_SMS(numara, mesaj)

        xml ="<?xml version='1.0' encoding='UTF-8'?>" & _
        "<mainbody>" & _
        "<header>" & _
        "<company>NETGSM</company>" & _
        "<usercode>8508406149</usercode>" & _
        "<password>W3KF5XRT</password>" & _
        "<startdate></startdate>" & _
        "<stopdate></stopdate>" & _
        "<type>1:n</type>" & _
        "<msgheader>ESOTOMASYON</msgheader>" & _
        "</header>" & _
        "<body>" & _
        "<msg><![CDATA[" & mesaj & "]]></msg>" & _
        "<no>"& numara &"</no>" & _
        "</body>" & _
        "</mainbody>"

        cevap = GETHTTPXML("http://api.netgsm.com.tr/xmlbulkhttppost.asp",xml)

        'Response.Write cevap

    End Function



Function RelativeTime(dt)

        Dim t_SECOND : t_SECOND = 1
        Dim t_MINUTE : t_MINUTE = 60 * t_SECOND
        Dim t_HOUR : t_HOUR = 60 * t_MINUTE
        Dim t_DAY : t_DAY = 24 * t_HOUR
        Dim t_MONTH : t_MONTH = 30 * t_DAY

        Dim delta : delta = DateDiff("s", dt, Now)

        Dim strTime : strTime = ""
        If (delta < 1 * t_MINUTE) Then
            If delta = 0 Then
                strTime = "henüz"
            ElseIf delta = 1 Then
                strTime = "bir saniye önce"
            Else
                strTime = delta & " saniyeler önce"
            End If
        ElseIf (delta < 2 * t_MINUTE) Then
          strTime = "1 dakika önce"
        ElseIf (delta < 50 * t_MINUTE) Then
          strTime =Round(delta / t_MINUTE) & " dakika önce"
        ElseIf (delta < 90 * t_MINUTE) Then
          strTime = "1 saat önce"
        ElseIf (delta < 24 * t_HOUR) Then
          strTime = Round(delta / t_HOUR) & " saat önce"
        ElseIf (delta < 48 * t_HOUR) Then
          strTime = "dün"
        ElseIf (delta < 30 * t_DAY) Then
         strTime = Round(delta / t_DAY) & " gün önce"
        ElseIf (delta < 12 * t_MONTH) Then
            Dim months
            months = Round(delta / t_MONTH)
            If months <= 1 Then
                strTime = "1 ay önce"
            Else
                strTime = months & " ay önce"
            End If
        Else
            Dim years : years = Round((delta / t_DAY) / 365)
            If years <= 1 Then
                strTime = "1 yıl önce"
            Else
                strTime = years & " yıl önce"
            End If
        End If
        RelativeTime = strTime

    End Function

%>