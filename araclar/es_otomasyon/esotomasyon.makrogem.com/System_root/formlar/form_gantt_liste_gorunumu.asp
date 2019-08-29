<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    

    firma_id = trn(request("firma_id"))
    kullanici_id = trn(request("kullanici_id"))
    proje_id = trn(request("proje_id"))
    tip = trn(request("tip"))

        atip_str = "PLANLAMA"
        if trim(tip) = "uygulama" then
            atip_str = "UYGULAMA"
        end if

        tip_str = ""
        ters_str = "_uygulama"
        if tip = "uygulama" then
            tip_str = "_uygulama"
            ters_str = ""
        end if

%>
<html lang="tr">
<head>
    <title><%=LNG("Proje Liste Görünümü")%></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style>
        body {
            font-family: Arial;
            text-align: left;
        }

        table {
            text-align: left;
        }
    </style>
</head>
<body>
    <table style="width: 100%;">
        <tr>
            <td style="vertical-align: top; text-align: left; line-height: 20px;">
                <h2><%=atip_str %> RAPORU</h2>
                <span><%=LNG("Oluşturma Tarihi :")%> <%=now %></span></td>
            <td style="vertical-align: top; text-align: right;">
                <img src="/images/proskop_buyuk2_form.png" /></td>
        </tr>
    </table>
    <div>
        <br />
        <br />

        <div style="margin: 4%; margin-top: 10px;">
        <table class="table " style="border: solid 1px #ccc; width:100%;" cellpadding="0" cellspacing="0" border="1">
            <tbody>
                <%
                    SQL="select * from ahtapot_proje_gantt_adimlari where proje_id = '"& proje_id &"' and cop = 'false'"
                    set adim = baglanti.execute(SQL)
                    do while not adim.eof
                %>
                <tr class="ictenustunegelince">
                    <% if cdbl(adim("ilevel"))=0 then %>
                    <td colspan="6"  style="padding: 10px; height:40px; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><i class="fa fa-sort-desc"></i><%=ucase(ucase(adim("name"))) %></td>
                    <% elseif cdbl(adim("ilevel"))=1 then %>
                    <td style="padding-left: <%=cint(adim("ilevel"))*30%>px!important; font-weight: bold; height:40px;"><i class="fa fa-sort-desc"></i> <%=ucase(adim("name") )%></td>
                    <td style="text-align:center;"><strong><%=LNG("Süre")%></strong></td>
                    <td style="width: 150px; padding-right: 30px!important; text-align:left; padding-left:15px;">
                        
                        <table>
                            <tr>
                                <td style="width:50px;"><%=adim("progress") %>% </td>
                                <td><img src="/img/raporbar.png" width="<%=adim("progress")*2 %>" style="width: <%=adim("progress")*2 %>px; height: 20px;" /></td>

                            </tr>
                        </table>
                        
                    </td>
                    <td style="text-align:center;"><strong><%=LNG("Başlangıç")%></strong></td>
                    <td style="text-align:center;"><strong><%=LNG("Bitiş")%></strong></td>

                    <td style="text-align: right;"><strong><%=LNG("Görevli Kaynaklar")%></strong></td>
                    <% elseif cdbl(adim("ilevel"))=2 then %>
                    <td style="height:40px; padding-left: <%=cint(adim("ilevel"))*30%>px!important;"><%=adim("name") %></td>
                    <td style="text-align:center;"><%=adim("duration" & tip_str) %> <%=LNG("gün")%></td>
                    <td style="width: 150px; padding-right: 30px!important; text-align:left;  padding-left:15px;">
                        <table>
                            <tr>
                                <td style="width:50px;"><%=adim("progress") %>% </td>
                                <td><img src="/img/raporbar.png" width="<%=adim("progress")*2 %>" style="width: <%=adim("progress")*2 %>px; height: 20px;" /></td>
                            </tr>
                        </table>
                    </td>
                    <td style="text-align:center;"><%=cdate(adim("start_tarih" & tip_str)) %></td>
                    <td style="text-align:center;"><%=cdate(adim("end_tarih" & tip_str)) %></td>

                    <td style="text-align: right;">Salih ŞAHİN, Safa ORAKÇI</td>
                    <% end if %>
                </tr>
                <%
                    adim.movenext
                    loop
                %>
            </tbody>
        </table>
    </div>
        <% if 1 = 2 then %>
        <fieldset visible="true" style="border: 1px solid #cccccc; padding: 15px; margin-bottom: 15px;">
            <div class="dt-responsive table-responsive">
                <table class="table " style="border: solid 1px #ccc; width:100%;" cellpadding="0" cellspacing="0" border="1">
                    <thead>
                        <tr>
                            <th style="padding: 10px; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;">ÖDEME TİPİ</th>
                            <th style="text-align: center; padding:10px; font-weight: bold; font-size: 15px; background: linear-gradient(45deg, #4099ff, #73b4ff); width: 150px;"><span class="label label-primary arkaplansiz badge-lg">TL ÖDEME</span></th>
                            <th style="padding: 10px; font-weight: bold; font-size: 15px; background: linear-gradient(45deg, #FF5370, #ff869a); width: 150px;"><span class="label label-danger arkaplansiz badge-lg ">$ ÖDEME</span></th>
                            <th style="padding: 10px; font-weight: bold; font-size: 15px; background: linear-gradient(45deg, #FFB64D, #ffcb80); width: 150px;"><span class="label label-warning arkaplansiz badge-lg">€ ÖDEME</span></th>
                            <th style="padding: 10px; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"></th>
                        </tr>
                    </thead>
                    <tbody>

                        <%
                SQL="SELECT CASE WHEN cari.alacakli_id = firma.id THEN firma.firma_adi ELSE firma2.firma_adi END AS firma_adi , CASE WHEN CONVERT(DATE, GETDATE(), 104) = cari.vade_tarihi THEN 1 WHEN cari.vade_tarihi BETWEEN DATEADD(DAY, 1, CONVERT(DATE, GETDATE(), 104)) AND DATEADD( DAY, 30, CONVERT(DATE, GETDATE(), 104) ) THEN 2 WHEN cari.vade_tarihi BETWEEN DATEADD(DAY, 31, CONVERT(DATE, GETDATE(), 104)) AND DATEADD( DAY, 60, CONVERT(DATE, GETDATE(), 104) ) THEN 3 WHEN cari.vade_tarihi BETWEEN DATEADD(DAY, 61, CONVERT(DATE, GETDATE(), 104)) AND DATEADD( DAY, 90, CONVERT(DATE, GETDATE(), 104) ) THEN 4 WHEN cari.vade_tarihi BETWEEN DATEADD(DAY, 91, CONVERT(DATE, GETDATE(), 104)) AND DATEADD( DAY, 120, CONVERT(DATE, GETDATE(), 104) ) THEN 5 WHEN cari.vade_tarihi >= DATEADD(DAY, 121, CONVERT(DATE, GETDATE(), 104)) THEN 6 END tip, cari.* FROM dbo.cari_hareketler cari LEFT JOIN dbo.ucgem_firma_listesi firma ON firma.id = cari.borclu_id LEFT JOIN dbo.ucgem_firma_listesi firma2 ON firma2.id = cari.alacakli_id WHERE cari.firma_id = '"& firma_id &"' AND cari.durum = 'true' AND cari.cop = 'false' AND cari.vade_tarihi >= CONVERT(DATE, GETDATE(), 104) AND cari.islem_tipi = 'Ödeme' ORDER BY cari.vade_tarihi DESC;"
                set cek = baglanti.execute(SQL)

                planlanmamis_tl = 0
                planlanmamis_usd = 0
                planlanmamis_eur = 0

                guncel_tl = 0
                guncel_usd = 0
                guncel_eur = 0

                otuz_tl = 0
                otuz_usd = 0
                otuz_eur = 0

                altmis_tl = 0
                altmis_usd = 0
                altmis_eur = 0

                doksan_tl = 0
                doksan_usd = 0
                doksan_eur = 0

                yuz20_tl = 0
                yuz20_usd = 0
                yuz20_eur = 0


                yuz20plus_tl = 0
                yuz20plus_usd = 0
                yuz20plus_eur = 0

                girdimi = false

                do while not cek.eof

                    girdimi = true

                    tip = trim(cek("tip"))

                    if trim(cek("parabirimi"))="TL" then

                        if trim(tip)="0" then
                            planlanmamis_tl = cdbl(planlanmamis_tl) + cdbl(cek("meblag"))
                        elseif trim(tip)="1" then
                            guncel_tl = cdbl(guncel_tl) + cdbl(cek("meblag"))
                        elseif trim(tip)="2" then
                            otuz_tl = cdbl(otuz_tl) + cdbl(cek("meblag"))
                        elseif trim(tip)="3" then
                            altmis_tl = cdbl(altmis_tl) + cdbl(cek("meblag"))
                        elseif trim(tip)="4" then
                            doksan_tl = cdbl(doksan_tl) + cdbl(cek("meblag"))
                        elseif trim(tip)="5" then
                            yuz20_tl = cdbl(yuz20_tl) + cdbl(cek("meblag"))
                        elseif trim(tip)="6" then
                            yuz20plus_tl = cdbl(yuz20plus_tl) + cdbl(cek("meblag"))
                        end if


                    elseif trim(cek("parabirimi"))="USD" then

                        if trim(tip)="0" then
                            planlanmamis_usd = cdbl(planlanmamis_usd) + cdbl(cek("meblag"))
                        elseif trim(tip)="1" then
                            guncel_usd = cdbl(guncel_usd) + cdbl(cek("meblag"))
                        elseif trim(tip)="2" then
                            otuz_usd = cdbl(otuz_usd) + cdbl(cek("meblag"))
                        elseif trim(tip)="3" then
                            altmis_usd = cdbl(altmis_usd) + cdbl(cek("meblag"))
                        elseif trim(tip)="4" then
                            doksan_usd = cdbl(doksan_usd) + cdbl(cek("meblag"))
                        elseif trim(tip)="5" then
                            yuz20_usd = cdbl(yuz20_usd) + cdbl(cek("meblag"))
                        elseif trim(tip)="6" then
                            yuz20plus_eur = cdbl(yuz20plus_eur) + cdbl(cek("meblag"))
                        end if

                    elseif trim(cek("parabirimi"))="EUR" then

                        if trim(tip)="0" then
                            planlanmamis_eur = cdbl(planlanmamis_eur) + cdbl(cek("meblag"))
                        elseif trim(tip)="1" then
                            guncel_eur = cdbl(guncel_eur) + cdbl(cek("meblag"))
                        elseif trim(tip)="2" then
                            otuz_eur = cdbl(otuz_eur) + cdbl(cek("meblag"))
                        elseif trim(tip)="3" then
                            altmis_eur = cdbl(altmis_eur) + cdbl(cek("meblag"))
                        elseif trim(tip)="4" then
                            doksan_eur = cdbl(doksan_eur) + cdbl(cek("meblag"))
                        elseif trim(tip)="5" then
                            yuz20_eur = cdbl(yuz20_eur) + cdbl(cek("meblag"))
                        elseif trim(tip)="6" then
                            yuz20plus_eur = cdbl(yuz20plus_eur) + cdbl(cek("meblag"))
                        end if

                    end if



                cek.movenext
                loop

                            eldeki = 0

                if girdimi then
                    cek.movefirst
                

                toplam_tl = planlanmamis_tl + guncel_tl + otuz_tl + altmis_tl + doksan_tl + yuz20_tl + yuz20plus_tl
                toplam_usd = planlanmamis_usd + guncel_usd + otuz_usd + altmis_usd + doksan_usd + yuz20_usd + yuz20plus_usd
                toplam_eur = planlanmamis_eur + guncel_eur + otuz_eur + altmis_eur + doksan_eur + yuz20_eur + yuz20plus_eur

                en_toplam = cdbl(toplam_tl) + cdbl(toplam_usd) + cdbl(toplam_eur)


                    eldeki = cint(((cdbl(planlanmamis_tl) + cdbl(planlanmamis_usd) + cdbl(planlanmamis_eur))*100) / cdbl(en_toplam))
                    if eldeki = 0 then
                        eldeki = 0
                    end if

                    if eldeki>1 then
                        eldeki = eldeki 
                    end if

                            eldeki1 = eldeki
                            eldeki = eldeki * 4

                            end if
                        %>
                        <tr>
                            <td style="padding:5px;">PLANLANMAMIŞ</td>
                            <td style="text-align: center; padding:5px;"><%=formatnumber(planlanmamis_tl,2) %> TL</td>
                            <td style="text-align: center; padding:5px;"><%=formatnumber(planlanmamis_usd,2) %> $</td>
                            <td style="text-align: center; padding:5px;"><%=formatnumber(planlanmamis_eur,2) %> €</td>
                            <td style=" padding:5px;"><span><%=eldeki1 %> %</span>  <img src="/img/raporbar.png" width="<%=eldeki %>" style="width: <%=eldeki%>px; height: 20px;" /></td>
                        </tr>
                        <%
                            if girdimi then
                    eldeki = cint(((cdbl(guncel_tl) + cdbl(guncel_usd) + cdbl(guncel_eur))*100) / cdbl(en_toplam))
                    if eldeki = 0 then
                        eldeki = 0
                    end if

                    if eldeki>1 then
                        eldeki = eldeki 
                    end if

                            eldeki1 = eldeki
                            eldeki = eldeki * 4
                            end if
                        %>
                        <tr>
                            <td style=" padding:5px;">GÜNCEL</td>
                            <td style="text-align: center; padding:5px;"><%=formatnumber(guncel_tl,2) %> TL</td>
                            <td style="text-align: center; padding:5px;"><%=formatnumber(guncel_usd,2) %> $</td>
                            <td style="text-align: center; padding:5px;"><%=formatnumber(guncel_eur,2) %> €</td>
                            <td style=" padding:5px;"><span><%=eldeki1 %> %</span>  <img src="/img/raporbar.png" width="<%=eldeki %>" style="width: <%=eldeki%>px; height: 20px;" /></td>
                        </tr>
                        <%
                            if girdimi then
                    eldeki = cint(((cdbl(otuz_tl) + cdbl(otuz_usd) + cdbl(otuz_eur))*100) / cdbl(en_toplam))
                    if eldeki = 0 then
                        eldeki = 0
                    end if

                    if eldeki>1 then
                        eldeki = eldeki 
                    end if

                            eldeki1 = eldeki
                            eldeki = eldeki * 4
                            end if
                        %>
                        <tr>
                            <td style=" padding:5px;">1-30 GÜN GEÇMİŞ</td>
                            <td style="text-align: center; padding:5px;"><%=formatnumber(otuz_tl,2) %> TL</td>
                            <td style="text-align: center; padding:5px;"><%=formatnumber(otuz_usd,2) %> $</td>
                            <td style="text-align: center; padding:5px;"><%=formatnumber(otuz_eur,2) %> €</td>
                            <td style=" padding:5px;"><span><%=eldeki1 %> %</span>  <img src="/img/raporbar.png" width="<%=eldeki %>" style="width: <%=eldeki%>px; height: 20px;" /></td>
                        </tr>
                        <%
                            if girdimi then
                    eldeki = cint(((cdbl(altmis_tl) + cdbl(altmis_usd) + cdbl(altmis_eur))*100) / cdbl(en_toplam))
                    if eldeki = 0 then
                        eldeki = 0
                    end if

                    if eldeki>1 then
                        eldeki = eldeki 
                    end if

                            eldeki1 = eldeki
                            eldeki = eldeki * 4
                            end if
                        %>
                        <tr>
                            <td style=" padding:5px;">31-60 GÜN GEÇMİŞ</td>
                            <td style="text-align: center; padding:5px;"><%=formatnumber(altmis_tl,2) %> TL</td>
                            <td style="text-align: center; padding:5px;"><%=formatnumber(altmis_usd,2) %> $</td>
                            <td style="text-align: center; padding:5px;"><%=formatnumber(altmis_eur,2) %> €</td>
                            <td style=" padding:5px;"><span><%=eldeki1 %> %</span>  <img src="/img/raporbar.png" width="<%=eldeki %>" style="width: <%=eldeki%>px; height: 20px;" /></td>
                        </tr>
                        <%
                            if girdimi then
                    eldeki = cint(((cdbl(doksan_tl) + cdbl(doksan_usd) + cdbl(doksan_eur))*100) / cdbl(en_toplam))
                    if eldeki = 0 then
                        eldeki = 0
                    end if

                    if eldeki>1 then
                        eldeki = eldeki 
                    end if

                            eldeki1 = eldeki
                            eldeki = eldeki * 4
                            end if
                        %>
                        <tr>
                            <td style=" padding:5px;">61-90 GÜN GEÇMİŞ</td>
                            <td style="text-align: center; padding:5px;"><%=formatnumber(doksan_tl,2) %> TL</td>
                            <td style="text-align: center; padding:5px;"><%=formatnumber(doksan_usd,2) %> $</td>
                            <td style="text-align: center; padding:5px;"><%=formatnumber(doksan_eur,2) %> €</td>
                            <td style=" padding:5px;"><span><%=eldeki1 %> %</span>  <img src="/img/raporbar.png" width="<%=eldeki %>" style="width: <%=eldeki%>px; height: 20px;" /></td>
                        </tr>
                        <%
                            if girdimi then
                    eldeki = cint(((cdbl(yuz20_tl) + cdbl(yuz20_usd) + cdbl(yuz20_eur))*100) / cdbl(en_toplam))
                    if eldeki = 0 then
                        eldeki = 0
                    end if

                    if eldeki>1 then
                        eldeki = eldeki 
                    end if

                            eldeki1 = eldeki
                            eldeki = eldeki * 4
                            end if
                        %>
                        <tr>
                            <td style=" padding:5px;">91-120 GÜN GEÇMİŞ</td>
                            <td style="text-align: center;  padding:5px;"><%=formatnumber(yuz20_tl,2) %> TL</td>
                            <td style="text-align: center; padding:5px;"><%=formatnumber(yuz20_usd,2) %> $</td>
                            <td style="text-align: center; padding:5px;"><%=formatnumber(yuz20_eur,2) %> €</td>
                            <td style=" padding:5px;"><span><%=eldeki1 %> %</span>  <img src="/img/raporbar.png" width="<%=eldeki %>" style="width: <%=eldeki%>px; height: 20px;" /></td>
                        </tr>
                        <%
                            if girdimi then
                    eldeki = cint(((cdbl(yuz20plus_tl) + cdbl(yuz20plus_usd) + cdbl(yuz20plus_eur))*100) / cdbl(en_toplam))
                    if eldeki = 0 then
                        eldeki = 0
                    end if

                    if eldeki>1 then
                        eldeki = eldeki 
                    end if

                            eldeki1 = eldeki
                            eldeki = eldeki * 4
                            end if
                        %>
                        <tr>
                            <td style=" padding:5px;">120+ GÜN GEÇMİŞ</td>
                            <td style="text-align: center; padding:5px;"><%=formatnumber(yuz20plus_tl,2) %> TL</td>
                            <td style="text-align: center; padding:5px;"><%=formatnumber(yuz20plus_usd,2) %> $</td>
                            <td style="text-align: center; padding:5px;"><%=formatnumber(yuz20plus_eur,2) %> €</td>
                            <td style=" padding:5px;"><span><%=eldeki1 %> %</span>  <img src="/img/raporbar.png" width="<%=eldeki %>" style="width: <%=eldeki%>px; height: 20px;" /></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </fieldset>
        <br />
        <hr />
        <br />
        <fieldset visible="true" style="border: 1px solid #cccccc; padding: 15px; margin-bottom: 15px;">
            <h3>ÖDEME LİSTESİ</h3>
            <div class="dt-responsive table-responsive">
                <table class="table " style="border: solid 1px #ccc; width:100%;" cellpadding="0" cellspacing="0" border="1">
                    <thead>
                        <tr>
                            <th style="padding: 10px; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;">ÖDEME TARİHİ</th>
                            <th style="padding: 10px; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;">FATURA/ÇEK TARİHİ</th>
                            <th style="padding: 10px; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;">MÜŞTERİ/TEDARİKÇİ</th>
                            <th style="text-align: center; padding:10px; background: linear-gradient(45deg, #4099ff, #73b4ff); width: 150px;"><span class="label label-primary arkaplansiz badge-lg">TL GİRİŞ</span></th>
                            <th style="text-align: center;padding:10px; background: linear-gradient(45deg, #FF5370, #ff869a); width: 150px;"><span class="label label-danger arkaplansiz badge-lg ">$ GİRİŞ</span></th>
                            <th style="text-align: center; padding:10px; background: linear-gradient(45deg, #FFB64D, #ffcb80); width: 150px;"><span class="label label-warning arkaplansiz badge-lg">€ GİRİŞ</span></th>
                        </tr>
                    </thead>
                    <tbody>


                        <%
                                                  if cek.eof then
                                    %>
                                    <tr>
                                        <td colspan="6" style="text-align:center; padding:10px;">Kayıt Yok</td>
                                    </tr>
                                    <%
                                        end if
                                        do while not cek.eof
                        %>
                        <tr>
                            <td style="padding:5px;"><%=cdate(cek("vade_tarihi")) %></td>
                            <td style="padding:5px;"><%=cdate(cek("islem_tarihi")) %></td>
                            <td style="padding:5px;"><%=cek("firma_adi") %></td>
                            <td style="text-align: center; padding:5px;"><% if trim(cek("parabirimi"))="TL" then %><%=formatnumber(cek("meblag"),2) %><% else %>0,00<% end if %> TL</td>
                            <td style="text-align: center; padding:5px;"><% if trim(cek("parabirimi"))="USD" then %><%=formatnumber(cek("meblag"),2) %><% else %>0,00<% end if %> $</td>
                            <td style="text-align: center; padding:5px;"><% if trim(cek("parabirimi"))="EUR" then %><%=formatnumber(cek("meblag"),2) %><% else %>0,00<% end if %> €</td>
                        </tr>
                        <%
                                        cek.movenext
                                        loop
                        %>
                    </tbody>
                </table>
            </div>
        </fieldset>
        <% end if %>
    </div>
</body>
</html>
