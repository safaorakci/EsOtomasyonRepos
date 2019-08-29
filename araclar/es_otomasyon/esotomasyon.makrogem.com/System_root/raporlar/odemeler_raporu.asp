<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

%>
<style>
    table.dataTable thead > tr > th.sorting_asc, table.dataTable thead > tr > th.sorting_desc, table.dataTable thead > tr > th.sorting, table.dataTable thead > tr > td.sorting_asc, table.dataTable thead > tr > td.sorting_desc, table.dataTable thead > tr > td.sorting {
        padding-right: 30px !important;
    }

    table.table-bordered.dataTable th, table.table-bordered.dataTable td {
        border-left-width: 0 !important;
    }

    table.dataTable thead .sorting, table.dataTable thead .sorting_asc, table.dataTable thead .sorting_desc, table.dataTable thead .sorting_asc_disabled, table.dataTable thead .sorting_desc_disabled {
        cursor: pointer !important;
        position: relative !important;
    }

    .table > thead > tr > th {
        border-bottom-color: #ccc !important;
        background-color: white !important;
    }

    table.dataTable td, table.dataTable th {
        -webkit-box-sizing: content-box !important;
        box-sizing: content-box !important;
        vertical-align: middle !important;
    }

    .table-bordered thead td, .table-bordered thead th {
        border-bottom-width: 2px !important;
    }

    .table thead th {
        vertical-align: bottom !important;
        border-bottom: 2px solid #e9ecef !important;
    }

    .table td, .table th {
        padding: .75rem !important;
    }

    .table.dataTable {
        margin-bottom: 15px !important;
        border-top: none;
    }

    table.table-bordered.dataTable {
        border-collapse: collapse !important;
    }

    .dt-toolbar-footer {
        border-top: none;
    }

    .dt-toolbar {
        padding: 6px 1px 10px !important;
    }

    .dataTables_filter .input-group-addon + .form-control {
        height: 32px !important;
    }
</style>
<section id="widget-grid" class="">
    <div class="row" style="display: none;">
        <div class="col-md-4 col-xl-4">

            <div class="card bg-c-blue notification-card">
                <div class="card-block">
                    <div class="row">

                        <div class="col-md-12" style="padding: 0; padding-left: 10px; height: 150px;">
                            <div class="row" style="padding: 0;">
                                <div class="col-xs-12" style="padding: 10px;">
                                    <center>
                                <h5 style="font-weight:300; line-height:45px;"><i class="fa fa-money"></i> <%=LNG("PLANLANMAMIŞ")%></h5>
                            </center>
                                </div>
                            </div>
                            <div class="row align-items-center" style="padding: 0; padding-top: 15px;">
                                <div class="col-4" style="padding: 0;">
                                    <h5 style="font-size: 15px;">0 TL</h5>
                                </div>
                                <div class="col-4 notify-cont" style="padding: 0;">
                                    <h5 style="font-size: 15px;">0 $</h5>
                                </div>
                                <div class="col-4 notify-cont" style="padding: 0;">
                                    <h5 style="font-size: 15px;">0 €</h5>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
        <div class="col-md-4 col-xl-4">
            <div class="card bg-c-pink notification-card">
                <div class="card-block">
                    <div class="row">

                        <div class="col-md-12" style="padding: 0; padding-left: 10px; height: 150px;">
                            <div class="row" style="padding: 0;">
                                <div class="col-xs-12" style="padding: 10px;">
                                    <center>
                                <h5 style="font-weight:300; line-height:45px;"><i class="fa fa-money"></i> <%=LNG("VADESİ GEÇEN")%></h5>
                            </center>
                                </div>
                            </div>
                            <div class="row align-items-center" style="padding: 0; padding-top: 15px;">
                                <div class="col-4" style="padding: 0;">
                                    <h5 style="font-size: 15px;">0 TL</h5>
                                </div>
                                <div class="col-4 notify-cont" style="padding: 0;">
                                    <h5 style="font-size: 15px;">0 $</h5>
                                </div>
                                <div class="col-4 notify-cont" style="padding: 0;">
                                    <h5 style="font-size: 15px;">0 €</h5>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
        <div class="col-md-4 col-xl-4">
            <div class="card bg-c-green notification-card">
                <div class="card-block">
                    <div class="row">

                        <div class="col-md-12" style="padding: 0; padding-left: 10px; height: 150px;">
                            <div class="row" style="padding: 0;">
                                <div class="col-xs-12" style="padding: 10px;">
                                    <center>
                                <h5 style="font-weight:300; line-height:45px;"><i class="fa fa-money"></i> <%=LNG("TOPLAM ÖDEME")%></h5>
                            </center>
                                </div>
                            </div>
                            <div class="row align-items-center" style="padding: 0; padding-top: 15px;">
                                <div class="col-4" style="padding: 0;">
                                    <h5 style="font-size: 15px;">0 TL</h5>
                                </div>
                                <div class="col-4 notify-cont" style="padding: 0;">
                                    <h5 style="font-size: 15px;">0 $</h5>
                                </div>
                                <div class="col-4 notify-cont" style="padding: 0;">
                                    <h5 style="font-size: 15px;">0 €</h5>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>
    <div class="row">

        <article class="col-xs-12 ">
            <div class="card">
                <div id="beta_donus" class="card-block" style="padding:0; margin-top:35px; margin-right:20px;">
                <div style="float: right;">
                                <a class="btn btn-labeled btn-success btn-sm" href="javascript:void(0);" onclick="rapor_pdf_indir('odemeler_raporu');" style="margin-top: -27px;"><span class="btn-label"><i class="fa fa-download"></i></span><%=LNG("İndir")%> </a>&nbsp;&nbsp;<a class="btn btn-labeled btn-warning btn-sm" href="javascript:void(0);" onclick="rapor_pdf_yazdir('odemeler_raporu');" style="margin-top: -27px;"><span class="btn-label"><i class="fa fa-print"></i></span><%=LNG("Yazdır")%> </a>&nbsp;&nbsp;<a class="btn btn-labeled btn-primary btn-sm" href="javascript:void(0);" onclick="rapor_pdf_gonder('odemeler_raporu');" style="margin-top: -27px;"><span class="btn-label"><i class="fa fa-send "></i></span><%=LNG("Gönder")%> </a>
                            </div>
                    </div>
                <div id="beta_donus" class="card-block">
                    <fieldset visible="true" style="border: 1px solid #cccccc; padding: 15px; margin-bottom: 15px;">
                        <legend style="width: auto; padding-left: 5px; padding-right: 5px; font-size: 15px;"><%=LNG("ÖDEMELER RAPORU")%></legend>
                        <div class="dt-responsive table-responsive">
                            <table class="table " style="border: solid 1px #ccc;" border="1">
                                <thead>
                                    <tr>
                                        <th style="padding: .75rem; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("Ödeme Tipi")%></th>
                                        <th style="text-align: center; padding: .75rem; font-weight: bold; font-size: 15px; background: linear-gradient(45deg, #4099ff, #73b4ff); width: 150px;"><span class="label label-primary arkaplansiz badge-lg">TL <%=LNG("ÖDEME")%></span></th>
                                        <th style="padding: .75rem; font-weight: bold; font-size: 15px; background: linear-gradient(45deg, #FF5370, #ff869a); width: 150px;"><span class="label label-danger arkaplansiz badge-lg ">$ <%=LNG("ÖDEME")%></span></th>
                                        <th style="padding: .75rem; font-weight: bold; font-size: 15px; background: linear-gradient(45deg, #FFB64D, #ffcb80); width: 150px;"><span class="label label-warning arkaplansiz badge-lg">€ <%=LNG("ÖDEME")%></span></th>
                                        <th style="padding: .75rem; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("Durum")%></th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <%
                SQL="SELECT CASE WHEN cari.alacakli_id = firma.id THEN firma.firma_adi ELSE firma2.firma_adi END AS firma_adi , CASE WHEN CONVERT(DATE, GETDATE(), 104) = cari.vade_tarihi THEN 1 WHEN cari.vade_tarihi BETWEEN DATEADD(DAY, 1, CONVERT(DATE, GETDATE(), 104)) AND DATEADD( DAY, 30, CONVERT(DATE, GETDATE(), 104) ) THEN 2 WHEN cari.vade_tarihi BETWEEN DATEADD(DAY, 31, CONVERT(DATE, GETDATE(), 104)) AND DATEADD( DAY, 60, CONVERT(DATE, GETDATE(), 104) ) THEN 3 WHEN cari.vade_tarihi BETWEEN DATEADD(DAY, 61, CONVERT(DATE, GETDATE(), 104)) AND DATEADD( DAY, 90, CONVERT(DATE, GETDATE(), 104) ) THEN 4 WHEN cari.vade_tarihi BETWEEN DATEADD(DAY, 91, CONVERT(DATE, GETDATE(), 104)) AND DATEADD( DAY, 120, CONVERT(DATE, GETDATE(), 104) ) THEN 5 WHEN cari.vade_tarihi >= DATEADD(DAY, 121, CONVERT(DATE, GETDATE(), 104)) THEN 6 END tip, cari.* FROM dbo.cari_hareketler cari LEFT JOIN dbo.ucgem_firma_listesi firma ON firma.id = cari.borclu_id LEFT JOIN dbo.ucgem_firma_listesi firma2 ON firma2.id = cari.alacakli_id WHERE cari.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' AND cari.durum = 'true' AND cari.cop = 'false' AND cari.vade_tarihi >= CONVERT(DATE, GETDATE(), 104) AND cari.islem_tipi = 'Ödeme' ORDER BY cari.vade_tarihi DESC;"
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

                                           end if

                                    %>
                                    <tr>
                                        <td><%=LNG("PLANLANMAMIŞ")%></td>
                                        <td style="text-align: center;"><%=formatnumber(planlanmamis_tl,2) %> TL</td>
                                        <td style="text-align: center;"><%=formatnumber(planlanmamis_usd,2) %> $</td>
                                        <td style="text-align: center;"><%=formatnumber(planlanmamis_eur,2) %> €</td>
                                        <td><span><%=eldeki %> %</span>&nbsp;&nbsp;<img src="/img/raporbar.png" width="<%=eldeki %>%" style="width: <%=eldeki%>%; height: 20px;" /></td>
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
                                        end if
                                    %>
                                    <tr>
                                        <td><%=LNG("GÜNCEL")%></td>
                                        <td style="text-align: center;"><%=formatnumber(guncel_tl,2) %> TL</td>
                                        <td style="text-align: center;"><%=formatnumber(guncel_usd,2) %> $</td>
                                        <td style="text-align: center;"><%=formatnumber(guncel_eur,2) %> €</td>
                                        <td><span><%=eldeki %> %</span>&nbsp;&nbsp;<img src="/img/raporbar.png" width="<%=eldeki %>%" style="width: <%=eldeki%>%; height: 20px;" /></td>
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
                                        end if
                                    %>
                                    <tr>
                                        <td><%=LNG("1-30 GÜN GEÇMİŞ")%></td>
                                        <td style="text-align: center;"><%=formatnumber(otuz_tl,2) %> TL</td>
                                        <td style="text-align: center;"><%=formatnumber(otuz_usd,2) %> $</td>
                                        <td style="text-align: center;"><%=formatnumber(otuz_eur,2) %> €</td>
                                        <td><span><%=eldeki %> %</span>&nbsp;&nbsp;<img src="/img/raporbar.png" width="<%=eldeki %>%" style="width: <%=eldeki%>%; height: 20px;" /></td>
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
                                        end if
                                    %>
                                    <tr>
                                        <td><%=LNG("31-60 GÜN GEÇMİŞ")%></td>
                                        <td style="text-align: center;"><%=formatnumber(altmis_tl,2) %> TL</td>
                                        <td style="text-align: center;"><%=formatnumber(altmis_usd,2) %> $</td>
                                        <td style="text-align: center;"><%=formatnumber(altmis_eur,2) %> €</td>
                                        <td><span><%=eldeki %> %</span>&nbsp;&nbsp;<img src="/img/raporbar.png" width="<%=eldeki %>%" style="width: <%=eldeki%>%; height: 20px;" /></td>
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
                                        end if
                                    %>
                                    <tr>
                                        <td><%=LNG("61-90 GÜN GEÇMİŞ")%></td>
                                        <td style="text-align: center;"><%=formatnumber(doksan_tl,2) %> TL</td>
                                        <td style="text-align: center;"><%=formatnumber(doksan_usd,2) %> $</td>
                                        <td style="text-align: center;"><%=formatnumber(doksan_eur,2) %> €</td>
                                        <td><span><%=eldeki %> %</span>&nbsp;&nbsp;<img src="/img/raporbar.png" width="<%=eldeki %>%" style="width: <%=eldeki%>%; height: 20px;" /></td>
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
                                        end if
                                    %>
                                    <tr>
                                        <td><%=LNG("91-120 GÜN GEÇMİŞ")%></td>
                                        <td style="text-align: center;"><%=formatnumber(yuz20_tl,2) %> TL</td>
                                        <td style="text-align: center;"><%=formatnumber(yuz20_usd,2) %> $</td>
                                        <td style="text-align: center;"><%=formatnumber(yuz20_eur,2) %> €</td>
                                        <td><span><%=eldeki %> %</span>&nbsp;&nbsp;<img src="/img/raporbar.png" width="<%=eldeki %>%" style="width: <%=eldeki%>%; height: 20px;" /></td>
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
                                        end if
                                    %>
                                    <tr>
                                        <td><%=LNG("120+ GÜN GEÇMİŞ")%></td>
                                        <td style="text-align: center;"><%=formatnumber(yuz20plus_tl,2) %> TL</td>
                                        <td style="text-align: center;"><%=formatnumber(yuz20plus_usd,2) %> $</td>
                                        <td style="text-align: center;"><%=formatnumber(yuz20plus_eur,2) %> €</td>
                                        <td><span><%=eldeki %> %</span>&nbsp;&nbsp;<img src="/img/raporbar.png" width="<%=eldeki %>%" style="width: <%=eldeki%>%; height: 20px;" /></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </fieldset>
                    <br /><hr /><br />
                    <fieldset visible="true" style="border: 1px solid #cccccc; padding: 15px; margin-bottom: 15px;">
                        <legend style="width: auto; padding-left: 5px; padding-right: 5px; font-size: 15px;"><%=LNG("ÖDEME LİSTESİ")%></legend>
                        <div class="dt-responsive table-responsive">
                            <table class="table " style="border: solid 1px #ccc;" border="1">
                                <thead>
                                    <tr>
                                        <th style="padding: .75rem; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("Ödeme Tarihi")%></th>
                                        <th style="padding: .75rem; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("Fatura/Çek Tarihi")%></th>
                                        <th style="padding: .75rem; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("Müşteri/Tedarikçi")%></th>
                                        <th style="text-align: center; background: linear-gradient(45deg, #4099ff, #73b4ff); width: 150px;"><span class="label label-primary arkaplansiz badge-lg">TL <%=LNG("GİRİŞ")%></span></th>
                                        <th style="text-align: center; background: linear-gradient(45deg, #FF5370, #ff869a); width: 150px;"><span class="label label-danger arkaplansiz badge-lg ">$ <%=LNG("GİRİŞ")%></span></th>
                                        <th style="text-align: center; background: linear-gradient(45deg, #FFB64D, #ffcb80); width: 150px;"><span class="label label-warning arkaplansiz badge-lg">€ <%=LNG("GİRİŞ")%></span></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        if cek.eof then
                                    %>
                                    <tr>
                                        <td colspan="6" style="text-align:center;"><%=LNG("Kayıt Yok")%></td>
                                    </tr>
                                    <%
                                        end if

                                        do while not cek.eof
                                        %>
                                    <tr>
                                        <td><%=cdate(cek("vade_tarihi")) %></td>
                                        <td><%=cdate(cek("islem_tarihi")) %></td>
                                        <td><%=cek("firma_adi") %></td>
                                        <td style="text-align: center;"><% if trim(cek("parabirimi"))="TL" then %><%=formatnumber(cek("meblag"),2) %><% else %>0,00<% end if %> TL</td>
                                        <td style="text-align: center;"><% if trim(cek("parabirimi"))="USD" then %><%=formatnumber(cek("meblag"),2) %><% else %>0,00<% end if %> $</td>
                                        <td style="text-align: center;"><% if trim(cek("parabirimi"))="EUR" then %><%=formatnumber(cek("meblag"),2) %><% else %>0,00<% end if %> €</td>
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
            </div>
        </article>

    </div>
</section>
<link rel="stylesheet" type="text/css" href="/files/assets/pages/data-table/extensions/responsive/css/responsive.dataTables.css">
<script src="/files/bower_components/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
<script src="/files/bower_components/datatables.net-responsive-bs4/js/responsive.bootstrap4.min.js"></script>
<style>
    .dt-toolbar-footer {
        background: #ffffff !important;
    }

    .dt-toolbar {
        background: #ffffff !important;
    }
</style>
