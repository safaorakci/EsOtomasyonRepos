<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    firma_id = trn(request("firma_id"))
    yetki_kodu = trn(request("yetki_kodu"))

    SQL="select firma.*, sehir.sehir from ucgem_firma_listesi firma left join tanimlama_destinasyon_sehir sehir on sehir.id = firma.firma_sehir where firma.id = '"& firma_id &"'"
    set firma = baglanti.execute(SQL)

    sayi = 6
    if trim(yetki_kodu)="TASERON" then
        sayi = 8
    end if

    if firma("yetki_kodu")="BOSS" then
%>
<script>
    $(function (){
        sayfagetir('/yeni_firma_detaylari/', 'jsid=4559&firma_id=<%=firma_id %>&yetki_kodu=<%=yetki_kodu %>');
    });
</script>
<% 
    response.End
    end if %>

    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>

    <div class="page-body breadcrumb-page">
        <div class="card page-header p-0">
            <div class="card-block front-icon-breadcrumb row align-items-end">
                <div class="breadcrumb-header col">
                    <div class="big-icon">
                        <div class="card-block user-info" style=" bottom: -73px;">
                            <div class="media-left">
                                <a href="#" class="profile-image">
                                    <img class="user-img img-radius" src="<%=firma("firma_logo") %>" style="width: 140px!important; height:149px!important;">
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="d-inline-block" style="padding-left: 175px;">
                        <h5 style="font-size:15px;"><%=firma("firma_adi") %></h5>
                            <span><%=firma("firma_yetkili") %></span>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <style>
        .md-tabs .nav-item {
            width: calc(100% / <%=sayi%>);
            border-right: solid 1px #007bff;
        }

        .nav-tabs .slide {
            width: calc(100% / <%=sayi%>);
        }

        .yuvarla {
            font-size: 13px;
            border-radius: 50%;
            color: white;
            width: 25px;
            height: 25px;
            background-color: #4099ff;


            font-size: 14px;
            padding: 4px;
            margin-right: 10px;
            color: #fff;
            border-radius: 4px;
            width: 30px;
            display: inline-block;
            height: 30px;
            text-align: center;


        }
        .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active i {
            color: #fff!important;
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
    </style>

<div class="row">
    <div class="col-lg-12">
        <div class="tabs tabs-style-bar">
            <nav>
                <ul>
            <% if trim(yetki_kodu)="TASERON" then %>

                    <li style="display:none" class="nav-link_yeni"><a style="-webkit-border-top-left-radius: 10px; -webkit-border-bottom-left-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-bottomleft: 10px; border-top-left-radius: 10px; border-bottom-left-radius: 10px;" href="#musteri_bilgileri" onclick="musteri_bilgilerini_getir('<%=firma_id %>', this);" class="icon icon-home"><span><%=LNG("Müşteri")%></span></a></li>

                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",98,")>0 then %>
                    <li style="display:none" class="nav-link_yeni"><a href="#cari_hareketler" onclick="musteri_cari_hareketleri_getir('<%=firma_id %>', this);" class="icon icon-box"><span><%=LNG("Cari Hareketler")%></span></a></li>
                    <% end if %>
                    
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",111,")>0 then %>
                    <li style="display:none" class="nav-link_yeni"><a href="#zimmet" onclick="firma_zimmet_getir('firma', '<%=firma_id %>', this);" class="icon icon-display"><span><%=LNG("Zimmet")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",99,")>0 then %>
                    <li style="display:none" class="nav-link_yeni"><a href="#dosyalar" onclick="musteri_dosyalari_getir('<%=firma_id %>', this);" class="icon icon-upload"><span><%=LNG("Dosyalar")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",100,")>0 then %>
                    <li style="display:none" class="nav-link_yeni"><a href="#ajanda" onclick="musteri_ajanda_getir('<%=firma_id %>', this);" class="icon icon-tools"><span><%=LNG("Ajanda")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",101,")>0 then %>
                    <li style="display:none" class="nav-link_yeni"><a href="#is_listesi_panel" onclick="musteri_is_listesi_getir('<%=firma_id %>', this);" class="icon icon-home"><span><%=LNG("İş Listesi")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",112,")>0 then %>
                    <li style="display:none" class="nav-link_yeni"><a href="#adamsaat"  onclick="taseron_adamsaat_getir('<%=firma_id %>', this, '<%=month(date) %>', '<%=year(date) %>');" class="icon icon-box"><span> <%=LNG("Adam Saat")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",102,")>0 then %>
                    <li style="display:none" class="nav-link_yeni"><a onclick="musteri_raporlarini_getir('<%=firma_id %>', this, this);" style="-webkit-border-top-right-radius: 10px; -webkit-border-bottom-right-radius: 10px; -moz-border-radius-topright: 10px; -moz-border-radius-bottomright: 10px; border-top-right-radius: 10px; border-bottom-right-radius: 10px;" href="#raporlar" class="icon icon-tools"><span><%=LNG("Raporlar")%></span></a></li>
                    <% end if %>
        <% else %>
                    <li class="nav-link_yeni"><a style="-webkit-border-top-left-radius: 10px; -webkit-border-bottom-left-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-bottomleft: 10px; border-top-left-radius: 10px; border-bottom-left-radius: 10px;" href="#musteri_bilgileri" onclick="musteri_bilgilerini_getir('<%=firma_id %>', this);" class="icon icon-home"><span><%=LNG("Müşteri")%></span></a></li>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",113,")>0 then %>
                    <li class="nav-link_yeni"><a href="#cari_hareketler" onclick="musteri_cari_hareketleri_getir('<%=firma_id %>', this);" class="icon icon-box"><span><%=LNG("Cari Hareketler")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",114,")>0 then %>                    
                    <li class="nav-link_yeni"><a href="#dosyalar" onclick="musteri_dosyalari_getir('<%=firma_id %>', this);" class="icon icon-upload"><span><%=LNG("Dosyalar")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",115,")>0 then %>
                    <li class="nav-link_yeni"><a href="#ajanda" onclick="musteri_ajanda_getir('<%=firma_id %>', this);" class="icon icon-tools"><span><%=LNG("Ajanda")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",116,")>0 then %>
                    <li class="nav-link_yeni"><a href="#is_listesi_panel" onclick="musteri_is_listesi_getir('<%=firma_id %>', this);" class="icon icon-home"><span><%=LNG("İş Listesi")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",117,")>0 then %>
                    <li class="nav-link_yeni"><a onclick="musteri_raporlarini_getir('<%=personel_id %>', this, this);" style="-webkit-border-top-right-radius: 10px; -webkit-border-bottom-right-radius: 10px; -moz-border-radius-topright: 10px; -moz-border-radius-bottomright: 10px; border-top-right-radius: 10px; border-bottom-right-radius: 10px;" href="#raporlar" class="icon icon-tools"><span><%=LNG("Raporlar")%></span></a></li>
                    <% end if %>
        <% end if %>
                </ul>
            </nav>
            <div class="content-wrap">
                <section id="musteri_bilgileri" class="musteri_tablari">
                <script>
                        $(function (){
                            musteri_bilgilerini_getir('<%=firma_id %>');
                        });
                    </script>
                </section>
                <section id="cari_hareketler" class="musteri_tablari"></section>
                <% if trim(yetki_kodu)="TASERON" then %>
                <section id="zimmet" class="musteri_tablari"></section>
                <% end if %>
                <section id="dosyalar" class="musteri_tablari"></section>
                <section id="ajanda" class="musteri_tablari"></section>
                <section id="is_listesi_panel" class="musteri_tablari"></section>
                <% if trim(yetki_kodu)="TASERON" then %>
                <section id="adamsaat" class="musteri_tablari"></section>
                <% end if %>
                <section id="raporlar" class="musteri_tablari"></section>

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
                        <a class="nav-link active" data-toggle="tab" href="#musteri_bilgileri" onclick="musteri_bilgilerini_getir('<%=firma_id %>');" role="tab"><span class="yuvarla"><i class="icofont icofont-home"></i></span> Müşteri</a>
                        <div class="slide"></div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#cari_hareketler" onclick="musteri_cari_hareketleri_getir('<%=firma_id %>');" role="tab"><span class="yuvarla" style="background-color:#2ed8b6;"><i class="icofont icofont-home"></i></span> Cari Hareketler</a>
                        <div class="slide"></div>
                    </li>
                    <% if trim(yetki_kodu)="TASERON" then %>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#zimmet" onclick="firma_zimmet_getir('firma', '<%=firma_id %>');" role="tab"><span class="yuvarla" style="background-color:#F88EA4;"><i class="icofont icofont-ui-settings"></i></span> Zimmet</a>
                        <div class="slide"></div>
                    </li>
                    <% end if %>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#dosyalar" onclick="musteri_dosyalari_getir('<%=firma_id %>');" role="tab"><span class="yuvarla" style="background-color:#2ed8b6;"><i class="icofont icofont-home"></i></span> Dosyalar</a>
                        <div class="slide"></div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#ajanda" onclick="musteri_ajanda_getir('<%=firma_id %>');" role="tab"><span class="yuvarla" style="background-color:#f1c40f;"><i class="icofont icofont-ui-user "></i></span> Ajanda</a>
                        <div class="slide"></div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#is_listesi_panel" onclick="musteri_is_listesi_getir('<%=firma_id %>');" role="tab"><span class="yuvarla" style="background-color:#ab7967;"><i class="icofont icofont-ui-message"></i></span> İş Listesi</a>
                        <div class="slide"></div>
                    </li>
                    <% if trim(yetki_kodu)="TASERON" then %>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#adamsaat" role="tab"><span class="yuvarla" style="background-color:#F88EA4;"><i class="icofont icofont-ui-settings"></i></span> Adam Saat</a>
                        <div class="slide"></div>
                    </li>
                    <% end if %>

                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#raporlar" onclick="musteri_raporlarini_getir('<%=firma_id %>');" role="tab"><span class="yuvarla" style="background-color:#39adb5;"><i class="icofont icofont-home"></i></span> Raporlar</a>
                        <div class="slide"></div>
                    </li>
                </ul>
            </div>
            <div class="tab-content">
                <div class="tab-pane active musteri_tablari" id="musteri_bilgileri" role="tabpanel">
                    <script>
                        $(function (){
                            musteri_bilgilerini_getir('<%=firma_id %>');
                        });
                    </script>
                </div>
                <% if trim(yetki_kodu)="TASERON" then %>
                <div class="tab-pane musteri_tablari" id="zimmet" role="tabpanel">
                    
                </div>

                <div class="tab-pane musteri_tablari" id="adamsaat" role="tabpanel">
                    
                </div>
                <% end if %>
                <div class="tab-pane musteri_tablari" id="cari_hareketler" role="tabpanel">
                    
                </div>
                <div class="tab-pane musteri_tablari" id="dosyalar" role="tabpanel">
                    
                </div>
                <div class="tab-pane musteri_tablari" id="ajanda" role="tabpanel">
                      
                </div>
                <div class="tab-pane musteri_tablari" id="is_listesi_panel" role="tabpanel">
                    
                </div>
                <div class="tab-pane musteri_tablari" id="raporlar" role="tabpanel">
                    
                </div>

            </div>
        </div>
    </div>
<% end if %>
