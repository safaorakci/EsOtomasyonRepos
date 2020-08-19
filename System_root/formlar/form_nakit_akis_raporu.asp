<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    firma_id = trn(request("firma_id"))
    kullanici_id = trn(request("kullanici_id"))
      
    baslangic_tarihi = trn(request("baslangic_tarihi"))
    bitis_tarihi = trn(request("bitis_tarihi"))

    if isdate(baslangic_tarihi) = false then
        baslangic_tarihi = cdate(date)
    end if

    if isdate(bitis_tarihi) = false then
        bitis_tarihi = cdate(date)+180
    end if


%>
<html lang="tr">
<head>
    <title><%=LNG("Nakit Akış Raporu")%></title>
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
                <h2><%=LNG("NAKİT AKIŞ RAPORU")%></h2>
                <span><%=LNG("Oluşturma Tarihi")%>&nbsp;:&nbsp;<%=now %></span></td>
            <td style="vertical-align: top; text-align: right;">
                <img src="/images/proskop_buyuk2_form.png" /></td>
        </tr>
    </table>
    <div>
        <br />
        <table>
            <tr>
                <td></td>
            </tr>
        </table>
        <br />
        <br />
        <fieldset visible="true" style="border: 1px solid #cccccc; padding: 15px; margin-bottom: 15px;">
            <div class="dt-responsive table-responsive">
                <table class="table " style="border: solid 1px #ccc; width: 100%;" cellpadding="0" cellspacing="0" border="1">
                    <thead>
                        <tr>
                            <th rowspan="2" style="padding: 10px; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("İŞLEM TÜRÜ")%></th>
                            <th rowspan="2" style="padding:  10px; vertical-align: middle; text-align: center; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("TAHSİLAT/ÖDEME TARİHİ")%></th>
                            <th rowspan="2" style="padding:  10px; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("MÜŞTERİ/TEDARİKÇİ")%></th>
                            <th rowspan="2" style="padding:  10px; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("AÇIKLAMA")%></th>
                            <th colspan="3" style="padding:  10px; vertical-align: middle; text-align: center; border-right: 1px solid #000; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("ÇIKIŞ")%></th>
                            <th colspan="3" style="padding:  10px; vertical-align: middle; font-weight: bold; border-right: 1px solid #000; text-align: center; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("GİRİŞ")%></th>
                            <th colspan="3" style="padding:  10px; vertical-align: middle; font-weight: bold; text-align: center; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("BAKİYE")%></th>
                        </tr>
                        <tr>
                            <th style="text-align: center; padding:10px; background: linear-gradient(45deg, #4099ff, #73b4ff); width: 150px;"><span class="label label-primary arkaplansiz badge-lg">TL</span></th>
                            <th style="text-align: center; padding:10px; background: linear-gradient(45deg, #FF5370, #ff869a); width: 150px;"><span class="label label-danger arkaplansiz badge-lg ">$</span></th>
                            <th style="text-align: center; padding:10px; background: linear-gradient(45deg, #FFB64D, #ffcb80); width: 150px; border-right: 1px solid #000;"><span class="label label-warning arkaplansiz badge-lg">€</span></th>
                            <th style="text-align: center; padding:10px; background: linear-gradient(45deg, #4099ff, #73b4ff); width: 150px;"><span class="label label-primary arkaplansiz badge-lg">TL</span></th>
                            <th style="text-align: center; padding:10px; background: linear-gradient(45deg, #FF5370, #ff869a); width: 150px;"><span class="label label-danger arkaplansiz badge-lg ">$</span></th>
                            <th style="text-align: center; padding:10px; background: linear-gradient(45deg, #FFB64D, #ffcb80); width: 150px; border-right: 1px solid #000;"><span class="label label-warning arkaplansiz badge-lg">€</span></th>
                            <th style="text-align: center; padding:10px; background: linear-gradient(45deg, #4099ff, #73b4ff); width: 150px;"><span class="label label-primary arkaplansiz badge-lg">TL</span></th>
                            <th style="text-align: center; padding:10px; background: linear-gradient(45deg, #FF5370, #ff869a); width: 150px;"><span class="label label-danger arkaplansiz badge-lg ">$</span></th>
                            <th style="text-align: center; padding:10px; background: linear-gradient(45deg, #FFB64D, #ffcb80); width: 150px;"><span class="label label-warning arkaplansiz badge-lg">€</span></th>
                        </tr>

                    </thead>
                    <tbody>
                        <% 
                                        SQL="SELECT CASE WHEN cari.islem_tipi = 'Ödeme' THEN firma2.firma_adi when cari.islem_tipi = 'Tahsilat' then firma.firma_adi END AS firma_adi, cari.* FROM dbo.cari_hareketler cari LEFT JOIN dbo.ucgem_firma_listesi firma ON firma.id = cari.borclu_id LEFT JOIN dbo.ucgem_firma_listesi firma2 ON firma2.id = cari.alacakli_id WHERE cari.firma_id = '"& firma_id &"' AND cari.durum = 'true' AND cari.cop = 'false' AND cari.vade_tarihi between '"& cdate(baslangic_tarihi) &"' and '"& cdate(bitis_tarihi) &"' and (cari.islem_tipi = 'Ödeme' or cari.islem_tipi = 'Tahsilat') ORDER BY cari.vade_tarihi DESC;;"
                                        set cek = baglanti.execute(SQL)

                                        if cek.eof then
                        %>
                        <tr>
                            <td colspan="10" style="text-align: center; padding:10px;"><%=LNG("Kayıt Yok")%></td>
                        </tr>
                        <%
                                        end if

                                        do while not cek.eof

                                            if trim(cek("parabirimi"))="TL" then
                                                bakiye_tl = cdbl(bakiye_tl) + cdbl(cek("meblag"))
                                            elseif trim(cek("parabirimi"))="USD" then
                                                bakiye_usd = cdbl(bakiye_usd) + cdbl(cek("meblag"))
                                            elseif trim(cek("parabirimi"))="EUR" then
                                                bakiye_eur = cdbl(bakiye_eur) + cdbl(cek("meblag"))
                                            end if
                        %>
                        <tr>
                            <td style=" padding:5px;"><%=cek("akis_tipi") %>-<%=cek("islem_tipi") %></td>
                            <td style="text-align: center; padding:5px;"><%=cdate(cek("vade_tarihi")) %></td>
                            <td style=" padding:5px;"><%=cek("firma_adi") %></td>
                            <td style=" padding:5px;"><%=cek("aciklama") %></td>
                            <% if trim(cek("islem_tipi"))="Ödeme" then %>
                            <td style="text-align: center; padding:5px; border-right: 1px #e8e8e8 solid;"><% if trim(cek("parabirimi"))="TL" then %><%=formatnumber(cek("meblag"),2) %> TL<% end if %></td>
                            <td style="text-align: center; padding:5px; border-right: 1px #e8e8e8 solid;"><% if trim(cek("parabirimi"))="USD" then %><%=formatnumber(cek("meblag"),2) %> $<% end if %></td>
                            <td style="text-align: center; padding:5px; border-right: 1px solid black;"><% if trim(cek("parabirimi"))="EUR" then %><%=formatnumber(cek("meblag"),2) %> €<% end if %></td>
                            <td style="text-align: center; padding:5px; border-right: 1px #e8e8e8 solid;"></td>
                            <td style="text-align: center; padding:5px; border-right: 1px #e8e8e8 solid;"></td>
                            <td style="text-align: center; padding:5px; border-right: 1px solid black;"></td>
                            <% else %>
                            <td style="text-align: center; padding:5px; border-right: 1px #e8e8e8 solid;"></td>
                            <td style="text-align: center; padding:5px; border-right: 1px #e8e8e8 solid;"></td>
                            <td style="text-align: center; padding:5px; border-right: 1px solid black;"></td>
                            <td style="text-align: center; padding:5px; border-right: 1px #e8e8e8 solid;"><% if trim(cek("parabirimi"))="TL" then %><%=formatnumber(cek("meblag"),2) %> TL<% end if %></td>
                            <td style="text-align: center; padding:5px; border-right: 1px #e8e8e8 solid;"><% if trim(cek("parabirimi"))="USD" then %><%=formatnumber(cek("meblag"),2) %> $<% end if %></td>
                            <td style="text-align: center; padding:5px; border-right: 1px solid black;"><% if trim(cek("parabirimi"))="EUR" then %><%=formatnumber(cek("meblag"),2) %> €<% end if %></td>
                            <% end if %>
                            <td style="text-align: center; padding:5px; border-right: 1px #e8e8e8 solid;"><%=formatnumber(bakiye_tl,2) %> TL</td>
                            <td style="text-align: center; padding:5px; border-right: 1px #e8e8e8 solid;"><%=formatnumber(bakiye_usd,2) %> $</td>
                            <td style="text-align: center; padding:5px; border-right: 1px solid black;"><%=formatnumber(bakiye_eur,2) %> €</td>

                        </tr>
                        <% 
                            cek.movenext
                            loop
                        %>
                    </tbody>
                </table>
            </div>
        </fieldset>
    </div>
</body>
</html>
