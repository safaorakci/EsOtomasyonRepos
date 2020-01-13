<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    personel_id = trn(request("personel_id"))

    SQL="select kullanici.personel_resim, gorev.gorev_adi, kullanici.personel_ad, kullanici.personel_soyad from ucgem_firma_kullanici_listesi kullanici join tanimlama_gorev_listesi gorev on gorev.id = kullanici.gorevler where kullanici.id = '"& personel_id &"' and kullanici.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"'"
    set personel = baglanti.execute(SQL)

    SQL = "select * from tbl_ModulYetkileri where FirmaId = '"& Request.Cookies("kullanici")("firma_id") &"'"
    set tblModulYetkiler = baglanti.execute(SQL)

    personel_resim = personel("personel_resim")
    if len(trim(personel_resim))<15 then
        personel_resim = "/img/user.png"
    end if
%>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>

<div class="page-body breadcrumb-page">
    <div class="card page-header p-0">
        <div class="card-block front-icon-breadcrumb row align-items-end">
            <div class="breadcrumb-header col">
                <div class="big-icon">
                    <div class="card-block user-info" style="bottom: -73px;">
                        <div class="media-left">
                            <a href="#" class="profile-image">
                                <img class="user-img img-radius" src="<%=personel_resim %>" style="width: 140px!important; height: 149px!important;">
                            </a>
                        </div>
                    </div>
                </div>
                <div class="d-inline-block" style="padding-left: 175px;">
                    <h5 style="font-size: 15px;"><%=personel("personel_ad") & " " & personel("personel_soyad") %></h5>
                    <span><%=personel("gorev_adi") %></span>
                </div>


            </div>
        </div>
    </div>
</div>

<style>
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
</style>

<div class="row">
    <div class="col-lg-12">
        <div class="tabs tabs-style-bar">
            <nav>
                <ul>
                    <li class="nav-link_yeni"><a href="#personel_bilgileri" onclick="personel_bilgileri_getir('<%=personel_id %>', this);" class="icon icon-home"><span><%=LNG("Personel")%></span></a></li>

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
                    <li class="nav-link_yeni"><a href="#dosyalar" onclick="personel_dosyalari_getir('<%=personel_id %>', this);" class="icon icon-tools"><span><%=LNG("Dosyalar")%></span></a></li>
                    <% end if %>

                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",109,")>0 then %>
                    <li class="nav-link_yeni"><a href="#personel_ajanda" onclick="personel_ajandasi_getir('<%=personel_id %>', this);" class="icon icon-home"><span><%=LNG("Ajanda")%></span></a></li>
                    <% end if %>

                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",110,")>0 then %>
                    <li class="nav-link_yeni"><a href="#is_listesi_panel" onclick="personel_is_listesi_getir('<%=personel_id %>', this);" class="icon icon-box"><span><%=LNG("İş Listesi")%></span></a></li>
                    <% end if %>

                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",111,")>0 then %>
                    <li class="nav-link_yeni"><a href="#adam_saat_cetveli" onclick="personel_adamsaat_getir('<%=personel_id %>', this, '<%=month(date) %>', '<%=year(date) %>');" class="icon icon-upload"><span><%=LNG("Adam-Saat")%></span></a></li>
                    <% end if %>

                    <!--        <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",112,")>0 then %>
                    <li style="display:none;" class="nav-link_yeni"><a onclick="personel_raporlarini_getir('<%=personel_id %>', this);" style="-webkit-border-top-right-radius: 10px; -webkit-border-bottom-right-radius: 10px; -moz-border-radius-topright: 10px; -moz-border-radius-bottomright: 10px; border-top-right-radius: 10px; border-bottom-right-radius: 10px;" href="#raporlar" class="icon icon-tools"><span><%=LNG("Raporlar")%></span></a></li>
                    <% end if %>-->
                </ul>
            </nav>
            <div class="content-wrap">
                <section id="personel_bilgileri" class="personel_tablar">
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
                <% if 1 = 2 then %>
                <section id="cari_hareketler" class="personel_tablar">
                </section>
                <% end if %>
                <section id="dosyalar" class="personel_tablar">
                </section>
                <section id="personel_ajanda" class="personel_tablar">
                </section>
                <section id="is_listesi_panel" class="personel_tablar">
                </section>
                <section id="adam_saat_cetveli" class="personel_tablar">
                </section>
                <!--  <section id="raporlar" class="personel_tablar">
                </section>-->
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
