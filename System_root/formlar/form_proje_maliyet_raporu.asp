<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

%>
<html lang="tr">
<head>
    <title><%=LNG("Personel Performans Raporu")%></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style>
        body {
            font-family: Arial;
            text-align:left;
        }
        table {
            text-align:left;
        }
    </style>
</head>
<body>
    <table style="width: 100%;">
        <tr>
            <td style="vertical-align: top; text-align: left; line-height: 20px;">
                <h2><%=LNG("PROJE MALİYET RAPORU")%></h2>
                <span><%=LNG("Oluşturma Tarihi")%>&nbsp;:&nbsp;<%=now %></span></td>
            <td style="vertical-align: top; text-align: right;">
                <img src="/images/proskop_buyuk2_form.png" /></td>
        </tr>
    </table>
    <div>
        <br />
        <br />
       <%
           proje_id = trn(request("yeni_is_yuku_proje_id"))
           fid = trn(request("fid"))
           kid = trn(request("kid"))

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


           SQL="select personel_ad + ' ' + personel_soyad as isim from ucgem_firma_kullanici_listesi where id = '"& kid &"'"
           set personel_cek = baglanti.execute(SQL)
       
%>

<div class="row invoive-info">
    <hr />
    <table style="width:100%;">
        <tr>
            <td style="width:70%; vertical-align:top; line-height:25px;">
        <span><strong class="m-0"><%=cek("proje_adi") %></strong></span><br />
        <span class="m-0 m-t-10"><%=cek("firma_adi") %></span><br />
        <span class="m-0"><%=cek("firma_telefon") %></span><br />
        <span><%=cek("firma_mail") %></span>

            </td>
          
            <td style="width:30%; vertical-align:top;">
                <table class="table table-responsive invoice-table invoice-order table-borderless">
            <tbody>
                <tr>
                    <th style="text-align:left;"><%=LNG("Tarih")%></th>
                    <td>:</td>
                    <td><%=now %></td>
                </tr>
                <tr>
                    <th style="text-align:left;"><%=LNG("Proje No")%></th>
                    <td>:</td>
                    <td>#<%=cek("id") %></td>
                </tr>
                <tr>
                    <th style="text-align:left;"><%=LNG("Raporu Alan")%></th>
                    <td>:</td>
                    <td><%=personel_cek("isim") %></td>
                </tr>
            </tbody>
        </table>

            </td>
        </tr>
    </table>

</div>
<div class="row">
    <div class="col-sm-12">
        <h3 style="font-size:15px; line-height:30px;"><%=LNG("BÜTÇE HESAPLARI")%></h3>

                               <%
                        sql="SELECT ISNULL((SELECT SUM(satinalma.gerceklesen_tutar) FROM ahtapot_proje_satinalma_listesi satinalma WHERE satinalma.proje_id = butce.proje_id and butce.id = satinalma.butce_hesabi AND satinalma.cop = 'false' AND gerceklesen_pb = 'TL'),0) AS gerceklesen_tl, ISNULL((SELECT SUM(satinalma.gerceklesen_tutar) FROM ahtapot_proje_satinalma_listesi satinalma WHERE satinalma.proje_id = butce.proje_id and butce.id = satinalma.butce_hesabi AND satinalma.cop = 'false' AND gerceklesen_pb = 'USD'),0) AS gerceklesen_usd, ISNULL((SELECT SUM(satinalma.gerceklesen_tutar) FROM ahtapot_proje_satinalma_listesi satinalma WHERE satinalma.proje_id = butce.proje_id and butce.id = satinalma.butce_hesabi AND satinalma.cop = 'false' AND gerceklesen_pb = 'EUR'),0) AS gerceklesen_eur, * FROM ahtapot_proje_butce_listesi butce WHERE butce.proje_id = '"& proje_id &"' AND butce.cop = 'false';"
                        set butce = baglanti.execute(SQL)
                        if butce.eof then
                        %>
                <div class="dt-responsive table-responsive">
                <table id="new-cons" border="1" cellpadding="0" cellspacing="0" class="table table-striped table-bordered table-hover" width="100%">
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
         <fieldset visible="true" style="border:1px solid #cccccc; padding:15px; margin-bottom:15px; ">
                                                <h3 style="width:auto; padding-left: 5px; padding-right: 5px;  font-size:15px;"><%=ucase(butce("butce_hesabi_adi")) %></h3>
        <div class="dt-responsive table-responsive">
                <table id="new-cons" border="1" cellpadding="0" cellspacing="0" class="table table-striped table-bordered table-hover" width="100%">
                    <thead>
                        <tr>
                            <th style="color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px; width:50%;"><%=LNG("BÜTÇE HESABI ADI")%></th>
                            <th style="text-align: center; max-width:200px; color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px;"><%=LNG("ÖNGÖRÜLEN / KALAN")%></th>
                            <th style="text-align: center; max-width:200px; color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px;"><%=LNG("GERÇEK")%></th>
                            <th style="text-align: center; max-width:300px; color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px;"><%=LNG("DURUM")%></th>
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
                            <td style="font-size:13px; padding:5px; font-weight:bold;"><%=butce("butce_hesabi_adi") %></td>
                            <td style="text-align: center;  max-width:200px; padding:5px; line-height:15px;">
                                <span class="label label-primary" style="font-size:12px; width:150px; margin-left:auto; margin-right:auto;"><%=FormatNumber(butce("ongorulen_tutar"),2) %>&nbsp;<%=butce("parabirimi") %></span>
                                <br />
                                <span class="label label-danger" style="font-size:12px; width:150px; margin-left:auto; margin-right:auto;"><%=FormatNumber(kalan_tutar,2) %>&nbsp;<%=butce("parabirimi") %></span>
                            </td>
                            <td style="text-align: center; line-height:5px;  padding:5px;  max-width:200px; line-height:15px;">
                                <span class="label label-warning" style="font-size:12px; padding:5px; width:150px; margin-left:auto; margin-right:auto;"><%=FormatNumber(butce("gerceklesen_tl"),2) %>&nbsp;TL</span><br />
                                <span class="label label-info" style="font-size:12px; padding:5px; width:150px; margin-left:auto; margin-right:auto;"><%=FormatNumber(butce("gerceklesen_usd"),2) %>&nbsp;USD</span><br />
                                <span class="label label-success" style="font-size:12px; padding:5px; width:150px; margin-left:auto; margin-right:auto;"><%=FormatNumber(butce("gerceklesen_eur"),2) %>&nbsp;EUR</span>
                            </td>
                            <td style=" max-width:300px;  padding:5px;">
                                <span><%=hesap %> %</span><br />
                                <img src="/img/raporbar.png" width="<%=hesap %>%" style="width:<%=hesap %>%; height:20px;"/>
                                

                                
                            </td>
                        </tr>
                       
                    </tbody>
                </table>
            </div>


           <h3 style="font-size:13px; line-height:25px;"><%=ucase(butce("butce_hesabi_adi")) %> <%=LNG("BÜTÇE KALEMLERİ")%></h3>
                                <div class="dt-responsive table-responsive">
                <table id="new-cons2"  border="1" cellpadding="0" cellspacing="0" class="table table-striped table-bordered table-hover" width="100%">
                    <thead>
                        <tr>
                            <th style="color: #495057; background-color: #e9ecef; padding: 10px;; font-weight:bold; font-size:15px; width:50%;"><%=LNG("SATINALMA ADI")%></th>
                            <th style="text-align: center;  color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px;"><%=LNG("TEDARİKÇİ")%></th>
                            <th style="text-align: center; max-width:120px; color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px;"><%=LNG("DURUM")%></th>
                            <th style="text-align: center; color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px;"><%=LNG("ÖNGÖRÜLEN")%></th>
                            <th style="text-align: center; max-width:200px; color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px;"><%=LNG("GERÇEK")%></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            SQL=" SELECT firma.firma_adi, butce.butce_hesabi_adi, satinalma.* from ahtapot_proje_satinalma_listesi satinalma join ahtapot_proje_butce_listesi butce on butce.id = satinalma.butce_hesabi JOIN dbo.ucgem_firma_listesi firma ON firma.id = satinalma.tedarikci_id where satinalma.proje_id = '"& proje_id &"' and butce.id = '"& butce("id") &"' and satinalma.cop = 'false' AND satinalma.durum = 'true' AND satinalma.durum = butce.durum AND satinalma.cop = butce.cop"
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
                            <td><span style="font-weight:bold; padding:5px;"><%=satis("satinalma_adi") %></span><br /><%=satis("aciklama") %></td>
                            <td><%=satis("firma_adi") %></td>
                            <td style="width: 120px; padding:5px;">
                                <% if trim(satis("satinalma_durum"))="Planlandı" then %>
                                <label class="label label-primary" style="font-size:12px; width:150px; margin-left:auto; margin-right:auto;"><%=LNG("PLANLANDI")%></label>
                                <% elseif trim(satis("satinalma_durum"))="Alındı" then %>
                                <label class="label label-info" style="font-size:12px; width:150px; margin-left:auto; margin-right:auto;"><%=LNG("ALINDI")%></label>
                                <% elseif trim(satis("satinalma_durum"))="Sipariş Verildi" then %>
                                <label class="label label-warning" style="font-size:12px; width:150px; margin-left:auto; margin-right:auto;"><%=LNG("SİPARİŞ VERİLDİ")%></label>
                                <% elseif trim(satis("satinalma_durum"))="Ödendi" then %>
                                <label class="label label-success" style="font-size:12px; width:150px; margin-left:auto; margin-right:auto;"><%=LNG("ÖDENDİ")%></label>
                                <% end if %>
                            </td>
                            <td style="text-align: center;  padding:5px;"><%=formatnumber(satis("ongorulen_tutar"),2) %>&nbsp;<%=satis("ongorulen_pb") %></td>
                            <td style="color: red; text-align: center;  padding:5px;"><%=formatnumber(satis("gerceklesen_tutar"),2) %>&nbsp;<%=satis("gerceklesen_pb") %></td>
                            
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

                SQL="SELECT departman.departman_adi, kullanici.personel_ad, kullanici.personel_soyad,SUM(hesaplama.saat) AS saat, ISNULL( CONVERT(DECIMAL(18, 2), (SUM(hesaplama.saat)) * ISNULL(SUM(hesaplama.maliyet), 0)), 0 ) AS maliyet_tutari, 'TL' AS pb FROM tanimlama_departman_listesi departman JOIN dbo.ucgem_firma_kullanici_listesi kullanici ON departman.firma_id = kullanici.firma_id AND kullanici.cop = departman.cop AND kullanici.cop = departman.cop AND kullanici.cop = 'false' AND kullanici.durum = 'true' JOIN ( SELECT olay.etiketler, kaynak.id, olay.baslangic AS baslangic, SUM((DATEDIFF( n, CONVERT(DATETIME, olay.baslangic) + CONVERT(DATETIME, olay.baslangic_saati), CONVERT(DATETIME, olay.bitis) + CONVERT(DATETIME, olay.bitis_saati) ) ) * 0.016667 ) AS saat, SUM(CASE WHEN kaynak.tip = 'PERSONEL' THEN kullanici.personel_saatlik_maliyet WHEN kaynak.tip = 'TASERON' THEN firma.taseron_saatlik_maliyet END) AS maliyet FROM dbo.gantt_kaynaklar kaynak JOIN ahtapot_ajanda_olay_listesi olay ON olay.etiket = kaynak.tip AND olay.etiket_id = kaynak.id AND (SELECT COUNT(value) FROM STRING_SPLIT(olay.etiketler, ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(10), '"& proje_id &"')) > 0 AND olay.durum = 'true' AND olay.cop = 'false' AND olay.tamamlandi = 1 LEFT JOIN dbo.ucgem_firma_kullanici_listesi kullanici ON kullanici.id = kaynak.id LEFT JOIN dbo.ucgem_firma_listesi firma ON firma.id = kaynak.id WHERE kaynak.tip = 'PERSONEL' GROUP BY kaynak.id, olay.baslangic, olay.etiketler ) hesaplama ON hesaplama.id = kullanici.id AND (SELECT COUNT(value) FROM STRING_SPLIT(hesaplama.etiketler, ',') WHERE value = 'departman-' + CONVERT(NVARCHAR(10),departman.id)) > 0 WHERE departman.firma_id = '"& fid &"' AND departman.durum = 'true' AND departman.cop = 'false' GROUP BY departman.departman_adi, kullanici.personel_ad, kullanici.personel_soyad ORDER BY departman.departman_adi, kullanici.personel_ad + ' ' + kullanici.personel_soyad"
                
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
                 <fieldset visible="true" style="border:1px solid #cccccc; padding:15px; margin-bottom:15px; ">
                    <h3 style="width:auto; padding-left: 5px; padding-right: 5px; font-size:15px;"><%=departman("departman_adi") %> <%=LNG("İŞÇİLİKLERİ")%></h3>
                     <table id="new-cons2"  border="1" cellpadding="0" cellspacing="0" class="table table-striped table-bordered table-hover" width="100%">
                    <thead>
                        <tr>
                            <th style="color: #495057; background-color: #e9ecef; padding: .75rem; font-weight:bold; font-size:15px; width:50%;"><%=LNG("Personel Adı")%></th>
                            <th style="text-align: center;  color: #495057; background-color: #e9ecef; padding: .75rem; font-weight:bold; font-size:15px;"><%=LNG("Toplam Saat")%></th>
                            <th style="text-align: center;  color: #495057; background-color: #e9ecef; padding: .75rem; font-weight:bold; font-size:15px;"><%=LNG("Maliyet")%></th>
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
                            <td style="padding:5px;"><%=departman("personel_ad") & " " & departman("personel_soyad") %></td>
                            <td style="text-align:center;"><label class="label label-primary" style="font-size:12px; width:150px; margin-left:auto; padding:5px; margin-right:auto;"><%=DakikadanSaatYap(cdbl(departman("saat")) * 60) %></label></td>
                            <td style="text-align:center;"><label class="label label-success" style="font-size:12px; width:150px; margin-left:auto; padding:5px; margin-right:auto;"><%=formatnumber(departman("maliyet_tutari"),2) %>&nbsp;<%=departman("pb") %></label></td>
                        </tr>
                   
        <%
            departman.movenext
            loop
        %>
        </tbody>
            </table>
        </fieldset>
        <h3 style="line-height:30px; font-size:15px;"><%=LNG("PROJE GELİRLERİ")%></h3>
        <div class="dt-responsive table-responsive">
    <table id="new-cons"  border="1" cellpadding="0" cellspacing="0" class="table table-striped table-bordered table-hover" width="100%">
        <thead>
            <tr>
                <th style="color: #495057; background-color: #e9ecef;  font-weight:bold; font-size:15px; padding:10px; width:10px; max-width:10px;"></th>
                <th style="color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px; width:50%;"><%=LNG("GELİR ADI")%></th>
                <th style="color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px; width:10%;"><%=LNG("DURUM")%></th>
                <th style="color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px; width:10%;"><%=LNG("ÖNGÖRÜLEN TARİH")%></th>
                <th style="color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px; width:10%;"><%=LNG("GERÇEK TARİH")%></th>
                <th style="color: #495057; background-color: #e9ecef; padding: 10px; font-weight:bold; font-size:15px; width:9%;"><%=LNG("TUTAR")%></th>
            </tr>
        </thead>
        <tbody>
            <%
                SQL="select * from ahtapot_proje_gelir_listesi where proje_id = '"& proje_id &"' and durum = 'true' and cop = 'false' order by planlanan_tarih asc"
                set gelir = baglanti.execute(SQL)
                if gelir.eof then
            %>
            <tr>
                <td colspan="5" style="text-align:center;"><%=LNG("Kayıt Yok")%></td>
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
                <td style="width:10px; padding:5px;"><strong><%=x %></strong></td>
                <td style="padding:5px;"><%=gelir("gelir_adi") %></td>
                <td style="text-align: center; padding:5px;">
                    <label class="label label-lg label-<% if trim(gelir("gelir_durum"))="Ödendi" then %>success<% elseif trim(gelir("gelir_durum"))="Bekliyor" then %>warning<% elseif trim(gelir("gelir_durum"))="Ertelendi" then %>danger<% end if %>" style="font-size:12px;">Ödendi</label></td>
                <td style="text-align: center; padding:5px;"><%=cdate(gelir("planlanan_tarih")) %></td>
                <td style="text-align: center; padding:5px;"><% if trim(gelir("gelir_durum"))="Ödendi" then %><%=cdate(gelir("odeme_tarih")) %><% else %>---<% end if %></td>
                <td style="text-align: center; padding:5px;">
                    <label style="display: block; font-size:12px;" class="label label-lg label-<% if trim(gelir("gelir_durum"))="Ödendi" then %>success<% elseif trim(gelir("gelir_durum"))="Bekliyor" then %>warning<% elseif trim(gelir("gelir_durum"))="Ertelendi" then %>danger<% end if %>"><%=formatnumber(gelir("odeme_tutar"),2) %>&nbsp;<%=gelir("odeme_pb") %></label></td>
            </tr>
            <%
                gelir.movenext
                loop
            %>
            <tr>
                <td colspan="5" style="text-align:right; padding:5px;"><strong><%=LNG("Tahsil Edilen Toplam :")%> </strong></td>
                <td style="line-height:15px; text-align:center; padding:5px;">
                    <span class="label label-lg label-inverse" style="font-size:12px;"><%=formatnumber(odenen_toplam_tl,2) %> TL</span><br />
                    <span class="label label-lg label-inverse" style="font-size:12px;"><%=formatnumber(odenen_toplam_usd,2) %> USD</span><br />
                    <span class="label label-lg label-inverse" style="font-size:12px;"><%=formatnumber(odenen_toplam_eur,2) %> EUR</span>
                </td>
            </tr>
              <tr>
                <td colspan="5" style="text-align:right; padding:5px;"><strong><%=LNG("Kalan Toplam :")%> </strong></td>
                <td style="line-height:15px; text-align:center; padding:5px;">
                    <span class="label label-lg label-inverse" style="font-size:12px;"><%=formatnumber(kalan_toplam_tl,2) %> TL</span><br />
                    <span class="label label-lg label-inverse" style="font-size:12px;"><%=formatnumber(kalan_toplam_usd,2) %> USD</span><br />
                    <span class="label label-lg label-inverse" style="font-size:12px;"><%=formatnumber(kalan_toplam_eur,2) %> EUR</span>
                </td>
            </tr>
        </tbody>
    </table>
</div>

    </div>
</div><br /><br /><hr /><br /><br />
<div class="row">
    <div class="col-sm-12">
        <table style="width:100%;">
            <tr>
                <td style="width:40%;"></td>
                <td style="width:60%;">
                    <table style="width:100%; text-align:center;"  border="1" cellpadding="0" cellspacing="0" class="table table-responsive invoice-table invoice-total">
            <tbody>
                <tr>
                    <th style="text-align:left; padding:5px;"><%=LNG("TOPLAM BÜTÇE :")%></th>
                    <td style=" padding:5px;"><%=formatnumber(toplam_butce_tl,2) %>&nbsp;TL</td>
                    <td style=" padding:5px;"><%=formatnumber(toplam_butce_usd,2) %>&nbsp;USD</td>
                    <td style=" padding:5px;"><%=formatnumber(toplam_butce_eur,2) %>&nbsp;EUR</td>
                </tr>
                                <tr>
                    <th style="text-align:left;  padding:5px;"><%=LNG("KALAN BÜTÇE :")%></th>
                    <td style=" padding:5px;"><%=formatnumber(toplam_butce_tl-toplam_satinalma_tl,2) %>&nbsp;TL</td>
                    <td style=" padding:5px;"><%=formatnumber(toplam_butce_usd-toplam_satinalma_usd,2) %>&nbsp;USD</td>
                    <td style=" padding:5px;"><%=formatnumber(toplam_butce_eur-toplam_satinalma_eur,2) %>&nbsp;EUR</td>
                </tr>
                <tr>
                    <td colspan="4">&nbsp;</td>
                </tr>
                <tr>
                    <th style="text-align:left;  padding:5px;"><%=LNG("SATINALMALAR TOPLAMI :")%></th>
                    <td style=" padding:5px;"><%=formatnumber(toplam_satinalma_tl,2) %>&nbsp;TL</td>
                    <td style=" padding:5px;"><%=formatnumber(toplam_satinalma_usd,2) %>&nbsp;USD</td>
                    <td style=" padding:5px;"><%=formatnumber(toplam_satinalma_eur,2) %>&nbsp;EUR</td>
                </tr>
             

                   <tr>
                    <th style="text-align:left;  padding:5px;"><%=LNG("İŞÇİLİKLER TOPLAMI :")%></th>
                    <td style=" padding:5px;"><%=formatnumber(toplam_iscilik_tl,2) %>&nbsp;TL</td>
                    <td style=" padding:5px;"><%=formatnumber(toplam_iscilik_usd,2) %>&nbsp;USD</td>
                    <td style=" padding:5px;"><%=formatnumber(toplam_iscilik_eur,2) %>&nbsp;EUR</td>
                </tr>
                 <tr>
                    <th style="text-align:left;  padding:5px;"><%=LNG("GELİRLER TOPLAMI :")%></th>
                    <td style=" padding:5px;"><%=formatnumber(odenen_toplam_tl,2) %>&nbsp;TL</td>
                    <td style=" padding:5px;"><%=formatnumber(odenen_toplam_usd,2) %>&nbsp;USD</td>
                    <td style=" padding:5px;"><%=formatnumber(odenen_toplam_eur,2) %>&nbsp;EUR</td>
                </tr>
              
            </tbody>
        </table>
                    <br /><br />
                    <table style="width:100%;"  border="1" cellpadding="0" cellspacing="0" class="table table-responsive invoice-table invoice-total">
                      <tr class="text-info">
                    <td colspan="3" style="color: #495057; background-color: #e9ecef;  font-weight:bold; font-size:15px; padding:10px; ">
                        <center><strong class="text-primary"><%=LNG("GENEL TOPLAM")%></strong></center>
                    </td>
                </tr>
                <%
                    genel_toplam_tl = cdbl(odenen_toplam_tl) - (cdbl(toplam_satinalma_tl) + cdbl(toplam_iscilik_tl))
                    genel_toplam_usd = cdbl(odenen_toplam_usd) - (cdbl(toplam_satinalma_usd) + cdbl(toplam_iscilik_eur))
                    genel_toplam_eur = cdbl(odenen_toplam_eur) - (cdbl(toplam_satinalma_usd) + cdbl(toplam_iscilik_eur))

                    
                    %>
                <tr class="text-info">
                    <td style="vertical-align:middle;  padding:5px;">
                        <center><strong class="text-primary"><%=formatnumber(genel_toplam_tl,2) %>&nbsp;TL</strong></center>
                    </td>
                    <td style="vertical-align:middle;  padding:5px;">
                        <center><strong class="text-primary"><%=formatnumber(genel_toplam_usd,2) %>&nbsp;USD</strong></center>
                    </td>
                     <td style="vertical-align:middle;  padding:5px;">
                        <center><strong class="text-primary"><%=formatnumber(genel_toplam_eur,2) %>&nbsp;EUR</strong></center>
                    </td>
                </tr>
                        </table>
                </td>
            </tr>
        </table>
        
    </div>
</div>
    </div>
</body>
</html>
