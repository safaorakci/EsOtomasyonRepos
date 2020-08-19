<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    personel_id = trn(request("personel_id"))
    ustId = trn(request("ustId"))
    FirmaID = Request.Cookies("kullanici")("firma_id")
    KullaniciID = Request.Cookies("kullanici")("kullanici_id")

    SQL="select kullanici.personel_resim, left(ISNULL((select gorev_adi + ', ' from tanimlama_gorev_listesi where (SELECT COUNT(value) FROM STRING_SPLIT(kullanici.gorevler, ',') WHERE value =  id ) > 0 and cop = 'false' for xml path('')), '----'), len(ISNULL((select gorev_adi + ', ' from tanimlama_gorev_listesi where (SELECT COUNT(value) FROM STRING_SPLIT(kullanici.gorevler, ',') WHERE value =  id ) > 0 and cop = 'false' for xml path('')), '----'))-1) as gorev_adi, kullanici.personel_ad, kullanici.personel_soyad from ucgem_firma_kullanici_listesi kullanici with(nolock) where kullanici.firma_id = '"& FirmaID &"' and kullanici.id = '"& personel_id &"' and kullanici.cop = 'false' order by kullanici.id asc"
    set personel = baglanti.execute(SQL)

    SQL = "select ISNULL(k.yonetici_yetkisi, 'false') as yonetici_yetkisi from ucgem_firma_kullanici_listesi k where id = '"& KullaniciID &"'"
    set yetkiKontrol = baglanti.execute(SQL)

    SQL = "select * from tbl_ModulYetkileri where FirmaId = '"& FirmaID &"'"
    set tblModulYetkiler = baglanti.execute(SQL)

    personel_resim = personel("personel_resim")
    if len(trim(personel_resim))<15 then
        personel_resim = "/img/user.png"
    end if

    SQL = "EXEC [dbo].PersonelGorevYetkileri '"& KullaniciID &"', 1, 1, 0, 0, '"& personel_id &"', '"& FirmaID &"'"
    set personelTab = baglanti.execute(SQL)
%>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<style type="text/css">
    .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active i {
        color: #fff !important;
    }

    .yuvarla i {
        font-family: 'themify';
        speak: none;
        font-style: normal;
        font-weight: normal;
        font-variant: normal;
        text-transform: none;
        line-height: 1;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
    }

    .tab-content > .active {
        display: block;
        background-color: white !important;
    }

    .ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active, a.ui-button:active, .ui-button:active, .ui-button.ui-state-active:hover {
        background: #58a5ff;
    }

    .border-bottom {
        border-bottom: 1px solid rgba(0, 0, 0, .1) !important;
    }

    .border-right {
        border-right: 1px solid rgba(0, 0, 0, .1) !important;
    }

    .border {
        border: 1px solid rgba(0, 0, 0, .1) !important;
    }

    .border-bottom-0 {
        border-bottom: none !important;
    }

    .border-top-0 {
        border-top: none !important;
    }

    .f-13 {
        font-size: 13px !important;
    }
</style>

<div class="page-body breadcrumb-page">
    <div class="card page-header p-0">
        <div class="card-block front-icon-breadcrumb row align-items-end">
            <div class="breadcrumb-header col">
                <div class="big-icon">
                    <div class="card-block user-info" style="bottom: -73px; width: auto !important;">
                        <div class="media-left">
                            <a href="#" class="profile-image">
                                <img class="user-img img-radius" src="<%=personel_resim %>" width="140" height="145">
                            </a>
                        </div>
                    </div>
                </div>
                <div class="d-inline-block" style="padding-left: 175px;">
                    <h5 style="font-size: 15px;"><%=personel("personel_ad") & " " & personel("personel_soyad") %></h5>
                    <span><%=personel("gorev_adi") %></span>
                </div>

                <a href="javascript:void(0);" onclick="sayfagetir('/personel_yonetimi/','jsid=4559&ustId=<%=ustId %>');" class="btn btn-sm btn-labeled btn-success btn-round float-right f-13"><i class="fa fa-history mr-2"></i> Geri Dön</a>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="tabs tabs-style-bar">
            <nav>
                <ul>
                    <li class="nav-link_yeni"><a href="#personel_bilgileri" onclick="personel_bilgileri_getir('<%=personel_id %>', this);" class="icon icon-home"><span><%=LNG("Personel")%></span></a></li>
                    <%
                        if not personelTab.eof then
                            do while not personelTab.eof
                                if CInt(personelTab("UstID")) = CInt(ustId) then
                    %>
                    <li class="nav-link_yeni">
                        <a href="<%=CStr(personelTab("HtmlHref"))%>" onclick="<%=personelTab("SayfaLink") %>" class="tabbuton icon icon-display">
                            <span><%=personelTab("SayfaAdi") %></span>
                        </a>
                    </li>
                    <%
                                end if
                            personelTab.movenext 
                            loop
                        end if
                    %>

                    <%if 1 = 2 then %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",103,")>0 then %>
                    <li class="nav-link_yeni"><a href="#giris_cikis" id="giris_cikis_buton" onclick="personel_giris_cikis_getir('<%=personel_id %>', this);" class="icon icon-box"><span><%=LNG("Giriş-İzin")%></span></a></li>
                    <% end if %>

                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",104,")>0 then %>
                    <li class="nav-link_yeni"><a href="#mesai_section" id="mesai_buton" onclick="personel_mesai_getir('<%=personel_id %>', this);" class="icon icon-home"><span><%=LNG("Mesai")%></span></a></li>
                    <% end if %>

                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",105,")>0 then %>
                    <li class="nav-link_yeni"><a href="#bordro_section" id="bordro_buton" onclick="personel_bordro_getir('<%=personel_id %>', this);" class="icon icon-tools"><span><%=LNG("Bordro")%></span></a></li>
                    <% end if %>

                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",106,")>0 then %>
                    <li class="nav-link_yeni"><a href="#zimmet" onclick="zimmet_getir('personel', '<%=personel_id %>', this);" class="icon icon-display"><span><%=LNG("Zimmet")%></span></a></li>
                    <% end if %>

                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",107,")>0 and 1 = 2 then %>
                    <li class="nav-link_yeni"><a href="#cari_hareketler" onclick="personel_cari_getir('<%=personel_id %>', this);" class="icon icon-upload"><span><%=LNG("Cari Hareketler")%></span></a></li>
                    <% end if %>

                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",108,")>0 then %>
                    <li class="nav-link_yeni"><a href="#dosyalar" onclick="personel_dosyalari_getir('<%=personel_id %>', this, 'personel');" class="icon icon-tools"><span><%=LNG("Dosyalar")%></span></a></li>
                    <% end if %>

                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",109,")>0 then %>
                    <%if Request.Cookies("kullanici")("kullanici_id") = personel_id or yetkiKontrol("yonetici_yetkisi") = "true" then %>
                    <li class="nav-link_yeni"><a href="#personel_ajanda" onclick="personel_ajandasi_getir('<%=personel_id %>', this);" class="icon icon-home"><span><%=LNG("Ajanda")%></span></a></li>
                    <%end if %>
                    <% end if %>

                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",110,")>0 then %>
                    <li class="nav-link_yeni"><a href="#is_listesi_panel" onclick="personel_is_listesi_getir('<%=personel_id %>', this);" class="icon icon-box"><span><%=LNG("İş Listesi")%></span></a></li>
                    <% end if %>

                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",111,")>0 then %>
                    <li class="nav-link_yeni"><a href="#adam_saat_cetveli" onclick="personel_adamsaat_getir('<%=personel_id %>', this, '<%=month(date) %>', '<%=year(date) %>');" class="icon icon-upload"><span><%=LNG("Adam-Saat")%></span></a></li>
                    <% end if %>
                    <% end if %>
                </ul>
            </nav>
            <div class="content-wrap">
                <section id="personel_bilgileri_cek" class="personel_tablar">
                    <script>
                        $(function (){
                            personel_bilgileri_getir('<%=personel_id %>');
                        });
                    </script>
                </section>
                <section id="giris_cikis" class="personel_tablar"></section>

                <section id="mesai_section" class="personel_tablar"></section>

                <section id="bordro_section" class="personel_tablar"></section>

                <section id="zimmet" class="personel_tablar"></section>

                <!--<section id="cari_hareketler" class="personel_tablar"></section>-->

                <section id="dosyalar" class="personel_tablar"></section>

                <section id="personel_ajanda" class="personel_tablar"></section>

                <section id="is_listesi_panel" class="personel_tablar"></section>

                <section id="adam_saat_cetveli" class="personel_tablar"></section>

                <section id="personel_puanlama" class="personel_tablar"></section>

                <section id="raporlar" class="personel_tablar"></section>
            </div>
        </div>
    </div>
</div>
<script>
			(function() {

				[].slice.call( document.querySelectorAll( '.tabs' ) ).forEach( function( el ) {
					new CBPFWTabs( el );
				});

			})();
</script>



<% if 1 = 2 then %>
<div class="row">
    <div class="col-lg-12">
        <!-- tab header start -->
        <div class="tab-header card">
            <ul class="nav nav-tabs md-tabs tab-timeline" style="border: solid 1px #007bff;" role="tablist" id="mytab">
                <li class="nav-item">
                    <a class="nav-link active" data-toggle="tab" href="#personel_bilgileri" onclick="personel_bilgileri_getir('<%=personel_id %>');" role="tab"><span class="yuvarla"><i class="icofont icofont-home"></i></span>Personel</a>
                    <div class="slide"></div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#giris_cikis" onclick="personel_giris_cikis_getir('<%=personel_id %>');" role="tab"><span class="yuvarla" style="background-color: #F88EA4;"><i class="icofont icofont-ui-user "></i></span>Giriş-Çıkış</a>
                    <div class="slide"></div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#zimmet" onclick="zimmet_getir('personel', '<%=personel_id %>');" role="tab"><span class="yuvarla" style="background-color: #2ed8b6;"><i class="icofont icofont-ui-message"></i></span>Zimmet</a>
                    <div class="slide"></div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#cari_hareketler" onclick="personel_cari_getir('<%=personel_id %>');" role="tab"><span class="yuvarla" style="background-color: #f1c40f;"><i class="icofont icofont-ui-settings"></i></span>Cari Hareketler</a>
                    <div class="slide"></div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#dosyalar" onclick="personel_dosyalari_getir('<%=personel_id %>');" role="tab"><span class="yuvarla" style="background-color: #ab7967;"><i class="icofont icofont-home"></i></span>Dosyalar</a>
                    <div class="slide"></div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#personel_ajanda" onclick="personel_ajandasi_getir('<%=personel_id %>');" role="tab"><span class="yuvarla" style="background-color: #39adb5;"><i class="icofont icofont-ui-user "></i></span>Ajanda</a>
                    <div class="slide"></div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#is_listesi_panel" onclick="personel_is_listesi_getir('<%=personel_id %>');" role="tab"><span class="yuvarla" style="background-color: #7c4dff;"><i class="icofont icofont-ui-message"></i></span>İş Listesi</a>
                    <div class="slide"></div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#adam_saat_cetveli" onclick="personel_adamsaat_getir('<%=personel_id %>');" role="tab"><span class="yuvarla" style="background-color: #ff5370;"><i class="icofont icofont-ui-settings"></i></span>Adam-Saat</a>
                    <div class="slide"></div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#raporlar" onclick="personel_raporlarini_getir('<%=personel_id %>');" role="tab"><span class="yuvarla" style="background-color: #4099ff;"><i class="icofont icofont-home"></i></span>Raporlar</a>
                    <div class="slide"></div>
                </li>
            </ul>
        </div>
        <div class="tab-content">
            <div class="tab-pane active personel_tablar" id="personel_bilgileri" role="tabpanel">
                <script>
                        $(function (){
                            personel_bilgileri_getir('<%=personel_id %>');
                        });
                </script>
            </div>
            <div class="tab-pane personel_tablar" id="giris_cikis" role="tabpanel">
            </div>
            <div class="tab-pane personel_tablar" id="zimmet" role="tabpanel">
            </div>
            <div class="tab-pane personel_tablar" id="cari_hareketler" role="tabpanel">
            </div>

            <div class="tab-pane personel_tablar" id="dosyalar" role="tabpanel">
            </div>


            <div class="tab-pane personel_tablar" id="personel_ajanda" role="tabpanel">
            </div>
            <div class="tab-pane personel_tablar" id="is_listesi_panel" role="tabpanel">
            </div>
            <div class="tab-pane personel_tablar" id="adam_saat_cetveli" role="tabpanel">
            </div>

            <div class="tab-pane personel_tablar" id="raporlar" role="tabpanel">
            </div>

        </div>
    </div>
</div>

<% end if %>
