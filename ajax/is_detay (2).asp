<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001


    is_id = trn(request("is_id"))
    personel_id  = trn(request("personel_id"))



    SQL="select ISNULL(isler.GantAdimID,0) AS GantAdimIDs, (select isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + ', ' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select ',' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ISNULL(STUFF(((select ',' + bildirim.adi from ucgem_bildirim_cesitleri bildirim where (SELECT COUNT(value) FROM STRING_SPLIT(REPLACE(isler.kontrol_bildirim, 'null', ''), ',') WHERE value =  bildirim.id ) > 0 for xml path(''))), 1, 1, ''), 'Yok') as kontrol_bildirim2, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id where isler.id = '"& is_id &"'"
    set detay = baglanti.execute(SQL)

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
</head>
<body>
    <div class="theme-loader">
        <div class="loader-track">
            <svg id="loader2" viewBox="0 0 100 100">
                <circle id="circle-loader2" cx="50" cy="50" r="45"></circle>
            </svg>
        </div>
    </div>
    <div id="pcoded" class="pcoded" style="background-color:white;">
        <div class="pcoded-overlay-box"></div>
        <div class="pcoded-container navbar-wrapper">
        
            
            <div class="pcoded-main-container" style="background-color:white;">
                <div class="pcoded-wrapper">
                  
                    <div class="pcoded-contents">
                        <div class="pcoded-inner-content">
                            <div class="main-body">
                                <div class="page-wrapper">
                                    <div class="page-body">
                                        <div id="ortadiv" style="background-color:#fff;">
<form>
    <style>
        @media screen and (max-size:767px) {

            .mobil_iptal {
                display: none !important;
            }

            #demo-pill-nav li a {
                padding: 5px !important;
            }
        }
    </style>
    <div class="col-lg-4 col-md-12" style="padding-left:0;">
        <br />
        <br>
        <div style="display: none;">
            <div class="mobil_iptal" style="text-align: right;">
                <a class="btn btn-labeled btn-success btn-mini" href="javascript:void(0);" style="margin-top: -27px;">
                    <span class="btn-label"><i class="fa fa-download"></i></span><%=LNG("İndir")%>
                </a>
                &nbsp;&nbsp;
                <a class="btn btn-labeled btn-warning btn-mini" href="javascript:void(0);" style="margin-top: -27px;">
                    <span class="btn-label"><i class="fa fa-print"></i></span><%=LNG("Yazdır")%>
                </a>
                &nbsp;&nbsp;
                <a class="btn btn-labeled btn-primary btn-mini" href="javascript:void(0);" style="margin-top: -27px;">
                    <span class="btn-label"><i class="fa fa-send "></i></span><%=LNG("Gönder")%>
                </a>
            </div>
        </div>
        <div class="well">
            <table border="0" cellpadding="5" cellspacing="0" class="tablom_detay" style="width: 100%;">
                <tr style="display: none;">
                    <td style="width: 100px"><strong><%=LNG("Adı")%></strong></td>
                    <td style="width: 10px;">:</td>
                    <td>
                        <%=detay("aciklama") %>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <div style="float: left; width: 160px;"><strong><%=LNG("İş Tanımı")%></strong></div>
                        :&nbsp;&nbsp;&nbsp;<%=detay("adi") %></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td style="width: 150px"><strong><%=LNG("Görevliler")%></strong></td>
                    <td style="width: 5px;">:</td>
                    <td>
                        <%=detay("gorevli_personeller") %>
                    </td>
                </tr>
                <tr>
                    <td><strong><%=LNG("Etiketler")%></strong></td>
                    <td>:</td>
                    <td>
                        <%=detay("departman_isimleri") %>
                    </td>
                </tr>
                <tr>
                    <td><strong><%=LNG("Öncelik")%></strong></td>
                    <td>:</td>
                    <td>
                        <%=detay("oncelik") %>
                    </td>
                </tr>
                <tr>
                    <td><strong><%=LNG("Planlanan Başlangıç")%></strong></td>
                    <td>:</td>
                    <td>
                        <%=cdate(detay("baslangic_tarihi")) %>&nbsp;<%=left(detay("baslangic_saati"),5) %>
                    </td>
                </tr>
                <tr>
                    <td><strong><%=LNG("Planlanan Bitiş")%></strong></td>
                    <td>:</td>
                    <td>
                        <%=cdate(detay("bitis_tarihi")) %>&nbsp;<%=left(detay("bitis_saati"),5) %>
                    </td>
                </tr>
                <tr>
                    <td><strong><%=LNG("Kontrol ve Bildirim")%></strong></td>
                    <td>:</td>
                    <td>
                        <%=detay("kontrol_bildirim2") %>
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <% if trim(detay("ekleyen_id")) = personel_id then %>
        <% if trim(detay("GantAdimIDs"))="0" then %>
        <a href="javascript:void(0);" class="btn btn-labeled btn-info btn-mini" onclick="is_kaydini_duzenle('<%=detay("id") %>'); return false;"><span class="btn-label"><i class="fa fa-edit "></i></span><%=LNG("Kaydı Düzenle")%></a>
        <% end if %>
        <% if trim(detay("durum"))="false" then %>
        <a href="javascript:void(0);" class="btn btn-labeled btn-danger btn-mini" onclick="isi_iptal_et('<%=detay("id") %>'); return false;"><span class='btn-label'><i class='fa fa-times'></i></span><%=LNG("İşi Aktif Et")%></a>
        <% else %>
        <a href="javascript:void(0);" class="btn btn-labeled btn-danger btn-mini" onclick="isi_iptal_et('<%=detay("id") %>'); return false;"><span class="btn-label"><i class="fa fa-times"></i></span><%=LNG("İşi İptal Et")%></a>
        <% end if %>
        <% end if %>
        <div style="display: none;">
            <input type="hidden" renk="<%=detay("renk") %>" baslangic_tarihi="<%=cdate(detay("baslangic_tarihi")) %>" baslangic_saati="<%=left(detay("baslangic_saati"),5) %>" bitis_tarihi="<%=cdate(detay("bitis_tarihi")) %>" bitis_saati="<%=left(detay("bitis_saati"),5) %>" idd="<%=is_id %>" adi="<%=detay("adi") %>" etiketler="<%=detay("departman_isimleri") %>" ekleyen="<%=detay("ekleyen_adsoyad") %>" class="guncel_lineer" id="guncel_lineer" />
          
        </div>
        <br />
        <br />
    </div>
    <div class="col-lg-7 col-md-12" style="padding-right:0;">
        <div class="widget-body">
            <div class="tabs-top">
                <ul class="nav nav-tabs  tabs is_tab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" data-toggle="tab" href="#tab-r1" role="tab"><%=LNG("İş Durumu")%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#tab-r5" id="parcalar_tab_buton" onclick="parcalar_ve_iscilik_getir('<%=is_id %>');" role="tab"><%=LNG("Parçalar / Cihazlar")%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#tab-r2" id="is_yazisma_tab_buton" onclick="is_yazisma_yeni_goster('<%=is_id %>');" role="tab"><%=LNG("Yazışmalar")%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#tab-r3" id="dosya_listesi_tab_buton" onclick="dosya_listesi_getir_montaj('<%=is_id %>');" role="tab"><%=LNG("Dosyalar")%></a>
                    </li>
                   
                </ul>
                <!-- Tab panes -->
                <div class="tab-content tabs card-block">
                    <div class="tab-pane" id="tab-r5" role="tabpanel">
                        <div id="parcalar_iscilik_donus_yeri<%=is_id %>"></div>
                    </div>
                    <div class="tab-pane active" id="tab-r1" role="tabpanel">
                        <legend><%=LNG("Görevliler")%></legend>
                        <%
                        SQL="SELECT iss.adi, dbo.DakikadanSaatYap( ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT(DATETIME, olay.baslangic) + CONVERT(DATETIME, olay.baslangic_saati), CONVERT(DATETIME, olay.bitis) + CONVERT(DATETIME, olay.bitis_saati) ) ) ), 0 ) FROM dbo.ahtapot_ajanda_olay_listesi olay WITH (NOLOCK) WHERE olay.IsID = gorevli.is_id and olay.etiket = 'personel' and olay.etiket_id = '"& personel_id &"' AND olay.durum = 'true' AND olay.cop = 'false' ) ) AS harcanan, CASE WHEN (DATEDIFF( n, DATEADD( n, ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT(DATETIME, olay.baslangic) + CONVERT(DATETIME, olay.baslangic_saati), CONVERT(DATETIME, olay.bitis) + CONVERT(DATETIME, olay.bitis_saati) ) ) ), 0 ) FROM dbo.ahtapot_ajanda_olay_listesi olay WITH (NOLOCK) WHERE olay.IsID = gorevli.is_id AND olay.durum = 'true' AND olay.cop = 'false' ), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ), DATEADD( n, dbo.SaattenDakikaYap(ISNULL(gorevli.toplam_sure, '00:00')), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ) ) ) < 0 THEN '-' ELSE '' END + dbo.DakikadanSaatYap( CASE WHEN (DATEDIFF( n, DATEADD( n, ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT( DATETIME, olay.baslangic ) + CONVERT( DATETIME, olay.baslangic_saati ), CONVERT( DATETIME, olay.bitis ) + CONVERT( DATETIME, olay.bitis_saati ) ) ) ), 0 ) FROM dbo.ahtapot_ajanda_olay_listesi olay WITH (NOLOCK) WHERE olay.IsID = gorevli.is_id AND olay.durum = 'true' AND olay.cop = 'false' ), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ), DATEADD( n, dbo.SaattenDakikaYap(ISNULL( gorevli.toplam_sure, '00:00' ) ), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ) ) ) < 0 THEN -1 * DATEDIFF( n, DATEADD( n, ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT( DATETIME, olay.baslangic ) + CONVERT( DATETIME, olay.baslangic_saati ), CONVERT( DATETIME, olay.bitis ) + CONVERT( DATETIME, olay.bitis_saati ) ) ) ), 0 ) FROM dbo.ahtapot_ajanda_olay_listesi olay WITH (NOLOCK) WHERE olay.IsID = gorevli.is_id AND olay.durum = 'true' AND olay.cop = 'false' ), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ), DATEADD( n, dbo.SaattenDakikaYap(ISNULL( gorevli.toplam_sure, '00:00' ) ), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ) ) ELSE DATEDIFF( n, DATEADD( n, ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT( DATETIME, olay.baslangic ) + CONVERT( DATETIME, olay.baslangic_saati ), CONVERT(DATETIME, olay.bitis) + CONVERT( DATETIME, olay.bitis_saati ) ) ) ), 0 ) FROM dbo.ahtapot_ajanda_olay_listesi olay WITH (NOLOCK) WHERE olay.IsID = gorevli.is_id AND olay.durum = 'true' AND olay.cop = 'false' ), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ), DATEADD( n, dbo.SaattenDakikaYap(ISNULL(gorevli.toplam_sure, '00:00')), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ) ) END ) AS kalan, ISNULL(gorevli.toplam_sure, '0:00') AS toplam_sure, ISNULL(gorevli.gunluk_sure, '0:00') AS gunluk_sure, ISNULL(gorevli.toplam_gun, '0:00') AS toplam_gun, CASE WHEN ISNULL(gorevli.toplam_sure, '0:00') = '0:00' THEN 0 ELSE 1 end AS GantAdimID, ISNULL(sinirlama_varmi, 0) as sinirlama_varmi, CONVERT(DATETIME, gorevli.ekleme_tarihi) + CONVERT(DATETIME, gorevli.ekleme_saati) AS tamamlanma_zamani, kullanici.personel_resim, kullanici.personel_ad + ' ' + kullanici.personel_soyad AS personel_adsoyad, gorevli.gorevli_id, gorevli.id, gorevli.tamamlanma_orani FROM ucgem_is_gorevli_durumlari gorevli WITH (NOLOCK) JOIN ucgem_firma_kullanici_listesi kullanici WITH (NOLOCK) ON kullanici.id = gorevli.gorevli_id JOIN ucgem_is_listesi iss ON iss.id = gorevli.is_id WHERE gorevli.is_id = '"& is_id &"' GROUP BY iss.adi, gorevli.toplam_sure, gorevli.gunluk_sure, gorevli.toplam_gun, ISNULL(iss.GantAdimID, 0), CONVERT(DATETIME, gorevli.ekleme_tarihi) + CONVERT(DATETIME, gorevli.ekleme_saati), kullanici.personel_resim, kullanici.personel_ad + ' ' + kullanici.personel_soyad, gorevli.gorevli_id, gorevli.id, gorevli.tamamlanma_orani, gorevli.is_id, iss.baslangic_tarihi, iss.sinirlama_varmi;"
                        set gorevli = baglanti.execute(SQL)
                        do while not gorevli.eof

                            if trim(gorevli("gorevli_id"))=trim(personel_id) then
                        %>
                        <div class="row">
                            <div class="col-xs-1">
                                <a rel="tooltip" data-original-title="<%=gorevli("personel_adsoyad") %>" data-placement="top" href="javascript:void(0)">
                                    <img style="width: 100%; min-width: 21px;" src="<%=gorevli("personel_resim") %>" class="online">
                                </a>
                            </div>

                            <div class="col-xs-8">
                                <% if cdbl(gorevli("tamamlanma_orani"))<100 then %>
                                <div style="width: 100%;">
                                    <div id="basicUsage" style="font-size: 40px; width: 165px; display: inline-block;">00:00:00</div>
                                    <input type="button" tamamlanmaid="<%=gorevli("id") %>" is_id="<%=is_id %>" class="startButton btn btn-success btn-lg mb-1" value="Başlat" style="margin-top: -15px;" />
                                    <input type="button" tamamlanmaid="<%=gorevli("id") %>" baslik="<%=gorevli("adi") %>" aciklama="<%=gorevli("adi") %> adlı işte ilerleme kaydedildi." is_id="<%=is_id %>" class="pauseButton btn btn-primary btn-lg mb-1" value="Duraklat" style="margin-top: -15px;" />
                                    <input type="button" tamamlanmaid="<%=gorevli("id") %>" is_id="<%=is_id %>" class="stopButton btn btn-danger btn-lg mb-1" value="Tamamlandı" style="margin-top: -15px;" />
                                </div>
                                <% else %>
                              <%=LNG("İşin Tamamlanma Durumu :")%>
                                <br />
                                <div class="nprogress">
                                    <div class="nprogress-bar nprogress-bar-striped nprogress-bar-success" role="progressbar" style="width: <%=gorevli("tamamlanma_orani") %>%" aria-valuenow="<%=gorevli("tamamlanma_orani") %>" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <% end if %>

                                <br />
                                <span style="float: left;">
                                    <% if trim(gorevli("sinirlama_varmi"))="0" then %>
                                    <table style="text-align: center;">
                                        <tr>
                                            <td><%=LNG("Harcanan Süre")%></td>
                                        </tr>
                                        <tr>
                                            <td><i class="fa fa-clock-o"></i><strong style="font-size: 15px;"><%=gorevli("harcanan") %></strong></td>
                                        </tr>
                                    </table>
                                    <% else %>
                                    <table style="text-align: center;">
                                        <tr>
                                            <td style="padding-right: 15px;"><%=LNG("Planlanan Çalışma(saat)")%></td>
                                            <td style="padding-right: 15px;"><%=LNG("Harcanan Süre")%></td>
                                            <td><%=LNG("Kalan Süre")%></td>
                                        </tr>
                                        <tr>
                                            <td style="padding-right: 15px;"><strong style="font-size: 15px;"><%=gorevli("gunluk_sure") & " X " & gorevli("toplam_gun") & " gün = " & gorevli("toplam_sure") %></strong></td>
                                            <td style="padding-right: 15px;"><i class="fa fa-clock-o"></i><strong style="font-size: 15px;"><%=gorevli("harcanan") %></strong></td>
                                            <td><i class="fa fa-clock-o"></i><strong style="font-size: 15px;"><%=gorevli("toplam_sure") %></strong></td>
                                        </tr>
                                    </table>
                                    <% end if %>
                                </span>
                                <span style="float: right;">Son Güncelleme : <%=gorevli("tamamlanma_zamani") %></span>
                            </div>

                            <!--<div class="col-xs-8">
                                
                                    
                                &nbsp;&nbsp;&nbsp;<%=LNG("İşin Tamamlanma Durumu :")%>
                                <br />
                                    <div start="<%=gorevli("tamamlanma_orani") %>" class="yeni_slider" isid="<%=is_id %>" tamamlanmaid="<%=gorevli("id") %>" id="is_durum<%=gorevli("id") %>" value="<%=gorevli("tamamlanma_orani") %>"></div>
                            
                                <br />
                                <span style="float: left;">
                                    <% if trim(gorevli("sinirlama_varmi"))="0" then %>
                                    <table style="text-align: center;">
                                        <tr>
                                            <td><%=LNG("Harcanan Süre")%></td>
                                        </tr>
                                        <tr>
                                            <td><i class="fa fa-clock-o"></i><strong style="font-size: 15px;"><%=gorevli("harcanan") %></strong></td>
                                        </tr>
                                    </table>
                                    <% else %>
                                    <table style="text-align: center;">
                                        <tr>
                                            <td style="padding-right: 15px;"><%=LNG("Planlanan Çalışma(saat)")%></td>
                                            <td style="padding-right: 15px;"><%=LNG("Harcanan Süre")%></td>
                                            <td><%=LNG("Kalan Süre")%></td>
                                        </tr>
                                        <tr>
                                            <td style="padding-right: 15px;"><strong style="font-size: 15px;"><%=gorevli("gunluk_sure") & " X " & gorevli("toplam_gun") & " gün = " & gorevli("toplam_sure") %></strong></td>
                                            <td style="padding-right: 15px;"><i class="fa fa-clock-o"></i><strong style="font-size: 15px;"><%=gorevli("harcanan") %></strong></td>
                                            <td><i class="fa fa-clock-o"></i><strong style="font-size: 15px;"><%=gorevli("toplam_sure") %></strong></td>
                                        </tr>
                                    </table>
                                    <% end if %>
                                </span>
                                <span style="float: right;">Son Güncelleme : <%=gorevli("tamamlanma_zamani") %></span>
                                    
                               

                            </div>-->

                            <div class="col-xs-1 hidden-xs" style="padding-top: 5px;">
                                <input id="easyPieChart<%=gorevli("id") %>" type="text" class="dial easyPieChartlar" value="<%=gorevli("tamamlanma_orani") %>" data-width="68" data-height="75" data-linecap="round" data-displayprevious="true" data-displayinput="true" data-readonly="true" data-fgcolor="#4ECDC4">
                            </div>
                            <div class="col-xs-1" style="padding-top: 5px;">
                                <input type="button" class="btn btn-danger btn-sm" onclick="is_personel_durt('<%=gorevli("gorevli_id") %>', '<%=is_id %>');" value="<%=LNG("Dürt")%>" />
                            </div>
                        </div>

                        <!--<div class="row">
                            <div class="col-xs-1" style="min-height:100px;"></div>
                            <div class="col-xs-8">
                                 <div id="basicUsage" style="font-size:40px;">00:00:00</div>
                                
                                <button class="startButton btn btn-success btn-lg mb-1">Başlat</button>
                                <button class="pauseButton btn btn-primary btn-lg mb-1">Duraklat</button>
                                <button class="stopButton btn btn-danger btn-lg mb-1">Tamamlandı</button>

                            </div>
                        </div>-->
                        <hr />
                        <% else %>

                        <div class="row">
                            <div class="col-xs-1">
                                <a rel="tooltip" data-original-title="<%=gorevli("personel_adsoyad") %>" data-placement="top" href="javascript:void(0)">
                                    <img style="width: 100%; min-width: 21px;" src="<%=gorevli("personel_resim") %>" class="online"></a>
                            </div>
                            <div class="col-xs-1">
                                <input id="easyPieChartlar" type="text" class="dial easyPieChartlar" value="<%=gorevli("tamamlanma_orani") %>" data-width="68" data-height="75" data-linecap="round" data-displayprevious="true" data-displayinput="true" data-readonly="true" data-fgcolor="#40c4ff">
                            </div>
                            <div class="col-xs-8">
                                <%=LNG("İşin Tamamlanma Durumu :")%>
                                <br />
                                <div class="nprogress">
                                    <div class="nprogress-bar nprogress-bar-striped nprogress-bar-success" role="progressbar" style="width: <%=gorevli("tamamlanma_orani") %>%" aria-valuenow="<%=gorevli("tamamlanma_orani") %>" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <br />
                                <span style="float: left;">
                                    <% if trim(gorevli("sinirlama_varmi"))="0" then %>
                                    <table style="text-align: center;">
                                        <tr>
                                            <td><%=LNG("Harcanan Süre")%></td>
                                        </tr>
                                        <tr>
                                            <td><i class="fa fa-clock-o"></i><strong style="font-size: 15px;"><%=gorevli("harcanan") %></strong></td>
                                        </tr>
                                    </table>
                                    <% else %>
                                    <table style="text-align: center;">
                                        <tr>
                                            <td style="padding-right: 15px;"><%=LNG("Planlanan Çalışma(saat)")%></td>
                                            <td style="padding-right: 15px;"><%=LNG("Harcanan Süre")%></td>
                                            <td><%=LNG("Kalan Süre")%></td>
                                        </tr>
                                        <tr>
                                            <td style="padding-right: 15px;"><strong style="font-size: 15px;"><%=gorevli("gunluk_sure") & " X " & gorevli("toplam_gun") & " gün = " & gorevli("toplam_sure") %></strong></td>
                                            <td style="padding-right: 15px;"><i class="fa fa-clock-o"></i><strong style="font-size: 15px;"><%=gorevli("harcanan") %></strong></td>
                                            <td><i class="fa fa-clock-o"></i><strong style="font-size: 15px;"><%=gorevli("toplam_sure") %></strong></td>
                                        </tr>
                                    </table>
                                    <% end if %>
                                </span><span style="float: right; padding-top: 0px;"><%=LNG("Son Güncelleme :")%> <%=gorevli("tamamlanma_zamani") %></span>
                            </div>
                            <div class="col-xs-1 " style="padding-top: 5px;">
                                <input type="button" class="btn btn-danger btn-sm" onclick="is_personel_durt('<%=gorevli("gorevli_id") %>', '<%=is_id %>');" value="<%=LNG("Dürt")%>" />
                            </div>
                        </div>
                        <hr />
                        <%
                            end if
                        %>
                        <div class="row">
                            <div class="col-xs-1"></div>
                            <div class="col-xs-11">
                                <div id="is_timer_list<%=is_id %>" style="width: 100%; margin-top: 50px;"></div>
                            </div>
                        </div>
                        <%
                        gorevli.movenext
                        loop
                        %>
                    </div>
                    <div class="tab-pane" id="tab-r2" role="tabpanel">
                        <div class="chat-body no-padding profile-message" style="overflow-y: auto; height: 400px!important; padding-bottom: 30px!important;" id="ChatBody<%=is_id %>"></div>
                        <div class="input-group wall-comsment-reply" style="width: 85%; padding-left: 96px!important;">
                            <input type="text" id="chat_yazi<%=is_id %>" onkeyup="return false;" class="form-control chat_yazi" placeholder="<%=LNG("Bir mesaj yaz...")%>" />
                            <span class="input-group-btn">
                                <a id="yazisma_gonder_button" class="btn btn-primary" onclick="is_yazisma_yeni_gonder('<%=is_id %>');" style="margin-left: 15px; color: white;"><i class="fa fa-reply"></i><%=LNG("Gönder")%></a>
                            </span>
                        </div>
                    </div>
                    <div class="tab-pane" id="tab-r3" role="tabpanel">
                        <div class="row">
                            <br />
                            <div class="col-md-3">
                                <h4><%=LNG("Dosya Ekle")%></h4>
                                <br />
                                <input type="file" value="/img/kucukboy.png" tip="kucuk" yol="dosya_deposu/" style="height: 31px!important;" id="dosya_yolu<%=is_id %>" />
                                <br />
                                <%=LNG("Dosya Adı:")%><br />
                                <input type="text" id="dosya_adi<%=is_id %>" />
                                <br />
                                <br />
                                <input type="button" class="btn btn-success" id="dosya_kaydet_buton" value="<%=LNG("Kaydet")%>" onclick="yeni_is_dosya_ekle('<%=is_id %>'); return false;" />
                                <br />

                            </div>
                            <div class="col-md-8">
                                <h4><%=LNG("Dosya Listesi")%></h4>
                                <br />
                                <div class="table-responsive">
                                    <div id="dosya_listesi<%=is_id %>"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                  
                </div>
            </div>
        </div>
    </div>
</form>


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

    
<script>
    $(function (){
    
    
                    $(".easyPieChartlar").knob({
                        draw: function () {
                            // "tron" case
                            if (this.$.data('skin') == 'tron') {
                                this.cursorExt = 0.3;
                                var a = this.arc(this.cv) // Arc
                                    ,
                                    pa // Previous arc
                                    , r = 1;
                                this.g.lineWidth = this.lineWidth;
                                if (this.o.displayPrevious) {
                                    pa = this.arc(this.v);
                                    this.g.beginPath();
                                    this.g.strokeStyle = this.pColor;
                                    this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, pa.s, pa.e, pa.d);
                                    this.g.stroke();
                                }
                                this.g.beginPath();
                                this.g.strokeStyle = r ? this.o.fgColor : this.fgColor;
                                this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, a.s, a.e, a.d);
                                this.g.stroke();
                                this.g.lineWidth = 2;
                                this.g.beginPath();
                                this.g.strokeStyle = this.o.fgColor;
                                this.g.arc(this.xy, this.xy, this.radius - this.lineWidth + 1 + this.lineWidth * 2 / 3, 0, 2 * Math.PI, false);
                                this.g.stroke();
                                return false;
                            }
                        }
                    });
                    is_timer_start_kaydi_getir(<%=is_id %>);

                    $('.pauseButton').hide();
                    $('.stopButton').hide();

                    timer = new easytimer.Timer();

                    $('.startButton').click(function () {
                        $(this).hide();
                        $('.pauseButton').show();
                        $('.stopButton').show();
                        timer.start();
                        var is_id = $(this).attr("is_id");
                        var TamamlanmaID = $(this).attr("tamamlanmaid");
                        is_timer_start_kaydi(is_id, TamamlanmaID, timer.getTimeValues());
                    });
                    $('.pauseButton').click(function () {
                        $(this).hide();
                        $('.startButton').show();
                        var baslik = $(this).attr("baslik");
                        var aciklama = $(this).attr("aciklama");
                        var is_id = $(this).attr("is_id");
                        var TamamlanmaID = $(this).attr("tamamlanmaid");
                        timer.pause();
                        is_timer_pause_kaydi(is_id, TamamlanmaID, timer.getTimeValues(), baslik, aciklama);
                    });
                    $('.stopButton').click(function () {
                        timer.stop();
                        var is_id = $(this).attr("is_id");
                        var TamamlanmaID = $(this).attr("tamamlanmaid");
                        var baslik = $('.pauseButton').attr("baslik");
                        var aciklama = $('.pauseButton').attr("aciklama");
                        is_timer_stop_kaydi(is_id, TamamlanmaID, timer.getTimeValues(), baslik, aciklama);

                    });

                    timer.addEventListener('secondsUpdated', function (e) {
                        $('#basicUsage').html(timer.getTimeValues().toString());
                    });
                    timer.addEventListener('started', function (e) {
                        $('#basicUsage').html(timer.getTimeValues().toString());
                    });


                    $(".yeni_slider").each(function () {

                        var $slider = $(this);
                        var olcu = $(this).width();

                        $(this).noUiSlider({
                            range: [0, 100],
                            start: $(this).attr("start"),
                            handles: 1,
                            connect: true,
                            slide: function () {

                                var asd = $(this);

                                clearTimeout(slider_timer);
                                slider_timer = setTimeout(function () {

                                    var oran = parseInt(asd.find(".noUi-connect").css("left"));
                                    oran = Math.round(100 - ((olcu - oran) / olcu * 100));
                                    var newVal = oran;

                                    if (parseFloat(newVal) > 97) {
                                        newVal = 100;
                                    }

                                    var onceki_oran = $("#easyPieChart" + $slider.attr("TamamlanmaID")).val();

                                    $("#easyPieChart" + $slider.attr("TamamlanmaID")).val(newVal);



                                    $("#easyPieChart" + $slider.attr("TamamlanmaID")).knob({
                                        draw: function () {
                                            // "tron" case
                                            if (this.$.data('skin') == 'tron') {
                                                this.cursorExt = 0.3;
                                                var a = this.arc(this.cv) // Arc
                                                    ,
                                                    pa // Previous arc
                                                    , r = 1;
                                                this.g.lineWidth = this.lineWidth;
                                                if (this.o.displayPrevious) {
                                                    pa = this.arc(this.v);
                                                    this.g.beginPath();
                                                    this.g.strokeStyle = this.pColor;
                                                    this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, pa.s, pa.e, pa.d);
                                                    this.g.stroke();
                                                }
                                                this.g.beginPath();
                                                this.g.strokeStyle = r ? this.o.fgColor : this.fgColor;
                                                this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, a.s, a.e, a.d);
                                                this.g.stroke();
                                                this.g.lineWidth = 2;
                                                this.g.beginPath();
                                                this.g.strokeStyle = this.o.fgColor;
                                                this.g.arc(this.xy, this.xy, this.radius - this.lineWidth + 1 + this.lineWidth * 2 / 3, 0, 2 * Math.PI, false);
                                                this.g.stroke();
                                                return false;
                                            }
                                        }
                                    });


                                    /*
                                     * 
                                    var data = "TamamlanmaID=" + $slider.attr("TamamlanmaID");
                                    data += "&tamamlanma_orani=" + newVal;
                                    data += "&IsID=" + $slider.attr("IsID");
                                    var IsID = $slider.attr("IsID");
                                    $.ajax({
                                        type: "POST",
                                        url: "/System_Root/ajax/islem1.aspx/IsDurumGuncelle",
                                        data: JSON.stringify(QueryStringToJSON(data)),
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function (response) {
                                            if (response.d == "0") {
                                                $.bigBox({
                                                    title: "Uyarı",
                                                    content: "Hata Oluştu",
                                                    color: "#C46A69",
                                                    icon: "fa fa-warning shake animated",
                                                    number: "1",
                                                    timeout: 6000
                                                });
                                            } else {
                                                $("#is_chart" + IsID).css('width', response.d + '%').attr('aria-valuenow', response.d).attr("data-progressbar-value", response.d);
                                                mesaj_ver("Görevler", "Kayıt Başarıyla Güncellendi", "success");
                                            }
                                        }, failure: function (response) {

                                            $.bigBox({
                                                title: "Uyarı",
                                                content: "Hata Oluştu",
                                                color: "#C46A69",
                                                icon: "fa fa-warning shake animated",
                                                number: "1",
                                                timeout: 6000
                                            });
                                        }
                                    });

                                    */

                                    is_ilerleme_ajanda_senkronizasyon($slider.attr("TamamlanmaID"), newVal, $slider.attr("IsID"), onceki_oran);

                                }, 300);
                            }
                        });

                    });

                    fileyap();

                    setTimeout(function () {
                        $(".file").attr("placeholder", "Yeni Dosya Yükle").css("height", "25px").css("margin-top", "5px;");
                    }, 1000);
    
    });
</script>


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
</body>
</html>

