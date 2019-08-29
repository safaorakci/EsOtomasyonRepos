<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    personel_id = request("personel_id")

    SQL="select isnull(gorev.yetkili_sayfalar,1) as yetkili_sayfalar , kullanici.*, firma.firma_hid, firma.id as firma_id from ucgem_firma_kullanici_listesi kullanici join ucgem_firma_listesi firma on firma.id = kullanici.firma_id join tanimlama_gorev_listesi gorev on gorev.id = kullanici.gorevler where kullanici.id = '"& personel_id &"'"
    set kullanici = baglanti.execute(SQL)


    Response.Cookies("kullanici")("firma_id") = kullanici("firma_id")
    Response.Cookies("kullanici")("kullanici_id") = kullanici("id")
    Response.Cookies("kullanici")("ekleyen_id") = kullanici("id")
    Response.Cookies("kullanici")("durum") = "true"
    Response.Cookies("kullanici")("login") = "true"
    Response.Cookies("kullanici")("login_tarih") = date
    Response.Cookies("kullanici")("login_saat") = time
    Response.Cookies("kullanici")("remember") = "true"
    Response.Cookies("kullanici").Expires = Date() + 30


    SQL="select gorev.gorev_adi, kullanici.* from ucgem_firma_kullanici_listesi kullanici join tanimlama_gorev_listesi gorev on gorev.id = kullanici.gorevler where kullanici.id = '"& personel_id &"'"
    set personel = baglanti.execute(SQL)

    personel_resim = personel("personel_resim")
    if len(trim(personel_resim))<15 then
        personel_resim = "/img/user.png"
    end if

%>



<!DOCTYPE html>
<html lang="tr">
<head>
    <title><% Response.Write(LNG("Es Otomasyon | Süreç Yönetimi")) %></title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta http-equiv="cache-control" content="max-age=0" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <meta name="author" content="Makrogem Bilişim Teknolojileri A.Ş" />
    <link rel="icon" href="/files/assets/images/favicon.ico" type="image/x-icon">
    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/files/bower_components/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/files/assets/icon/themify-icons/themify-icons.css">
    <link rel="stylesheet" type="text/css" href="/files/assets/icon/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="/files/assets/css/jquery.mCustomScrollbar.css">
    <link rel="stylesheet" href="/files/assets/pages/chart/radial/css/radial.css" type="text/css" media="all">
    <link rel="stylesheet" type="text/css" href="/files/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="/css/ozel_css.css">
    <link rel="stylesheet" type="text/css" href="/files/assets/icon/icofont/css/icofont.css">
    <link rel="stylesheet" type="text/css" href="/files/bower_components/switchery/css/switchery.min.css">
    <link rel="stylesheet" type="text/css" href="/files/bower_components/sweetalert/css/sweetalert.css">
    <link rel="stylesheet" type="text/css" href="/files/bower_components/pnotify/css/pnotify.css">
    <link rel="stylesheet" type="text/css" href="/files/bower_components/pnotify/css/pnotify.brighttheme.css">
    <link rel="stylesheet" type="text/css" href="/files/bower_components/pnotify/css/pnotify.mobile.css">
    <link rel="stylesheet" type="text/css" href="/files/assets/pages/pnotify/notify.css">
    <link rel="stylesheet" type="text/css" href="/css/proskop.css">
    <link href="/js/vis-timeline-graph2d.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/css/spectrum.css">
    <link rel="stylesheet" type="text/css" href="/js/tabs/css/tabs.css" />
    <link rel="stylesheet" type="text/css" href="/js/tabs/css/tabstyles.css" />
    <link rel="stylesheet" type="text/css" href="/js/select2.min.css" />
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="/js/NumberFormat154.js"></script>
     <style>
        
        body::-webkit-scrollbar-track
        {
	        -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
	        background-color: #F5F5F5;
        }

        body::-webkit-scrollbar
        {
	        width: 30px;
	        background-color: #F5F5F5;
        }

        body::-webkit-scrollbar-thumb
        {
	        background-color: #0ae;
	
	        background-image: -webkit-gradient(linear, 0 0, 0 100%,
	                           color-stop(.5, rgba(255, 255, 255, .2)),
					           color-stop(.5, transparent), to(transparent));
        }

    </style>
</head>
<body>
    <div class="theme-loader">
        <div class="loader-track">
            <svg id="loader2" viewBox="0 0 100 100">
                <circle id="circle-loader2" cx="50" cy="50" r="45"></circle>
            </svg>
        </div>
    </div>
    <div id="pcoded" class="pcoded">
        <div class="pcoded-overlay-box"></div>
        <div class="pcoded-container navbar-wrapper">
        
            
            <div class="pcoded-main-container">
                <div class="pcoded-wrapper">
                  
                    <div class="pcoded-contents">
                        <div class="pcoded-inner-content">
                            <div class="main-body">
                                <div class="page-wrapper">
                                    <div class="page-body">
                                        <div id="ortadiv">
                                            

                                            
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


<div class="row">
    <div class="col-lg-12">
        <div class="tabs tabs-style-bar">
            <nav>
                <ul>
                    <li class="nav-link_yeni"><a style="-webkit-border-top-left-radius: 10px; -webkit-border-bottom-left-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-bottomleft: 10px; border-top-left-radius: 10px; border-bottom-left-radius: 10px; padding-top:15px; height:75px;" href="#personel_bilgileri" id="personel_ilk_buton" onclick="profil_personel_bilgileri_getir('<%=personel_id %>', this);" class="icon icon-home"><div><%=LNG("Personel")%></div></a></li>

                    <li class="nav-link_yeni"><a style=" padding-top:15px; height:75px;" href="#giris_cikis" onclick="profil_personel_giris_cikis_getir('<%=personel_id %>', this);" class="icon icon-box"><div><%=LNG("Giriş-Çıkış Bilgileri")%></div></a></li>
                    <li class="nav-link_yeni"><a  style=" padding-top:15px; height:75px;" href="#izin_bilgileri" onclick="profil_personel_izin_getir('<%=personel_id %>', this);" class="icon icon-display"><div><%=LNG("İzin Bilgileri")%></div></a></li>
                    <li class="nav-link_yeni"><a style=" padding-top:15px; height:75px;" href="#mesai_bilgileri" onclick="profil_personel_mesai_getir('<%=personel_id %>', this);" class="icon icon-upload"><div><%=LNG("Mesai Bilgileri")%></div></a></li>
                    <li class="nav-link_yeni"><a style=" padding-top:15px; height:75px;" href="#bordrolar" onclick="profil_personel_bordro_getir('<%=personel_id %>', this);" class="icon icon-tools"><div><%=LNG("Bordrolarım")%></div></a></li>
                </ul>
            </nav>
            <div class="content-wrap">
                <section id="personel_bilgileri" class="personel_tablar">
                </section>
                <section id="giris_cikis" class="personel_tablar"></section>
                <section id="izin_bilgileri" class="personel_tablar"></section>
                <section id="mesai_bilgileri" class="personel_tablar"></section>
                <section id="bordrolar" class="personel_tablar"></section>
            </div>
        </div>
    </div>
</div>





                                        </div>
                                    </div>
                                </div>
                                <div id="styleSelector"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="/files/bower_components/jquery/js/jquery.min.js "></script>
    <script src="/files/bower_components/jquery-ui/js/jquery-ui.min.js "></script>
    <script src="/files/bower_components/popper.js/js/popper.min.js"></script>
    <script src="/files/bower_components/bootstrap/js/bootstrap.min.js "></script>
    <script src="/files/assets/pages/widget/excanvas.js "></script>
    <script src="/files/bower_components/jquery-slimscroll/js/jquery.slimscroll.js "></script>
    <script src="/files/bower_components/modernizr/js/modernizr.js "></script>
    <script src="/files/assets/js/SmoothScroll.js"></script>
    <script src="/files/assets/js/jquery.mCustomScrollbar.concat.min.js "></script>
    <script src="/files/bower_components/chart.js/js/Chart.js"></script>
    <script src="/files/assets/pages/widget/amchart/amcharts.js"></script>
    <script src="/files/assets/pages/widget/amchart/serial.js"></script>
    <script src="/files/assets/pages/widget/amchart/light.js"></script>
    <script src="/files/assets/js/pcoded.js"></script>
    <script src="/files/assets/js/vertical/vertical-layout.js"></script>
    <script src="/files/assets/js/script.js"></script>
    <script src="/files/assets/js/bootstrap-growl.min.js"></script>
    <script src="/js/plugin/jquery-touch/jquery.ui.touch-punch.min.js"></script>
    <script src="/js/plugin/easy-pie-chart/jquery.easy-pie-chart.min.js"></script>
    <script src="/js/plugin/sparkline/jquery.sparkline.min.js"></script>
    <script src="/js/plugin/masked-input/jquery.maskedinput.min.js"></script>
    <script src="/js/plugin/bootstrap-slider/bootstrap-slider.min.js"></script>
    <script src="/js/plugin/msie-fix/jquery.mb.browser.min.js"></script>
    <script src="/js/plugin/fastclick/fastclick.min.js"></script>
    <script src="/js/smart-chat-ui/smart.chat.ui.min.js"></script>
    <script src="/js/smart-chat-ui/smart.chat.manager.min.js"></script>
    <script src="/js/plugin/flot/jquery.flot.cust.min.js"></script>
    <script src="/js/plugin/flot/jquery.flot.resize.min.js"></script>
    <script src="/js/plugin/flot/jquery.flot.time.min.js"></script>
    <script src="/js/plugin/flot/jquery.flot.tooltip.min.js"></script>
    <script src="/js/plugin/vectormap/jquery-jvectormap-1.2.2.min.js"></script>
    <script src="/js/plugin/vectormap/jquery-jvectormap-world-mill-en.js"></script>
    <script src="/js/plugin/moment/moment.min.js"></script>
    <script src="/js/plugin/fullcalendar/jquery.fullcalendar.min.js"></script>

    <script src="/js/plugin/datatables/jquery.dataTables.min.js"></script>
    <script src="/js/plugin/datatables/dataTables.colVis.min.js"></script>
    <script src="/js/plugin/datatables/dataTables.tableTools.min.js"></script>
    <script src="/js/plugin/datatables/dataTables.bootstrap.min.js"></script>
    <script src="/js/plugin/datatable-responsive/datatables.responsive.min.js"></script>
    

    <script src="/files/assets/pages/data-table/js/jszip.min.js"></script>
    <script src="/files/assets/pages/data-table/js/pdfmake.min.js"></script>
    <script src="/files/assets/pages/data-table/js/vfs_fonts.js"></script>
    <script src="/files/bower_components/switchery/js/switchery.min.js"></script>
    <script src="/files/bower_components/sweetalert/js/sweetalert.min.js"></script>
    <script src="/files/bower_components/pnotify/js/pnotify.js"></script>
    <script src="/files/bower_components/pnotify/js/pnotify.mobile.js"></script>
    <script src="/files/bower_components/pnotify/js/pnotify.buttons.js"></script>
    <script src="/js/select2.full.min.js"></script>

    <script src="https://maps.googleapis.com/maps/api/js?sensor=false&key=AIzaSyADkAddLO7eqRWbN-6DrgG4xkbCsbI6WKg"></script>
    <script src="/js/components/filestyle/jquery.filestyle.js"></script>
    <script src="/js/yeniimage.js"></script>
    <script src="/js/plugin/jquery-validate/jquery.validate.min.js"></script>
    <script src="/js/plugin/bootstrapvalidator/bootstrapValidator.min.js"></script>
    <script src="/js/plugin/noUiSlider/jquery.nouislider.min.js"></script>
    <script src="/js/autosize.js"></script>
    <link rel="stylesheet" href="/css/multiple-select.css" />
    <script src="/js/multiple-select.js"></script>
    <script src="/js/plugin/flot/jquery.flot.tooltip.min.js"></script>
    <script src="https://d3js.org/d3-path.v1.min.js"></script>
    <script src="https://d3js.org/d3-shape.v1.min.js"></script>
    <div style="display: none;" id="koftiden"></div>
    <script src="/files/assets/pages/chart/knob/jquery.knob.js"></script>
    <script src="/js/tasimalar.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.8.1/moment-with-locales.min.js"></script>
    <script src="/js/vis.js"></script>
    <script src="/js/proskop.js"></script>
    <script src="/js/proskop_script.js"></script>
    <script src="/js/proskop_script2.js"></script>
    <script type="text/javascript" charset="utf-8" src="/js/components/jquery.autotab-1.1b.js"></script>
    <script type="text/javascript" charset="utf-8" src="https://code.jquery.com/jquery-migrate-3.0.0.js"></script>
    <script type="text/javascript" src="/js/spectrum.js"></script>
    <script src="https://www.gstatic.com/charts/loader.js"></script>
      <script src="/js/tabs/js/cbpFWTabs.js"></script>
    <script src="/js/jquery.maskMoney.js"></script>
    <script src="/js/components/print/jquery.printPage.js"></script>
    <script src="/js/easytimer/easytimer.min.js"></script>
    <div class="modal fade modal-flex" id="Modal-overflow3" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-dialog3 " role="document">
            <div class="modal-content">
                <div id="modal_div3"></div>
            </div>
        </div>
    </div>

    <div class="modal fade modal-flex" id="Modal-overflow2" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-dialog2" role="document">
            <div class="modal-content">
                <div id="modal_div2"></div>
            </div>
        </div>
    </div>

    <div class="modal fade modal-flex" id="Modal-overflow" tabindex="-1" role="dialog">
        <div class="modal-dialog " role="document">
            <div class="modal-content">
                <div id="modal_div"></div>
            </div>
        </div>
    </div>


    <button id="modal_butonum" style="display: none;" type="button" class="btn btn-danger waves-effect" data-toggle="modal" data-target="#Modal-overflow"></button>
    <button id="modal_butonum2" style="display: none;" type="button" class="btn btn-danger waves-effect" data-toggle="modal" data-target="#Modal-overflow2"></button>
    <button id="modal_butonum3" style="display: none;" type="button" class="btn btn-danger waves-effect" data-toggle="modal" data-target="#Modal-overflow3"></button>
    <script>
	    (function() {
		    [].slice.call( document.querySelectorAll( '.tabs' ) ).forEach( function( el ) {
			    new CBPFWTabs( el );
		    });
            $("#personel_ilk_buton").click();
	    })();
    </script>

</body>
</html>


