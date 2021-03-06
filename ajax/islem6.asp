﻿<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" bilal -->

<% 

    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    FirmaID = Request.Cookies("kullanici")("firma_id")

    if trn(request("islem"))="profil_personel_bilgileri_getir" then

        personel_id = request("personel_id")

        SQL="select kullanici.personel_resim, left(ISNULL((select gorev_adi + ', ' from tanimlama_gorev_listesi where (SELECT COUNT(value) FROM STRING_SPLIT(kullanici.gorevler, ',') WHERE value =  id ) > 0 and cop = 'false' for xml path('')), '----'), len(ISNULL((select gorev_adi + ', ' from tanimlama_gorev_listesi where (SELECT COUNT(value) FROM STRING_SPLIT(kullanici.gorevler, ',') WHERE value =  id ) > 0 and cop = 'false' for xml path('')), '----'))-1) as gorev_adi, * from ucgem_firma_kullanici_listesi kullanici with(nolock) where kullanici.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and kullanici.id = '"& personel_id &"' and kullanici.cop = 'false' order by kullanici.id asc"
        set personel = baglanti.execute(SQL)

        personel_resim = personel("personel_resim")

        if len(trim(personel_resim))<15 then
            personel_resim = "/img/user.png"
        end if

        user_id = Request.Cookies("kullanici")("kullanici_id")

        SQL="select yonetici_yetkisi from ucgem_firma_kullanici_listesi where id = '"& user_id &"' and firma_id = '"& Request.Cookies("kullanici")("firma_id") &"'"
        set personelbilgi = baglanti.execute(SQL)

%>
<script type="text/javascript">
    sayfa_yuklenince();
</script>
<div class="card">
    <div class="card-header">
        <h5 class="card-header-text"><%=LNG("Personel Bilgileri")%></h5>
    </div>
    <div class="card-block">
        <div class="view-info">
            <form id="koftiform"></form>
            <form autocomplete="off" id="personel_guncelleme_form">
                <div class="row">
                    <div class="col-lg-3">
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Personel Resim")%></label>
                            <div class="col-sm-12 col-lg-12" style="margin-bottom: 15px;">
                                <input type="file" value="<%=personel("personel_resim") %>" filepath="<%=personel("personel_resim") %>" id="personel_resim" tip="buyuk" folder="PersonelResim" yol="personel_resim/" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Personel Ad")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="personel_ad" required value="<%=personel("personel_ad") %>" class="form-control">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Personel Soyad")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="personel_soyad" value="<%=personel("personel_soyad") %>" class="form-control" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Personel T.C No")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="personel_tcno" value="<%=personel("tcno") %>" class="form-control" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Personel Doğum Tarihi")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <%
                                        Function formatNumber(value, digits) 
                                            if digits > len(value) then 
                                                formatNumber = String(digits-len(value),"0") & value 
                                            else 
                                                formatNumber = value 
                                            end if 
                                        End Function 
                                    %>
                                    <input type="text" class="takvimyap form-control" id="personel_dtarih" required value="<%=formatNumber(DAY(personel("personel_dtarih")),2)%>.<%=formatNumber(MONTH(personel("personel_dtarih")),2)%>.<%=YEAR(personel("personel_dtarih"))%>" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Personel Cinsiyet")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <select id="personel_cinsiyet" name="personel_cinsiyet" class="select2">
                                    <option <% if trim(personel("personel_cinsiyet"))="Bay" then %> selected="selected" <% end if %>><%=LNG("Bay")%></option>
                                    <option <% if trim(personel("personel_cinsiyet"))="Bayan" then %> selected="selected" <% end if %>><%=LNG("Bayan")%></option>
                                </select>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <br />
                                <br />
                                <%if trim(personelbilgi("yonetici_yetkisi"))="false" then  %>
                                <script type="text/javascript">
                                    $("#personel_ad").attr("disabled", "disabled");
                                    $("#personel_soyad").attr("disabled", "disabled");
                                    $("#personel_tcno").attr("disabled", "disabled");
                                    $("#personel_dtarih").attr("disabled", "disabled");
                                    $("#personel_eposta").attr("disabled", "disabled");
                                    $("#personel_telefon").attr("disabled", "disabled");
                                    $("#personel_parola").attr("disabled", "disabled");
                                    $("#personel_resim").attr("disabled", "disabled");
                                    $("#personel_cinsiyet").attr("disabled", "disabled");
                                    $("#personelbtn").click(function () {
                                        mesaj_ver("Personel Yetkisi", "Bu İşemi Yapmak İçin Yetkili Değilsiniz. !", "danger");
                                    });
                                </script>
                                <% elseif trim(personelbilgi("yonetici_yetkisi"))="true" then %>
                                <script type="text/javascript">
                                    $("#personelbtn").attr("onclick", "kendi_personel_bilgilerini_guncelle();");
                                </script>
                                <% end if %>
                                <input type="button" id="personelbtn" class="btn btn-primary" value="<%=LNG("Bilgilerimi Güncelle")%>" />
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Personel E-Posta")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="email" id="personel_eposta" class="form-control" required value="<%=personel("personel_eposta") %>" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Personel Telefon")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="personel_telefon" class="form-control" value="<%=personel("personel_telefon") %>" required data-mask="0(999) 999 99 99" placeholder="0(532) 123 45 67">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Görev")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <select name="gorevler" id="gorevler" disabled="disabled" class="select2" multiple>
                                    <%
                                        SQL="select id, gorev_adi from tanimlama_gorev_listesi where durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"' order by gorev_adi asc"
                                        set gorev = baglanti.execute(SQL)
                                        do while not gorev.eof
                                    %>
                                    <option <% if instr(","& personel("gorevler") &",", ","& gorev("id") &",")>0 then %> selected="selected" <% end if %> value="<%=gorev("id") %>"><%=gorev("gorev_adi") %></option>
                                    <%
                                        gorev.movenext
                                        loop
                                    %>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Parola")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <input type="password" id="personel_parola" value="<%=personel("personel_parola") %>" required class="form-control">
                            </div>
                        </div>
                    </div>
                </div>
            </form>

        </div>
    </div>
</div>
<%
    elseif trn(request("islem"))="profil_personel_giris_cikis_getir" then

        personel_id = trn(request("personel_id"))

        sql="select * from ucgem_firma_kullanici_listesi where id = '"& personel_id &"' and firma_id = '"& FirmaID &"'"
        set personel = baglanti.execute(SQL)

%>
<script type="text/javascript">
    if ($(window).width() < 500) {
        $("#giriscikisraporum").hide();
    }
</script>
<div class="card">
    <div class="card-block">
        <div class="view-info">
            <div class="row" id="giriscikisraporum">
                <div class="col-lg-12">
                    <h5 class="card-header-text"><%=LNG("Giriş Çıkış Raporum")%></h5>
                    <br />
                    <br />
                    <div id="yillik_takvim_yeri">
                        <script>
                            $(function (){
                                profil_personel_yillik_takvimi_getir('<%=personel_id %>', '<%=year(date) %>');
                            });
                        </script>
                    </div>
                    <table>
                        <tbody>
                            <tr>
                                <td>
                                    <div style="border: solid 1px black; width: 39px; height: 28px; background-color: #2ed8b6;"></div>
                                </td>
                                <td style="vertical-align: middle; padding: 6px;"><%=LNG("Zamanında")%></td>
                                <td>
                                    <div style="border: solid 1px black; width: 39px; height: 28px; background-color: #f1c40f;"></div>
                                </td>
                                <td style="vertical-align: middle; padding: 6px;"><%=LNG("30 Dakika Geç Kaldı")%></td>
                                <td>
                                    <div style="border: solid 1px black; width: 39px; height: 28px; background-color: #ff5370;"></div>
                                </td>
                                <td style="vertical-align: middle; padding: 6px;"><%=LNG("30 Dakikadan Fazla Geç Kaldı")%></td>
                            </tr>
                        </tbody>
                    </table>
                    <style>
                        .renk2_1 {
                            background-color: #f2f2f2;
                        }

                        .renk2_2 {
                            background-color: #2ed8b6;
                        }

                        .renk2_3 {
                            background-color: #f1c40f;
                        }

                        .renk2_4 {
                            background-color: #ff5370;
                        }

                        .ui-selecting {
                            background-color: #FECA40 !important;
                        }
                    </style>

                </div>
            </div>

            <hr />
            <div class="row">
                <div class="col-lg-4 col-xl-3">
                    <h5 class="card-header-text"><%=LNG("Çalışma Saatlerim")%></h5>
                    <br />
                    <br />
                    <form id="koftiform"></form>
                    <form autocomplete="off" id="personel_calisma_form">
                        <table>
                            <thead>
                                <tr>
                                    <th style="padding: 5px; font-weight: bold;"></th>
                                    <th style="padding: 5px; padding-left: 20px; font-weight: bold;"><%=LNG("Durum")%></th>
                                    <th style="padding: 5px; font-weight: bold;"><%=LNG("Giriş Saati")%></th>
                                    <th style="padding: 5px; font-weight: bold;"><%=LNG("Çıkış Saati")%></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td style="padding: 5px; font-weight: bold;"><%=LNG("Pazartesi")%></td>
                                    <td style="padding-left: 20px;">
                                        <input type="checkbox" onchange="calisma_gunu_sectim(1);" class="js-switch" <% if trim(personel("gun1"))="True" then %> checked="checked" <% end if %> name="gun1" id="gun1" disabled="disabled" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" disabled="disabled" style="width: 65px;" id="gun1_saat1" required class="timepicker form-control" value="<%=left(personel("gun1_saat1"),5) %>" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" disabled="disabled" style="width: 65px;" id="gun1_saat2" required class="timepicker form-control" value="<%=left(personel("gun1_saat2"),5) %>" /></td>
                                </tr>
                                <tr>
                                    <td style="padding: 5px; font-weight: bold;"><%=LNG("Salı")%></td>
                                    <td style="padding-left: 20px;">
                                        <input type="checkbox" disabled="disabled" onchange="calisma_gunu_sectim(2);" class="js-switch" <% if trim(personel("gun2"))="True" then %> checked="checked" <% end if %> name="gun2" id="gun2" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" disabled="disabled" style="width: 65px;" id="gun2_saat1" required class="timepicker form-control" value="<%=left(personel("gun2_saat1"),5) %>" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" disabled="disabled" style="width: 65px;" id="gun2_saat2" required class="timepicker form-control" value="<%=left(personel("gun2_saat2"),5) %>" /></td>
                                </tr>
                                <tr>
                                    <td style="padding: 5px; font-weight: bold;"><%=LNG("Çarşamba")%></td>
                                    <td style="padding-left: 20px;">
                                        <input type="checkbox" disabled="disabled" onchange="calisma_gunu_sectim(3);" class="js-switch" <% if trim(personel("gun3"))="True" then %> checked="checked" <% end if %> name="gun3" id="gun3" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" disabled="disabled" style="width: 65px;" id="gun3_saat1" required class="timepicker form-control" value="<%=left(personel("gun3_saat1"),5) %>" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" disabled="disabled" style="width: 65px;" id="gun3_saat2" required class="timepicker form-control" value="<%=left(personel("gun3_saat2"),5) %>" /></td>
                                </tr>
                                <tr>
                                    <td style="padding: 5px; font-weight: bold;"><%=LNG("Perşembe")%></td>
                                    <td style="padding-left: 20px;">
                                        <input type="checkbox" disabled="disabled" onchange="calisma_gunu_sectim(4);" class="js-switch" <% if trim(personel("gun4"))="True" then %> checked="checked" <% end if %> name="gun4" id="gun4" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" disabled="disabled" style="width: 65px;" id="gun4_saat1" required class="timepicker form-control" value="<%=left(personel("gun4_saat1"),5) %>" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" disabled="disabled" style="width: 65px;" id="gun4_saat2" required class="timepicker form-control" value="<%=left(personel("gun4_saat2"),5) %>" /></td>
                                </tr>
                                <tr>
                                    <td style="padding: 5px; font-weight: bold;"><%=LNG("Cuma")%></td>
                                    <td style="padding-left: 20px;">
                                        <input type="checkbox" disabled="disabled" onchange="calisma_gunu_sectim(5);" class="js-switch" <% if trim(personel("gun5"))="True" then %> checked="checked" <% end if %> name="gun5" id="gun5" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" disabled="disabled" style="width: 65px;" id="gun5_saat1" required class="timepicker form-control" value="<%=left(personel("gun5_saat1"),5) %>" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" disabled="disabled" style="width: 65px;" id="gun5_saat2" required class="timepicker form-control" value="<%=left(personel("gun5_saat2"),5) %>" /></td>
                                </tr>
                                <tr>
                                    <td style="padding: 5px; font-weight: bold;"><%=LNG("Cumartesi")%></td>
                                    <td style="padding-left: 20px;">
                                        <input type="checkbox" disabled="disabled" onchange="calisma_gunu_sectim(6);" class="js-switch" <% if trim(personel("gun6"))="True" then %> checked="checked" <% end if %> name="gun6" id="gun6" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" disabled="disabled" style="width: 65px;" id="gun6_saat1" required class="timepicker form-control" value="<%=left(personel("gun6_saat1"),5) %>" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" disabled="disabled" style="width: 65px;" id="gun6_saat2" required class="timepicker form-control" value="<%=left(personel("gun6_saat2"),5) %>" /></td>
                                </tr>
                                <tr>
                                    <td style="padding: 5px; font-weight: bold;"><%=LNG("Pazar")%></td>
                                    <td style="padding-left: 20px;">
                                        <input type="checkbox" disabled="disabled" onchange="calisma_gunu_sectim(7);" class="js-switch" <% if trim(personel("gun7"))="True" then %> checked="checked" <% end if %> name="gun1" id="gun7" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" disabled="disabled" style="width: 65px;" id="gun7_saat1" required class="timepicker form-control" value="<%=left(personel("gun7_saat1"),5) %>" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" disabled="disabled" style="width: 65px;" id="gun7_saat2" required class="timepicker form-control" value="<%=left(personel("gun7_saat2"),5) %>" /></td>
                                </tr>

                            </tbody>
                        </table>
                    </form>

                </div>
                <style>
                    .table > caption + thead > tr:first-child > td, .table > caption + thead > tr:first-child > th, .table > colgroup + thead > tr:first-child > td, .table > colgroup + thead > tr:first-child > th, .table > thead:first-child > tr:first-child > td, .table > thead:first-child > tr:first-child > th {
                        border-top: 1px solid #ccc !important;
                    }

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

                    /*
                    .table td, .table th {
                        padding: .75rem !important;
                    }*/

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
                <div class="col-lg-8 col-xl-9" style="padding-top: 15px;">
                    <h5 class="card-header-text"><%=LNG("Giriş Çıkış Bilgilerim")%></h5>
                    <input type="button" style="float: right; margin-top: 10px; display: none" onclick="giris_cikis_kaydi_ekle('<%=personel_id%>', '<%=cdate(date)%>');" class="btn btn-primary btn-mini btn-rnd" value="<%=LNG("Giriş Çıkış Kaydı Ekle")%>" />
                    <br />
                    <br />
                    <div id="giris_cikis_kayitlari">
                        <script>
                            $(function (){
                                profil_personel_giris_cikis_kayitlarini_getir('<%=personel_id %>');
                            });
                        </script>

                    </div>

                </div>
            </div>
            <hr />
        </div>
    </div>
</div>
<%

    elseif trn(request("islem"))="profil_personel_izin_getir" then

       personel_id = trn(request("personel_id"))

       SQL = "select isnull(kullanici.personel_yillik_izin, 0) - isnull((select Count(giris.id) from ucgem_personel_mesai_girisleri giris, ucgem_personel_izin_talepleri talep where giris.personel_id = kullanici.id and giris_tipi = 2 and talep.cop = 'false' and talep.personel_id = kullanici.id and giris.tarih between talep.baslangic_tarihi and talep.bitis_tarihi and NOT(talep.turu='Ücretsiz Izin') and talep.durum = 'Onaylandi'),0) as kalan, kullanici.* from ucgem_firma_kullanici_listesi kullanici where kullanici.id = '"& personel_id &"' and kullanici.firma_id = '"& FirmaID &"'"
       set personel = baglanti.execute(SQL)

       personel_yillik_izin_hakedis = personel("personel_yillik_izin_hakedis")

       if isdate(personel_yillik_izin_hakedis)=true then
            personel_yillik_izin_hakedis = cdate(personel_yillik_izin_hakedis)
       else
            personel_yillik_izin_hakedis = cdate(personel_yillik_izin_hakedis)+1
       end if
%>
<script type="text/javascript">
    if ($(window).width() < 500) {
        $("#personelyiilikizin").hide();
        $("#yenizintalebi").addClass("btn-mini");
        $("#cizgi").hide();
    }
</script>
<div class="card">
    <div class="card-block">
        <div class="view-info">
            <div class="row" id="personelyiilikizin">
                <div class="col-lg-12">
                    <h5 class="card-header-text"><%=LNG("İzin Raporum")%>
                    </h5>
                    <div style="float: right; margin-top: -20px; font-weight: bold; margin-right: 30px; line-height: 10px; text-align: center;">
                        Kalan İzin Kullanım Hakkı<span class="label label-info" style="font-size: 13px; padding: 3px; text-align: center;"><%=personel("kalan") %> gün</span><br />
                        Hakediş Tarihi : <span class="label label-warning" style="font-size: 13px; padding: 3px; text-align: center;"><%=personel_yillik_izin_hakedis %></span>
                    </div>
                    <br />
                    <br />
                    <div id="yillik_takvim_yeri_izin">
                        <script>
                            $(function (){
                                personel_yillik_takvimi_getir_izin('<%=personel_id %>', '<%=year(date) %>');
                            });
                        </script>
                    </div>
                    <table>
                        <tbody>
                            <tr>
                                <td>
                                    <div style="border: solid 1px black; width: 39px; height: 28px; background-color: #4099ff;"></div>
                                </td>
                                <td style="vertical-align: middle; padding: 6px;"><%=LNG("İzin")%></td>
                                <% if 1 = 2 then %>
                                <td>
                                    <div style="border: solid 1px black; width: 39px; height: 28px; background-color: #f1c40f;"></div>
                                </td>
                                <td style="vertical-align: middle; padding: 6px;"><%=LNG("Onay Bekliyor")%></td>
                                <td>
                                    <div style="border: solid 1px black; width: 39px; height: 28px; background-color: #ff5370;"></div>
                                </td>
                                <td style="vertical-align: middle; padding: 6px;"><%=LNG("Reddedildi")%></td>
                                <% end if %>
                            </tr>
                        </tbody>
                    </table>

                    <style>
                        .renk2_1 {
                            background-color: #f2f2f2;
                        }

                        .renk2_2 {
                            background-color: #2ed8b6;
                        }

                        .renk2_3 {
                            background-color: #f1c40f;
                        }

                        .renk2_4 {
                            background-color: #ff5370;
                        }

                        .ui-selecting {
                            background-color: #FECA40 !important;
                        }
                    </style>

                </div>
            </div>

            <hr id="cizgi" />
            <div class="row">

                <style>
                    .table > caption + thead > tr:first-child > td, .table > caption + thead > tr:first-child > th, .table > colgroup + thead > tr:first-child > td, .table > colgroup + thead > tr:first-child > th, .table > thead:first-child > tr:first-child > td, .table > thead:first-child > tr:first-child > th {
                        border-top: 1px solid #ccc !important;
                    }

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

                    /*
                    .table td, .table th {
                        padding: .75rem !important;
                    }*/

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
                <div class="col-lg-12 col-xl-12" style="padding-top: 15px;">
                    <h5 class="card-header-text"><%=LNG("İzin Bilgilerim")%>
                       
                    </h5>
                    <span style="float: right;">
                        <button id="yenizintalebi" style="margin-top: -15px;" onclick="yeni_izin_talebi_modal('<%=personel_id %>');" class="btn btn-success">Yeni İzin Talebi Gönder</button>
                    </span>
                    <br />
                    <br />
                    <div id="izin_kayitlari">
                        <script>
                            $(function (){
                                profil_personel_izin_kayitlarini_getir('<%=personel_id %>');
                            });
                        </script>
                    </div>
                </div>
            </div>
            <hr />
        </div>
    </div>
</div>
<%


    elseif trn(request("islem"))="profil_personel_izin_kayitlarini_getir" then

        personel_id = trn(request("personel_id"))
        personel_adina = trn(request("personel_adina"))

        if trn(request("islem2"))="talep_ekle" then
            
            if not personel_adina = 0 then
                personel_id = personel_adina
            end if

            baslangic_tarihi = trn(request("baslangic_tarihi"))
            baslangic_saati = trn(request("baslangic_saati"))
            bitis_tarihi = trn(request("bitis_tarihi"))
            bitis_saati = trn(request("bitis_saati"))
            nedeni = trn(request("nedeni"))
            turu = trn(request("turu"))
            aciklama = trn(request("aciklama"))

            SQL="select * from ucgem_firma_kullanici_listesi where id = '"& personel_id &"' and firma_id = '"& FirmaID &"'"
            set kullanicicek = baglanti.execute(SQL)

            durum = "Onay Bekliyor"
            cop = "false"
            firma_kodu = kullanicicek("firma_kodu")
            firma_id = kullanicicek("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time
            OlusturanPersonelID = Request.Cookies("kullanici")("kullanici_id")

            SQL="insert into ucgem_personel_izin_talepleri(personel_id, baslangic_tarihi, baslangic_saati, bitis_tarihi, bitis_saati, nedeni, turu, aciklama, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, OlusturanPersonelID) values('"& personel_id &"', CONVERT(date, '"& baslangic_tarihi &"', 103), '"& baslangic_saati &"', CONVERT(date, '"& bitis_tarihi &"', 103), '"& bitis_saati &"', '"& nedeni &"', '"& turu &"', '"& aciklama &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"', '"& OlusturanPersonelID &"')"
            set ekle = baglanti.execute(SQL)

            SQL="select * from ucgem_firma_kullanici_listesi where firma_id = '"& firma_id &"' and cop = 'false' and durum = 'true' and isnull(yonetici_yetkisi, 'false')='true'"
            set kcek = baglanti.execute(SQL)

            do while not kcek.eof

                bildirim = kullanicicek("personel_ad") & " " & kullanicicek("personel_soyad") & " "& cdate(baslangic_tarihi) &" "& left(baslangic_saati,5) &" ile "& cdate(bitis_tarihi) &" "& left(bitis_saati,5) &" tarihleri için izin talebinde bulundu." & chr(13) & chr(13) & "Açıklama :" & aciklama & chr(13) & chr(13)
                tip = "personel_detaylari"
                click = "CokluIsYap(''personel_detaylari'',''"& personel_id &"'',''izin'',0);" 
                user_id = kcek("id")
                okudumu = "0"
                durum = "true"
                cop = "false"
                firma_kodu = kullanicicek("firma_kodu")
                firma_id = kullanicicek("firma_id")
                ekleyen_id = personel_id
                ekleyen_ip = Request.ServerVariables("Remote_Addr")
    
                SQL="insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& bildirim &"', '"& tip &"', N'"& click &"', '"& user_id &"', '"& okudumu &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate()); SET NOCOUNT ON; EXEC MailGonderBildirim @personel_id = '"& kcek("id") &"', @mesaj = '"& replace(bildirim, chr(13), "<br>") &"';"
                set ekle2 = baglanti.execute(SQL)

                NetGSM_SMS kcek("personel_telefon"), bildirim


            kcek.movenext
            loop



        elseif trn(request("islem2"))="sil" then

            kayit_id = trn(request("kayit_id"))

            SQL="update ucgem_personel_izin_talepleri set cop = 'true' where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set sil = baglanti.execute(SQL)

        end if
%>

<div class="dt-responsive table-responsive">
    <table id="new-cons" class="table table-striped table-bordered table-hover" width="100%">
        <thead>
            <tr>
                <th style="width: 30px;">ID</th>
                <th><%=LNG("İzin Başlangıç")%></th>
                <th><%=LNG("İzin Bitiş")%></th>
                <th><%=LNG("İzin Nedeni")%></th>
                <th><%=LNG("İzin Şekli")%></th>
                <th><%=LNG("Açıklama")%></th>
                <th><%=LNG("Durum")%></th>
                <th><%=LNG("İşlem")%></th>
            </tr>
        </thead>
        <tbody>
            <%
                SQL="select * from ucgem_personel_izin_talepleri where personel_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' and firma_id = '"& FirmaID &"' and cop = 'false'"
                set izin = baglanti.execute(SQL)

                if izin.eof then
            %>
            <tr>
                <td colspan="8" style="text-align: center;">Kayıt Bulunamadı</td>
            </tr>
            <% end if %>
            <%
                do while not izin.eof
            %>
            <tr>
                <td><%=izin("id") %></td>
                <td><%=cdate(izin("baslangic_tarihi")) %>&nbsp;<%=left(izin("baslangic_saati"),5) %></td>
                <td><%=cdate(izin("bitis_tarihi")) %>&nbsp;<%=left(izin("bitis_saati"),5) %></td>
                <td><%=izin("nedeni") %></td>
                <td><%=izin("turu") %></td>
                <td><%=izin("aciklama") %></td>
                <td><%=izin("durum") %></td>
                <td>
                    <input type="button" class="btn btn-mini btn-danger" onclick="izin_talebi_sil('<%=personel_id %>', '<%=izin("id") %>');" value="Sil" /></td>
            </tr>
            <%
                izin.movenext
                loop
            %>
        </tbody>
    </table>
</div>
<script>
                        $(function () {
                            var newcs = $('#new-cons').DataTable();
                            new $.fn.dataTable.Responsive(newcs);
                            $(".dataTables_length").hide();
                            setTimeout(function () {
                                $(".yetmislik").addClass("form-control");
                            }, 500);
                            $('a[title]').tooltip();
                        });
</script>
<%

    elseif trn(request("islem"))="profil_personel_giris_cikis_kayitlarini_getir" then

        personel_id = trn(request("personel_id"))

        if trn(request("islem2"))="ekle" then

            giris_tipi = trn(request("saat_tipi"))
            saat = trn(request("giris_cikis_saati"))
            tarih = trn(request("giris_cikis_tarihi"))

            cihazID = 0
            durum = "true"
            cop = "false"
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            
            SQL="insert into ucgem_personel_mesai_girisleri(tarih, saat, personel_id, cihazID, giris_tipi, ekleme_zamani, durum, cop, ekleme_tarihi, ekleme_saati, ekleyen_ip, firma_id, ekleyen_id) values('"& tarih &"', '"& saat &"', '" & personel_id & "', '" & cihazID & "', '" & giris_tipi & "', getdate(), '" & durum & "', '" & cop & "', getdate(), getdate(), '" & ekleyen_ip & "', '"& firma_id &"', '"& ekleyen_id &"')"
            set ekle = baglanti.execute(SQL)

        elseif trn(request("islem2"))="guncelle" then
    
            giris_tipi = trn(request("saat_tipi"))
            saat = trn(request("giris_cikis_saati"))
            tarih = trn(request("giris_cikis_tarihi"))
            kayit_id = trn(request("kayit_id"))

            SQL="update ucgem_personel_mesai_girisleri set giris_tipi = '"& giris_tipi &"', saat = '"& saat &"', tarih = '"& tarih &"', ekleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"', ekleme_tarihi = getdate(), ekleme_saati = getdate(), ekleme_zamani = getdate() where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)
            

        elseif trn(request("islem2"))="sil" then

            kayit_id = trn(request("kayit_id"))

            SQL="update ucgem_personel_mesai_girisleri set cop = 'true', silen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"', silme_tarihi = getdate(), silme_saati = getdate() where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set sil = baglanti.execute(SQL)

        end if
%>
<div class="dt-responsive table-responsive">
    <table id="new-cons" class="table table-striped table-bordered table-hover" width="100%">
        <thead>
            <tr>
                <th style="width: 30px;">ID</th>
                <th><%=LNG("Tarih")%></th>
                <th><%=LNG("Saat")%></th>
                <th><%=LNG("Tip")%></th>
                <th><%=LNG("Durum")%></th>
                <th><%=LNG("İşlem")%></th>
            </tr>
        </thead>
        <tbody>
            <%
                SQL="set datefirst 1;SELECT mesai.id as form_id, CASE WHEN mesai.giris_tipi = 1 THEN DATEDIFF( MINUTE, (CONVERT(DATETIME, mesai.tarih) + CONVERT(DATETIME, ISNULL( CASE WHEN DATEPART(dw, mesai.tarih) = 1 THEN kullanici.gun1_saat1 WHEN DATEPART(dw, mesai.tarih) = 2 THEN kullanici.gun2_saat1 WHEN DATEPART(dw, mesai.tarih) = 3 THEN kullanici.gun3_saat1 WHEN DATEPART(dw, mesai.tarih) = 4 THEN kullanici.gun4_saat1 WHEN DATEPART(dw, mesai.tarih) = 5 THEN kullanici.gun5_saat1 WHEN DATEPART(dw, mesai.tarih) = 6 THEN kullanici.gun6_saat1 WHEN DATEPART(dw, mesai.tarih) = 7 THEN kullanici.gun7_saat1 END, '00:00' ) ) ), CONVERT(DATETIME, mesai.tarih) + CONVERT(DATETIME, mesai.saat) ) ELSE DATEDIFF( MINUTE, (CONVERT(DATETIME, mesai.tarih) + CONVERT(DATETIME, ISNULL( CASE WHEN DATEPART(dw, mesai.tarih) = 1 THEN kullanici.gun1_saat2 WHEN DATEPART(dw, mesai.tarih) = 2 THEN kullanici.gun2_saat2 WHEN DATEPART(dw, mesai.tarih) = 3 THEN kullanici.gun3_saat2 WHEN DATEPART(dw, mesai.tarih) = 4 THEN kullanici.gun4_saat2 WHEN DATEPART(dw, mesai.tarih) = 5 THEN kullanici.gun5_saat2 WHEN DATEPART(dw, mesai.tarih) = 6 THEN kullanici.gun6_saat2 WHEN DATEPART(dw, mesai.tarih) = 7 THEN kullanici.gun7_saat2 END, '00:00' ) ) ), CONVERT(DATETIME, mesai.tarih) + CONVERT(DATETIME, mesai.saat) ) END AS fark, * FROM ucgem_personel_mesai_girisleri mesai JOIN ucgem_firma_kullanici_listesi kullanici ON kullanici.id = mesai.personel_id WHERE mesai.personel_id = '"& personel_id &"' AND mesai.cop = 'false' and mesai.firma_id = '"& FirmaID &"' ORDER BY mesai.tarih DESC;"
                set giris = baglanti.execute(SQL)
                if giris.eof then
            %>
            <tr>
                <td colspan="6" style="text-align: center;"><%=LNG("Personel Giriş-Çıkış Kaydı Bulunamadı.")%></td>
            </tr>
            <%
                end if
                do while not giris.eof
                k = k + 1 
            %>
            <tr>
                <td><%=k %></td>
                <td><%=day(cdate(giris("tarih"))) %>&nbsp;<%=monthname(month(cdate(giris("tarih")))) %>&nbsp;<%=year(cdate(giris("tarih"))) %>&nbsp;<%=weekdayname(weekday(cdate(giris("tarih")))) %></td>
                <td><%=left(giris("saat"),5) %></td>
                <td><% if trim(giris("giris_tipi"))="2" then %><%=LNG("İzin")%><% elseif trim(giris("giris_tipi"))="1" then %><%=LNG("Giriş")%><% else %><%=LNG("Çıkış")%><% end if %></td>
                <% if trim(giris("giris_tipi"))="2" then %>
                <td><span class="label label-info"><%=LNG("İzin Kullanıldı")%></span></td>
                <% elseif trim(giris("giris_tipi"))="1" then %>
                <td><span class="label label-<% if cdbl(giris("fark"))<=0 then %>success<% elseif cdbl(giris("fark"))<30 then %>warning<% else %>danger<% end if %>">
                    <% if cdbl(giris("fark"))<0 then %><%=cdbl(giris("fark"))*-1 %>&nbsp;<%=LNG("Dakika Erken")%><% elseif cdbl(giris("fark"))=0 then %><%=LNG("Zamanında")%><% else %><%=cdbl(giris("fark")) %>&nbsp;<%=LNG("Dakika Geç")%><% end if %></span></td>
                <% else %>
                <td><span class="label label-<% if cdbl(giris("fark"))>=0 then %>success<% elseif cdbl(giris("fark"))>30 then %>warning<% else %>danger<% end if %>">
                    <% if cdbl(giris("fark"))<0 then %><%=cdbl(giris("fark"))*-1 %>&nbsp;<%=LNG("Dakika Erken")%><% elseif cdbl(giris("fark"))=0 then %><%=LNG("Zamanında")%><% else %><%=cdbl(giris("fark")) %>&nbsp;<%=LNG("Dakika Geç")%><% end if %></span></td>
                <% end if %>
                <td>
                    <div style="width: 120px;">
                        <div class="btn-group dropdown-split-primary">
                            <button type="button" class="btn btn-mini btn-primary"><i class="icofont icofont-exchange"></i><%=LNG("İşlemler")%></button>
                            <button type="button" class="btn btn-primary btn-mini dropdown-toggle dropdown-toggle-split waves-effect waves-light" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="sr-only"><%=LNG("İşlemler")%></span>
                            </button>
                            <div class="dropdown-menu">
                                <!--<a class="dropdown-item waves-effect waves-light" href="javascript:void(0);" onclick="personel_giris_cikis_kaydi_duzenle('<%=personel_id %>', '<%=giris("form_id") %>');"><%=LNG("Kaydı Düzenle")%></a>-->
                                <a class="dropdown-item waves-effect waves-light" href="javascript:void(0);" onclick="personel_giris_cikis_kaydi_sil('<%=personel_id %>', '<%=giris("form_id") %>');"><%=LNG("Kaydı Sil")%></a>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            <%
                giris.movenext
                loop
            %>
        </tbody>
    </table>
</div>
<script>
                        $(function () {
                            var newcs = $('#new-cons').DataTable();
                            new $.fn.dataTable.Responsive(newcs);
                            $(".dataTables_length").hide();
                            setTimeout(function () {
                                $(".yetmislik").addClass("form-control");
                            }, 500);
                            $('a[title]').tooltip();
                        });
</script>
<%

    elseif trn(request("islem"))="personel_yillik_takvimi_getir_izin" then
        
        personel_id = trn(request("personel_id"))
        yil = trn(request("yil"))

        tarih1 = "01.01." & yil
        tarih2 = "31.12." & yil

        SQL="DECLARE @Date1 DATE = CONVERT(date, '"& tarih1 &"', 103), @Date2 DATE = CONVERT(date, '"& tarih2 &"', 103), @personel_id int = '"& personel_id &"'; SELECT DATEADD(DAY, number, @Date1) AS gun, CASE WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 1 THEN kullanici.gun1 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 2 THEN kullanici.gun2 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 3 THEN kullanici.gun3 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 4 THEN kullanici.gun4 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 5 THEN kullanici.gun5 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 6 THEN kullanici.gun6 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 7 THEN kullanici.gun7 END AS varmi, ( SELECT TOP 1 mesai3.giris_tipi FROM ucgem_personel_mesai_girisleri mesai3 WHERE mesai3.tarih = DATEADD(DAY, number, @Date1) AND mesai3.cop = 'false' AND mesai3.personel_id = kullanici.id AND mesai3.giris_tipi = 2 ) AS giris_tipi, ISNULL( ( SELECT TOP 1 ISNULL( CASE WHEN mesai1.giris_tipi = 1 THEN DATEDIFF( MINUTE, (CONVERT(DATETIME, mesai1.tarih) + CONVERT( DATETIME, ISNULL( CASE WHEN DATEPART(dw, mesai1.tarih) = 1 THEN kullanici.gun1_saat1 WHEN DATEPART(dw, mesai1.tarih) = 2 THEN kullanici.gun2_saat1 WHEN DATEPART(dw, mesai1.tarih) = 3 THEN kullanici.gun3_saat1 WHEN DATEPART(dw, mesai1.tarih) = 4 THEN kullanici.gun4_saat1 WHEN DATEPART(dw, mesai1.tarih) = 5 THEN kullanici.gun5_saat1 WHEN DATEPART(dw, mesai1.tarih) = 6 THEN kullanici.gun6_saat1 WHEN DATEPART(dw, mesai1.tarih) = 7 THEN kullanici.gun7_saat1 END, '00:00' ) ) ), CONVERT(DATETIME, mesai1.tarih) + CONVERT(DATETIME, mesai1.saat) ) END, '999' ) FROM ucgem_personel_mesai_girisleri mesai1 WHERE mesai1.tarih = DATEADD(DAY, number, @Date1) AND mesai1.cop = 'false' AND mesai1.personel_id = kullanici.id AND mesai1.giris_tipi = 1 ), '999' ) AS fark, ISNULL((SELECT top 1 ISNULL( CASE WHEN mesai2.giris_tipi = 0 THEN DATEDIFF( MINUTE, (CONVERT(DATETIME, mesai2.tarih) + CONVERT( DATETIME, ISNULL( CASE WHEN DATEPART(dw, mesai2.tarih) = 1 THEN kullanici.gun1_saat2 WHEN DATEPART(dw, mesai2.tarih) = 2 THEN kullanici.gun2_saat2 WHEN DATEPART(dw, mesai2.tarih) = 3 THEN kullanici.gun3_saat2 WHEN DATEPART(dw, mesai2.tarih) = 4 THEN kullanici.gun4_saat2 WHEN DATEPART(dw, mesai2.tarih) = 5 THEN kullanici.gun5_saat2 WHEN DATEPART(dw, mesai2.tarih) = 6 THEN kullanici.gun6_saat2 WHEN DATEPART(dw, mesai2.tarih) = 7 THEN kullanici.gun7_saat2 END, '00:00' ) ) ), CONVERT(DATETIME, mesai2.tarih) + CONVERT(DATETIME, mesai2.saat) ) END, '999' ) FROM ucgem_personel_mesai_girisleri mesai2 WHERE mesai2.tarih = DATEADD(DAY, number, @Date1) AND mesai2.cop = 'false' AND mesai2.personel_id = kullanici.id AND mesai2.giris_tipi = 0 ), '999' ) AS fark2 FROM master..spt_values JOIN dbo.ucgem_firma_kullanici_listesi kullanici ON kullanici.id = @personel_id WHERE type = 'P' and kullanici.firma_id = '"& FirmaID &"' AND DATEADD(DAY, number, @Date1) <= @Date2;"
        set cek = baglanti.execute(SQL)
%>
<style>
    .backrenk {
        background-color: #f2f2f2;
    }

    .reserve-list tr td {
        min-width: 20px !important;
    }
</style>
<div class="dt-responsive table-responsive">
    <table class="reserve-list" style="width: 98%;">
        <thead>
            <tr>
                <th style="width: 100px; text-align: center; background-color: #ff5370; border: solid 1px black; color: White; font-size: 14px;">
                    <input type="button" class="btn btn-mini btn-warning" onclick="personel_yillik_takvimi_getir_izin(<%=personel_id %>,<%=cdbl(yil) - 1 %>);" style="float: left;" value="<<">&nbsp;<%=yil %>&nbsp;<input type="button" class="btn btn-mini btn-warning" style="float: right;" onclick="personel_yillik_takvimi_getir_izin(<%=personel_id %>,<%=cdbl(yil) + 1 %>);" value=">>"></th>
                <% for x = 1 to 31 %>
                <th style="text-align: center; background-color: #ccc; border: solid 1px black;"><%=x %></th>
                <% next %>
            </tr>
        </thead>

        <%
     for t = 1 to 12
     
        if t mod 2 = 0 then
            renk = "#429aff;"
            renk2 = ""
        else
            renk = "#73b4ff"
            renk2="backrenk"
        end if

        %>
        <tr>
            <td align="center" style="font-weight: bold; height: 25px; background-color: <%=renk%>; vertical-align: middle; border: solid 1px black; text-align: center; color: White;"><%=ucase(monthname(t)) %></td>
            <% for x = 1 to 31 %>
            <% 
            tarih = x & "." & t &"." & yil
            if isdate(tarih) then
                yenirenk = ""
                if not cek.eof then

                    if trim(cek("varmi"))="False" then
                        yenirenk = "#ccc"
                    elseif trim(cek("giris_tipi"))="2" then
                        yenirenk = "#4099ff"
                    elseif trim(cek("fark"))="999" then
                        yenirenk = ""
                    elseif cdbl(cek("fark"))<=0 then
                        yenirenk = ""
                    elseif cdbl(cek("fark"))<30 then 
                        yenirenk = ""
                    else
                        yenirenk = ""    
                    end if
                end if


            
            %>
            <td onclick="giris_izin_talebi_ekle('<%=personel_id %>','<%=cdate(tarih) %>');" tarih="<%=cdate(tarih) %>" style="<% if cdate(tarih)=cdate(date) then %> border: solid 2px red; <% else %> border: solid 1px black; <% end if %> width: 2%; background-color: <%=yenirenk %>!important;" class="<% if cdate(tarih)>=cdate(date) then %> secilebilir3 <% else %> secilemez3 <% end if %> ustunesari" align="center">&nbsp;</td>
            <% 
            if month(tarih)=12 and day(tarih)=31 then
            else
                cek.movenext
            end if
        else
            %>
            <td style="background-color: Black;" align="center">&nbsp;</td>
            <% end if %>
            <%  next  %>
        </tr>
        <% 
            next 
        %>
    </table>
</div>
<%


    elseif trn(request("islem"))="profil_personel_mesai_getir" then


        personel_id = trn(request("personel_id"))

        sql="select * from ucgem_firma_kullanici_listesi where id = '"& personel_id &"' and firma_id = '"& FirmaID &"'"
        set personel = baglanti.execute(SQL)

%>
<script type="text/javascript">
    if ($(window).width() < 500) {
        $("#personelyilliktakvim").hide();
        $("#takvimcizgi").hide();
        $("#mesaibildirim").addClass("btn-mini");
    }
</script>
<div class="card">
    <div class="card-block">
        <div class="view-info">
            <div class="row" id="personelyilliktakvim">
                <div class="col-lg-12">
                    <h5 class="card-header-text"><%=LNG("Mesai Raporum")%></h5>
                    <br />
                    <br />
                    <div id="yillik_takvim_yeri_mesai">
                        <script>
                            $(function (){
                                personel_yillik_takvimi_getir_mesai('<%=personel_id %>', '<%=year(date) %>');
                            });
                        </script>
                    </div>
                    <table>
                        <tbody>
                            <tr>
                                <td>
                                    <div style="border: solid 1px black; width: 39px; height: 28px; background-color: #2ed8b6;"></div>
                                </td>
                                <td style="vertical-align: middle; padding: 6px;"><%=LNG("Onaylandı")%></td>
                                <td>
                                    <div style="border: solid 1px black; width: 39px; height: 28px; background-color: #f1c40f;"></div>
                                </td>
                                <td style="vertical-align: middle; padding: 6px;"><%=LNG("Onay Bekliyor")%></td>
                                <td>
                                    <div style="border: solid 1px black; width: 39px; height: 28px; background-color: #ff5370;"></div>
                                </td>
                                <td style="vertical-align: middle; padding: 6px;"><%=LNG("Reddedildi")%></td>
                            </tr>
                        </tbody>
                    </table>
                    <style>
                        .renk2_1 {
                            background-color: #f2f2f2;
                        }

                        .renk2_2 {
                            background-color: #2ed8b6;
                        }

                        .renk2_3 {
                            background-color: #f1c40f;
                        }

                        .renk2_4 {
                            background-color: #ff5370;
                        }

                        .ui-selecting {
                            background-color: #FECA40 !important;
                        }
                    </style>

                </div>
            </div>

            <hr id="takvimcizgi" />
            <div class="row">

                <style>
                    .table > caption + thead > tr:first-child > td, .table > caption + thead > tr:first-child > th, .table > colgroup + thead > tr:first-child > td, .table > colgroup + thead > tr:first-child > th, .table > thead:first-child > tr:first-child > td, .table > thead:first-child > tr:first-child > th {
                        border-top: 1px solid #ccc !important;
                    }

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

                    /*
                    .table td, .table th {
                        padding: .75rem !important;
                    }*/

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
                <div class="col-lg-12 col-xl-12" style="padding-top: 15px;">
                    <h5 class="card-header-text"><%=LNG("Mesai Bilgilerim")%>
                       
                    </h5>
                    <span style="float: right;">
                        <button onclick="modal_mesai_bildirimi_yap('<%=personel_id %>', 'Onay Bekliyor');" class="btn btn-success mb-1" id="mesaibildirim">Mesai Bildirimi Yap</button>
                    </span>
                    <br />
                    <br />
                    <div id="mesai_kayitlari">
                        <script>
                            $(function (){
                                profil_personel_mesai_kayitlarini_getir('<%=personel_id %>');
                            });
                        </script>

                    </div>

                </div>
            </div>

            <hr />


        </div>
    </div>
</div>
<%
    elseif trn(request("islem"))="profil_personel_mesai_kayitlarini_getir" then


        personel_id = trn(request("personel_id"))
        mesai_personel_adina = trn(request("mesai_personel_adina"))

        if trn(request("islem2"))="ekle" then

            if not mesai_personel_adina = 0 then
                personel_id = mesai_personel_adina
            end if
       
            baslangic_tarihi = trn(request("baslangic_tarihi"))
            baslangic_saati = trn(request("baslangic_saati"))
            'bitis_tarihi = trn(request("bitis_tarihi"))
            bitis_saati = trn(request("bitis_saati"))
            aciklama = trn(request("aciklama"))
            durum = trn(request("durum"))

            durum = "Onay Bekliyor"
            SQL="select * from ucgem_firma_kullanici_listesi where id = '"& personel_id &"' and firma_id = '"& FirmaID &"'"
            set kullanicicek = baglanti.execute(SQL)

            cop = "false"
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time
            OlusturanPersonelID = Request.Cookies("kullanici")("kullanici_id")

            SQL="insert into ucgem_personel_mesai_bildirimleri(personel_id, baslangic_tarihi, baslangic_saati, bitis_tarihi, bitis_saati, aciklama, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, OlusturanPersonelID) values('"& personel_id &"', CONVERT(date, '"& baslangic_tarihi &"', 103), '"& baslangic_saati &"', NULL, '"& bitis_saati &"', '"& aciklama &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"', '"& OlusturanPersonelID &"')"
            set ekle = baglanti.execute(SQL)



            SQL="select * from ucgem_firma_kullanici_listesi where firma_id = '"& firma_id &"' and cop = 'false' and durum = 'true' and isnull(yonetici_yetkisi, 'false')='true'"
            set kcek = baglanti.execute(SQL)

            do while not kcek.eof

                bildirim = kullanicicek("personel_ad") & " " & kullanicicek("personel_soyad") & " "& cdate(baslangic_tarihi) &" "& left(baslangic_saati,5) &" ile "& cdate(baslangic_tarihi) &" "& left(bitis_saati,5) &" saatleri arasında mesai bildiriminde bulundu." & chr(13) & chr(13) & "Açıklama :" & aciklama & chr(13) & chr(13)
                tip = "is_listesi"
                click = "CokluIsYap(''personel_detaylari'',''"& kullanicicek("id") &"'',''mesai'',0);" 
                user_id = kcek("id")
                okudumu = "0"
                durum = "true"
                cop = "false"
                firma_kodu = kullanicicek("firma_kodu")
                firma_id = kullanicicek("firma_id")
                ekleyen_id = personel_id
                ekleyen_ip = Request.ServerVariables("Remote_Addr")
    
                SQL="insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& bildirim &"', '"& tip &"', N'"& click &"', '"& user_id &"', '"& okudumu &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate()); SET NOCOUNT ON; EXEC MailGonderBildirim @personel_id = '"& kcek("id") &"', @mesaj = '"& replace(bildirim, chr(13), "<br>") &"';"
                set ekle2 = baglanti.execute(SQL)

                NetGSM_SMS kcek("personel_telefon"), bildirim


            kcek.movenext
            loop



        elseif trn(request("islem2"))="sil" then
    
            kayit_id = trn(request("kayit_id"))


            SQL="UPDATE ucgem_personel_mesai_bildirimleri SET cop='true' WHERE id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set sil = baglanti.execute(SQL)
            

        end if
%>
<div class="dt-responsive table-responsive">
    <table id="new-cons" class="table table-striped table-bordered table-hover" width="100%">
        <thead>
            <tr>
                <th style="width: 30px;">ID</th>
                <th><%=LNG("Mesai Tarihi")%></th>
                <th><%=LNG("Mesai Başlangıç Saati")%></th>
                <th><%=LNG("Mesai Bitiş Saati")%></th>
                <th><%=LNG("Açıklama")%></th>
                <th><%=LNG("Durum")%></th>
                <th><%=LNG("İşlem")%></th>
            </tr>
        </thead>
        <tbody>
            <%
                SQL="select * from ucgem_personel_mesai_bildirimleri where personel_id = '"& personel_id &"' and firma_id = '"& FirmaID &"' and cop = 'false'"
                set mesai = baglanti.execute(SQL)
                if mesai.eof then
            %>
            <tr>
                <td colspan="7" style="text-align: center;">Kayıt Bulunamadı</td>
            </tr>
            <%
                end if
                do while not mesai.eof
            %>
            <tr>
                <td style="width: 30px;"><%=mesai("id") %></td>
                <td><%=cdate(mesai("baslangic_tarihi")) %></td>
                <td><%=left(mesai("baslangic_saati"),5) %></td>
                <td><%=left(mesai("bitis_saati"),5) %></td>
                <td><%=mesai("aciklama") %></td>
                <td><%=mesai("durum") %></td>
                <td>
                    <input type="button" class="btn btn-danger btn-mini" value="Sil" onclick="mesai_bildirim_sil('<%=personel_id%>', '<%=mesai("id")%>');" /></td>
            </tr>
            <%
                mesai.movenext
                loop
            %>
        </tbody>
    </table>
</div>
<script>
    $(function () {
        var newcs = $('#new-cons').DataTable();
        new $.fn.dataTable.Responsive(newcs);
        $(".dataTables_length").hide();
        setTimeout(function () {
            $(".yetmislik").addClass("form-control");
        }, 500);
        $('a[title]').tooltip();
    });
</script>
<%



    elseif trn(request("islem"))="personel_yillik_takvimi_getir_mesai" then

        personel_id = trn(request("personel_id"))
        yil = trn(request("yil"))

        tarih1 = "01.01." & yil
        tarih2 = "31.12." & yil

        SQL="DECLARE @Date1 DATE = CONVERT(date, '"& tarih1 &"', 103), @Date2 DATE = CONVERT(date, '"& tarih2 &"', 103), @personel_id int = '"& personel_id &"';  SELECT isnull((select top 1 durum from ucgem_personel_mesai_bildirimleri where personel_id = @personel_id and firma_id = '"& FirmaID &"' and DATEADD(DAY, number, @Date1) between baslangic_tarihi and bitis_tarihi order by id desc),'false') as mesaidurum, DATEADD(DAY, number, @Date1) AS gun, CASE WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 1 THEN kullanici.gun1 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 2 THEN kullanici.gun2 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 3 THEN kullanici.gun3 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 4 THEN kullanici.gun4 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 5 THEN kullanici.gun5 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 6 THEN kullanici.gun6 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 7 THEN kullanici.gun7 END AS varmi, ( SELECT TOP 1 mesai3.giris_tipi FROM ucgem_personel_mesai_girisleri mesai3 WHERE mesai3.tarih = DATEADD(DAY, number, @Date1) and mesai3.firma_id = '"& FirmaID &"' AND mesai3.cop = 'false' AND mesai3.personel_id = kullanici.id AND mesai3.giris_tipi = 2 ) AS giris_tipi, ISNULL( ( SELECT TOP 1 ISNULL( CASE WHEN mesai1.giris_tipi = 1 THEN DATEDIFF( MINUTE, (CONVERT(DATETIME, mesai1.tarih) + CONVERT( DATETIME, ISNULL( CASE WHEN DATEPART(dw, mesai1.tarih) = 1 THEN kullanici.gun1_saat1 WHEN DATEPART(dw, mesai1.tarih) = 2 THEN kullanici.gun2_saat1 WHEN DATEPART(dw, mesai1.tarih) = 3 THEN kullanici.gun3_saat1 WHEN DATEPART(dw, mesai1.tarih) = 4 THEN kullanici.gun4_saat1 WHEN DATEPART(dw, mesai1.tarih) = 5 THEN kullanici.gun5_saat1 WHEN DATEPART(dw, mesai1.tarih) = 6 THEN kullanici.gun6_saat1 WHEN DATEPART(dw, mesai1.tarih) = 7 THEN kullanici.gun7_saat1 END, '00:00' ))), CONVERT(DATETIME, mesai1.tarih) + CONVERT(DATETIME, mesai1.saat) ) END, '999' ) FROM ucgem_personel_mesai_girisleri mesai1 WHERE mesai1.tarih = DATEADD(DAY, number, @Date1) and mesai1.firma_id = '"& FirmaID &"' AND mesai1.cop = 'false' AND mesai1.personel_id = kullanici.id AND mesai1.giris_tipi = 1 ), '999' ) AS fark, ISNULL( ( SELECT TOP 1 ISNULL( CASE WHEN mesai2.giris_tipi = 0 THEN DATEDIFF( MINUTE, (CONVERT(DATETIME, mesai2.tarih) + CONVERT( DATETIME, ISNULL( CASE WHEN DATEPART(dw, mesai2.tarih) = 1 THEN kullanici.gun1_saat2 WHEN DATEPART(dw, mesai2.tarih) = 2 THEN kullanici.gun2_saat2 WHEN DATEPART(dw, mesai2.tarih) = 3 THEN kullanici.gun3_saat2 WHEN DATEPART(dw, mesai2.tarih) = 4 THEN kullanici.gun4_saat2 WHEN DATEPART(dw, mesai2.tarih) = 5 THEN kullanici.gun5_saat2 WHEN DATEPART(dw, mesai2.tarih) = 6 THEN kullanici.gun6_saat2 WHEN DATEPART(dw, mesai2.tarih) = 7 THEN kullanici.gun7_saat2 END, '00:00' ) ) ), CONVERT(DATETIME, mesai2.tarih) + CONVERT(DATETIME, mesai2.saat) ) END, '999' ) FROM ucgem_personel_mesai_girisleri mesai2 WHERE mesai2.tarih = DATEADD(DAY, number, @Date1) and mesai2.firma_id = '"& FirmaID &"' AND mesai2.cop = 'false' AND mesai2.personel_id = kullanici.id AND mesai2.giris_tipi = 0 ), '999' ) AS fark2 FROM master..spt_values JOIN dbo.ucgem_firma_kullanici_listesi kullanici ON kullanici.id = @personel_id WHERE type = 'P' AND DATEADD(DAY, number, @Date1) <= @Date2 and kullanici.firma_id = '"& FirmaID &"'"
        set cek = baglanti.execute(SQL)
%>
<style>
    .backrenk {
        background-color: #f2f2f2;
    }

    .reserve-list tr td {
        min-width: 20px !important;
    }
</style>
<div class="dt-responsive table-responsive">
    <table class="reserve-list" style="width: 98%;">
        <thead>
            <tr>
                <th style="width: 100px; text-align: center; background-color: #ff5370; border: solid 1px black; color: White; font-size: 14px;">
                    <input type="button" class="btn btn-mini btn-warning" onclick="personel_yillik_takvimi_getir(<%=personel_id %>,<%=cdbl(yil) - 1 %>);" style="float: left;" value="<<">&nbsp;<%=yil %>&nbsp;<input type="button" class="btn btn-mini btn-warning" style="float: right;" onclick="personel_yillik_takvimi_getir(<%=personel_id %>,<%=cdbl(yil) + 1 %>);" value=">>"></th>
                <% for x = 1 to 31 %>
                <th style="text-align: center; background-color: #ccc; border: solid 1px black;"><%=x %></th>
                <% next %>
            </tr>
        </thead>

        <%
     for t = 1 to 12
     
        if t mod 2 = 0 then
            renk = "#429aff;"
            renk2 = ""
        else
            renk = "#73b4ff"
            renk2="backrenk"
        end if

        %>
        <tr>
            <td align="center" style="font-weight: bold; height: 25px; background-color: <%=renk%>; vertical-align: middle; border: solid 1px black; text-align: center; color: White;"><%=ucase(monthname(t)) %></td>
            <% for x = 1 to 31 %>
            <% 
            tarih = x & "." & t &"." & yil
            if isdate(tarih) then
                yenirenk = ""
                if not cek.eof then

                    if 1 = 2 then
                        if trim(cek("varmi"))="False" then
                            yenirenk = "#ccc"
                        elseif trim(cek("giris_tipi"))="2" then
                            yenirenk = ""
                        elseif trim(cek("fark"))="999" then
                            yenirenk = ""
                        elseif cdbl(cek("fark"))<=0 then
                            yenirenk = "#2ed8b6"
                        elseif cdbl(cek("fark"))<30 then 
                            yenirenk = "#f1c40f"
                        else
                            yenirenk = "#ff5370"    
                        end if
                    end if

                    if trim(cek("mesaidurum"))="Onaylandı" then
                        yenirenk = "#2ed8b6"    
                    elseif trim(cek("mesaidurum"))="Onay Bekliyor" then
                        yenirenk = "#f1c40f"    
                    elseif trim(cek("mesaidurum"))="Reddedildi" then
                        yenirenk = "#ff5370"    
                    end if
                end if
            
            %>
            <td onclick="giris_cikis_kaydi_ekle('<%=personel_id %>','<%=cdate(tarih) %>');" tarih="<%=cdate(tarih) %>" style="<% if cdate(tarih)=cdate(date) then %> border: solid 2px red; <% else %> border: solid 1px black; <% end if %> width: 2%; background-color: <%=yenirenk %>!important;" class="<% if cdate(tarih)>=cdate(date) then %> secilebilir3 <% else %> secilemez3 <% end if %> ustunesari" align="center">&nbsp;</td>
            <% 
            if month(tarih)=12 and day(tarih)=31 then
            else
                cek.movenext
            end if
        else
            %>
            <td style="background-color: Black;" align="center">&nbsp;</td>
            <% end if %>
            <%  next  %>
        </tr>
        <% 
            next 
        %>
    </table>
</div>
<%

    elseif trn(request("islem"))="profil_personel_bordro_getir" then

        personel_id = trn(request("personel_id"))

%>
<div class="card">
    <div class="card-block">
        <div class="view-info">
            <div class="row">
                <div class="col-lg-12">
                    <h5 class="card-header-text"><%=LNG("Bordrolarım")%></h5>
                    <br />
                    <br />
                    <div class="dt-responsive table-responsive">
                        <table id="new-cons" class="table table-striped table-bordered table-hover" width="100%">
                            <thead>
                                <tr>
                                    <th style="width: 30px;">ID</th>
                                    <th><%=LNG("Dönem")%></th>
                                    <th><%=LNG("Ekleme Tarihi")%></th>
                                    <th><%=LNG("Açıklama")%></th>
                                    <th><%=LNG("İşlem")%></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    SQL="select * from ucgem_personel_bordro_listesi where personel_id = '"& personel_id &"' and firma_id = '"& FirmaID &"' and cop = 'false'"
                                    set bordro = baglanti.execute(SQL)
                                    if bordro.eof then
                                %>
                                <tr>
                                    <td colspan="5" style="text-align: center;">Kayıt Bulunamadı</td>
                                </tr>
                                <%
                                    end if
                                    do while not bordro.eof
                                %>
                                <tr>
                                    <td style="width: 30px;"><%=bordro("id") %></td>
                                    <td><%=bordro("donem") %></td>
                                    <td><%=cdate(bordro("ekleme_tarihi")) %>&nbsp;<%=left(bordro("ekleme_saati"),5) %></td>
                                    <td><%=bordro("aciklama") %></td>
                                    <td>
                                        <input type="button" onclick="bordro_indir('<%=bordro("dosya_yolu")%>');" class="btn btn-mini btn-primary" value="İndir" /></td>
                                </tr>
                                <%
                                    bordro.movenext
                                    loop
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%
    

    elseif trn(request("islem"))="profil_personel_yillik_takvimi_getir" then
        
        personel_id = trn(request("personel_id"))
        yil = trn(request("yil"))

        tarih1 = "01.01." & yil
        tarih2 = "31.12." & yil

        SQL="DECLARE @Date1 DATE = CONVERT(date, '"& tarih1 &"', 103), @Date2 DATE = CONVERT(date, '"& tarih2 &"', 103), @personel_id int = '"& personel_id &"'; SELECT DATEADD(DAY, number, @Date1) AS gun, CASE WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 1 THEN kullanici.gun1 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 2 THEN kullanici.gun2 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 3 THEN kullanici.gun3 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 4 THEN kullanici.gun4 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 5 THEN kullanici.gun5 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 6 THEN kullanici.gun6 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 7 THEN kullanici.gun7 END AS varmi, ( SELECT TOP 1 mesai3.giris_tipi FROM ucgem_personel_mesai_girisleri mesai3 WHERE mesai3.tarih = DATEADD(DAY, number, @Date1) AND mesai3.cop = 'false' AND mesai3.personel_id = kullanici.id AND mesai3.giris_tipi = 2 ) AS giris_tipi, ISNULL( ( SELECT TOP 1 ISNULL( CASE WHEN mesai1.giris_tipi = 1 THEN DATEDIFF( MINUTE, (CONVERT(DATETIME, mesai1.tarih) + CONVERT( DATETIME, ISNULL( CASE WHEN DATEPART(dw, mesai1.tarih) = 1 THEN kullanici.gun1_saat1 WHEN DATEPART(dw, mesai1.tarih) = 2 THEN kullanici.gun2_saat1 WHEN DATEPART(dw, mesai1.tarih) = 3 THEN kullanici.gun3_saat1 WHEN DATEPART(dw, mesai1.tarih) = 4 THEN kullanici.gun4_saat1 WHEN DATEPART(dw, mesai1.tarih) = 5 THEN kullanici.gun5_saat1 WHEN DATEPART(dw, mesai1.tarih) = 6 THEN kullanici.gun6_saat1 WHEN DATEPART(dw, mesai1.tarih) = 7 THEN kullanici.gun7_saat1 END, '00:00' ) ) ), CONVERT(DATETIME, mesai1.tarih) + CONVERT(DATETIME, mesai1.saat) ) END, '999' ) FROM ucgem_personel_mesai_girisleri mesai1 WHERE mesai1.tarih = DATEADD(DAY, number, @Date1) AND mesai1.cop = 'false' AND mesai1.personel_id = kullanici.id AND mesai1.giris_tipi = 1 ), '999' ) AS fark, ISNULL( ( SELECT top 1 ISNULL( CASE WHEN mesai2.giris_tipi = 0 THEN DATEDIFF( MINUTE, (CONVERT(DATETIME, mesai2.tarih) + CONVERT( DATETIME, ISNULL( CASE WHEN DATEPART(dw, mesai2.tarih) = 1 THEN kullanici.gun1_saat2 WHEN DATEPART(dw, mesai2.tarih) = 2 THEN kullanici.gun2_saat2 WHEN DATEPART(dw, mesai2.tarih) = 3 THEN kullanici.gun3_saat2 WHEN DATEPART(dw, mesai2.tarih) = 4 THEN kullanici.gun4_saat2 WHEN DATEPART(dw, mesai2.tarih) = 5 THEN kullanici.gun5_saat2 WHEN DATEPART(dw, mesai2.tarih) = 6 THEN kullanici.gun6_saat2 WHEN DATEPART(dw, mesai2.tarih) = 7 THEN kullanici.gun7_saat2 END, '00:00' ) ) ), CONVERT(DATETIME, mesai2.tarih) + CONVERT(DATETIME, mesai2.saat) ) END, '999' ) FROM ucgem_personel_mesai_girisleri mesai2 WHERE mesai2.tarih = DATEADD(DAY, number, @Date1) AND mesai2.cop = 'false' AND mesai2.personel_id = kullanici.id AND mesai2.giris_tipi = 0 ), '999' ) AS fark2 FROM master..spt_values JOIN dbo.ucgem_firma_kullanici_listesi kullanici ON kullanici.id = @personel_id WHERE type = 'P' and kullanici.firma_id = '"& FirmaID &"' AND DATEADD(DAY, number, @Date1) <= @Date2;"
        set cek = baglanti.execute(SQL)
%>
<style>
    .backrenk {
        background-color: #f2f2f2;
    }

    .reserve-list tr td {
        min-width: 20px !important;
    }
</style>
<div class="dt-responsive table-responsive">
    <table class="reserve-list" style="width: 98%;">
        <thead>
            <tr>
                <th style="width: 100px; text-align: center; background-color: #ff5370; border: solid 1px black; color: White; font-size: 14px;">
                    <input type="button" class="btn btn-mini btn-warning" onclick="profil_personel_yillik_takvimi_getir(<%=personel_id %>,<%=cdbl(yil) - 1 %>);" style="float: left;" value="<<">&nbsp;<%=yil %>&nbsp;<input type="button" class="btn btn-mini btn-warning" style="float: right;" onclick="profil_personel_yillik_takvimi_getir(<%=personel_id %>,<%=cdbl(yil) + 1 %>);" value=">>"></th>
                <% for x = 1 to 31 %>
                <th style="text-align: center; background-color: #ccc; border: solid 1px black;"><%=x %></th>
                <% next %>
            </tr>
        </thead>

        <%
     for t = 1 to 12
     
        if t mod 2 = 0 then
            renk = "#429aff;"
            renk2 = ""
        else
            renk = "#73b4ff"
            renk2="backrenk"
        end if

        %>
        <tr>
            <td align="center" style="font-weight: bold; height: 25px; background-color: <%=renk%>; vertical-align: middle; border: solid 1px black; text-align: center; color: White;"><%=ucase(monthname(t)) %></td>
            <% for x = 1 to 31 %>
            <% 
            tarih = x & "." & t &"." & yil
            if isdate(tarih) then
                yenirenk = ""
                if not cek.eof then

                    if trim(cek("varmi"))="False" then
                        yenirenk = "#ccc"
                    elseif trim(cek("giris_tipi"))="2" then
                        yenirenk = "#4099ff"
                    elseif trim(cek("fark"))="999" then
                        yenirenk = ""
                    elseif cdbl(cek("fark"))<=0 then
                        yenirenk = "#2ed8b6"
                    elseif cdbl(cek("fark"))<30 then 
                        yenirenk = "#f1c40f"
                    else
                        yenirenk = "#ff5370"    
                    end if
                end if
            
            %>
            <td onclicks="giris_cikis_kaydi_ekle('<%=personel_id %>','<%=cdate(tarih) %>');" tarih="<%=cdate(tarih) %>" style="<% if cdate(tarih)=cdate(date) then %> border: solid 2px red; <% else %> border: solid 1px black; <% end if %> width: 2%; background-color: <%=yenirenk %>!important;" class="<% if cdate(tarih)>=cdate(date) then %> secilebilir3 <% else %> secilemez3 <% end if %> ustunesari" align="center">&nbsp;</td>
            <% 
            if month(tarih)=12 and day(tarih)=31 then
            else
                cek.movenext
            end if
        else
            %>
            <td style="background-color: Black;" align="center">&nbsp;</td>
            <% end if %>
            <%  next  %>
        </tr>
        <% 
            next
        %>
    </table>
</div>
<%

      elseif trn(request("islem"))="mdoal_mesai_bildirimi_yap" then

        personel_id = trn(request("personel_id"))
        durum = trn(request("durum"))

       SQL = "select * from ucgem_firma_kullanici_listesi where id = '"& Request.Cookies("kullanici")("kullanici_id") &"' and firma_id = '"& FirmaID &"' and cop = 'false'"
       set personel = baglanti.execute(SQL)

       yetki = "false"
       visible = ""
       if personel("yonetici_yetkisi") = "true" then
           yetki = "true"
       else
           visible = "style='display:none'"
       end if

        if not durum = "Onaylandı" then
            durum = "Onay Bekliyor"
        end if

%>
<form id="koftiforms"></form>
<div class="modal-header">
    <%=LNG("Mesai Bildirimi Yap")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>

<form autocomplete="off" id="mesai_bildirim_form" class="smart-form validateform" style="padding: 15px;">
    <div class="row" <%=visible %>>
        <label class="col-sm-12 col-form-label"><%=LNG("Personel Adına")%></label>
        <div class="form-group col-sm-12">
            <select id="mesai_personel_adina" class="select2">
                <option value="0">Personel Seç</option>
                <%
                    SQL = "select id, personel_ad +' '+ personel_soyad as ad_soyad from ucgem_firma_kullanici_listesi where cop = 'false' and firma_id = '"& FirmaID &"'"
                    set personeller = baglanti.execute(SQL)

                    if not personeller.eof then
                    do while not personeller.eof
                %>
                    <option value="<%=personeller("id") %>""><%=personeller("ad_soyad") %></option>
                <%
                    personeller.movenext
                    loop
                    end if
                %>
            </select>
        </div>
    </div>
    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Mesai Başlangıç Tarihi")%></label>
        <div class="col-sm-8">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <script type="text/javascript">
                    $(".takvimyap").datepicker({

                    }).datepicker("setDate", new Date());
                    //$("#mesai_baslangic_tarihi").datepicker({ dateFormat: "dd.mm.yyyy" }).datepicker("setDate", new Date());
                    //$("#mesai_baslangic_tarihi").datepicker({ dateFormat: "dd-mm-yyyy" }).val(new Date().getDate() + "." + new Date().getMonth() + "." + new Date().getFullYear());
                </script>
                <input type="text" class="required form-control takvimyap" name="mesai_baslangic_tarihi" id="mesai_baslangic_tarihi" placeholder="__.__.____" />
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            <label class="col-form-label"><%=LNG("Mesai Başlangıç Saati")%></label>
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" class="required form-control timepicker" name="mesai_baslangic_saati" id="mesai_baslangic_saati" placeholder="__:__" />
            </div>
        </div>
        <div class="col-md-6">
            <label class="col-form-label"><%=LNG("Mesai Bitiş Saati")%></label>
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" class="required form-control timepicker" name="mesai_bitis_saati" id="mesai_bitis_saati" placeholder="__:__" />
            </div>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label" style="display: none"><%=LNG("Mesai Bitiş Tarihi")%></label>
        <div class="col-sm-8" style="display: none">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <script type="text/javascript">
                    $("#mesai_bitis_tarihi").datepicker({ dateFormat: "dd-mm-yyyy" }).datepicker("setDate", $("#mesai_baslangic_tarihi").val());
                </script>
                <input type="text" class="required form-control takvimyap" name="mesai_bitis_tarihi" id="mesai_bitis_tarihi" placeholder="__.__.____" />
            </div>
        </div>

    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Açıklama")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <textarea name="mesai_aciklama" class="form-control" id="mesai_aciklama"></textarea>
            </div>
        </div>
    </div>


    <div class="modal-footer">
        <input type="button" onclick="mesai_bildirim_kaydet(<%=personel_id %>, '<%=durum%>');" class="btn btn-primary" value="<%=LNG("Mesai Bildirimi Yap")%>" />
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#mesai_personel_adina").select2({
                dropdownParent: $("#modal_div")
            });
        });
    </script>
</form>

<%
    elseif trn(request("islem"))="yeni_izin_talebi_modal" then

       personel_id = trn(request("personel_id"))

       SQL = "select * from ucgem_firma_kullanici_listesi where id = '"& Request.Cookies("kullanici")("kullanici_id") &"' and firma_id = '"& FirmaID &"' and cop = 'false'"
       set personel = baglanti.execute(SQL)

       yetki = "false"
       visible = ""
       if personel("yonetici_yetkisi") = "true" then
           yetki = "true"
       else
           visible = "style='display:none'"
       end if

       SQL = "select isnull(kullanici.personel_yillik_izin, 0) - isnull((select Count(giris.id) from ucgem_personel_mesai_girisleri giris, ucgem_personel_izin_talepleri talep where giris.personel_id = kullanici.id and giris_tipi = 2 and talep.cop = 'false' and talep.personel_id = kullanici.id and giris.tarih between talep.baslangic_tarihi and talep.bitis_tarihi and NOT(talep.turu='Ücretsiz Izin') and talep.durum = 'Onaylandi'),0) as kalan, kullanici.* from ucgem_firma_kullanici_listesi kullanici where kullanici.id = '"& personel_id &"' and kullanici.firma_id = '"& FirmaID &"'"
       set personel = baglanti.execute(SQL)

       personel_yillik_izin_hakedis = personel("personel_yillik_izin_hakedis")

       if isdate(personel_yillik_izin_hakedis)=true then
            personel_yillik_izin_hakedis = cdate(personel_yillik_izin_hakedis)
       else
            personel_yillik_izin_hakedis = cdate(personel_yillik_izin_hakedis)+1
       end if
%>
<form id="koftiforms"></form>
<div class="modal-header">
    <%=LNG("İzin Talebi Gönder")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>

<div class="well" style="margin: 30px;">
    <br />
    <center style="text-align: center;">Yıllık İzin Süreniz : <strong><%=personel("kalan") %></strong> gündür. Yıllık İzin Hakediş Tarihiniz : <strong><%=cdate(personel_yillik_izin_hakedis) %></strong></center>
    <br />
</div>

<form autocomplete="off" id="yeni_gundem_form" class="smart-form validateform" style="padding: 15px;">

    <div class="row" <%=visible %>>
        <label class="col-sm-12 col-form-label"><%=LNG("Personel Adına")%></label>
        <div class="col-sm-12">
            <select id="personel_adina" class="select2">
                <option value="0">Personel Seç</option>
                <%
                    SQL = "select id, personel_ad +' '+ personel_soyad as ad_soyad from ucgem_firma_kullanici_listesi where cop = 'false' and firma_id = '"& FirmaID &"'"
                    set personeller = baglanti.execute(SQL)

                    if not personeller.eof then
                    do while not personeller.eof
                %>
                    <option value="<%=personeller("id") %>""><%=personeller("ad_soyad") %></option>
                <%
                    personeller.movenext
                    loop
                    end if
                %>
            </select>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("İzin Nedeni")%></label>
        <div class="col-sm-12">
            <select name="izin_nedeni" id="izin_nedeni" class="select2">
                <option>Yıllık İzin</option>
                <option>Doğum İzni</option>
                <option>Babalık İzni</option>
                <option>Ölüm İzni</option>
                <option>Diğer</option>
            </select>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("İzin Şekli")%></label>
        <div class="col-sm-12">
            <select name="izin_turu" id="izin_turu" class="select2" onchange="İzinKontrol();">
                <option>Yıllık İzin</option>
                <option>Ücretsiz İzin</option>
                <option>Yarım İzin</option>
                <option>İdari İzin</option>
                <option>Rapor</option>
            </select>
        </div>
    </div>

    <div class="row">
        <div class="form-group col-sm-6">
            <label class="col-form-label"><%=LNG("İzin Başlangıç Tarihi")%></label>
            <div id="baslangictarih">
                <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" class="required form-control takvimyap" name="izin_baslangic_tarihi" id="izin_baslangic_tarihi" value="<%=FormatDate(date, "00") %>" placeholder="__.__.____" />
                <script type="text/javascript">
                    var date = new Date();
                    date.setDate(date.getDate() - 1);
                    $(".takvimyap").datepicker({
                        minDate: date
                    });
                </script>
            </div>
            </div>
            <div id="baslangicsaat" style="display:none">
                <label class="col-form-label"><%=LNG("İzin Başlangıç Saati")%></label>
                <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" class="form-control timepicker" required name="izin_baslangic_saati" id="izin_baslangic_saati" placeholder="__:__" />
            </div>
            </div>
        </div>
        <div class="form-group col-sm-6">
            <label class="col-form-label"><%=LNG("İzin Bitiş Tarihi")%></label>
            <div id="bitistarih">
                <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" class="required form-control takvimyap" name="izin_bitis_tarihi" id="izin_bitis_tarihi" value="<%=FormatDate(date, "00") %>" placeholder="__.__.____" />
                <script type="text/javascript">
                    $(".takvimyap").datepicker({
                        minDate: new Date()
                    });
                </script>
            </div>
            </div>
            <div id="bitissaat" style="display:none">
                <label class="col-form-label"><%=LNG("İzin Bitiş Saati")%></label>
                <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" class="form-control timepicker" required name="izin_bitis_saati" id="izin_bitis_saati" placeholder="__:__" />
            </div>
            </div>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Açıklama")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <textarea name="izin_aciklama" class="form-control" id="izin_aciklama"></textarea>
            </div>
        </div>
    </div>

    <div class="modal-footer">
        <input type="button" onclick="izin_talebi_gonder(<%=personel_id %>);" class="btn btn-primary" value="<%=LNG("Yeni İzin Talebi Gönder")%>" />
    </div>

    <script type="text/javascript">
        function İzinKontrol() {
            var value = $("#izin_turu").val();
            if (value === "Yarım İzin") {
                $("#baslangicsaat").slideToggle();
                $("#bitissaat").slideToggle();
            }
            else {
                $("#baslangicsaat").slideUp();
                $("#bitissaat").slideUp();
            }
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#personel_adina, #izin_nedeni, #izin_turu").select2({
                dropdownParent: $("#modal_div")
            });
        });
    </script>

</form>
<%
    elseif trn(request("islem"))="personel_mesai_talep_onayla" then

        personel_id = trn(request("personel_id"))
        kayit_id = trn(request("kayit_id"))
        durum = trn(request("durum"))

        SQL="select * from ucgem_personel_mesai_bildirimleri where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
        set talep = baglanti.execute(SQL)
        
        if personel_id=Request.Cookies("kullanici")("kullanici_id") then
%>
<script>
            mesaj_ver("Mesai Talepleri", "Kendi Mesai Talebiniz Üzerinde İşlem Yapamazsınız. !", "danger");
</script>
<%
        else
            SQL="update ucgem_personel_mesai_bildirimleri set durum = '"& durum &"' where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)

            SQL="select * from ucgem_firma_kullanici_listesi where id= '"& personel_id &"' and firma_id = '"& FirmaID &"'"
            set kcek = baglanti.execute(SQL)

            do while not kcek.eof

                if trim(durum)="Onaylandı" then
                    bildirim = Request.Cookies("kullanici")("kullanici_adsoyad") & " Mesai Talebinizi Onayladı. " & chr(13) & chr(13)
                elseif trim(durum)="Onay Bekliyor" then
                    bildirim = Request.Cookies("kullanici")("kullanici_adsoyad") & " Mesai Talebinizi Beklemeye Aldı. " & chr(13) & chr(13)
                else
                    bildirim = Request.Cookies("kullanici")("kullanici_adsoyad") & " Mesai Talebinizi Reddetti. " & chr(13) & chr(13)
                end if
                tip = "is_listesi"
                click = "CokluIsYap(''personel_detaylari'',''"& kcek("id") &"'',''mesai'',0);" 
                user_id = kcek("id")
                okudumu = "0"
                durum = "true"
                cop = "false"
                firma_kodu = request.Cookies("kullanici")("firma_kodu")
                firma_id = request.Cookies("kullanici")("firma_id")
                ekleyen_id = request.Cookies("kullanici")("kullanici_id")
                ekleyen_ip = Request.ServerVariables("Remote_Addr")
    
                SQL="insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& bildirim &"', '"& tip &"', N'"& click &"', '"& user_id &"', '"& okudumu &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate()); SET NOCOUNT ON; EXEC MailGonderBildirim @personel_id = '"& kcek("id") &"', @mesaj = '"& replace(bildirim, chr(13), "<br>") &"';"
                set ekle2 = baglanti.execute(SQL)

                NetGSM_SMS kcek("personel_telefon"), bildirim


            kcek.movenext
            loop

        end if
       


    elseif trn(request("islem"))="bordro_indir" then

        dosya_yolu = trn(request("dosya_yolu"))

        Sub ParcaParcaDosyaIndir2(FilePath, FileName)
            Const clChunkSize = 1048576 ' 1MB
            Dim oStream, i
            Response.Buffer = False
            Response.ContentType = "application/octet-stream"
            Response.AddHeader "Content-Disposition", _
            "attachment; Filename=" & FileName
            Set oStream = Server.CreateObject("ADODB.Stream")
            oStream.Type = 1 
            oStream.Open
            oStream.LoadFromFile FilePath
            For i = 1 To oStream.Size \ clChunkSize
                Response.BinaryWrite oStream.Read(clChunkSize)
            Next
            If (oStream.Size Mod clChunkSize) <> 0 Then
                Response.BinaryWrite oStream.Read(oStream.Size Mod clChunkSize)
            End If
            oStream.Close
        End Sub

        ParcaParcaDosyaIndir Server.MapPath(dosya_yolu), ("bordro" & "." & split(right(dosya_yolu, 7), ".")(1))

    elseif trn(request("islem"))="bordro_gonder" then

        dosya_yolu = trn(request("dosya_yolu"))

        firma_id = Request.Cookies("kullanici")("firma_id")

        SQL = "select firma_otomasyon_mail from ucgem_firma_listesi where durum = 'true' and id = '"& firma_id &"'"

        set firma_otomasyon_mail = baglanti.execute(SQL)

        SQL="select personel_eposta from ucgem_firma_kullanici_listesi where id = '"& Request.Cookies("kullanici")("kullanici_id") &"' and firma_id = '"& FirmaID &"'"
        
        set personel_eposta = baglanti.execute(SQL)

        Sub ParcaParcaDosyaIndir2(FilePath, FileName)
            Const clChunkSize = 1048576 ' 1MB
            Dim oStream, i
            Response.Buffer = False
            Response.ContentType = "application/octet-stream"
            Response.AddHeader "Content-Disposition", _
            "attachment; Filename=" & FileName
            Set oStream = Server.CreateObject("ADODB.Stream")
            oStream.Type = 1 
            oStream.Open
            oStream.LoadFromFile FilePath
            For i = 1 To oStream.Size \ clChunkSize
                Response.BinaryWrite oStream.Read(clChunkSize)
            Next
            If (oStream.Size Mod clChunkSize) <> 0 Then
                Response.BinaryWrite oStream.Read(oStream.Size Mod clChunkSize)
            End If
            oStream.Close
        End Sub
        
        

       
      


    elseif trn(request("islem"))="personel_izin_talep_onayla" then

        personel_id = trn(request("personel_id"))
        kayit_id = trn(request("kayit_id"))
        durum = trn(request("durum"))

        SQL="select * from ucgem_personel_izin_talepleri where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
        set talep = baglanti.execute(SQL)
    
        if personel_id=Request.Cookies("kullanici")("kullanici_id") then
%>
<script>
            mesaj_ver("İzin Talepleri", "Kendi İzin Talebinizi Onaylayamazsınız. !", "danger");
</script>
<%
        else
            SQL="update ucgem_personel_izin_talepleri set durum = '"& durum &"', OnaylayanId = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)

            SQL="select * from ucgem_firma_kullanici_listesi where id= '"& personel_id &"' and firma_id = '"& FirmaID &"'"
            set kcek = baglanti.execute(SQL)

            do while not kcek.eof

                if trim(durum)="Onaylandı" then
                    bildirim = Request.Cookies("kullanici")("kullanici_adsoyad") & " İzin Talebinizi Onayladı. " & chr(13) & chr(13)
                elseif trim(durum)="Onay Bekliyor" then
                    bildirim = Request.Cookies("kullanici")("kullanici_adsoyad") & " İzin Talebinizi Beklemeye Aldı. " & chr(13) & chr(13)
                else
                    bildirim = Request.Cookies("kullanici")("kullanici_adsoyad") & " İzin Talebinizi Reddetti. " & chr(13) & chr(13)
                end if
                tip = "is_listesi"
                click = "CokluIsYap(''personel_detaylari'',''"& kcek("id") &"'',''izin'',0);" 
                user_id = kcek("id")
                okudumu = "0"
                durum = "true"
                cop = "false"
                firma_kodu = request.Cookies("kullanici")("firma_kodu")
                firma_id = request.Cookies("kullanici")("firma_id")
                ekleyen_id = request.Cookies("kullanici")("kullanici_id")
                ekleyen_ip = Request.ServerVariables("Remote_Addr")
    
                SQL="insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& bildirim &"', '"& tip &"', N'"& click &"', '"& user_id &"', '"& okudumu &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate()); SET NOCOUNT ON; EXEC MailGonderBildirim @personel_id = '"& kcek("id") &"', @mesaj = '"& replace(bildirim, chr(13), "<br>") &"';"
                set ekle2 = baglanti.execute(SQL)

                NetGSM_SMS kcek("personel_telefon"), bildirim

            kcek.movenext
            loop

            for x = cdate(talep("baslangic_tarihi")) to cdate(talep("bitis_tarihi"))

            cihazID = 0
            giris_tipi = 2
            tarih = cdate(x)
            saat = "00:00"
            ekleme_zamani= now()
            cop = "false"
            ekleme_tarihi = date
            ekleme_saati = time
            OnayDurum = "Onaylandi"
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")

            SQL="delete from ucgem_personel_mesai_girisleri where personel_id = '"& personel_id &"' and giris_tipi = '"& giris_tipi &"' and tarih = CONVERT(date, '"& tarih &"', 103) and firma_id = '"& FirmaID &"'"
            set sil = baglanti.execute(SQL)
            if trim(durum)="true" then
    
                SQL="insert into ucgem_personel_mesai_girisleri(personel_id, cihazID, giris_tipi, tarih, saat, ekleme_zamani, durum, cop, ekleme_tarihi, ekleme_saati, ekleyen_ip, firma_id, ekleyen_id) values('"& personel_id &"', '"& cihazID &"', '"& giris_tipi &"', CONVERT(date, '"& tarih &"', 103), '"& saat &"', CONVERT(date, '"& ekleme_zamani &"', 103), '"& OnayDurum &"', '"& cop &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"', '"& ekleyen_ip &"', '"& firma_id &"', '"& ekleyen_id &"')"
                set ekle = baglanti.execute(SQL)

            end if

        next

        end if
     
  elseif trn(request("islem"))="personel_mesai_getir" then

        personel_id = trn(request("personel_id"))

        sql="select * from ucgem_firma_kullanici_listesi where id = '"& personel_id &"' and firma_id = '"& FirmaID &"'"
        set personel = baglanti.execute(SQL)
%>
<div class="card">
    <div class="card-block">
        <div class="view-info">
            <div class="row">
                <div class="col-lg-12 col-xl-12">
                    <h5 class="card-header-text"><%=LNG("Personel Mesai Bilgileri")%> </h5>
                    <span style="float: right; margin-bottom: 15px">
                        <button onclick="modal_mesai_bildirimi_yap('<%=personel_id %>', 'Onay Bekliyor');" class="btn btn-primary">Mesai Bilgisi Ekle</button>
                    </span>
                    <br />
                    <br />
                    <div class="dt-responsive table-responsive" style="padding-bottom: 120px">
                        <table id="new-cons" class="table table-striped table-bordered table-hover" width="100%">
                            <thead>
                                <tr>
                                    <th style="width: 30px;">ID</th>
                                    <th><%=LNG("Mesai Tarihi")%></th>
                                    <th><%=LNG("Mesai Başlangıç Saati")%></th>
                                    <th><%=LNG("Mesai Bitiş Saati")%></th>
                                    <th><%=LNG("Açıklama")%></th>
                                    <th><%=LNG("Durum")%></th>
                                    <th><%=LNG("İşlem")%></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                SQL="select * from ucgem_personel_mesai_bildirimleri where personel_id = '"& personel_id &"' and firma_id = '"& FirmaID &"' and cop = 'false'"
                set mesai = baglanti.execute(SQL)
                if mesai.eof then
                                %>
                                <tr>
                                    <td colspan="7" style="text-align: center;">Kayıt Bulunamadı</td>
                                </tr>
                                <%
                end if
                do while not mesai.eof
                                %>
                                <tr>
                                    <td style="width: 30px;"><%=mesai("id") %></td>
                                    <td><%=cdate(mesai("baslangic_tarihi")) %></td>
                                    <td><%=left(mesai("baslangic_saati"),5) %></td>
                                    <td><%=left(mesai("bitis_saati"),5) %></td>
                                    <td><%=mesai("aciklama") %></td>
                                    <td><%=mesai("durum") %></td>
                                    <!--<td><input type="button" class="btn btn-danger btn-mini" value="Sil" onclick="mesai_bildirim_sil('<%=personel_id%>', '<%=mesai("id")%>');" /></td>-->
                                    <td class="dropdown" style="width: 10px;">
                                        <button type="button" class="btn btn-mini btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-cog" aria-hidden="true"></i></button>
                                        <div class="dropdown-menu dropdown-menu-right b-none contact-menu">
                                            <a class="dropdown-item" href="javascript:void(0);" onclick="rapor_pdf_indir('mesai_bildirim_formu', '<%=personel_id %>','<%=mesai("id") %>');"><i class="fa fa-download"></i>İndir</a>
                                            <a class="dropdown-item" href="javascript:void(0);" onclick="rapor_pdf_yazdir('mesai_bildirim_formu','<%=personel_id %>','<%=mesai("id") %>');"><i class="fa fa-print"></i>Yazdır</a>
                                            <a class="dropdown-item" href="javascript:void(0);" onclick="rapor_pdf_gonder('mesai_bildirim_formu','<%=personel_id %>','<%=mesai("id") %>');"><i class="fa fa-send"></i>Gönder</a>
                                            <a class="dropdown-item" href="javascript:void(0);" onclick="personel_mesai_talep_onayla('<%=personel_id %>','<%=mesai("id") %>', 'Onaylandı');"><i class="icofont icofont-edit"></i>Onayla</a>
                                            <a class="dropdown-item" href="javascript:void(0);" onclick="personel_mesai_talep_onayla('<%=personel_id %>','<%=mesai("id") %>', 'Reddedildi');"><i class="icofont icofont-ui-delete"></i>Reddet</a>
                                            <a class="dropdown-item" href="javascript:void(0);" onclick="personel_mesai_talep_onayla('<%=personel_id %>','<%=mesai("id") %>', 'Onay Bekliyor');"><i class="icofont icofont-ui-calendar"></i>Beklet</a>
                                        </div>
                                    </td>
                                </tr>
                                <%
                mesai.movenext
                loop
                                %>
                            </tbody>
                        </table>
                    </div>
                    <script>
                        $(function () {
                            var newcs = $('#new-cons').DataTable();
                            new $.fn.dataTable.Responsive(newcs);
                            $(".dataTables_length").hide();
                            setTimeout(function () {
                                $(".yetmislik").addClass("form-control");
                            }, 500);
                            $('a[title]').tooltip();
                        });
                    </script>
                    <style>
                        .table > caption + thead > tr:first-child > td, .table > caption + thead > tr:first-child > th, .table > colgroup + thead > tr:first-child > td, .table > colgroup + thead > tr:first-child > th, .table > thead:first-child > tr:first-child > td, .table > thead:first-child > tr:first-child > th {
                            border-top: 1px solid #ccc !important;
                        }

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

                        /*
                        .table td, .table th {
                            padding: .75rem !important;
                        }*/

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
                </div>

            </div>
        </div>
    </div>

    <div class="cards" style="display: none">
        <div class="card-block">
            <div class="view-info">
                <div class="row">
                    <div class="col-lg-12 col-xl-12">
                        <h5 class="card-header-text"><%=LNG("Onay Bekleyen Mesai Bildirimleri")%></h5>
                        <br />
                        <br />
                        <div class="dt-responsive table-responsive" style="padding-bottom: 400px">
                            <table id="new-cons2" class="table table-striped table-bordered table-hover" width="100%">
                                <thead>
                                    <tr>
                                        <th style="width: 30px;">ID</th>
                                        <th><%=LNG("Mesai Tarihi")%></th>
                                        <th><%=LNG("Mesai Başlangıç Saati")%></th>
                                        <th><%=LNG("Mesai Bitiş Saati")%></th>
                                        <th><%=LNG("Açıklama")%></th>
                                        <th><%=LNG("Durum")%></th>
                                        <th style="width: 120px;"><%=LNG("İşlem")%></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                SQL="select * from ucgem_personel_mesai_bildirimleri where personel_id = '"& personel_id &"' and firma_id = '"& FirmaID &"' and cop = 'false' and durum = 'Onay Bekliyor' OR durum = 'Reddedildi'"
                set mesai = baglanti.execute(SQL)
                if mesai.eof then
                                    %>
                                    <tr>
                                        <td colspan="6" style="text-align: center;">Kayıt Bulunamadı</td>
                                    </tr>
                                    <%
                end if
                do while not mesai.eof
                                    %>
                                    <tr>
                                        <td style="width: 30px;"><%=mesai("id") %></td>
                                        <td><%=cdate(mesai("baslangic_tarihi")) %></td>
                                        <td><%=left(mesai("baslangic_saati"),5) %></td>
                                        <td><%=left(mesai("bitis_saati"),5) %></td>
                                        <td><%=mesai("aciklama") %></td>
                                        <td><%=mesai("durum") %></td>
                                        <!--<td>
                                            <input type="button" class="btn btn-success btn-mini" value="Onayla" onclick="mesai_bildirim_onayla('<%=personel_id%>', '<%=mesai("id")%>');" />&nbsp;<input type="button" class="btn btn-danger btn-mini" value="Sil" onclick="mesai_bildirim_sil('<%=personel_id%>', '<%=mesai("id")%>');" /></td>-->
                                        <td class="dropdown" style="width: 10px;">
                                            <button type="button" class="btn btn-mini btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-cog" aria-hidden="true"></i></button>
                                            <div class="dropdown-menu dropdown-menu-right b-none contact-menu">
                                                <a class="dropdown-item" href="javascript:void(0);" onclick="rapor_pdf_indir('mesai_bildirim_formu', '<%=personel_id %>','<%=mesai("id") %>');"><i class="fa fa-download"></i>İndir</a>
                                                <a class="dropdown-item" href="javascript:void(0);" onclick="rapor_pdf_yazdir('mesai_bildirim_formu','<%=personel_id %>','<%=mesai("id") %>');"><i class="fa fa-print"></i>Yazdır</a>
                                                <a class="dropdown-item" href="javascript:void(0);" onclick="rapor_pdf_gonder('mesai_bildirim_formu','<%=personel_id %>','<%=mesai("id") %>');"><i class="fa fa-send"></i>Gönder</a>
                                                <a class="dropdown-item" href="javascript:void(0);" onclick="personel_mesai_talep_onayla('<%=personel_id %>','<%=mesai("id") %>', 'Onaylandı');"><i class="icofont icofont-edit"></i>Onayla</a>
                                                <a class="dropdown-item" href="javascript:void(0);" onclick="personel_mesai_talep_onayla('<%=personel_id %>','<%=mesai("id") %>', 'Reddedildi');"><i class="icofont icofont-ui-delete"></i>Reddet</a>
                                                <a class="dropdown-item" href="javascript:void(0);" onclick="personel_mesai_talep_onayla('<%=personel_id %>','<%=mesai("id") %>', 'Onay Bekliyor');"><i class="icofont icofont-ui-calendar"></i>Beklet</a>
                                            </div>
                                        </td>
                                    </tr>
                                    <%
                mesai.movenext
                loop
                                    %>
                                </tbody>
                            </table>
                        </div>
                        <script>
                        $(function () {
                            var newcs = $('.new-cons2').DataTable();
                            new $.fn.dataTable.Responsive(newcs);
                            $(".dataTables_length").hide();
                            setTimeout(function () {
                                $(".yetmislik").addClass("form-control");
                            }, 500);
                            $('a[title]').tooltip();
                        });
                        </script>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%
    elseif trn(request("islem"))="mesai_bildirim_onayla" then

        personel_id = trn(request("personel_id"))
        kayit_id = trn(request("kayit_id"))


        if personel_id=Request.Cookies("kullanici")("kullanici_id") then
    %>
    <script>
            mesaj_ver("Mesai Talepleri", "Kendi Mesai Talebinizi Onaylayamazsınız. !", "danger");
    </script>
    <%
        else
           SQL="update ucgem_personel_mesai_bildirimleri set durum = 'Onaylandı' where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
           set guncelle = baglanti.execute(SQL)


            SQL="select * from ucgem_firma_kullanici_listesi where id= '"& personel_id &"' and firma_id = '"& FirmaID &"'"
            set kcek = baglanti.execute(SQL)

            do while not kcek.eof

                bildirim = Request.Cookies("kullanici")("kullanici_adsoyad") & " Mesai Bildirim Talebinizi Onayladı." & chr(13) & chr(13) 
                tip = "is_listesi"
                click = "CokluIsYap(''personel_detaylari'',''"& kullanicicek("id") &"'',''mesai'',0);" 
                user_id = kcek("id")
                okudumu = "0"
                durum = "true"
                cop = "false"
                firma_kodu = request.Cookies("kullanici")("firma_kodu")
                firma_id = request.Cookies("kullanici")("firma_id")
                ekleyen_id = request.Cookies("kullanici")("kullanici_id")
                ekleyen_ip = Request.ServerVariables("Remote_Addr")
    
                SQL="insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& bildirim &"', '"& tip &"', N'"& click &"', '"& user_id &"', '"& okudumu &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate()); SET NOCOUNT ON; EXEC MailGonderBildirim @personel_id = '"& kcek("id") &"', @mesaj = '"& replace(bildirim, chr(13), "<br>") &"';"
                set ekle2 = baglanti.execute(SQL)

                NetGSM_SMS kcek("personel_telefon"), bildirim


            kcek.movenext
            loop

        end if


    elseif trn(request("islem"))="personel_bordro_getir" then

        personel_id = trn(request("personel_id"))

    %>
    <script>
        $(function (){
            fileyap();
        });
    </script>
    <div class="card">
        <div class="card-block">
            <div class="view-info">
                <div class="row">

                    <div class="col-md-4" style="padding-top: 15px;">
                        <form autocomplete="off" id="dosya_yukleme_form">
                            <h5 style="font-size: 15px;">Bordro Ekle</h5>
                            <br>
                            <input class="form-control required" required type="file" id="bordro_dosya_yolu" tip="kucuk" folder="Bordro" />
                            <img src="/img/loader_green.gif" id="fileLoading" style="display: none" />
                            <br>
                            Dönem:<br>
                            <select name="bordro_donem" class="select2" id="bordro_donem">
                                <% for x = 1 to 12 %>
                                <option value="<%=MonthName(x) & " " & year(date)-1 %>"><%=MonthName(x) & " " & year(date)-1 %></option>
                                <% next %>
                                <% for x = 1 to 12 %>
                                <option <% if trim(month(cdate(date)))=trim(x+1) then %> selected="selected" <% end if %> value="<%=MonthName(x) & " " & year(date) %>"><%=MonthName(x) & " " & year(date) %></option>
                                <% next %>
                            </select><br>
                            <br>
                            Açıklama:<br>
                            <input name="bordro_aciklama" type="text" id="bordro_aciklama" required class="form-control required" style="max-width: 300px;" /><br>
                            <br>
                            <br>
                            <input type="button" class="btn btn-primary btn-mini" onclick="bordro_kaydet(<%=personel_id %>);" value="Bordro Yükle">
                        </form>
                    </div>
                    <div class="col-md-8" style="padding-top: 15px;">
                        <h5 style="font-size: 15px;">Bordro Listesi</h5>
                        <br>
                        <div id="depo_dosya_listesis">
                            <div class="dt-responsive table-responsive">
                                <table id="new-cons" class="table table-striped table-bordered table-hover" width="100%">
                                    <thead>
                                        <tr>
                                            <th style="width: 30px;">ID</th>
                                            <th><%=LNG("Dönem")%></th>
                                            <th><%=LNG("Ekleme Tarihi")%></th>
                                            <th><%=LNG("Açıklama")%></th>
                                            <th><%=LNG("İşlem")%></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                    SQL="select * from ucgem_personel_bordro_listesi where personel_id = '"& personel_id &"' and firma_id = '"& FirmaID &"' and cop = 'false'"
                                    set bordro = baglanti.execute(SQL)
                                    if bordro.eof then
                                        %>
                                        <tr>
                                            <td colspan="5" style="text-align: center;">Kayıt Bulunamadı</td>
                                        </tr>
                                        <%
                                    end if
                                    do while not bordro.eof
                                        %>
                                        <tr>
                                            <td style="width: 30px;"><%=bordro("id") %></td>
                                            <td><%=bordro("donem") %></td>
                                            <td><%=cdate(bordro("ekleme_tarihi")) %>&nbsp;<%=left(bordro("ekleme_saati"),5) %></td>
                                            <td><%=bordro("aciklama") %></td>
                                            <td>
                                                <input type="button" onclick="rapor_pdf_gonder('bordro_gonder', '', '', '<%=bordro("dosya_yolu")%>');" class="btn btn-mini btn-primary" value="Gönder" />&nbsp;<input type="button" onclick="bordro_sil('<%=bordro("id")%>');" class="btn btn-mini btn-danger" value="Sil" /></td>
                                        </tr>
                                        <%
                                    bordro.movenext
                                    loop
                                        %>
                                    </tbody>
                                </table>
                            </div>
                            <script>
        $(function () {


            setTimeout(function () {

    
    if ($('#new-cons2').length>0) {
                     var newcs2 = $('#new-cons2').DataTable();
            new $.fn.dataTable.Responsive(newcs2);
      }

    if ($('#new-cons').length>0) {
                    var newcs = $('#new-cons').DataTable();
            new $.fn.dataTable.Responsive(newcs);


            $(".dataTables_length").hide();

                $(".yetmislik").addClass("form-control"); 
    /*
    $(".dataTables_length").each(function (){
        $(this).parent("div").remove();
    });

    $(".dataTables_filter").each(function (){
        $(this).parent("div").removeClass("col-sm-6");
    });
    */

    
    }
            },500);
       


        });
                            </script>
                            <style>
                                .table > caption + thead > tr:first-child > td, .table > caption + thead > tr:first-child > th, .table > colgroup + thead > tr:first-child > td, .table > colgroup + thead > tr:first-child > th, .table > thead:first-child > tr:first-child > td, .table > thead:first-child > tr:first-child > th {
                                    border-top: 1px solid #ccc !important;
                                }

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
                                /*
                                .table td, .table th {
                                    padding: .75rem !important;
                                }*/

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
                                /*
    .dataTables_filter {
    float: right;
    width: auto;
}
    */
                            </style>
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
                        </div>
                    </div>


                </div>
            </div>
        </div>
    </div>
    <%


    elseif trn(request("islem"))="bordro_kaydet" then

        personel_id = trn(request("personel_id"))
        dosya_yolu = trn(request("bordro_dosya_yolu"))
        donem = trn(request("bordro_donem"))
        aciklama = trn(request("bordro_aciklama"))

        durum = "true"
        cop = "false"
        firma_kodu = Request.Cookies("kullanici")("firma_kodu")
        firma_id = Request.Cookies("kullanici")("firma_id")
        ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
        ekleyen_ip = Request.ServerVariables("Remote_Addr")
        ekleme_tarihi = date
        ekleme_saati = time


        SQL="insert into ucgem_personel_bordro_listesi(personel_id, donem, aciklama, dosya_yolu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& personel_id &"', '"& donem &"', '"& aciklama &"', '"& dosya_yolu &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 104), '"& ekleme_saati &"')"
        set ekle = baglanti.execute(SQL)

    elseif trn(request("islem"))="bordro_sil" then

        kayit_id = trn(request("kayit_id"))

        silen_id = Request.Cookies("kullanici")("kullanici_id")
        silen_ip = Request.ServerVariables("Remote_Addr")
        silen_tarihi = date
        silen_saati = time

        SQL="update ucgem_personel_bordro_listesi set cop = 'true', silen_id = '"& silen_id &"', silen_ip = '"& silen_ip &"', silen_tarihi =  CONVERT(date, '"& silen_tarihi &"', 103), silen_saati = '"& silen_saati &"' where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
        set guncelle = baglanti.execute(SQL)

    elseif trn(request("islem"))="parca_listesi" then


        if trim(request("islem2"))="ekle" then

            parca_resmi = trn(request("parca_resmi"))
            marka = trn(request("marka"))
            parca_adi = trn(request("parca_adi"))
            kategori = trn(request("kategori"))
            aciklama = trn(request("aciklama"))
            birim_maliyet = trn(request("birim_maliyet"))
            birim_pb = trn(request("birim_pb"))
            birim = trn(request("birim"))
            miktar = trn(request("miktar"))
            minumum_miktar = trn(request("minumum_miktar"))
            barcode = trn(request("barcode"))
            kodu = trn(request("kodu"))


            durum = "true"
            cop = "false"
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time

            birim_maliyet = NoktalamaDegis(birim_maliyet)
            miktar = NoktalamaDegis(miktar)
            minumum_miktar = NoktalamaDegis(minumum_miktar)


            SQL="insert into parca_listesi(parca_kodu, parca_resmi, marka, parca_adi, kategori, aciklama, birim_maliyet, birim_pb, birim, miktar, minumum_miktar, barcode, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& kodu &"', '"& parca_resmi &"', '"& marka &"', '"& parca_adi &"', '"& kategori &"', '"& aciklama &"', '"& birim_maliyet &"', '"& birim_pb &"', '"& birim &"', '"& miktar &"', '"& minumum_miktar &"', '"& barcode &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
            set ekle = baglanti.execute(SQL)        


        elseif trn(request("islem2"))="guncelle" then

            kayit_id = trn(request("kayit_id"))

            parca_resmi = trn(request("parca_resmi"))
            marka = trn(request("marka"))
            parca_adi = trn(request("parca_adi"))
            kategori = trn(request("kategori"))
            aciklama = trn(request("aciklama"))
            birim_maliyet = trn(request("birim_maliyet"))
            birim_pb = trn(request("birim_pb"))
            birim = trn(request("birim"))
            miktar = trn(request("miktar"))
            minumum_miktar = trn(request("minumum_miktar"))
            barcode = trn(request("barcode"))
            kodu = trn(request("kodu"))

            birim_maliyet = Replace(birim_maliyet,",",".")

            SQL="update parca_listesi set parca_kodu = '"& kodu &"', parca_resmi = '"& parca_resmi &"', marka = '"& marka &"', parca_adi = '"& parca_adi &"', kategori = '"& kategori &"', aciklama = '"& aciklama &"', birim_maliyet = '"& birim_maliyet &"', birim_pb = '"& birim_pb &"', birim = '"& birim &"', miktar = '"& miktar &"', minumum_miktar = '"& minumum_miktar &"', barcode = '"& barcode &"' where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
        'response.Write(SQL)
            set guncelle = baglanti.execute(SQL)
        


        elseif trn(request("islem2"))="sil" then

            kayit_id = trn(request("kayit_id"))

            silen_id = Request.Cookies("kullanici")("firma_id")
            silen_ip = Request.ServerVariables("Remote_Addr")
            silen_tarihi = date
            silen_saati = time

            SQL="update parca_listesi set cop = 'true', silen_id = '"& silen_id &"', silen_ip = '"& silen_ip &"', silen_tarihi = CONVERT(DATE, '"& silen_tarihi &"',103), silen_saati = '"& silen_saati &"' where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set ekle = baglanti.execute(SQL)

        end if

    %>
    <div class="dt-responsive table-responsive">

        <table id="dt_basic" class="table table-striped table-bordered nowrap datatableyap" aria-describedby="dt_basic_info" style="width: 100%;">
            <thead>
                <tr>
                    <th data-hide="phone,tablet">ID</th>
                    <th data-hide="phone,tablet">Kodu</th>
                    <th data-hide="phone,tablet">Marka</th>
                    <th data-class="expand">Parça Adı</th>
                    <th data-hide="phone,tablet">Kategori</th>
                    <th data-hide="phone,tablet">Miktar</th>
                    <th data-hide="phone,tablet">Maliyet</th>
                    <th data-hide="phone,tablet">Barcode</th>
                    <th data-hide="phone,tablet">Açıklama</th>
                    <th data-hide="phone,tablet">Ekleme</th>
                    <th data-hide="phone,tablet">İş Emirleri</th>
                    <th style="text-align: center;">Durum</th>
                    <th>İşlem</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    kacadet = 350
                    sayfa = trn(request("sayfa"))
                    if isnumeric(sayfa)=false then
                        sayfa = 1
                    end if
                    if sayfa = 0 then
                        sayfa = 1
                    end if

                    nereden = (cdbl(sayfa)-1) * kacadet

                    arama_str = ""
                    if trn(request("islem2"))="arama" then
                        where_str = ""
                        marka = trn(request("marka"))
                        parca_adi = trn(request("parca_adi"))
                        kategori = trn(request("kategori"))
                        aciklama = trn(request("aciklama"))
                        barcode = trn(request("barcode"))
                        kodu = trn(request("kodu"))

                        if len(kodu)>1 then
                            arama_str = arama_str & " and (parca.parca_kodu collate French_CI_AI like '%"& kodu &"%')"
                        end if

                        if len(marka)>1 then
                            arama_str = arama_str & " and (parca.marka collate French_CI_AI like '%"& marka &"%')"
                        end if

                        if len(parca_adi)>1 then
                            arama_str = arama_str & " and (parca.parca_adi collate French_CI_AI like '%"& parca_adi &"%')"
                        end if

                        if not cdbl(kategori)=0 then
                            arama_str = arama_str & " and (parca.kategori = '"& kategori &"')"
                        end if

                        if len(aciklama)>1 then
                            arama_str = arama_str & " and (parca.aciklama collate French_CI_AI like '%"& aciklama &"%')"
                        end if

                        if len(barcode)>1 then
                            arama_str = arama_str & " and (parca.barcode collate French_CI_AI like '%"& barcode &"%')"
                        end if
                    end if

                    SQL="SELECT * FROM ( SELECT ROW_NUMBER() OVER ( ORDER BY parca.id ) AS RowNum, parca.*, kat.kategori_adi, kullanici.personel_ad + ' ' + kullanici.personel_soyad as adsoyad, isnull((SELECT COUNT(*) from  is_parca_listesi WHERE cop = 'false' AND ParcaId= parca.id ),0) kullanilan from parca_listesi parca join tanimlama_kategori_listesi kat on kat.id = parca.kategori join ucgem_firma_kullanici_listesi kullanici on kullanici.id = parca.ekleyen_id where parca.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and parca.cop = 'false' "& arama_str &" ) AS RowConstrainedResult WHERE RowNum >= "& cdbl(nereden) &" AND RowNum <= "& kacadet &" ORDER BY RowNum"
                    set parca = baglanti.execute(SQL)
                    'response.Write(SQL)
                    if parca.eof then
                %>
                <tr>
                    <td colspan="13" style="text-align: center;">Kayıt Bulunamadı</td>
                </tr>
                <%
                    end if
                    do while not parca.eof
                %>
                <tr>
                    <td style="text-align: center;"><%=parca("id") %></td>
                    <td><%=parca("parca_kodu") %></td>
                    <td><%=parca("marka") %></td>
                    <td><%=parca("parca_adi") %></td>
                    <td><%=parca("kategori_adi") %></td>
                    <td><%=parca("miktar") %></td>
                    <td><%=formatnumber(parca("birim_maliyet"),2) %>&nbsp;<%=parca("birim_pb") %></td>
                    <td><%=parca("barcode") %></td>
                    <td><%=parca("aciklama") %></td>
                    <td><%=parca("adsoyad") %><br />
                        <%=cdate(parca("ekleme_tarihi")) %></td>
                    <td style="text-align: center;">
                        <span class="label label-warning" style="display: inline; font-size: 13px; padding-left: 10px; padding-right: 10px;"><%=parca("kullanilan") %></span> /
                        <input type="button" class="btn btn-info btn-mini" onclick="ParcadanIsListesiBul('<%=parca("id")%>', 'Stok');" value="Aç" /></td>
                    <td style="text-align: center; width: 100px;">
                        <span id="santiye_durum_repeater_str<%=parca("id") %>santiye_label_0" onclick="durum_guncelleme_calistir('parca_listesi', '<%=parca("id") %>');">
                            <input id="santiye_durum_repeater_st<%=parca("id") %>_santiye_0" type="checkbox" name="santiye_durum_repeater$ctl00$st<%=parca("id") %>_santiye" checked="checked" class="js-switch" />
                        </span>
                    </td>
                    <td class="icon-list-demo2" style="width: 100px;">
                        <a href="javascript:void(0);" onclick="parca_duzenle('<%=parca("id") %>');" rel="tooltip" data-placement="top" data-original-title="Parça Detaylarını Görüntüle">
                            <i class="fa fa-external-link"></i>
                        </a>
                        &nbsp;
                        <a href="javascript:void(0);" onclick="parca_sil('<%=parca("id") %>');" rel="tooltip" data-placement="top" data-original-title="Parça Sil">
                            <i class="ti-trash"></i>
                        </a>
                    </td>
                </tr>
                <% 
                    parca.movenext
                    loop
                %>
            </tbody>
        </table>
    </div>


    <!--    <center>
    <div class="btn-group">
        <button class="btn <% if sayfa = 1 or sayfa = 0 then %> disabled <% end if %>"  <% if sayfa=1 or sayfa = 0 then %> <% else %> onclick="parcalari_getir(<%=cdbl(sayfa)-1 %>);" <% end if %> type="button"><<</button>
        <% 
            baslangic = sayfa-4
            if baslangic<1 then
                baslangic=1
            end if 
       
            bitis = sayfa+4
            if cdbl(bitis)>cdbl(sayfasayisi) then
                bitis = sayfasayisi
            end if
        %>  
        <% for x = baslangic to bitis %>
        <button class="btn <% if int(x) = int(sayfa) or x = 1 and sayfa = 0 then  %>  btn-warning <% end if %>"  onclick="parcalari_getir(<%=cdbl(x)%>);" type="button"><%=x %></button>
        <% next %>
        <button class="btn <% if int(sayfa) >= int(sayfasayisi) then %> disabled <% end if %>" <% if int(sayfa) >= int(sayfasayisi) then %> <% else %>onclick="parcalari_getir(<%=cdbl(sayfa)+1 %>);" <% end if %> type="button">>></button>
    </div> </center>-->


    <%

    elseif trn(request("islem"))="kategori_listesi" then

        
        if trn(request("islem2"))="ekle" then



            kategori_adi = trn(request("kategori_adi"))

            durum = "true"
            cop = "false"
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time

            SQL="insert into tanimlama_kategori_listesi(kategori_adi, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& kategori_adi &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
            set ekle = baglanti.execute(SQL)



        elseif trn(request("islem2"))="sil" then



            kayit_id = trn(request("kayit_id"))

            SQL="delete from tanimlama_kategori_listesi where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set sil = baglanti.execute(SQL)



        end if

    %>
    <table id="simpletable" class="table table-striped table-bordered nowrap datatableyap1">
        <thead>
            <tr>
                <th style="width: 30px;">ID</th>
                <th>Kategori Adı</th>
                <th style="width: 40px; text-align: center;">Durum</th>
                <th style="width: 100px;">İşlem</th>
            </tr>
        </thead>
        <tbody>
            <%
                    SQL="select * from tanimlama_kategori_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and cop = 'false'"
                    set kategori = baglanti.execute(SQL)
                    if kategori.eof then
            %>
            <tr>
                <td colspan="4" style="text-align: center;">Kayıt Bulunamadı</td>
            </tr>
            <% 
                end if
                k = 0
                do while not kategori.eof    
                    k = k + 1
            %>
            <tr>
                <td><%=k %></td>
                <td><%=kategori("kategori_adi") %></td>
                <td style="text-align: center;">
                    <span id="santiye_durum_repeater_str<%=kategori("id") %>santiye_label_0" onclick="durum_guncelleme_calistir('tanimlama_kategori_listesi', '<%=kategori("id") %>');">
                        <input id="santiye_durum_repeater_st<%=kategori("id") %>_santiye_0" type="checkbox" name="santiye_durum_repeater$ctl00$st<%=kategori("id") %>_santiye" checked="checked" class="js-switch" /></span>
                </td>
                <td class="icon-list-demo2">
                    <a href="javascript:void(0);" onclick="tanimlama_kategori_sil('<%=kategori("id") %>');" rel="tooltip">
                        <i class="ti-trash"></i>
                    </a>
                </td>
            </tr>
            <%
                    kategori.movenext
                    loop
            %>
        </tbody>
    </table>
    <%

    elseif trn(request("islem"))="urun_grup_listesi" then


        if trn(request("islem2"))="ekle" then

            grup_adi = trn(request("grup_adi"))

            durum = "true"
            cop = "false"
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time

            SQL="insert into parca_grup_listesi(grup_adi, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& grup_adi &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
            set ekle = baglanti.execute(SQL)

        elseif trn(request("islem2"))="guncelle" then

            grup_id = trn(request("grup_id"))
            grup_adi = trn(request("grup_adi"))
            parcalar = trn(request("parcalar"))
            olusturanId = Request.Cookies("kullanici")("kullanici_id")
            olusturmaTarihi = date

            for x = 0 to ubound(split(parcalar, ","))
                parcaid = split(parcalar, ",")(x)
                SQL = "IF NOT EXISTS (select * from UrunAgaciParcalar where GrupID = '"& grup_id &"' and ParcaId = '"& parcaid &"' and firma_id = '"& FirmaID &"' and Silindi = 'false') insert into UrunAgaciParcalar(FirmaID, GrupID, ParcaId, OlusturanID, OlusturmaTarihi, Silindi) values('"& FirmaID &"', '"& grup_id &"', '"& parcaid &"', '"& olusturanId &"', getdate(), 'false')"
                set grupParcalar = baglanti.execute(SQL)
            next

            if IsNULL(parcalar) or parcalar = "" then
                SQL = "update UrunAgaciParcalar set Silindi = 'true', GuncelleyenID = '"& olusturanId &"', GuncellemeTarihi = getdate() where GrupID = '"& grup_id &"' and Silindi = 'false' and FirmaID = '"& FirmaID &"'"
                set urunAgaciGuncelle = baglanti.execute(SQL)
            else
                SQL = "update UrunAgaciParcalar set Silindi = 'true', GuncelleyenID = '"& olusturanId &"', GuncellemeTarihi = getdate() where not ParcaId in("& parcalar &") and GrupID = '"& grup_id &"' and Silindi = 'false' and FirmaID = '"& FirmaID &"'"
                set urunAgaciGuncelle = baglanti.execute(SQL)
            end if

        elseif trn(request("islem2")) = "agacgrubuguncelle" then

            parca_id = trn(request("parca_id"))
            grup_id = trn(request("grup_id"))
            adet = trn(request("adet"))

            for x = 0 to ubound(split(parca_id, ","))
                parcaid = split(parca_id, ",")(x)
                miktar = split(adet, ",")(x)
                SQL = "update UrunAgaciParcalar set ParcaAdet = '"& miktar &"' where ParcaId = '"& parcaid &"' and GrupID = '"& grup_id &"' and FirmaID = '"& FirmaID &"'"
                set grupParcalar = baglanti.execute(SQL)
            next

        elseif trn(request("islem2"))="sil" then

            kayit_id = trn(request("kayit_id"))

            silen_id = Request.Cookies("kullanici")("kullanici_id")
            silen_ip = Request.ServerVariables("Remote_Addr")
            silen_tarihi = date
            silen_saati = time

            SQL="update parca_grup_listesi set cop = 'true', silen_id = '"& silen_id &"', silen_ip = '"& silen_ip &"', silen_tarihi = CONVERT(date, getdate(), 103), silen_saati = '"& silen_saati &"' where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set sil = baglanti.execute(SQL)

            SQL = "update UrunAgaciParcalar set Silindi = 'true', GuncelleyenID = '"& silen_id &"', GuncellemeTarihi = getdate() where GrupID = '"& kayit_id &"' and FirmaID = '"& FirmaID &"'"
            set grup_parca_sil = baglanti.execute(SQL)

        end if

    %>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script type="text/javascript">
        $(function () {
            $("#accordion").accordion({
                heightStyle: "content"
            });
        });
    </script>
    <div id="accordion">
        <%

            SQL="select * from parca_grup_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and cop = 'false'"
            set grup = baglanti.execute(SQL)
            if grup.eof then
        %>
            Kayıt Bulunamadı...
        <%
            end if
            x = 0
            do while not grup.eof
                x = x + 1
        %>
        <h3 onclick="grup_detay_getir('<%=grup("id") %>');" id="grup_detay_getir<%=grup("id") %>"><a href="javascript:void(0);"><%=grup("grup_adi") %></a></h3>
        <div id="grup_detay_donus<%=grup("id") %>">
            &nbsp;
        <% if x = 1 then %>
            <script type="text/javascript">
                $(function () {
                    grup_detay_getir('<%=grup("id") %>');
                });
            </script>
            <% end if %>
        </div>
        <%
           grup.movenext
           loop
        %>
    </div>
    <%
    elseif trn(request("islem"))="gruba_parca_ekle" then

        grup_id = trn(request("grup_id"))

        SQL="select * from UrunAgaciParcalar where GrupID = '"& grup_id &"' and Silindi = 'false' and firma_id = '"& FirmaID &"'"
        set grup_parcalar = baglanti.execute(SQL)

        SQL = "select * from parca_grup_listesi where id = '"& grup_id &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
        set grup = baglanti.execute(SQL)
        
    %>
    <div class="modal-header">
        <%=LNG("Ürün Ağacı Düzenle")%>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <form autocomplete="off" id="koftiform"></form>
    <form autocomplete="off" id="yeni_toplanti_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
        <div class="row">
            <label class="col-sm-12 col-form-label"><%=LNG("Ürün Ağacı Adı :")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-user"></i>
                    </span>
                    <input type="text" id="dgrup_adi" name="grup_adi" value="<%=grup("grup_adi") %>" required class="form-control required" />
                </div>
            </div>
        </div>
        <div class="row">
            <label class="col-sm-12 col-form-label"><%=LNG("Parçalar :")%></label>
            <div class="col-sm-12">
                <script>
                   $(function (){
                        $(".parcalarr").select2({
                            ajax: {
                                url: '/ajax_request6/?jsid=4559&islem=parcalar_auto',
                                dataType: 'json',
                                delay: 250,
                                data: function (params) {
                                    return {
                                        term: params.term,
                                        page: params.page
                                    };
                                },
                                processResults: function (data, params) {
                                    return {
                                        results: data,
                                    };
                                },
                                cache: true
                            },
                            escapeMarkup: function (markup) { return markup; },
                            minimumInputLength: 1,
                            templateResult: formatRepo,
                            templateSelection: formatRepoSelection,
                            selectOnClose: true
                        });
                   });

                    
                    function formatRepo(repo) {
                        if (repo.loading) return repo.text;
                        var markup = '<div class="select2-result-repository clearfix" style="padding:0;">' +
                            '<div class="select2-result-repository__meta">' +
                            '<div class="select2-result-repository__title">' + repo.kodu + '</div>' +
                            '<div class="select2-result-repository__title">' + repo.parcaadi + ' (' + repo.marka + ')' + '</div>';

                        markup += '<div class="select2-result-repository__statistics">' +
                            '<div class="select2-result-repository__stargazers">' + repo.aciklama + '</div>' +
                            '</div>' +
                            '</div></div>';

                        return markup;
                    }

                    function formatRepoSelection(repo) {
                        return repo.text || repo.kodu;
                    }

                </script>
                <select name="parcalar[]" multiple="multiple" class="parcalarr" id="parcalar">
                    <%
                        do while not grup_parcalar.eof
                        SQL = "select * from parca_listesi where id = '"& grup_parcalar("ParcaId") &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
                        set parca = baglanti.execute(SQL)
                    %>
                    <option selected value="<%=parca("id") %>"><%=parca("parca_kodu") %> </option>
                    <%
                        grup_parcalar.movenext
                        loop
                    %>
                </select>
            </div>
        </div>
        <div class="modal-footer">
            <input type="button" onclick="gruba_parca_kayit('<%=grup_id %>');" class="btn btn-primary" value="<%=LNG("Güncelle")%>" />
        </div>
    </form>

    <%
        elseif trn(request("islem"))="user_list" then

        'Burada firma id kontrolü yapılmayacak
        SQL="select * from ucgem_firma_kullanici_listesi where durum = 'true' and cop = 'false'"
        set user_list = baglanti.execute(SQL)
        
        do while not user_list.eof
    %>
    <div id="usercardcount<%=user_list("id") %>" onclick="userLogin(<%=user_list("id")%>);" class="userCard col-xs-6 col-md-3 col-sm-4" style="margin-bottom: 10px; padding: 5px 5px 0px 5px">
        <div class="card" style="margin-bottom: 0px">
            <img src="<%=user_list("personel_resim") %>" id="userPhoto" class="card-img-top" alt="..." style="width: auto; height: 150px">
            <div class="card-body userBody">
                <input id="useremail<%=user_list("id") %>" type="hidden" value="<%=user_list("personel_eposta") %>" />
                <span id="AdSoyad<%=user_list("id") %>" class="card-title text-dark"><%=user_list("personel_ad") %>&nbsp;<%=user_list("personel_soyad") %></span>
            </div>
        </div>
    </div>
    <%
        user_list.movenext
        loop
    %>


    <%

    elseif trn(request("islem"))="grup_detay_getir" then

        grup_id = trn(request("grup_id"))
        durum = ""
    %>
    <span class="float-right mb-2">
        <input type="button" class="btn btn-danger btn-mini" onclick="grubu_sil('<%=grup_id %>');" value="Grubu Sil" />&nbsp;
        <input type="button" class="btn btn-success btn-mini" onclick="gruba_parca_ekle('<%=grup_id %>');" value="Grubu Düzenle" />
    </span>
    <div class="dt-responsive table-responsive" id="grup_listesi<%=grup_id %>">
        <table class="table table-bordered text-nowrap">
            <thead>
                <tr>
                    <th style="width: 45px;">Id</th>
                    <th>Parça</th>
                    <th>Marka</th>
                    <th>Açıklama</th>
                    <th>Adet</th>
                </tr>
            </thead>
            <tbody>


                <% 
                SQL = "select * from UrunAgaciParcalar where GrupID = '"& grup_id &"' and Silindi = 'false' and firma_id = '"& FirmaID &"'"
                set grup_parca = baglanti.execute(SQL)

                if grup_parca.eof then
                %>
                <tr>
                    <td colspan="5" style="text-align: center;">Bu Gruba Tanımlanan Parça Bulunamadı</td>
                </tr>
                <%
                end if
                p = 0
                do while not grup_parca.eof    
                    p = p + 1
                    SQL = "select * from parca_listesi where id = '"& grup_parca("ParcaId") &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
                    set parca = baglanti.execute(SQL)
                %>
                <tr>
                    <td style="width: 30px;"><%=p %></td>
                    <td>
                        <%
                        parcaDetay = ""
                        if parca("parca_adi") <> "" then
                            if parcaDetay = "" then
                                parcaDetay = parca("parca_adi")
                            else
                                parcaDetay = parcaDetay & " - " & parca("parca_adi")
                            end if
                        end if
                        if parca("parca_kodu") <> "" then 
                            if parcaDetay = "" then
                                parcaDetay = parca("parca_kodu")
                            else
                                parcaDetay = parcaDetay & " - " & parca("parca_kodu")
                            end if
                        end if
                        if parcaDetay = "" then
                            parcaDetay = "-"
                        end if
                        %>
                        <%=parcaDetay %>
                    </td>
                    <td><% if parca("marka") = "" then %> - <%else %> <%=parca("marka") %> <%end if %></td>
                    <td><% if parca("aciklama") = "" then %> - <%else %> <%=parca("aciklama") %> <%end if %></td>
                    <td>
                        <input type="number" min="1" style="width: 50px" value="<%=grup_parca("ParcaAdet") %>" id="count<%=grup_id %><%=p %>" parca_id="<%=grup_parca("ParcaId") %>" /></td>
                </tr>
                <% 
                grup_parca.movenext
                loop
                %>
            </tbody>
        </table>
    </div>
    <span style="float: right;">
        <input type="button" class="btn btn-info btn-mini" onclick="adet_kaydi_guncelle('<%=grup_id %>', '<%=p %>');" value="Kayıtları Güncelle" <%=durum %> />
    </span>
    <%
    elseif trn(request("islem"))="parcalar_auto" then
        
        q = trn(request("term"))

        Response.Clear()

        Response.AddHeader "Content-Type", "application/json"

        SQL="SELECT top 20 parca.id, marka, parca.parca_kodu, parca_adi, REPLACE(aciklama, '""', ' \""') as aciklama, kat.kategori_adi, parca.birim_maliyet, parca.birim_pb FROM parca_listesi parca LEFT JOIN tanimlama_kategori_listesi kat ON kat.id = parca.kategori where parca.firma_id = '"& FirmaID &"' and kat.firma_id = '"& FirmaID &"' and parca.cop = 'false' and parca_adi collate French_CI_AI like '%"& q &"%' or aciklama collate French_CI_AI like '%"& q &"%' or parca_kodu collate French_CI_AI like '%"& q &"%' or marka collate French_CI_AI like '%"& q &"%' GROUP BY parca.id, marka, parca_adi, aciklama, kat.kategori_adi, parca.parca_kodu, parca.birim_maliyet, parca.birim_pb;"
        set parca = baglanti.execute(SQL)

        Response.Write "["
        do while not parca.eof
    %>{"id":<%=parca("id") %>,"parcaadi":"<%=parca("parca_adi") %>","kodu":"<%=parca("parca_kodu") %>","kod_marka":"<%=parca("parca_kodu") %>-<%=parca("marka") %>","marka":"<%=parca("marka") %>","aciklama":"<%=parca("aciklama") %>","kategori":"<%=parca("kategori_adi") %>","maliyet":"<%=parca("birim_maliyet") %>","birim_pb":"<%=parca("birim_pb") %>"},<%
        parca.movenext
        loop

        Response.Write "{}]"

    elseif trn(request("islem"))="parcalar_auto2" then
        
        q = trn(request("term"))

        Response.Clear()

        Response.AddHeader "Content-Type", "application/json"

        SQL="select top 20 id, grup_adi from parca_grup_listesi where grup_adi collate French_CI_AI like '%"& q &"%' and firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and cop = 'false' order by grup_adi asc"
        set parca = baglanti.execute(SQL)
        Response.Write "["
        do while not parca.eof
    %>{"id":<%=parca("id") %>, "agacadi":"<%=parca("grup_adi") %>"},<%
        parca.movenext
        loop

        Response.Write "{}]"

    elseif trn(request("islem"))="talep_fisleri" then

        if trn(request("islem2"))="ekle" then

            baslik = trn(request("baslik"))
            oncelik = trn(request("oncelik"))
            talep_edilen = trn(request("talep_edilen"))
            bildirimTuru = trn(request("bildirimTuru"))
            aciklama = trn(request("aciklama"))
            dosya = trn(request("dosya"))

            durum = "Onay Bekliyor"
            cop = "false"
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time

        
            SQL="insert into talep_fisleri(baslik, oncelik, aciklama, dosya, durum, cop, firma_kodu, firma_id, ekleyen_id, talep_edilen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& baslik &"', '"& oncelik &"', '"& aciklama &"', '"& dosya &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& talep_edilen &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
            set ekle = baglanti.execute(SQL)

            SQL="SELECT TOP 1 id FROM talep_fisleri where firma_id = '"& FirmaID &"' ORDER BY ekleme_tarihi DESC, ekleme_saati DESC"
            set idcek = baglanti.execute(SQL)

            for x = 0 to ubound(split(talep_edilen, ","))
                user = split(talep_edilen, ",")(x)
                SQL="insert into TalepFisleriGorevliler(FisID,GorevliID,FirmaID) values('"& idcek("id") &"', '"& user &"', '"& FirmaID &"')"
                set userekle = baglanti.execute(SQL)

                SQL="select * from ucgem_firma_kullanici_listesi where id = '"& user &"' and cop = 'false' and durum = 'true' and firma_id = '"& FirmaID &"'"
                set kcek = baglanti.execute(SQL)
                
                personelmail = kcek("personel_eposta")
                
                bildirim = Request.Cookies("kullanici")("kullanici_adsoyad") & " "& baslik &" adlı öncelik seviyesi "& oncelik &" bir Talep Fişi Oluşturdu. Açıklama :" & aciklama
                tip = "talep_fisleri"
                click = "sayfagetir(''/talepler/'',''jsid=4559'');"
                user_id = kcek("id")
                okudumu = "0"
                durum = "true"
                cop = "false"
                firma_kodu = request.Cookies("kullanici")("firma_kodu")
                firma_id = request.Cookies("kullanici")("firma_id")
                ekleyen_id = request.Cookies("kullanici")("kullanici_id")
                ekleyen_ip = Request.ServerVariables("Remote_Addr")

                SQL="insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& bildirim &"', '"& tip &"', N'"& click &"', '"& user &"', '"& okudumu &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate()); SET NOCOUNT ON; EXEC MailGonderBildirim @personel_id = '"& kcek("id") &"', @mesaj = '"& replace(bildirim, chr(13), "<br>") &"';"
                set ekle2 = baglanti.execute(SQL)
                
                for y = 0 to ubound(split(bildirimTuru, ","))
                    BildirimType = split(bildirimTuru, ",")(y)
                    if BildirimType = "SMS" then
                
                        NetGSM_SMS kcek("personel_telefon"), bildirim
                    elseif BildirimType = "MAIL" then
    %>
    <script type="text/javascript">
        MailGonder('<%=kcek("personel_eposta") %>', '<%=baslik %>', '<%=bildirim %>');
    </script>
    <%
                    end if
                next
            next
         

        elseif trn(request("islem2"))="sil" then

            kayit_id = trn(request("kayit_id"))

            silen_id = Request.Cookies("kullanici")("kullanici_id")
            silen_ip = Request.ServerVariables("Remote_Addr")
            silen_tarihi = date
            silen_saati = time

        

            SQL="update talep_fisleri set cop = 'true', silen_id = '"& silen_id &"', silen_ip = '"& silen_ip &"', silen_tarihi = CONVERT(date, '"& silen_tarihi &"', 103), silen_saati = '"& silen_saati &"' where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set sil = baglanti.execute(SQL)


        elseif trn(request("islem2"))="guncelle" then

            kayit_id = trn(request("kayit_id"))
            baslik = trn(request("baslik"))
            oncelik = trn(request("oncelik"))
            aciklama = trn(request("aciklama"))
            dosya = trn(request("dosya"))

            SQL="update talep_fisleri set baslik = '"& baslik &"', oncelik = '"& oncelik &"', aciklama = '"& aciklama &"', dosya = '"& dosya &"' where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)


        elseif trn(request("islem2"))="onay" then


            talep_id = trn(request("talep_id"))
            deger = trn(request("deger"))

            SQL="update talep_fisleri set durum = '"& deger &"' where id = '"& talep_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)

            SQL="select * from talep_fisleri where id = '"& talep_id &"' and firma_id = '"& FirmaID &"'"
            set cek = baglanti.execute(SQL)

            SQL="select * from ucgem_firma_kullanici_listesi where id= '"& cek("ekleyen_id") &"' and firma_id = '"& FirmaID &"'"
            set kcek = baglanti.execute(SQL)

            do while not kcek.eof
                
                bildirim = Request.Cookies("kullanici")("kullanici_adsoyad") & " ''"& cek("baslik") &"'' adlı talep fişinizin durumunu : "& deger &" olarak güncelledi." & chr(13) & chr(13) & "Açıklama :" & cek("aciklama") & chr(13) & chr(13)
                tip = "is_listesi"
                click = "sayfagetir(''/talepler/'',''jsid=4559&bildirim=true&bildirim_id="& is_id &"'');"
                user_id = kcek("id")
                okudumu = "0"
                durum = "true"
                cop = "false"
                firma_kodu = request.Cookies("kullanici")("firma_kodu")
                firma_id = request.Cookies("kullanici")("firma_id")
                ekleyen_id = request.Cookies("kullanici")("kullanici_id")
                ekleyen_ip = Request.ServerVariables("Remote_Addr")
    
                SQL="insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& bildirim &"', '"& tip &"', N'"& click &"', '"& user_id &"', '"& okudumu &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate()); SET NOCOUNT ON; EXEC MailGonderBildirim @personel_id = '"& kcek("id") &"', @mesaj = '"& replace(bildirim, chr(13), "<br>") &"';"
                set ekle2 = baglanti.execute(SQL)

                NetGSM_SMS kcek("personel_telefon"), bildirim


            kcek.movenext
            loop


        end if

    %>
    <style>
        .label {
            font-size: 12px;
            padding: 3px;
        }
    </style>
    <script type="text/javascript">
        if ($(window).width() < 500) {
            $("#yenitalepfisiekle").addClass("btn-mini");
        }
    </script>
    <div class="dt-responsive table-responsive">
        <table id="simpletable" class="table table-striped table-bordered datatableyap" style="width: 100%;">
            <thead>
                <tr>
                    <th data-hide="phone,tablet">ID</th>
                    <th data-hide="phone,tablet">Öncelik</th>
                    <th data-class="expand">Başlık</th>
                    <th data-hide="phone,tablet">Açıklama</th>
                    <th data-hide="phone,tablet">Ekleyen</th>
                    <th data-hide="phone,tablet">Talep Edilen Kişi</th>
                    <th data-hide="phone,tablet">Durum</th>
                    <th data-class="phone">İşlem</th>
                </tr>
            </thead>
            <tbody>
                <%

                    SQL="SELECT distinct talepler.* FROM [TalepFisleriGorevliler] TalepFisi INNER JOIN talep_fisleri talepler on TalepFisi.FisID = talepler.id where talepler.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and (talepler.id IN (SELECT FisID FROM [dbo].[TalepFisleriGorevliler] WHERE GorevliID = '"& Request.Cookies("kullanici")("kullanici_id") &"') OR talepler.ekleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"') and talepler.cop = 'false' order by talepler.id desc"
                    'SQL="select fis.*, kullanici.personel_ad, kullanici.personel_soyad, kul.personel_ad + ' ' + kul.personel_soyad as 'talep_edilen_adsoyad' from talep_fisleri fis join ucgem_firma_kullanici_listesi kullanici on kullanici.id = fis.ekleyen_id join ucgem_firma_kullanici_listesi kul on kul.id = fis.talep_edilen_id where fis.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and   (fis.talep_edilen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' OR fis.ekleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"') and fis.cop = 'false' order by fis.id desc"
                    set talepler = baglanti.execute(SQL)

                    if talepler.eof then
                %>
                <tr>
                    <td colspan="8" style="text-align: center;">Talep Kaydı Bulunamadı</td>
                </tr>
                <%
                    end if
                    t = 0
                    do while not talepler.eof
                     t = t +1

                    SQL="SELECT * FROM ucgem_firma_kullanici_listesi WHERE id = '"& talepler("ekleyen_id") &"' and firma_id = '"& FirmaID &"'" 
                    set kcek = baglanti.execute(SQL)
                %>
                <tr>
                    <td style="text-align: center; width: 25px;"><%=t %></td>
                    <% if trim(talepler("oncelik"))="Düsük" then %>
                    <td style="text-align: center;">
                        <span class="label label-warning ">Düşük</span>
                    </td>
                    <% elseif trim(talepler("oncelik"))="Yüksek" then %>
                    <td style="text-align: center;">
                        <span class="label label-danger">Yüksek</span>
                    </td>
                    <% elseif trim(talepler("oncelik"))="Normal" then %>
                    <td style="text-align: center;">
                        <span class="label label-info">Normal</span>
                    </td>
                    <% end if %>
                    <td><%=talepler("baslik") %></td>
                    <td><%=talepler("aciklama") %></td>
                    <td><%=kcek("personel_ad") & " " & kcek("personel_soyad") %><br />
                        <%=cdate(talepler("ekleme_tarihi")) & " " & left(talepler("ekleme_saati"),5) %></td>
                    <td><%
                           SQL="SELECT * FROM TalepFisleriGorevliler WHERE FisID = '"& talepler("id") &"' and FirmaID = '"& FirmaID &"'"
                           set talepFisiGorevliler = baglanti.execute(SQL)
                            
                            do while not talepFisiGorevliler.eof
                                SQL="SELECT * FROM ucgem_firma_kullanici_listesi WHERE id = '"& talepFisiGorevliler("GorevliID") &"' and firma_id = '"& FirmaID &"'"
                                set kcek2 = baglanti.execute(SQL)
                                
                    %>  <%=kcek2("personel_ad") & " " & kcek2("personel_soyad") %><br />
                        <% talepFisiGorevliler.movenext
                            loop %></td>
                    <% if trim(talepler("durum"))="İşlem Yapılıyor" then %>
                    <td style="text-align: center;">
                        <span class="label label-info">İşlem Yapılıyor</span>
                    </td>
                    <% elseif trim(talepler("durum"))="Onay Bekliyor" then %>
                    <td style="text-align: center;">
                        <span class="label label-warning ">Onay Bekliyor</span>
                    </td>
                    <% elseif trim(talepler("durum"))="Reddedildi" then %>
                    <td style="text-align: center;">
                        <span class="label label-danger">Reddedildi</span>
                    </td>
                    <% elseif trim(talepler("durum"))="Onaylandi" then %>
                    <td style="text-align: center;">
                        <span class="label label-success">Onaylandi</span>
                    </td>
                    <% end if %>

                    <td style="width: 70px;">

                        <%
                            isCheck = false
                            SQL="SELECT * FROM TalepFisleriGorevliler WHERE FisID = '"& talepler("id") &"' and FirmaID = '"& FirmaID &"'"
                            set talepGorevliler = baglanti.execute(SQL)

                            do while not talepGorevliler.eof
                                if InStr( talepGorevliler("GorevliID") , Request.Cookies("kullanici")("kullanici_id")) > 0   then
                                    isCheck = true
                                end if

                            talepGorevliler.movenext
                            loop
                            
                            if isCheck then
                        %>
                        <button type="button" class="btn btn-mini btn-primary dropdown-toggle dropdown-toggle-split waves-effect waves-light" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            İşlemler 
                        </button>
                        <div class="dropdown-menu">
                            <% if trim(talepler("durum"))="Onaylandı" or trim(talepler("durum"))="Reddedildi" then %>
                            <% else %>
                            <a class="dropdown-item waves-effect waves-light" onclick="TalebiIseDonustur('<%=talepler("id") %>');" href="javascript:void(0);">Talebi İş Emrine Dönüştür</a>
                            <% end if %>
                            <% if trim(talepler("durum"))="Onay Bekliyor" then %>
                            <a class="dropdown-item waves-effect waves-light" onclick="talep_fisi_onay('<%=talepler("id") %>', 'Reddedildi');" href="javascript:void(0);">Reddet</a>
                            <% end if %>
                            <a class="dropdown-item waves-effect waves-light" onclick="talep_fisi_duzenle('<%=talepler("id") %>');" href="javascript:void(0);">Düzenle</a>
                            <a class="dropdown-item waves-effect waves-light" onclick="talep_fisi_sil('<%=talepler("id") %>');" href="javascript:void(0);">Sil</a>
                        </div>
                        <%
                            else
                        %>
                        <i id="iconforbidden" class="fa fas fa-ban fa-3x" style="color: darkred" title="Yekiniz Yok !"></i>
                        <%
                           end if
                        %>
                    </td>
                </tr>
                <% 
                    talepler.movenext
                    loop
                %>
            </tbody>
        </table>
    </div>
    <%
    elseif trn(request("islem")) = "grup_parametreleri" then
    %>
    <table id="dt_basic" class="table table-bordered table-sprited datatableyap" style="width: 100%">
        <thead>
            <tr>
                <th>Id</th>
                <th>Grup Adı</th>
                <th>Grup Parametre</th>
                <th>Tip</th>
                <th>İşlem</th>
            </tr>
        </thead>
        <tbody>
            <%
                SQL = "select Gparam.HatirlaticiGrupParametreleriID, gr.GrupAdi, Gparam.Tip, Gparam.GrupParametre from Hatirlatici.GrupParametreleri Gparam join Hatirlatici.Grup gr on Gparam.HatirlaticiGrupID = gr.HatirlaticiGrupID where Gparam.Silindi = 'false' and Gparam.FirmaID = '"& FirmaID &"'"
                set GrupParametreleri = baglanti.execute(SQL)

                if GrupParametreleri.eof then
            %>
            <tr>
                <td colspan="5" style="text-align: center">Kayıt Bulunamadı</td>
            </tr>
            <%
                end if
                do while not GrupParametreleri.eof
                i = i + 1
            %>
            <tr>
                <td><%=i %></td>
                <td><%=GrupParametreleri("GrupAdi") %></td>
                <td><%=GrupParametreleri("GrupParametre") %></td>
                <td><%=GrupParametreleri("Tip") %></td>
                <td>
                    <button type="button" class="btn btn-info btn-mini" onclick="ParametreTanimlamalariDuzenle('/System_Root/ajax/islem1.aspx/ParametreTanimlamalariDuzenle', '<%=GrupParametreleri("HatirlaticiGrupParametreleriID") %>')">Düzenle</button>
                    <button type="button" class="btn btn-danger btn-mini" onclick="ParametreTanimlamalariSil('/System_Root/ajax/islem1.aspx/ParametreTanimlamalariSil', '<%=GrupParametreleri("HatirlaticiGrupParametreleriID") %>')">Sil</button>
                </td>
            </tr>
            <%
                GrupParametreleri.movenext
                loop
            %>
        </tbody>
    </table>
    <%
        elseif trn(request("islem")) = "aracTakipParametreleri" then
            durum = trn(request("durum"))
            if durum = "undefined" then
                    durum = "arac"
            end if
    %>
    <table id="dt_basic" class="table table-bordered table-sprited datatableyap" style="width: 100%">
        <thead>
            <tr>
                <th>Id</th>
                <th>Grup Adı</th>
                <th>Grup Parametre</th>
                <th>Tip</th>
                <%if durum = "arac" then %>
                    <th>Hatırlatma</th>
                <%end if %>
                <th>İşlem</th>
            </tr>
        </thead>
        <tbody>
            <%
                if durum = "hatirlatma" then
                    SQL = "select Gparam.AracTakipGrupParametreleriID, gr.GrupAdi, Gparam.Tip, Gparam.GrupParametre, Gparam.Hatirlatma from AracTakip.GrupParametreleri Gparam join AracTakip.Grup gr on Gparam.AracTakipGrupID = gr.AracTakipGrupID where Gparam.Silindi = 'false' and Gparam.FirmaID = '"& FirmaID &"' and Gparam.Hatirlatma = 'true' order by AracTakipGrupParametreleriID desc"
                elseif durum = "arac" then
                    SQL = "select Gparam.AracTakipGrupParametreleriID, gr.GrupAdi, Gparam.Tip, Gparam.GrupParametre, Gparam.Hatirlatma from AracTakip.GrupParametreleri Gparam join AracTakip.Grup gr on Gparam.AracTakipGrupID = gr.AracTakipGrupID where Gparam.Silindi = 'false' and Gparam.FirmaID = '"& FirmaID &"' order by AracTakipGrupParametreleriID desc"
                end if
                    set GrupParametreleri = baglanti.execute(SQL)

                if GrupParametreleri.eof then
            %>
            <tr>
                <td colspan="6" style="text-align: center">Kayıt Bulunamadı</td>
            </tr>
            <%
                end if 
                do while not GrupParametreleri.eof
                i = i + 1
            %>
            <tr>
                <td><%=i %></td>
                <td><%=GrupParametreleri("GrupAdi") %></td>
                <td><%=GrupParametreleri("GrupParametre") %></td>
                <td><%=GrupParametreleri("Tip") %></td>
                <%if durum = "arac" then %>
                    <td>
                        <%if GrupParametreleri("Hatirlatma") = True then %>
                            <label class="label label-success" style="width: 50px; font-size: 12px;">Var</label>
                        <%else %>
                            <label class="label label-warning" style="width: 50px; font-size: 12px;">Yok</label>
                        <%end if %>
                    </td>
                <%end if %>
                <td>
                    <button type="button" class="btn btn-info btn-mini" onclick="AracTakipParametreTanimlamalariDuzenle('/System_Root/ajax/islem1.aspx/AracTakipParametreTanimlamalariDuzenle', '<%=GrupParametreleri("AracTakipGrupParametreleriID") %>'<%if durum = "hatirlatma" then %>, 'hatirlatma'<%else %>, 'arac'<%end if %>)">Düzenle</button>
                    <button type="button" class="btn btn-danger btn-mini" onclick="AracTakipParametreTanimlamalariSil('/System_Root/ajax/islem1.aspx/AracTakipParametreTanimlamalariSil', '<%=GrupParametreleri("AracTakipGrupParametreleriID") %>')">Sil</button>
                </td>
            </tr>
            <%
                GrupParametreleri.movenext
                loop
            %>
        </tbody>
    </table>
    <%
    elseif trn(request("islem")) = "grup_list" then
    %>
    <table class="table table-bordered table-sprited table-mini" style="width: 100%">
         <thead>
             <tr>
                 <th colspan="3" style="text-align: center; padding: 6px !important;">Tanımlanan Gruplar</th>
             </tr>
             <tr>
                 <th>Id</th>
                 <th>Grup Adı</th>
                 <th>İşlem</th>
             </tr>
         </thead>
         <tbody>
             <%
                 SQL = "select * from Hatirlatici.Grup where Silindi = 'false' and FirmaID = '"& FirmaID &"'"
                 set Grup = baglanti.execute(SQL)

                 if not Grup.eof then
                 i = 0
                 do while not Grup.eof
                 i = i + 1
             %>
             <tr>
                 <td><%=i %></td>
                 <td><%=Grup("GrupAdi") %></td>
                 <td>
                     <button class="btn btn-info btn-mini" onclick="GrupDuzenle('/System_Root/ajax/islem1.aspx/GrupDuzenle', '<%=Grup("HatirlaticiGrupID") %>');">Düzenle</button>
                     <button class="btn btn-danger btn-mini" onclick="GrupSil('/System_Root/ajax/islem1.aspx/GrupSil', '<%=Grup("HatirlaticiGrupID") %>');">Sil</button>
                 </td>
             </tr>
             <%
                 Grup.movenext
                 loop
                 end if
             %>
         </tbody>
    </table>
    <%
        elseif trn(request("islem")) = "aractakipGrupList" then
    %>
    <table class="table table-bordered table-sprited table-mini" style="width: 100%">
         <thead>
             <tr>
                 <th colspan="3" style="text-align: center; padding: 6px !important;">Tanımlanan Gruplar</th>
             </tr>
             <tr>
                 <th>Id</th>
                 <th>Grup Adı</th>
                 <th>İşlem</th>
             </tr>
         </thead>
         <tbody>
             <%
                 SQL = "select * from AracTakip.Grup where Silindi = 'false' and FirmaID = '"& FirmaID &"'"
                 set Grup = baglanti.execute(SQL)

                 if Grup.eof then
             %>
                <tr>
                    <td colspan="3" style="text-align:center">Kayıt Bulunamadı</td>
                </tr>
             <%
                 end if

                 if not Grup.eof then
                 i = 0
                 do while not Grup.eof
                 i = i + 1
             %>
             <tr>
                 <td><%=i %></td>
                 <td><%=Grup("GrupAdi") %></td>
                 <td>
                     <button class="btn btn-info btn-mini" onclick="AracTakipGrupDuzenle('/System_Root/ajax/islem1.aspx/AracTakipGrupDuzenle', '<%=Grup("AracTakipGrupID") %>');">Düzenle</button>
                     <button class="btn btn-danger btn-mini" onclick="AracTakipGrupSil('/System_Root/ajax/islem1.aspx/AracTakipGrupSil', '<%=Grup("AracTakipGrupID") %>');">Sil</button>
                 </td>
             </tr>
             <%
                 Grup.movenext
                 loop
                 end if
             %>
         </tbody>
    </table>
    <%
    elseif trn(request("islem")) = "zorunlu_dosyalar" then
    %>
    <div class="dt-responsive table-responsive">
        <table id="dt_basic" class="table table-bordered table-sprited datatableyap" style="width: 100%">
            <thead>
                <tr>
                    <th>Id</th>
                    <th>Dosya Adı</th>
                    <th>Zorunlu</th>
                    <th>İşlem</th>
                </tr>
            </thead>
            <tbody>
                <%
                    FirmaID = Request.Cookies("kullanici")("firma_id")

                    SQL = "select * from ZorunluDosyalar where Silindi = 'false' and FirmaID = '"& FirmaID &"' order by DosyaID desc"
                    set dosyalar = baglanti.execute(SQL)

                    if dosyalar.eof then
                %>
                <tr>
                    <td colspan="5" style="text-align: center">Kayıt Bulunamadı</td>
                </tr>
                <%
                     end if
                     do while not dosyalar.eof
                     i = i + 1
                %>
                <tr>
                    <td><%=i %></td>
                    <td style="white-space:nowrap;"><%=dosyalar("DosyaAdi") %></td>
                    <td style="white-space:nowrap;">
                        <%if dosyalar("Zorunlu") = True then %>
                            <label class="label label-danger" style="padding: 4px; font-size: 11px; font-weight: 600;">Zorunlu</label>
                        <%elseif dosyalar("Zorunlu") = False then %>
                            <label class="label label-success" style="padding: 4px; font-size: 11px; font-weight: 600;">Zorunlu Değil</label>
                        <%end if %>
                    </td>
                    <td style="white-space:nowrap;">
                        <button type="button" class="btn btn-info btn-mini" onclick="ZorunluDosyaDuzenle('/System_Root/ajax/islem1.aspx/ZorunluDosyaDuzenle', '<%=dosyalar("DosyaID") %>');">Düzenle</button>
                        <button type="button" class="btn btn-danger btn-mini" onclick="ZorunluDosyaSil('/System_Root/ajax/islem1.aspx/ZorunluDosyaSil', '<%=dosyalar("DosyaID") %>');">Sil</button>
                    </td>
                </tr>
                <%
                      dosyalar.movenext
                      loop
                %>
            </tbody>
        </table>
    </div>
    <%
    elseif trn(request("islem"))="grup_deger_kaydet" then
        if trn(request("islem2")) = "ekle" then
            
            elementCount = trn(request("count"))
            grupId = trn(request("grupId"))
            aciklama = trn(request("aciklama"))
            'response.Write(aciklama)
            'paramId = trn(request("paramId"))
            olusturanId = Request.Cookies("kullanici")("kullanici_id")
            olusturmaTarihi = date

            ar = Array()
            For i = 0 To elementCount - 1
                value = trn(request("value" & i))
                Id = trn(request("paramId" & i))

                'SQL ="select * from Hatirlatici.GrupDegerleri where Silindi = 'false' and HatirlaticiGrupParametreID = '"& Id &"'"
                'set control = baglanti.Execute(SQL)

                'if not control.eof then
                'Response.Clear()
    %>
    <!--<script type="text/javascript">
        $(function () {
            mesaj_ver("Hatırlatıcı", "Eklemek İstediğiniz Kayıt Mevcut", "danger");
        });
    </script>-->
    <%
                'Response.End
                'return   
                'end if

                SQL = "insert into Hatirlatici.GrupDegerleri(HatirlaticiGrupParametreID, GrupValue, OlusturanID, OlusturmaTarihi, Silindi, Aciklama, FirmaID) values('"& Id &"', '"& value &"', '"& olusturanId &"', Convert(date, '"& olusturmaTarihi &"', 103), 'false', '"& aciklama &"', '"& FirmaID &"')"
                set grupDeger = baglanti.execute(SQL)     
            next
        end if
    %>
    <table class="table table-bordered table-sprited datatableyap" style="width: 100%">
        <thead>
            <tr>
                <th>Id</th>
                <th>Grup</th>
                <th>Parametre</th>
                <th>Parametre Değeri</th>
                <th>İşlem</th>
            </tr>
        </thead>
        <tbody>
            <%
                    SQL = "select grupDeger.HatirlaticiGrupDegerleriID, grupDeger.HatirlaticiGrupParametreID, grupDeger.GrupValue, grupParams.GrupParametre, grup.GrupAdi from Hatirlatici.GrupDegerleri as grupDeger INNER JOIN Hatirlatici.GrupParametreleri AS grupParams ON grupDeger.HatirlaticiGrupParametreID = grupParams.HatirlaticiGrupParametreleriID INNER JOIN Hatirlatici.Grup as grup On grupParams.HatirlaticiGrupID = grup.HatirlaticiGrupID where grupDeger.Silindi = 'false' and grupParams.Silindi = 'false' and grup.Silindi = 'false' and grupDeger.FirmaID = '"& FirmaID &"' and grupParams.FirmaID = '"& FirmaID &"' and grup.FirmaID = '"& FirmaID &"' order by HatirlaticiGrupDegerleriID desc"
                    set GrupDegerleri = baglanti.execute(SQL)
                'response.Write(SQL)
                    if GrupDegerleri.eof then
            %>
            <tr>
                <td colspan="4" style="text-align: center">Kayıt Bulunamadı</td>
            </tr>
            <%
                    end if
                    do while not GrupDegerleri.eof
                    k = k + 1
            %>
            <tr>
                <td><%=k %></td>
                <td><%=GrupDegerleri("GrupAdi") %></td>
                <td><%=GrupDegerleri("GrupParametre") %></td>
                <td><%=GrupDegerleri("GrupValue") %></td>
                <td>
                    <button type="button" class="btn btn-info btn-mini" onclick="GrupDegerleriDuzenle('/System_Root/ajax/islem1.aspx/GrupDegerleriDuzenle', '<%=GrupDegerleri("HatirlaticiGrupDegerleriID") %>')">Düzenle</button>
                    <button type="button" class="btn btn-danger btn-mini" onclick="GrupDegerleriSil('/System_Root/ajax/islem1.aspx/GrupDegerleriSil', '<%=GrupDegerleri("HatirlaticiGrupDegerleriID") %>')">Sil</button>
                </td>
            </tr>
            <%
                    GrupDegerleri.movenext
                    loop
            %>
        </tbody>
    </table>
    <%
    elseif trn(request("islem")) = "aracTakipGrupDegerleri" then
        if trn(request("islem2")) = "ekle" then
            elementCount = trn(request("count"))
            grupId = trn(request("grupId"))
            'paramId = trn(request("paramId"))
            olusturanId = Request.Cookies("kullanici")("kullanici_id")
            olusturmaTarihi = date

            ar = Array()
            For i = 0 To elementCount - 1
                value = trn(request("value" & i))
                Id = trn(request("paramId" & i))

                'SQL ="select * from Hatirlatici.GrupDegerleri where Silindi = 'false' and HatirlaticiGrupParametreID = '"& Id &"'"
                'set control = baglanti.Execute(SQL)

                'if not control.eof then
                'Response.Clear()
    %>
    <!--<script type="text/javascript">
        $(function () {
            mesaj_ver("Hatırlatıcı", "Eklemek İstediğiniz Kayıt Mevcut", "danger");
        });
    </script>-->
    <%
                'Response.End
                'return   
                'end if

                SQL = "insert into AracTakip.GrupDegerleri(AracTakipGrupParametreID, GrupValue, OlusturanID, OlusturmaTarihi, Silindi, FirmaID) values('"& Id &"', '"& value &"', '"& olusturanId &"', Convert(date, '"& olusturmaTarihi &"', 103), 'false', '"& FirmaID &"')"
                set grupDeger = baglanti.execute(SQL)  
            next
        end if
    %>
    <table class="table table-bordered table-sprited datatableyap" style="width: 100%">
        <thead>
            <tr>
                <th>Id</th>
                <th>Grup</th>
                <th>Parametre</th>
                <th>Parametre Değeri</th>
                <th>İşlem</th>
            </tr>
        </thead>
        <tbody>
            <%
                    SQL = "select grupDeger.AracTakipGrupDegerleriID, grupDeger.AracTakipGrupParametreID, grupDeger.GrupValue, grupParams.GrupParametre, grup.GrupAdi from AracTakip.GrupDegerleri as grupDeger INNER JOIN AracTakip.GrupParametreleri AS grupParams ON grupDeger.AracTakipGrupParametreID = grupParams.AracTakipGrupParametreleriID INNER JOIN AracTakip.Grup as grup On grupParams.AracTakipGrupID = grup.AracTakipGrupID where grupDeger.Silindi = 'false' and grupParams.Silindi = 'false' and grup.Silindi = 'false' and grupDeger.FirmaID = '"& FirmaID &"' and grupParams.FirmaID = '"& FirmaID &"' and grup.FirmaID = '"& FirmaID &"' order by AracTakipGrupDegerleriID desc"
                    set GrupDegerleri = baglanti.execute(SQL)
                'response.Write(SQL)
                    if GrupDegerleri.eof then
            %>
            <tr>
                <td colspan="5" style="text-align: center">Kayıt Bulunamadı</td>
            </tr>
            <%
                    end if
                    do while not GrupDegerleri.eof
                    k = k + 1
            %>
            <tr>
                <td><%=k %></td>
                <td><%=GrupDegerleri("GrupAdi") %></td>
                <td><%=GrupDegerleri("GrupParametre") %></td>
                <td><%=GrupDegerleri("GrupValue") %></td>
                <td>
                    <button type="button" class="btn btn-info btn-mini" onclick="AracTakipGrupDegerleriDuzenle('/System_Root/ajax/islem1.aspx/AracTakipGrupDegerleriDuzenle', '<%=GrupDegerleri("AracTakipGrupDegerleriID") %>')">Düzenle</button>
                    <button type="button" class="btn btn-danger btn-mini" onclick="AracTakipGrupDegerleriSil('/System_Root/ajax/islem1.aspx/AracTakipGrupDegerleriSil', '<%=GrupDegerleri("AracTakipGrupDegerleriID") %>')">Sil</button>
                </td>
            </tr>
            <%
                    GrupDegerleri.movenext
                    loop
            %>
        </tbody>
    </table>
    <%
    elseif trn(request("islem"))= "aracTakipKayitlari" then
    %>
        <div class="dt-responsive table-responsive">
            <table class="table table-bordered table-sprited datatableyap table-mini" style="width: 100%">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Plaka</th>
                        <th>Marka</th>
                        <th>Model</th>
                        <th>Yıl</th>
                        <th>İşlem</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                            SQL = "select AracTakipAracID, Marka, Model, Yil, Plaka from AracTakip.Arac where Silindi = 'false' and Durum = 'true' and FirmaID = '"& FirmaID &"' order by AracTakipAracID desc"
                            set aracTakipKayitlari = baglanti.execute(SQL)
                            if aracTakipKayitlari.eof then
                    %>
                    <tr>
                        <td colspan="7" style="text-align: center">Kayıt Bulunamadı</td>
                    </tr>
                    <%
                            end if
                            do while not aracTakipKayitlari.eof
                            k = k + 1
                    %>
                    <tr>
                        <td><%=k %></td>
                        <td><%=aracTakipKayitlari("Plaka") %></td>
                        <td><%=aracTakipKayitlari("Marka") %></td>
                        <td><%=aracTakipKayitlari("Model") %></td>
                        <td><%=aracTakipKayitlari("Yil") %></td>
                        <td>
                            <button type="button" class="btn btn-info btn-mini" onclick="sayfagetir('/aracDetay/','jsid=4559&id=<%=aracTakipKayitlari("AracTakipAracID") %>');">Detay</button>
                            <button type="button" class="btn btn-danger btn-mini" onclick="AracKaydiSil('/System_Root/ajax/islem1.aspx/AracKaydiSil', '<%=aracTakipKayitlari("AracTakipAracID") %>');">Sil</button>
                        </td>
                    </tr>
                    <%
                            aracTakipKayitlari.movenext
                            loop
                    %>
                </tbody>
            </table>
        </div>
    <%
    elseif trn(request("islem")) = "aracTakipKilometreKayitlari" then
        id = trn(request("id"))
    %>
        <div class="dt-responsive table-responsive">
            <table class="table table-bordered table-sprited datatableyap table-mini" style="width: 100%">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Kilometre</th>
                        <th>Ekleyen Kişi</th>
                        <th>Ekleme Tarihi</th>
                        <th>İşlem</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                            SQL = "select kl.AracTakipKilometreID, kl.AracTakipAracID, k.personel_ad +' '+ k.personel_soyad as ad_soyad, kl.Kilometre, kl.OlusturmaTarihi from AracTakip.Kilometre kl inner join ucgem_firma_kullanici_listesi k on kl.OlusturanID = k.id where AracTakipAracID = '"& id &"' and kl.Silindi = 'false' and kl.Durum = 'true' and kl.FirmaID = '"& FirmaID &"' and k.FirmaID = '"& FirmaID &"' order by kl.AracTakipKilometreID desc"
                            set aracTakipKilometreKayitlari = baglanti.execute(SQL)
                            if aracTakipKilometreKayitlari.eof then
                    %>
                    <tr>
                        <td colspan="7" style="text-align: center">Kayıt Bulunamadı</td>
                    </tr>
                    <%
                            end if
                            do while not aracTakipKilometreKayitlari.eof
                            k = k + 1
                    %>
                    <tr>
                        <td><%=k %></td>
                        <td><%=aracTakipKilometreKayitlari("Kilometre") %></td>
                        <td><%=aracTakipKilometreKayitlari("ad_soyad") %></td>
                        <td><%=aracTakipKilometreKayitlari("OlusturmaTarihi") %></td>
                        <td>
                            <button type="button" class="btn btn-info btn-mini" onclick="AracKilometreBilgiAl('/System_Root/ajax/islem1.aspx/AracKilometreBilgiAl', '<%=aracTakipKilometreKayitlari("AracTakipAracID") %>', '<%=aracTakipKilometreKayitlari("AracTakipKilometreID") %>');">Düzenle</button>
                            <button class="btn btn-warning btn-mini" id="bakimKaydiEkle" onclick="bakimKaydiEkle('<%=aracTakipKilometreKayitlari("AracTakipAracID") %>', '<%=aracTakipKilometreKayitlari("AracTakipKilometreID") %>');">Bakım Kaydı Ekle</button>
                            <!--<button type="button" class="btn btn-danger btn-mini" onclick="">Sil</button>-->
                        </td>
                    </tr>
                    <%
                            aracTakipKilometreKayitlari.movenext
                            loop
                    %>
                </tbody>
            </table>
        </div>
    <%
    elseif trn(request("islem")) = "servisBakimKayitlari" then
        id = trn(request("id"))
    %>
        <div class="dt-responsive table-responsive">
            <table class="table table-bordered table-sprited datatableyap table-mini text-nowrap" style="width: 100%">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Kilometre</th>
                        <th>Servis Adı</th>
                        <th>Servis Adresi</th>
                        <th>Servis Detayı</th>
                        <th>Hatırlatma Tarihi</th>
                        <th>Servise Gitti</th>
                        <th>İşlem</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                            SQL = "select b.AracTakipKilometreID, b.AracTakipBakimID, b.BakimTarihi, b.ServisAdi,b.ServisDetayi, b.ServisAdresi, k.Kilometre,case when ISNULL(b.ServiseGitti, 0) = 0 then N'Hayır' else  'Evet' end as ServiseGitti from AracTakip.Bakim b inner join AracTakip.Kilometre k on k.AracTakipKilometreID = b.AracTakipKilometreID inner join AracTakip.Arac a on a.AracTakipAracID = k.AracTakipAracID where a.AracTakipAracID = '"& id &"' and b.FirmaID = '"& FirmaID &"' and b.FirmaID = '"& FirmaID &"'" 
                            set servisBakimKayitlari = baglanti.execute(SQL)
                            if servisBakimKayitlari.eof then
                    %>
                    <tr>
                        <td colspan="8" style="text-align: center">Kayıt Bulunamadı</td>
                    </tr>
                    <%
                            end if
                            do while not servisBakimKayitlari.eof
                            k = k + 1
                    %>
                    <tr>
                        <td><%=k %></td>
                        <td><%=servisBakimKayitlari("Kilometre")%></td>
                        <td><%=servisBakimKayitlari("ServisAdi")%></td>
                        <td><%=servisBakimKayitlari("ServisAdresi")%></td>
                        <td><%=servisBakimKayitlari("ServisDetayi")%></td>
                        <td><%=servisBakimKayitlari("BakimTarihi")%></td>
                        <td>
                            <select class="form-control form-control-sm" id="selectServis<%=servisBakimKayitlari("AracTakipBakimID") %>" style="height:calc(1.8125rem + -12px); font-size:12px; padding:4px">
                                <option <%if servisBakimKayitlari("ServiseGitti") = "Evet" then%> selected <%end if %> value="1">Evet</option>
                                <option <%if servisBakimKayitlari("ServiseGitti") = "Hayır" then%> selected <%end if %> value="0">Hayır</option>
                            </select>
                            <button class="btn btn-info btn-mini ml-2" onclick="BakimServisDuzenle('/System_Root/ajax/islem1.aspx/BakimServisDuzenle', '<%=servisBakimKayitlari("AracTakipBakimID") %>', '<%=servisBakimKayitlari("AracTakipKilometreID") %>', '<%=id %>')">Düzenle</button>
                        </td>
                        <td>
                            <button class="btn btn-primary btn-mini" onclick="ServisBakimDuzenle('<%=servisBakimKayitlari("AracTakipBakimID") %>');">Düzenle</button>
                        </td>
                    </tr>
                    <%
                            servisBakimKayitlari.movenext
                            loop
                    %>
                </tbody>
            </table>            
        </div>
    <%
    elseif trn(request("islem")) = "bakimKaydiEkle" then
        aracID = trn(request("aracId"))
        kmID = trn(request("kmId"))
    %>
        <div class="modal-header">
            Servis Bakım Kaydı
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <form id="koftiform"></form>
        <form autocomplete="off" id="yeni_parca_giris_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
            <div class="row">
                <div class="form-group col-sm-6">
                    <label class="col-form-label">Servis Adı</label>
                    <input type="text" id="servisAdi" class="form-control" placeholder="Servis Adı"/>
                </div>
                <div class="form-group col-sm-6">
                    <label class="col-form-label">Servis Adresi</label>
                    <input type="text" id="servisAdresi" class="form-control" placeholder="Servis Adresi"/>
                </div>
                <div class="form-group col-sm-6">
                    <label class="col-form-label">Servis Telefonu</label>
                    <input type="text" id="servisTelefonu" class="form-control" placeholder="Servis Telefonu"/>
                </div>
                <div class="form-group col-sm-6">
                    <label class="col-form-label">Servis Tutarı</label>
                    <input type="text" id="tutari" class="form-control" placeholder="Servis Tutarı"/>
                </div>
                <div class="form-group col-sm-12">
                    <label class="col-form-label">Servis Detayı</label>
                    <textarea id="servisDetayi" class="form-control" placeholder="Servis Detayı"></textarea>
                </div>
                <div class="form-group col-sm-12">
                    <label class="col-form-label">Bakım Tarihi</label>
                    <input type="text" id="bakimTarihi" class="form-control takvimyap" placeholder="Bakım Tarihi" value="<%=response.write(Date) %>""/>
                </div>
                <div class="form-group col-sm-12" id="hatirlatma">
                    <label class="col-form-label">Hatırlatma</label>
                    <label class="col-sm-12 col-form-label" style="margin-bottom: 0px">
                        <span style="margin-right: 7px; font-size: 13px">Tarihinde Hatırlat</span>
                        <input type="checkbox" class="js-switch mr-4" id="tarihinde" />
                    </label>
                    <label class="col-sm-6 col-form-label" style="margin-bottom: 0px">
                        <span style="margin-right: 7px; font-size: 13px">Kilometreye Geldiğinde</span>
                        <input type="checkbox" class="js-switch" id="kilometreyeGeldiginde" onclick="KilometreyeGeldiginde();" />
                    </label>
                    <input type="text" id="txtKm" class="form-control form-control-sm col-sm-4 float-right" style="margin-right:4.5rem; display:none" value="0" placeholder="Kilometre"/>
                </div>
                <div class="form-group col-sm-12 row" id="herKmDiv">
                    <label class="col-form-label col-sm-1">Her</label>
                    <input type="text" class="form-control form-control-sm col-sm-2 ml-2 mr-2" id="herKm" value="0" placeholder="km"/>
                    <label class="col-form-label"> km'de bir</label>
                    <label class="col-sm-2 col-form-label" style="margin-bottom: 0px">
                        <input type="checkbox" class="js-switch mr-4" id="herKmdebir"/>
                    </label>
                </div>
            </div>

            <div class="modal-footer" style="padding:0px">
                <input type="button" onclick="YeniServisBakimEkle('/System_Root/ajax/islem1.aspx/YeniServisBakimEkle', '<%=aracID%>', '<%=kmID%>');" class="btn btn-success btn-mini mt-3" value="Bakım Ekle" />
            </div>

            <script type="text/javascript">
                function KilometreyeGeldiginde() {
                    if ($("#txtKm").is(":visible") === true) {
                        $("#txtKm").hide();
                    }
                    else {
                        $("#txtKm").show();
                    }
                }

                $(document).ready(function () {
                    $("#txtKm, #tutari, #herKm, #servisTelefonu").keypress(function (e) {
                        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                            return false;
                        }
                    });
                });
            </script>
        </form>
    <%
        elseif trn(request("islem")) = "bakimKaydiDuzenle" then
        servisId = trn(request("servisID"))

        SQL = "select b.AracTakipBakimID, b.AracTakipKilometreID, h.AracTakipAracID, h.AracTakipHatirlatmaID, b.ServisAdi, b.ServisAdresi, b.ServisDetayi, b.ServisTelefonu, b.Tutar, (SELECT FORMAT(b.BakimTarihi,'dd.MM.yyyy')) as BakimTarihi, h.TarihindeHatirlat, h.KilometreyeGeldigindeHatirlat, h.HatirlatmaKilometresi, h.HerKmdeHatirlat, h.HerKmDegeri from AracTakip.Bakim b inner join AracTakip.Hatirlatma h on h.ServisBakimID = b.AracTakipBakimID where b.AracTakipBakimID = '"& servisId &"' and b.FirmaID = '"& FirmaID &"' and h.FirmaID = '"& FirmaID &"'"
        set bakimBilgileri = baglanti.execute(SQL)
    %>
        <div class="modal-header">
            Servis Bakım Düzenle
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <form id="koftiform"></form>
        <form autocomplete="off" id="yeni_parca_giris_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
            <div class="row">
                <div class="form-group col-sm-6">
                    <label class="col-form-label">Servis Adı</label>
                    <input type="text" id="servisAdi" class="form-control" placeholder="Servis Adı" value="<%=bakimBilgileri("ServisAdi") %>"/>
                </div>
                <div class="form-group col-sm-6">
                    <label class="col-form-label">Servis Adresi</label>
                    <input type="text" id="servisAdresi" class="form-control" placeholder="Servis Adresi" value="<%=bakimBilgileri("ServisAdresi") %>"/>
                </div>
                <div class="form-group col-sm-6">
                    <label class="col-form-label">Servis Telefonu</label>
                    <input type="text" id="servisTelefonu" class="form-control" placeholder="Servis Telefonu" value="<%=bakimBilgileri("ServisTelefonu") %>"/>
                </div>
                <div class="form-group col-sm-6">
                    <label class="col-form-label">Servis Tutarı</label>
                    <input type="text" id="tutari" class="form-control" placeholder="Servis Tutarı" value="<%=bakimBilgileri("Tutar") %>"/>
                </div>
                <div class="form-group col-sm-12">
                    <label class="col-form-label">Servis Detayı</label>
                    <textarea id="servisDetayi" class="form-control" placeholder="Servis Detayı"><%=bakimBilgileri("ServisDetayi") %></textarea>
                </div>
                <div class="form-group col-sm-12">
                    <label class="col-form-label">Bakım Tarihi</label>
                    <input type="text" id="bakimTarihi" class="form-control takvimyap" placeholder="Bakım Tarihi" value="<%=response.write(bakimBilgileri("BakimTarihi")) %>"/>
                </div>
                <div class="form-group col-sm-12" id="hatirlatma">
                    <label class="col-form-label">Hatırlatma</label>
                    <label class="col-sm-12 col-form-label" style="margin-bottom: 0px">
                        <span style="margin-right: 7px; font-size: 13px">Tarihinde Hatırlat</span>
                        <input type="checkbox" class="js-switch mr-4" id="tarihinde" <%if bakimBilgileri("TarihindeHatirlat") = True then %> checked="checked" <%end if %> />
                    </label>
                    <label class="col-sm-6 col-form-label" style="margin-bottom: 0px">
                        <span style="margin-right: 7px; font-size: 13px">Kilometreye Geldiğinde</span>
                        <input type="checkbox" class="js-switch" id="kilometreyeGeldiginde" onclick="KilometreyeGeldiginde();" <%if bakimBilgileri("KilometreyeGeldigindeHatirlat") = True then %> checked="checked" <%end if %> />
                    </label>
                    <input type="text" id="txtKm" class="form-control form-control-sm col-sm-4 float-right" style="margin-right:4.5rem; display:none" <%if bakimBilgileri("KilometreyeGeldigindeHatirlat") = True then %> value="<%=bakimBilgileri("HatirlatmaKilometresi") %>" <%else %> value="0" <%end if %> placeholder="Kilometre" />
                </div>
                <div class="form-group col-sm-12 row" id="herKmDiv">
                    <label class="col-form-label col-sm-1">Her</label>
                    <input type="text" class="form-control form-control-sm col-sm-2 ml-2 mr-2" id="herKm" <%if bakimBilgileri("HerKmdeHatirlat") = True then %> value="<%=bakimBilgileri("HerKmDegeri") %>" <%end if %> placeholder="km"/>
                    <label class="col-form-label"> km'de bir</label>
                    <label class="col-sm-2 col-form-label" style="margin-bottom: 0px">
                        <input type="checkbox" class="js-switch mr-4" id="herKmdebir" <%if bakimBilgileri("HerKmdeHatirlat") = True then %> checked="checked" <%end if %>/>
                    </label>
                </div>
            </div>

            <div class="modal-footer" style="padding:0px">
                <input type="button" onclick="YeniServisBakimDuzenle('/System_Root/ajax/islem1.aspx/YeniServisBakimDuzenle', '<%=bakimBilgileri("AracTakipBakimID")%>', '<%=bakimBilgileri("AracTakipHatirlatmaID")%>', '<%=bakimBilgileri("AracTakipAracID")%>');" class="btn btn-info btn-mini mt-3" value="Bakım Düzenle" />
            </div>

            <script type="text/javascript">
                function KilometreyeGeldiginde() {
                    if ($("#txtKm").is(":visible") === true) {
                        $("#txtKm").hide();
                    }
                    else {
                        $("#txtKm").show();
                    }
                }

                $(document).ready(function () {
                    $("#txtKm, #tutari, #herKm, #servisTelefonu").keypress(function (e) {
                        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                            return false;
                        }
                    });
                });
            </script>
        </form>
    <%
    elseif trn(request("islem"))="satinalma_siparisleri" then

        if trn(request("islem2"))="ekle" then

            baslik = trn(request("baslik"))
            siparis_tarihi = trn(request("siparis_tarihi"))
            oncelik = trn(request("oncelik"))
            tedarikci_id = trn(request("tedarikci_id"))
            alttoplam = trn(request("alttoplam"))
            aciklama = trn(request("aciklama"))
            proje_id = trn(request("proje_id"))

            toplamtl = trn(request("toplamtl"))
            toplamusd = trn(request("toplamusd"))
            toplameur = trn(request("toplameur"))
            parcalar = trn(request("parcalar"))
            durum = trn(request("durum"))


            durum = trn(request("durum"))
            cop = "false"
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time

            if tedarikci_id = "null" then
                tedarikci_id = 0
            end if
            if proje_id = "null" then
                proje_id = 0
            end if


            SQL="SET NOCOUNT ON; insert into satinalma_listesi(baslik, siparis_tarihi, oncelik, tedarikci_id, proje_id, aciklama, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, toplamtl, toplamusd, toplameur) values('"& baslik &"', CONVERT(date, '"& siparis_tarihi &"', 103), '"& oncelik &"', '"& tedarikci_id &"', '"& proje_id &"', '"& aciklama &"', '"& durum &"', '"& cop &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"', '"& toplamtl &"', '"& toplamusd &"', '"& toplameur &"'); SELECT SCOPE_IDENTITY() id;"
            set ekle = baglanti.execute(SQL)

            SatinalmaId = ekle(0)

            for x = 0 to ubound(split(parcalar, "|"))

                if len(split(parcalar, "|")(x)) > 5 then

                    maliyet = split(split(parcalar, "|")(x), "~")(0)
                    pb = split(split(parcalar, "|")(x), "~")(1)
                    adet = split(split(parcalar, "|")(x), "~")(2)
                    parcaId = split(split(parcalar, "|")(x), "~")(3)


                    durum = "true"
                    cop = "false"
                    firma_id = Request.Cookies("kullanici")("firma_id")
                    ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
                    ekleyen_ip = Request.ServerVariables("Remote_Addr")
                    ekleme_tarihi = date
                    ekleme_saati = time

                    SQL="insert into satinalma_siparis_listesi(SatinalmaId, parcaId, maliyet, pb, adet, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& SatinalmaId &"', '"& parcaId &"', '"& maliyet &"', '"& pb &"', '"& adet &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
                    set ekle = baglanti.execute(SQL)

                end if

            next

        elseif trn(request("islem2"))="guncelle" then

            kayit_id = trn(request("kayit_id"))
            is_id = trn(request("is_id"))
            'Response.Write("iş Id : " & is_id)

            baslik = trn(request("baslik"))
            siparis_tarihi = trn(request("siparis_tarihi"))
            oncelik = trn(request("oncelik"))
            tedarikci_id = trn(request("tedarikci_id"))
            aciklama = trn(request("aciklama"))

            toplamtl = trn(request("toplamtl"))
            toplamusd = trn(request("toplamusd"))
            toplameur = trn(request("toplameur"))
            parcalar = trn(request("parcalar"))

            durum = trn(request("durum"))
            cop = "false"
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time


            SQL="update satinalma_listesi set durum = '"& durum &"', baslik = '"& baslik &"', siparis_tarihi = CONVERT(date, '"& siparis_tarihi &"', 103), oncelik = '"& oncelik &"', tedarikci_id = '"& tedarikci_id &"', aciklama = '"& aciklama &"', toplamtl = '"& toplamtl &"', toplamusd = '"& toplamusd &"', toplameur = '"& toplameur &"' where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)

            SatinalmaId = kayit_id

            SQL="delete from satinalma_siparis_listesi where SatinalmaId = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set sil = baglanti.execute(SQL)

            for x = 0 to ubound(split(parcalar, "|"))

                if len(split(parcalar, "|")(x))>5 then

                    maliyet = split(split(parcalar, "|")(x), "~")(0)
                    pb = split(split(parcalar, "|")(x), "~")(1)
                    adet = split(split(parcalar, "|")(x), "~")(2)
                    parcaId = split(split(parcalar, "|")(x), "~")(3)


                    durum = "true"
                    cop = "false"
                    firma_id = Request.Cookies("kullanici")("firma_id")
                    ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
                    ekleyen_ip = Request.ServerVariables("Remote_Addr")
                    ekleme_tarihi = date
                    ekleme_saati = time

                    SQL="insert into satinalma_siparis_listesi(SatinalmaId, IsId, parcaId, maliyet, pb, adet, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& SatinalmaId &"', '"& is_id &"', '"& parcaId &"', '"& maliyet &"', '"& pb &"', '"& adet &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
                    set ekle = baglanti.execute(SQL)

                end if

            next

            

        elseif trn(request("islem2"))="sil" then

            kayit_id = trn(request("kayit_id"))

            SQL="update satinalma_listesi set cop = 'true', silen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"', silen_tarihi = getdate(), silen_saati = getdate() where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set sil = baglanti.execute(SQL)

        end if


    %>
    <div class="dt-responsive table-responsive" style="padding-bottom: 400px;">
        <table id="simpletable" class="table table-striped table-bordered nowrap datatableyap" style="width: 100%;">
            <thead>
                <tr>
                    <th data-hide="phone,tablet">ID</th>
                    <th data-hide="phone,tablet" style="width: 60px;">Öncelik</th>
                    <th data-class="expand">Başlık</th>
                    <th data-hide="phone,tablet">Tarih</th>
                    <th data-hide="phone,tablet">Tedarikçi</th>
                    <th data-hide="phone,tablet">Proje</th>
                    <th data-hide="phone,tablet">Toplam Maliyet</th>
                    <th data-hide="phone,tablet">Ekleyen</th>
                    <th data-hide="phone,tablet" style="width: 60px;">Durum</th>
                    <th>İşlem</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    if trn(request("islem2"))="arama" then

                        baslik = trn(request("baslik"))
                        siparis_tarihi = trn(request("siparis_tarihi"))
                        oncelik = trn(request("oncelik"))
                        tedarikci_id = trn(request("tedarikci_id"))
                        aciklama = trn(request("aciklama"))
                        durum = trn(request("durum"))

                        if len(baslik)>1 then
                            sorgu_str = sorgu_str & " and (satinalma.baslik collate French_CI_AI like '%"& baslik &"%')"
                        end if

                        if len(siparis_tarihi)>5 then
                            if isdate(siparis_tarihi)=true then
                                sorgu_str = sorgu_str & " and (satinalma.siparis_tarihi  = CONVERT(date, '"& siparis_tarihi &"', 103))"
                            end if
                        end if

                        if not trim(oncelik) = "0" then
                            sorgu_str = sorgu_str & " and (satinalma.oncelik collate French_CI_AI like '%"& oncelik &"%')"
                        end if

                        if not trim(tedarikci_id)="0" then
                            sorgu_str = sorgu_str & " and (satinalma.tedarikci_id = '"& tedarikci_id &"')"
                        end if

                        if len(aciklama)>1 then
                            sorgu_str = sorgu_str & " and (satinalma.aciklama collate French_CI_AI like '%"& aciklama &"%')"
                        end if

                        if not trim(durum)="0" then
                            sorgu_str = sorgu_str & " and (satinalma.durum collate French_CI_AI like '%"& durum &"%')"
                        end if

                        SQL="select satinalma.*, isnull(firma.firma_adi, '') as tedarikci, kullanici.personel_ad + ' ' + kullanici.personel_soyad as ekleyen from satinalma_listesi satinalma left join ucgem_firma_listesi firma on firma.id = satinalma.tedarikci_id join ucgem_firma_kullanici_listesi kullanici on kullanici.id = satinalma.ekleyen_id  where satinalma.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and satinalma.cop = 'false' "& sorgu_str &" order by satinalma.id desc"
                    else
                        SQL="select satinalma.*, isnull(firma.firma_adi, '') as tedarikci, proje.proje_adi as proje, proje.proje_kodu as proje_kodu, kullanici.personel_ad + ' ' + kullanici.personel_soyad as ekleyen from satinalma_listesi satinalma left join ucgem_firma_listesi firma on firma.id = satinalma.tedarikci_id left join ucgem_proje_listesi proje on proje.id = satinalma.proje_id join ucgem_firma_kullanici_listesi kullanici on kullanici.id = satinalma.ekleyen_id where satinalma.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and satinalma.cop = 'false' order by satinalma.id desc"
                    
                    end if
                    set satinalma = baglanti.execute(SQL)
                    'response.Write(SQL)
                    if satinalma.eof then
                %>
                <tr>
                    <td colspan="10" style="text-align: center;">Satınalma Kaydı Bulunamadı</td>
                </tr>
                <%
                    end if
                    s = 0
                    do while not satinalma.eof
                        s = s + 1
                %>
                <tr>
                    <td style="text-align: center;"><%=s %></td>
                    <% if trim(satinalma("oncelik"))="Düşük" then %>
                    <td style="text-align: center;">
                        <span class="label label-warning" style="font-size: 11px">Düşük</span>
                    </td>
                    <% elseif trim(satinalma("oncelik"))="Yüksek" then %>
                    <td style="text-align: center;">
                        <span class="label label-danger" style="font-size: 11px">Yüksek</span>
                    </td>
                    <% elseif trim(satinalma("oncelik"))="Normal" then %>
                    <td style="text-align: center;">
                        <span class="label label-info" style="font-size: 11px">Normal</span>
                    </td>
                    <% end if %>
                    <td><%=satinalma("baslik") %></td>
                    <td><%=cdate(satinalma("siparis_tarihi"))%></td>

                    <%if trim(satinalma("tedarikci_id")) = "0" then%>
                    <td><span style="font-size: 12px; font-weight: bold">-</span></td>
                    <%else%>
                    <td><%=satinalma("tedarikci")%></td>
                    <%end if %>

                    <%if trim(satinalma("proje_id")) = "0" then%>
                    <td><span style="font-size: 12px; font-weight: bold">-</span></td>
                    <%else%>
                    <td><%=satinalma("proje")%>-<%=satinalma("proje_kodu")%></td>
                    <%end if %>
                    <td>
                        <% if not formatnumber(satinalma("toplamtl"),2) = "00" then %>
                        <%=formatnumber(satinalma("toplamtl"),2) %> TL
                        <% end if  %>
                        <% if Cdbl(satinalma("toplamtl")) > 0 and Cdbl(satinalma("toplamusd")) > 0 or Cdbl(satinalma("toplamtl")) > 0 and Cdbl(satinalma("toplameur")) > 0 then %>
                            -
                        <%end if %>
                        <% if not formatnumber(satinalma("toplamusd"),2) = "00" then %>
                        <%=formatnumber(satinalma("toplamusd"),2) %> USD
                        <% end if  %>
                        <% if Cdbl(satinalma("toplamusd")) > 0 and Cdbl(satinalma("toplameur")) > 0 then %>
                            -
                        <%end if %>
                        <% if not formatnumber(satinalma("toplameur"),2) = "00" then %>
                        <%=formatnumber(satinalma("toplameur"),2) %> EUR
                        <% end if  %></td>
                    <td><%=satinalma("ekleyen") %><br />
                        <%=cdate(satinalma("ekleme_tarihi")) %></td>
                    <% if trim(satinalma("durum"))="Siparis Edildi" then %>
                    <td style="text-align: center;">
                        <span class="label label-info" style="font-size: 11px">Sipariş Edildi</span>
                    </td>
                    <% elseif trim(satinalma("durum"))="Iptal Edildi" then %>
                    <td style="text-align: center;">
                        <span class="label label-danger" style="font-size: 11px">İptal Edildi</span>
                    </td>
                    <% elseif trim(satinalma("durum"))="Tamamlandi" then %>
                    <td style="text-align: center;">
                        <span class="label label-success" style="font-size: 11px">Tamamlandı</span>
                    </td>
                    <% else %>
                    <td style="text-align: center;">
                        <span class="label label-warning" style="font-size: 11px">Onay Bekliyor</span>
                    </td>
                    <% end if %>

                    <td class="dropdown" style="width: 10px;">
                        <button type="button" class="btn btn-mini btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-cog" aria-hidden="true"></i></button>
                        <div class="dropdown-menu dropdown-menu-right b-none contact-menu">
                            <a class="dropdown-item" href="javascript:void(0);" onclick="rapor_pdf_indir('satinalma_formu', '<%=satinalma("id") %>', '<%=satinalma("IsId") %>');"><i class="fa fa-download"></i>S.Alma Form İndir</a>
                            <a class="dropdown-item" href="javascript:void(0);" onclick="rapor_pdf_indir('teklif_formu', '<%=satinalma("id") %>', '<%=satinalma("IsId") %>');"><i class="fa fa-download"></i>Teklif Form İndir</a>
                            <a class="dropdown-item" href="javascript:void(0);" onclick="rapor_pdf_yazdir('satinalma_formu','<%=satinalma("id") %>', '<%=satinalma("IsId") %>');"><i class="fa fa-print"></i>Yazdır</a>
                            <a class="dropdown-item" href="javascript:void(0);" onclick="rapor_pdf_gonder('satinalma_formu','<%=satinalma("id") %>', '<%=satinalma("IsId") %>');"><i class="fa fa-send"></i>Gönder</a>
                            <a class="dropdown-item" href="javascript:void(0);" onclick="satinalma_kayitduzenle('<%=satinalma("id") %>', '<%=satinalma("IsId") %>');"><i class="icofont icofont-edit"></i>Düzenle</a>
                            <a class="dropdown-item" href="javascript:void(0);" onclick="satinalma_kayitsil('<%=satinalma("id") %>', '<%=satinalma("IsId") %>');"><i class="icofont icofont-ui-delete"></i>Sil</a>
                        </div>
                    </td>
                </tr>
                <% 
                    satinalma.movenext
                    loop
                %>
            </tbody>
        </table>
    </div>
    <%


    elseif trn(request("islem"))="satinalma_kayitduzenle" then

        kayit_id = trn(request("kayit_id"))
        is_id = trn(request("is_id"))

        SQL="select * from satinalma_listesi where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
        set kayit = baglanti.execute(SQL)

    %>
    <div class="modal-header">
        Satınalma Siparişi Düzenle
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
    </div>
    <form id="koftiform"></form>
    <form autocomplete="off" id="satinalmasiparisi" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">

        <div class="row">
            <label class="col-sm-12 col-form-label">Başlık :</label>
            <div class="col-sm-12">
                <input type="text" name="satinalma_baslik" id="satinalma_baslik" value="<%=kayit("baslik") %>" class="form-control required" required />
            </div>
        </div>

        <div class="row">
            <label class="col-sm-6 col-form-label">Sipariş Tarihi :</label>
            <label class="col-sm-6 col-form-label">Öncelik :</label>
            <div class="col-sm-6">
                <input type="text" name="siparis_tarihi" id="siparis_tarihi" class="form-control required takvimyap" value="<%=FormatDate(kayit("siparis_tarihi"), "00") %>" required />
            </div>
            <div class="col-sm-6">
                <select name="satinalma_oncelik" id="satinalma_oncelik" class="select2">
                    <option <% if trim(kayit("oncelik"))="Normal" then %> selected="selected" <% end if %> value="Normal">Normal</option>
                    <option <% if trim(kayit("oncelik"))="Düşük" then %> selected="selected" <% end if %> value="Düşük">Düşük</option>
                    <option <% if trim(kayit("oncelik"))="Yüksek" then %> selected="selected" <% end if %> value="Yüksek">Yüksek</option>
                </select>
            </div>
        </div>


        <div class="row">
            <label class="col-sm-6 col-form-label">Tedarikçi :</label>
            <label class="col-sm-6 col-form-label">Proje :</label>
            <div class="col-sm-6">
                <select name="satinalma_tedarikci_id" id="satinalma_tedarikci_id" class="select2">
                    <%
                    SQL="select id, firma_adi from ucgem_firma_listesi where ekleyen_firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and cop = 'false' and yetki_kodu = 'TASERON'"
                    set firmacek = baglanti.execute(SQL)
                    do while not firmacek.eof
                    %>
                    <option <% if trim(firmacek("id"))=trim(kayit("tedarikci_id")) then %> selected="selected" <% end if %> value="<%=firmacek("id") %>"><%=firmacek("firma_adi") %> </option>
                    <%
                    firmacek.movenext
                    loop
                    %>
                </select>
            </div>
            <div class="col-sm-6">
                <select name="satinalma_proje_id" id="satinalma_proje_id" class="select2">
                    <%
                    SQL="select * from ucgem_proje_listesi where durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"'"
                    set proje = baglanti.execute(SQL)
                    do while not proje.eof
                    %>
                    <option <% if trim(proje("id"))=trim(kayit("proje_id")) then %> selected="selected" <% end if %> value="<%=proje("id") %>"><%=proje("proje_adi") %>-<%=proje("proje_kodu") %> </option>
                    <%
                    proje.movenext
                    loop
                    %>
                </select>
            </div>
        </div>

        <%
        i = -1
        %>

        <script>

        $(function (){
            parcalar_autocomplete_calistir();
        });
        </script>

        <div class="row">
            <label class="col-sm-12 col-form-label">
                Parçalar :
            </label>
            <hr />
            <div class="col-sm-12">
                <div class="well">
                    <table style="width: 100%;">
                        <thead>
                            <tr>
                                <th>Parça</th>
                                <th style="width: 250px;">Maliyet</th>
                                <th style="width: 150px; padding-left: 15px;">Adet</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody id="satinalma_parcalistesi">
                            <%
                            SQL="SELECT parca.parca_kodu + ' - ' + parca.marka + ' - ' + parca.aciklama AS parcaadi, * FROM satinalma_siparis_listesi siparis JOIN parca_listesi parca ON parca.id = siparis.parcaId where SatinalmaId = '"& kayit("id") &"' and siparis.cop = 'false' and siparis.firma_id = '"& FirmaID &"' and parca.firma_id = '"& FirmaID &"'" 
                            set siparis = baglanti.execute(SQL)
                                'response.Write(SQL)
                            do while not siparis.eof
                            i = i + 1
                            %>
                            <tr id="satinalmasatir<%=i %>">
                                <td>
                                    <input type="text" name="parcalar" id="parcalar<%=i %>" i="<%=i %>" data="<%=siparis("parcaId") %>" value="<%=siparis("parcaadi") %>" class="form-control parcalar required" required />
                                </td>
                                <td>
                                    <div class="row">
                                        <div class="col-sm-6" style="text-align: right; padding-right: 0;">
                                            <input type="text" class="form-control maliyetler required" required name="maliyet" id="maliyet<%=i %>" onkeyup="satinalmasiparishesapkitap();" value="<%=siparis("maliyet") %>" style="height: 38px;" />
                                        </div>
                                        <div class="col-sm-6" style="padding-left: 15px; text-align: left;">
                                            <select onchange="satinalmasiparishesapkitap();" class="form-control yapilan paralar" name="paralar" id="paralar<%=i %>">
                                                <option <% if trim(siparis("pb"))="TL" then %> selected="selected" <% end if %> value="TL">TL</option>
                                                <option <% if trim(siparis("pb"))="USD" then %> selected="selected" <% end if %> value="USD">USD</option>
                                                <option <% if trim(siparis("pb"))="EUR" then %> selected="selected" <% end if %> value="EUR">EUR</option>
                                            </select>
                                        </div>
                                    </div>
                                </td>
                                <td style="padding-left: 15px;">
                                    <input type="text" class="form-control adetler required" required onkeyup="satinalmasiparishesapkitap();" name="adet" id="adet<%=i %>" style="height: 38px;" value="<%=siparis("adet") %>" /></td>
                                <th style="width: 25px; padding-left: 10px;"><a href="javascript:void(0);" onclick="satinalmayenisatirsil('<%=i %>'); satinalmasiparishesapkitap();">
                                    <img src="/img/abort.png" /></a></th>
                            </tr>
                            <%
                            siparis.movenext
                            loop
                            %>
                        </tbody>
                    </table>
                    <input type="hidden" name="parcasayisi" id="parcasayisi" value="<%=i %>" />
                    <div style="float: right;">
                        <a href="javascript:void(0);" onclick="satinalmayenisatirekle('<%=i %>');">
                            <img src="/img/plus.png" /></a>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">

            <label class="col-sm-4 col-form-label">Alt Toplam TL:</label>
            <label class="col-sm-4 col-form-label">Alt Toplam USD:</label>
            <label class="col-sm-4 col-form-label">Alt Toplam EUR:</label>

            <div class="col-sm-4">
                <input type="text" class="form-control required" required name="satinalma_alttoplam" value="<%=formatnumber(kayit("toplamtl"),2) %>" id="satinalma_alttoplamtl" />
            </div>

            <div class="col-sm-4">
                <input type="text" class="form-control required" required name="satinalma_alttoplam" value="<%=formatnumber(kayit("toplamusd"),2) %>" id="satinalma_alttoplamusd" />
            </div>

            <div class="col-sm-4">
                <input type="text" class="form-control required" required name="satinalma_alttoplam" value="<%=formatnumber(kayit("toplameur"),2) %>" id="satinalma_alttoplameur" />
            </div>

        </div>

        <div class="row">
            <label class="col-sm-12 col-form-label">Satınalma Durum :</label>
            <div class="col-sm-12">
                <select name="satinalma_durum" id="satinalma_durum" class="select2">
                    <option <% if trim(kayit("durum"))="Sipariş Edildi" then %> selected="selected" <% end if %> value="Sipariş Edildi">Sipariş Edildi</option>
                    <option <% if trim(kayit("durum"))="Iptal Edildi" then %> selected="selected" <% end if %> value="İptal Edildi">İptal Edildi</option>
                    <option <% if trim(kayit("durum"))="Tamamlandı" then %> selected="selected" <% end if %> value="Tamamlandı">Tamamlandı</option>
                    <option <% if trim(kayit("durum"))="Onay Bekliyor" then %> selected="selected" <% end if %> value="Onay Bekliyor">Onay Bekliyor</option>
                </select>
            </div>
        </div>

        <div class="row">
            <label class="col-sm-12 col-form-label">Açıklama :</label>
            <div class="col-sm-12">
                <textarea name="satinalma_aciklama" id="satinalma_aciklama" class="form-control"><%=kayit("aciklama") %></textarea>
            </div>
        </div>


        <div class="modal-footer">
            <input type="button" class="btn btn-primary" onclick="SatinalmaSiparisGuncelle('<%=kayit("id")%>', '<%=kayit("IsId")%>');" value="Sipariş Güncelle" />
        </div>


        <style>
            .ui-helper-hidden {
                display: none;
            }

            .ui-helper-hidden-accessible {
                border: 0;
                clip: rect(0 0 0 0);
                height: 1px;
                margin: -1px;
                overflow: hidden;
                padding: 0;
                position: absolute;
                width: 1px;
            }

            .ui-helper-reset {
                margin: 0;
                padding: 0;
                border: 0;
                outline: 0;
                line-height: 1.3;
                text-decoration: none;
                font-size: 100%;
                list-style: none;
            }

            .ui-helper-clearfix:before,
            .ui-helper-clearfix:after {
                content: "";
                display: table;
                border-collapse: collapse;
            }

            .ui-helper-clearfix:after {
                clear: both;
            }

            .ui-helper-zfix {
                width: 100%;
                height: 100%;
                top: 0;
                left: 0;
                position: absolute;
                opacity: 0;
                filter: Alpha(Opacity=0); /* support: IE8 */
            }

            .ui-front {
                z-index: 1070;
            }


            /* Interaction Cues
----------------------------------*/
            .ui-state-disabled {
                cursor: default !important;
                pointer-events: none;
            }


            /* Icons
----------------------------------*/
            .ui-icon {
                display: inline-block;
                vertical-align: middle;
                margin-top: -.25em;
                position: relative;
                text-indent: -99999px;
                overflow: hidden;
                background-repeat: no-repeat;
            }

            .ui-widget-icon-block {
                left: 50%;
                margin-left: -8px;
                display: block;
            }

            /* Misc visuals
----------------------------------*/

            /* Overlays */
            .ui-widget-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
            }

            .ui-autocomplete {
                position: absolute;
                top: 0;
                left: 0;
                cursor: default;
            }

            .ui-menu {
                list-style: none;
                padding: 0;
                margin: 0;
                display: block;
                outline: 0;
            }

                .ui-menu .ui-menu {
                    position: absolute;
                }

                .ui-menu .ui-menu-item {
                    margin: 0;
                    cursor: pointer;
                    /* support: IE10, see #8844 */
                    list-style-image: url("data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7");
                }

                .ui-menu .ui-menu-item-wrapper {
                    position: relative;
                    padding: 3px 1em 3px .4em;
                    display: block;
                    width: 100%;
                    border: 1px solid #ccc;
                }

                .ui-menu .ui-menu-divider {
                    margin: 5px 0;
                    height: 0;
                    font-size: 0;
                    line-height: 0;
                    border-width: 1px 0 0 0;
                }

                .ui-menu .ui-state-focus,
                .ui-menu .ui-state-active {
                    margin: -1px;
                }

            /* icon support */
            .ui-menu-icons {
                position: relative;
            }

                .ui-menu-icons .ui-menu-item-wrapper {
                    padding-left: 2em;
                }

            /* left-aligned */
            .ui-menu .ui-icon {
                position: absolute;
                top: 0;
                bottom: 0;
                left: .2em;
                margin: auto 0;
            }

            /* right-aligned */
            .ui-menu .ui-menu-icon {
                left: auto;
                right: 0;
            }

            /* Component containers
----------------------------------*/
            .ui-widget {
                font-family: Arial,Helvetica,sans-serif;
                font-size: 1em;
            }

                .ui-widget .ui-widget {
                    font-size: 1em;
                }

                .ui-widget input,
                .ui-widget select,
                .ui-widget textarea,
                .ui-widget button {
                    font-family: Arial,Helvetica,sans-serif;
                    font-size: 1em;
                }

                .ui-widget.ui-widget-content {
                    border: 1px solid #c5c5c5;
                }

            .ui-widget-content {
                border: 1px solid #dddddd;
                background: #ffffff;
                color: #333333;
            }

                .ui-widget-content a {
                    color: #333333;
                }

            .ui-widget-header {
                border: 1px solid #dddddd;
                background: #e9e9e9;
                color: #333333;
                font-weight: bold;
            }

                .ui-widget-header a {
                    color: #333333;
                }

                /* Interaction states
----------------------------------*/
                .ui-state-default,
                .ui-widget-content .ui-state-default,
                .ui-widget-header .ui-state-default,
                .ui-button,
                /* We use html here because we need a greater specificity to make sure disabled
works properly when clicked or hovered */
                html .ui-button.ui-state-disabled:hover,
                html .ui-button.ui-state-disabled:active {
                    border: 1px solid #c5c5c5;
                    background: #f6f6f6;
                    font-weight: normal;
                    color: #454545;
                }

                    .ui-state-default a,
                    .ui-state-default a:link,
                    .ui-state-default a:visited,
                    a.ui-button,
                    a:link.ui-button,
                    a:visited.ui-button,
                    .ui-button {
                        color: #454545;
                        text-decoration: none;
                    }

                        .ui-state-hover,
                        .ui-widget-content .ui-state-hover,
                        .ui-widget-header .ui-state-hover,
                        .ui-state-focus,
                        .ui-widget-content .ui-state-focus,
                        .ui-widget-header .ui-state-focus,
                        .ui-button:hover,
                        .ui-button:focus {
                            border: 1px solid #cccccc;
                            background: #ededed;
                            font-weight: normal;
                            color: #2b2b2b;
                        }

                            .ui-state-hover a,
                            .ui-state-hover a:hover,
                            .ui-state-hover a:link,
                            .ui-state-hover a:visited,
                            .ui-state-focus a,
                            .ui-state-focus a:hover,
                            .ui-state-focus a:link,
                            .ui-state-focus a:visited,
                            a.ui-button:hover,
                            a.ui-button:focus {
                                color: #2b2b2b;
                                text-decoration: none;
                            }

            .ui-visual-focus {
                box-shadow: 0 0 3px 1px rgb(94, 158, 214);
            }

            .ui-state-active,
            .ui-widget-content .ui-state-active,
            .ui-widget-header .ui-state-active,
            a.ui-button:active,
            .ui-button:active,
            .ui-button.ui-state-active:hover {
                border: 1px solid #003eff;
                background: #007fff;
                font-weight: normal;
                color: #ffffff;
            }

                .ui-icon-background,
                .ui-state-active .ui-icon-background {
                    border: #003eff;
                    background-color: #ffffff;
                }

                .ui-state-active a,
                .ui-state-active a:link,
                .ui-state-active a:visited {
                    color: #ffffff;
                    text-decoration: none;
                }

            /* Interaction Cues
----------------------------------*/
            .ui-state-highlight,
            .ui-widget-content .ui-state-highlight,
            .ui-widget-header .ui-state-highlight {
                border: 1px solid #dad55e;
                background: #fffa90;
                color: #777620;
            }

            .ui-state-checked {
                border: 1px solid #dad55e;
                background: #fffa90;
            }

            .ui-state-highlight a,
            .ui-widget-content .ui-state-highlight a,
            .ui-widget-header .ui-state-highlight a {
                color: #777620;
            }

            .ui-state-error,
            .ui-widget-content .ui-state-error,
            .ui-widget-header .ui-state-error {
                border: 1px solid #f1a899;
                background: #fddfdf;
                color: #5f3f3f;
            }

                .ui-state-error a,
                .ui-widget-content .ui-state-error a,
                .ui-widget-header .ui-state-error a {
                    color: #5f3f3f;
                }

            .ui-state-error-text,
            .ui-widget-content .ui-state-error-text,
            .ui-widget-header .ui-state-error-text {
                color: #5f3f3f;
            }

            .ui-priority-primary,
            .ui-widget-content .ui-priority-primary,
            .ui-widget-header .ui-priority-primary {
                font-weight: bold;
            }

            .ui-priority-secondary,
            .ui-widget-content .ui-priority-secondary,
            .ui-widget-header .ui-priority-secondary {
                opacity: .7;
                filter: Alpha(Opacity=70); /* support: IE8 */
                font-weight: normal;
            }

            .ui-state-disabled,
            .ui-widget-content .ui-state-disabled,
            .ui-widget-header .ui-state-disabled {
                opacity: .35;
                filter: Alpha(Opacity=35); /* support: IE8 */
                background-image: none;
            }

                .ui-state-disabled .ui-icon {
                    filter: Alpha(Opacity=35); /* support: IE8 - See #6059 */
                }


            /* Misc visuals
----------------------------------*/

            /* Corner radius */
            .ui-corner-all,
            .ui-corner-top,
            .ui-corner-left,
            .ui-corner-tl {
                border-top-left-radius: 3px;
            }

            .ui-corner-all,
            .ui-corner-top,
            .ui-corner-right,
            .ui-corner-tr {
                border-top-right-radius: 3px;
            }

            .ui-corner-all,
            .ui-corner-bottom,
            .ui-corner-left,
            .ui-corner-bl {
                border-bottom-left-radius: 3px;
            }

            .ui-corner-all,
            .ui-corner-bottom,
            .ui-corner-right,
            .ui-corner-br {
                border-bottom-right-radius: 3px;
            }

            /* Overlays */
            .ui-widget-overlay {
                background: #aaaaaa;
                opacity: .3;
                filter: Alpha(Opacity=30); /* support: IE8 */
            }

            .ui-widget-shadow {
                -webkit-box-shadow: 0px 0px 5px #666666;
                box-shadow: 0px 0px 5px #666666;
            }
        </style>

        <script type="text/javascript">
            $(document).ready(function () {
                $("#satinalma_alttoplamtl").val($("#satinalma_alttoplamtl").val().replace(".", ""));
                $("#satinalma_alttoplamusd").val($("#satinalma_alttoplamusd").val().replace(".", ""));
                $("#satinalma_alttoplameur").val($("#satinalma_alttoplameur").val().replace(".", ""));
            });
        </script>
        <script src="/js/jquery-ui.js"></script>

    </form>
    <%
    elseif trn(request("islem"))="yeni_uretim_sablonu_ekle" then
    %>
    <div class="modal-header">
        Üretim Şablonu Ekle
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
    </div>
    <form id="koftiform"></form>
    <form autocomplete="off" id="uretimsablonuekle" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">

        <div class="row">
            <label class="col-sm-12 col-form-label">Üretim Şablonu Kayıt Adı :</label>
            <div class="col-sm-12">
                <input type="text" name="sablon_adi" id="sablon_adi" class="form-control required" required />
            </div>
        </div>

        <div class="modal-footer">
            <input type="button" class="btn btn-primary" onclick="UretimSablonuKayit();" value="Üretim Şablonu Ekle" />
        </div>

    </form>
    <%

elseif trn(request("islem"))="uretim_sablonlari" then


     if trn(request("islem2"))="ekle" then

            sablon_adi = trn(request("sablon_adi"))

            durum = "true"
            cop = "false"
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time

            SQL="insert into uretim_sablonlari(sablon_adi, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& sablon_adi &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
            set ekle = baglanti.execute(SQL)

        elseif trn(request("islem2"))="sil" then

            sablon_id = trn(request("sablon_id"))

            SQL="update uretim_sablonlari set cop='true' where id = '"& sablon_id &"' and firma_id = '"& FirmaID &"'"
            set sil = baglanti.execute(SQL)

        end if


    %>

    <div class="card-block accordion-block color-accordion-block p-3">
        <div>
            <div>
                <%
                    SQL="select * from uretim_sablonlari where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and cop = 'false'"
                    set sablon = baglanti.execute(SQL)
                    if sablon.eof then
                %>
                <div class="well">
                    <br />
                    <br />
                    <center>Üretim Şablon Kaydı Bulunamadı</center>
                    <br />
                    <br />
                </div>

                <% else %>
                <div class="color-accordion" id="color-accordion">
                    <%
                        x = 0
                        do while not sablon.eof
                            x = x + 1
                    %>
                    <a class="accordion-msg ustunegelince" href="#collapseOne<%=sablon("id") %>" onclick="UretimSablonDetayGetir('<%=sablon("id") %>');" id="acilacak_santiye<%=sablon("id") %>" style="color: #4f4e4e; border-top: 1px solid #fff; font-weight: normal;"><i class="fa fa-map-o projeikon"></i>&nbsp;&nbsp;<%=sablon("sablon_adi") %>

                        <div style="float: right; width: 50px; padding: 6px; text-align: center; -webkit-border-radius: 10px; -moz-border-radius: 10px; border-radius: 10px; margin-top: -30px; position: absolute; right: 15px; background-color: transparent">
                            <div class="pcoded-badge label" style="width: 35px; font-size: 100%;">
                                <i onclick="sablon_sil(<%=sablon("id") %>);" class="ti-trash" style="color: black; background: transparent; font-size: 20px" tabindex="1"></i>
                            </div>
                        </div>
                    </a>

                    <div class="accordion-desc">
                        <div id="accoric<%=sablon("id") %>">
                        </div>
                    </div>

                    <%
                        sablon.movenext
                        loop
                    %>
                </div>


                <% end if %>
            </div>
        </div>
    </div>
    <%
    elseif trn(request("islem"))="UretimSablonDetayGetir" then

        Id = trn(request("Id"))
    %>
    <script>
        $(function (){
            $("#planframe").css("height", parseInt(window.height)-500);
        });
    </script>
    <iframe id="planframe" src="/system_root/santiyeler/uretim_sablon_frame.asp?jsid=4559&proje_id=<%=Id %>&tip=planlama" style="width: 100%; height: 1050px; overflow: scroll; border: none;"></iframe>
    <%
    elseif trn(request("islem"))="proje_sablonlara_kaydet" then

        proje_id = trn(request("proje_id"))

    %>
    <div class="modal-header">
        Proje Planını Üretim Şablonlarına Kopyala
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <form autocomplete="off" id="uretimsablonuekle" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
        <div class="row">
            <label class="col-sm-12 col-form-label">Üretim Şablonu Kayıt Adı :</label>
            <div class="col-sm-12">
                <input type="text" name="sablon_adi" id="sablon_adi" class="form-control required" required />
            </div>
        </div>
        <div class="modal-footer">
            <input type="button" class="btn btn-primary" onclick="proje_sablonlara_kayit('<%=proje_id%>');" value="Üretim Şablonu Ekle" />
        </div>
    </form>
    <% 
    elseif trn(request("islem"))="proje_sablonlara_kayit" then

        proje_id = trn(request("proje_id"))
        sablon_adi = trn(request("sablon_adi"))

        durum = "true"
        cop = "false"
        firma_kodu = Request.Cookies("kullanici")("firma_kodu")
        firma_id = Request.Cookies("kullanici")("firma_id")
        ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
        ekleyen_ip = Request.ServerVariables("Remote_Addr")
        ekleme_tarihi = date
        ekleme_saati = time

        SQL="SET NOCOUNT ON; insert into uretim_sablonlari(sablon_adi, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& sablon_adi &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"'); select SCOPE_IDENTITY();"
        set ekle = baglanti.execute(SQL)

        SablonId = ekle(0)

        SQL="Execute [dbo].[SablonProjeEkle] @ProjeId = '"& proje_id &"', @SablonId = '"& SablonId &"';"
        set ekle = baglanti.execute(SQL)

    elseif trn(request("islem"))="YeniTekliBakimKaydiEkle" then

    %>
    <div class="modal-header">
        Yeni Servis-Bakım Kaydı Planla
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <form autocomplete="off" id="uretimsablonuekle" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">

        <div class="row">
            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Proje")%></label>
            <div class="col-sm-12 col-lg-12">
                <select id="proje_id" name="proje_id" class="select2">
                    <%
                        SQL="select id, proje_adi from ucgem_proje_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and cop = 'false' order by proje_adi asc"
                        set proje = baglanti.execute(SQL)
                        do while not proje.eof
                    %>
                    <option value="<%=proje("id") %>"><%=proje("proje_adi") %></option>
                    <%
                        proje.movenext
                        loop
                    %>
                </select>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12 col-lg-12">

                <div class="row toplanti_tipi rutin" style="display: nones; margin-top: 10px;">
                    <div class="col-sm-6">
                        <label class="col-form-label"><%=LNG("Yineleme Başlangıç Tarihi :")%></label>
                        <div class="input-group input-group-primary">
                            <span class="input-group-addon">
                                <i class="icon-prepend fa fa-user"></i>
                            </span>
                            <input type="text" id="yineleme_baslangic" name="yineleme_baslangic" class="form-control takvimyap required" required />
                            <script>
                                $("#yineleme_baslangic").val(new Date().toLocaleDateString());
                                $("#yineleme_bitis").val(new Date().toLocaleDateString());
                            </script>
                        </div>
                    </div>

                    <div class="col-sm-6">
                        <label class="col-form-label"><%=LNG("Yineleme Bitiş Tarihi :")%></label>
                        <div class="input-group input-group-primary">
                            <span class="input-group-addon">
                                <i class="icon-prepend fa fa-user"></i>
                            </span>
                            <input type="text" id="yineleme_bitis" name="yineleme_bitis" class="form-control takvimyap required" required />
                        </div>
                    </div>
                </div>


                <div class="row toplanti_tipi rutin" style="display: nones;">
                    <label class="col-sm-12 col-form-label"><%=LNG("Yineleme Dönemi :")%></label>
                    <div class="col-sm-3">
                        <table>
                            <tr>
                                <td>
                                    <input type="radio" checked="checked" class="yineleme_donemi" name="yineleme_donemi" id="yineleme_donemi1" onclick="toplanti_ekle_yineleme_donemi(this);" value="gunluk" checkeds="checkeds" /></td>
                                <td>
                                    <label for="yineleme_donemi1"><%=LNG("Günlük")%></label></td>
                            </tr>
                            <tr>
                                <td style="padding-top: 5px;">
                                    <input type="radio" class="yineleme_donemi" id="yineleme_donemi2" onclick="toplanti_ekle_yineleme_donemi(this);" value="haftalik" name="yineleme_donemi" /></td>
                                <td style="padding-top: 5px;">
                                    <label for="yineleme_donemi2"><%=LNG("Haftalık")%></label></td>
                            </tr>
                            <tr>
                                <td style="padding-top: 5px;">
                                    <input type="radio" class="yineleme_donemi" id="yineleme_donemi3" onclick="toplanti_ekle_yineleme_donemi(this);" value="aylik" name="yineleme_donemi" /></td>
                                <td style="padding-top: 5px;">
                                    <label for="yineleme_donemi3"><%=LNG("Aylık")%></label></td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-sm-9" style="border-left: 1px solid #e8e8e8;">
                        <div class="yineleme_yerleri gunluk_yineleme">
                            <table>
                                <tr>
                                    <td>
                                        <input type="radio" checked="checked" checkeds="checkeds" name="gunluk_yineleme_secim" id="gunluk_yineleme_secim1" onclick="radio_tikle(this);" value="gunluk" /></td>
                                    <td><%=LNG("Her")%> </td>
                                    <td>
                                        <input type="text" required value="1" name="gunluk_yineleme_gun_aralik" id="gunluk_yineleme_gun_aralik1" style="width: 35px; text-align: center;" class="numericonly required" /></td>
                                    <td><%=LNG("günde bir")%> </td>
                                </tr>
                                <tr>
                                    <td style="padding-top: 10px;">
                                        <input type="radio" name="gunluk_yineleme_secim" id="gunluk_yineleme_secim2" onclick="radio_tikle(this);" value="is_gunu" /></td>
                                    <td style="padding-top: 10px;" colspan="3"><%=LNG("Her İş Günü")%></td>
                                </tr>
                            </table>
                        </div>
                        <div class="yineleme_yerleri haftalik_yineleme" style="width: 100%; display: none;">
                            <table style="width: 100%;">
                                <tr>
                                    <td><%=LNG("Her")%></td>
                                    <td>
                                        <input required type="text" name="haftalik_yineleme_sikligi" id="haftalik_yineleme_sikligi" value="1" style="width: 35px; text-align: center;" class="numericonly required" /></td>
                                    <td><%=LNG("haftada bir yenile")%></td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <div style="width: 100%; padding-top: 15px;">
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td><%=LNG("Pzt")%><br />
                                                        <label class="onoffswitch-label" id="dst4_label">
                                                            <input type="checkbox" value="2" class="js-switch dhaftalik_gunler" id="dst4" name="dhaftalik_gunler" />
                                                        </label>
                                                    </td>
                                                    <td><%=LNG("Sal")%><br />
                                                        <label class="onoffswitch-label" id="dst5_label">
                                                            <input type="checkbox" value="3" class="js-switch dhaftalik_gunler" id="dst5" name="dhaftalik_gunler" />
                                                        </label>
                                                    </td>
                                                    <td><%=LNG("Çar")%><br />
                                                        <label class="onoffswitch-label" id="dst6_label">
                                                            <input type="checkbox" value="4" class="js-switch dhaftalik_gunler" id="dst6" name="dhaftalik_gunler" />
                                                        </label>
                                                    </td>
                                                    <td><%=LNG("Per")%><br />
                                                        <label class="onoffswitch-label" id="dst7_label">
                                                            <input type="checkbox" value="5" class="js-switch dhaftalik_gunler" id="dst7" name="dhaftalik_gunler" />
                                                        </label>
                                                    </td>
                                                    <td><%=LNG("Cum")%><br />
                                                        <label class="onoffswitch-label" id="dst8_label">
                                                            <input type="checkbox" value="6" class="js-switch dhaftalik_gunler" id="dst8" name="dhaftalik_gunler" />
                                                        </label>
                                                    </td>
                                                    <td><%=LNG("Cmt")%><br />
                                                        <label class="onoffswitch-label" id="dst9_label">
                                                            <input type="checkbox" value="7" class="js-switch dhaftalik_gunler" id="dst9" name="dhaftalik_gunler" />
                                                        </label>
                                                    </td>
                                                    <td><%=LNG("Pzr")%><br />
                                                        <label class="onoffswitch-label" id="dst10_label">
                                                            <input type="checkbox" value="1" class="js-switch dhaftalik_gunler" id="dst10" name="dhaftalik_gunler" />
                                                        </label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <div class="yineleme_yerleri aylik_yineleme" style="width: 100%; display: none;">
                            <table>
                                <tr>
                                    <td>
                                        <input type="radio" name="aylik_yenileme_tipi" id="aylik_yenileme_tipi1" onclick="radio_tikle(this);" value="1" checked="checked" checkeds="checkeds" /></td>
                                    <td style="width: 37px;"><%=LNG("Her")%></td>
                                    <td>
                                        <input type="text" value="1" name="aylik_gun" id="aylik_gun" style="width: 35px; text-align: center;" required class="numericonly required" /></td>
                                    <td style="width: 65px;"><%=LNG(". günü")%></td>
                                    <td>
                                        <input type="text" value="1" style="width: 35px; text-align: center;" name="aylik_aralik" id="aylik_aralik" class="numericonly" required /></td>
                                    <td><%=LNG("ayda bir")%></td>
                                </tr>
                            </table>
                            <br />
                            <table>
                                <tr>
                                    <td>
                                        <input type="radio" name="aylik_yenileme_tipi" id="aylik_yenileme_tipi2" onclick="radio_tikle(this);" value="2" /></td>
                                    <td style="width: 37px;"><%=LNG("Her")%></td>
                                    <td>
                                        <select name="aylik_yineleme1" id="aylik_yineleme1" class="yapilan">
                                            <option value="1"><%=LNG("birinci")%></option>
                                            <option value="2"><%=LNG("ikinci")%></option>
                                            <option value="3"><%=LNG("üçüncü")%></option>
                                            <option value="4"><%=LNG("dördüncü")%></option>
                                            <option value="son"><%=LNG("son")%></option>
                                        </select></td>
                                    <td style="padding-left: 8px;">
                                        <select name="aylik_yineleme2" id="aylik_yineleme2" class="yapilan">
                                            <option value="gün"><%=LNG("gün")%></option>
                                            <option value="2"><%=LNG("pazartesi")%></option>
                                            <option value="3"><%=LNG("salı")%></option>
                                            <option value="4"><%=LNG("çarşamba")%></option>
                                            <option value="5"><%=LNG("perşembe")%></option>
                                            <option value="6"><%=LNG("cuma")%></option>
                                            <option value="7"><%=LNG("cumartesi")%></option>
                                            <option value="1"><%=LNG("pazar")%></option>
                                        </select></td>
                                    <td><%=LNG("günü")%></td>

                                </tr>

                            </table>

                        </div>
                    </div>
                </div>
            </div>


        </div>
        <div class="modal-footer">
            <input type="button" class="btn btn-primary" onclick="ProjeBakimKaydiEkle(0, 'true');" value="Periyodik Servis/Bakım Planı Ekle" />
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#proje_id").select2({
                    dropdownParent: $("#modal_div")
                });
            });
        </script>
    </form>
    <%

    elseif trn(request("islem")) = "YeniServisBakimKaydiEkle" then
    %>

    <div class="modal-header">
        Yeni Servis Bakım Kaydı
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <form autocomplete="off" id="servisbakimkaydi" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
        <script type="text/javascript">
            $(function () {
                parcalar_autocomplete_calistir3();
            });

            if ($(window).width() < 500) {
                $("#baslangicDiv").removeAttr("style");
                $("#bitisDiv").removeAttr("style");
            }
        </script>
        <div class="row">
            <label class="col-sm-11  col-lg-11 col-form-label"><%=LNG("Müşteri")%></label>
            <div class="col-sm-11 col-lg-11">
                <select id="musteri_id" name="musteri_id" class="select2" onchange="musteribilgilerial('new');">
                    <option disabled selected>Müşteri Seç</option>
                    <%
                        SQL="select id, firma_adi, firma_yetkili from ucgem_firma_listesi where yetki_kodu = 'MUSTERI' and durum = 'true' and cop = 'false' and ekleyen.firma_id = '"& FirmaID &"'"
                        set musteri = baglanti.execute(SQL)
                        do while not musteri.eof
                    %>
                    <option value="<%=musteri("id") %>"><%=musteri("firma_adi") %></option>
                    <%
                        musteri.movenext
                        loop
                    %>
                </select>
            </div>
            <div class="col-md-1 col-lg-1">
                <button class="btn btn-link btn-sm" onclick="YeniMusteriOlustur();" style="margin-left: -15px; margin-top: -7px;">
                    <i class="fa fa-plus fa-2x"></i>
                </button>
            </div>
            <div class="col-md-12" id="musteriformu" style="display: none; margin-top: 10px">
                <div class="row" style="border-top: 1px solid #dedede; padding-top: 10px">
                    <label class="col-form-label col-md-12 font-weight-bold" style="text-align: left; margin-bottom: 10px">Müşteri Bilgileri</label>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label class="col-from-label">Firma Adı</label>
                            <input type="text" class="form-control" id="firmaadi" placeholder="Firma Adı" required />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12" id="textyetkili">
                        <div class="form-group">
                            <label class="col-from-label">Yetkili Kişi </label>
                            <input type="text" class="form-control" id="yetkilikisi" placeholder="Yetkili Kişi" required />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12" id="selectyetkili" style="display: none">
                        <div class="form-group">
                            <label class="col-from-label">Yetkili Kişi</label>
                            <i class="fa fa-close" id="yetkiliSelectGizle" style="cursor: pointer; margin-left: 5px"></i>
                            <select class="form-control" id="selectyetkilikisi" required style="height: 35px; padding: .4rem .75rem;"></select>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label class="col-from-label">Firma Telefon</label>
                            <input type="tel" class="form-control" id="firmatelefon" placeholder="0(555) 123 45 67"/>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label class="col-from-label">Firma E-posta</label>
                            <input class="form-control" type="email" id="firmaeposta" placeholder="example@gmail.com" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label class="col-from-label">Firma Adress</label>
                            <input class="form-control" type="text" id="firmaadress" placeholder="Adress" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label class="col-from-label">Vergi Dairesi</label>
                            <input class="form-control" type="text" id="firmavergidairesi" placeholder="Vergi Dairesi" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label class="col-from-label">Vergi No</label>
                            <input class="form-control" type="text" id="firmavergino" placeholder="Vergi No" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label class="col-from-label">Makine Bilgileri</label>
                            <input class="form-control" type="text" id="firmamakinebilgi" placeholder="Makine Bilgileri" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label class="col-from-label">Bildirilen Arıza</label>
                            <input class="form-control" type="text" id="firmaariza" placeholder="Bildirilen Arıza" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label>Başlangıç Tarihi</label>
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="icon-prepend fa fa-calendar"></i>
                                </span>
                                <input type="text" id="baslangic_tarihi" class="takvimyap form-control" style="padding-left: 10px" value="<%=FormatDate(date, "00")%>" />
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label>Bitiş Tarihi</label>
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="icon-prepend fa fa-calendar"></i>
                                </span>
                                <input type="text" id="bitis_tarihi" class="takvimyap form-control" style="padding-left: 10px" value="<%=FormatDate(date, "00")%>" />
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-6 col-xs-6" id="baslangicDiv" style="max-width: 12.5% !important; padding-right: 5px">
                        <label>Başlangıç Saati</label>
                        <div class="form-group">
                            <input type="text" id="baslangic_saati" class="timepicker form-control" style="padding-left: 10px" value="" />
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-6 col-xs-6" id="bitisDiv" style="max-width: 12.5% !important; padding-left: 5px">
                        <label>Bitiş Saati</label>
                        <div class="form-group">
                            <input type="text" id="bitis_saati" class="timepicker form-control" style="padding-left: 10px" value="" />
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6 col-xs-12">
                        <label>Proje</label>
                        <div class="form-group">
                            <select class="form-control select2" id="proje-bilgi">
                                <option selected value="0">Proje Seç</option>
                                <%
                                    SQL = "select id, proje_adi, proje_kodu from ucgem_proje_listesi where cop = 'false' and firma_id = '"& FirmaID &"'"
                                    set proje_bilgisi = baglanti.execute(SQL)

                                    do while not proje_bilgisi.eof
                                %>
                                <option value="<%=proje_bilgisi("id") %>"><%=proje_bilgisi("proje_kodu") %> - <%=proje_bilgisi("proje_adi") %></option>
                                <%
                                    proje_bilgisi.movenext
                                    loop
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label>Rapor Durumu</label>
                            <select id="firmarapordurumu" class="form-control select2" onchange="raporDurumKontrol();">
                                <option selected value="">Durum Seç</option>
                                <option value="Faturası Kesildi">Faturası Kesildi</option>
                                <option value="Faturası Kesilecek">Faturası Kesilecek</option>
                                <option value="Garanti Kapsamında">Garanti Kapsamında</option>
                            </select>
                        </div>
                        <div class="form-group" id="faturagorevli" style="display:none">
                            <label>Personel</label>
                            <select id="personelbildirim" class="form-control select2">
                                <option selected value="0">Personel Seç</option>
                                <%
                                    SQL = "select id, personel_ad + ' ' + personel_soyad as ad_soyad from ucgem_firma_kullanici_listesi where cop = 'false' and firma_id = '"& FirmaID &"'"
                                    set user = baglanti.execute(SQL)

                                    if not user.eof then
                                    do while not user.eof
                                %>
                                <option value="<%=user("id") %>"><%=user("ad_soyad") %></option>
                                <%
                                    user.movenext
                                    loop
                                    end if
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label>Görevli</label>
                            <select id="firmagorevli" class="form-control select2" multiple required>
                                <%
                                    SQL = "select id, personel_ad + ' ' + personel_soyad as adsoyad from ucgem_firma_kullanici_listesi where durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"'"
                                    set kullanicilar = baglanti.execute(SQL)
                                    do while not kullanicilar.eof
                                %>
                                <option value="<%=kullanicilar("id") %>"><%=kullanicilar("adsoyad") %></option>
                                <%
                                    kullanicilar.movenext
                                    loop        
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label class="col-from-label">Yapılan İşlemler</label>
                            <textarea class="form-control" id="firmayapilanislemler" placeholder="Yapılan İşlemler" style="min-height: 100px"></textarea>
                        </div>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label class="col-from-label">Not</label>
                            <textarea class="form-control" id="firmanot" placeholder="Not" style="min-height: 100px"></textarea>
                        </div>
                    </div>
                </div>


                <div class="row" style="border-top: 1px solid #dedede; padding-top: 10px;" id="parcaTable">
                    <div class="col-md-4 col-sm-4 col-xs-8">
                        <div class="form-group">
                            <label class="font-weight-bold">Parça Adı</label>
                            <input type="text" name="parcalar" form_id="" id="parcalar1" i="<1" data="0" class="form-control parcalar" />
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-2 col-xs-4">
                        <div class="form-group">
                            <label class="font-weight-bold">Adet</label>
                            <input type="number" class="form-control adeti" name="musteriparcaadeti" id="musteriparcaadeti" min="1" value="1" />
                        </div>
                    </div>
                    <div class="col-md-12 col-sm-12 col-xs-12 col-lg-12">
                        <label class="col-form-label font-weight-bold" style="margin-bottom: 10px">Stok Listesi</label>
                        <table id="servisformParcalar" class="table table-bordered table-sm table-sprited">
                            <thead>
                                <tr>
                                    <th>Parça</th>
                                    <th>Adet</th>
                                    <!--<th>Sipariş Durumu</th>-->
                                    <th>Maliyet</th>
                                    <th>Açıklama</th>
                                    <th>Işlem</th>
                                </tr>
                            </thead>
                            <tbody id="stoklist">
                                <tr id="SumPriceRow">
                                    <td colspan="2" style="text-align: right; font-weight: 700;"><span>Tolam Maliyet</span></td>
                                    <td colspan="1" id="totalPrice">0 TL - 0 USD - 0 EUR</td>
                                    <td colspan="2"></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <div class="form-group" style="margin-right: 35px; margin-top: auto; margin-bottom: auto; display: none" id="tabloyaekle">
                <div class="form-check">
                    <label class="form-check-label" style="padding-left: 1px" for="listeyeekle">Müşteri Listesine Kaydet</label>
                    <input type="checkbox" class="form-check-input" style="margin-left: 10px; margin-top: 3px; cursor: pointer" id="listeyeekle">
                </div>
            </div>
            <input type="hidden" id="servisparca" parcaid="" adet="" />
            <input type="hidden" id="siparisformu" siparisparcaid="" stokparcaid="" />
            <input type="submit" class="btn btn-primary" onclick="ServisBakimKaydiEkle();" value="Servis Ekle" />
        </div>
        <style>
            .ui-helper-hidden {
                display: none;
            }

            .ui-helper-hidden-accessible {
                border: 0;
                clip: rect(0 0 0 0);
                height: 1px;
                margin: -1px;
                overflow: hidden;
                padding: 0;
                position: absolute;
                width: 1px;
            }

            .ui-helper-reset {
                margin: 0;
                padding: 0;
                border: 0;
                outline: 0;
                line-height: 1.3;
                text-decoration: none;
                font-size: 100%;
                list-style: none;
            }

            .ui-helper-clearfix:before,
            .ui-helper-clearfix:after {
                content: "";
                display: table;
                border-collapse: collapse;
            }

            .ui-helper-clearfix:after {
                clear: both;
            }

            .ui-helper-zfix {
                width: 100%;
                height: 100%;
                top: 0;
                left: 0;
                position: absolute;
                opacity: 0;
                filter: Alpha(Opacity=0); /* support: IE8 */
            }

            .ui-front {
                z-index: 1070;
            }


            /* Interaction Cues
----------------------------------*/
            .ui-state-disabled {
                cursor: default !important;
                pointer-events: none;
            }


            /* Icons
----------------------------------*/
            .ui-icon {
                display: inline-block;
                vertical-align: middle;
                margin-top: -.25em;
                position: relative;
                text-indent: -99999px;
                overflow: hidden;
                background-repeat: no-repeat;
            }

            .ui-widget-icon-block {
                left: 50%;
                margin-left: -8px;
                display: block;
            }

            /* Misc visuals
----------------------------------*/

            /* Overlays */
            .ui-widget-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
            }

            .ui-autocomplete {
                position: absolute;
                top: 0;
                left: 0;
                cursor: default;
            }

            .ui-menu {
                list-style: none;
                padding: 0;
                margin: 0;
                display: block;
                outline: 0;
            }

                .ui-menu .ui-menu {
                    position: absolute;
                }

                .ui-menu .ui-menu-item {
                    display: flex;
                    margin: 0;
                    cursor: pointer;
                    /* support: IE10, see #8844 */
                    list-style-image: url("data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7");
                }

                .ui-menu .ui-menu-item-wrapper {
                    position: relative;
                    padding: 3px 1em 3px .4em;
                    display: block;
                    width: 100%;
                    border: 1px solid #ccc;
                }

                .ui-menu .ui-menu-divider {
                    margin: 5px 0;
                    height: 0;
                    font-size: 0;
                    line-height: 0;
                    border-width: 1px 0 0 0;
                }

                .ui-menu .ui-state-focus,
                .ui-menu .ui-state-active {
                    margin: -1px;
                }

            /* icon support */
            .ui-menu-icons {
                position: relative;
            }

                .ui-menu-icons .ui-menu-item-wrapper {
                    padding-left: 2em;
                }

            /* left-aligned */
            .ui-menu .ui-icon {
                position: absolute;
                top: 0;
                bottom: 0;
                left: .2em;
                margin: auto 0;
            }

            /* right-aligned */
            .ui-menu .ui-menu-icon {
                left: auto;
                right: 0;
            }

            /* Component containers
----------------------------------*/
            .ui-widget {
                font-family: Arial,Helvetica,sans-serif;
                font-size: 1em;
            }

                .ui-widget .ui-widget {
                    font-size: 1em;
                }

                .ui-widget input,
                .ui-widget select,
                .ui-widget textarea,
                .ui-widget button {
                    font-family: Arial,Helvetica,sans-serif;
                    font-size: 1em;
                }

                .ui-widget.ui-widget-content {
                    border: 1px solid #c5c5c5;
                }

            .ui-widget-content {
                border: 1px solid #dddddd;
                background: #ffffff;
                color: #333333;
            }

                .ui-widget-content a {
                    color: #333333;
                }

            .ui-widget-header {
                border: 1px solid #dddddd;
                background: #e9e9e9;
                color: #333333;
                font-weight: bold;
            }

                .ui-widget-header a {
                    color: #333333;
                }

                /* Interaction states
----------------------------------*/
                .ui-state-default,
                .ui-widget-content .ui-state-default,
                .ui-widget-header .ui-state-default,
                .ui-button,
                /* We use html here because we need a greater specificity to make sure disabled
works properly when clicked or hovered */
                html .ui-button.ui-state-disabled:hover,
                html .ui-button.ui-state-disabled:active {
                    border: 1px solid #c5c5c5;
                    background: #f6f6f6;
                    font-weight: normal;
                    color: #454545;
                }

                    .ui-state-default a,
                    .ui-state-default a:link,
                    .ui-state-default a:visited,
                    a.ui-button,
                    a:link.ui-button,
                    a:visited.ui-button,
                    .ui-button {
                        color: #454545;
                        text-decoration: none;
                    }

                        .ui-state-hover,
                        .ui-widget-content .ui-state-hover,
                        .ui-widget-header .ui-state-hover,
                        .ui-state-focus,
                        .ui-widget-content .ui-state-focus,
                        .ui-widget-header .ui-state-focus,
                        .ui-button:hover,
                        .ui-button:focus {
                            border: 1px solid #cccccc;
                            background: #ededed;
                            font-weight: normal;
                            color: #2b2b2b;
                        }

                            .ui-state-hover a,
                            .ui-state-hover a:hover,
                            .ui-state-hover a:link,
                            .ui-state-hover a:visited,
                            .ui-state-focus a,
                            .ui-state-focus a:hover,
                            .ui-state-focus a:link,
                            .ui-state-focus a:visited,
                            a.ui-button:hover,
                            a.ui-button:focus {
                                color: #2b2b2b;
                                text-decoration: none;
                            }

            .ui-visual-focus {
                box-shadow: 0 0 3px 1px rgb(94, 158, 214);
            }

            .ui-state-active,
            .ui-widget-content .ui-state-active,
            .ui-widget-header .ui-state-active,
            a.ui-button:active,
            .ui-button:active,
            .ui-button.ui-state-active:hover {
                border: 1px solid #003eff;
                background: #007fff;
                font-weight: normal;
                color: #ffffff;
            }

                .ui-icon-background,
                .ui-state-active .ui-icon-background {
                    border: #003eff;
                    background-color: #ffffff;
                }

                .ui-state-active a,
                .ui-state-active a:link,
                .ui-state-active a:visited {
                    color: #ffffff;
                    text-decoration: none;
                }

            /* Interaction Cues
----------------------------------*/
            .ui-state-highlight,
            .ui-widget-content .ui-state-highlight,
            .ui-widget-header .ui-state-highlight {
                border: 1px solid #dad55e;
                background: #fffa90;
                color: #777620;
            }

            .ui-state-checked {
                border: 1px solid #dad55e;
                background: #fffa90;
            }

            .ui-state-highlight a,
            .ui-widget-content .ui-state-highlight a,
            .ui-widget-header .ui-state-highlight a {
                color: #777620;
            }

            .ui-state-error,
            .ui-widget-content .ui-state-error,
            .ui-widget-header .ui-state-error {
                border: 1px solid #f1a899;
                background: #fddfdf;
                color: #5f3f3f;
            }

                .ui-state-error a,
                .ui-widget-content .ui-state-error a,
                .ui-widget-header .ui-state-error a {
                    color: #5f3f3f;
                }

            .ui-state-error-text,
            .ui-widget-content .ui-state-error-text,
            .ui-widget-header .ui-state-error-text {
                color: #5f3f3f;
            }

            .ui-priority-primary,
            .ui-widget-content .ui-priority-primary,
            .ui-widget-header .ui-priority-primary {
                font-weight: bold;
            }

            .ui-priority-secondary,
            .ui-widget-content .ui-priority-secondary,
            .ui-widget-header .ui-priority-secondary {
                opacity: .7;
                filter: Alpha(Opacity=70); /* support: IE8 */
                font-weight: normal;
            }

            .ui-state-disabled,
            .ui-widget-content .ui-state-disabled,
            .ui-widget-header .ui-state-disabled {
                opacity: .35;
                filter: Alpha(Opacity=35); /* support: IE8 */
                background-image: none;
            }

                .ui-state-disabled .ui-icon {
                    filter: Alpha(Opacity=35); /* support: IE8 - See #6059 */
                }


            /* Misc visuals
----------------------------------*/

            /* Corner radius */
            .ui-corner-all,
            .ui-corner-top,
            .ui-corner-left,
            .ui-corner-tl {
                border-top-left-radius: 3px;
            }

            .ui-corner-all,
            .ui-corner-top,
            .ui-corner-right,
            .ui-corner-tr {
                border-top-right-radius: 3px;
            }

            .ui-corner-all,
            .ui-corner-bottom,
            .ui-corner-left,
            .ui-corner-bl {
                border-bottom-left-radius: 3px;
            }

            .ui-corner-all,
            .ui-corner-bottom,
            .ui-corner-right,
            .ui-corner-br {
                border-bottom-right-radius: 3px;
            }

            /* Overlays */
            .ui-widget-overlay {
                background: #aaaaaa;
                opacity: .3;
                filter: Alpha(Opacity=30); /* support: IE8 */
            }

            .ui-widget-shadow {
                -webkit-box-shadow: 0px 0px 5px #666666;
                box-shadow: 0px 0px 5px #666666;
            }
        </style>
        <script type="text/javascript">
            $("#yetkiliSelectGizle").click(function () {
                $("#selectyetkili").hide();
                $("#textyetkili").show();
            });

            $(document).ready(function () {
                $("#musteri_id, #proje-bilgi, #firmarapordurumu, #personelbildirim").select2({
                    dropdownParent: $("#modal_div3")
                });
            });
        </script>
    </form>
    <%
        elseif trn(request("islem"))="YeniServisBakimKaydiDuzenle" then
            kayitId = trn(request("kayitId"))
            durum = "true"
            cop = "false"

            SQL="select * from servis_bakim_kayitlari where Durum = '"& durum &"' and Cop = '"& cop &"' and id = '"& kayitId &"' and firma_id = '"& FirmaID &"'"
            set formduzenle = baglanti.execute(SQL)
    %>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#musteriformu").slideDown();
        });

        $("#musteri_id option[value=" + '<%=formduzenle("FirmaId") %>' + "]").attr('selected', 'selected');
        if ($("#musteri_id").val().length > 0) {
            //$("#musteri_id").trigger("change");
        }
        $("#proje-bilgi option[value=" + '<%=formduzenle("ProjeId")%>' + "]").attr('selected', 'selected');
    </script>
    <div class="modal-header">
        Servis Bakım Düzenle
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <form autocomplete="off" id="servisbakimduzenle" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
        <script>
           $(function (){
               parcalar_autocomplete_calistir3();
           });
        </script>
        <div class="row">
            <label class="col-sm-11  col-lg-11 col-form-label"><%=LNG("Müşteri")%></label>
            <div class="col-sm-11 col-lg-11">
                <select id="musteri_id" name="musteri" class="select2" onchange="musteribilgilerial('edit');">
                    <option disabled selected>Müşteri Seç</option>
                    <%
                        SQL="select id, firma_adi, firma_yetkili from ucgem_firma_listesi where yetki_kodu = 'MUSTERI' and durum = 'true' and cop = 'false' and ekleyen.firma_id = '"& FirmaID &"'"
                        set musteri = baglanti.execute(SQL)
                        do while not musteri.eof
                    %>
                    <option <%if formduzenle("FirmaId") = musteri("id") then %> selected="selected" <%end if %> value="<%=musteri("id") %>"><%=musteri("firma_adi") %></option>
                    <%
                        musteri.movenext
                        loop
                    %>
                </select>
            </div>
            <div class="col-md-1 col-lg-1">
                <button class="btn btn-link btn-sm" onclick="YeniMusteriOlustur();" style="margin-left: -15px; margin-top: -7px;">
                    <i class="fa fa-plus fa-2x"></i>
                </button>
            </div>
            <div class="col-md-12" id="musteriformu" style="display: none; margin-top: 10px">
                <div class="row" style="border-top: 1px solid #dedede; padding-top: 10px">
                    <label class="col-form-label col-md-12 font-weight-bold" style="text-align: left; margin-bottom: 10px">Müşteri Bilgileri</label>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label class="col-from-label">Firma Adı</label>
                            <input type="text" class="form-control" id="firmaadi" placeholder="Firma Adı" value="<%=formduzenle("FirmaUnvani") %>" required />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12" id="textyetkili">
                        <div class="form-group">
                            <label class="col-from-label">Yetkili Kişi</label>
                            <input type="text" class="form-control" id="yetkilikisi" placeholder="Yetkili Kişi" value="<%=formduzenle("Yetkili") %>" required />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12" id="selectyetkili" style="display: none">
                        <div class="form-group">
                            <label class="col-from-label">Yetkili Kişi</label>
                            <i class="fa fa-close" id="yetkiliSelectGizle" style="cursor: pointer; margin-left: 5px"></i>
                            <select class="form-control yetiskinselect" id="selectyetkilikisi" required style="height: 35px; padding: .4rem .75rem;"></select>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label class="col-from-label">Yetkili Telefon</label>
                            <input type="text" class="form-control" id="firmatelefon" placeholder="0(555) 123 45 67" value="<%=formduzenle("Telefon") %>" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label class="col-from-label">Yetkili E-posta</label>
                            <input class="form-control" type="email" id="firmaeposta" placeholder="example@gmail.com" value="<%=formduzenle("Email") %>" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label class="col-from-label">Firma Adress</label>
                            <input class="form-control" type="text" id="firmaadress" placeholder="Adress" value="<%=formduzenle("Adress") %>" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label class="col-from-label">Vergi Dairesi</label>
                            <input class="form-control" type="text" id="firmavergidairesi" placeholder="Vergi Dairesi" value="<%=formduzenle("VergiDairesi") %>" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label class="col-from-label">Vergi No</label>
                            <input class="form-control" type="text" id="firmavergino" placeholder="Vergi No" value="<%=formduzenle("VergiNo") %>" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label class="col-from-label">Makine Bilgileri</label>
                            <input class="form-control" type="text" id="firmamakinebilgi" placeholder="Makine Bilgileri" value="<%=formduzenle("MakinaBilgileri") %>" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label class="col-from-label">Bildirilen Arıza</label>
                            <input class="form-control" type="text" id="firmaariza" placeholder="Bildirilen Arıza" value="<%=formduzenle("BildirilenAriza") %>" />
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label>Başlangıç Tarihi</label>
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="icon-prepend fa fa-calendar"></i>
                                </span>
                                <input type="text" id="baslangic_tarihi" required class="takvimyap form-control" style="padding-left: 10px" value="<%=formatNumber(DAY(formduzenle("BaslangicTarihi")),2)%>.<%=formatNumber(MONTH(formduzenle("BaslangicTarihi")),2)%>.<%=YEAR(formduzenle("BaslangicTarihi"))%>" />
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label>Bitiş Tarihi</label>
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <i class="icon-prepend fa fa-calendar"></i>
                                </span>
                                <input type="text" id="bitis_tarihi" required class="takvimyap form-control" style="padding-left: 10px" value="<%=formatNumber(DAY(formduzenle("BitisTarihi")),2)%>.<%=formatNumber(MONTH(formduzenle("BitisTarihi")),2)%>.<%=YEAR(formduzenle("BitisTarihi"))%>" />
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-6 col-xs-12" style="max-width: 12.5% !important; padding-right: 5px">
                        <label>Başlangıç Saati</label>
                        <div class="form-group">
                            <input type="text" id="baslangic_saati" required class="timepicker form-control" style="padding-left: 10px" value="<%=formduzenle("BaslangicSaati") %>" />
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-6 col-xs-12" style="max-width: 12.5% !important; padding-left: 5px">
                        <label>Bitiş Saati</label>
                        <div class="form-group">
                            <input type="text" id="bitis_saati" required class="timepicker form-control" style="padding-left: 10px" value="<%=formduzenle("BitisSaati") %>" />
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6 col-xs-12">
                        <label>Proje</label>
                        <div class="form-group">
                            <select class="select2" id="proje-bilgi">
                                <option selected value="0">Proje Seç</option>
                                <%
                                    SQL = "select id, proje_adi, proje_kodu from ucgem_proje_listesi where cop = 'false' and firma_id = '"& FirmaID &"'"
                                    set proje_bilgisi = baglanti.execute(SQL)

                                    do while not proje_bilgisi.eof
                                %>
                                <option value="<%=proje_bilgisi("id") %>"><%=proje_bilgisi("proje_kodu") %> - <%=proje_bilgisi("proje_adi") %></option>
                                <%
                                    proje_bilgisi.movenext
                                    loop
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label>Rapor Durumu</label>
                            <select id="firmarapordurumu" class="form-control select2" onchange="raporDurumKontrol();">
                                <%
                                    r0 = ""
                                    r1 = ""
                                    r2 = ""
                                    r3 = ""
                                    if IsNULL(formduzenle("RaporDurumu")) or formduzenle("RaporDurumu") = "" then
                                        r0 = "selected"
                                    end if
                                    if formduzenle("RaporDurumu") = "Faturasi Kesildi" then
                                        r1 = "selected"
                                    end if
                                    if formduzenle("RaporDurumu") = "Faturasi Kesilecek" then
                                        r2 = "selected"
                                    end if
                                    if formduzenle("RaporDurumu") = "Garanti Kapsaminda" then
                                        r3 = "selected"
                                    end if
                                %>
                                <option <%=r0%> value="" >Durum Seç</option>
                                <option <%=r1%> value="Faturası Kesildi">Faturası Kesildi</option>
                                <option <%=r2%> value="Faturası Kesilecek">Faturası Kesilecek</option>
                                <option <%=r3%> value="Garanti Kapsamında">Garanti Kapsamında</option>
                            </select>
                        </div>
                        <div class="form-group" id="faturagorevli" style="display:none">
                            <label>Bildirim Gönderilecek Personel</label>
                            <select id="personelbildirim" class="form-control select2">
                                <option selected value="0">Personel Seç</option>
                                <%
                                    SQL = "select id, personel_ad + ' ' + personel_soyad as ad_soyad from ucgem_firma_kullanici_listesi where cop = 'false' and firma_id = '"& FirmaID &"'"
                                    set user = baglanti.execute(SQL)

                                    if not user.eof then
                                    do while not user.eof

                                    state = ""
                                    if user("id") = formduzenle("BildirimGonderilecekPersonelID") then
                                        state = "selected"
                                    end if
                                %>
                                <option <%=state %> value="<%=user("id") %>"><%=user("ad_soyad") %></option>
                                <%
                                    user.movenext
                                    loop
                                    end if
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label>Görevli</label>
                            <select id="firmagorevli" class="form-control select2" multiple>
                                <%
                                    SQL = "select id, personel_ad + ' ' + personel_soyad as adsoyad from ucgem_firma_kullanici_listesi where durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"'"
                                    set kullanicilar = baglanti.execute(SQL)
                                    do while not kullanicilar.eof

                                    state = ""
                                    for x = 0 to ubound(split(formduzenle("Gorevliler"), ","))
                                    user = split(formduzenle("Gorevliler"), ",")(x)
                                        if CStr(user) = CStr(kullanicilar("id")) then
                                            state = "selected"
                                        end if
                                    next
                                %>
                                <option <%=state%> value="<%=kullanicilar("id") %>"><%=kullanicilar("adsoyad") %> </option>
                                <%
                                    kullanicilar.movenext
                                    loop        
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label class="col-from-label">Yapılan İşlemler</label>
                            <textarea class="form-control" id="firmayapilanislemler" placeholder="Yapılan İşlemler" style="min-height: 100px"><%=formduzenle("YapilanIslemler") %></textarea>
                        </div>
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-12">
                        <div class="form-group">
                            <label class="col-from-label">Not</label>
                            <textarea class="form-control" id="firmanot" placeholder="Not" style="min-height: 100px"><%=formduzenle("FormNot") %></textarea>
                        </div>
                    </div>
                </div>
                <div class="row" style="border-top: 1px solid #dedede; padding-top: 10px">
                    <div class="col-md-4 col-sm-4 col-xs-8">
                        <div class="form-group">
                            <label class="font-weight-bold">Parça Adı</label>
                            <input type="text" name="parcalar" id="parcalar1" i="1" data="" class="form-control parcalar" />
                        </div>
                    </div>
                    <div class="col-md-2 col-sm-2 col-xs-4">
                        <div class="form-group">
                            <label class="font-weight-bold">Adet</label>
                            <input type="number" class="form-control adeti" name="musteriparcaadeti" id="musteriparcaadeti" min="1" value="1" />
                        </div>
                    </div>
                    <div class="col-md-12 col-sm-12 col-lg-12">
                        <label class="col-form-label font-weight-bold" style="margin-bottom: 10px">Stok Listesi</label>
                        <table class="table table-bordered table-sm table-sprited">
                            <thead>
                                <tr>
                                    <!--<th>Id</th>-->
                                    <th>Parça</th>
                                    <th>Adet</th>
                                    <th>Maliyet</th>
                                    <th>Açıklama</th>
                                    <th>Işlem</th>
                                </tr>
                            </thead>
                            <tbody id="stoklist">
                                <%  
                                        if formduzenle.eof then 
                                %>
                                <tr>
                                    <td colspan="4" style="text-align: center">Kayıt Bulunamadı</td>
                                </tr>
                                <%
                                        end if
                                        parcaID = formduzenle("ParcaId")
                                        for x = 0 to ubound(split(formduzenle("ParcaId"), ","))
                                            id = split(formduzenle("ParcaId"), ",")(x)
                                            Adet = split(formduzenle("Adet"), ",")(x)
                                            StokAdet = split(formduzenle("StoktanKullanilanAdet"), ",")(x)
                                           
                                        SQL = "select * from parca_listesi where durum = 'true' and cop = 'false' and id = '"& id &"' and firma_id = '"& FirmaID &"'"
                                        set parcadetay = baglanti.execute(SQL)

                                        parca_kodu = "-"
                                        marka = "-"
                                        toplamMaliyet = CDbl(CDbl(parcadetay("birim_maliyet")) * Adet)
                                        birimPB = parcadetay("birim_pb")
                                        if parcadetay("marka") = "" then
                                        else
                                            marka = parcadetay("marka")
                                        end if
                                        if parcadetay("parca_kodu") = "" then
                                        else
                                            parca_kodu = parcadetay("parca_kodu")
                                        end if
                                        birim = "TL"
                                        if parcadetay("birim_pb") = "" then
                                        else
                                            birim = parcadetay("birim_pb")
                                            if birim = "EURO" then
                                                birim = "EUR"
                                            end if
                                        end if

                                        k = 0
                                        do while not parcadetay.eof
                                            k = k + 1
                                %>
                                <tr id="parca<%=parcadetay("id") %>">
                                    <!--<td style="text-align:center"><%=k %></td>-->
                                    <td><%=parca_kodu %> - <%=marka %></td>
                                    <td><%=Adet %></td>
                                    <td class="price"><%=toplamMaliyet %>&nbsp<%=birim %></td>
                                    <td><%=parcadetay("aciklama") %></td>
                                    <td>
                                        <button type="button" onclick="parcaDuzenle('<%=parcadetay("id")%>');" class="btn btn-danger btn-mini">Sil</button></td>
                                </tr>
                                <% 
                                        parcadetay.movenext 
                                        loop
                                %>
                                <% next %>
                                <tr id="toplamtutar">
                                    <td colspan="2" style="text-align: right; font-weight: 700;"><span>Tolam Maliyet</span></td>
                                    <td colspan="1" id="totalPrice"></td>
                                    <td colspan="2"></td>
                                </tr>
                            </tbody>
                        </table>
                        <input type="hidden" id="parcalarId" adet="<%=formduzenle("Adet") %>" parcaid="<%=formduzenle("ParcaId") %>" stokadet="<%=formduzenle("StoktanKullanilanAdet") %>" delstokadet="" delparcaid="" deladet="" sonradaneklenenparca="" sonradaneklenenadet="" />
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-primary" onclick="ServisBakimKaydiDuzenlemeYap(<%=kayitId%>);">Servis / Bakım Planı Düzenle</button>
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#musteri_id, #proje-bilgi, #firmarapordurumu, #personelbildirim").select2({
                    dropdownParent: $("#modal_div3")
                });
            });
        </script>
        <script type="text/javascript">
            $(document).ready(function () {
                var sumTL = 0;
                var sumUSD = 0;
                var sumEUR = 0;
                var valueTL = 0;
                var valueUSD = 0;
                var valueEUR = 0;

                if ($("#stoklist").children('tr').length == 1) {
                    $("#totalPrice").text(0 + " TL" + " - " + 0 + " USD" + " - " + 0 + " EUR");
                }

                $(".price").each(function () {

                    var sonucTL = $(this).text().indexOf("TL");
                    var sonucUSD = $(this).text().indexOf("USD");
                    var sonucEUR = $(this).text().indexOf("EUR");

                    if (sonucTL != -1) {
                        valueTL = $(this).text().replace('TL', '').replace(' ', '').replace(',', '.');
                        if (!isNaN(valueTL) && valueTL.length != 0 && valueTL > 0) {
                            sumTL += parseFloat(valueTL);
                            $("#totalPrice").text(sumTL.toFixed(2) + " TL" + " - " + sumUSD.toFixed(2) + " USD" + " - " + sumEUR.toFixed(2) + " EUR");
                        }
                    }

                    if (sonucUSD != -1) {
                        valueUSD = $(this).text().replace('USD', '').replace(' ', '').replace(',', '.');
                        if (!isNaN(valueUSD) && valueUSD.length != 0 && valueUSD > 0) {
                            sumUSD += parseFloat(valueUSD);
                            $("#totalPrice").text(sumTL.toFixed(2) + " TL" + " - " + sumUSD.toFixed(2) + " USD" + " - " + sumEUR.toFixed(2) + " EUR");
                        }
                    }

                    if (sonucEUR != -1) {
                        valueEUR = $(this).text().replace('EUR', '').replace(' ', '').replace(',', '.');
                        if (!isNaN(valueEUR) && valueEUR.length != 0 && valueEUR > 0) {
                            sumEUR += parseFloat(valueEUR);
                            $("#totalPrice").text(sumTL.toFixed(2) + " TL" + " - " + sumUSD.toFixed(2) + " USD" + " - " + sumEUR.toFixed(2) + " EUR");
                        }
                    }
                });
            });
            $("#firmarapordurumu").trigger("onchange");
        </script>
        <script type="text/javascript">
            $("#yetkiliSelectGizle").click(function () {
                $("#selectyetkili").hide();
                $("#textyetkili").show();
            });
        </script>
        <style>
            .ui-helper-hidden {
                display: none;
            }

            .ui-helper-hidden-accessible {
                border: 0;
                clip: rect(0 0 0 0);
                height: 1px;
                margin: -1px;
                overflow: hidden;
                padding: 0;
                position: absolute;
                width: 1px;
            }

            .ui-helper-reset {
                margin: 0;
                padding: 0;
                border: 0;
                outline: 0;
                line-height: 1.3;
                text-decoration: none;
                font-size: 100%;
                list-style: none;
            }

            .ui-helper-clearfix:before,
            .ui-helper-clearfix:after {
                content: "";
                display: table;
                border-collapse: collapse;
            }

            .ui-helper-clearfix:after {
                clear: both;
            }

            .ui-helper-zfix {
                width: 100%;
                height: 100%;
                top: 0;
                left: 0;
                position: absolute;
                opacity: 0;
                filter: Alpha(Opacity=0); /* support: IE8 */
            }

            .ui-front {
                z-index: 1070;
            }


            /* Interaction Cues
----------------------------------*/
            .ui-state-disabled {
                cursor: default !important;
                pointer-events: none;
            }


            /* Icons
----------------------------------*/
            .ui-icon {
                display: inline-block;
                vertical-align: middle;
                margin-top: -.25em;
                position: relative;
                text-indent: -99999px;
                overflow: hidden;
                background-repeat: no-repeat;
            }

            .ui-widget-icon-block {
                left: 50%;
                margin-left: -8px;
                display: block;
            }

            /* Misc visuals
----------------------------------*/

            /* Overlays */
            .ui-widget-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
            }

            .ui-autocomplete {
                position: absolute;
                top: 0;
                left: 0;
                cursor: default;
            }

            .ui-menu {
                list-style: none;
                padding: 0;
                margin: 0;
                display: block;
                outline: 0;
            }

                .ui-menu .ui-menu {
                    position: absolute;
                }

                .ui-menu .ui-menu-item {
                    display: flex;
                    margin: 0;
                    cursor: pointer;
                    /* support: IE10, see #8844 */
                    list-style-image: url("data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7");
                }

                .ui-menu .ui-menu-item-wrapper {
                    position: relative;
                    padding: 3px 1em 3px .4em;
                    display: block;
                    width: 100%;
                    border: 1px solid #ccc;
                }

                .ui-menu .ui-menu-divider {
                    margin: 5px 0;
                    height: 0;
                    font-size: 0;
                    line-height: 0;
                    border-width: 1px 0 0 0;
                }

                .ui-menu .ui-state-focus,
                .ui-menu .ui-state-active {
                    margin: -1px;
                }

            /* icon support */
            .ui-menu-icons {
                position: relative;
            }

                .ui-menu-icons .ui-menu-item-wrapper {
                    padding-left: 2em;
                }

            /* left-aligned */
            .ui-menu .ui-icon {
                position: absolute;
                top: 0;
                bottom: 0;
                left: .2em;
                margin: auto 0;
            }

            /* right-aligned */
            .ui-menu .ui-menu-icon {
                left: auto;
                right: 0;
            }

            /* Component containers
----------------------------------*/
            .ui-widget {
                font-family: Arial,Helvetica,sans-serif;
                font-size: 1em;
            }

                .ui-widget .ui-widget {
                    font-size: 1em;
                }

                .ui-widget input,
                .ui-widget select,
                .ui-widget textarea,
                .ui-widget button {
                    font-family: Arial,Helvetica,sans-serif;
                    font-size: 1em;
                }

                .ui-widget.ui-widget-content {
                    border: 1px solid #c5c5c5;
                }

            .ui-widget-content {
                border: 1px solid #dddddd;
                background: #ffffff;
                color: #333333;
            }

                .ui-widget-content a {
                    color: #333333;
                }

            .ui-widget-header {
                border: 1px solid #dddddd;
                background: #e9e9e9;
                color: #333333;
                font-weight: bold;
            }

                .ui-widget-header a {
                    color: #333333;
                }

                /* Interaction states
----------------------------------*/
                .ui-state-default,
                .ui-widget-content .ui-state-default,
                .ui-widget-header .ui-state-default,
                .ui-button,
                /* We use html here because we need a greater specificity to make sure disabled
works properly when clicked or hovered */
                html .ui-button.ui-state-disabled:hover,
                html .ui-button.ui-state-disabled:active {
                    border: 1px solid #c5c5c5;
                    background: #f6f6f6;
                    font-weight: normal;
                    color: #454545;
                }

                    .ui-state-default a,
                    .ui-state-default a:link,
                    .ui-state-default a:visited,
                    a.ui-button,
                    a:link.ui-button,
                    a:visited.ui-button,
                    .ui-button {
                        color: #454545;
                        text-decoration: none;
                    }

                        .ui-state-hover,
                        .ui-widget-content .ui-state-hover,
                        .ui-widget-header .ui-state-hover,
                        .ui-state-focus,
                        .ui-widget-content .ui-state-focus,
                        .ui-widget-header .ui-state-focus,
                        .ui-button:hover,
                        .ui-button:focus {
                            border: 1px solid #cccccc;
                            background: #ededed;
                            font-weight: normal;
                            color: #2b2b2b;
                        }

                            .ui-state-hover a,
                            .ui-state-hover a:hover,
                            .ui-state-hover a:link,
                            .ui-state-hover a:visited,
                            .ui-state-focus a,
                            .ui-state-focus a:hover,
                            .ui-state-focus a:link,
                            .ui-state-focus a:visited,
                            a.ui-button:hover,
                            a.ui-button:focus {
                                color: #2b2b2b;
                                text-decoration: none;
                            }

            .ui-visual-focus {
                box-shadow: 0 0 3px 1px rgb(94, 158, 214);
            }

            .ui-state-active,
            .ui-widget-content .ui-state-active,
            .ui-widget-header .ui-state-active,
            a.ui-button:active,
            .ui-button:active,
            .ui-button.ui-state-active:hover {
                border: 1px solid #003eff;
                background: #007fff;
                font-weight: normal;
                color: #ffffff;
            }

                .ui-icon-background,
                .ui-state-active .ui-icon-background {
                    border: #003eff;
                    background-color: #ffffff;
                }

                .ui-state-active a,
                .ui-state-active a:link,
                .ui-state-active a:visited {
                    color: #ffffff;
                    text-decoration: none;
                }

            /* Interaction Cues
----------------------------------*/
            .ui-state-highlight,
            .ui-widget-content .ui-state-highlight,
            .ui-widget-header .ui-state-highlight {
                border: 1px solid #dad55e;
                background: #fffa90;
                color: #777620;
            }

            .ui-state-checked {
                border: 1px solid #dad55e;
                background: #fffa90;
            }

            .ui-state-highlight a,
            .ui-widget-content .ui-state-highlight a,
            .ui-widget-header .ui-state-highlight a {
                color: #777620;
            }

            .ui-state-error,
            .ui-widget-content .ui-state-error,
            .ui-widget-header .ui-state-error {
                border: 1px solid #f1a899;
                background: #fddfdf;
                color: #5f3f3f;
            }

                .ui-state-error a,
                .ui-widget-content .ui-state-error a,
                .ui-widget-header .ui-state-error a {
                    color: #5f3f3f;
                }

            .ui-state-error-text,
            .ui-widget-content .ui-state-error-text,
            .ui-widget-header .ui-state-error-text {
                color: #5f3f3f;
            }

            .ui-priority-primary,
            .ui-widget-content .ui-priority-primary,
            .ui-widget-header .ui-priority-primary {
                font-weight: bold;
            }

            .ui-priority-secondary,
            .ui-widget-content .ui-priority-secondary,
            .ui-widget-header .ui-priority-secondary {
                opacity: .7;
                filter: Alpha(Opacity=70); /* support: IE8 */
                font-weight: normal;
            }

            .ui-state-disabled,
            .ui-widget-content .ui-state-disabled,
            .ui-widget-header .ui-state-disabled {
                opacity: .35;
                filter: Alpha(Opacity=35); /* support: IE8 */
                background-image: none;
            }

                .ui-state-disabled .ui-icon {
                    filter: Alpha(Opacity=35); /* support: IE8 - See #6059 */
                }


            /* Misc visuals
----------------------------------*/

            /* Corner radius */
            .ui-corner-all,
            .ui-corner-top,
            .ui-corner-left,
            .ui-corner-tl {
                border-top-left-radius: 3px;
            }

            .ui-corner-all,
            .ui-corner-top,
            .ui-corner-right,
            .ui-corner-tr {
                border-top-right-radius: 3px;
            }

            .ui-corner-all,
            .ui-corner-bottom,
            .ui-corner-left,
            .ui-corner-bl {
                border-bottom-left-radius: 3px;
            }

            .ui-corner-all,
            .ui-corner-bottom,
            .ui-corner-right,
            .ui-corner-br {
                border-bottom-right-radius: 3px;
            }

            /* Overlays */
            .ui-widget-overlay {
                background: #aaaaaa;
                opacity: .3;
                filter: Alpha(Opacity=30); /* support: IE8 */
            }

            .ui-widget-shadow {
                -webkit-box-shadow: 0px 0px 5px #666666;
                box-shadow: 0px 0px 5px #666666;
            }
        </style>
        <script src="/js/jquery-ui.js"></script>
    </form>
    <%
    elseif trn(request("islem")) = "musteribilgilerial" then

        musteriId = trn(request("musteriID"))
        SQL = "select * from ucgem_firma_listesi where id = '"& musteriId &"' and firma_id = '"& FirmaID &"'"
        response.Write(SQL)
        set result = baglanti.execute(SQL)

    elseif trn(request("islem"))="personeller" then

        personel_tcno = trn(request("personel_tcno"))
        personel_eposta = trn(request("personel_eposta"))
        personel_telefon = trn(request("personel_telefon"))

        SQL="select count(id) from ucgem_firma_kullanici_listesi where (tcno = '"& personel_tcno &"' or personel_eposta = '"& personel_eposta &"' or personel_telefon = '"& personel_telefon &"') and cop = 'false' and firma_id = '"& FirmaID &"'"
        set varmi = baglanti.execute(SQL)

        if cdbl(varmi(0))=0 then
            Response.Clear()
            Response.Write "ok"
            Response.End
        else
            Response.Clear()
            Response.Write "false"
            Response.End
        end if
        
    %>
    <%
    elseif trn(request("islem"))="YasakliGunEkle" then

        FirmaID = Request.Cookies("kullanici")("firma_id")

        if trn(request("islem2"))="ekle" then

            baslangic_tarihi = trn(request("baslangic_tarihi"))
            bitis_tarihi = trn(request("bitis_tarihi"))

            SQL="insert into tanimlama_yasakli_izin_gunleri(baslangic_tarihi, bitis_tarihi, firma_id) values(CONVERT(date, '"& baslangic_tarihi &"', 103), CONVERT(date, '"& bitis_tarihi &"', 103), '"& FirmaID &"')"
            set ekle = baglanti.execute(SQL)

        elseif trn(request("islem2"))="sil" then

            kayit_id = trn(request("kayit_id"))

            SQL="delete from tanimlama_yasakli_izin_gunleri where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)

        end if

    %>
    <table id="simpletable" class="table table-striped table-bordered nowrap datatableyap1">
        <thead>
            <tr>
                <th style="width: 30px;">ID</th>
                <th>Başlangıç Tarihi</th>
                <th>Bitiş Tarihi</th>
                <th style="width: 100px;">İşlem</th>
            </tr>
        </thead>
        <tbody>
            <%
                    SQL="select * from tanimlama_yasakli_izin_gunleri where firma_id = '"& FirmaID &"' order by id asc"
                    set kategori = baglanti.execute(SQL)
                    if kategori.eof then
            %>
            <tr>
                <td colspan="4" style="text-align: center;">Kayıt Bulunamadı</td>
            </tr>
            <% 
                end if
                k = 0
                do while not kategori.eof    
                    k = k + 1
            %>
            <tr>
                <td><%=k %></td>
                <td><%=cdate(kategori("baslangic_tarihi")) %></td>
                <td><%=cdate(kategori("bitis_tarihi")) %></td>
                <td class="icon-list-demo2">
                    <a href="javascript:void(0);" onclick="tanimlama_yasakli_sil('<%=kategori("id") %>');" rel="tooltip">
                        <i class="ti-trash"></i>
                    </a>
                </td>
            </tr>
            <%
                    kategori.movenext
                    loop
            %>
        </tbody>
    </table>
    <% 
    elseif trn(request("islem"))="servis_formu" then

        is_id = trn(request("is_id"))

        Set Pdf = Server.CreateObject("Persits.Pdf")
        Set Doc = Pdf.CreateDocument


        Doc.ImportFromUrl site_url & "/teknik_servis_formu/?jsid=4559&is_id=" & is_id, "pageWidth=900,DrawBackground=true,pageHeight=1200, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
        dosya_yolu = "/downloadRapor/ServisFormu"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
        Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)

        sName = server.MapPath(dosya_yolu)

        ParcaParcaDosyaIndir sName, "ServisFormu.pdf"

    end if  

    %>
