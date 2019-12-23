<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    if trn(request("islem"))="rapor_is_yuku_gosterim_proje_sectim_verimlilik" then

            proje_id = trn(request("proje_id"))
            dongu_baslangic = cdate(trn(request("baslangic")))
            dongu_bitis = cdate(trn(request("bitis")))
            gosterim_tipi = trn(request("gosterim_tipi"))
            donem = trn(request("donem"))
    
%>
<style>
    .taskin {
        background-color: #fb8f8f !important;
    }

    .hbir {
        background-color: #f0f78e !important;
    }

    .hiki {
        background-color: #82cdff !important;
    }

    .huc {
        background-color: #a5dc95 !important;
    }
</style>
<div>
    <div id="tablediv">
        <table id="tablegosterge" style="border-color: #e8e8e8; font-family: Tahoma; width: 100%;">
            <thead id="thead">
                <tr>
                    <th rowspan="2" class="ilkth headcol">
                        <div style="width: 150px;"><%=LNG("Kaynaklar")%></div>
                    </th>
                    <th rowspan="2" class="ilkth headcol ">
                        <div style="width: 80px; text-align: center; margin-left: auto; margin-right: auto;">
                            <%=LNG("İş Sayısı")%>
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
                    <th class="ust_th" colspan="<%=cols %>"><%=monthname(son_ay) %>&nbsp;<%=year(x) %></th>
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

                        SQL="Exec [dbo].[ProjeIsYukuCetveli] @proje_id = '"& proje_id &"', @firma_id = '"& Request.Cookies("kullanici")("firma_id") &"', @baslangic = '"& dongu_baslangic &"', @bitis = '"& dongu_bitis &"', @gosterim_tipi = '"& gosterim_tipi &"';"
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
                <tr class="ustunegelince <%=klas %>">
                    <%
                            if trim(gosterim_tipi)="0" then
                                toplam_sayi = cdbl(toplam_sayi) + cdbl(cetvel("kaynak_toplam_sayi"))
                            elseif trim(gosterim_tipi)="1" then
                                toplam_sayi = cdbl(toplam_sayi) + cdbl(cetvel("kaynak_toplam_dakika"))
                            end if

                            toplam_dakika = (AyinSonGunu(cdate(cetvel("tarih"))) * 480) - 1920

                            toplam_hesap = (100-(((cdbl(toplam_dakika)-cdbl(cetvel("kaynak_toplam_dakika")))/cdbl(cdbl(toplam_dakika)))*100))

                            en_toplam_hesap = (cdbl(en_toplam_hesap) + cdbl(toplam_hesap))
                            satirsay = satirsay + 1
                    %>
                    <td style="width: 150px;" class="ust_td2 headcol"><%=cetvel("kaynak") %></td>
                    <td class="gosterge_td alt_td ">
                        <% if trim(gosterim_tipi)="0" then %>
                            %<%=formatnumber(toplam_hesap,2)%>
                        <% elseif trim(gosterim_tipi)="1" then %>
                            %<%=100-formatnumber(toplam_hesap,2)%>
                        <% end if %></td>

                    <% end if 
                            
                            if trim(cetvel("saat2"))="00:00" then
                                hesap = cint(100-(((480 - cdbl(0))/480)*100))
                            else
                                hesap = cint(100-(((480 - cdbl(cetvel("saat")))/480)*100))
                            end if

                            hesap_klas = ""

                            if trim(gosterim_tipi)="0" then 
                                if cdbl(hesap)=0 then
                                    hesap_klas = "hsifir"
                                elseif cdbl(hesap)<41 then
                                    hesap_klas = "hbir"
                                elseif cdbl(hesap)<76 then
                                    hesap_klas = "hiki"
                                elseif cdbl(hesap)<101 then
                                    hesap_klas = "huc"
                                elseif cdbl(hesap)>100 then
                                    hesap_klas = "taskin"
                                end if
                            else

                            if isnumeric(hesap)=false then
                                hesap = 0
                            end if

                                hesap = 100-cdbl(hesap)



                                if cdbl(hesap)<0 then
                                    hesap_klas = "taskin"
                                elseif cdbl(hesap)=0 then
                                    hesap_klas = "hbir"
                                elseif cdbl(hesap)<41 then
                                    hesap_klas = "hbir"
                                elseif cdbl(hesap)<76 then
                                    hesap_klas = "hiki"
                                elseif cdbl(hesap)<101 then
                                    hesap_klas = "huc"
                                end if
                            end if



                            
                    %>
                    <td class="alt_td  <%=hesap_klas %> <% if day(cetvel("tarih"))=1 then %> alt_td2 <% end if %>  ">

                        <% if trim(gosterim_tipi)="0" then %>
                        <% if trim(cetvel("saat2"))="00:00" then %>
                                            %0
                                     <% else 
                                     %>
                                            %<%=hesap %>
                        <% end if %>
                        <% else %>
                                            %<%=hesap %>
                        <% end if %>





                    </td>
                    <%  
                            if trim(gosterim_tipi)="0" then
                                gun_toplam2(gunsayi) = cdbl(gun_toplam2(gunsayi)) + cdbl(hesap)
                            elseif trim(gosterim_tipi)="1" then
                                gun_toplam2(gunsayi) = cdbl(gun_toplam2(gunsayi)) + cdbl(hesap)
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
                            %<%=formatnumber((en_toplam_hesap/satirsay),2) %>
                        <% elseif trim(gosterim_tipi)="1" then %>
                            %<%=formatnumber((100-(en_toplam_hesap/satirsay)),2) %>
                        <% end if %>
                    </td>

                    <% for x = 0 to ubound(gun_toplam2)-1 %>
                    <td class="alt_td" style="background-color: #4d7193; color: white;">
                        <% if trim(gosterim_tipi)="0" then %>
                            %<%=cint(cdbl(gun_toplam2(x))/cdbl(satirsay)) %>
                        <% elseif trim(gosterim_tipi)="1" then %>
                            %<%=cint(cdbl(gun_toplam2(x))/cdbl(satirsay)) %>
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
<% 
      elseif trn(request("islem"))="departman_adam_saat_getir" then

        etiketler = trn(request("etiketler"))
        rapor_personel_id = trn(request("rapor_personel_id"))
        proje_id = trn(request("yeni_is_yuku_proje_id"))
        baslangic = trn(request("baslangic"))
        bitis = trn(request("bitis"))

%>
<script>
    $(function (){
        $("#adamsaatframe").css("height", parseInt(window.height)-500);
    });
</script>

<div class="card">
    <div class="card-block">
        <div class="view-info">
            <div class="row">
                <div class="col-lg-12">
                    <style>
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
                    <%
                        dongu_baslangic = cdate(baslangic)
                        dongu_bitis = cdate(bitis)
                    %>
                    <div class="h5" style="font-size: 15px;"><%=LNG("Adam-Saat Cetveli")%></div>

                    <div class="tablediv" style="width: 100%; margin-top: 15px; overflow: auto;">
                        <div id="tablediv">
                            <table id="tablegosterge" style="border-color: #e8e8e8; font-family: Tahoma; width: 100%;">
                                <thead id="thead">
                                    <tr>
                                        <th rowspan="2" class="ilkth headcol">
                                            <div style="width: 150px;"><%=LNG("Kaynaklar")%></div>
                                        </th>
                                        <th rowspan="2" class="ilkth headcol ">
                                            <div style="width: 80px; text-align: center; margin-left: auto; margin-right: auto;">
                                                <%=LNG("Saat")%>
                                            </div>
                                        </th>
                                        <th rowspan="2" class="ilkth headcol ">
                                            <div style="width: 80px; text-align: center; margin-left: auto; margin-right: auto;">
                                                <%=LNG("Maliyet")%>
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
                                        <th class="ust_th" colspan="<%=cols %>"><%=monthname(son_ay) %>&nbsp;<%=year(x) %></th>
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
                                        SQL="EXEC dbo.DepartmanAdamSaatCetveli @proje_id = '"& proje_id &"', @firma_id = '"& Request.Cookies("kullanici")("firma_id") &"', @baslangic = '"& cdate(dongu_baslangic) &"', @bitis = '"& cdate(dongu_bitis) &"', @etiketler = '"& etiketler &"', @rapor_personel_id = '"& rapor_personel_id &"';"
                                        set cetvel = baglanti.execute(sql)
                                        response.Write(SQL)

                                        tarih_sayi = cdate(dongu_bitis) - cdate(dongu_baslangic) + 1

                                        Dim gun_toplam()
                                        Redim gun_toplam(tarih_sayi)
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
                                                toplam_calisma_suresi = cetvel("toplam_calisma_saati")
                                                toplam_saat = cdbl(toplam_saat) + cdbl(cetvel("kaynak_toplam_saat"))
                                                toplam_tutar = cdbl(toplam_tutar) + cdbl(cetvel("kaynak_toplam_maliyet"))
                                        %>
                                        <td style="width: 150px;" class="ust_td2 headcol"><%=cetvel("kaynak") %></td>
                                        <td class="gosterge_td alt_td "><%=cetvel("calisma_suresi") %></td>
                                        <td class=" gosterge_td alt_td sagcizgi"><%=cetvel("kaynak_toplam_maliyet") %> TL</td>
                                        <% end if %>
                                        <td class="alt_td <% if day(cetvel("tarih"))=1 then %> alt_td2 <% end if %> <% if cdate(cetvel("tarih"))=cdate(date) then %> sarialan <% end if %> "><% if cdbl(cetvel("maliyet_tutari"))=0 then %>-<% else %><%=cetvel("calisma_saati") %><br />
                                            <%=cetvel("maliyet_tutari") %>TL<% end if %></td>
                                        <%  
                                            'response.Write(gunsayi)
                                                gun_toplam(gunsayi) = cdbl(gun_toplam(gunsayi)) + cdbl(cetvel("maliyet_tutari"))
                                                gunsayi = gunsayi + 1

                                            cetvel.movenext
                                            loop
                                        %>
                                    </tr>
                                    <tr>
                                        <td class="ust_td2 headcol" style="width: 150px; background-color: #4d7193; color: white!important;"><%=LNG("TOPLAM")%></td>
                                        <td class="gosterge_td alt_td "><%=toplam_calisma_suresi %></td>
                                        <td class=" gosterge_td alt_td sagcizgi"><%=toplam_tutar %> TL</td>
                                        <% for x = 0 to ubound(gun_toplam)-1 %>
                                        <td class="alt_td" style="background-color: #4d7193; color: white;"><%=gun_toplam(x) %>TL</td>
                                        <% next %>
                                    </tr>
                                    <%
                                        Erase gun_toplam
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%
    elseif trn(request("islem"))="proje_maliyet_raporu_getir" then

        proje_id = trn(request("yeni_is_yuku_proje_id"))
        baslangic_tarihi = trn(request("baslangic_tarihi"))
        bitis_tarihi = trn(request("bitis_tarihi"))

        SQL="select firma.firma_adi, firma.firma_telefon, firma.firma_mail, proje.* from ucgem_proje_listesi proje join ucgem_firma_listesi firma on firma.id = proje.proje_firma_id where proje.id = '"& proje_id &"'"
        set cek = baglanti.execute(SQL)

        toplam_butce_tl = 0
        toplam_butce_usd = 0
        toplam_butce_eur = 0

        toplam_satinalma_tl = 0
        toplam_satinalma_usd = 0
        toplam_satinalma_eur = 0

        toplam_iscilik_tl = 0
        toplam_iscilik_usd = 0
        toplam_iscilik_eur = 0

        toplam_gelir_tl = 0
        toplam_gelir_usd = 0
        toplam_gelir_eur = 0
%>

<div class="row invoive-info">
    <div class="col-md-6 col-sm-12 invoice-client-info">
        <h5 style="color: black; margin-bottom: 20px;"><%=LNG("Proje Maliyet Raporu")%></h5>
        <h6 class="m-0"><%=cek("proje_adi") %></h6>
        <p class="m-0 m-t-10"><%=cek("firma_adi") %></p>
        <p class="m-0"><%=cek("firma_telefon") %></p>
        <p><%=cek("firma_mail") %></p>
    </div>
    <div class="col-md-3 col-sm-6">
        <h6><%=LNG("Rapor Bilgileri :")%></h6>
        <table class="table table-responsive invoice-table invoice-order table-borderless">
            <tbody>
                <tr>
                    <th><%=LNG("Tarih :")%></th>
                    <td><%=now %></td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="col-md-3 col-sm-6">
        <h6 class="m-b-20"><%=LNG("Proje No")%> <span>#<%=cek("id") %></span></h6>
        <h6 class="m-b-10" style="font-weight: normal;"><%=LNG("Raporu Alan :")%> <span><%=Request.Cookies("kullanici")("kullanici_adsoyad") %></span></h6>
    </div>
</div>
<div class="row">
    <div class="col-sm-12">
        <h5 style="font-size: 15px; line-height: 30px;"><%=LNG("Bütçe Hesapları")%></h5>

        <%
            sql="SELECT ISNULL((SELECT SUM(satinalma.gerceklesen_tutar) FROM ahtapot_proje_satinalma_listesi satinalma WHERE satinalma.proje_id = butce.proje_id and butce.id = satinalma.butce_hesabi AND satinalma.cop = 'false' AND gerceklesen_pb = 'TL'),0) AS gerceklesen_tl, ISNULL((SELECT SUM(satinalma.gerceklesen_tutar) FROM ahtapot_proje_satinalma_listesi satinalma WHERE satinalma.proje_id = butce.proje_id and butce.id = satinalma.butce_hesabi AND satinalma.cop = 'false' AND gerceklesen_pb = 'USD'),0) AS gerceklesen_usd, ISNULL((SELECT SUM(satinalma.gerceklesen_tutar) FROM ahtapot_proje_satinalma_listesi satinalma WHERE satinalma.proje_id = butce.proje_id and butce.id = satinalma.butce_hesabi AND satinalma.cop = 'false' AND gerceklesen_pb = 'EUR'),0) AS gerceklesen_eur, * FROM ahtapot_proje_butce_listesi butce WHERE butce.proje_id = '"& proje_id &"' AND butce.cop = 'false';"
            set butce = baglanti.execute(SQL)
            if butce.eof then
        %>
        <div class="dt-responsive table-responsive">
            <table id="new-cons" class="table table-striped table-bordered table-hover" width="100%">
                <tbody>
                    <tr>
                        <td colspan="5" style="text-align: center;"><%=LNG("Kayıt Yok")%></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <%
                        end if
                        do while not butce.eof
        %>
        <fieldset visible="true" style="border: 1px solid #cccccc; padding: 15px; margin-bottom: 15px;">
            <legend style="width: auto; padding-left: 5px; padding-right: 5px; font-size: 15px;"><%=butce("butce_hesabi_adi") %></legend>
            <div class="dt-responsive table-responsive">
                <table id="new-cons" class="table table-striped table-bordered table-hover" width="100%">
                    <thead>
                        <tr>
                            <th style="color: #495057; background-color: #e9ecef; padding: .75rem; font-weight: bold; font-size: 15px; width: 50%;"><%=LNG("Bütçe Hesap Adı")%></th>
                            <th style="text-align: center; max-width: 200px; color: #495057; background-color: #e9ecef; padding: .75rem; font-weight: bold; font-size: 15px;"><%=LNG("Öngörülen / Kalan")%></th>
                            <th style="text-align: center; max-width: 200px; color: #495057; background-color: #e9ecef; padding: .75rem; font-weight: bold; font-size: 15px;"><%=LNG("Gerçek")%></th>
                            <th style="text-align: center; max-width: 300px; color: #495057; background-color: #e9ecef; padding: .75rem; font-weight: bold; font-size: 15px;"><%=LNG("Durum")%></th>
                        </tr>
                    </thead>
                    <tbody>

                        <%
                            kalan_tutar = cdbl(butce("ongorulen_tutar")) - (cdbl(Ciftparacevir(butce("gerceklesen_tl"), "TL", butce("parabirimi"))) + cdbl(Ciftparacevir(butce("gerceklesen_usd"), "USD", butce("parabirimi")))+ cdbl(Ciftparacevir(butce("gerceklesen_eur"), "EUR", butce("parabirimi"))))
                            kalan_tutar2 = cdbl(butce("ongorulen_tutar")) - cdbl(kalan_tutar)
                            hesap = cint(100-(((cdbl(butce("ongorulen_tutar")) - cdbl(kalan_tutar2)) / cdbl(butce("ongorulen_tutar"))) * 100))


                            if trim(butce("parabirimi"))="TL" then
                                toplam_butce_tl = cdbl(toplam_butce_tl) + cdbl(butce("ongorulen_tutar"))
                            elseif trim(butce("parabirimi"))="USD" then
                                toplam_butce_usd = cdbl(toplam_butce_usd) + cdbl(butce("ongorulen_tutar"))
                            elseif trim(butce("parabirimi"))="EUR" then
                                toplam_butce_eur = cdbl(toplam_butce_eur) + cdbl(butce("ongorulen_tutar"))
                            end if
                        %>
                        <tr>
                            <td style="font-size: 13px; font-weight: bold;"><%=butce("butce_hesabi_adi") %></td>
                            <td style="text-align: center; max-width: 200px;">
                                <label class="label label-primary" style="font-size: 12px; width: 150px; margin-left: auto; margin-right: auto;"><%=FormatNumber(butce("ongorulen_tutar"),2) %>&nbsp;<%=butce("parabirimi") %></label>
                                <br />
                                <label class="label label-danger" style="font-size: 12px; width: 150px; margin-left: auto; margin-right: auto;"><%=FormatNumber(kalan_tutar,2) %>&nbsp;<%=butce("parabirimi") %></label>
                            </td>
                            <td style="text-align: center; line-height: 5px; max-width: 200px;">
                                <label class="label label-warning" style="font-size: 12px; width: 150px; margin-left: auto; margin-right: auto;"><%=FormatNumber(butce("gerceklesen_tl"),2) %>&nbsp;TL</label><br />
                                <label class="label label-info" style="font-size: 12px; width: 150px; margin-left: auto; margin-right: auto;"><%=FormatNumber(butce("gerceklesen_usd"),2) %>&nbsp;USD</label><br />
                                <label class="label label-success" style="font-size: 12px; width: 150px; margin-left: auto; margin-right: auto;"><%=FormatNumber(butce("gerceklesen_eur"),2) %>&nbsp;EUR</label>
                            </td>
                            <td style="max-width: 300px;">
                                <span><%=hesap %> %</span><br />
                                <img src="/img/raporbar.png" width="<%=hesap %>%" style="width: <%=hesap %>%; height: 20px;" />



                            </td>
                        </tr>

                    </tbody>
                </table>
            </div>


            <h5 style="font-size: 13px; line-height: 25px;"><%=butce("butce_hesabi_adi") %> <%=LNG("Bütçe Kalemleri")%></h5>
            <div class="dt-responsive table-responsive">
                <table id="new-cons2" class="table table-striped table-bordered table-hover" width="100%">
                    <thead>
                        <tr>
                            <th style="color: #495057; background-color: #e9ecef; padding: .75rem; font-weight: bold; font-size: 15px; width: 50%;"><%=LNG("Satınalma Adı")%></th>
                            <th style="text-align: center; color: #495057; background-color: #e9ecef; padding: .75rem; font-weight: bold; font-size: 15px;"><%=LNG("Tedarikçi")%></th>
                            <th style="text-align: center; max-width: 120px; color: #495057; background-color: #e9ecef; padding: .75rem; font-weight: bold; font-size: 15px;"><%=LNG("Durum")%></th>
                            <th style="text-align: center; color: #495057; background-color: #e9ecef; padding: .75rem; font-weight: bold; font-size: 15px;"><%=LNG("Öngörülen")%></th>
                            <th style="text-align: center; max-width: 200px; color: #495057; background-color: #e9ecef; padding: .75rem; font-weight: bold; font-size: 15px;"><%=LNG("Gerçek")%></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            SQL=" SELECT isnull(firma.firma_adi, '---') as firma_adi, butce.butce_hesabi_adi, satinalma.* from ahtapot_proje_satinalma_listesi satinalma join ahtapot_proje_butce_listesi butce on butce.id = satinalma.butce_hesabi left JOIN dbo.ucgem_firma_listesi firma ON firma.id = satinalma.tedarikci_id where satinalma.proje_id = '"& proje_id &"' and butce.id = '"& butce("id") &"' and satinalma.cop = 'false' AND satinalma.durum = 'true' AND satinalma.durum = butce.durum AND satinalma.cop = butce.cop"
                            set satis = baglanti.execute(SQL)
                            if satis.eof then
                        %>
                        <tr>
                            <td colspan="5" style="text-align: center;"><%=LNG("Kayıt Yok")%></td>
                        </tr>
                        <%
                            end if
                            do while not satis.eof

                                 



                            if trim(satis("gerceklesen_pb"))="TL" then
                                toplam_satinalma_tl = cdbl(toplam_satinalma_tl) + cdbl(satis("gerceklesen_tutar"))
                            elseif trim(satis("gerceklesen_pb"))="USD" then
                                toplam_satinalma_usd = cdbl(toplam_satinalma_usd) + cdbl(satis("gerceklesen_tutar"))
                            elseif trim(satis("gerceklesen_pb"))="EUR" then
                                toplam_satinalma_eur = cdbl(toplam_satinalma_eur) + cdbl(satis("gerceklesen_tutar"))
                            end if
                               
                        %>
                        <tr>
                            <td><span style="font-weight: bold;"><%=satis("satinalma_adi") %></span><br />
                                <%=satis("aciklama") %></td>
                            <td><%=satis("firma_adi") %></td>
                            <td style="width: 120px;">
                                <% if trim(satis("satinalma_durum"))="Planlandı" then %>
                                <label class="label label-primary" style="font-size: 12px; width: 150px; margin-left: auto; margin-right: auto;"><%=LNG("PLANLANDI")%></label>
                                <% elseif trim(satis("satinalma_durum"))="Alındı" then %>
                                <label class="label label-info" style="font-size: 12px; width: 150px; margin-left: auto; margin-right: auto;"><%=LNG("ALINDI")%></label>
                                <% elseif trim(satis("satinalma_durum"))="Sipariş Verildi" then %>
                                <label class="label label-warning" style="font-size: 12px; width: 150px; margin-left: auto; margin-right: auto;"><%=LNG("SİPARİŞ VERİLDİ")%></label>
                                <% elseif trim(satis("satinalma_durum"))="Ödendi" then %>
                                <label class="label label-success" style="font-size: 12px; width: 150px; margin-left: auto; margin-right: auto;"><%=LNG("ÖDENDİ")%></label>
                                <% end if %>
                            </td>
                            <td style="text-align: center;"><%=formatnumber(satis("ongorulen_tutar"),2) %>&nbsp;<%=satis("ongorulen_pb") %></td>
                            <td style="color: red; text-align: center;"><%=formatnumber(satis("gerceklesen_tutar"),2) %>&nbsp;<%=satis("gerceklesen_pb") %></td>

                        </tr>
                        <%
                            
                            satis.movenext
                            loop
                        %>
                    </tbody>
                </table>
            </div>
        </fieldset>
        <%
                        butce.movenext
                        loop
        %>


        <%
            SQL="SELECT departman.departman_adi, kullanici.personel_ad, kullanici.personel_soyad,SUM(hesaplama.saat) AS saat, ISNULL( CONVERT(DECIMAL(18, 2), (SUM(hesaplama.saat)) * ISNULL(((CASE WHEN hesaplama.tip = 'PERSONEL' THEN kullanici2.personel_saatlik_maliyet WHEN hesaplama.tip = 'TASERON' THEN firma.taseron_saatlik_maliyet END)), 0)), 0 ) AS maliyet_tutari, 'TL' AS pb FROM tanimlama_departman_listesi departman JOIN dbo.ucgem_firma_kullanici_listesi kullanici ON departman.firma_id = kullanici.firma_id AND kullanici.cop = departman.cop AND kullanici.cop = departman.cop AND kullanici.cop = 'false' AND kullanici.durum = 'true' JOIN ( SELECT kaynak.tip, olay.etiketler, kaynak.id, olay.baslangic AS baslangic, SUM((DATEDIFF( n, CONVERT(DATETIME, olay.baslangic) + CONVERT(DATETIME, olay.baslangic_saati), CONVERT(DATETIME, olay.bitis) + CONVERT(DATETIME, olay.bitis_saati) ) ) * 0.016667 ) AS saat FROM dbo.gantt_kaynaklar kaynak JOIN ahtapot_ajanda_olay_listesi olay ON olay.etiket = kaynak.tip AND olay.etiket_id = kaynak.id AND (SELECT COUNT(value) FROM STRING_SPLIT(olay.etiketler, ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(10), '1795')) > 0 AND olay.durum = 'true' AND olay.cop = 'false' AND olay.tamamlandi = 1 WHERE kaynak.tip = 'PERSONEL' GROUP BY kaynak.id, olay.baslangic, olay.etiketler, kaynak.tip ) hesaplama ON hesaplama.id = kullanici.id AND (SELECT COUNT(value) FROM STRING_SPLIT(hesaplama.etiketler, ',') WHERE value = 'departman-' + CONVERT(NVARCHAR(10),departman.id)) > 0  LEFT JOIN dbo.ucgem_firma_kullanici_listesi kullanici2 ON kullanici2.id = hesaplama.id LEFT JOIN dbo.ucgem_firma_listesi firma ON firma.id = hesaplama.id WHERE departman.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' AND departman.durum = 'true' AND departman.cop = 'false' GROUP BY departman.departman_adi, kullanici.personel_ad, kullanici.personel_soyad, hesaplama.tip, kullanici2.personel_saatlik_maliyet, firma.taseron_saatlik_maliyet ORDER BY departman.departman_adi, kullanici.personel_ad + ' ' + kullanici.personel_soyad"
            set departman = baglanti.execute(SQL)
            
            son_Departman = ""
            hic_girdimi = false
            do while not departman.eof

                if not trim(son_Departman) = trim(departman("departman_adi")) then
                    son_Departman = trim(departman("departman_adi"))
                    if hic_girdimi = true then
                        
        %>
                    </tbody>
                </table>
            </fieldset>
            <% end if %>
        <div>
            <fieldset visible="true" style="border: 1px solid #cccccc; padding: 15px; margin-bottom: 15px;">
                <legend style="width: auto; padding-left: 5px; padding-right: 5px; font-size: 15px;"><%=departman("departman_adi") %> <%=LNG("İŞÇİLİKLERİ")%></legend>
                <div>
                    <table id="new-cons2" class="table table-striped table-bordered table-hover" width="100%">
                        <thead>
                            <tr>
                                <th style="color: #495057; background-color: #e9ecef; padding: .75rem; font-weight: bold; font-size: 15px; width: 50%;"><%=LNG("Personel Adı")%></th>
                                <th style="text-align: center; color: #495057; background-color: #e9ecef; padding: .75rem; font-weight: bold; font-size: 15px;"><%=LNG("Toplam Saat")%></th>
                                <th style="text-align: center; color: #495057; background-color: #e9ecef; padding: .75rem; font-weight: bold; font-size: 15px;"><%=LNG("Maliyet")%></th>
                            </tr>
                        </thead>
                        <tbody>
                            <% end if 

                        hic_girdimi = true

                        if trim(departman("pb"))="TL" then
                            toplam_iscilik_tl = cdbl(toplam_iscilik_tl) + cdbl(departman("maliyet_tutari"))
                        elseif trim(departman("pb"))="USD" then
                            toplam_iscilik_usd = cdbl(toplam_iscilik_usd) + cdbl(departman("maliyet_tutari"))
                        elseif trim(departman("pb"))="EUR" then
                            toplam_iscilik_eur = cdbl(toplam_iscilik_eur) + cdbl(departman("maliyet_tutari"))
                        end if

                            %>
                            <tr>
                                <td><%=departman("personel_ad") & " " & departman("personel_soyad") %></td>
                                <td style="text-align: center;">
                                    <label class="label label-primary" style="font-size: 12px; width: 150px; margin-left: auto; margin-right: auto;"><%=DakikadanSaatYap(cdbl(departman("saat"))*60) %></label></td>
                                <td style="text-align: center;">
                                    <label class="label label-success" style="font-size: 12px; width: 150px; margin-left: auto; margin-right: auto;"><%=formatnumber(departman("maliyet_tutari"),2) %>&nbsp;<%=departman("pb") %></label></td>
                            </tr>

                            <%
            departman.movenext
            loop
                            %>
                        </tbody>
                    </table>
                </div>
            </fieldset>
        </div>
        <h5 style="line-height: 30px; font-size: 15px;"><%=LNG("Proje Gelirleri")%></h5>
        <div class="dt-responsive table-responsive">
            <table id="new-cons" class="table table-striped table-bordered table-hover" width="100%">
                <thead>
                    <tr>
                        <th style="color: #495057; background-color: #e9ecef; font-weight: bold; font-size: 15px; width: 10px; max-width: 10px;"></th>
                        <th style="color: #495057; background-color: #e9ecef; padding: .75rem; font-weight: bold; font-size: 15px; width: 50%;"><%=LNG("Gelir Adı")%></th>
                        <th style="color: #495057; background-color: #e9ecef; padding: .75rem; font-weight: bold; font-size: 15px; width: 10%;"><%=LNG("Durum")%></th>
                        <th style="color: #495057; background-color: #e9ecef; padding: .75rem; font-weight: bold; font-size: 15px; width: 10%;"><%=LNG("Öngörülen Tarih")%></th>
                        <th style="color: #495057; background-color: #e9ecef; padding: .75rem; font-weight: bold; font-size: 15px; width: 10%;"><%=LNG("Gerçek Tarih")%></th>
                        <th style="color: #495057; background-color: #e9ecef; padding: .75rem; font-weight: bold; font-size: 15px; width: 9%;"><%=LNG("Tutar")%></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                SQL="select * from ahtapot_proje_gelir_listesi where proje_id = '"& proje_id &"' and durum = 'true' and cop = 'false' order by planlanan_tarih asc"
                set gelir = baglanti.execute(SQL)
                if gelir.eof then
                    %>
                    <tr>
                        <td colspan="5" style="text-align: center;"><%=LNG("Kayıt Yok")%></td>
                    </tr>
                    <%
                end if

                odenen_toplam_tl = 0
                odenen_toplam_usd = 0
                odenen_toplam_eur = 0

                kalan_toplam_tl = 0
                kalan_toplam_usd = 0
                kalan_toplam_eur = 0

                x = 0
                do while not gelir.eof
                    if trim(gelir("gelir_durum"))="Ödendi" then
                        if trim(gelir("odeme_pb"))="TL" then
                            odenen_toplam_tl = cdbl(odenen_toplam_tl) + cdbl(gelir("odeme_tutar"))
                        elseif trim(gelir("odeme_pb"))="USD" then
                            odenen_toplam_usd = cdbl(odenen_toplam_usd) + cdbl(gelir("odeme_tutar"))
                        elseif trim(gelir("odeme_pb"))="EUR" then
                            odenen_toplam_eur = cdbl(odenen_toplam_eur) + cdbl(gelir("odeme_tutar"))
                        end if
                    else
                        if trim(gelir("odeme_pb"))="TL" then
                            kalan_toplam_tl = cdbl(kalan_toplam_tl) + cdbl(gelir("odeme_tutar"))
                        elseif trim(gelir("odeme_pb"))="USD" then
                            kalan_toplam_usd = cdbl(kalan_toplam_usd) + cdbl(gelir("odeme_tutar"))
                        elseif trim(gelir("odeme_pb"))="EUR" then
                            kalan_toplam_eur = cdbl(kalan_toplam_eur) + cdbl(gelir("odeme_tutar"))
                        end if
                    end if

                




                x = x +1
                    %>
                    <tr>
                        <td style="width: 10px;"><strong><%=x %></strong></td>
                        <td><%=gelir("gelir_adi") %></td>
                        <td style="text-align: center;">
                            <label class="label label-lg label-<% if trim(gelir("gelir_durum"))="Ödendi" then %>success<% elseif trim(gelir("gelir_durum"))="Bekliyor" then %>warning<% elseif trim(gelir("gelir_durum"))="Ertelendi" then %>danger<% end if %>" style="font-size: 12px;"><%=LNG("Ödendi")%></label></td>
                        <td style="text-align: center;"><%=cdate(gelir("planlanan_tarih")) %></td>
                        <td style="text-align: center;"><% if trim(gelir("gelir_durum"))="Ödendi" then %><%=cdate(gelir("odeme_tarih")) %><% else %>---<% end if %></td>
                        <td style="text-align: center;">
                            <label style="display: block; font-size: 12px;" class="label label-lg label-<% if trim(gelir("gelir_durum"))="Ödendi" then %>success<% elseif trim(gelir("gelir_durum"))="Bekliyor" then %>warning<% elseif trim(gelir("gelir_durum"))="Ertelendi" then %>danger<% end if %>"><%=formatnumber(gelir("odeme_tutar"),2) %>&nbsp;<%=gelir("odeme_pb") %></label></td>
                    </tr>
                    <%
                gelir.movenext
                loop
                    %>
                    <tr>
                        <td colspan="5" style="text-align: right;"><strong><%=LNG("TAHSİL EDİLEN TOPLAM :")%> </strong></td>
                        <td style="line-height: 5px; text-align: center;">
                            <label class="label label-lg label-inverse" style="font-size: 12px;"><%=formatnumber(odenen_toplam_tl,2) %> TL</label><br />
                            <label class="label label-lg label-inverse" style="font-size: 12px;"><%=formatnumber(odenen_toplam_usd,2) %> USD</label><br />
                            <label class="label label-lg label-inverse" style="font-size: 12px;"><%=formatnumber(odenen_toplam_eur,2) %> EUR</label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5" style="text-align: right;"><strong><%=LNG("KALAN TOPLAM :")%> </strong></td>
                        <td style="line-height: 5px; text-align: center;">
                            <label class="label label-lg label-inverse" style="font-size: 12px;"><%=formatnumber(kalan_toplam_tl,2) %> TL</label><br />
                            <label class="label label-lg label-inverse" style="font-size: 12px;"><%=formatnumber(kalan_toplam_usd,2) %> USD</label><br />
                            <label class="label label-lg label-inverse" style="font-size: 12px;"><%=formatnumber(kalan_toplam_eur,2) %> EUR</label>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

    </div>
</div>
<div class="row">
    <div class="col-sm-12">
        <table class="table table-responsive invoice-table invoice-total">
            <tbody>
                <tr>
                    <th><%=LNG("Toplam Bütçe :")%></th>
                    <td><%=formatnumber(toplam_butce_tl,2) %>&nbsp;TL</td>
                    <td><%=formatnumber(toplam_butce_usd,2) %>&nbsp;USD</td>
                    <td><%=formatnumber(toplam_butce_eur,2) %>&nbsp;EUR</td>
                </tr>
                <tr>
                    <th><%=LNG("Kalan Bütçe :")%></th>
                    <td><%=formatnumber(toplam_butce_tl-toplam_satinalma_tl,2) %>&nbsp;TL</td>
                    <td><%=formatnumber(toplam_butce_usd-toplam_satinalma_usd,2) %>&nbsp;USD</td>
                    <td><%=formatnumber(toplam_butce_eur-toplam_satinalma_eur,2) %>&nbsp;EUR</td>
                </tr>
                <tr>
                    <td colspan="4"></td>
                </tr>
                <tr>
                    <th><%=LNG("Satınalmalar Toplamı :")%></th>
                    <td><%=formatnumber(toplam_satinalma_tl,2) %>&nbsp;TL</td>
                    <td><%=formatnumber(toplam_satinalma_usd,2) %>&nbsp;USD</td>
                    <td><%=formatnumber(toplam_satinalma_eur,2) %>&nbsp;EUR</td>
                </tr>


                <tr>
                    <th><%=LNG("İşçilikler Toplamı :")%></th>
                    <td><%=formatnumber(toplam_iscilik_tl,2) %>&nbsp;TL</td>
                    <td><%=formatnumber(toplam_iscilik_usd,2) %>&nbsp;USD</td>
                    <td><%=formatnumber(toplam_iscilik_eur,2) %>&nbsp;EUR</td>
                </tr>
                <tr>
                    <th><%=LNG("Gelirler Toplamı :")%></th>
                    <td><%=formatnumber(odenen_toplam_tl,2) %>&nbsp;TL</td>
                    <td><%=formatnumber(odenen_toplam_usd,2) %>&nbsp;USD</td>
                    <td><%=formatnumber(odenen_toplam_eur,2) %>&nbsp;EUR</td>
                </tr>
                <tr class="text-info">
                    <td colspan="4">
                        <h5 class="text-primary"><%=LNG("Genel Toplam")%></h5>
                    </td>
                </tr>
                <%
                    genel_toplam_tl = cdbl(odenen_toplam_tl) - (cdbl(toplam_satinalma_tl) + cdbl(toplam_iscilik_tl))
                    genel_toplam_usd = cdbl(odenen_toplam_usd) - (cdbl(toplam_satinalma_usd) + cdbl(toplam_iscilik_eur))
                    genel_toplam_eur = cdbl(odenen_toplam_eur) - (cdbl(toplam_satinalma_usd) + cdbl(toplam_iscilik_eur))

                    
                %>
                <tr class="text-info">
                    <td></td>
                    <td>
                        <h5 class="text-primary"><%=formatnumber(genel_toplam_tl,2) %>&nbsp;TL</h5>
                    </td>
                    <td>
                        <h5 class="text-primary"><%=formatnumber(genel_toplam_usd,2) %>&nbsp;USD</h5>
                    </td>
                    <td>
                        <h5 class="text-primary"><%=formatnumber(genel_toplam_eur,2) %>&nbsp;EUR</h5>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
<%
    elseif trn(request("islem"))="personel_performans_raporu_getir" then

        baslangic_tarihi = trn(request("baslangic_tarihi"))
        bitis_tarihi = trn(request("bitis_tarihi"))
        rapor_personel_id = trn(request("rapor_personel_id"))
        etiketler = trn(request("etiketler"))
        yeni_is_yuku_proje_id = trn(request("yeni_is_yuku_proje_id"))


%>
<div class="col-md-6">
    <fieldset visible="true" style="border: 1px solid #cccccc; padding: 15px; margin-bottom: 15px;">
        <legend style="width: auto; padding-left: 5px; padding-right: 5px; font-size: 15px;"><%=LNG("Departmanlara Harcanan Süre")%></legend>
        <%

            if isdate(baslangic_tarihi)=true and isdate(bitis_tarihi)=true then
                'tarih_str = " AND (('"& baslangic_tarihi &"' BETWEEN olay.baslangic AND olay.bitis) OR ('"& bitis_tarihi &"' BETWEEN olay.baslangic AND olay.bitis))"
                tarih_str = " and ((calisma.baslangic BETWEEN CONVERT(DATETIME,'"& baslangic_tarihi &"',103) AND CONVERT(DATETIME,'"& bitis_tarihi &"',103))  OR (calisma.bitis BETWEEN CONVERT(DATETIME,'"& baslangic_tarihi &"',103) AND CONVERT(DATETIME,'"& bitis_tarihi &"',103)))"
            elseif isdate(baslangic_tarihi)=true then
                tarih_str = " AND calisma.baslangic<=CONVERT(DATETIME,'"& baslangic_tarihi &"',103)"
            elseif isdate(bitis_tarihi)=true then
                tarih_str = " AND calisma.bitis>=CONVERT(DATETIME,'"& bitis_tarihi &"',103)"
            end if


            if not trim(rapor_personel_id)="0" then
                kullanici_str = " and kullanici.id = '"& rapor_personel_id &"'"
                kullanici_str2 = " AND calisma.ekleyen_id = '"& rapor_personel_id &"'"
            end if

            if not trim(etiketler)="0" then
                etiket_str = " AND (SELECT COUNT(value) FROM STRING_SPLIT((select departmanlar from ucgem_is_listesi where id = calisma.is_id), ',') WHERE value = '"& etiketler &"') > 0"
                etiket_str2 = " AND departman.id = '"& split(etiketler, "-")(1) &"'"
            end if

            if not trim(yeni_is_yuku_proje_id)="0" then
                proje_str = " AND (SELECT COUNT(value) FROM STRING_SPLIT((select departmanlar from ucgem_is_listesi where id = calisma.is_id), ',') WHERE value = 'proje-"& yeni_is_yuku_proje_id &"') > 0"
            end if

            SQL="SELECT departman.departman_adi, dbo.DakikadanSaatYap( ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT(DATETIME, calisma.baslangic ,103), CONVERT(DATETIME, calisma.bitis,103)))), 0 ) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT((select departmanlar from ucgem_is_listesi where id = calisma.is_id), ',') WHERE value = 'departman-' + CONVERT(NVARCHAR(50), departman.id)) > 0 " & kullanici_str2 &  tarih_str & etiket_str & proje_str &" AND calisma.durum = 'true' AND calisma.cop = 'false' ) ) AS gosterge_sayisi, ( ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT(DATETIME, calisma.baslangic ,103), CONVERT(DATETIME, calisma.bitis,103)))), 0) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT((select departmanlar from ucgem_is_listesi where id = calisma.is_id), ',') WHERE value = 'departman-' + CONVERT(NVARCHAR(50), departman.id)) > 0"& kullanici_str2 & tarih_str & etiket_str & proje_str &" AND calisma.durum = 'true' AND calisma.cop = 'false' ) ) AS gosterge_sayisi2 FROM dbo.ucgem_firma_kullanici_listesi kullanici JOIN dbo.tanimlama_departman_listesi departman ON departman.firma_id = kullanici.firma_id "& etiket_str2 &" AND departman.cop = 'false' AND departman.durum = 'true' WHERE kullanici.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' "& kullanici_str &" AND ((SELECT ISNULL( SUM((DATEDIFF( n, CONVERT(DATETIME, calisma.baslangic ,103), CONVERT(DATETIME, calisma.bitis,103)))), 0 ) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE calisma.ekleyen_id = kullanici.id AND (SELECT COUNT(value) FROM STRING_SPLIT((select departmanlar from ucgem_is_listesi where id = calisma.is_id), ',') WHERE value = 'departman-' + CONVERT(NVARCHAR(50), departman.id)) > 0"& tarih_str & etiket_str & proje_str &" AND calisma.durum = 'true' AND calisma.cop = 'false' ) ) > 0 GROUP BY departman.departman_adi, departman.id;"
            set sayilar = baglanti.execute(SQL)
            'response.Write(SQL)
        %>


        <table class="table" width="100%" style="width: 100%;">
            <thead>
                <tr>
                    <th style="text-align: left; vertical-align: middle; width: 200px; max-width: 35%;"><%=LNG("Departman")%></th>
                    <th style="text-align: center; vertical-align: middle; width: 15%;" width="20%"><%=LNG("Saat")%></th>
                    <th></th>
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
                    <td colspan="3" style="text-align: center;"><%=LNG("Kayıt Yok")%></td>
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

                %>

                <tr>
                    <td style="text-align: center; text-align: left;"><%=sayilar("departman_adi") %></td>
                    <td style="text-align: center;"><%=sayilar("gosterge_sayisi") %></td>
                    <td style="padding-left: 15px; text-align: left;">
                        <img src="/img/raporbar.png" width="<%=eldeki %>%" style="width: <%=eldeki %>%; height: 20px;" /></td>
                </tr>
                <%
        sayilar.movenext
        loop
                %>
            </tbody>
            <tfoot>
                <tr>
                    <td style="text-align: right;"><strong><%=LNG("TOPLAM:")%> </strong></td>
                    <td style="text-align: center;"><%=DakikadanSaatYap(toplam_tutar) %></td>
                    <td></td>
                </tr>
            </tfoot>
        </table>
    </fieldset>
</div>

<div class="col-md-6">
    <fieldset visible="true" style="border: 1px solid #cccccc; padding: 15px; margin-bottom: 15px;">
        <legend style="width: auto; padding-left: 5px; padding-right: 5px; font-size: 15px;"><%=LNG("Projelere Harcanan Süre")%></legend>



        <%

                                    if isdate(baslangic_tarihi)=true and isdate(bitis_tarihi)=true then
                                        tarih_str = " AND ((CONVERT(DATETIME,'"& baslangic_tarihi &"',103) BETWEEN calisma.baslangic AND calisma.bitis) OR (CONVERT(DATETIME,'"& bitis_tarihi &"',103) BETWEEN calisma.baslangic AND calisma.bitis))"
                                        tarih_str = " and ((calisma.baslangic BETWEEN CONVERT(DATETIME,'"& baslangic_tarihi &"',103) AND CONVERT(DATETIME,'"& bitis_tarihi &"',103))  OR (calisma.bitis BETWEEN CONVERT(DATETIME,'"& baslangic_tarihi &"',103) AND CONVERT(DATETIME,'"& bitis_tarihi &"',103)))"
                                    elseif isdate(baslangic_tarihi)=true then
                                        tarih_str = " AND calisma.baslangic<=CONVERT(DATETIME,'"& baslangic_tarihi &"',103)"
                                    elseif isdate(bitis_tarihi)=true then
                                        tarih_str = " AND calisma.bitis>=CONVERT(DATETIME,'"& bitis_tarihi &"',103)"
                                    end if

                                    if not trim(rapor_personel_id)="0" then
                                        kullanici_str = " and kullanici.id = '"& rapor_personel_id &"'"
                                        kullanici_str2 = " and calisma.ekleyen_id = '"& rapor_personel_id &"'"
                                    end if

                                    if not trim(etiketler)="0" then
                                        etiket_str = " AND (SELECT COUNT(value) FROM STRING_SPLIT((select departmanlar from ucgem_is_listesi where id = calisma.is_id), ',') WHERE value = '"& etiketler &"') > 0"
                                    end if

                                    if not trim(yeni_is_yuku_proje_id)="0" then
                                        proje_str = " AND proje.id = '"& yeni_is_yuku_proje_id &"'"
                                    end if

                                  

                                    SQL="SELECT proje.proje_adi, dbo.DakikadanSaatYap((SELECT ISNULL(SUM((DATEDIFF(n, CONVERT(DATETIME, calisma.baslangic,103), CONVERT(DATETIME, calisma.bitis,103)))), 0) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT((select departmanlar from ucgem_is_listesi where id = calisma.is_id), ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(50), proje.id)) > 0 AND calisma.durum = 'true' AND calisma.cop = 'false'"& kullanici_str2 &  tarih_str & etiket_str &")) AS gosterge_sayisi, ((SELECT ISNULL( SUM((DATEDIFF( n, CONVERT(DATETIME, calisma.baslangic,103), CONVERT(DATETIME, calisma.bitis,103)))), 0) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT((select departmanlar from ucgem_is_listesi where id = calisma.is_id), ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(50), proje.id)) > 0 AND calisma.durum = 'true' AND calisma.cop = 'false'"& kullanici_str2 &  tarih_str & etiket_str &" ) ) AS gosterge_sayisi2 FROM dbo.ucgem_proje_listesi proje where proje.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' "& proje_str  &" AND proje.cop = 'false' AND proje.durum = 'true' AND ( ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT(DATETIME, calisma.baslangic,103), CONVERT(DATETIME, calisma.bitis,103)))), 0) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT((select departmanlar from ucgem_is_listesi where id = calisma.is_id), ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(50), proje.id)) > 0 AND calisma.durum = 'true' AND calisma.cop = 'false'"& kullanici_str2 &  tarih_str & etiket_str &" ) ) > 0 GROUP BY proje.proje_adi, proje.id;"
                                    set sayilar = baglanti.execute(SQL)
        %>


        <table class="table" width="100%" style="width: 100%;">
            <thead>
                <tr>
                    <th style="text-align: left; vertical-align: middle; width: 200px; max-width: 35%;"><%=LNG("Proje")%></th>
                    <th style="text-align: center; vertical-align: middle; width: 15%;" width="20%"><%=LNG("Saat")%></th>
                    <th></th>
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
                    <td colspan="3" style="text-align: center;"><%=LNG("Kayıt Yok")%></td>
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
                %>

                <tr>
                    <td style="text-align: center; text-align: left;"><%=sayilar("proje_adi") %></td>
                    <td style="text-align: center;"><%=sayilar("gosterge_sayisi") %></td>
                    <td style="padding-left: 15px; text-align: left;">
                        <img src="/img/raporbar.png" width="<%=eldeki %>%" style="width: <%=eldeki %>%; height: 20px;" /></td>
                </tr>
                <%
        sayilar.movenext
        loop
                %>
            </tbody>
            <tfoot>
                <tr>
                    <td style="text-align: right;"><strong><%=LNG("TOPLAM:")%> </strong></td>
                    <td style="text-align: center;"><%=DakikadanSaatYap(toplam_tutar) %></td>
                    <td></td>
                </tr>
            </tfoot>
        </table>
    </fieldset>

</div>

<div class="col-md-6">
    <fieldset visible="true" style="border: 1px solid #cccccc; padding: 15px; margin-bottom: 15px;">
        <legend style="width: auto; padding-left: 5px; padding-right: 5px; font-size: 15px;"><%=LNG("Projelere Göre İş Dağılımı")%></legend>


        <%

        if isdate(baslangic_tarihi)=true and isdate(bitis_tarihi)=true then
            tarih_str = " AND ((CONVERT(DATETIME,'"& baslangic_tarihi &"',103) BETWEEN iss.baslangic_tarihi AND iss.bitis_tarihi) OR (CONVERT(DATETIME,'"& bitis_tarihi &"',103) BETWEEN iss.baslangic_tarihi AND iss.bitis_tarihi))"
            tarih_str = " and ((iss.baslangic_tarihi BETWEEN CONVERT(DATETIME,'"& baslangic_tarihi &"',103) AND CONVERT(DATETIME,'"& bitis_tarihi &"',103))  OR (iss.bitis_tarihi BETWEEN CONVERT(DATETIME,'"& baslangic_tarihi &"',103) AND CONVERT(DATETIME,'"& bitis_tarihi &"',103)))"
        elseif isdate(baslangic_tarihi)=true then
            tarih_str = " AND iss.baslangic_tarihi<=CONVERT(DATETIME,'"& baslangic_tarihi &"',103)"
        elseif isdate(bitis_tarihi)=true then
            tarih_str = " AND iss.bitis_tarihi>=CONVERT(DATETIME,'"& bitis_tarihi &"',103)"
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


      SQL="SELECT ROW_NUMBER() OVER (ORDER BY proje.id ASC) AS rowid, 0 AS santiye_sayi, proje.id, proje.proje_adi, ( SELECT COUNT(iss.id) FROM ucgem_is_listesi iss JOIN dbo.ucgem_is_gorevli_durumlari durum ON durum.is_id = iss.id "& kullanici_str &" WHERE iss.durum = 'true' AND iss.cop = 'false' AND (SELECT COUNT(value) FROM STRING_SPLIT(iss.departmanlar, ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(10), proje.id)) > 0 "& tarih_str & etiket_str &" ) AS gosterge_sayisi, ( SELECT COUNT(id) FROM ucgem_is_listesi WHERE durum = 'true' AND cop = 'false' AND firma_id = proje.firma_id ) AS tum_sayi FROM dbo.ucgem_proje_listesi proje WHERE proje.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' "& proje_str &" AND proje.durum = 'true' AND proje.cop = 'false' AND ( SELECT COUNT(iss.id) FROM ucgem_is_listesi iss JOIN dbo.ucgem_is_gorevli_durumlari durum ON durum.is_id = iss.id "& kullanici_str &" WHERE iss.durum = 'true' AND iss.cop = 'false' AND (SELECT COUNT(value) FROM STRING_SPLIT(iss.departmanlar, ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(10), proje.id)) > 0 "& tarih_str & etiket_str &" ) > 0 GROUP BY proje.id, proje.proje_adi, proje.firma_id ORDER BY proje.proje_adi ASC;"
            set sayilar = baglanti.execute(SQL)

        %>


        <table class="table" width="100%" style="width: 100%;">
            <thead>
                <tr>
                    <th style="text-align: left; vertical-align: middle; width: 200px; max-width: 35%;"><%=LNG("Proje")%></th>
                    <th style="text-align: center; vertical-align: middle; width: 15%;" width="20%"><%=LNG("İş Sayısı")%></th>
                    <th></th>
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
                    <td colspan="3" style="text-align: center;"><%=LNG("Kayıt Yok")%></td>
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

                %>

                <tr>
                    <td style="text-align: center; text-align: left;"><%=sayilar("proje_adi") %></td>
                    <td style="text-align: center;"><%=sayilar("gosterge_sayisi") %></td>
                    <td style="padding-left: 15px; text-align: left;">
                        <img src="/img/raporbar.png" width="<%=eldeki %>%" style="width: <%=eldeki %>%; height: 20px;" /></td>
                </tr>
                <%
        sayilar.movenext
        loop
                %>
            </tbody>
            <tfoot>
                <tr>
                    <td style="text-align: right;"><strong><%=LNG("TOPLAM:")%> </strong></td>
                    <td style="text-align: center;"><%=toplam_tutar %></td>
                    <td></td>
                </tr>
            </tfoot>
        </table>
    </fieldset>
</div>
<%

        if isdate(baslangic_tarihi)=true and isdate(bitis_tarihi)=true then
            tarih_str = " AND ((CONVERT(DATETIME,'"& baslangic_tarihi &"',103) BETWEEN iss.baslangic_tarihi AND iss.bitis_tarihi) OR (CONVERT(DATETIME,'"& bitis_tarihi &"',103) BETWEEN iss.baslangic_tarihi AND iss.bitis_tarihi))"
            tarih_str = " and ((iss.baslangic_tarihi BETWEEN CONVERT(DATETIME,'"& baslangic_tarihi &"',103) AND CONVERT(DATETIME,'"& bitis_tarihi &"',103))  OR (iss.bitis_tarihi BETWEEN CONVERT(DATETIME,'"& baslangic_tarihi &"',103) AND CONVERT(DATETIME,'"& bitis_tarihi &"',103)))"
        elseif isdate(baslangic_tarihi)=true then
            tarih_str = " AND iss.baslangic_tarihi<=CONVERT(DATETIME,'"& baslangic_tarihi &"',103)"
        elseif isdate(bitis_tarihi)=true then
            tarih_str = " AND iss.bitis_tarihi>=CONVERT(DATETIME,'"& bitis_tarihi &"',103)"
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


    SQL="SELECT ROW_NUMBER() OVER (ORDER BY departman.id ASC) AS rowid, 0 AS santiye_sayi, departman.id, departman.departman_adi, departman.departman_tipi, departman.sirano, ( SELECT COUNT(iss.id) FROM ucgem_is_listesi iss JOIN dbo.ucgem_is_gorevli_durumlari durum ON durum.is_id = iss.id WHERE iss.durum = 'true' AND iss.cop = 'false' AND (ISNULL(iss.tamamlanma_orani, 0) != 100) AND (SELECT COUNT(value) FROM STRING_SPLIT(iss.departmanlar, ',') WHERE value = 'departman-' + CONVERT(NVARCHAR(10), departman.id)) > 0 "& etiket_str & tarih_str & kullanici_str & proje_str &" ) AS gosterge_sayisi FROM tanimlama_departman_listesi departman WHERE departman.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' AND departman.durum = 'true' AND departman.cop = 'false' AND ( SELECT COUNT(iss.id) FROM ucgem_is_listesi iss JOIN dbo.ucgem_is_gorevli_durumlari durum ON durum.is_id = iss.id WHERE iss.durum = 'true' and iss.cop = 'false' AND (ISNULL(iss.tamamlanma_orani, 0) != 100) AND (SELECT COUNT(value) FROM STRING_SPLIT(iss.departmanlar, ',') WHERE value = 'departman-' + CONVERT(NVARCHAR(10), departman.id)) > 0 "& etiket_str &  tarih_str & kullanici_str & proje_str &" )>0 GROUP BY departman.id, departman.departman_adi, departman.departman_tipi, departman.sirano, departman.firma_id ORDER BY departman.departman_adi asc;"
    set sayilar = baglanti.execute(SQL)

%>
<div class="col-md-6">
    <fieldset visible="true" style="border: 1px solid #cccccc; padding: 15px; margin-bottom: 15px;">
        <legend style="width: auto; padding-left: 5px; padding-right: 5px; font-size: 15px;"><%=LNG("Etiketlere Göre İş Dağılımı")%></legend>

        <br />
        <table class="table" width="100%" style="width: 100%;">
            <thead>
                <tr>
                    <th style="text-align: left; vertical-align: middle; width: 200px; max-width: 35%;"><%=LNG("Departman")%></th>
                    <th style="text-align: center; vertical-align: middle; width: 15%;" width="20%"><%=LNG("İş Sayısı")%></th>
                    <th></th>
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
                    <td colspan="3" style="text-align: center;"><%=LNG("Kayıt Yok")%></td>
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

                %>

                <tr>
                    <td style="text-align: center; text-align: left;"><%=sayilar("departman_adi") %></td>
                    <td style="text-align: center;"><%=sayilar("gosterge_sayisi") %></td>
                    <td style="padding-left: 15px; text-align: left;">
                        <img src="/img/raporbar.png" width="<%=eldeki %>%" style="width: <%=eldeki %>%; height: 20px;" /></td>
                </tr>
                <%
        sayilar.movenext
        loop
                %>
            </tbody>
            <tfoot>
                <tr>
                    <td style="text-align: right;"><strong><%=LNG("TOPLAM:")%> </strong></td>
                    <td style="text-align: center;"><%=toplam_tutar %></td>
                    <td></td>
                </tr>
            </tfoot>
        </table>
    </fieldset>
</div>

<%
    elseif trn(request("islem"))="proje_adam_saat_getir_rapor" then

        rapor_personel_id = trn(request("rapor_personel_id"))
        etiketler = trn(request("etiketler"))
        yeni_is_yuku_proje_id = trn(request("yeni_is_yuku_proje_id"))
        baslangic = trn(request("baslangic"))
        bitis = trn(request("bitis"))

%>
<div class="col-lg-12">
    <style>
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

    <%
        dongu_baslangic = cdate(baslangic)
        dongu_bitis = cdate(bitis)
    %>
    <div class="h5" style="font-size: 15px;"><%=LNG("Adam-Saat Cetveli")%></div>

    <div class="tablediv" style="width: 100%; margin-top: 15px; overflow: auto;">
        <div id="tablediv">
            <table id="tablegosterge" style="border-color: #e8e8e8; font-family: Tahoma; width: 100%;">
                <thead id="thead">
                    <tr>
                        <th rowspan="2" class="ilkth headcol">
                            <div style="width: 150px;"><%=LNG("Kaynaklar")%></div>
                        </th>
                        <th rowspan="2" class="ilkth headcol ">
                            <div style="width: 80px; text-align: center; margin-left: auto; margin-right: auto;">
                                <%=LNG("Saat")%>
                            </div>
                        </th>
                        <th rowspan="2" class="ilkth headcol ">
                            <div style="width: 80px; text-align: center; margin-left: auto; margin-right: auto;">
                                <%=LNG("Maliyet")%>
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
                        <th class="ust_th" colspan="<%=cols %>"><%=monthname(son_ay) %>&nbsp;<%=year(x) %></th>
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

                                        SQL="EXEC dbo.ProjeAdamSaatCetveliRapor @proje_id = '"& yeni_is_yuku_proje_id &"', @firma_id = '"& Request.Cookies("kullanici")("firma_id") &"', @baslangic = '"& dongu_baslangic &"', @bitis = '"& dongu_bitis &"', @rapor_personel_id = '"& rapor_personel_id &"', @etiketler = '"& etiketler &"';"
                        'response.Write(SQL)
                                        set cetvel = baglanti.execute(sql)

                                        tarih_sayi = cdate(dongu_bitis) - cdate(dongu_baslangic) + 1

                                        Dim gun_toplam_rapor()
                                        Redim gun_toplam_rapor(tarih_sayi)
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
                            toplam_calisma_saati = cetvel("toplam_calisma_saati")

                            toplam_saat = cdbl(toplam_saat) + cdbl(cetvel("kaynak_toplam_saat"))
                            toplam_tutar = cdbl(toplam_tutar) + cdbl(cetvel("kaynak_toplam_maliyet"))
                        %>
                        <td style="width: 150px;" class="ust_td2 headcol"><%=cetvel("kaynak") %></td>
                        <td class="gosterge_td alt_td "><%=cetvel("calisma_suresi") %></td>
                        <td class=" gosterge_td alt_td sagcizgi"><%=cetvel("kaynak_toplam_maliyet") %> TL</td>
                        <% end if %>
                        <td class="alt_td <% if day(cetvel("tarih"))=1 then %> alt_td2 <% end if %> <% if cdate(cetvel("tarih"))=cdate(date) then %> sarialan <% end if %> "><% if cdbl(cetvel("maliyet_tutari"))=0 then %>-<% else %>
                            <%=cetvel("calisma_saati") %><br />
                            <%=cetvel("maliyet_tutari") %> TL<% end if %></td>
                        <%  
                            'response.Write(gunsayi)
                                gun_toplam_rapor(gunsayi) = cdbl(gun_toplam_rapor(gunsayi)) + cdbl(cetvel("maliyet_tutari"))
                                gunsayi = gunsayi + 1
                            cetvel.movenext
                            loop
                        %>
                    </tr>
                    <tr>
                        <td class="ust_td2 headcol" style="width: 150px; background-color: #4d7193; color: white!important;"><%=LNG("TOPLAM")%></td>
                        <td class="gosterge_td alt_td "><%=toplam_calisma_saati %></td>
                        <td class=" gosterge_td alt_td sagcizgi"><%=toplam_tutar %> TL</td>
                        <% for x = 0 to ubound(gun_toplam_rapor)-1 %>
                        <td class="alt_td" style="background-color: #4d7193; color: white;"><%=gun_toplam_rapor(x) %>TL</td>
                        <% next %>
                    </tr>
                    <%
                        Erase gun_toplam_rapor
                    %>
                </tbody>
            </table>
        </div>
    </div>


</div>
<%

    elseif trn(request("islem"))="personel_adam_saat_rapor_getir" then

        personel_id = trn(request("rapor_personel_id"))
        baslangic = trn(request("baslangic"))
        bitis = trn(request("bitis"))
        is_yuku_gosterim_tipi = trn(request("is_yuku_gosterim_tipi"))
        etiketler = trn(request("etiketler"))
        yeni_is_yuku_proje_id = trn(request("yeni_is_yuku_proje_id"))

%>
<style>
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
<%
    dongu_baslangic = cdate(baslangic)
    dongu_bitis = cdate(bitis)


        gosterim_tipi = trn(request("is_yuku_gosterim_tipi"))
        etiketler = trn(request("etiketler"))
        proje_id = trn(request("yeni_is_yuku_proje_id"))


        SQL="EXEC dbo.PersonelAdamSaatCetveliRapor @personel_id = '"& personel_id &"', @firma_id = '"& Request.Cookies("kullanici")("firma_id") &"', @baslangic = '"& dongu_baslangic &"', @bitis = '"& dongu_bitis &"', @proje_id = '"& proje_id &"', @etiketler = '"& etiketler &"';"
        set cetvel = baglanti.execute(sql)
        'response.Write(SQL)
    if cetvel.eof then
%>
<!--<%=LNG("Girilen Kriterlere Uygun Kayıt Bulunamadı.")%>-->
<strong style="font-size:14px">Girilen Kriterlere Uygun Kayıt Bulunamadı</strong>
<% 
        Response.End
    end if%>
<div class="h5" style="font-size: 15px;"><%=LNG("Adam-Saat Cetveli")%></div>

<div class="tablediv" style="width: 100%; margin-top: 15px; overflow: auto;">
    <div id="tablediv">
        <table id="tablegosterge" style="border-color: #e8e8e8; width: 100%; font-family: Tahoma;">
            <thead id="thead">
                <tr>
                    <th rowspan="2" class="ilkth headcol">
                        <div style="width: 250px;"><%=LNG("Kaynaklar")%></div>
                    </th>
                    <th rowspan="2" class="ilkth headcol ">
                        <div style="width: 80px; text-align: center; margin-left: auto; margin-right: auto;">
                            <%=LNG("Saat")%>
                        </div>
                    </th>
                    <th rowspan="2" class="ilkth headcol ">
                        <div style="width: 80px; text-align: center; margin-left: auto; margin-right: auto;">
                            <%=LNG("Maliyet")%>
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
                    <th class="ust_th" colspan="<%=cols %>"><%=monthname(son_ay) %>&nbsp;<%=year(x) %></th>
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


                                        tarih_sayi = cdate(dongu_bitis) - cdate(dongu_baslangic)

                                        Dim gun_toplam_prapor()
                                        Redim gun_toplam_prapor(tarih_sayi)
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
                    <%
                        toplam_calisma_saati = cetvel("toplam_calisma_saati")                          
                        toplam_saat = cdbl(toplam_saat) + cdbl(cetvel("kaynak_toplam_saat"))
                        toplam_tutar = cdbl(toplam_tutar) + cdbl(cetvel("kaynak_toplam_maliyet"))
                    %>
                    <td style="width: 150px;" class="ust_td2 headcol"><%=cetvel("kaynak") %></td>
                    <td class="gosterge_td alt_td "><%=cetvel("calisma_suresi") %></td>
                    <td class=" gosterge_td alt_td sagcizgi">
                        <%=cetvel("kaynak_toplam_maliyet") %> TL            
                    </td>
                    <% end if %>
                    <td class="alt_td <% if day(cetvel("tarih"))=1 then %> alt_td2 <% end if %> <% if cdate(cetvel("tarih"))=cdate(date) then %> sarialan <% end if %> ">
                        <% if trim(gosterim_tipi)="0" then %>
                        <% if cdbl(cetvel("maliyet_tutari"))=0 then %>-<% else %><%=cetvel("maliyet_tutari") %>TL<% end if %>
                        <% else %>
                        <% if cetvel("calisma_saati")=  "00:00" then %>-<% else %><%=cetvel("calisma_saati") %><% end if %>
                        <% end if %>

                    </td>
                    <%  
                        if trim(gosterim_tipi)="0" then
                            gun_toplam_prapor(gunsayi) = cdbl(gun_toplam_prapor(gunsayi)) + cdbl(cetvel("maliyet_tutari"))
                        else
                            gun_toplam_prapor(gunsayi) = cdbl(gun_toplam_prapor(gunsayi)) + (cdbl(cetvel("saat")) * 60)
                        end if

                        gunsayi = gunsayi + 1
                        
                        cetvel.movenext
                        loop
                    %>
                </tr>
                <tr>
                    <td class="ust_td2 headcol" style="width: 150px; background-color: #4d7193; color: white!important;"><%=LNG("TOPLAM")%></td>
                    <td class="gosterge_td alt_td "><%=toplam_calisma_saati %></td>
                    <td class=" gosterge_td alt_td sagcizgi"><%=toplam_tutar %> TL</td>
                    <% for x = 0 to ubound(gun_toplam_prapor) %>
                    <td class="alt_td" style="background-color: #4d7193; color: white;">
                        <% if trim(gosterim_tipi)="0" then %>
                        <%=gun_toplam_prapor(x) %> TL
                                            <% else %>
                        <%=DakikadanSaatYap(gun_toplam_prapor(x)) %>
                        <% end if %>
                    </td>
                    <% next %>
                </tr>
                <%
                                        Erase gun_toplam_prapor
                %>
            </tbody>
        </table>
    </div>
</div>
<div>
</div>




<%

    elseif trn(request("islem"))="nakit_akis_takvim_getir" then

        baslangic_tarihi = trn(request("baslangic_tarihi"))
        bitis_tarihi = trn(request("bitis_tarihi"))


        if isdate(baslangic_tarihi) = false then
            baslangic_tarihi = cdate(date)
        end if


        if isdate(bitis_tarihi) = false then
            bitis_tarihi = cdate(date)+180
        end if
%>
<div class="dt-responsive table-responsive">
    <table class="table ">
        <thead>
            <tr>
                <th style="background-color: #e9ecef;"></th>
                <% for x = cdate(baslangic_tarihi) to cdate(bitis_tarihi) %>
                <th colspan="3" style="text-align: center; border-right: 1px #cccccc solid; background-color: #e9ecef;">
                    <div style="width: 250px; text-align: center; margin-left: auto; margin-right: auto;"><%=cdate(x) %></div>
                </th>
                <% next %>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td></td>
                <% for x = cdate(baslangic_tarihi) to cdate(bitis_tarihi) %>
                <th style="text-align: center;">TL</th>
                <th style="text-align: center;">$</th>
                <th style="text-align: center; border-right: 1px #cccccc solid;">€</th>
                <% next %>
            </tr>
            <tr>
                <td style="background-color: #fbfbfb;"><strong><%=LNG("TAHSİLATLAR")%></strong></td>
                <% 

                                            fark = cdate(bitis_tarihi) - cdate(baslangic_tarihi)

                                            dim bakiye_tl()
                                            redim bakiye_tl(fark+1)
                                            dim bakiye_usd()
                                            redim bakiye_usd(fark+1)
                                            dim bakiye_eur()
                                            redim bakiye_eur(fark+1)

                                            bakiye_tl(0) = 0
                                            bakiye_usd(0) = 0
                                            bakiye_eur(0) = 0

                                            SQL="DECLARE @baslangic DATE = '"& cdate(baslangic_tarihi) &"'; DECLARE @bitis DATE = '"& cdate(bitis_tarihi) &"'; SELECT DATEADD(DAY, spt.number, @baslangic) AS tarih, (SELECT ISNULL(SUM(meblag),0) FROM dbo.cari_hareketler WHERE islem_tipi = 'Tahsilat' AND parabirimi = 'TL' AND durum = 'true' AND cop = 'false' AND alacakli_id = '1' AND vade_tarihi = DATEADD(DAY, spt.number, @baslangic)) AS tahsilat_tl, (SELECT ISNULL(SUM(meblag),0) FROM dbo.cari_hareketler WHERE islem_tipi = 'Tahsilat' AND parabirimi = 'USD' AND durum = 'true' AND cop = 'false' AND alacakli_id = '1' AND vade_tarihi = DATEADD(DAY, spt.number, @baslangic)) AS tahsilat_usd, (SELECT ISNULL(SUM(meblag),0) FROM dbo.cari_hareketler WHERE islem_tipi = 'Tahsilat' AND parabirimi = 'USD' AND durum = 'true' AND cop = 'false' AND alacakli_id = '1' AND vade_tarihi = DATEADD(DAY, spt.number, @baslangic)) AS tahsilat_eur, (SELECT ISNULL(SUM(meblag),0) FROM dbo.cari_hareketler WHERE islem_tipi = 'Ödeme' AND parabirimi = 'TL' AND durum = 'true' AND cop = 'false' AND borclu_id = '1' AND vade_tarihi = DATEADD(DAY, spt.number, @baslangic)) AS odeme_tl, (SELECT ISNULL(SUM(meblag),0) FROM dbo.cari_hareketler WHERE islem_tipi = 'Ödeme' AND parabirimi = 'USD' AND durum = 'true' AND cop = 'false' AND borclu_id = '1' AND vade_tarihi = DATEADD(DAY, spt.number, @baslangic)) AS odeme_usd, (SELECT ISNULL(SUM(meblag),0) FROM dbo.cari_hareketler WHERE islem_tipi = 'Ödeme' AND parabirimi = 'USD' AND durum = 'true' AND cop = 'false' AND borclu_id = '1' AND vade_tarihi = DATEADD(DAY, spt.number, @baslangic)) AS odeme_eur FROM master..spt_values spt where spt.type = 'P' AND DATEADD(DAY, number, @baslangic) <= @bitis;"
                                            set cek = baglanti.execute(SQL)
                                            x = 0
                                            do while not cek.eof
                                             x = x +1

                                                bakiye_tl(x) = cdbl(bakiye_tl(x-1)) + (cdbl(cek("tahsilat_tl")) - cdbl(cek("odeme_tl")))
                                                bakiye_usd(x) = cdbl(bakiye_usd(x-1)) + (cdbl(cek("tahsilat_usd")) - cdbl(cek("odeme_usd")))
                                                bakiye_eur(x) = cdbl(bakiye_eur(x-1)) + (cdbl(cek("tahsilat_eur")) - cdbl(cek("odeme_eur")))


                %>
                <td style="text-align: center; background-color: #fbfbfb;"><% if cdbl(cek("tahsilat_tl"))>0 then %><%=formatnumber(cek("tahsilat_tl"),2) %> TL<% end if %></td>
                <td style="text-align: center; background-color: #fbfbfb;"><% if cdbl(cek("tahsilat_usd"))>0 then %><%=formatnumber(cek("tahsilat_usd"),2) %> $<% end if %></td>
                <td style="text-align: center; background-color: #fbfbfb; border-right: 1px #cccccc solid;"><% if cdbl(cek("tahsilat_eur"))>0 then %><%=formatnumber(cek("tahsilat_eur"),2) %> €<% end if %></td>
                <% 
                                            cek.movenext
                                            loop
                                            cek.movefirst

                %>
            </tr>
            <tr>
                <td><strong><%=LNG("ÖDEMELER")%></strong></td>
                <% 
                                            do while not cek.eof
                %>
                <td style="text-align: center;"><% if cdbl(cek("odeme_tl"))>0 then %><%=formatnumber(cek("odeme_tl"),2) %> TL<% end if %></td>
                <td style="text-align: center;"><% if cdbl(cek("odeme_usd"))>0 then %><%=formatnumber(cek("odeme_usd"),2) %> $<% end if %></td>
                <td style="text-align: center; border-right: 1px #cccccc solid;"><% if cdbl(cek("odeme_eur"))>0 then %><%=formatnumber(cek("odeme_eur"),2) %> €<% end if %></td>
                <% cek.movenext
                                           loop
                %>
            </tr>
            <tr>
                <td style="background-color: #e9ecef;"><strong><%=LNG("BAKİYE")%></strong></td>
                <% for x = 1 to fark+1 %>
                <td style="text-align: center; background-color: #e9ecef;"><%=formatnumber(bakiye_tl(x),2) %> TL</td>
                <td style="text-align: center; background-color: #e9ecef;"><%=formatnumber(bakiye_usd(x),2) %> $</td>
                <td style="text-align: center; background-color: #e9ecef; border-right: 1px #cccccc solid;"><%=formatnumber(bakiye_eur(x),2) %> €</td>
                <% next
                                            
                                            erase bakiye_tl
                                            erase bakiye_usd
                                            erase bakiye_eur
                %>
            </tr>
        </tbody>
    </table>
</div>


<hr />
<div class="dt-responsive table-responsive">
    <table border="1" style="border: solid 1px #ccc;" class="table ">
        <thead>
            <tr>
                <th rowspan="2" style="padding: .75rem; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("İşlem Türü")%></th>
                <th rowspan="2" style="padding: .75rem; vertical-align: middle; text-align: center; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("Tahsilat/Ödeme Tarihi")%></th>
                <th rowspan="2" style="padding: .75rem; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("Müşteri/Tedarikçi")%></th>
                <th rowspan="2" style="padding: .75rem; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("Açıklama")%></th>
                <th colspan="3" style="padding: .75rem; vertical-align: middle; text-align: center; border-right: 1px solid #000; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("Çıkış")%></th>
                <th colspan="3" style="padding: .75rem; vertical-align: middle; font-weight: bold; border-right: 1px solid #000; text-align: center; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("Giriş")%></th>
                <th colspan="3" style="padding: .75rem; vertical-align: middle; font-weight: bold; text-align: center; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("Bakiye")%></th>
            </tr>
            <tr>
                <th style="text-align: center; background: linear-gradient(45deg, #4099ff, #73b4ff); width: 150px;"><span class="label label-primary arkaplansiz badge-lg">TL</span></th>
                <th style="text-align: center; background: linear-gradient(45deg, #FF5370, #ff869a); width: 150px;"><span class="label label-danger arkaplansiz badge-lg ">$</span></th>
                <th style="text-align: center; background: linear-gradient(45deg, #FFB64D, #ffcb80); width: 150px; border-right: 1px solid #000;"><span class="label label-warning arkaplansiz badge-lg">€</span></th>
                <th style="text-align: center; background: linear-gradient(45deg, #4099ff, #73b4ff); width: 150px;"><span class="label label-primary arkaplansiz badge-lg">TL</span></th>
                <th style="text-align: center; background: linear-gradient(45deg, #FF5370, #ff869a); width: 150px;"><span class="label label-danger arkaplansiz badge-lg ">$</span></th>
                <th style="text-align: center; background: linear-gradient(45deg, #FFB64D, #ffcb80); width: 150px; border-right: 1px solid #000;"><span class="label label-warning arkaplansiz badge-lg">€</span></th>
                <th style="text-align: center; background: linear-gradient(45deg, #4099ff, #73b4ff); width: 150px;"><span class="label label-primary arkaplansiz badge-lg">TL</span></th>
                <th style="text-align: center; background: linear-gradient(45deg, #FF5370, #ff869a); width: 150px;"><span class="label label-danger arkaplansiz badge-lg ">$</span></th>
                <th style="text-align: center; background: linear-gradient(45deg, #FFB64D, #ffcb80); width: 150px;"><span class="label label-warning arkaplansiz badge-lg">€</span></th>
            </tr>

        </thead>
        <tbody>
            <% 
                                        SQL="SELECT CASE WHEN cari.islem_tipi = 'Ödeme' THEN firma2.firma_adi when cari.islem_tipi = 'Tahsilat' then firma.firma_adi END AS firma_adi, cari.* FROM dbo.cari_hareketler cari LEFT JOIN dbo.ucgem_firma_listesi firma ON firma.id = cari.borclu_id LEFT JOIN dbo.ucgem_firma_listesi firma2 ON firma2.id = cari.alacakli_id WHERE cari.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' AND cari.durum = 'true' AND cari.cop = 'false' AND cari.vade_tarihi between '"& cdate(baslangic_tarihi) &"' and '"& cdate(bitis_tarihi) &"' and (cari.islem_tipi = 'Ödeme' or cari.islem_tipi = 'Tahsilat')  ORDER BY cari.vade_tarihi DESC;;"
                                        set cek = baglanti.execute(SQL)

                                        if cek.eof then
            %>
            <tr>
                <td colspan="10" style="text-align: center;"><%=LNG("Kayıt Yok")%></td>
            </tr>
            <%
                                        end if

                                        alt_bakiye_tl = 0
                                        alt_bakiye_usd = 0
                                        alt_bakiye_eur = 0

                                        do while not cek.eof

                                            if trim(cek("parabirimi"))="TL" then
                                                alt_bakiye_tl = cdbl(alt_bakiye_tl) + cdbl(cek("meblag"))
                                            elseif trim(cek("parabirimi"))="USD" then
                                                alt_bakiye_usd = cdbl(alt_bakiye_usd) + cdbl(cek("meblag"))
                                            elseif trim(cek("parabirimi"))="EUR" then
                                                alt_bakiye_eur = cdbl(alt_bakiye_eur) + cdbl(cek("meblag"))
                                            end if
            %>
            <tr>
                <td><%=cek("akis_tipi") %>-<%=cek("islem_tipi") %></td>
                <td style="text-align: center;"><%=cdate(cek("vade_tarihi")) %></td>
                <td><%=cek("firma_adi") %></td>
                <td><%=cek("aciklama") %></td>
                <% if trim(cek("islem_tipi"))="Ödeme" then %>
                <td style="text-align: center; border-right: 1px #e8e8e8 solid;"><% if trim(cek("parabirimi"))="TL" then %><%=formatnumber(cek("meblag"),2) %> TL<% end if %></td>
                <td style="text-align: center; border-right: 1px #e8e8e8 solid;"><% if trim(cek("parabirimi"))="USD" then %><%=formatnumber(cek("meblag"),2) %> $<% end if %></td>
                <td style="text-align: center; border-right: 1px solid black;"><% if trim(cek("parabirimi"))="EUR" then %><%=formatnumber(cek("meblag"),2) %> €<% end if %></td>
                <td style="text-align: center; border-right: 1px #e8e8e8 solid;"></td>
                <td style="text-align: center; border-right: 1px #e8e8e8 solid;"></td>
                <td style="text-align: center; border-right: 1px solid black;"></td>
                <% else %>
                <td style="text-align: center; border-right: 1px #e8e8e8 solid;"></td>
                <td style="text-align: center; border-right: 1px #e8e8e8 solid;"></td>
                <td style="text-align: center; border-right: 1px solid black;"></td>
                <td style="text-align: center; border-right: 1px #e8e8e8 solid;"><% if trim(cek("parabirimi"))="TL" then %><%=formatnumber(cek("meblag"),2) %> TL<% end if %></td>
                <td style="text-align: center; border-right: 1px #e8e8e8 solid;"><% if trim(cek("parabirimi"))="USD" then %><%=formatnumber(cek("meblag"),2) %> $<% end if %></td>
                <td style="text-align: center; border-right: 1px solid black;"><% if trim(cek("parabirimi"))="EUR" then %><%=formatnumber(cek("meblag"),2) %> €<% end if %></td>
                <% end if %>
                <td style="text-align: center; border-right: 1px #e8e8e8 solid;"><%=formatnumber(alt_bakiye_tl,2) %> TL</td>
                <td style="text-align: center; border-right: 1px #e8e8e8 solid;"><%=formatnumber(alt_bakiye_usd,2) %> $</td>
                <td style="text-align: center; border-right: 1px solid black;"><%=formatnumber(alt_bakiye_eur,2) %> €</td>

            </tr>
            <% 
                                        cek.movenext
                                        loop
                                        
            %>
        </tbody>
    </table>
</div>

<%

    elseif trn(request("islem"))="proje_ic_liste_getir" then

        durum_id = trn(request("durum_id"))

        SQL="SELECT 999925216000000000 - isnull(dbo.ToTicks(CONVERT(DATETIME, proje.guncelleme_tarihi) + CONVERT(DATETIME, proje.guncelleme_saati)),0) guncelleme_ticks, 999925216000000000 - dbo.ToTicks(CONVERT(DATETIME, proje.ekleme_tarihi) + CONVERT(DATETIME, proje.ekleme_saati)) ekleme_ticks, isnull(proje.guncelleme_tarihi, getdate()) as guncelleme_tarihi, isnull(proje.guncelleme_saati, '00:00') as guncelleme_saati, guncelleyen.personel_ad + ' ' + guncelleyen.personel_soyad AS guncelleyen, musteri.firma_adi, kullanici.personel_ad + ' ' + kullanici.personel_soyad AS ekleyen, proje.ekleme_tarihi, proje.ekleme_saati, santiye_durum_id AS id, proje.id AS idd, UPPER(proje_adi) AS proje_adi, ( SELECT COUNT(id) FROM ucgem_is_listesi WHERE durum = 'true' AND cop = 'false' AND (ISNULL(tamamlanma_orani, 0) != 100) AND ( SELECT COUNT(value) FROM STRING_SPLIT(departmanlar, ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(50), proje.id) ) > 0 ) AS is_sayisi, ( SELECT COUNT(id) FROM ucgem_proje_olay_listesi olay WHERE olay.proje_id = proje.id AND olay.durum = 'true' AND olay.cop = 'false' ) AS gosterge_sayisi, proje.proje_kodu FROM ucgem_proje_listesi proje JOIN ucgem_firma_kullanici_listesi kullanici ON kullanici.id = proje.ekleyen_id  left JOIN ucgem_firma_kullanici_listesi guncelleyen ON guncelleyen.id = proje.guncelleyen_id  JOIN dbo.ucgem_firma_listesi musteri ON musteri.id = proje.proje_firma_id  WHERE proje.santiye_durum_id = '"& durum_id &"' AND proje.durum = 'true' AND proje.cop = 'false' ORDER BY proje.id DESC;"
        set cek = baglanti.execute(SQL)

        if cek.eof then

            SQL="select durum_adi from tanimlama_santiye_durum_listesi where id = '"& durum_id &"'"
            set cek2 = baglanti.execute(SQL)

%>
<br />
<br />
<center><%=cek2("durum_adi") %>&nbsp;<%=LNG("Kategorisinde Proje Bulunamadı.")%></center>
<br />
<% else %>
<table id="dt_basic" class="table table-striped table-bordered table-hover datatableyap" width="100%">
    <thead>
        <tr>
            <th data-hide="phone" style="line-height: 20px; padding: 5px!important; background-color: #000!important; color: white; text-align: center; height: 20px;"><%=LNG("Proje Kodu")%></th>
            <th data-class="expand" style="line-height: 20px; padding: 5px!important; background-color: #000!important; color: white; height: 20px;"><%=LNG("Proje Adı")%></th>
            <th data-hide="phone" style="line-height: 20px; padding: 5px!important; background-color: #000!important; color: white; text-align: center; height: 20px;"><%=LNG("Olay")%></th>
            <th data-hide="phone" style="line-height: 20px; padding: 5px!important; background-color: #000!important; color: white; text-align: center; height: 20px;"><%=LNG("İş")%></th>
            <th data-hide="phone" style="line-height: 20px; padding: 5px!important; background-color: #000!important; color: white; height: 20px;"><%=LNG("Firma")%></th>
            <th data-hide="phone" style="line-height: 20px; padding: 5px!important; background-color: #000!important; color: white; text-align: center; height: 20px;"><%=LNG("Ekleme Tarihi")%></th>
            <th data-hide="phone" style="line-height: 20px; padding: 5px!important; background-color: #000!important; color: white; text-align: center; height: 20px;"><%=LNG("Güncelleme Tarihi")%></th>
        </tr>
    </thead>
    <tbody>
        <% do while not cek.eof %>
        <tr>
            <td style="text-align: center; cursor: pointer" onclick="sayfagetir('/santiye_detay/','jsid=4559&id=<%=cek("idd") %>&departman_id=<%=cek("id") %>');"><span style="font-weight: 500;"><%=cek("proje_kodu") %></span></td>
            <td><span style="cursor: pointer;" onclick="sayfagetir('/santiye_detay/','jsid=4559&id=<%=cek("idd") %>&departman_id=<%=cek("id") %>');"><span style="font-weight: 500;"><%=cek("proje_adi") %></span></span></td>
            <td onclick="sayfagetir('/santiye_detay/','jsid=4559&id=<%=cek("idd") %>&departman_id=<%=cek("id") %>');" style="text-align: center; cursor: pointer; padding: 3px;">
                <label class="label label-primary" style="font-size: 130%; background: #000;"><%=cek("gosterge_sayisi") %></label></td>
            <td onclick="sayfagetir('/santiye_detay/','jsid=4559&id=<%=cek("idd") %>&departman_id=<%=cek("id") %>');" style="text-align: center; cursor: pointer;">
                <label class="label label-danger" style="font-size: 130%;"><%=cek("is_sayisi") %></label></td>
            <td onclick="sayfagetir('/santiye_detay/','jsid=4559&id=<%=cek("idd") %>&departman_id=<%=cek("id") %>');" style="cursor: pointer;"><%=cek("firma_adi") %></td>
            <td onclick="sayfagetir('/santiye_detay/','jsid=4559&id=<%=cek("idd") %>&departman_id=<%=cek("id") %>');" data-order="<%=cek("ekleme_ticks") %>" style="text-align: center; cursor: pointer; padding: 3px!important;"><%=cdate(cek("ekleme_tarihi")) & " " & left(cek("ekleme_saati"),5) %><br />
                <%=cek("ekleyen") %></td>
            <td onclick="sayfagetir('/santiye_detay/','jsid=4559&id=<%=cek("idd") %>&departman_id=<%=cek("id") %>');" data-order="<%=cek("guncelleme_ticks") %>" style="text-align: center; cursor: pointer; padding: 3px!important;"><%=cdate(cek("guncelleme_tarihi")) & " " & left(cek("guncelleme_saati"),5) %><br />
                <%=cek("guncelleyen") %></td>
        </tr>
        <%
    cek.movenext
    loop
        %>
    </tbody>
</table>
<%
    end if

    elseif trn(request("islem"))="yeni_firma_ekle" then

        firma_parola = "778899"
        yetki_kodu = trn(request("yetki_kodu"))
        firma_logo = trn(request("firma_logo"))
        firma_adi = trn(request("firma_adi"))
        firma_yetkili = trn(request("firma_yetkili"))
        firma_telefon = trn(request("firma_telefon"))
        firma_mail = trn(request("firma_mail"))
        firma_supervisor_id = trn(request("firma_supervisor_id"))
        yetkili1_telefon = trn(request("yetkili1_telefon"))
        yetkili1_mail = trn(request("yetkili1_mail"))

        default_parabirimi = "TL"
        cari_calisma_izni = "true"
        genel_kar_tipi = "Oran"
        genel_kar = "20"
        genel_kar_pb = "TL"
        firma_gsm = firma_telefon
        kur_secimi = "TL"
        durum = "true"
        cop = "false"
        firma_kodu = "DEMO"
        ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
        ekleyen_firma_kodu = ""
        ekleyen_firma_id = "0"
        ekleyen_ip = REquest.ServerVariables("remote_Addr")
        ekleme_tarihi = date
        ekleme_saati = time
        

        ornek_firma_id = 225
        ornek_proje_id = 451

        SQL="SET NOCOUNT ON; insert into ucgem_firma_listesi(yetki_kodu, firma_logo, firma_adi, firma_yetkili, firma_telefon, firma_mail, firma_supervisor_id, default_parabirimi, cari_calisma_izni, genel_kar_tipi, genel_kar, genel_kar_pb, firma_gsm, kur_secimi, durum, cop, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, ekleyen_firma_id, ekleyen_firma_kodu, yetkili1_telefon, yetkili1_mail) values('"& yetki_kodu &"', '"& firma_logo &"', '"& firma_adi &"', '"& firma_yetkili &"', '"& firma_telefon &"', '"& firma_mail &"', '"& firma_supervisor_id &"', '"& default_parabirimi &"', '"& cari_calisma_izni &"', '"& genel_kar_tipi &"', '"& genel_kar &"', '"& genel_kar_pb &"', '"& firma_gsm &"', '"& kur_secimi &"', '"& durum &"', '"& cop &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', '"& ekleme_tarihi &"', '"& ekleme_saati &"', '"& ekleyen_firma_id &"', '"& ekleyen_firma_kodu &"', '"& yetkili1_telefon &"', '"& yetkili1_mail &"'); SELECT SCOPE_IDENTITY() id;"
        set ekle = baglanti.execute(SQL)

        firma_id = ekle(0)
        firma_kodu = "DEMO" & firma_id

        SQL="update ucgem_firma_listesi set firma_kodu = 'DEMO"& firma_id &"', firma_hid = '"& firma_id &"' where id = '"& firma_id &"';"
        set guncelle = baglanti.execute(SQL)

        SQL="SET NOCOUNT ON; insert into tanimlama_departman_listesi(departman_adi, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi,ekleme_saati,departman_tipi) SELECT departman_adi, 'true', 'false', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(),getdate(), departman_tipi FROM dbo.tanimlama_departman_listesi WHERE firma_id = '"& ornek_firma_id &"'; SELECT SCOPE_IDENTITY() id;"
        set ekle = baglanti.execute(SQL)

        SQL="select top 1 id from tanimlama_departman_listesi where firma_id = '"& firma_id &"' order by id asc"
        set cek = baglanti.execute(SQL)

        departman_id = cek(0)

        SQL="SET NOCOUNT ON; insert into tanimlama_santiye_durum_listesi(durum_adi,durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip ,ekleme_tarihi, ekleme_saati) SELECT durum_adi, 'true', 'false', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(),getdate() FROM tanimlama_santiye_durum_listesi WHERE firma_id = '"& ornek_firma_id &"'; SELECT SCOPE_IDENTITY() id;"
        set ekle = baglanti.execute(SQL)

        SQL="select top 1 id from tanimlama_santiye_durum_listesi where firma_id = '"& firma_id &"' order by id asc"
        set cek = baglanti.execute(SQL)


        santiye_durum_id = cek(0)

        SQL="SET NOCOUNT ON; insert into tanimlama_gorev_listesi(gorev_adi, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip ,ekleme_tarihi, ekleme_saati, yetkili_sayfalar) SELECT gorev_adi, 'true', 'false', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate(), yetkili_sayfalar FROM tanimlama_gorev_listesi WHERE firma_id = '"& ornek_firma_id &"'; SELECT SCOPE_IDENTITY() id;"
        set ekle = baglanti.execute(SQL)

        SQL="select top 1 id from tanimlama_gorev_listesi where firma_id = '"& firma_id &"' order by id desc"
        set cek = baglanti.execute(SQL)

        gorevler = cek(0)

        
        SQL="SET NOCOUNT ON; insert into ucgem_firma_kullanici_listesi(kullanici_hid, yetki_kodu, firma_kodu, firma_id, firma_hid, personel_eposta, personel_parola, maili_varmi, personel_cinsiyet, personel_ad, personel_soyad, personel_telefon, personel_dtarih, personel_resim, ekleyen_yetki_kodu, ekleyen_firma_kodu, ekleyen_firma_id, departmanlar, gorevler, durum, cop, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, is_tablo_gorunum, is_tablo_sayi, personel_saatlik_maliyet, personel_maliyet_pb) SELECT '"& firma_id &"', 'ALL', '"& firma_kodu &"', '"& firma_id &"', '"& firma_id &"', '"& firma_mail &"', '"& firma_parola &"', '0', personel_cinsiyet, '"& firma_yetkili &"', '', '"& firma_telefon &"', personel_dtarih, personel_resim, ekleyen_yetki_kodu, '"& firma_kodu &"', '"& firma_id &"', '"& departman_id &"', '"& gorevler &"', 'true', 'false', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate(), is_tablo_gorunum, is_tablo_sayi, personel_saatlik_maliyet, personel_maliyet_pb FROM dbo.ucgem_firma_kullanici_listesi WHERE firma_id = '"& ornek_firma_id &"'; SELECT SCOPE_IDENTITY() id;"
        set personel_ekle = baglanti.execute(SQL)

        SQL="select top 1 id from ucgem_firma_kullanici_listesi where firma_id = '"& firma_id &"' order by id desc"
        set cek = baglanti.execute(SQL)

        ekleyen_id = cek(0)

        SQL="update ucgem_firma_kullanici_listesi set kullanici_hid = '"& firma_id & "." & ekleyen_id &"' where id = '"& ekleyen_id &"';"
        set guncelle = baglanti.execute(SQL)

        SQL="SET NOCOUNT ON; insert into ucgem_firma_listesi(yetki_kodu, firma_hid, firma_adi, firma_yetkili, firma_telefon, firma_mail, firma_logo, firma_supervisor_id, default_parabirimi , cari_calisma_izni , genel_kar_tipi, genel_kar , genel_kar_pb, firma_gsm, kur_secimi, durum, cop, ekleyen_id, ekleyen_ip ,ekleme_tarihi, ekleme_saati, ekleyen_firma_id, ekleyen_firma_kodu) SELECT yetki_kodu, '0', firma_adi, firma_yetkili, firma_telefon, firma_mail, firma_logo, '"& ekleyen_id &"', default_parabirimi , cari_calisma_izni , genel_kar_tipi, genel_kar , genel_kar_pb, firma_gsm, kur_secimi, 'true', 'false', '"& ekleyen_id &"', '"& ekleyen_ip &"' , getdate(), getdate(), '"& firma_id &"', '"& firma_kodu &"' FROM dbo.ucgem_firma_listesi WHERE ekleyen_firma_id = '"& ornek_firma_id &"'; SELECT SCOPE_IDENTITY() id;"
        set ekle = baglanti.execute(SQL)

        SQL="select top 1 id from ucgem_firma_listesi where ekleyen_firma_id = '"& firma_id &"' order by id desc"
        set cek = baglanti.execute(SQL)

        musteri_id = cek(0)


        SQL="select * from tanimlama_departman_listesi where firma_id = '"& firma_id &"'"
        set depacek = baglanti.execute(SQL)
        do while not depacek.eof 
            departlar = departlar & depacek(0) & ","
        depacek.movenext
        loop
        
        SQL="SET NOCOUNT ON; insert into ucgem_proje_listesi(proje_adi, proje_firma_id, supervisor_id, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip ,ekleme_tarihi, ekleme_saati, santiye_durum_id, selectedRow, canWrite, canWriteOnParent, zoom, proje_departmanlari) SELECT proje_adi, '"& musteri_id &"', '"& ekleyen_id &"','true', 'false', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate(), '"& santiye_durum_id &"', selectedRow, canWrite, canWriteOnParent, zoom, '"& departlar &"' FROM ucgem_proje_listesi WHERE firma_id = '"& ornek_firma_id &"'; SELECT SCOPE_IDENTITY() id;"
        set ekle = baglanti.execute(SQL)

        SQL="select top 1 id from ucgem_proje_listesi where firma_id = '"& firma_id &"' order by id desc"
        set cek = baglanti.execute(SQL)

        proje_id = cek(0)
        
        SQL="insert into ucgem_proje_olay_listesi(proje_id, olay, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip ,ekleme_tarihi, ekleme_saati, departman_id, olay_saati, olay_tarihi) SELECT '"& proje_id &"', olay, 'true', 'false', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate(), '"& departman_id &"', getdate(), getdate() FROM ucgem_proje_olay_listesi WHERE firma_id  = '"& ornek_firma_id &"';"
        set ekle = baglanti.execute(SQL)


        SQL="insert into ahtapot_proje_gantt_adimlari(proje_id, name, progress, progressByWorklog, irelevance, type, typeId, description, code, ilevel, status, depends, start, duration, iend, startIsMilestone, endIsMilestone , collapsed, canWrite, canAdd, canDelete, canAddIssue, hasChild, cop, start_tarih, end_tarih, start_uygulama, iend_uygulama, duration_uygulama, start_tarih_uygulama , end_tarih_uygulama) SELECT '"& proje_id &"', name, progress, progressByWorklog, irelevance, type, typeId, description, code, ilevel, status, depends, start, duration, iend, startIsMilestone, endIsMilestone , collapsed, canWrite, canAdd, canDelete, canAddIssue, hasChild, cop, start_tarih, end_tarih, start_uygulama, iend_uygulama, duration_uygulama, start_tarih_uygulama , end_tarih_uygulama FROM dbo.ahtapot_proje_gantt_adimlari WHERE proje_id = '"& ornek_proje_id &"'"
        set ekle = baglanti.execute(SQL)

        baslangic_tarihi = cdate(date) + 15
        bitis_tarihi = cdate(date) + 25

        SQL="SET NOCOUNT ON; insert into ucgem_is_listesi(adi, aciklama, gorevliler, departmanlar, oncelik , kontrol_bildirim, baslangic_tarihi, baslangic_saati, bitis_tarihi, bitis_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, guncelleme_tarihi, guncelleme_saati, guncelleyen, renk, ajanda_gosterim, toplam_sure, gunluk_sure, toplam_gun, sinirlama_varmi) SELECT TOP 1 adi, aciklama, gorevliler, 'departman-"& departman_id &"', oncelik , kontrol_bildirim, '"& baslangic_tarihi &"', baslangic_saati, '"& bitis_tarihi &"', bitis_saati, 'true', 'false', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate(), getdate(), getdate(), 'firma_yetkili', renk, ajanda_gosterim, toplam_sure, gunluk_sure, toplam_gun, sinirlama_varmi FROM dbo.ucgem_is_listesi WHERE firma_id = '"& ornek_firma_id  &"'; SELECT SCOPE_IDENTITY() id;"
        set ekle = baglanti.execute(SQL)

        SQL="select top 1 id from ucgem_is_listesi where firma_id = '"& firma_id &"' order by id desc"
        set cek = baglanti.execute(SQL)

        is_id = cek(0)


        SQL="insert into ucgem_is_gorevli_durumlari(gorevli_id, tamamlanma_orani, tamamlanma_tarihi, tamamlanma_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, is_id, toplam_sure, gunluk_sure, toplam_gun) SELECT '"& ekleyen_id &"', 50, getdate(), getdate(), 'true', 'false', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate(), '"& is_id &"', toplam_sure, gunluk_sure, toplam_gun FROM dbo.ucgem_is_gorevli_durumlari WHERE is_id = 1440"
        set ekle = baglanti.execute(SQL)


        SQL="SET NOCOUNT ON; EXEC DemoHEsapGonderim @personel_id = '"& ekleyen_id &"';"
        set gonder = baglanti.execute(SQL)

        Response.Write "ok"
        

    end if 

%>