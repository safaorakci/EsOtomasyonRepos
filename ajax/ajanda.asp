<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    Response.Clear()
%> <%

        etiket = trn(request("etiket"))
        etiket_id = trn(request("etiket_id"))
        baslangic = left(trn(request("start")),10)
        bitis = left(trn(request("end")),10)
        kelime = trn(request("kelime"))

        baslangic = cdate(right(baslangic, 2) & "." & mid(baslangic, 6,2) & "." & left(baslangic, 4))
        bitis = cdate(right(bitis, 2) & "." & mid(bitis, 6,2) & "." & left(bitis, 4))

        if trn(request("gunluk"))="true"  then
            ' baslangic = cdate(date)
        end if

        kelime_str = ""
        if len(kelime)>0 then
            kelime_str = " and (olay.title like '%"& kelime &"%' or olay.description like '%"& kelime &"%' or isnull(etiket.adi,'') like '%"& kelime &"%')"
        end if

        if trn(request("gunluk"))="true" then
            gunluk_str = " and isnull(olay.tamamlandi, '0')=0"
        end if
    
        if etiket = "proje" then
            SQL="select baslangic, bitis, baslangic_saati, bitis_saati, olay.id, tamamlandi, STRING_ESCAPE(title, 'json') as title, allDay, color from ahtapot_ajanda_olay_listesi olay left join etiketler etiket on (SELECT COUNT(value) FROM STRING_SPLIT(olay.etiketler, ',') WHERE value =  etiket.sorgu ) > 0 where ((olay.etiket = '"& etiket &"' and olay.etiket_id = '"& etiket_id &"') or ( (SELECT COUNT(value) FROM STRING_SPLIT(olay.etiketler, ',') WHERE value =  'proje-"& etiket_id &"' ) > 0)) "& gunluk_str &" and olay.cop = 'false'"& kelime_str &" and ((olay.baslangic between CONVERT(date, '"& cdate(baslangic) &"', 103) and CONVERT(date, '"& cdate(bitis) &"', 103) or olay.bitis between CONVERT(date, '"& cdate(baslangic) &"', 103) and CONVERT(date, '"& cdate(bitis) &"', 103)) or NOT (olay.baslangic >= CONVERT(date, '"& baslangic &"', 103) OR olay.bitis <=  CONVERT(date, '"& biris &"', 103))) group by baslangic, bitis, baslangic_saati, bitis_saati, olay.id, tamamlandi, title, allDay, color order by olay.baslangic asc"
        else
            SQL="select baslangic, bitis, baslangic_saati, bitis_saati, olay.id, tamamlandi, STRING_ESCAPE(title, 'json') as title, case when allDay=0 then 'False' else 'True' end as allDay, color from ahtapot_ajanda_olay_listesi olay left join etiketler etiket on (SELECT COUNT(value) FROM STRING_SPLIT(olay.etiketler, ',') WHERE value =  etiket.sorgu ) > 0 where  olay.etiket = '"& etiket &"' "& gunluk_str &" and olay.etiket_id = '"& etiket_id &"' and olay.cop = 'false'"& kelime_str &" and ((olay.baslangic between CONVERT(date, '"& cdate(baslangic) &"', 103) and CONVERT(date, '"& cdate(bitis) &"', 103) or olay.bitis between CONVERT(date, '"& cdate(baslangic) &"', 103) and CONVERT(date, '"& cdate(bitis) &"', 103)) or NOT (olay.baslangic >= CONVERT(date, '"& baslangic &"', 103) OR olay.bitis <=  CONVERT(date, '"& bitis &"', 103))) group by baslangic, bitis, baslangic_saati, bitis_saati, olay.id, tamamlandi, title, allDay, color order by olay.baslangic asc"
        end if
        set olay = baglanti.execute(SQL)

        i = 0
    Response.Write("[")
        do while not olay.eof

            baslangic = cdate(olay("baslangic"))
            if trn(request("gunluk"))="true" and cdate(olay("baslangic"))<cdate(date) then
                ' baslangic = cdate(date)
            end if

            i = i + 1
            if cdbl(i)>1 then
                Response.Write ","
            end if
            ay = month(cdate(baslangic))
            if cdbl(ay)<10 then
                ay = "0" & cint(ay)
            end if
            gun = day(cdate(baslangic))
            if cdbl(gun)<10 then
                gun = "0" & cint(gun)
            end if

            ay2 = month(cdate(olay("bitis")))
            gun2 = day(cdate(olay("bitis")))
            if cdbl(ay2)<10 then
                ay2 = "0" & cint(ay2)
            end if
            if cdbl(gun2)<10 then
                gun2 = "0" & cint(gun2)
            end if

            baslangic_saati = left(olay("baslangic_saati"),5)
            bitis_saati = left(olay("bitis_saati"),5)

            checkbox = ""
            if trn(request("gunluk"))="true" then
                checkbox = ""' "<input type='checkbox'/>"
            end if

            %>{"id": "<%=olay("id") %>","durum": "<%=olay("tamamlandi") %>","title": "<%=checkbox & Replace(trim(olay("title")), "\n", " ") %>","allDay": "<%=lcase(olay("allDay")) %>","start": "<%=year(cdate(olay("baslangic"))) %>-<%=ay %>-<%=gun & " " & baslangic_saati %>","end": "<%=year(cdate(olay("bitis"))) %>-<%=ay2 %>-<%=gun2 & " " & bitis_saati %>","url": "","color": "<%=olay("color") %>","description": "<%=Replace(trim(olay("title")), "\n", " ") %>"}<%
    olay.movenext
    loop
                Response.Write("]")
%>
