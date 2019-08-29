<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    firma_id = trn(request("firma_id"))
%>
<html lang="tr">
<head>
    <title><%=LNG("Departmanlardaki İş Hacmi Raporu")%></title>
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
            <td style="vertical-align: top; text-align: left; line-height:20px;">
                <h2><%=LNG("DEPARTMANLARDAKİ İŞ HACMİ RAPORU")%></h2>
                <span><%=LNG("Oluşturma Tarihi")%>&nbsp;:&nbsp;<%=now %></span></td>
            <td style="vertical-align: top; text-align: right;">
                <img src="/images/proskop_buyuk2_form.png" /></td>
        </tr>
    </table>
    <div><br /><br />
        <table class="table" width="100%" style="width: 100%; font-family:Arial; font-size:12px;">
            <thead>
                <tr>
                    <th style="padding: 10px; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("DEPARTMAN")%></th>
                    <th style="padding: 10px; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("İŞ HACMİ")%></th>
                    <th style="padding: 10px; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"></th>
                </tr>
            </thead>
            <tbody>
                <%
                        SQL="SELECT ROW_NUMBER() OVER (ORDER BY departman.id ASC) AS rowid, 0 AS santiye_sayi, departman.id, departman.departman_adi, departman.departman_tipi, departman.sirano, ( SELECT COUNT(id) FROM ucgem_is_listesi WHERE durum = 'true' AND cop = 'false' AND (ISNULL(tamamlanma_orani, 0) != 100) AND (SELECT COUNT(value) FROM STRING_SPLIT(departmanlar, ',') WHERE value = 'departman-' + CONVERT(NVARCHAR(10), departman.id)) > 0 ) + ( SELECT COUNT(id) FROM ucgem_proje_olay_listesi olay WHERE olay.departman_id = departman.id AND olay.durum = 'true' AND olay.cop = 'false' ) AS gosterge_sayisi, ( SELECT COUNT(id) FROM ucgem_is_listesi WHERE durum = 'true' AND cop = 'false' ) + ( SELECT COUNT(id) FROM ucgem_proje_olay_listesi olay WHERE olay.durum = 'true' AND olay.cop = 'false' ) AS tum_sayi FROM tanimlama_departman_listesi departman LEFT JOIN ucgem_firma_kullanici_listesi kullanici ON (SELECT COUNT(value) FROM STRING_SPLIT(kullanici.departmanlar, ',') WHERE value = departman.id) > 0 WHERE departman.firma_id = '"& firma_id &"' AND departman.durum = 'true' AND departman.cop = 'false'  GROUP BY departman.id, departman.departman_adi, departman.departman_tipi, departman.sirano ORDER BY  gosterge_sayisi desc;"
                        set sayilar = baglanti.execute(SQL)

                        en_yuksek = 0
                        do while not sayilar.eof
                            if cdbl(en_yuksek) < cdbl(sayilar("gosterge_sayisi")) then
                                en_yuksek = cdbl(sayilar("gosterge_sayisi"))
                            end if
                        sayilar.MoveNext
                        loop
                        if en_yuksek = 0 then
                            en_yuksek = 1
                        end if
                        sayilar.Movefirst

                        toplam_tutar = 0

                        do while not sayilar.eof

                            eldeki = cint((cdbl(sayilar("gosterge_sayisi"))*100) / cdbl(en_yuksek))
                            if eldeki = 0 then
                                eldeki = 0
                            end if

                            if eldeki>1 then
                                eldeki = eldeki 
                            end if

                            toplam_tutar = cdbl(toplam_tutar) + cdbl(sayilar("gosterge_sayisi"))
                    



                    eldeki = eldeki * 6

                    

                %>

                <tr>
                    <td style="text-align: center;padding: 10px; font-weight: bold; text-align: left;"><%=sayilar("departman_adi") %></td>
                    <td style="text-align: center;padding: 10px;"><%=sayilar("gosterge_sayisi") %></td>
                    <td style="padding: 10px;padding-left: 15px; text-align: left;">
                        <img src="/img/raporbar.png" width="<%=eldeki %>" style="width: <%=eldeki %>px; height: 20px;" /></td>
                </tr>
                <%
                        sayilar.movenext
                        loop
                %>
            </tbody>
            <tfoot>
                <tr>
                    <td style="padding: 10px; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; text-align:right; background-color: #e9ecef!important;"><strong><%=LNG("TOPLAM :")%> </strong></td>
                    <td style="padding: 10px; text-align:center; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=toplam_tutar %></td>
                    <td style="padding: 10px; text-align:center; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"></td>
                </tr>
            </tfoot>
        </table>
    </div>
</body>
</html>
