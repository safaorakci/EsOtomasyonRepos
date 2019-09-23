<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    proje_id = trn(request("id"))
    departman_id = trn(request("departman_id"))

    projeid = trn(request("proje_id"))
    tip = trn(request("tip"))

    SQL="select firma.firma_adi, * from ucgem_proje_listesi proje join ucgem_firma_listesi firma on firma.id = proje.proje_firma_id where proje.id = '"& proje_id &"'"
    set firma = baglanti.execute(SQL)
   
%>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="/js/gantt/ganttUtilities.js"></script>
<script src="/js/gantt/ganttTask.js"></script>
<script src="/js/gantt/ganttDrawerSVG.js"></script>
<script src="/js/gantt/ganttZoom.js"></script>
<script src="/js/gantt/ganttGridEditor.js"></script>
<script src="/js/gantt/ganttMaster.js"></script>

<div class="page-body breadcrumb-page">
    <div class="card page-header p-0">
        <div class="card-block front-icon-breadcrumb row align-items-end">
            <div class="breadcrumb-header col">
                <div class="big-icon">
                    <div class="card-block user-info" style=" bottom: -73px; width:70%;">
                        <div class="media-left">
                            <a href="#" class="profile-image">
                                <img class="user-img img-radius" src="/upload/upload/ahtapot_26.07.2018_10.42.50_GDIbg.jpg" style="width: 140px!important; height:149px!important;">
                            </a>
                        </div>
                    </div>
                </div>
                <div class="d-inline-block" style="padding-left: 175px;">
                    <h5 style="font-size:15px;"><%=firma("proje_adi") %></h5>
                    <span><%=firma("firma_adi") %></span>
                </div>

                 <span style="float:right;">
                    <a href="javascript:void(0);" onclick="santiye_sil('<%=proje_id %>');" class="btn btn-mini btn-danger btn-round" style="color: white; float:right;"><i class="fa fa-search"></i>&nbsp;<%=LNG("Proje Sil")%></a>
                    <a href="javascript:void(0);" onclick="sayfagetir('/santiyeler/','jsid=4559&acilacak=<%=departman_id %>');" class="btn btn-mini btn-labeled btn-success  btn-round" style="color: white; float:right; margin-right:10px;"><span class="btn-label" style="color: white;"><i class="fa fa-history"></i></span>&nbsp;<%=LNG("Geri Dön")%></a>
                </span>


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
                    <li class="nav-link_yeni"><a tabindex="-1" style="-webkit-border-top-left-radius: 10px; -webkit-border-bottom-left-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-bottomleft: 10px; border-top-left-radius: 10px; border-bottom-left-radius: 10px;" href="#olaylar_tab" onclick="onbellekten_proje_olaylar_getir('<%=proje_id %>','<%=departman_id %>', this);" class="tabbuton icon icon-home"><span><%=LNG("Detay")%></span></a></li>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",89,")>0 then %>
                    <li class="nav-link_yeni"><a href="#planlama_tab" onclick="onbellekten_proje_planlama_getir('<%=proje_id %>', 'planlama', this);" class="tabbuton icon icon-box"><span><%=LNG("Planlama")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",90,")>0 then %>
                    <li class="nav-link_yeni"><a href="#uygulama_tab" onclick="onbellekten_proje_planlama_getir('<%=proje_id %>', 'uygulama', this);" class="tabbuton icon icon-display"><span><%=LNG("Uygulama")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",91,")>0 then %>
                    <li class="nav-link_yeni" style="display:none"><a href="#satinalma_tab" onclick="onbellekten_proje_satinalma_getir('<%=proje_id %>', this);" class="tabbuton icon icon-upload"><span><%=LNG("Maliyet")%></span></a></li>
                    <% end if %>
                    <li class="nav-link_yeni" style="display:none;"><a href="#gelir_tab" onclick="onbellekten_proje_gelir_getir('<%=proje_id %>', this); " class="tabbuton icon icon-tools"><span><%=LNG("Gelir")%></span></a></li>               
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",92,")>0 then %>
                    <li class="nav-link_yeni" style="display:none"><a href="#ajanda_tab" onclick="onbellekten_proje_ajanda_getir('<%=proje_id %>', this); " class="tabbuton icon icon-home"><span><%=LNG("Ajanda")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",93,")>0 then %>
                    <li class="nav-link_yeni"><a href="#dosyalar_tab" onclick="onbellekten_proje_dosyalari_getir('<%=proje_id %>', this); " class="tabbuton icon icon-box"><span><%=LNG("Dosya")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",94,")>0 then %>
                    <li class="nav-link_yeni"><a href="#is_listesi_tab" onclick="onbellekten_proje_is_listesi_getir('<%=proje_id %>', this); " class="tabbuton icon icon-display"><span><%=LNG("İş Listesi")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",95,")>0 then %>
                    <li class="nav-link_yeni"><a href="#servis_tab" onclick="onbellekten_servis_getir('<%=proje_id %>', this); " class="icon icon-upload"><span><%=LNG("Bakım")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",96,")>0 then %>
                    <li class="nav-link_yeni"><a href="#adam_saat_tab" onclick="onbellekten_santiye_adam_saat_getir('<%=proje_id %>', this); " class="icon icon-upload"><span><%=LNG("Adam-Saat")%></span></a></li>
                    <% end if %>
                    <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",97,")>0 then %>
                    <li class="nav-link_yeni"><a id="raporlar_tab_buton" href="#raporlar_tab" onclick="onbellekten_santiye_rapor_getir('<%=proje_id %>', this); " style="-webkit-border-top-right-radius: 10px; -webkit-border-bottom-right-radius: 10px; -moz-border-radius-topright: 10px; -moz-border-radius-bottomright: 10px; border-top-right-radius: 10px; border-bottom-right-radius: 10px;" class="icon icon-tools"><span><%=LNG("Raporlar")%></span></a></li>
                    <% end if %>
                </ul>
            </nav>
            <div class="content-wrap proje_usttab">
                <section id="olaylar_tab" class="proje_tablar">
                    <script>
                                $(function (){
                                    proje_olaylar_getir('<%=proje_id %>','<%=departman_id %>');
                                });
                    </script>
                </section>
                <section id="planlama_tab" class="proje_tablar">
                </section>
                <section id="uygulama_tab" class="proje_tablar">
                </section>
              
                <section id="satinalma_tab" class="proje_tablar">
                </section>
                <section id="gelir_tab" class="proje_tablar"></section>
                
                <section id="ajanda_tab" class="proje_tablar">
                </section>
                <section id="dosyalar_tab" class="proje_tablar">
                </section>
                <section id="is_listesi_tab" class="proje_tablar">
                </section>
                <section id="servis_tab" class="proje_tablar" style="padding-top:10px;">
                  
                </section>
                
                <section id="adam_saat_tab" class="proje_tablar">
                </section>
                <section id="raporlar_tab" class="proje_tablar">
                </section>
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
    
<style>
   /* .table td, .table th {
        padding: 5px !important;
    }*/
</style>
<!-- #include virtual="/ajax/include/yenidt.asp" -->
