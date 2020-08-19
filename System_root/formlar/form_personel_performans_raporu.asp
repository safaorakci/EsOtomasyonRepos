<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    FirmaID = Request.Cookies("kullanici")("firma_id")
%>
<html lang="tr">
<head>
    <title><%=LNG("Personel Performans Raporu")%></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style>
        body {
            font-family: Arial;
        }
    </style>
</head>
<body>
    <table style="width: 100%;">
        <tr>
            <td style="vertical-align: top; text-align: left; line-height: 20px;">
                <h2><%=LNG("PERSONEL PERFORMANS RAPORU")%></h2>
                <span><%=LNG("Oluşturma Tarihi")%>&nbsp;:&nbsp;<%=now %></span></td>
            <td style="vertical-align: top; text-align: right;">
                <img src="/images/proskop_buyuk2_form.png" /></td>
        </tr>
    </table>
    <div>
        <br />
        <br />
        <%
            
        baslangic_tarihi = trn(request("baslangic_tarihi"))
        bitis_tarihi = trn(request("bitis_tarihi"))
        rapor_personel_id = trn(request("rapor_personel_id"))
        etiketler = trn(request("etiketler"))
        yeni_is_yuku_proje_id = trn(request("yeni_is_yuku_proje_id"))
        fid = trn(request("fid"))
        kid = trn(request("kid"))

        %>

        <table style="width:100%; " width="100%">
            <tr>
                <td>
            <h3><%=LNG("DEPARTMANLARA HARCANAN SÜRE")%></h3>


            <%

                                    if isdate(baslangic_tarihi)=true and isdate(bitis_tarihi)=true then
                                        tarih_str = " AND (('"& baslangic_tarihi &"' BETWEEN olay.baslangic AND olay.bitis) OR ('"& bitis_tarihi &"' BETWEEN olay.baslangic AND olay.bitis))"
                                    elseif isdate(baslangic_tarihi)=true then
                                        tarih_str = " AND olay.baslangic<='"& baslangic_tarihi &"'"
                                    elseif isdate(bitis_tarihi)=true then
                                        tarih_str = " AND olay.bitis>='"& bitis_tarihi &"'"
                                    end if

                                    if not trim(rapor_personel_id)="0" then
                                        kullanici_str = " and kullanici.id = '"& rapor_personel_id &"'"
                                        kullanici_str2 = " and olay.etiket = 'personel' AND olay.etiket_id = '"& rapor_personel_id &"'"
                                    end if

                                    if not trim(etiketler)="0" then
                                        etiket_str = " AND (SELECT COUNT(value) FROM STRING_SPLIT(olay.etiketler, ',') WHERE value = '"& etiketler &"') > 0"
                                        etiket_str2 = " AND departman.id = '"& split(etiketler, "-")(1) &"'"
                                    end if

                                    if not trim(yeni_is_yuku_proje_id)="0" then
                                        proje_str = " AND (SELECT COUNT(value) FROM STRING_SPLIT(olay.etiketler, ',') WHERE value = 'proje-"& yeni_is_yuku_proje_id &"') > 0"
                                    end if

                                  SQL="SELECT departman.departman_adi, dbo.DakikadanSaatYap((SELECT ISNULL(SUM((DATEDIFF(n, CONVERT(DATETIME, olay.baslangic) + CONVERT(DATETIME, olay.baslangic_saati), CONVERT(DATETIME, olay.bitis) + CONVERT(DATETIME, olay.bitis_saati) ) ) ), 0 ) FROM dbo.ahtapot_ajanda_olay_listesi olay WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT(olay.etiketler, ',') WHERE value = 'departman-' + CONVERT(NVARCHAR(50), departman.id)) > 0"& kullanici_str2 &  tarih_str & etiket_str & proje_str &" AND olay.durum = 'true' AND olay.cop = 'false' and olay.firma_id = '"& FirmaID &"')) AS gosterge_sayisi, ((SELECT ISNULL(SUM((DATEDIFF(n, CONVERT(DATETIME, olay.baslangic) + CONVERT(DATETIME, olay.baslangic_saati), CONVERT(DATETIME, olay.bitis) + CONVERT(DATETIME, olay.bitis_saati)))), 0) FROM dbo.ahtapot_ajanda_olay_listesi olay WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT(olay.etiketler, ',') WHERE value = 'departman-' + CONVERT(NVARCHAR(50), departman.id)) > 0"& kullanici_str2 & tarih_str & etiket_str & proje_str &" AND olay.durum = 'true' AND olay.cop = 'false' and olay.firma_id = '"& FirmaID &"')) AS gosterge_sayisi2 FROM dbo.ucgem_firma_kullanici_listesi kullanici JOIN dbo.tanimlama_departman_listesi departman ON departman.firma_id = kullanici.firma_id "& etiket_str2 &" AND departman.cop = 'false' AND departman.durum = 'true' WHERE kullanici.firma_id = '"& fid &"' "& kullanici_str &" AND ( ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT(DATETIME, olay.baslangic) + CONVERT(DATETIME, olay.baslangic_saati), CONVERT(DATETIME, olay.bitis) + CONVERT(DATETIME, olay.bitis_saati) ) ) ), 0 ) FROM dbo.ahtapot_ajanda_olay_listesi olay WITH (NOLOCK) WHERE olay.etiket = 'personel' AND olay.etiket_id = kullanici.id AND (SELECT COUNT(value) FROM STRING_SPLIT(olay.etiketler, ',') WHERE value = 'departman-' + CONVERT(NVARCHAR(50), departman.id)) > 0"& tarih_str & etiket_str & proje_str &" AND olay.durum = 'true' AND olay.cop = 'false' ) ) > 0 GROUP BY departman.departman_adi, departman.id;"
                                set sayilar = baglanti.execute(SQL)

            %>


            <table class="table" width="100%" style="width: 100%;">
                <thead>
                    <tr>
                        <th style="color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px; text-align:left; height:25px;"><%=LNG("DEPARTMAN")%></th>
                        <th style="color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px; "><%=LNG("SAAT")%></th>
                        <th style="color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px; "></th>
                    </tr>
                </thead>
                <tbody>
                    <%

                        en_yuksek = 0
                                            girdimi = false
                        do while not sayilar.eof
                                            girdimi = true
                            if cdbl(en_yuksek) < cdbl(sayilar("gosterge_sayisi2")) then
                                en_yuksek = cdbl(sayilar("gosterge_sayisi2"))
                            end if
                        sayilar.MoveNext
                        loop
                        if en_yuksek = 0 then
                            en_yuksek = 1
                        end if
                                            if girdimi then
                        sayilar.Movefirst
                                            end if

                        toplam_tutar = 0
                                            if sayilar.eof then
                    %>
                    <tr>
                        <td colspan="3" style="text-align: center; height:25px;"><%=LNG("Kayıt Yok")%></td>
                    </tr>
                    <%
                                            end if

        do while not sayilar.eof


                            eldeki = cint((cdbl(sayilar("gosterge_sayisi2"))*100) / cdbl(en_yuksek))
                            if eldeki = 0 then
                                eldeki = 1
                            end if

                            if eldeki>1 then
                                eldeki = eldeki 
                            end if

                            toplam_tutar = cdbl(toplam_tutar) + cdbl(sayilar("gosterge_sayisi2"))

                            eldeki = eldeki * 5
                    %>

                    <tr>
                        <td style="text-align: center; text-align: left; height:25px;"><%=sayilar("departman_adi") %></td>
                        <td style="text-align: center;"><%=sayilar("gosterge_sayisi") %></td>
                        <td style="padding-left: 15px; text-align: left;">
                            <img src="/img/raporbar.png" width="<%=eldeki %>" style="width: <%=eldeki %>px; height: 20px;" /></td>
                    </tr>
                    <%
        sayilar.movenext
        loop
                    %>
                </tbody>
                <tfoot>
                    <tr>
                        <td style="text-align: right; height:25px;"><strong><%=LNG("TOPLAM:")%> </strong></td>
                        <td style="text-align: center;"><%=DakikadanSaatYap(toplam_tutar) %></td>
                        <td></td>
                    </tr>
                </tfoot>
            </table>
        </td>
            </tr>
        </table>
        <br />
         <br />
        <hr />
         <br /> <br />
            <h3><%=LNG("PROJELERE HARCANAN SÜRE")%></h3>



            <%

                                    if isdate(baslangic_tarihi)=true and isdate(bitis_tarihi)=true then
                                        tarih_str = " AND (('"& baslangic_tarihi &"' BETWEEN olay.baslangic AND olay.bitis) OR ('"& bitis_tarihi &"' BETWEEN olay.baslangic AND olay.bitis))"
                                    elseif isdate(baslangic_tarihi)=true then
                                        tarih_str = " AND olay.baslangic<='"& baslangic_tarihi &"'"
                                    elseif isdate(bitis_tarihi)=true then
                                        tarih_str = " AND olay.bitis>='"& bitis_tarihi &"'"
                                    end if

                                    if not trim(rapor_personel_id)="0" then
                                        kullanici_str = " and kullanici.id = '"& rapor_personel_id &"'"
                                        kullanici_str2 = " and olay.etiket = 'personel' AND olay.etiket_id = '"& rapor_personel_id &"'"
                                    end if

                                    if not trim(etiketler)="0" then
                                        etiket_str = " AND (SELECT COUNT(value) FROM STRING_SPLIT(olay.etiketler, ',') WHERE value = '"& etiketler &"') > 0"
                                    end if

                                    if not trim(yeni_is_yuku_proje_id)="0" then
                                        proje_str = " AND proje.id = '"& yeni_is_yuku_proje_id &"'"
                                    end if

                                  

                                    SQL="SELECT proje.proje_adi, dbo.DakikadanSaatYap( ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT(DATETIME, olay.baslangic) + CONVERT(DATETIME, olay.baslangic_saati), CONVERT(DATETIME, olay.bitis) + CONVERT(DATETIME, olay.bitis_saati) ) ) ), 0 ) FROM dbo.ahtapot_ajanda_olay_listesi olay WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT(olay.etiketler, ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(50), proje.id)) > 0 AND olay.durum = 'true' AND olay.cop = 'false'"& kullanici_str2 &  tarih_str & etiket_str &" ) ) AS gosterge_sayisi, ( ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT(DATETIME, olay.baslangic) + CONVERT(DATETIME, olay.baslangic_saati), CONVERT(DATETIME, olay.bitis) + CONVERT(DATETIME, olay.bitis_saati) ) ) ), 0 ) FROM dbo.ahtapot_ajanda_olay_listesi olay WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT(olay.etiketler, ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(50), proje.id)) > 0 AND olay.durum = 'true' AND olay.cop = 'false'"& kullanici_str2 &  tarih_str & etiket_str &" ) ) AS gosterge_sayisi2 FROM dbo.ucgem_proje_listesi proje where proje.firma_id = '"& fid &"' "& proje_str  &" AND proje.cop = 'false' AND proje.durum = 'true' AND ( ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT(DATETIME, olay.baslangic) + CONVERT(DATETIME, olay.baslangic_saati), CONVERT(DATETIME, olay.bitis) + CONVERT(DATETIME, olay.bitis_saati) ) ) ), 0 ) FROM dbo.ahtapot_ajanda_olay_listesi olay WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT(olay.etiketler, ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(50), proje.id)) > 0 AND olay.durum = 'true' AND olay.cop = 'false'"& kullanici_str2 &  tarih_str & etiket_str &" ) ) > 0 GROUP BY proje.proje_adi, proje.id;"
                                    set sayilar = baglanti.execute(SQL)

            %>


            <table class="table" width="100%" style="width: 100%;">
                <thead>
                    <tr>
                        <th style="color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px; text-align:left; height:25px;"><%=LNG("DEPARTMAN")%></th>
                        <th style="color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px; "><%=LNG("SAAT")%></th>
                        <th style="color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px; "></th>
                    </tr>
                </thead>
                <tbody>
                    <%

                        en_yuksek = 0
                        girdimi = false
                        do while not sayilar.eof
                            girdimi = true
                            if cdbl(en_yuksek) < cdbl(sayilar("gosterge_sayisi2")) then
                                en_yuksek = cdbl(sayilar("gosterge_sayisi2"))
                            end if
                        sayilar.MoveNext
                        loop
                        if en_yuksek = 0 then
                            en_yuksek = 1
                        end if
                            if girdimi then
                                sayilar.Movefirst
                            end if

                        toplam_tutar = 0

                        if sayilar.eof then
                    %>
                    <tr>
                        <td colspan="3" style="text-align: center; height:25px;"><%=LNG("Kayıt Yok")%></td>
                    </tr>
                    <%
                        end if

        do while not sayilar.eof


                            eldeki = cint((cdbl(sayilar("gosterge_sayisi2"))*100) / cdbl(en_yuksek))
                            if eldeki = 0 then
                                eldeki = 1
                            end if

                            if eldeki>1 then
                                eldeki = eldeki 
                            end if

                            toplam_tutar = cdbl(toplam_tutar) + cdbl(sayilar("gosterge_sayisi2"))


                        eldeki = eldeki * 5
                    %>

                    <tr>
                        <td style="text-align: center; text-align: left; height:25px;"><%=sayilar("proje_adi") %></td>
                        <td style="text-align: center;"><%=sayilar("gosterge_sayisi") %></td>
                        <td style="padding-left: 15px; text-align: left;">
                            <img src="/img/raporbar.png" width="<%=eldeki %>" style="width: <%=eldeki %>px; height: 20px;" /></td>
                    </tr>
                    <%
        sayilar.movenext
        loop
                    %>
                </tbody>
                <tfoot>
                    <tr>
                        <td style="text-align: right; height:25px;"><strong><%=LNG("TOPLAM:")%> </strong></td>
                        <td style="text-align: center;"><%=DakikadanSaatYap(toplam_tutar) %></td>
                        <td></td>
                    </tr>
                </tfoot>
            </table>
        <br /> <br />

        <hr />
         <br /> <br />
            <h3><%=LNG("PROJELERE GÖRE İŞ DAĞILIMI")%></h3>


            <%

        if isdate(baslangic_tarihi)=true and isdate(bitis_tarihi)=true then
            tarih_str = " AND (('"& baslangic_tarihi &"' BETWEEN iss.baslangic_tarihi AND iss.bitis_tarihi) OR ('"& bitis_tarihi &"' BETWEEN iss.baslangic_tarihi AND iss.bitis_tarihi))"
        elseif isdate(baslangic_tarihi)=true then
            tarih_str = " AND iss.baslangic_tarihi<='"& baslangic_tarihi &"'"
        elseif isdate(bitis_tarihi)=true then
            tarih_str = " AND iss.bitis_tarihi>='"& bitis_tarihi &"'"
        end if

        if not trim(rapor_personel_id)="0" then
            kullanici_str = " AND durum.gorevli_id = '"& rapor_personel_id &"'"
            kullanici_str2 = " and olay.etiket = 'personel' AND olay.etiket_id = '"& rapor_personel_id &"'"
        end if

        if not trim(etiketler)="0" then
            etiket_str = " AND (SELECT COUNT(value) FROM STRING_SPLIT(iss.departmanlar, ',') WHERE value = '"& etiketler &"') > 0"
        end if

        if not trim(yeni_is_yuku_proje_id)="0" then
            proje_str = " AND proje.id = '"& yeni_is_yuku_proje_id &"'"
        end if


      SQL="SELECT ROW_NUMBER() OVER (ORDER BY proje.id ASC) AS rowid, 0 AS santiye_sayi, proje.id, proje.proje_adi, ( SELECT COUNT(iss.id) FROM ucgem_is_listesi iss JOIN dbo.ucgem_is_gorevli_durumlari durum ON durum.is_id = iss.id "& kullanici_str &" WHERE iss.durum = 'true' AND iss.cop = 'false' AND (SELECT COUNT(value) FROM STRING_SPLIT(iss.departmanlar, ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(10), proje.id)) > 0 "& tarih_str & etiket_str &" ) AS gosterge_sayisi, ( SELECT COUNT(id) FROM ucgem_is_listesi WHERE durum = 'true' AND cop = 'false' AND firma_id = proje.firma_id ) AS tum_sayi FROM dbo.ucgem_proje_listesi proje WHERE proje.firma_id = '"& fid &"' "& proje_str &" AND proje.durum = 'true' AND proje.cop = 'false' AND ( SELECT COUNT(iss.id) FROM ucgem_is_listesi iss JOIN dbo.ucgem_is_gorevli_durumlari durum ON durum.is_id = iss.id "& kullanici_str &" WHERE iss.durum = 'true' AND iss.cop = 'false' and durum.firma_id = '"& fid &"' AND (SELECT COUNT(value) FROM STRING_SPLIT(iss.departmanlar, ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(10), proje.id)) > 0 "& tarih_str & etiket_str &" ) > 0 GROUP BY proje.id, proje.proje_adi, proje.firma_id ORDER BY proje.proje_adi ASC;"
        set sayilar = baglanti.execute(SQL)

            %>


            <table class="table" width="100%" style="width: 100%;">
                <thead>
                    <tr>
                        <th style="color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px;height:25px; text-align:left;"><%=LNG("DEPARTMAN")%></th>
                        <th style="color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px; "><%=LNG("İŞ SAYISI")%></th>
                        <th style="color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px; "></th>
                    </tr>
                </thead>
                <tbody>
                    <%

                        en_yuksek = 0
                        varmi = false
                        do while not sayilar.eof
                            varmi = true
                            if cdbl(en_yuksek) < cdbl(sayilar("gosterge_sayisi")) then
                                en_yuksek = cdbl(sayilar("gosterge_sayisi"))
                            end if
                        sayilar.MoveNext
                        loop
                        if en_yuksek = 0 then
                            en_yuksek = 1
                        end if
                        if varmi then
                            sayilar.Movefirst
                        end if

                        toplam_tutar = 0

                        if sayilar.eof then
                        %>
                    <tr>
                        <td colspan="3" style="text-align:center; height:25px;"><%=LNG("Kayıt Yok")%></td>
                    </tr>
                    <%
                        end if

        do while not sayilar.eof


                            eldeki = cint((cdbl(sayilar("gosterge_sayisi"))*100) / cdbl(en_yuksek))
                            if eldeki = 0 then
                                eldeki = 1
                            end if

                            if eldeki>1 then
                                eldeki = eldeki 
                            end if

                            toplam_tutar = cdbl(toplam_tutar) + cdbl(sayilar("gosterge_sayisi"))

                        eldeki = eldeki * 5
                    %>

                    <tr>
                        <td style="text-align: center; text-align: left;height:25px;"><%=sayilar("proje_adi") %></td>
                        <td style="text-align: center;height:25px;"><%=sayilar("gosterge_sayisi") %></td>
                        <td style="padding-left: 15px; text-align: left; height:25px;">
                            <img src="/img/raporbar.png" width="<%=eldeki %>" style="width: <%=eldeki %>px; height: 20px;" /></td>
                    </tr>
                    <%
        sayilar.movenext
        loop
                    %>
                </tbody>
                <tfoot>
                    <tr>
                        <td style="text-align: right; height:25px;"><strong><%=LNG("TOPLAM:")%> </strong></td>
                        <td style="text-align: center;height:25px;"><%=toplam_tutar %></td>
                        <td></td>
                    </tr>
                </tfoot>
            </table>
         <br /> <br />
        <hr />
         <br /> <br />
        <%

        if isdate(baslangic_tarihi)=true and isdate(bitis_tarihi)=true then
            tarih_str = " AND (('"& baslangic_tarihi &"' BETWEEN iss.baslangic_tarihi AND iss.bitis_tarihi) OR ('"& bitis_tarihi &"' BETWEEN iss.baslangic_tarihi AND iss.bitis_tarihi))"
        elseif isdate(baslangic_tarihi)=true then
            tarih_str = " AND iss.baslangic_tarihi<='"& baslangic_tarihi &"'"
        elseif isdate(bitis_tarihi)=true then
            tarih_str = " AND iss.bitis_tarihi>='"& bitis_tarihi &"'"
        end if

        if not trim(rapor_personel_id)="0" then
            kullanici_str = " AND durum.gorevli_id = '"& rapor_personel_id &"'"
        end if

        if not trim(etiketler)="0" then
            etiket_str = "AND (SELECT COUNT(value) FROM STRING_SPLIT(iss.departmanlar, ',') WHERE value = 'departman-"& etiketler &"') > 0"
        end if

        if not trim(yeni_is_yuku_proje_id)="0" then
            proje_str = "AND (SELECT COUNT(value) FROM STRING_SPLIT(iss.departmanlar, ',') WHERE value = 'proje-"& yeni_is_yuku_proje_id &"') > 0"
        end if


    SQL="SELECT ROW_NUMBER() OVER (ORDER BY departman.id ASC) AS rowid, 0 AS santiye_sayi, departman.id, departman.departman_adi, departman.departman_tipi, departman.sirano, ( SELECT COUNT(iss.id) FROM ucgem_is_listesi iss JOIN dbo.ucgem_is_gorevli_durumlari durum ON durum.is_id = iss.id WHERE iss.durum = 'true' AND iss.cop = 'false' AND (ISNULL(iss.tamamlanma_orani, 0) != 100) AND (SELECT COUNT(value) FROM STRING_SPLIT(iss.departmanlar, ',') WHERE value = 'departman-' + CONVERT(NVARCHAR(10), departman.id)) > 0 "& etiket_str & tarih_str & kullanici_str & proje_str &" ) AS gosterge_sayisi FROM tanimlama_departman_listesi departman WHERE departman.firma_id = '"& fid &"' AND departman.durum = 'true' AND departman.cop = 'false' AND ( SELECT COUNT(iss.id) FROM ucgem_is_listesi iss JOIN dbo.ucgem_is_gorevli_durumlari durum ON durum.is_id = iss.id WHERE iss.durum = 'true' and iss.cop = 'false' and durum.firma_id = '"& fid &"' and iss.firma_id = '"& FirmaID &"' AND (ISNULL(iss.tamamlanma_orani, 0) != 100) AND (SELECT COUNT(value) FROM STRING_SPLIT(iss.departmanlar, ',') WHERE value = 'departman-' + CONVERT(NVARCHAR(10), departman.id)) > 0 "& etiket_str &  tarih_str & kullanici_str & proje_str &" )>0 GROUP BY departman.id, departman.departman_adi, departman.departman_tipi, departman.sirano, departman.firma_id ORDER BY departman.departman_adi asc;"
    set sayilar = baglanti.execute(SQL)

        %>

        
            <h3><%=LNG("ETİKETLERE GÖRE İŞ DAĞILIMI")%></h3>

            <br />
            <table class="table" width="100%" style="width: 100%;">
                <thead>
                    <tr>
                        <th style="color: #495057; text-align:left; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px;height:25px;"><%=LNG("DEPARTMAN")%></th>
                        <th style="color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px; "><%=LNG("İŞ SAYISI")%></th>
                        <th style="color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px; "></th>
                    </tr>
                </thead>
                <tbody>
                    <%

                        en_yuksek = 0
                                        girdimi = false
                        do while not sayilar.eof
                                        girdimi = true
                            if cdbl(en_yuksek) < cdbl(sayilar("gosterge_sayisi")) then
                                en_yuksek = cdbl(sayilar("gosterge_sayisi"))
                            end if
                        sayilar.MoveNext
                        loop
                        if en_yuksek = 0 then
                            en_yuksek = 1
                        end if
                                        if girdimi then
                        sayilar.Movefirst
                                        end if

                        toplam_tutar = 0

                        if sayilar.eof then
                    %>
                    <tr>
                        <td colspan="3" style="text-align: center;height:25px;"><%=LNG("Kayıt Yok")%></td>
                    </tr>
                    <%
                        end if

        do while not sayilar.eof


                            eldeki = cint((cdbl(sayilar("gosterge_sayisi"))*100) / cdbl(en_yuksek))
                            if eldeki = 0 then
                                eldeki = 1
                            end if

                            if eldeki>1 then
                                eldeki = eldeki 
                            end if

                            toplam_tutar = cdbl(toplam_tutar) + cdbl(sayilar("gosterge_sayisi"))

                        eldeki = eldeki * 5
                    %>

                    <tr>
                        <td style="text-align: center; height:25px;text-align: left;"><%=sayilar("departman_adi") %></td>
                        <td style="text-align: center;"><%=sayilar("gosterge_sayisi") %></td>
                        <td style="padding-left: 15px; text-align: left;">
                            <img src="/img/raporbar.png" width="<%=eldeki %>" style="width: <%=eldeki %>px; height: 20px;" /></td>
                    </tr>
                    <%
        sayilar.movenext
        loop
                    %>
                </tbody>
                <tfoot>
                    <tr>
                        <td style="text-align: right; height:25px;"><strong><%=LNG("TOPLAM:")%> </strong></td>
                        <td style="text-align: center;"><%=toplam_tutar %></td>
                        <td></td>
                    </tr>
                </tfoot>
            </table>
        

    </div>
</body>
</html>
