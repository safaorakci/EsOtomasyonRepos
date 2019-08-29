<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    proje_id = trn(request("pid"))
    dongu_baslangic = cdate(trn(request("baslangic")))
    dongu_bitis = cdate(trn(request("bitis")))
    gosterim_tipi = trn(request("tip"))
    firma_id = trn(request("fid"))
    kullanici_id = trn(request("kid"))

%>
<html lang="tr">
    <head>
        <title><%=LNG("Personel İş Yükü Raporu")%></title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <style>

            body {
                font-family:Arial;
            }
    .taskin {
        background-color: #fb8f8f !important;
    }

    .guncizelge {
        width: 30px;
        text-align: center;
        margin-left: auto;
        margin-right: auto;
    }

    .ikincisi td {
        background-color: #f8f5f5;
    }

    .ilkth {
        width: 150px;
        padding: 5px;
        background-color: #32506d;
        color: white;
        line-height: 25px;
        border: solid 1px #e8e8e8;
    }

    .ust_th_ilk {
        background-color: #32506d;
        border: solid 1px #e8e8e8;
        border-left: 3px solid #32506d;
        color: white;
        line-height: 40px;
        vertical-align: bottom;
        padding: 5px;
    }

    .ust_th {
        background-color: #32506d;
        border: solid 1px #e8e8e8;
        border-left: solid 3px white;
        color: white;
        line-height: 40px;
        vertical-align: bottom;
        padding: 5px;
    }

    .alt_th {
        text-align: center;
        background-color: #4d7193;
        border: solid 1px #e8e8e8;
        color: white;
        line-height: 25px;
    }

    .ustunegelince {
        background-color: #fff;
    }


    .ustunegelince2 td {
        background-color: #cce6ff !important;
    }

    .ust_td2 {
        border: solid 1px #e8e8e8;
        padding: 5px;
        line-height: 20px;
        font-weight: bold;
        background-color: #32506d !important;
        color: white !important;
    }

    .gosterge_td {
        text-align: center;
        background-color: #4d7193 !important;
        color: white !important;
    }

    .sagcizgi {
        border-right: 3px solid #32506d !important;
    }

    .alt_td {
        text-align: center;
        border: solid 1px #e8e8e8;
        line-height: 20px;
        padding: 5px;
    }

    .alt_td2 {
        border-left: 3px solid #32506d;
    }

    .sarialan {
        background-color: #f5ffa6 !important;
    }


    .tablediv {
        padding-bottom: 15px;
    }


        .tablediv::-webkit-scrollbar-track {
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
            border-radius: 10px;
            background-color: #F5F5F5;
        }

        .tablediv::-webkit-scrollbar {
            width: 12px;
            background-color: #F5F5F5;
        }

        .tablediv::-webkit-scrollbar-thumb {
            border-radius: 10px;
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
            background-color: #32506d;
        }
</style>
    </head>
    <body>
        <table style="width:100%;">
            <tr>
                <td style="vertical-align:top; text-align:left;"><h2><%=LNG("PERSONEL İŞ YÜKÜ RAPORU")%></h2><span><%=LNG("Oluşturma Tarihi")%>&nbsp;:&nbsp;<%=now %></span></td>
                <td style="vertical-align:top; text-align:right;"><img src="/images/proskop_buyuk2_form.png" /></td>            </tr>
        </table>
    <div>
    <div id="tablediv">
        <table id="tablegosterge" style="border-color: #e8e8e8; width: 100%;">
            <thead id="thead">
                <tr>
                    <th rowspan="2" class="ilkth headcol">
                        <div style="width: 150px;"><%=LNG("KAYNAKLAR")%></div>
                    </th>
                    <th rowspan="2" class="ilkth headcol ">
                        <div style="width: 80px; text-align: center; margin-left: auto; margin-right: auto;">
                            <%=LNG("İŞ SAYISI")%>
                        </div>
                    </th>
                    <% 
                            son_ay = 0
                            for x = dongu_baslangic to dongu_bitis 
                                if not son_ay = month(x) then
                                    son_ay = month(x)

                                    cols = AyinSonGunu(cdate(x)) - day(cdate(x))

                                    if cdate( AyinSonGunu(cdate(x)) & "." & month(cdate(x)) & "." & year(cdate(x))) > dongu_bitis then
                                        cols = day(dongu_bitis)
                                    end if

                                    cols = cols + 1
                    %>
                    <th class="ust_th" colspan="<%=cols %>"><%=ucase(monthname(son_ay)) %>&nbsp;<%=year(x) %></th>
                    <% 
                                end if
                            next
                    %>
                </tr>
                <tr>

                    <% for x = dongu_baslangic to dongu_bitis  %>
                    <th class="alt_th" style="<% if day(x)=1 then %> border-left: solid 3px white; <% end if %>">
                        <div class="guncizelge"><%=day(x) %></div>
                    </th>
                    <% next %>
                </tr>
            </thead>
            <tbody id="tbody">

                <%

                        SQL="Exec [dbo].[ProjeIsYukuCetveli] @proje_id = '"& proje_id &"', @firma_id = '"& firma_id &"', @baslangic = '"& dongu_baslangic &"', @bitis = '"& dongu_bitis &"', @gosterim_tipi = '"& gosterim_tipi &"';"
                        set cetvel = baglanti.execute(sql)

                        tarih_sayi = cdate(dongu_bitis) - cdate(dongu_baslangic) + 1

                        Dim gun_toplam2()
                        Redim gun_toplam2(tarih_sayi)
                        k = 0
                        son_kaynak = ""
                        do while not cetvel.eof 
                            girdimi = false
                            if not sonkaynak = cetvel("tip") & cetvel("id") then
                                sonkaynak = cetvel("tip") & cetvel("id")
                                girdimi = true
                                k = k + 1
                                klas = ""
                                if k mod 2 = 0 then
                                    klas = "ikincisi"
                                end if
                                                
                                gunsayi = 0

                                if k > 1 then
                %>
                                        </tr>
                                        <% end if %>
                <tr class=" ustunegelince <%=klas %>">
                    <%
                            if trim(gosterim_tipi)="0" then
                                toplam_sayi = cdbl(toplam_sayi) + cdbl(cetvel("kaynak_toplam_sayi"))
                            elseif trim(gosterim_tipi)="1" then
                                toplam_sayi = cdbl(toplam_sayi) + cdbl(cetvel("kaynak_toplam_dakika"))
                            end if
                    %>
                    <td style="width: 150px;" class="ust_td2 headcol"><a href="javascript:void(0);" onclick="KaynakIsYukuDetayGoster('<%=cetvel("tip") %>', '<%=cetvel("id") %>');" style="color: white;"><i class="fa fa-plus-square"></i>&nbsp;&nbsp;<%=cetvel("kaynak") %></a></td>
                    <td class="gosterge_td alt_td ">
                        <% if trim(gosterim_tipi)="0" then %>
                        <%=cetvel("kaynak_toplam_sayi") %>
                        <% elseif trim(gosterim_tipi)="1" then %>
                        <%=cetvel("kaynak_toplam_saat") %>
                        <% end if %></td>

                    <% end if %>
                    <td class="alt_td  <% if cdbl(cetvel("saat"))>480 then %> taskin <% end if %> <% if day(cetvel("tarih"))=1 then %> alt_td2 <% end if %> <% if cdate(cetvel("tarih"))=cdate(date) then %> sarialan <% end if %> ">
                        <% if trim(gosterim_tipi)="0" then %>
                        <% if cdbl(cetvel("sayi"))=0 then %>-<% else %>
                        <!--<a href="javascript:void(0);" onclick="aiyda('<%=cetvel("id") %>','<%=cdate(cetvel("tarih")) %>');">-->
                        <%=cetvel("sayi") %>
                        <!--</a>-->
                        <% end if %>
                        <% elseif trim(gosterim_tipi)="1" then %>
                        <% if trim(cetvel("saat2"))="00:00" then %>-<% else %>
                        <!--<a href="javascript:void(0);" onclick="aiyda('<%=cetvel("id") %>','<%=cetvel("tarih") %>');">-->
                        <%=cetvel("saat2") %>
                        <!--</a>-->
                        <% end if %>
                        <% end if %>

                    </td>
                    <%  
                            if trim(gosterim_tipi)="0" then
                                gun_toplam2(gunsayi) = cdbl(gun_toplam2(gunsayi)) + cdbl(cetvel("sayi"))
                            elseif trim(gosterim_tipi)="1" then
                                gun_toplam2(gunsayi) = cdbl(gun_toplam2(gunsayi)) + cdbl(cetvel("saat"))
                            end if
                            gunsayi = gunsayi + 1

                            cetvel.movenext
                            loop
                    %>
                </tr>
                <tr>
                    <td class="ust_td2 headcol" style="width: 150px; background-color: #4d7193; color: white!important;"><%=LNG("TOPLAM")%></td>
                    <td class="gosterge_td alt_td ">
                        <% if trim(gosterim_tipi)="0" then %>
                        <%=toplam_sayi %>
                        <% elseif trim(gosterim_tipi)="1" then %>
                        <%=DakikadanSaatYap(toplam_sayi) %>
                        <% end if %>
                    </td>

                    <% for x = 0 to ubound(gun_toplam2)-1 %>
                    <td class="alt_td" style="background-color: #4d7193; color: white;">
                        <% if trim(gosterim_tipi)="0" then %>
                        <%=gun_toplam2(x) %>
                        <% elseif trim(gosterim_tipi)="1" then %>
                        <%=DakikadanSaatYap(gun_toplam2(x)) %>
                        <% end if %>
                    </td>
                    <% next %>
                </tr>
                <%
                        Erase gun_toplam2
                %>
            </tbody>
        </table>
    </div>
    <div id="tablediv2" style="display: none;"></div>
</div>

    </body>
</html>