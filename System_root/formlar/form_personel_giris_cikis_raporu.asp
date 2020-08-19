<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    rapor_personel_id = trn(request("personelID"))
    baslangic = trn(request("tarihBaslangic"))
    bitis = trn(request("tarihBitis"))

    dongu_baslangic = cdate(baslangic)
    dongu_bitis = cdate(bitis)

    FirmaID = Request.Cookies("kullanici")("firma_id")
%>
<html lang="tr">
    <head>
        <title><%=LNG("Proje Adam-Saat Raporu")%></title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <style>

            body {
                font-family:Arial;
            }
        .taskin {
            background-color:#fb8f8f!important;
        }

        .hbir {
            background-color:#f0f78e!important;
        }

        .hiki {
            background-color:#82cdff!important;
        }

        .huc {
            background-color:#a5dc95!important;
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
        <table style="width: 100%;">
        <tr>
            <td style="vertical-align: top; text-align: left; line-height: 20px;">
                <h2><%=LNG("Personel Giriş Çıkış RAPORU")%></h2>
                <span><%=LNG("Oluşturma Tarihi")%>&nbsp;:&nbsp;<%=now %></span></td>
            <td style="vertical-align: top; text-align: right;">
                <img src="/images/proskop_buyuk2_form.png" /></td>
        </tr>
    </table>
    <div>
    <div class="tablediv" style="width: 100%; margin-top: 15px; overflow: auto;">
        <div id="tablediv">
            <table id="tablegosterge" style="border-color: #e8e8e8; font-family: Tahoma; width: 100%;">
                <thead id="thead">
                    <tr>
                        <th rowspan="2" class="ilkth headcol">
                            <div style="width: 150px;"><%=LNG("Personeller")%></div>
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
                        <th class="ust_th" colspan="<%=cols * 3 %>"><%=monthname(son_ay) %>&nbsp;<%=year(x) %></th>
                        <% 
                                                end if
                                            next
                        %>
                    <tr>
                        <% for x = dongu_baslangic to dongu_bitis  %>
                        <th class="alt_th" style="<% if day(x)=1 then %> border-left: solid 3px white; <% end if %>" colspan="3">
                            <div class="col-md-12">
                                <div class="row">
                                    <div style="border-bottom: 1px solid;" class="col-md-12"><%=day(x) %></div>
                                    <div style="padding-left:13px; border-right: 1px solid;" class="col-md-4"><span title="Giriş Saati">G</span></div>
                                    <div style="padding-left:13px; border-right: 1px solid;" class="col-md-4"><span title="Çıkış Saati">Ç</span></div>
                                    <div style="padding-left:15px" class="col-md-4"><span title="İzinli">İ</span></div>
                                </div>
                            </div>
                        </th>
                        <% next %>
                    </tr>
                </thead>
                <tbody id="tbody">

                <%
                                        SQL="EXEC dbo.spGenelPuantaj '"& baslangic &"', '"& bitis &"', '"& rapor_personel_id &"', '"& FirmaID &"';"
                                        set cetvel = baglanti.execute(SQL)

                                        k = 0
                                        son_kaynak = ""
                                        do while not cetvel.eof 
                                            girdimi = false
                                            if not sonkaynak = cetvel("id") then
                                                sonkaynak = cetvel("id")
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
                    <td style="width: 150px;" class="ust_td2 headcol"><%=cetvel("Personel") %></td>
                    <% end if %>
                    <td style="min-width:38px" class="alt_td <% if cdate(cetvel("Tarih"))=cdate(date) then %> sarialan <% end if %> ">
                        <%if not cetvel("Giris") = "-" and not cetvel("Cikis") = "-" then%>
                            <%=cetvel("Giris") %>
                        <%else %>
                            -
                        <%end if %>
                    </td>
                    <td style="min-width:38px" class="alt_td <% if cdate(cetvel("Tarih"))=cdate(date) then %> sarialan <% end if %> ">
                        <%if not cetvel("Giris") = "-" and not cetvel("Cikis") = "-" then%>
                            <%=cetvel("Cikis") %>
                        <%else %>
                            -
                        <%end if %>
                    </td>
                    <td style="min-width:38px" class="alt_td <% if cdate(cetvel("Tarih"))=cdate(date) then %> sarialan <% end if %> ">
                        <%if not cetvel("izin") = "-" then%>
                            <%=cetvel("izin") %>
                        <%else %>
                            -
                        <%end if %>
                    </td>
                    <%  
                        gunsayi = gunsayi + 1
                        
                        cetvel.movenext
                        loop
                    %>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div id="tablediv2" style="display: none;"></div>
</div>

    </body>
</html>