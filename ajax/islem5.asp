﻿<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    FirmaID = Request.Cookies("kullanici")("firma_id")

    if trn(request("islem"))="is_detay_goster" then

    is_id = trn(request("is_id"))

    SQL=" EXEC getIsKodu '"& is_id &"'"
    set detay = baglanti.execute(SQL)

    SQL = "select * from tbl_ModulYetkileri where FirmaId = '"& Request.Cookies("kullanici")("firma_id") &"'"
    set tblModulYetkiler = baglanti.execute(SQL)

    Dim protocol
    Dim domainName
    Dim fileName
    Dim queryString
    Dim url
    
    protocol = "http" 
    If lcase(request.ServerVariables("HTTPS"))<> "off" Then 
       protocol = "https" 
    End If

    domainName= Request.ServerVariables("SERVER_NAME") 
    
    url = domainName
    If Len(queryString) <> 0 Then
       url = url & "?" & queryString
    End If
%>
<link href="../js/select2.min.css" rel="stylesheet" />
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
    <div class="row">
            <div class="col-lg-4 col-sm-12 col-xs-11 col-md-12">
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
                    <!--<span class="btn-label"><i class="fa fa-send "></i></span><%=LNG("Gönder")%>-->
                </a>
            </div>
        </div>
        <button type="button" id="isDetayButon" class="btn btn-info btn-mini">İş Detayı</button>
        <script type="text/javascript">
            $("#isDetayButon").click(function () {
                $("#isDetayDiv").slideToggle();
            });

            $(document).ready(function () {
                if ($(window).width() <= 500) {
                    $(".startButton").removeClass("btn-lg").addClass("btn-mini");
                    $(".pauseButton").removeClass("btn-lg").addClass("btn-mini");
                    $(".stopButton").removeClass("btn-lg").addClass("btn-mini");
                    $("#sonGuncelleme").css("float", "left");
                    $("#sonGuncelleme").css("margin-top", "20px");
                    $("span sonGuncelleme2").css("margin-top", "20px");
                    $("span sonGuncelleme2").css("float", "left");
                    $(".wall-comsment-reply").css("padding-left", "0px");
                    $("div #yuzde").removeClass("col-xs-1").addClass("col-xs-10");
                    $("div #yuzde2").removeClass("col-xs-1").addClass("col-xs-3");
                    $("div #yuzde").css("margin-top", "15px").css("float", "right");
                    $("#tabDiv").css("padding", "0px");
                    $("#tabDiv").css("margin-left", "-8px");
                    $("#tablo_is_adi").css("width", "190px !important");
                    $("#islerTableRespon").removeClass("table-responsive");
                    $("#islerTableRespon").appendTo("mob", "true");
                    $("#xs-visible").show();
                    $(".isCalismaList").css("margin-top", "0px");
                    $("#yeniservisformu").css("margin-top", "10px");
                }
            });
        </script>
        <div class="well col-xs-11 mt-1" style="display: none; margin-top: 5px" id="isDetayDiv">
            <table border="0" cellpadding="5" cellspacing="0" class="tablom_detay">
                <tr>
                    <td style="width: 150px"><strong><%=LNG("İş Kodu")%></strong></td>
                    <td style="width: 5px;">:</td>
                    <td>
                        <%=detay("is_kodu") %>
                    </td>
                </tr>


                <tr style="display: none;">
                    <td style="width: 100px"><strong><%=LNG("Adı")%></strong></td>
                    <td style="width: 10px;">:</td>
                    <td>
                        <%=detay("aciklama") %>
                    </td>
                </tr>
                <tr>
                    <td style="width:150px"><strong><%=LNG("İş Tanımı")%></strong></td>
                    <td style="width:5px">:</td>
                    <td><%=detay("adi") %></td>
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
                        <% if IsNull(detay("proje")) then %> <%else %> <%=detay("proje") %> <br /> <%end if %>
                        <% if IsNull(detay("departman_isimleri")) then%> <%else %> <%=detay("departman_isimleri") %> <%end if %>
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

        <% if trim(detay("is_tipi"))="Servis" then %>
        <a href="javascript:void(0);" class="btn btn-labeled btn-primary btn-mini" onclick="servis_formu_ac('<%=detay("id") %>'); return false;"><span class="btn-label"><i class="fa fa-edit "></i></span><%=LNG("Servis Formu")%></a>
        <% end if %>
        <% if trim(detay("ekleyen_id")) = trim(Request.Cookies("kullanici")("kullanici_id")) then %>
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
            <script>
                    $(function () {
                        vis_element_guncelle();
                    });
            </script>
        </div>
        <br />
        <br />
    </div>
    <div class="col-lg-7 col-sm-12 col-xs-11 col-md-12">
        <div class="widget-body">
            <div class="tabs-top">
                <ul class="nav nav-tabs tabs is_tab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" data-toggle="tab" href="#tab-r1" role="tab"><%=LNG("İş Durumu")%></a>
                    </li>
                    <%
                        ParcaCihaz = False
                        if not tblModulYetkiler.eof then
                            do while not tblModulYetkiler.eof
                                if tblModulYetkiler("ModulId") = 7 and tblModulYetkiler("Status") = True then
                                    ParcaCihaz = True
                                end if
                            tblModulYetkiler.movenext
                            loop
                        end if
                    %>
                    <%if ParcaCihaz = True then %>
                        <li class="nav-item" style="display:none">
                            <a class="nav-link" data-toggle="tab" href="#tab-r5" id="parcalar_tab_buton" onclick="parcalar_ve_iscilik_getir('<%=is_id %>');" role="tab"><%=LNG("Parçalar / Cihazlar")%></a>
                        </li>
                    <%end if %>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#tab-r2" id="is_yazisma_tab_buton" onclick="is_yazisma_yeni_goster('<%=is_id %>');" role="tab"><%=LNG("Yazışmalar")%></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#tab-r3" id="dosya_listesi_tab_buton" onclick="dosya_listesi_getir('<%=is_id %>');" role="tab"><%=LNG("Dosyalar")%></a>
                    </li>
                    <li class="nav-item mobil_iptal" style="display:none">
                        <a class="nav-link mobil_iptal" data-toggle="tab" href="#tab-r4" data-toggle="tab" role="tab"><%=LNG("Bildirimler")%></a>
                    </li>
                </ul>
                <!-- Tab panes -->
                <div id="tabDiv" class="tab-content tabs card-block">
                    <div class="tab-pane" id="tab-r5" role="tabpanel">
                        <div id="parcalar_iscilik_donus_yeri<%=is_id %>"></div>
                    </div>
                    <div class="tab-pane active" id="tab-r1" role="tabpanel">
                        <legend><%=LNG("Görevliler")%></legend>
                        <%
                        SQL="with cte as (SELECT iss.adi, case when (select COUNT(id) from ucgem_is_calisma_listesi WHERE is_id = '"& is_id &"' and firma_id = '"& FirmaID &"' and ekleyen_id = gorevli.gorevli_id) = 0 then '00:00' else dbo.DakikadanSaatYap((SELECT ISNULL( SUM((DATEDIFF(MINUTE, CONVERT(DATETIME, olay.baslangic), CONVERT(DATETIME, olay.bitis)))), 0) FROM dbo.ucgem_is_calisma_listesi olay WITH (NOLOCK) WHERE olay.is_id = gorevli.is_id and olay.ekleyen_id = gorevli.gorevli_id AND olay.durum = 'true' AND olay.cop = 'false' )) end AS harcanan, CASE WHEN (DATEDIFF(MINUTE, DATEADD(n, (SELECT ISNULL(SUM((DATEDIFF(MINUTE, CONVERT(DATETIME, calisma.baslangic), CONVERT(DATETIME, calisma.bitis)))), 0) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE calisma.is_id = gorevli.is_id AND calisma.durum = 'true' AND calisma.ekleyen_id = gorevli.gorevli_id and calisma.cop = 'false'), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ), DATEADD( n, dbo.SaattenDakikaYap(ISNULL(gorevli.toplam_sure, '00:00')), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ) ) ) < 0 THEN '-' ELSE '' END + dbo.DakikadanSaatYap(CASE WHEN (DATEDIFF( n, DATEADD( n, ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT( DATETIME, calisma.baslangic ), CONVERT( DATETIME, calisma.bitis)))), 0) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE calisma.is_id = gorevli.is_id AND calisma.ekleyen_id = gorevli.gorevli_id and calisma.durum = 'true' AND calisma.cop = 'false' ), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ), DATEADD(n,dbo.SaattenDakikaYap(ISNULL( gorevli.toplam_sure, '00:00' ) ), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ) ) ) < 0 THEN -1 * DATEDIFF(n, DATEADD( n, (SELECT ISNULL(SUM((DATEDIFF(n, CONVERT(DATETIME, calisma.baslangic), CONVERT( DATETIME, calisma.bitis )))), 0 ) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE calisma.is_id = gorevli.is_id and calisma.ekleyen_id = gorevli.gorevli_id AND calisma.durum = 'true' AND calisma.cop = 'false' ), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ), DATEADD( n, dbo.SaattenDakikaYap(ISNULL( gorevli.toplam_sure, '00:00' ) ), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ) ) ELSE DATEDIFF(n, DATEADD( n, (SELECT ISNULL( SUM((DATEDIFF( n, CONVERT( DATETIME, calisma.baslangic ), CONVERT( DATETIME, calisma.bitis) ) ) ), 0 ) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE calisma.is_id = gorevli.is_id and calisma.ekleyen_id = gorevli.gorevli_id AND calisma.durum = 'true' AND calisma.cop = 'false' ), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ), DATEADD( n, dbo.SaattenDakikaYap(ISNULL(gorevli.toplam_sure, '00:00')), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ) ) END ) AS kalan, ISNULL(gorevli.toplam_sure, '0:00') AS toplam_sure, ISNULL(gorevli.gunluk_sure, '0:00') AS gunluk_sure, ISNULL(gorevli.toplam_gun, '0:00') AS toplam_gun, CASE WHEN ISNULL(gorevli.toplam_sure, '0:00') = '0:00' THEN 0 ELSE 1 end AS GantAdimID, ISNULL(sinirlama_varmi, 0) as sinirlama_varmi, CONVERT(DATETIME, gorevli.ekleme_tarihi) + CONVERT(DATETIME, gorevli.ekleme_saati) AS tamamlanma_zamani, kullanici.personel_resim, kullanici.personel_ad + ' ' + kullanici.personel_soyad AS personel_adsoyad, gorevli.gorevli_id, gorevli.id, gorevli.tamamlanma_orani FROM ucgem_is_gorevli_durumlari gorevli WITH (NOLOCK) JOIN ucgem_firma_kullanici_listesi kullanici WITH (NOLOCK) ON kullanici.id = gorevli.gorevli_id JOIN ucgem_is_listesi iss ON iss.id = gorevli.is_id WHERE gorevli.is_id = '"& is_id &"' and gorevli.firma_id = '"& FirmaID &"' GROUP BY iss.adi, gorevli.toplam_sure, gorevli.gunluk_sure, gorevli.toplam_gun, ISNULL(iss.GantAdimID, 0), CONVERT(DATETIME, gorevli.ekleme_tarihi) + CONVERT(DATETIME, gorevli.ekleme_saati), kullanici.personel_resim, kullanici.personel_ad + ' ' + kullanici.personel_soyad, gorevli.gorevli_id, gorevli.id, gorevli.tamamlanma_orani, gorevli.is_id, iss.baslangic_tarihi, iss.sinirlama_varmi ) select CASE WHEN tamamlanma_orani = 100 THEN 100 WHEN (Convert(int, CONVERT(decimal(15,2), LEFT(harcanan, CHARINDEX(':', harcanan) - 1)) * 60 + CONVERT(int, RIGHT(harcanan, 2))) > Convert(int, CONVERT(decimal(15,2), LEFT(toplam_sure, CHARINDEX(':', toplam_sure) - 1)) * 60 + CONVERT(int, RIGHT(toplam_sure, 2))) AND CONVERT(int, tamamlanma_orani) = 0) THEN 90 WHEN (Convert(int, CONVERT(decimal(15,2), LEFT(harcanan, CHARINDEX(':', harcanan) - 1)) * 60 + CONVERT(int, RIGHT(harcanan, 2))) = 0 and CONVERT(int, tamamlanma_orani) = 0) THEN 0 WHEN Convert(int, CONVERT(decimal(15,2), LEFT(harcanan, CHARINDEX(':', harcanan) - 1)) * 60 + CONVERT(int, RIGHT(harcanan, 2))) > Convert(int, CONVERT(decimal(15,2), LEFT(toplam_sure, CHARINDEX(':', toplam_sure) - 1)) * 60 + CONVERT(int, RIGHT(toplam_sure, 2))) THEN 90 WHEN CONVERT(int, CONVERT(decimal(15,2), LEFT(harcanan, CHARINDEX(':', harcanan) - 1)) * 60 + CONVERT(int, RIGHT(harcanan, 2))) = CONVERT(int, CONVERT(decimal(15,2), LEFT(toplam_sure, CHARINDEX(':', toplam_sure) - 1)) * 60 + CONVERT(int, RIGHT(toplam_sure, 2))) THEN 90 ELSE CONVERT(int, CONVERT(decimal(15,2), LEFT(harcanan, CHARINDEX(':', harcanan) - 1) * 60 + CONVERT(int, RIGHT(harcanan, 2))) / CONVERT(int, CONVERT(decimal(15,2), LEFT(toplam_sure, CHARINDEX(':', toplam_sure) - 1) * 60 + CONVERT(int, RIGHT(toplam_sure, 2)))) * 100) END as tamamlanmorani, * from cte"
                        set gorevli = baglanti.execute(SQL)
                            'response.Write(SQL)
                        do while not gorevli.eof

                            if trim(gorevli("gorevli_id"))=trim(request.Cookies("kullanici")("kullanici_id")) then
                        %>
                        <div class="row">
                            <div class="col-xs-1 col-md-1 mb-2">
                                <a rel="tooltip" data-original-title="<%=gorevli("personel_adsoyad") %>" data-placement="top" href="javascript:void(0)">
                                    <img style="width: 100%; min-width: 21px;" src="<%=gorevli("personel_resim") %>" class="online">
                                </a>
                            </div>
                            <!--<hr class="col-xs-10 col-md-12" id="xs-visible" style="display:none"/>-->
                            <div class="col-md-8 col-sm-8 col-xs-10">
                                <% if cdbl(gorevli("tamamlanma_orani"))<100 then %>
                                <div style="width: 100%;">
                                    <div id="basicUsage" style="font-size: 40px; width: 165px; display: inline-block;">00:00:00</div>
                                    <input type="button" tamamlanmaid="<%=gorevli("id") %>" user_id="<%=gorevli("gorevli_id")%>" is_id="<%=is_id %>" class="startButton btn btn-success mb-1" value="Başlat" style="margin-top: -15px;"/>
                                    <input type="button" tamamlanmaid="<%=gorevli("id") %>" user_id="<%=gorevli("gorevli_id")%>" baslik="<%=gorevli("adi") %>" aciklama="<%=gorevli("adi") %> adlı işte ilerleme kaydedildi." is_id="<%=is_id %>" class="pauseButton btn btn-primary mb-1" value="Duraklat" style="margin-top: -15px;" />
                                    <input type="button" tamamlanmaid="<%=gorevli("id") %>" user_id="<%=gorevli("gorevli_id")%>" is_id="<%=is_id %>" class="stopButton btn btn-danger mb-1" value="Tamamlandı" style="margin-top: -15px;" />
                                </div>
                                <% else %>
                                <%=LNG("İşin Tamamlanma Durumu :")%>
                                <br />
                                <div class="nprogress">
                                    <div class="nprogress-bar nprogress-bar-striped nprogress-bar-success" role="progressbar" style="width: <%=gorevli("tamamlanmorani") %>%" aria-valuenow="<%=gorevli("tamamlanmorani") %>" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <% end if %>

                                <br />
                                <span style="float: left;">
                                    <% if trim(gorevli("sinirlama_varmi"))="0" then %>
                                    <table style="text-align: center;">
                                        <thead>
                                            <tr>
                                                <th><%=LNG("Planlanan Süre")%></th>
                                                <th>&nbsp</th>
                                                <th>&nbsp</th>
                                                <th>&nbsp</th>
                                                <th>&nbsp</th>
                                                <th>&nbsp</th>
                                                <th><%=LNG("Harcanan Süre")%></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td><i class="fa fa-clock-o"></i><strong style="font-size: 15px;"><%=gorevli("toplam_sure") %></strong></td>
                                                <td>&nbsp</td>
                                                <td>&nbsp</td>
                                                <td>&nbsp</td>
                                                <td>&nbsp</td>
                                                <td>&nbsp</td>
                                                <td><i class="fa fa-clock-o"></i><strong style="font-size: 15px;"><%=gorevli("harcanan") %></strong></td>
                                            </tr>
                                        </tbody>
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
                                            <td style="padding-right: 15px;"><i class="fa fa-clock-o">&nbsp</i><strong style="font-size: 15px;"><%=gorevli("harcanan") %></strong></td>
                                            <td><i class="fa fa-clock-o">&nbsp</i><strong style="font-size: 15px;"><%=gorevli("kalan") %></strong></td>
                                        </tr>
                                    </table>
                                    <% end if %>
                                </span>

                                <span id="sonGuncelleme" style="float: right;">Son Güncelleme : <strong><%=gorevli("tamamlanma_zamani") %></strong></span>
                            </div>

                            <div id="yuzde" class="col-xs-1 col-md-2" style="padding-top: 5px;">
                                <input id="easyPieChart<%=gorevli("id") %>" type="text" class="dial easyPieChartlar" value="<%=gorevli("tamamlanmorani") %>" data-width="68" data-height="75" data-linecap="round" data-displayprevious="true" data-displayinput="true" data-readonly="true" data-fgcolor="#4ECDC4">
                            </div>
                            <div class="col-xs-1" style="padding-top: 5px; display: none;">
                                <input type="button" class="btn btn-danger btn-sm" onclick="is_personel_durt('<%=gorevli("gorevli_id") %>', '<%=is_id %>');" value="<%=LNG("Uyar")%>" />
                            </div>
                        </div>
                        <hr />
                        <% else %>
                        <div class="row">
                            <div class="col-xs-1">
                                <a rel="tooltip" data-original-title="<%=gorevli("personel_adsoyad") %>" data-placement="top" href="javascript:void(0)">
                                    <img style="width: 100%; min-width: 21px;" src="<%=gorevli("personel_resim") %>" class="online"></a>
                            </div>
                            <div class="col-xs-10 col-md-8">
                                <%=LNG("İşin Tamamlanma Durumu :")%>
                                <br />
                                <div class="nprogress">
                                    <div class="nprogress-bar nprogress-bar-striped nprogress-bar-success" role="progressbar" style="width: <%=gorevli("tamamlanmorani") %>%" aria-valuenow="<%=gorevli("tamamlanmorani") %>" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                                <br />
                                <span style="float: left;">
                                    <% if trim(gorevli("sinirlama_varmi"))="0" then %>
                                    <table style="text-align: center;">
                                        <thead>
                                            <tr>
                                                <th><%=LNG("Planlanan Süre")%></th>
                                                <th>&nbsp</th>
                                                <th>&nbsp</th>
                                                <th>&nbsp</th>
                                                <th>&nbsp</th>
                                                <th>&nbsp</th>
                                                <th><%=LNG("Harcanan Süre")%></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td><i class="fa fa-clock-o"></i><strong style="font-size: 15px;"><%=gorevli("toplam_sure") %></strong></td>
                                                <td>&nbsp</td>
                                                <td>&nbsp</td>
                                                <td>&nbsp</td>
                                                <td>&nbsp</td>
                                                <td>&nbsp</td>
                                                <td><i class="fa fa-clock-o"></i><strong style="font-size: 15px;"><%=gorevli("harcanan") %></strong></td>
                                            </tr>
                                        </tbody>
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
                                            <td style="padding-right: 15px;"><i class="fa fa-clock-o">&nbsp</i><strong style="font-size: 15px;"><%=gorevli("harcanan") %></strong></td>
                                            <td><i class="fa fa-clock-o">&nbsp</i><strong style="font-size: 15px;"><%=gorevli("kalan") %></strong></td>
                                        </tr>
                                    </table>
                                    <% end if %>
                                </span>
                                <span id="sonGuncelleme2" style="float: right; padding-top: 0px;"><%=LNG("Son Güncelleme : ")%> <strong><%=gorevli("tamamlanma_zamani") %></strong></span>
                            </div>
                            <div id="yuzde2" class="col-xs-1">
                                <input id="easyPieChartlar" type="text" class="dial easyPieChartlar" value="<%=gorevli("tamamlanmorani") %>" data-width="68" data-height="75" data-linecap="round" data-displayprevious="true" data-displayinput="true" data-readonly="true" data-fgcolor="#40c4ff">
                            </div>
                            <div class="col-xs-1 " style="padding-top: 5px;">
                                <input type="button" class="btn btn-danger btn-sm" onclick="is_personel_durt('<%=gorevli("gorevli_id") %>', '<%=is_id %>');" value="<%=LNG("Uyar")%>" />
                            </div>
                        </div>
                        <hr />
                        <%
                            end if
                            gorevli.movenext
                            loop
                        %>
                        <div class="row">
                            <div class="col-xs-8 col-sm-12 col-md-12 isCalismaList p-2" id="is_timer_list<%=is_id %>"> 
                                
                            </div>
                        </div>
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
                            <div class="col-md-3 col-xs-10">
                                <h4><%=LNG("Dosya Ekle")%></h4>
                                <br />
                                <input type="file" value="/img/kucukboy.png" tip="kucuk" yol="dosya_deposu/" style="height: 31px!important;" id="dosya_yolu<%=is_id %>" folder="IsDosyaları" />
                                <img src="/img/loader_green.gif" id="fileLoading" style="display: none" />
                                <br />
                                <%=LNG("Dosya Adı:")%><br />
                                <input type="text" id="dosya_adi<%=is_id %>" />
                                <br />
                                <br />
                                <input type="button" class="btn btn-success" id="dosya_kaydet_buton" value="<%=LNG("Kaydet")%>" onclick="yeni_is_dosya_ekle('<%=is_id %>'); return false;" />
                                <br />

                            </div>
                            <div class="col-xs-10">
                                <h4><%=LNG("Dosya Listesi")%></h4>
                                <br />
                                <div class="table-responsive border-0" id="dosya_listesi<%=is_id %>">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane mobil_iptal" id="tab-r4" role="tabpanel">
                        <select id="is_detay_kontrol_bildirim<%=is_id %>" name="is_detay_kontrol_bildirim<%=is_id %>" class="select2">
                            <option value="22"><%=LNG("SMS")%></option>
                            <option value="24"><%=LNG("MAİL")%></option>
                        </select>
                        <br />
                        <br />
                        <input type="button" class="btn btn-primary" value="<%=LNG("Güncelle")%>" onclick="is_kontrol_bildirim_guncelle('<%=is_id %>'); return false;" />
                    </div>
                </div>



            </div>
        </div>
    </div>
    </div>
<%
    elseif trn(request("islem"))="ModalParcaEkle" then
%>
<div class="modal-header">
    Parça Ekle
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_parca_giris_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">

    <div class="row" style="display:none;">
        <label class="col-sm-12 col-form-label">Parça Resmi :</label>
        <div class="col-sm-12">
            <input type="file" id="parca_resmi" yol="/Parcalar" tip="buyuk" class="form-control" />
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Kodu :</label>
        <div class="col-sm-12">
            <input type="text" id="kodu" class="form-control" />
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Marka :</label>
        <div class="col-sm-12">
            <input type="text" id="marka" class="form-control" />
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Parça Adı :</label>
        <div class="col-sm-12">
            <input type="text" id="parca_adi" class="form-control" />
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Kategori :</label>
        <div class="col-sm-12">
            <select id="kategori" class="select2">
                <%
                    SQL="select * from tanimlama_kategori_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and cop = 'false' order by kategori_adi asc"
                    set kategori = baglanti.execute(SQL)
                    do while not kategori.eof
                %>
                <option value="<%=kategori("id") %>"><%=kategori("kategori_adi") %></option>
                <%
                    kategori.movenext
                    loop
                %>
            </select>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Açıklama :</label>
        <div class="col-sm-12">
            <textarea id="aciklama" class="form-control"></textarea>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Birim Maliyet :</label>
        <div class="col-sm-6">
            <input type="text" id="birim_maliyet" class="form-control" />
        </div>
        <div class="col-sm-6">
            <select name="birim_pb" id="birim_pb" class="select2">
                <option>TL</option>
                <option>USD</option>
                <option>EUR</option>
            </select>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-6 col-form-label">Miktar :</label>
        <label class="col-sm-6 col-form-label">Minumum Miktar :</label>
        <div class="col-sm-6">
            <input type="text" id="miktar" class="form-control" />
        </div>

        <div class="col-sm-6">
            <input type="text" id="minumum_miktar" class="form-control" />
        </div>

    </div>

    <div class="row">
        <label class="col-sm-12 col-md-6 col-form-label">Barcode :</label>
        <label class="col-sm-12 col-md-6 col-form-label">Birim :</label>
        <div class="col-sm-12 col-md-6">
            <input type="text" id="barcode" class="form-control" />
        </div>
        <div class="col-sm-12 col-md-6">
            <select class="form-control select2" id="birim" style="padding:6px; height:35px">
                <option value="KILOGRAM">KİLOGRAM</option>
                <option value="METRE">METRE</option>
                <option value="ADET">ADET</option>
                <option value="M2">M2</option>
                <option value="MM">MM</option>
                <option value="CM">CM</option>
                <option value="SET">SET</option>
                <option value="LITRE">LİTRE</option>
            </select>
        </div>
    </div>
    <div class="modal-footer">
        <input type="button" onclick="yeni_parca_ekle();" class="btn btn-primary" value="Parça Ekle" />
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#kategori, #birim, #birim_pb").select2({
                dropdownParent: $("#modal_div")
            });
        });
    </script>
</form>
<%    
    elseif trn(request("islem"))="parca_duzenle" then

        kayit_id = trn(request("kayit_id"))

        SQL="select * from parca_listesi where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
        set parca = baglanti.execute(SQL)

%>
<div class="modal-header">
    Parça Düzenle
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_parca_giris_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">

    <div class="row" style="display:none;">
        <label class="col-sm-12 col-form-label">Parça Resmi :</label>
        <div class="col-sm-12">
            <input type="file" id="parca_resmi" yol="/Parcalar" tip="buyuk" value="<%=parca("parca_resmi") %>" class="form-control" />
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Kodu :</label>
        <div class="col-sm-12">
            <input type="text" id="kodu" value="<%=parca("parca_kodu") %>" class="form-control" />
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Marka :</label>
        <div class="col-sm-12">
            <input type="text" id="marka" value="<%=parca("marka") %>" class="form-control" />
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Parça Adı :</label>
        <div class="col-sm-12">
            <input type="text" id="parca_adi" value="<%=parca("parca_adi") %>" class="form-control" />
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Kategori :</label>
        <div class="col-sm-12">
            <select id="kategori" class="select2">
                <%
                    SQL="select * from tanimlama_kategori_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and cop = 'false' order by kategori_adi asc"
                    set kategori = baglanti.execute(SQL)
                    do while not kategori.eof
                %>
                <option <% if trim(parca("kategori"))=trim(kategori("id")) then %> selected="selected" <% end if %> value="<%=kategori("id") %>"><%=kategori("kategori_adi") %></option>
                <%
                    kategori.movenext
                    loop
                %>
            </select>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Açıklama :</label>
        <div class="col-sm-12">
            <textarea id="aciklama" class="form-control"><%=parca("aciklama") %></textarea>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Birim Maliyet :</label>
        <div class="col-sm-6">
            <input type="text" id="birim_maliyet" value="<%=parca("birim_maliyet") %>" class="form-control" />
        </div>
        <div class="col-sm-6">
            <select name="birim_pb" id="birim_pb" class="select2">
                <option <% if trim(parca("birim_pb"))="TL" then %> selected="selected" <% end if %>>TL</option>
                <option <% if trim(parca("birim_pb"))="USD" then %> selected="selected" <% end if %>>USD</option>
                <option <% if trim(parca("birim_pb"))="EUR" then %> selected="selected" <% end if %>>EUR</option>
            </select>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-6 col-form-label">Miktar :</label>
        <label class="col-sm-6 col-form-label">Minumum Miktar :</label>
        <div class="col-sm-6">
            <input type="text" id="miktar" value="<%=parca("miktar") %>" class="form-control" />
        </div>
        <div class="col-sm-6">
            <input type="text" id="minumum_miktar" value="<%=parca("minumum_miktar") %>" class="form-control" />
        </div>
    </div>


    <div class="row">
        <label class="col-sm-12 col-md-6 col-form-label">Barcode :</label>
        <label class="col-sm-12 col-md-6 col-form-label">Birim :</label>
        <div class="col-sm-12 col-md-6">
            <input type="text" id="barcode" value="<%=parca("barcode") %>" class="form-control" />
        </div>
        <div class="col-sm-12 col-md-6">
            <select class="form-control" id="birim" style="padding:6px; height:35px">
                <option <%if trim(parca("birim")) = "KILOGRAM" then %> selected="selected" <%end if %> value="KILOGRAM">KİLOGRAM</option>
                <option <%if trim(parca("birim")) = "METRE" then %> selected="selected" <%end if %> value="METRE">METRE</option>
                <option <%if trim(parca("birim")) = "ADET" then %> selected="selected" <%end if %> value="ADET">ADET</option>
                <option <%if trim(parca("birim")) = "M2" then %> selected="selected" <%end if %> value="M2">M2</option>
                <option <%if trim(parca("birim")) = "MM" then %> selected="selected" <%end if %> value="MM">MM</option>
                <option <%if trim(parca("birim")) = "CM" then %> selected="selected" <%end if %> value="CM">CM</option>
                <option <%if trim(parca("birim")) = "SET" then %> selected="selected" <%end if %> value="SET">SET</option>
                <option <%if trim(parca("birim")) = "LITRE" then %> selected="selected" <%end if %> value="LITRE">LİTRE</option>
            </select>
        </div>
    </div>
    <div class="modal-footer">
        <input type="button" onclick="parca_guncelle('<%=parca("id") %>');" class="btn btn-primary" value="Parça Düzenle" />
    </div>
</form>
<%
    elseif trn(request("islem"))="ModalSatinalmaEkle" then
%>
<div class="modal-header">
    Satınalma Siparişi Ekle
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="satinalmasiparisi" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">

    <div class="row">
        <label class="col-sm-12 col-form-label">Başlık :</label>
        <div class="col-sm-12">
            <input type="text" name="satinalma_baslik" id="satinalma_baslik" class="form-control required" required />
        </div>
    </div>

    <div class="row">
        <label class="col-sm-6 col-form-label">Sipariş Tarihi :</label>
        <label class="col-sm-6 col-form-label">Öncelik :</label>
        <div class="col-sm-6">
            <input type="text" name="siparis_tarihi" id="siparis_tarihi" class="form-control required takvimyap" value="<%=FormatDate(date, "00") %>"" required />
        </div>
        <div class="col-sm-6">
            <select name="satinalma_oncelik" id="satinalma_oncelik" class="select2">
                <option value="Normal">Normal</option>
                <option value="Düşük">Düşük</option>
                <option value="Yüksek">Yüksek</option>
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
                <option value="<%=firmacek("id") %>"><%=firmacek("firma_adi") %></option>
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
                <option value="<%=proje("id") %>"><%=proje("proje_adi") %>-<%=proje("proje_kodu") %></option>
                <%
                    proje.movenext
                    loop
                %>
            </select>
        </div>
    </div>
    <% i = 0 %>
    <script>
        $(function (){
            parcalar_autocomplete_calistir();
        });
    </script>
    <input type="hidden" name="parcasayisi" id="parcasayisi" value="<%=i %>" />
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
                        <tr id="satinalmasatir<%=i %>">
                            <td>
                                <input type="text" name="parcalar" id="parcalar<%=i %>" i="<%=i %>" data="0" class="form-control parcalar required" required />
                            </td>
                            <td>
                                <div class="row">
                                    <div class="col-sm-6" style="text-align: right; padding-right: 0;">
                                        <input type="text" class="form-control maliyetler required" required name="maliyet" id="maliyet<%=i %>" onkeyup="satinalmasiparishesapkitap();" style="height: 38px;" />
                                    </div>
                                    <div class="col-sm-6" style="padding-left: 15px; text-align: left;">
                                        <select onchange="satinalmasiparishesapkitap();" class="form-control yapilan paralar" name="paralar" id="paralar<%=i %>">
                                            <option value="TL">TL</option>
                                            <option value="USD">USD</option>
                                            <option value="EUR">EUR</option>
                                        </select>
                                    </div>
                                </div>
                            </td>
                            <td style="padding-left: 15px;">
                                <input type="text" class="form-control adetler required" required onkeyup="satinalmasiparishesapkitap();" name="adet" id="adet<%=i %>" style="height: 38px;" /></td>
                            <th style="width: 25px; padding-left: 10px;">
                                <a href="javascript:void(0);" onclick="satinalmayenisatirsil('<%=i %>');">
                                    <img src="/img/abort.png" />
                                </a>
                            </th>
                        </tr>
                    </tbody>
                </table>
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
            <input type="text" class="form-control required" required name="satinalma_alttoplam" value="0,00" id="satinalma_alttoplamtl" />
        </div>

        <div class="col-sm-4">
            <input type="text" class="form-control required" required name="satinalma_alttoplam" value="0,00" id="satinalma_alttoplamusd" />
        </div>

        <div class="col-sm-4">
            <input type="text" class="form-control required" required name="satinalma_alttoplam" value="0,00" id="satinalma_alttoplameur" />
        </div>

    </div>


    <div class="row">
        <label class="col-sm-12 col-form-label">Satınalma Durum :</label>
        <div class="col-sm-12">
            <select name="satinalma_durum" id="satinalma_durum" class="select2">
                <option value="Sipariş Edildi">Sipariş Edildi</option>
                <option value="İptal Edildi">İptal Edildi</option>
                <option value="Tamamlandı">Tamamlandı</option>
                <option value="Onay Bekliyor">Onay Bekliyor</option>
            </select>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Açıklama :</label>
        <div class="col-sm-12">
            <textarea name="satinalma_aciklama" id="satinalma_aciklama" class="form-control"></textarea>
        </div>
    </div>


    <div class="modal-footer">
        <input type="button" class="btn btn-primary" onclick="SatinalmaSiparisKaydet();" value="Sipariş Kaydet" />
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
    <script src="/js/jquery-ui.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#satinalma_tedarikci_id, #satinalma_oncelik, #satinalma_proje_id, #satinalma_durum").select2({
                dropdownParent: $("#modal_div3")
            });
        });
    </script>
</form>
<%
    elseif trn(request("islem"))="ModalTalepEkle" then
%>
<div class="modal-header">
    Talep Ekle
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="talepfisform" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">

    <div class="row">
        <label class="col-sm-12 col-form-label">Başlık :</label>
        <div class="col-sm-12">
            <input type="text" name="talep_baslik" id="talep_baslik" class="form-control" />
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Öncelik :</label>
        <div class="col-sm-12">
            <select name="talep_oncelik" id="talep_oncelik" class="select2">
                <option value="Normal">Normal</option>
                <option value="Yüksek">Yüksek</option>
                <option value="Düşük">Düşük</option>
            </select>
        </div>
    </div>

    <div class="row">
        <div class="form-group row col-sm-6">
            <label class="col-sm-12 col-form-label">Talep Edilen Kişi :</label>
            <div class="col-sm-12">
                <select name="talep_edilen" id="talep_edilen" class="select2" multiple required>
                    <%
                    firma_id = Request.Cookies("kullanici")("firma_id")
                    SQL="select id, personel_ad + ' ' + personel_soyad as personel_ad_soyad from ucgem_firma_kullanici_listesi where firma_id = '"& firma_id &"' and durum = 'true' and cop = 'false'"
                    set talep_edilen = baglanti.execute(SQL)
                    do while not talep_edilen.eof
                    %>
                    <option value="<%=talep_edilen("id") %>"><%=talep_edilen("personel_ad_soyad") %></option>
                    <%
                    talep_edilen.movenext
                    loop
                    %>
                </select>
            </div>
        </div>

        <div class="form-group row col-sm-6">
            <label class="col-sm-12 col-form-label">Kontrol ve Bildirim :</label>
            <div class="col-sm-12">
                <select name="kontrol_select" id="kontrol_select" class="select2" multiple required>
                    <%
                    SQL="select id, adi from ucgem_bildirim_cesitleri where firma_id = '"& FirmaID &"'"
                    set kontrol_select = baglanti.execute(SQL)
                    do while not kontrol_select.eof
                    %>
                    <option value="<%=kontrol_select("adi") %>"><%=kontrol_select("adi") %></option>
                    <%
                    kontrol_select.movenext
                    loop
                    %>
                </select>
            </div>
        </div>
    </div>


    <div class="row">
        <label class="col-sm-12 col-form-label">Açıklama :</label>
        <div class="col-sm-12">
            <textarea name="talep_aciklama" id="talep_aciklama" class="form-control"></textarea>
        </div>
    </div>

    <div class="row" style="display:none;">
        <label class="col-sm-12 col-form-label">Dosya :</label>
        <div class="col-sm-12">
            <input type="file" id="talep_dosya" yol="/Parcalar" tip="kucuk" class="form-control" folder="TalepFisDosyalari" />
        </div>
    </div>


    <div class="modal-footer">
        <input type="button" class="btn btn-primary" onclick="yeni_talep_fisi_ekle();" value="Talep Ekle" />
    </div>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#talep_oncelik").select2({
                dropdownParent: $("#modal_div")
            });
        });
    </script>
</form>
<%
    elseif trn(request("islem"))="ModalTalepDuzenle" then

        kayit_id = trn(request("kayit_id"))

        SQL="select * from talep_fisleri where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
        set talepcek = baglanti.execute(SQL)

%>
<div class="modal-header">
    Talep Düzenle
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="talepfisform" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">

    <div class="row">
        <label class="col-sm-12 col-form-label">Başlık :</label>
        <div class="col-sm-12">
            <input type="text" name="talep_baslik" id="talep_baslik" value="<%=talepcek("baslik") %>" class="form-control" />
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Öncelik :</label>
        <div class="col-sm-12">
            <select name="talep_oncelik" id="talep_oncelik" class="select2">
                <option <% if trim(talepcek("oncelik"))="Normal" then %> selected="selected" <% end if %> value="Normal">Normal</option>
                <option <% if trim(talepcek("oncelik"))="Yüksek" then %> selected="selected" <% end if %> value="Yüksek">Yüksek</option>
                <option <% if trim(talepcek("oncelik"))="Düşük" then %> selected="selected" <% end if %> value="Düşük">Düşük</option>
            </select>
        </div>
    </div>


    <div class="row">
        <label class="col-sm-12 col-form-label">Açıklama :</label>
        <div class="col-sm-12">
            <textarea name="talep_aciklama" id="talep_aciklama" class="form-control"><%=talepcek("aciklama") %></textarea>
        </div>
    </div>

    <div class="row" style="display:none;">
        <label class="col-sm-12 col-form-label">Dosya :</label>
        <div class="col-sm-12">
            <input type="file" id="talep_dosya" yol="/Parcalar" tip="kucuk" value="<%=talepcek("dosya") %>" folder="TalepFisDosyalari" class="form-control" />
        </div>
    </div>

    <div class="modal-footer">
        <input type="button" class="btn btn-primary" onclick="yeni_talep_fisi_guncelle('<%=kayit_id %>');" value="Talep Güncelle" />
    </div>
</form>
<%

    elseif trn(request("islem"))="is_timer_start_kaydi" then

        is_id = trn(request("is_id"))
        gorevli_id = trn(request("gorevli_id"))
        sayfalar = trn(request("sayfalar"))

        if trn(request("islem2"))="baslat" then
            
            TamamlanmaID = trn(request("TamamlanmaID"))
            gorevli_id = trn(request("userId"))
            durum = "true"
            cop = "false"
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time

            SQL ="SELECT id FROM ucgem_is_calisma_listesi WHERE baslangic IS NOT NULL AND bitis IS NULL AND ekleyen_id = '"& ekleyen_id &"' and firma_id = '"& FirmaID &"'"
            set control = baglanti.Execute(SQL)

            SQL = "select DISTINCT Count(ms.SayfaID) as count from Page.MenuSayfalar ms join Page.GorevYetkileri gy on gy.SayfaID = ms.YetkiID join ucgem_firma_kullanici_listesi kl on gy.GorevID in (select value from string_split(kl.gorevler, ',')) where ms.durum = 1 and ms.cop = 0 and kl.durum = 'true' and kl.cop = 'false' and kl.firma_id = '"& firma_id &"' and kl.id = '"& kullanici_id &"' and gy.Yetki = 1"
            set yetkiKontrol = baglanti.execute(SQL)

            if CInt(yetkiKontrol("count")) = 0 and not control.eof then
               Response.Clear()
%>
            <script type="text/javascript">
                $(function () {
                    mesaj_ver("İkinci İş", "Aynı Anda İkinci İşi Başlatama Yetkiniz Yok.", "danger");
                    timer.stop();
                    $('.startButton').show();
                    $('.pauseButton').hide();
                    $('.stopButton').hide();
                });
            </script>
<%
                Response.End
                return
            end if
    
            SQL ="SELECT * FROM ucgem_is_calisma_listesi WHERE ekleyen_id = '"& ekleyen_id &"' AND is_id = '"& is_id &"' and firma_id = '"& FirmaID &"' AND durum= 'true' AND cop='false' "
            set controlbaslat = baglanti.Execute(SQL)

            SQL ="SELECT * FROM ucgem_firma_kullanici_listesi WHERE id ='"& ekleyen_id &"' and firma_id = '"& FirmaID &"' AND durum= 'true' AND cop='false' "
            set kullanicicek = baglanti.Execute(SQL)

            SQL ="SELECT * FROM ucgem_is_listesi WHERE id ='"& is_id &"' and firma_id = '"& FirmaID &"' AND durum= 'true' AND cop='false' "
            set iscek = baglanti.Execute(SQL)

           SQL ="SELECT * FROM ucgem_firma_kullanici_listesi WHERE id ='"& iscek("ekleyen_id") &"' and firma_id = '"& FirmaID &"' AND durum= 'true' AND cop='false' "
            set yoneticicek = baglanti.Execute(SQL)

            if controlbaslat.eof then
                bildirim = kullanicicek("personel_ad") & " " & kullanicicek("personel_soyad") & " "& iscek("adi") &" Adlı İşe Başladı."
                tip = "is_listesi"
                click = "CokluIsYap(''is_listesi'',0,'' '',''"& is_id &"'');"
                user_id = iscek("ekleyen_id")
                okudumu = "0"
                durum = "true"
                cop = "false"
                firma_kodu = kullanicicek("firma_kodu")
                firma_id = kullanicicek("firma_id")
                ekleyen_ip = Request.ServerVariables("Remote_Addr")
    
                SQL="insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& bildirim &"', '"& tip &"', N'"& click &"', '"& user_id &"', '"& okudumu &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate())"
    'response.Write(SQL)
                set ekle2 = baglanti.execute(SQL)

                NetGSM_SMS yoneticicek("personel_telefon"), bildirim
            end if

            SQL="insert into ucgem_is_calisma_listesi(TamamlanmaID, is_id, baslangic, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& TamamlanmaID &"', '"& is_id &"', getdate(), '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 104), '"& ekleme_saati &"')"
            set ekle = baglanti.execute(SQL)

           

            SQL="select * from ucgem_is_listesi where id = '"& is_id &"' and firma_id = '"& FirmaID &"'"
            set iscek = baglanti.execute(SQL)

            etiketler = iscek("departmanlar")

        elseif trn(request("islem2"))="pause" then

            IsID = trn(request("is_id"))
            TamamlanmaID = trn(request("TamamlanmaID"))
            gorevli_id = trn(request("gorevli_id"))
            tamamlanma_orani = trn(request("tamamlanma_orani"))
            onceki_oran = trn(request("onceki_oran"))
            baslama_saati = trn(request("baslama_saati"))
            bitirme_saati = time
            baslama_tarihi = trn(request("baslama_tarihi"))
            bitirme_tarihi = date
            ajanda_baslik = trn(request("ajanda_baslik"))
            ajanda_aciklama = trn(request("ajanda_aciklama"))
            etiket_id = Request.Cookies("kullanici")("kullanici_id")
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")

            SQL="SELECT iss.departmanlar, iss.adi, ISNULL(kaynak.toplam_sure,'0:00') AS toplam_sure, ISNULL(kaynak.gunluk_sure,'0:00') AS gunluk_sure, ISNULL(kaynak.toplam_gun, '0:00') AS toplam_gun, isnull(iss.GantAdimID, 0) as GantAdimID, convert(datetime,gorevli.ekleme_tarihi) + convert(datetime, gorevli.ekleme_saati) as tamamlanma_zamani, kullanici.personel_resim, kullanici.personel_ad + ' ' + kullanici.personel_soyad as personel_adsoyad,gorevli.gorevli_id, gorevli.id, gorevli.tamamlanma_orani from ucgem_is_gorevli_durumlari gorevli  with(nolock) join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = gorevli.gorevli_id join ucgem_is_listesi iss on iss.id = gorevli.is_id and iss.firma_id = '"& FirmaID &"' LEFT JOIN dbo.ahtapot_gantt_adim_kaynaklari kaynak  with(nolock) ON kaynak.adimID = iss.GantAdimID WHERE gorevli.id = '"& TamamlanmaID &"' and gorevli.firma_id = '"& FirmaID &"' GROUP BY kaynak.toplam_sure, kaynak.gunluk_sure, kaynak.toplam_gun, isnull(iss.GantAdimID, 0), convert(datetime,gorevli.ekleme_tarihi) + convert(datetime, gorevli.ekleme_saati), kullanici.personel_resim, kullanici.personel_ad + ' ' + kullanici.personel_soyad, gorevli.gorevli_id, gorevli.id, gorevli.tamamlanma_orani, iss.adi, iss.departmanlar"
            set bilgicek = baglanti.execute(SQL)

            etiketler = bilgicek("departmanlar")

            SQL="select top 1 * from ucgem_is_calisma_listesi where is_id = '"& is_id &"' and firma_id = '"& FirmaID &"' and ekleyen_id = '"& ekleyen_id &"' and TamamlanmaID = '"& TamamlanmaID &"' and bitis is null and cop = 'false' order by id desc"
            set cek = baglanti.execute(SQL)

            if not cek.eof then
                SQL="update ucgem_is_calisma_listesi set bitis = (select CASE WHEN (select DATEDIFF(MINUTE, cl.baslangic, GETDATE()) as fark from ucgem_is_calisma_listesi cl where cl.id = "& cek("id") &") = 0 THEN DATEADD(MINUTE, +1, GETDATE()) ELSE GETDATE() END as fark), IsWaitingAutoStart = 0 where id = '"& cek("id") &"' and firma_id = '"& FirmaID &"'"
                set cek2 = baglanti.execute(SQL)
    
                SQL="insert into ahtapot_ajanda_olay_listesi(IsID, etiket, etiket_id, title, allDay, baslangic, bitis, baslangic_saati, bitis_saati, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, kisiler, ana_kayit_id, tamamlandi, is_calisma_id) values('"& IsID &"', 'personel', '"& etiket_id &"', '"& ajanda_baslik &"', '0', CONVERT(date,'"& baslama_tarihi &"',103), CONVERT(date,'"& bitirme_tarihi &"',103), '"& baslama_saati &"', (select CASE WHEN (select DATEDIFF(MINUTE, '"& baslama_saati &"', '"& bitirme_saati &"') as fark) = 0 THEN DATEADD(MINUTE, +1, '"& bitirme_saati &"') ELSE '"& bitirme_saati &"' END as fark), '', 'rgb(241, 196, 15)', '"& ajanda_aciklama &"', '"& etiketler &"', 'true', 'false', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"',  CONVERT(date, GETDATE(), 103), GETDATE(), '', '0', '"& TamamlanmaID &"', '"& cek("id") &"')"
                set ekle = baglanti.execute(SQL)
            end if
           
        elseif trn(request("islem2"))="stop" then

            IsID = trn(request("is_id"))
            TamamlanmaID = trn(request("TamamlanmaID"))
            gorevli_id = trn(request("gorevli_id"))
            tamamlanma_orani = trn(request("tamamlanma_orani"))
            onceki_oran = trn(request("onceki_oran"))
            baslama_saati = trn(request("baslama_saati"))
            bitirme_saati = time
            baslama_tarihi = trn(request("baslama_tarihi"))
            bitirme_tarihi = date
            ajanda_baslik = trn(request("ajanda_baslik"))
            ajanda_aciklama = trn(request("ajanda_aciklama"))
            etiket_id = Request.Cookies("kullanici")("kullanici_id")
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")

            SQL="SELECT iss.departmanlar, iss.adi, ISNULL(kaynak.toplam_sure,'0:00') AS toplam_sure, ISNULL(kaynak.gunluk_sure,'0:00') AS gunluk_sure, ISNULL(kaynak.toplam_gun, '0:00') AS toplam_gun, isnull(iss.GantAdimID, 0) as GantAdimID, convert(datetime,gorevli.ekleme_tarihi) + convert(datetime, gorevli.ekleme_saati) as tamamlanma_zamani, kullanici.personel_resim, kullanici.personel_ad + ' ' + kullanici.personel_soyad as personel_adsoyad,gorevli.gorevli_id, gorevli.id, gorevli.tamamlanma_orani from ucgem_is_gorevli_durumlari gorevli  with(nolock) join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = gorevli.gorevli_id join ucgem_is_listesi iss on iss.id = gorevli.is_id LEFT JOIN dbo.ahtapot_gantt_adim_kaynaklari kaynak  with(nolock) ON kaynak.adimID = iss.GantAdimID WHERE gorevli.id = '"& TamamlanmaID &"' and gorevli.firma_id = '"& FirmaID &"' and kullanici.firma_id = '"& FirmaID &"' and iss.firma_id = '"& FirmaID &"' GROUP BY kaynak.toplam_sure, kaynak.gunluk_sure, kaynak.toplam_gun, isnull(iss.GantAdimID, 0), convert(datetime,gorevli.ekleme_tarihi) + convert(datetime, gorevli.ekleme_saati), kullanici.personel_resim, kullanici.personel_ad + ' ' + kullanici.personel_soyad, gorevli.gorevli_id, gorevli.id, gorevli.tamamlanma_orani, iss.adi, iss.departmanlar"
            set bilgicek = baglanti.execute(SQL)

            etiketler = bilgicek("departmanlar")

            SQL="select top 1 * from ucgem_is_calisma_listesi where is_id = '"& is_id &"' and TamamlanmaID = '"& TamamlanmaID &"' and firma_id = '"& FirmaID &"' and bitis is null and cop = 'false' order by id desc"
            set cek = baglanti.execute(SQL)

            if not cek.eof then

                SQL = "update ucgem_is_calisma_listesi set bitis = (select CASE WHEN (select DATEDIFF(MINUTE, cl.baslangic, GETDATE()) as fark from ucgem_is_calisma_listesi cl where cl.id = "& cek("id") &") = 0 THEN DATEADD(MINUTE, +1, GETDATE()) ELSE GETDATE() END as fark), IsWaitingAutoStart = 0 where id = '"& cek("id") &"' and firma_id = '"& FirmaID &"'"
                set cek2 = baglanti.execute(SQL)

                SQL="insert into ahtapot_ajanda_olay_listesi(IsID, etiket, etiket_id, title, allDay, baslangic, bitis, baslangic_saati, bitis_saati, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, kisiler, ana_kayit_id, tamamlandi, is_calisma_id) values('"& IsID &"', 'personel', '"& etiket_id &"', '"& ajanda_baslik &"', '0', CONVERT(date,'"& baslama_tarihi &"',103), CONVERT(date,'"& bitirme_tarihi &"',103), '"& baslama_saati &"', (select CASE WHEN (select DATEDIFF(MINUTE, '"& baslama_saati &"', '"& bitirme_saati &"') as fark) = 0 THEN DATEADD(MINUTE, +1, '"& bitirme_saati &"') ELSE '"& bitirme_saati &"' END as fark), '', 'rgb(46, 204, 113)', '"& ajanda_aciklama &"', '"& etiketler &"', 'true', 'false', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"',  CONVERT(date, '"& ekleme_tarihi &"',103), '"& ekleme_saati &"', '', '0', '"& TamamlanmaID &"', '"& cek("id") &"')"
                set ekle = baglanti.execute(SQL)
            end if
        end if
%>
<div class="dt-responsive table-responsive">
    <table class="table table-mini text-nowrap table-bordered w-100 datatableyap">
        <thead>
            <tr>
                <th>Başlangıç</th>
                <th>Bitiş</th>
                <th>Süre</th>
                <th>Personel</th>
                <th>İşlem</th>
            </tr>
        </thead>
        <tbody>
            <%
          SQL="SELECT ekleyen.personel_ad + ' ' + ekleyen.personel_soyad AS ekleyen_adsoyad, CASE WHEN ISNULL(c.bitis, 0) = 0 THEN '00:00:00' ELSE CASE WHEN LEN(CONVERT(NVARCHAR(20), DATEDIFF(HOUR, c.baslangic, c.bitis))) = 1 THEN '0' ELSE '' END + CONVERT(nvarchar(10), DATEDIFF(HOUR, 0, DATEADD(MINUTE, CONVERT(int, DATEDIFF(MINUTE, c.baslangic, c.bitis)), ''))) + ':' + CASE WHEN LEN(CONVERT(NVARCHAR(50), DATEDIFF(MINUTE, c.baslangic, c.bitis) % 60)) = 1 THEN '0' ELSE '' END + CONVERT(NVARCHAR(50), DATEDIFF(MINUTE, c.baslangic, c.bitis) % 60) + ':00' END AS sure, DATEDIFF(MINUTE, c.baslangic, ISNULL(c.bitis, c.baslangic)) AS dakika,RIGHT('0'+CAST(DATEPART(HOUR, c.baslangic)as varchar(2)),2)+ ':'+ RIGHT('0'+CAST(DATEPART(minute, c.baslangic)as varchar(2)),2) as baslangicSaat, RIGHT('0'+CAST(DATEPART(HOUR, c.bitis)as varchar(2)),2)+ ':'+ RIGHT('0'+CAST(DATEPART(minute, c.bitis)as varchar(2)),2) as bitisSaat, c.* FROM ucgem_is_calisma_listesi c JOIN ucgem_firma_kullanici_listesi ekleyen WITH (NOLOCK) ON ekleyen.id = c.ekleyen_id WHERE c.is_id = '"& is_id &"' and c.ekleyen_id = '"& gorevli_id &"' and c.firma_id = '"& FirmaID &"' and c.cop = 'false' ORDER BY c.id ASC;"
          set calisma = baglanti.execute(SQL)
            'response.Write(SQL)
          if calisma.eof then
                state = "display:none"
            %>
            <tr>
                <td colspan="5" style="text-align: center;">Çalışma Kaydı Bulunamadı</td>
            </tr>
            <%
          end if
          girdimi = false
          toplamdakika = 0
          do while not calisma.eof
             toplamdakika = cdbl(toplamdakika) + cdbl(calisma("dakika"))
            %>
            <tr>
                <td><%=FormatDate(calisma("baslangic"), "00") %> &nbsp;<%=calisma("baslangicSaat") %></td>
                <td>
                    <%
                    if isnull(calisma("bitis")) = false then  
                    %>
                    <%=FormatDate(calisma("bitis"), "00") %> &nbsp; <%=calisma("bitisSaat") %>
                    <% 
                    else
                    girdimi = true
                    if CStr(calisma("ekleyen_id")) = Request.Cookies("kullanici")("kullanici_id") then
                        user_id = calisma("ekleyen_id")
                        fromDate=FormatDate(calisma("baslangic"), "00") & " " & calisma("baslangicSaat") & ":" & second(calisma("baslangic"))
                        toDate=now()
                    end if

                    baslangic_tarihi = FormatDate(calisma("baslangic"), "00")
                    baslangic_saati = calisma("baslangicSaat")
                    %>
                    ---
                <% end if %>
                </td>
                <td><%=calisma("sure") %></td>
                <td><%=calisma("ekleyen_adsoyad") %></td>
                <td>
                    <%if isnull(calisma("bitis")) = false then %>
                    <button type="button" class="btn btn-info btn-mini" id="calisma-duzenle<%=calisma("id") %>" onclick="calisma_kaydi_duzenleme('<%=calisma("id") %>', '<%=calisma("is_id") %>', '<%=calisma("ekleyen_id") %>');">Düzenle</button>
                    <%end if %>
                </td>
            </tr>
            <%
            calisma.movenext
            loop

            SQL = "with sorgu as (SELECT CASE WHEN ISNULL(c.bitis, 0) = 0 THEN '00:00:00' ELSE CASE WHEN LEN(CONVERT(NVARCHAR(10), DATEDIFF(HOUR, c.baslangic, c.bitis))) = 1 THEN '0' ELSE '' END + CONVERT(nvarchar(10), DATEDIFF(HOUR, 0, DATEADD(MINUTE, CONVERT(int, DATEDIFF(MINUTE, c.baslangic, c.bitis)), ''))) + ':' + CASE WHEN LEN(CONVERT(NVARCHAR(50), DATEDIFF(MINUTE, c.baslangic, c.bitis) % 60)) = 1 THEN '0' ELSE '' END + CONVERT(NVARCHAR(50), DATEDIFF(MINUTE, c.baslangic, c.bitis) % 60) + ':00' END AS sure FROM ucgem_is_calisma_listesi c JOIN ucgem_firma_kullanici_listesi ekleyen WITH (NOLOCK) ON ekleyen.id = c.ekleyen_id WHERE c.is_id = '"& is_id &"' and c.ekleyen_id = '"& gorevli_id &"' and c.firma_id = '"& FirmaID &"' and c.cop = 'false') select CASE WHEN LEN(CAST((CONVERT(char(8), SUM(CONVERT(int, LEFT(sure, CHARINDEX(':', sure) - 1)) * 60 + SUBSTRING(sure, CHARINDEX(':', sure) + 1, 2))) / 60) AS VARCHAR(10))) < 2 THEN '0'+ CAST((CONVERT(char(8), SUM(CONVERT(int, LEFT(sure, CHARINDEX(':', sure) - 1)) * 60 + SUBSTRING(sure, CHARINDEX(':', sure) + 1, 2))) / 60) AS VARCHAR(10)) ELSE CAST((CONVERT(char(8), SUM(CONVERT(int, LEFT(sure, CHARINDEX(':', sure) - 1)) * 60 + SUBSTRING(sure, CHARINDEX(':', sure) + 1, 2))) / 60) AS VARCHAR(10)) END + ':' + CASE WHEN LEN(CAST (CONVERT(char(8), SUM(CONVERT(int, LEFT(sure, CHARINDEX(':', sure) - 1)) * 60 + SUBSTRING(sure, CHARINDEX(':', sure) + 1, 2))) % 60 AS VARCHAR(10))) < 2 THEN +'0' + CAST (CONVERT(char(8), SUM(CONVERT(int, LEFT(sure, CHARINDEX(':', sure) - 1)) * 60 + SUBSTRING(sure, CHARINDEX(':', sure) + 1, 2))) % 60 AS VARCHAR(10)) ELSE CAST (CONVERT(char(8), SUM(CONVERT(int, LEFT(sure, CHARINDEX(':', sure) - 1)) * 60 + SUBSTRING(sure, CHARINDEX(':', sure) + 1, 2))) % 60 AS VARCHAR(10)) END + ':00' as toplamsure from sorgu"
            set toplamCalisma = baglanti.execute(SQL)
            'response.Write(SQL)
            SQL = "SELECT COUNT(DISTINCT c.ekleyen_id) as sayi  FROm ucgem_is_calisma_listesi c WHERE c.is_id = '"& is_id &"' and c.cop = 'false'"
            set userSayi = baglanti.execute(SQL)
            %>
        </tbody>
        <tfoot class="bg-light">
            <tr style="<%=state %>">
               <td></td>
               <td class="font-weight-bold">Toplam Süre</td>
               <td class="font-weight-bold"><%=toplamCalisma("toplamsure") %></td>
               <td></td>
               <td></td>
           </tr>
        </tfoot>
    </table>
</div>
<% 
    if girdimi = true and CStr(user_id) = Request.Cookies("kullanici")("kullanici_id") then 
        saniye =  DateDiff("s",fromDate,toDate)
        userId = user_id
%>
<input type="hidden" id="sonacikkayit<%=is_id %>" baslangic_tarihi="<%=cdate(baslangic_tarihi) %>" baslangic_saati="<%=baslangic_saati %>" />
<script>
    timer = new easytimer.Timer();
    $(function () {
        timer.start({ precision: 'seconds', startValues: { seconds: <%=saniye %> }});

    setInterval(function () {
        $("#hour" + <%=userId %> + "-" + <%=is_id %>).html(timer.getTimeValues().toString().substring(0, 2));
        $("#minute" + <%=userId %> + "-" + <%=is_id %>).html(timer.getTimeValues().toString().substring(3, 5));
        $("#second" + <%=userId %> + "-" + <%=is_id %>).html(timer.getTimeValues().toString().substring(6, 8));
    }, 1000);

    $('.startButton').hide();
    $('.pauseButton').show();
    $('.stopButton').show();
    });
</script>
<% count = count + 1 %>
<% end if %>

<%

    elseif trn(request("islem"))="proje_plan_kopyala" then

        proje_id = trn(request("proje_id"))

        SQL="select proje_adi from ucgem_proje_listesi where id = '"& proje_id &"' and firma_id = '"& Request.Cookies("kullanici")("firma_id") &"'"
        set projecek = baglanti.execute(SQL)

%>
<div class="modal-header">
    <%=LNG("Üretim Şablonlarından Seç")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_personel_giris_form" class="smart-form validateform" novalidate="novalidate">
    <div class="modal-body">
        <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Üretim Şablonu")%></label>
        <div class="col-sm-12">
            <select class="select2" name="uretim_sablonu_id" id="uretim_sablonu_id">
                <%
                    SQL="select id, sablon_adi from uretim_sablonlari where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and cop = 'false'"
                    set projecek = baglanti.execute(SQL)
                    do while not projecek.eof
                %>
                <option value="<%=projecek("id") %>"><%=projecek("sablon_adi") %></option>
                <%
                    projecek.movenext
                    loop
                %>
            </select>
        </div>
    </div>
        <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("İşlem Tipi")%></label>
        <div class="col-sm-12">
            <select class="select2" name="islem_tipi" id="islem_tipi">
                <option value="1"><%=LNG("Mevcut Planlamanın Üstüne Yaz")%></option>
                <option value="2"><%=LNG("Mevcut Planlamanın Altına Ekle")%></option>
            </select>
        </div>
    </div>
    </div>
    <div class="modal-footer p-2">
        <input type="button" onclick="proje_sablon_kopyalama_baslat(this, '<%=proje_id %>');" class="btn btn-primary btn-sm mr-2" value="<%=LNG("Kopyala")%>" />
    </div>
    <div id="kopyalama_donus" style="display: none;"></div>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#uretim_sablonu_id, #islem_tipi").select2({
                dropdownParent: $("#modal_div")
            });
        });
    </script>
</form>
<%
    elseif trn(request("islem")) = "calisma_kaydi_duzenleme" then

        ID = trn(request("ID"))
        IsID = trn(request("IsID"))
        GorevliID = trn(request("GorevliID"))
        
        SQL = "SELECT RIGHT('0'+CAST(DATEPART(HOUR, c.baslangic)as varchar(2)),2)+ ':'+ RIGHT('0'+CAST(DATEPART(minute, c.baslangic)as varchar(2)),2) as baslangicSaat, RIGHT('0'+CAST(DATEPART(HOUR, c.bitis)as varchar(2)),2)+ ':'+ RIGHT('0'+CAST(DATEPART(minute, c.bitis)as varchar(2)),2) as bitisSaat, c.baslangic, c.bitis FROM ucgem_is_calisma_listesi c JOIN ucgem_firma_kullanici_listesi ekleyen WITH (NOLOCK) ON ekleyen.id = c.ekleyen_id WHERE c.is_id = '"& IsID &"' and c.ekleyen_id = '"& GorevliID &"' and c.id = '"& ID &"' and c.firma_id = '"& FirmaID &"' and c.cop = 'false' ORDER BY c.id ASC;"
        set calismaKaydi = baglanti.execute(SQL)
%>
<div class="modal-header">
    Çalışma Kaydı Güncelleme
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<div class="modal-body pt-0">
    <div class="row">
        <div class="col-md-7">
            <div class="form-group mb-1">
                <label class="col-form-label">Başlangıç Tarihi</label>
                <input type="text" class="form-control form-control-sm takvimyap" id="BaslangicTarihi" value="<%=FormatDate(calismaKaydi("baslangic"), "00") %>"/>
            </div>
        </div>
        <div class="col-md-5">
            <div class="form-group mb-1">
                <label class="col-form-label">Başlangıç Saati</label>
                <input type="text" class="form-control form-control-sm timepicker" id="BaslangicSaati" value="<%=calismaKaydi("baslangicSaat") %>"/>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-7">
            <div class="form-group mb-1">
                <label class="col-form-label">Bitiş Tarihi</label>
                <input type="text" class="form-control form-control-sm takvimyap" id="BitisTarihi" value="<%=FormatDate(calismaKaydi("bitis"), "00") %>"/>
                <script type="text/javascript">
                   
                    $("#BaslangicTarihi").on("change", function () {
                        $("#BitisTarihi").datepicker({
                            minDate: $("#BaslangicTarihi").val()
                        }).val($("#BaslangicTarihi").val());
                    });
                   
                </script>
            </div>
        </div>
        <div class="col-md-5">
            <div class="form-group mb-1">
                <label class="col-form-label">Bitiş Saati</label>
                <input type="text" class="form-control form-control-sm timepicker" id="BitisSaati" value="<%=calismaKaydi("bitisSaat") %>"/>
            </div>
        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-info btn-mini" onclick="calisma_kaydi_duzenle('<%=ID %>', '<%=IsID %>', '<%=GorevliID %>')">Kaydı Güncelle</button>
</div>
<%
   elseif trn(request("islem"))="proje_sablon_kopyalama_baslat" then

        hedef_proje_id = trn(request("proje_id"))
        uretim_sablonu_id = trn(request("uretim_sablonu_id"))
        islem_tipi = trn(request("islem_tipi"))

        if trim(islem_tipi)="1" then

            SQL="delete from ahtapot_proje_gantt_adimlari where proje_id = '"& hedef_proje_id &"' and firma_id = '"& FirmaID &"'"
            set sil = baglanti.execute(SQL)

            SQL="insert into ahtapot_proje_gantt_adimlari(start_tarih, end_tarih, start_tarih_uygulama, end_tarih_uygulama, cop, proje_id, name, progress, progressByWorklog, irelevance, type, typeId, description, code, ilevel, status, depends, start, duration, iend, start_uygulama, duration_uygulama, iend_uygulama, startIsMilestone, endIsMilestone, collapsed, canWrite, canAdd, canDelete, canAddIssue, hasChild, firma_id) select start_tarih, end_tarih, start_tarih_uygulama, end_tarih_uygulama, cop, '"& hedef_proje_id &"', name, 0, progressByWorklog, irelevance, type, typeId, description, code, ilevel, status, depends, start, duration, iend, start_uygulama, duration_uygulama, iend_uygulama, startIsMilestone, endIsMilestone, collapsed, canWrite, canAdd, canDelete, canAddIssue, hasChild, firma_id from ahtapot_sablon_gantt_adimlari where proje_id = '"& uretim_sablonu_id &"'"
            set ekle = baglanti.execute(SQL)

        elseif trim(islem_tipi)="2" then

            SQL="select isnull(count(id),0) from ahtapot_proje_gantt_adimlari where proje_id = '"& hedef_proje_id &"' and firma_id = '"& FirmaID &"'"
            set kactanecek = baglanti.execute(SQL)
    

            kactane = kactanecek(0)

            SQL="insert into ahtapot_proje_gantt_adimlari(start_tarih, end_tarih, start_tarih_uygulama, end_tarih_uygulama, cop, proje_id, name, progress, progressByWorklog, irelevance, type, typeId, description, code, ilevel, status, depends, start, duration, iend, start_uygulama, duration_uygulama, iend_uygulama, startIsMilestone, endIsMilestone, collapsed, canWrite, canAdd, canDelete, canAddIssue, hasChild, firma_id) select start_tarih, end_tarih, start_tarih, end_tarih, cop, '"& hedef_proje_id &"', name, 0, progressByWorklog, irelevance, type, typeId, description, code, ilevel, status, depends, start, duration, iend, start, duration, iend, startIsMilestone, endIsMilestone, collapsed, canWrite, canAdd, canDelete, canAddIssue, hasChild, firma_id from ahtapot_sablon_gantt_adimlari where proje_id = '"& uretim_sablonu_id &"' and ltrim(ilevel) != '0'"
            set ekle = baglanti.execute(SQL)

            SQL="select * from ahtapot_sablon_gantt_adimlari where proje_id = '"& uretim_sablonu_id &"' and firma_id = '"& FirmaID &"' and ltrim(ilevel) != '0' order by id asc"
            set cek = baglanti.execute(SQL)
            

        end if

    elseif trn(request("islem"))="servis_getir" then

        proje_id = trn(request("proje_id"))

%>
<div class="card" style="padding: 15px;">


    <div class="row">
        <div class="col-md-4">
            <h5>Periyodik Bakım Ayarları</h5>

            <div class="row toplanti_tipi rutin" style="display: nones; margin-top: 10px;">
                <div class="col-sm-6">
                    <label class="col-form-label"><%=LNG("Yineleme Başlangıç Tarihi :")%></label>
                    <div class="input-group input-group-primary">
                        <span class="input-group-addon">
                            <i class="icon-prepend fa fa-user"></i>
                        </span>
                        <input type="text" id="yineleme_baslangic" name="yineleme_baslangic" class="form-control takvimyap required" required />
                    </div>
                </div>
            </div>
            <div class="row toplanti_tipi rutin" style="display: nones; margin-top: 10px;">
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


            <br />
            <input type="button" class="btn btn-primary" onclick="ProjeBakimKaydiEkle('<%=proje_id%>');" value="Güncelle" />
        </div>
        <div class="col-md-8">
            <h5>Periyodik Bakım Kayıtları</h5>
            <br />
            <div id="servis_kayit_donus">
                <script>
                     $(function (){
                        proje_bakim_kayitlarini_getir('<%=proje_id %>');
                     });
                </script>
            </div>
            <hr />
            <h5>Planlanan Servis/Bakım Listesi</h5>
            <hr />
            <div>
                <table id="tblServisBakim" class="table table-bordered table-sprited text-nowrap" style="width: 100%">
                    <thead>
                        <tr style="display: none">
                            <th></th>
                            <th>
                                <select class="select2 form-control" id="firma">
                                    <option value="" selected>Tümü</option>
                                </select></th>
                            <th>
                                <select class="select2 form-control" id="yetkili">
                                    <option value="" selected>Tümü</option>
                                </select></th>
                            <th>
                                <select class="select2 form-control" id="gorevli">
                                    <option value="" selected>Tümü</option>
                                </select></th>
                            <th>
                                <select class="select2 form-control" id="adress">
                                    <option value="" selected>Tümü</option>
                                </select></th>
                            <th>
                                <select class="select2 form-control" id="tarih">
                                    <option value="" selected>Tümü</option>
                                </select></th>
                            <th></th>
                        </tr>
                        <tr>
                            <th>Id</th>
                            <th>Firma Ünvanı</th>
                            <th>Yetkili</th>
                            <th>Görevliler</th>
                            <th>Adress</th>
                            <th>Ekleme Tarihi</th>
                            <th>Işlem</th>
                        </tr>
                    </thead>
                    <tbody id="congress">
                        <%
                SQL = "select kullanici.personel_ad + ' ' + kullanici.personel_soyad as ekleyen, servis.* from servis_bakim_kayitlari servis join ucgem_firma_kullanici_listesi kullanici on kullanici.id = servis.EkleyenId where servis.ProjeId = '"& proje_id &"' and servis.firma_id = '"& FirmaID &"' and servis.Durum = 'true' and servis.Cop = 'false' order by servis.id desc"
                set servisBakim = baglanti.execute(SQL)

                if servisBakim.eof then
                        %>
                        <tr>
                            <td colspan="10" style="text-align: center">Kayıt Bulunamadı</td>
                        </tr>
                        <%
                end if
                k = 0
                do while not servisBakim.eof
                    k = k + 1
                        %>
                        <tr>
                            <td><%=k %></td>
                            <td><%=servisBakim("FirmaUnvani") %></td>
                            <td><%=servisBakim("Yetkili") %></td>
                            <td>
                                <%
                    for x = 0 to ubound(split(servisBakim("Gorevliler"), ","))
                        user = split(servisBakim("Gorevliler"), ",")(x)
                        SQL="SELECT * FROM ucgem_firma_kullanici_listesi WHERE id = '"& user &"' and firma_id = '"& FirmaID &"'" 
                        set kcek2 = baglanti.execute(SQL)  
                                %>
                                <%=kcek2("personel_ad") & " " & kcek2("personel_soyad") %><br />
                                <%next %>
                            </td>
                            <td><%=servisBakim("Adress") %></td>

                            <td><%=servisBakim("EklemeTarihi") %></td>
                            <td>
                                <button type="button" class="btn btn-mini btn-primary dropdown-toggle dropdown-toggle-split waves-effect waves-light" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    İşlemler
                                </button>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item waves-effect waves-light" onclick="rapor_pdf_indir('teknik_servis_formu', '<%=Request.Cookies("kullanici")("kullanici_id") %>', '<%=servisBakim("id") %>');" href="javascript:void(0);">Servis Formu Oluştur</a>
                                    <a class="dropdown-item waves-effect waves-light" onclick="ServisBakimKaydiDuzenle(<%=servisBakim("id") %>, <%=servisBakim("FirmaId") %>);" href="javascript:void(0);">Düzenle</a>
                                    <a class="dropdown-item waves-effect waves-light" onclick="ServisBakimKaydiSil(<%=servisBakim("id") %>);" href="javascript:void(0);">Sil</a>
                                </div>
                            </td>
                        </tr>
                        <%
                servisBakim.movenext
                loop
                        %>
                    </tbody>
                </table>
                <script type="text/javascript">
                    var firma = [];
                    var yetkili = [];
                    var gorevli = [];
                    var adress = [];
                    var tarih = [];

                    function unique(list) {
                        var result = [];
                        $.each(list, function (i, e) {
                            if ($.inArray(e, result) == -1) result.push(e);
                        });
                        return result;
                    }

                    $("#tblServisBakim tr:gt(0)").each(function () {
                        var this_row = $(this);

                        firma.push($.trim(this_row.find('td:eq(1)').html()));
                        yetkili.push($.trim(this_row.find('td:eq(2)').html()));
                        gorevli.push($.trim(this_row.find('td:eq(3)').html()));
                        adress.push($.trim(this_row.find('td:eq(4)').html()));
                        tarih.push($.trim(this_row.find('td:eq(5)').html()));
                    });

                    $.each(unique(firma), function (index, value) {
                        if (value !== "") {
                            $("#firma").append("<option> " + value + " </option>");
                        }
                    });
                    $.each(unique(yetkili), function (index, value) {
                        if (value !== "") {
                            $("#yetkili").append("<option> " + value + " </option>");
                        }
                    });
                    $.each(unique(gorevli), function (index, value) {
                        if (value !== "") {
                            $("#gorevli").append("<option> " + value + " </option>");
                        }
                    });
                    $.each(unique(adress), function (index, value) {
                        if (value !== "") {
                            $("#adress").append("<option> " + value + " </option>");
                        }
                    });
                    $.each(unique(tarih), function (index, value) {
                        if (value !== "") {
                            $("#tarih").append("<option> " + value + " </option>");
                        }
                    });



                    $(document).ready(function () {
                        $("#firma").on("change", function () {
                            var value = $(this).val().toLowerCase();
                            $("#tblServisBakim tbody tr").filter(function () {
                                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                            });
                        });
                        $("#yetkili").on("change", function () {
                            var value = $(this).val().toLowerCase();
                            $("#tblServisBakim tbody tr").filter(function () {
                                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                            });
                        });
                        $("#gorevli").on("change", function () {
                            var value = $(this).val().toLowerCase();
                            $("#tblServisBakim tbody tr").filter(function () {
                                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                            });
                        });
                        $("#adress").on("change", function () {
                            var value = $(this).val().toLowerCase();
                            $("#tblServisBakim tbody tr").filter(function () {
                                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                            });
                        });
                        $("#tarih").on("change", function () {
                            var value = $(this).val().toLowerCase();
                            $("#tblServisBakim tbody tr").filter(function () {
                                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                            });
                        });
                    });

                    $(document).ready(function () {

                        var $table = $('#tblServisBakim');
                        //$table.find('thead tr').filter(':eq(1),:eq(2)').css('visibility', 'visible').each(function () {
                        //    var title = $(this).text();
                        //    $(this).html('<input type="text" placeholder="Search ' + title + '" />');
                        //});
                        // Setup - add a text input to each footer cell
                        $('#tblServisBakim thead tr').clone(true).appendTo('#tblServisBakim thead');
                        $('#tblServisBakim thead tr:eq(1) th').each(function (i) {
                            var title = $(this).text();
                            $(this).html('<input type="text" id="' + i + '" placeholder="' + title + '" />');

                            $('input', this).on('keyup change', function () {
                                if (table.column(i).search() !== this.value) {
                                    table
                                        .column(i)
                                        .search(this.value)
                                        .draw();
                                }
                            });
                        });

                        var table = $('#tblServisBakim').DataTable({
                            orderCellsTop: true,
                            fixedHeader: true
                        });
                    });
                </script>
                <script type="text/javascript">
                    $(document).ready(function () {
                        $("#0").hide();
                        $("#6").hide();
                    });
                </script>
            </div>
        </div>
    </div>

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

<%
    elseif trn(request("islem"))="ProjeBakimKaydiEkle" then

        ProjeId = trn(request("ProjeId"))
        proje_id = ProjeId

        if trn(request("islem2"))="onay" then

            BakimID = trn(request("BakimID"))

            SQL="update proje_bakim_kayitlari set durum = 'Tamamlandı' where id = '" & BakimID &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)

        elseif trn(request("islem2"))="ekle" then

            yineleme_donemi = trn(request("yineleme_donemi"))
            gunluk_yineleme_secim = trn(request("gunluk_yineleme_secim"))
            gunluk_yineleme_gun_aralik = trn(request("gunluk_yineleme_gun_aralik"))
            haftalik_yineleme_sikligi = trn(request("haftalik_yineleme_sikligi"))
            gunler = trn(request("gunler"))
            aylik_yenileme_tipi = trn(request("aylik_yenileme_tipi"))
            aylik_gun = trn(request("aylik_gun"))
            aylik_aralik = trn(request("aylik_aralik"))
            aylik_yineleme1 = trn(request("aylik_yineleme1"))
            aylik_yineleme2 = trn(request("aylik_yineleme2"))
            aylik_yineleme3 = trn(request("aylik_yineleme3"))
            yineleme_baslangic = trn(request("yineleme_baslangic"))
            yineleme_bitis = trn(request("yineleme_bitis"))


            durum = "İşlem Bekliyor"
            cop = "false"
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time

            proje_id = ProjeId

            if trim(yineleme_donemi) = "gunluk" then

    
                if trim(gunluk_yineleme_secim)="gunluk" then


                    y = 0
                    for x = cdate(yineleme_baslangic) to cdate(yineleme_bitis) step cint(gunluk_yineleme_gun_aralik)
     
                        y = y + 1

                        toplanti_sira = y
                        toplanti_tarihi = cdate(x)
                        toplanti_saati = toplanti_saati

                        tarih = toplanti_tarihi
                        SQL="insert into proje_bakim_kayitlari(proje_id, tarih, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', CONVERT(date, '"& tarih &"', 103), '"& durum &"', '"& cop &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
                        set ekle = baglanti.execute(SQL)


                    next

                else
                    ' iş günü
                    y = 0
                    for x = cdate(yineleme_baslangic) to cdate(yineleme_bitis)

                        if weekday(cdate(x))=1 or weekday(cdate(x))=7 then
                        else
                            y = y + 1
                            toplanti_sira = y
                            toplanti_tarihi = cdate(x)
                            toplanti_saati = toplanti_saati

                            tarih = toplanti_tarihi
                            SQL="insert into proje_bakim_kayitlari(proje_id, tarih, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', CONVERT(date, '"& tarih &"', 103), '"& durum &"', '"& cop &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
                            set ekle = baglanti.execute(SQL)

                        end if

                    next

                end if

            elseif trim(yineleme_donemi) = "haftalik" then

                gunler = "," & gunler & ","
                hafta = 0
                y = 0
                girdimi = false
                for x = cdate(yineleme_baslangic) to cdate(yineleme_bitis)
                    if weekday(cdate(x))= 2 then
                        if hafta = 0 and girdimi = true then
                            hafta = 1
                        else
                            hafta = hafta + 1
                        end if
                    end if
                    if hafta mod cint(haftalik_yineleme_sikligi) = 0 or hafta = 0 then
                        if instr(gunler, "," & weekday(cdate(x)) & ",")>0 then

                            y = y + 1
                            toplanti_sira = y
                            toplanti_tarihi = cdate(x)
                            toplanti_saati = toplanti_saati

                            tarih = toplanti_tarihi
                            SQL="insert into proje_bakim_kayitlari(proje_id, tarih, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', CONVERT(date, '"& tarih &"', 103), '"& durum &"', '"& cop &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
                            set ekle = baglanti.execute(SQL)

                            girdimi = true

                        end if
                    end if
                next

            elseif trim(yineleme_donemi) = "aylik" then

                if trim(aylik_yenileme_tipi)="1" then
                    y = 0
                    ay = 0
                    girdimi = false
                    for x = cdate(yineleme_baslangic) to cdate(yineleme_bitis)
                        if day(cdate(x)) = 1 then
                            if ay = 0 and girdimi = true then
                                ay = 1
                            else
                                ay = ay + 1
                            end if
                        end if
                        if ay mod cint(aylik_aralik) = 0 or ay = 0 then
                            if day(cdate(x))=cint(aylik_gun) then

                                y = y + 1
                                toplanti_sira = y
                                toplanti_tarihi = cdate(x)
                                toplanti_saati = toplanti_saati

                                tarih = toplanti_tarihi
                                SQL="insert into proje_bakim_kayitlari(proje_id, tarih, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', CONVERT(date, '"& tarih &"', 103), '"& durum &"', '"& cop &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
                                set ekle = baglanti.execute(SQL)

                                girdimi = true

                            end if
                        end if
                    next

                elseif trim(aylik_yenileme_tipi)="2" then

                      

                    if trim(aylik_yineleme2)="gün" then
                        if aylik_yineleme1 = "son" then

                                y = 0
                                for x = cdate(yineleme_baslangic) to cdate(yineleme_bitis)
                                    son_gun = cdate(AyinSonGunu(x) & "." & month(cdate(x)) & "." & year(cdate(x)))

                                    if cdate(son_gun) = cdate(x) then

                                        y = y + 1
                                        toplanti_sira = y
                                        toplanti_tarihi = son_gun
                                        toplanti_saati = toplanti_saati

                                        tarih = toplanti_tarihi
                                        SQL="insert into proje_bakim_kayitlari(proje_id, tarih, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', CONVERT(date, '"& tarih &"', 103), '"& durum &"', '"& cop &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
                                        set ekle = baglanti.execute(SQL)

                                    end if

                                next

                            else

                                y = 0
                                for x = cdate(yineleme_baslangic) to cdate(yineleme_bitis)
                                    if int(day(cdate(x))) = int(aylik_yineleme1) then

                                        y = y + 1
                                        toplanti_sira = y
                                        toplanti_tarihi = cdate(x)
                                        toplanti_saati = toplanti_saati

                                        tarih = toplanti_tarihi
                                        SQL="insert into proje_bakim_kayitlari(proje_id, tarih, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', CONVERT(date, '"& tarih &"', 103), '"& durum &"', '"& cop &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
                                        set ekle = baglanti.execute(SQL)

                                    end if
                                next

                            end if

                        end if

                    else

                        if aylik_yineleme1 = "son" then

                                girdimi = false
                                son_ay = 14
                                son_gun = cdate(AyinSonGunu(yineleme_baslangic) & "." & month(cdate(yineleme_baslangic)) & "." & year(cdate(yineleme_baslangic)))
                                y = 0

                                for x = cdate(yineleme_bitis) to cdate(son_gun)

                                    if weekday(cdate(x))= int(aylik_yineleme2) and cdate(x) <= cdate(request("yineleme_baslangic")) then
                                        if not cint(son_ay) = cint(month(cdate(x))) then
                                            son_ay = int(month(cdate(x)))

                                            y = y + 1
                                            toplanti_sira = y
                                            toplanti_tarihi = cdate(x)
                                            toplanti_saati = toplanti_saati

                                            tarih = toplanti_tarihi
                                            SQL="insert into proje_bakim_kayitlari(proje_id, tarih, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', CONVERT(date, '"& tarih &"', 103), '"& durum &"', '"& cop &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
                                            set ekle = baglanti.execute(SQL)

                                        end if
                                    end if

                                next
                                    
                            else


                                baslangic_ay = "01." & month(cdate(yineleme_baslangic)) & "." & year(cdate(yineleme_baslangic))
                                y = 0
                                kacinci = 0
                                for x = cdate(baslangic_ay) to cdate(yineleme_bitis)
                                    if cint(weekday(cdate(x)))=cint(aylik_yineleme2) then
                                        kacinci = kacinci + 1
                                        if cint(aylik_yineleme1)=cint(kacinci) then

                                            y = y + 1
                                            toplanti_sira = y
                                            toplanti_tarihi = cdate(x)
                                            toplanti_saati = toplanti_saati

                                            tarih = toplanti_tarihi
                                            SQL="insert into proje_bakim_kayitlari(proje_id, tarih, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', CONVERT(date, '"& tarih &"', 103), '"& durum &"', '"& cop &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
                                            set ekle = baglanti.execute(SQL)

                                        end if
                                    end if
                                next

                            end if
                        end if
                    end if


        elseif trn(request("islem2"))="sil" then

            BakimID = trn(request("BakimID"))

            SQL="delete from proje_bakim_kayitlari where id = '"& BakimID &"' and firma_id = '"& FirmaID &"'"
            set sil = baglanti.execute(SQL)

        end if

        Tum = trn(request("Tum"))
%>
<table class="table datatableyap table-bordered table-sprited" style="width: 100%;">
    <thead>
        <tr>
            <th style="width: 30px;">Id</th>
            <% if trn(request("Tum"))="true" then %>
            <th>Proje Adı</th>
            <% end if %>
            <th>Planlanan Tarih</th>
            <th>Durum</th>
            <th>Ekleyen</th>
            <th>Ekleme Tarihi</th>
            <th style="width: 30px;">İşlem</th>
        </tr>
    </thead>
    <tbody>
        <%
                if trn(request("Tum"))="true" then
                    if trn(request("islem2"))="arama" then

                        proje_id = trn(request("proje_id"))
                        baslangic_tarihi = trn(request("baslangic_tarihi"))
                        bitis_tarihi = trn(request("bitis_tarihi"))
                        bakim_durum = trn(request("bakim_durum"))

                        if not trim(proje_id)="0" then
                            sorgu_str = " and bakim.proje_id = '"& proje_id &"'"
                        end if

                        if isdate(baslangic_tarihi)=true and isdate(bitis_tarihi)=true then
                            sorgu_str = " and bakim.tarih between CONVERT(date, '"& cdate(baslangic_tarihi) &"', 103) and CONVERT(date, '"& cdate(bitis_tarihi) &"',103)"
                        elseif isdate(baslangic_tarihi)=true then
                            sorgu_str = " and bakim.tarih >= CONVERT(date,'"& cdate(baslangic_tarihi) &"',103)"
                        elseif isdate(bitis_tarihi)=true then
                            sorgu_str = " and bakim.tarih <= CONVERT(date,'"& cdate(bitis_tarihi) &"',103)"
                        end if

                        if not trim(bakim_durum)="0" then
                            sorgu_str = " and bakim.durum = '"& bakim_durum &"'"
                        end if

                        SQL="select proje.proje_adi, kullanici.personel_ad + ' ' + kullanici.personel_soyad as ekleyen, bakim.* from proje_bakim_kayitlari bakim join ucgem_firma_kullanici_listesi kullanici on kullanici.id = bakim.ekleyen_id  join ucgem_proje_listesi proje on proje.id = bakim.proje_id where proje.firma_id = '"& FirmaID &"' and kullanici.firma_id = '"& FirmaID &"' and bakim.firma_id = '"& FirmaID &"' and bakim.cop = 'false' "& sorgu_str &" order by bakim.tarih asc"
                    else
                        SQL="select proje.proje_adi, kullanici.personel_ad + ' ' + kullanici.personel_soyad as ekleyen, bakim.* from proje_bakim_kayitlari bakim join ucgem_firma_kullanici_listesi kullanici on kullanici.id = bakim.ekleyen_id  join ucgem_proje_listesi proje on proje.id = bakim.proje_id where proje.firma_id = '"& FirmaID &"' and kullanici.firma_id = '"& FirmaID &"' and bakim.firma_id = '"& FirmaID &"' and bakim.cop = 'false' order by bakim.tarih asc"
                    end if

                else
                    SQL="select kullanici.personel_ad + ' ' + kullanici.personel_soyad as ekleyen, bakim.* from proje_bakim_kayitlari bakim join ucgem_firma_kullanici_listesi kullanici on kullanici.id = bakim.ekleyen_id where bakim.proje_id = '"& proje_id &"' and bakim.firma_id = '"& FirmaID &"' and kullanici.firma_id = '"& FirmaID &"' and bakim.cop = 'false' order by bakim.tarih asc"
                end if

                set bakim = baglanti.execute(SQL)
                if bakim.eof then
        %>
        <tr>
            <td colspan="6" style="text-align: center;">Tanımlanmış Bakım Kaydı Bulunamadı</td>
        </tr>
        <%
                end if
                k = 0
                do while not bakim.eof
                    k = k + 1
        %>
        <tr>
            <td><%=k %></td>
            <% if trn(request("Tum"))="true" then %>
            <td><%=bakim("proje_adi") %></td>
            <% end if %>
            <td><%=cdate(bakim("tarih")) %></td>
            <td><% if trim(bakim("durum"))="Tamamlandı" then %><span class="label label-success" style="font-size: 100%; padding: 5px; display: inline;"><%=bakim("durum") %></span>
                <% else %>
                <span class="label label-warning" style="font-size: 100%; padding: 5px; display: inline;"><%=bakim("durum") %></span>
                <% end if %></td>
            <td><%=bakim("ekleyen") %></td>
            <td><%=cdate(bakim("ekleme_tarihi")) %>&nbsp;<%=left(bakim("ekleme_saati"),5) %></td>
            <td style="width: 10px;">

                <input type="button" class="btn btn-primary btn-mini" value="<%=LNG("İş Emri Oluştur")%>" onclick="BakimdanIsEmriOlustur('<%=bakim("proje_id") %>', '<%=bakim("id") %>', '<%=Tum %>', '<%=cdate(bakim("tarih")) %>');" />
                <input type="button" class="btn btn-danger btn-mini" value="<%=LNG("Sil")%>" onclick="ProjeBakimKaydiSil('<%=bakim("proje_id") %>', '<%=bakim("id") %>', '<%=Tum %>');" />

            </td>
        </tr>
        <%
                bakim.movenext
                loop
        %>
    </tbody>
</table>
<%
    elseif trn(request("islem"))="YeniServisBakimKaydiEkle" then
    
        if trn(request("islem2"))="ekle" then
            firmaunvani = trn(request("firmaunvani"))
            firmayetkili = trn(request("firmayetkili"))
            firmatelefon = trn(request("firmatelefon"))
            firmaeposta = trn(request("firmaeposta"))
            firmaadress = trn(request("firmaadress"))
            firmavergidairesi = trn(request("firmavergidairesi"))
            firmavergino = trn(request("firmavergino"))
            listeyeekle = trn(request("listeyeekle"))
            gorevli = trn(request("gorevli"))
            'parcaId = trn(request("parcaId"))
            'adet = trn(request("adet"))
            musteri_id = trn(request("musteri_id"))
            proje_id = trn(request("proje_id"))
            rapor_durumu = trn(request("rapor_durumu"))
            personelbildirim = trn(request("personelbildirim"))
            if musteri_id = "null" then
                musteri_id = 0
            end if

            siparisdurumu = trn(request("siparisdurumu"))
            siparisparcaid = trn(request("siparisparcaid"))
            siparisadet = trn(request("siparisadet"))
            stokparcaid = trn(request("stokparcaid"))
            stokadet = trn(request("stokadet"))

            sayi = trn(request("sayi"))
            ParcaId = trn(request("ParcaId"))
            Adet = trn(request("Adet"))
            
            firmamakinebilgi = trn(request("firmamakinebilgi"))
            firmaariza = trn(request("firmaariza"))
            baslangic_tarihi = trn(request("baslangic_tarihi"))
            bitis_tarihi = trn(request("bitis_tarihi"))
            baslangic_saati = trn(request("baslangic_saati"))
            bitis_saati = trn(request("bitis_saati"))
            firmayapilanislemler = trn(request("firmayapilanislemler"))
            firmanot = trn(request("firmanot"))
            
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time
            durum = "true"
            cop = "false"
            oncelik = "Normal"
            satinalmaDurum = "Onay Bekliyor"
            baslik = "Servis Formu"

            parcaKullanildimi = false
            StoktanKullanilanAdet = ""
            if ParcaId = "" then
            else
                parcaKullanildimi = true
            end if

            if sayi = "birdenfazla" then

                for y = 0 to ubound(split(ParcaId, ","))
                    bolunmusId = split(ParcaId, ",")(y)
                    bolunmusAdet = split(Adet, ",")(y)

                    SQL = "select * from parca_listesi where id = '"& bolunmusId &"' and firma_id = '"& FirmaID  &"'"
                    set stokkontrol = baglanti.execute(SQL)
                    
                    result = stokkontrol("miktar") - bolunmusAdet
                    if result > 0 or result = 0 then
                        if StoktanKullanilanAdet = "" then
                            StoktanKullanilanAdet = bolunmusAdet
                        else
                            StoktanKullanilanAdet = StoktanKullanilanAdet & "," & bolunmusAdet
                        end if
                        SQL = "update parca_listesi set miktar = miktar - '"& bolunmusAdet &"' where id = '"& bolunmusId &"' and firma_id = '"& FirmaID &"'"
                        set stokGuncelle = baglanti.execute(SQL)
                    else
                        if StoktanKullanilanAdet = "" then
                            StoktanKullanilanAdet = stokkontrol("miktar")
                        else
                            StoktanKullanilanAdet = StoktanKullanilanAdet & "," & stokkontrol("miktar")
                        end if
                        SQL = "update parca_listesi set miktar = 0 where id = '"& bolunmusId &"' and firma_id = '"& FirmaID  &"'"
                        set stokGuncelle = baglanti.execute(SQL)
                    end if                    
                next
            else
                    if parcaKullanildimi = true then
                        SQL = "select * from parca_listesi where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
                        set stokkontrol = baglanti.execute(SQL)
                        result2 = stokkontrol("miktar") - Adet
                        if result2 > 0 or result = 0 then
                            if StoktanKullanilanAdet = "" then
                                StoktanKullanilanAdet = Adet
                            else
                                StoktanKullanilanAdet = StoktanKullanilanAdet & "," & Adet
                            end if  
                            SQL = "update parca_listesi set miktar = miktar - '"& Adet &"' where id = '"& ParcaId &"' and firma_id = '"& FirmaID  &"'"
                            set stokGuncelle = baglanti.execute(SQL)
                        else
                            if StoktanKullanilanAdet = "" then
                                StoktanKullanilanAdet = stokkontrol("miktar")
                            else
                                StoktanKullanilanAdet = StoktanKullanilanAdet & "," & stokkontrol("miktar")
                            end if
                            SQL = "update parca_listesi set miktar = 0 where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
                            set stokGuncelle = baglanti.execute(SQL)
                        end if 
                    end if
            end if

            if rapor_durumu = "Faturası Kesildi" or rapor_durumu = "Faturası Kesilecek" then            
            else
                personelbildirim = 0
            end if

            SQL = "SET NOCOUNT ON; insert into servis_bakim_kayitlari (FirmaId, ProjeId, FirmaUnvani, Yetkili, Adress, Email, Telefon, VergiDairesi, VergiNo, Durum, Cop, EkleyenId, EkleyenIp, EklemeTarihi, EklemeSaati, Gorevliler, ParcaId, Adet, StoktanKullanilanAdet, MakinaBilgileri, BildirilenAriza, BaslangicTarihi, BitisTarihi, BaslangicSaati, BitisSaati, YapilanIslemler, FormNot, RaporDurumu, BildirimGonderilecekPersonelID) values('"& musteri_id &"', '"& proje_id &"', '"& firmaunvani &"', '"& firmayetkili &"', '"& firmaadress &"', '"& firmaeposta &"', '"& firmatelefon &"', '"& firmavergidairesi &"', '"& firmavergino &"', '"& durum &"', '"& cop &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), CONVERT(time, '"& ekleme_saati &"'), '"& gorevli &"', '"& ParcaId &"', '"& Adet &"', '"& StoktanKullanilanAdet &"', '"& firmamakinebilgi &"', '"& firmaariza &"', CONVERT(date, '"& baslangic_tarihi &"', 103), CONVERT(date, '"& bitis_tarihi &"', 103), CONVERT(time, '"& baslangic_saati &"'), CONVERT(time, '"& bitis_saati &"'), '"& firmayapilanislemler &"', '"& firmanot &"', '"& rapor_durumu &"', '"& personelbildirim &"'); select SCOPE_IDENTITY();"
            set servisekle = baglanti.execute(SQL)

            if rapor_durumu = "Faturası Kesildi" or rapor_durumu = "Faturası Kesilecek" then
                ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
                SQL = "select personel_ad + ' ' + personel_soyad as ad_soyad from ucgem_firma_kullanici_listesi where id = '"& ekleyen_id &"' and firma_id = '"& FirmaID &"' and cop = 'false'"
                set personel = baglanti.execute(SQL)

                bildirim = personel("ad_soyad") & " isimli personel yeni eklediği Teknik Servis Formunda rapor durumunu (" & rapor_durumu & ") olarak oluşturdu"
                tip = "bakim_yonetimi"
                click = "CokluIsYap(''bakim_yonetimi'',0,'' '',''0'');"
                okudumu = "0"
                durum = "true"
                cop = "false"
                firma_kodu = Request.Cookies("kullanici")("firma_kodu")
                firma_id = Request.Cookies("kullanici")("firma_id")
                ekleyen_ip = Request.ServerVariables("Remote_Addr")
                SQL="insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& bildirim &"', '"& tip &"', N'"& click &"', '"& personelbildirim &"', '"& okudumu &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate())"
                set personelBildirim = baglanti.execute(SQL)
            end if
                
            if listeyeekle = "true" then
                yetki_kodu = "MUSTERI"
                firma_hid = Request.Cookies("kullanici")("firma_id")
                SQL = "insert into ucgem_firma_listesi (yetki_kodu, firma_adi, firma_yetkili, firma_adres, firma_telefon, firma_mail) values('"& yetki_kodu &"', '"& firmaunvani &"', '"& firmayetkili &"', '"& firmaadress &"', '"& firmatelefon &"', '"& firmaeposta &"')"
                set yenimusteri = baglanti.execute(SQL)

                SQL = "select top 1 * from ucgem_firma_listesi order by id desc"
                set firmabilgisi = baglanti.execute(SQL)

                SQL = "SET NOCOUNT ON; insert into servis_bakim_kayitlari (FirmaId, ProjeId, FirmaUnvani, Yetkili, Adress, Email, Telefon, VergiDairesi, VergiNo, Durum, Cop, EkleyenId, EkleyenIp, EklemeTarihi, EklemeSaati, Gorevliler, ParcaId, Adet, MakinaBilgileri, BildirilenAriza, BaslangicTarihi, BitisTarihi, BaslangicSaati, BitisSaati, YapilanIslemler, FormNot) values('"& firmabilgisi("id") &"', '"& proje_id &"', '"& firmaunvani &"', '"& firmayetkili &"', '"& firmaadress &"', '"& firmaeposta &"', '"& firmatelefon &"', '"& firmavergidairesi &"', '"& firmavergino &"', '"& durum &"', '"& cop &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), CONVERT(time, '"& ekleme_saati &"'), '"& gorevli &"', '"& parcaId &"', '"& adet &"', '"& firmamakinebilgi &"', '"& firmaariza &"', CONVERT(date, '"& baslangic_tarihi &"', 103), CONVERT(date, '"& bitis_tarihi &"', 103), CONVERT(time, '"& baslangic_saati &"'), CONVERT(time, '"& bitis_saati &"'), '"& firmayapilanislemler &"', '"& firmanot &"'); select SCOPE_IDENTITY();"
                set servisekle = baglanti.execute(SQL)
            end if
                formId = servisekle(0)
    
            if siparisdurumu = "var" then

               SQL = "select * from satinalma_listesi where formId = '"& formId &"' and firma_id = '"& FirmaID &"'"
               set siparisVarmi = baglanti.execute(SQL)
  
               for x = 0 to ubound(split(siparisparcaid, ","))
                    parcaid = split(siparisparcaid, ",")(x)
                    adet = split(siparisadet, ",")(x)

                    SQL = "select * from parca_listesi where id = '"& parcaid &"' and firma_id = '"& FirmaID &"'"
                    set parcalar = baglanti.execute(SQL)

                    birimFiyat = CDbl(parcalar("birim_maliyet"))

                    birim = ""
                    if parcalar("birim_pb") = "" then
                       birim = "TL"
                    else
                       birim = parcalar("birim_pb")
                    end if

                    toplamTL = "0.00"
                    toplamEUR = "0.00"
                    toplamUSD = "0.00"
                    
                    if parcalar("birim_pb") = "TL" then
                          birim = "TL"
                          toplamTL = CDbl(birimFiyat * adet)
                    end if
                    if parcalar("birim_pb") = "USD" then
                          birim = "USD"
                          toplamUSD = CDbl(birimFiyat * adet)
                    end if
                    if parcalar("birim_pb") = "EUR" then
                          birim = "EUR"
                          toplamEUR = CDbl(birim_Fiyat * adet)
                    end if
               next
                               


               if siparisVarmi.eof then
                  SQL = "SET NOCOUNT ON; insert into satinalma_listesi(baslik, siparis_tarihi, oncelik, tedarikci_id, proje_id, aciklama, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, toplamtl, toplamusd, toplameur, formId) values('"& baslik &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& oncelik &"', '"& tedarikci_id &"', '"& proje_id &"', '"& aciklama &"', '"& satinalmaDurum &"', '"& cop &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"', '"& toplamtl &"', '"& toplamusd &"', '"& toplameur &"', '"& formId &"'); SELECT SCOPE_IDENTITY() id;"
                  set siparisFormu = baglanti.execute(SQL)
                  siparisId = siparisFormu(0)
               else

                  if parcalar("birim_pb") = "TL" then
                    SQL = "update satinalma_listesi set toplamtl = toplamtl + '"& toplamTL &"' where IsId = '"& siparisVarmi("formId") &"' and firma_id = '"& FirmaID &"'"
                    set satinalmaListesi = baglanti.execute(SQL)
                    satinalmaId = siparisFormuVarmi("id")
                  end if
                 
                  if parcalar("birim_pb") = "USD" then
                    SQL = "update satinalma_listesi set toplamusd = toplamusd + '"& toplamUSD &"' where IsId = '"& siparisVarmi("formId") &"' and firma_id = '"& FirmaID &"'"
                    set satinalmaListesi = baglanti.execute(SQL)
                    satinalmaId = siparisFormuVarmi("id")
                  end if
                 
                  if parcalar("birim_pb") = "EUR" then
                    SQL = "update satinalma_listesi set toplameur = toplameur + '"& toplamEUR &"' where IsId = '"& siparisVarmi("formId") &"' and firma_id = '"& FirmaID &"'"
                    set satinalmaListesi = baglanti.execute(SQL)
                    satinalmaId = siparisFormuVarmi("id")
                  end if

              end if
               siparisparcaid = trn(request("siparisparcaid"))
               'if siparisparcaid.IndexOf(",") > -1 then
                  for x = 0 to ubound(split(siparisparcaid, ","))
                      parcaid = split(siparisparcaid, ",")(x)
                      adet = split(siparisadet, ",")(x)
                    
                      SQL = "select * from satinalma_siparis_listesi where SatinalmaId = '"& siparisId &"' and firma_id = '"& FirmaID &"' and durum = 'true' and cop = 'false'"
                      set siparisVarmi = baglanti.execute(SQL)
                    
                      if siparisVarmi.eof then
                         SQL = "insert into satinalma_siparis_listesi(SatinalmaId, IsId, parcaId, maliyet, pb, adet, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, formId) values('"& siparisId &"', NULL, '"& parcaid &"', '"& birimFiyat &"', '"& birim &"', '"& adet &"', '"& durum &"', '"& cop &"', '"& firma_id &"','"& ekleyen_id &"','"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"', '"& formId &"')"
                         set satinalmaSiparisListesi = baglanti.execute(SQL)
                      else
                         if parcalar("birim_pb") = "TL" then
                            SQL = "update satinalma_listesi set toplamtl = toplamtl + '"& toplamTL &"' where formId = '"& siparisVarmi("formId") &"' and firma_id = '"& FirmaID &"'"
                            set satinalmaListesi = baglanti.execute(SQL)
                         end if

                         if parcalar("birim_pb") = "USD" then
                            SQL = "update satinalma_listesi set toplamusd = toplamusd + '"& toplamUSD &"' where formId = '"& siparisVarmi("formId") &"' and firma_id = '"& FirmaID &"'"
                            set satinalmaListesi = baglanti.execute(SQL)
                         end if
                         
                         if parcalar("birim_pb") = "EUR" then
                            SQL = "update satinalma_listesi set toplameur = toplameur + '"& toplamEUR &"' where formId = '"& siparisVarmi("formId") &"' and firma_id = '"& FirmaID &"'"
                            set satinalmaListesi = baglanti.execute(SQL)
                         end if
                     end if 
                 next
                'else


            'end if
        end if

        elseif trn(request("islem2"))="sil" then

            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            kayitId = trn(request("kayit_id"))

            SQL = "update servis_bakim_kayitlari set Cop = 'true' where id = '"& kayitId &"' and firma_id = '"& FirmaID &"'"
            set servissil = baglanti.execute(SQL)
    
            SQL = "select * from servis_bakim_kayitlari where id = '"& kayitId &"' and firma_id = '"& FirmaID &"' and Cop = 'true'"
            set silinenKayit = baglanti.execute(SQL)
            for x = 0 to ubound(split(silinenKayit("ParcaId"), ","))
                parcaid = split(silinenKayit("ParcaId"), ",")(x)
                adet = split(silinenKayit("StoktanKullanilanAdet"), ",")(x)
                
                SQL = "update parca_listesi set miktar = miktar + '"& adet &"' where id = '"& parcaid &"' and firma_id = '"& FirmaID &"'"
                set stokArttir = baglanti.execute(SQL)
            next
                

        elseif trn(request("islem2"))="duzenle" then

            firmaunvani = trn(request("firmaunvani"))
            firmayetkili = trn(request("firmayetkili"))
            firmatelefon = trn(request("firmatelefon"))
            firmaeposta = trn(request("firmaeposta"))
            
            firmavergidairesi = trn(request("firmavergidairesi"))
            firmaadress = trn(request("firmaadress"))
            firmavergino = trn(request("firmavergino"))
            listeyeekle = trn(request("listeyeekle"))
            gorevli = trn(request("gorevli"))
            proje_id = trn(request("proje_id"))
            rapor_durumu = trn(request("rapor_durumu"))
            personelbildirim = trn(request("personelbildirim"))
            musteri_id = trn(request("musteri_id"))
            if musteri_id = "null" then
                musteri_id = 0
            end if

            firmamakinebilgi = trn(request("firmamakinebilgi"))
            firmaariza = trn(request("firmaariza"))
            baslangic_tarihi = trn(request("baslangic_tarihi"))
            bitis_tarihi = trn(request("bitis_tarihi"))
            baslangic_saati = trn(request("baslangic_saati"))
            bitis_saati = trn(request("bitis_saati"))
            firmayapilanislemler = trn(request("firmayapilanislemler"))
            firmanot = trn(request("firmanot"))
            kayitId = trn(request("kayitId"))

            parcaId = trn(request("parcaId"))
            adet = trn(request("adet"))
            Dstokadet = trn(request("stokadet"))

            sayi = trn(request("sayi"))
            delparcaid = trn(request("delparcaid"))
            deladet = trn(request("deladet"))
            delstokadet = trn(request("delstokadet"))
            index = trn(request("index"))
            index2 = trn(request("index2"))

            sonradaneklenenparca = trn(request("sonradaneklenenparca"))
            sonradaneklenenadet = trn(request("sonradaneklenenadet"))
            sonradaneklenensayi = trn(request("sonradaneklenensayi"))

            'if delparcaid = "" then
            '    if NOT IsNull(sonradaneklenenparca) then
            '        parcaId = "," & sonradaneklenenparca
            '        adet = "," & sonradaneklenenadet
            '    end if
            'end if
            
            if isNULL(Dstokadet) then
                StoktanKullanilanParcaAdeti = null
            else
                StoktanKullanilanParcaAdeti = Dstokadet
            end if

            parcaKullanildimi = false
            StoktanKullanilanAdet = ""
            if Not IsNULL(parcaId) then
                parcaKullanildimi = true
            end if

            if index = "ekleme" then
                if sonradaneklenensayi = "birdenfazla" then

                for y = 0 to ubound(split(sonradaneklenenparca, ","))
                    bolunmusParcaId = split(sonradaneklenenparca, ",")(y)
                    bolunmusParcaAdet = split(sonradaneklenenadet, ",")(y)

                    SQL = "select * from parca_listesi where id = '"& bolunmusParcaId &"' and firma_id = '"& FirmaID &"'"
                    set kontrol = baglanti.execute(SQL)
                    
                    result = kontrol("miktar") - bolunmusParcaAdet
                    if result > 0 then
                        if StoktanKullanilanParcaAdeti = "" then
                            StoktanKullanilanParcaAdeti = bolunmusParcaAdet
                        else
                            StoktanKullanilanParcaAdeti = StoktanKullanilanParcaAdeti & "," & bolunmusParcaAdet
                        end if
                        SQL = "update parca_listesi set miktar = miktar - '"& bolunmusParcaAdet &"' where id = '"& bolunmusParcaId &"' and firma_id = '"& FirmaID &"'"
                        set stokGuncelle = baglanti.execute(SQL)   
                    else
                        if StoktanKullanilanParcaAdeti = "" then
                            StoktanKullanilanParcaAdeti = kontrol("miktar")
                        else
                            StoktanKullanilanParcaAdeti = StoktanKullanilanParcaAdeti & "," & kontrol("miktar")
                        end if
                        SQL = "update parca_listesi set miktar = 0 where id = '"& bolunmusParcaId &"' and firma_id = '"& FirmaID &"'"
                        set stokGuncelle = baglanti.execute(SQL)   
                    end if
                    
                next
             else

                    if parcaKullanildimi = true then

                        SQL = "select * from parca_listesi where id = '"& sonradaneklenenparca &"' and firma_id = '"& FirmaID &"'"
                        set kontrol = baglanti.execute(SQL)
    
                        result2 = kontrol("miktar") - sonradaneklenenadet
                        if result2 > 0 or result2 = 0 then
                            if StoktanKullanilanParcaAdeti = "" then
                                StoktanKullanilanParcaAdeti = sonradaneklenenadet
                            else
                                StoktanKullanilanParcaAdeti = StoktanKullanilanParcaAdeti & "," & sonradaneklenenadet
                            end if
                            SQL = "update parca_listesi set miktar = miktar - '"& sonradaneklenenadet &"' where id = '"& sonradaneklenenparca &"' and firma_id = '"& FirmaID &"'"
                            set stokGuncelle = baglanti.execute(SQL)
                        else
                            if StoktanKullanilanParcaAdeti = "" then
                                StoktanKullanilanParcaAdeti = kontrol("miktar")
                            else
                                StoktanKullanilanParcaAdeti = StoktanKullanilanParcaAdeti & "," & kontrol("miktar")
                            end if
                            SQL = "update parca_listesi set miktar = 0 where id = '"& sonradaneklenenparca &"' and firma_id = '"& FirmaID &"'"
                            set stokGuncelle = baglanti.execute(SQL)
                        end if
                    end if
             end if
           end if

            if index2 = "silme" then
                if sayi = "birdenfazla" then
                    for y = 0 to ubound(split(delparcaid, ","))
                        bolunmusParcaId1 = split(delparcaid, ",")(y)
                        bolunmusParcaAdet1 = split(deladet, ",")(y)
                        bolunmusParcaStokAdet1 = split(delstokadet, ",")(y)

                        SQL = "update parca_listesi set miktar = miktar + '"& bolunmusParcaStokAdet1 &"' where id = '"& bolunmusParcaId1 &"' and firma_id = '"& FirmaID &"'"
                        set stokGuncelle = baglanti.execute(SQL)
                    next
                else
                    SQL = "update parca_listesi set miktar = miktar + '"& delstokadet &"' where id = '"& delparcaid &"' and firma_id = '"& FirmaID &"'"
                    set stokGuncelle = baglanti.execute(SQL)
                end if
            end if

            if rapor_durumu = "Faturası Kesildi" or rapor_durumu = "Faturası Kesilecek" then
            else
                personelbildirim = 0
            end if

            SQL = "update servis_bakim_kayitlari set FirmaId = '"& musteri_id &"', ProjeId = '"& proje_id &"', FirmaUnvani = '"& firmaunvani &"', Yetkili = '"& firmayetkili &"', Adress = '"& firmaadress &"', Email = '"& firmaeposta &"', Telefon = '"& firmatelefon &"', VergiDairesi = '"& firmavergidairesi &"', VergiNo = '"& firmavergino &"', Gorevliler = '"& gorevli &"', ParcaId = '"& parcaId &"', Adet = '"& adet &"', StoktanKullanilanAdet = '"& StoktanKullanilanParcaAdeti &"' , MakinaBilgileri = '"& firmamakinebilgi &"', BildirilenAriza = '"& firmaariza &"', BaslangicTarihi = CONVERT(date, '"& baslangic_tarihi &"', 103), BitisTarihi = CONVERT(date, '"& bitis_tarihi &"', 103), BaslangicSaati = CONVERT(time, '"& baslangic_saati &"'), BitisSaati = CONVERT(time, '"& bitis_saati &"'), YapilanIslemler = '"& firmayapilanislemler &"', FormNot = '"& firmanot &"', RaporDurumu = '"& rapor_durumu &"', BildirimGonderilecekPersonelID = '"& personelbildirim &"' where id = '"& kayitId &"' and firma_id = '"& FirmaID &"'"
            set formguncelle = baglanti.execute(SQL)

            if rapor_durumu = "Faturası Kesildi" or rapor_durumu = "Faturası Kesilecek" then
                ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
                SQL = "select personel_ad + ' ' + personel_soyad as ad_soyad from ucgem_firma_kullanici_listesi where id = '"& ekleyen_id &"' and firma_id = '"& FirmaID &"' and cop = 'false'"
                set personel = baglanti.execute(SQL)

                bildirim = personel("ad_soyad") & " isimli personel düzenleme yaptığı Teknik Servis Formunda rapor durumunu (" & rapor_durumu & ") olarak değiştirdi"
                tip = "bakim_yonetimi"
                click = "CokluIsYap(''bakim_yonetimi'',0,'' '',''0'');"
                okudumu = "0"
                durum = "true"
                cop = "false"
                firma_kodu = Request.Cookies("kullanici")("firma_kodu")
                firma_id = Request.Cookies("kullanici")("firma_id")
                ekleyen_ip = Request.ServerVariables("Remote_Addr")
                SQL="insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& bildirim &"', '"& tip &"', N'"& click &"', '"& personelbildirim &"', '"& okudumu &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate())"
                set personelBildirim = baglanti.execute(SQL)
            end if
        end if

    SQL = "select * from servis_bakim_kayitlari where firma_id = '"& FirmaID &"' and Durum = 'true' and Cop = 'false'"
    set servisbakim = baglanti.execute(SQL)
%>

<table id="tblServisBakim" class="table table-bordered text-nowrap" style="width: 100%">
    <thead>
        <tr style="display: none">
            <th></th>
            <th>
                <select class="select2 form-control" id="firma">
                    <option value="" selected>Tümü</option>
                </select></th>
            <th>
                <select class="select2 form-control" id="yetkili">
                    <option value="" selected>Tümü</option>
                </select></th>
            <th>
                <select class="select2 form-control" id="gorevli">
                    <option value="" selected>Tümü</option>
                </select></th>
            <th>
                <select class="select2 form-control" id="adress">
                    <option value="" selected>Tümü</option>
                </select></th>
            <th>
                <select class="select2 form-control" id="tarih">
                    <option value="" selected>Tümü</option>
                </select></th>
            <th></th>
        </tr>
        <tr>
            <th>Id</th>
            <th>Firma Ünvanı</th>
            <th>Yetkili</th>
            <th>Görevliler</th>
            <th>Adress</th>
            <th>Ekleme Tarihi</th>
            <th>Rapor Durumu</th>
            <th>Işlem</th>
        </tr>
    </thead>
    <tbody id="congress">
        <%
                SQL = "select kullanici.personel_ad + ' ' + kullanici.personel_soyad as ekleyen, servis.* from servis_bakim_kayitlari servis join ucgem_firma_kullanici_listesi kullanici on kullanici.id = servis.EkleyenId where servis.Durum = 'true' and servis.Cop = 'false' and servis.firma_id = '"& FirmaID &"' and kullanici.firma_id = '"& FirmaID &"' order by servis.id desc"
                set servisBakim = baglanti.execute(SQL)

                if servisBakim.eof then
        %>
        <tr>
            <td colspan="10" style="text-align: center">Kayıt Bulunamadı</td>
        </tr>
        <%
                end if
                k = 0
                do while not servisBakim.eof
                    k = k + 1
        %>
        <tr>
            <td><%=k %></td>
            <td><%=servisBakim("FirmaUnvani") %></td>
            <td><%=servisBakim("Yetkili") %></td>
            <td>
                <%
                    for x = 0 to ubound(split(servisBakim("Gorevliler"), ","))
                        user = split(servisBakim("Gorevliler"), ",")(x)
                        SQL="SELECT * FROM ucgem_firma_kullanici_listesi WHERE id = '"& user &"'" 
                        set kcek2 = baglanti.execute(SQL)  
                %>
                <%=kcek2("personel_ad") & " " & kcek2("personel_soyad") %><br />
                <%next %>
            </td>
            <td><%=servisBakim("Adress") %></td>
            <td><%=servisBakim("EklemeTarihi") %></td>
            <td><label class="label label-warning" style="font-size: 12px; padding: 5px; color: black !important;"><%if IsNULL(servisBakim("RaporDurumu")) or servisBakim("RaporDurumu") = "" then %> - <%else %> <%=servisBakim("RaporDurumu") %> <%end if %></label></td>
            <td>
                <button type="button" class="btn btn-mini btn-primary dropdown-toggle dropdown-toggle-split waves-effect waves-light" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    İşlemler
                </button>
                <div class="dropdown-menu">
                    <a class="dropdown-item waves-effect waves-light" onclick="rapor_pdf_indir('teknik_servis_formu', '<%=Request.Cookies("kullanici")("kullanici_id") %>', '<%=servisBakim("id") %>');" href="javascript:void(0);">Servis Formu Oluştur</a>
                    <a class="dropdown-item waves-effect waves-light" onclick="ServisBakimKaydiDuzenle(<%=servisBakim("id") %>, <%=servisBakim("FirmaId") %>);" href="javascript:void(0);">Düzenle</a>
                    <a class="dropdown-item waves-effect waves-light" onclick="ServisBakimKaydiSil(<%=servisBakim("id") %>);" href="javascript:void(0);">Sil</a>
                </div>
            </td>
        </tr>
        <%
                servisBakim.movenext
                loop
        %>
    </tbody>
</table>
<script type="text/javascript">
    $(document).ready(function () {

        var $table = $('#tblServisBakim');
        //$table.find('thead tr').filter(':eq(1),:eq(2)').css('visibility', 'visible').each(function () {
        //    var title = $(this).text();
        //    $(this).html('<input type="text" placeholder="Search ' + title + '" />');
        //});
        // Setup - add a text input to each footer cell
        $('#tblServisBakim thead tr').clone(true).appendTo('#tblServisBakim thead');
        $('#tblServisBakim thead tr:eq(1) th').each(function (i) {
            var title = $(this).text();
            $(this).html('<input type="text" id="' + i + '" placeholder="' + title + '" />');

            $('input', this).on('keyup change', function () {
                if (table.column(i).search() !== this.value) {
                    table
                        .column(i)
                        .search(this.value)
                        .draw();
                }
            });
        });

        var table = $('#tblServisBakim').DataTable({
            orderCellsTop: true,
            fixedHeader: true
        });
    });

    $(document).ready(function () {
        $("#0").hide();
        $("#7").hide();
    });

</script>
<%   
    elseif trn(request("islem"))="parcalar_ve_iscilik_getir" then

        IsID = trn(request("IsID"))

%>
<script type="text/javascript">
    $(function () {
        parcalar_autocomplete_calistir2('<%=IsID %>');
        is_detay_kullanilan_parca_getir('<%=IsID %>');
    });
</script>
<div class="row">
    <div class="col-xs-10">
        <table style="width: 95%;">
            <tr>
                <td style="padding-right: 10px;"><span style="font-size: 14px; font-weight: bold;">Parça Ekle</span></td>
                <td style="padding-right: 10px;"><span style="font-size: 14px; font-weight: bold;">Adet</span></td>
                <td style="padding-left: 10px;"><span style="font-size: 14px; font-weight: bold;">Ürün Ağacı Ekle</span></td>
            </tr>
            <tr>
                <td style="padding-right: 10px;">
                    <input type="text" name="parcalar" id="parcalar1" isid="<%=IsID %>" i="1" data="0" class="form-control parcalar required" style="width: 90%;" required />
                </td>
                <td>
                    <input id="parca_adeti" type="number" onkeyup="numControl();" class="form-control" style="width: 50px; text-align: center;" value="1" min="1" />
                </td>
                <td style="padding-left: 10px;">
                    <input type="text" name="aparcalar" id="aparcalar1" isid="<%=IsID %>" i="1" data="0" class="form-control aparcalar required" style="width: 90%;" required />
                </td>
            </tr>
        </table>
    </div>
</div>

<script type="text/javascript">
    function numControl() {
        if ($("#parca_adeti").val() < 1 || $("#parca_adeti").val() === null) {
            $("#parca_adeti").val("1");
        }
    }
</script>

<br />
<div class="row">
    <div class="col-xs-10">
        <h5 style="font-size: 14px; margin-bottom: 10px; font-weight: bold;">KULLANILAN PARÇALAR</h5>
        <div class="table-responsive border-0" id="kullanilan_parcalar<%=IsID %>">
        </div>
    </div>
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
            background: skyblue;
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
<%
    elseif trn(request("islem"))="is_detay_parca_sectim" then

        IsID = trn(request("IsID"))

        if trn(request("islem2"))="agacekle" then

            AgacId = trn(request("AgacId"))
            IsID = trn(request("IsID"))

            durum = "true"
            cop = "false"
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time
            oncelik = "Normal"
            satinalmaDurum = "Onay Bekliyor"
            baslik = "Eksik Parça"

            SQL = "select * from UrunAgaciParcalar where Silindi = 'false' and GrupID = '"& AgacId &"' and FirmaID = '"& FirmaID &"'"
            set parcaAdet = baglanti.execute(SQL)
            c = 0
            do while not parcaAdet.eof
                c = c + 1
                SQL = "select * from is_parca_listesi where ParcaId = '"& parcaAdet("ParcaId") &"' and IsID = '"& IsID &"' and firma_id = '"& FirmaID &"'"
                set varmi = baglanti.execute(SQL)

                if varmi.eof then

                    SQL = "select * from parca_listesi where id = '"& parcaAdet("ParcaId") &"' and firma_id = '"& FirmaID &"'"
                    set parcaStokBilgisi = baglanti.execute(SQL)
                    
                    agacGirilenParca = parcaAdet("ParcaAdet")
                    stoktakimiktar = parcaStokBilgisi("miktar")
                    stoktakiminimum = parcaStokBilgisi("minumum_miktar")
                    
                    if agacGirilenParca + stoktakiminimum > stoktakimiktar then
                        SiparisVerilenSayi = CInt(agacGirilenParca + stoktakiminimum) - CInt(stoktakimiktar)
                    else
                        SiparisVerilenSayi = 0
                    end if
                    
                    StoktanKullanilanSayi = 0
                    if stoktakimiktar > CInt(agacGirilenParca) then
                        StoktanKullanilanSayi = agacGirilenParca
                    elseif stoktakimiktar < CInt(agacGirilenParca) then
                        StoktanKullanilanSayi = stoktakimiktar
                    else
                        StoktanKullanilanSayi = stoktakimiktar
                    end if
                    
                    SQL="insert into is_parca_listesi(IsID, ParcaId, Adet, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, StoktanKullanilanAdet, SiparisVerilenAdet) values('"& IsID &"', '"& parcaAdet("ParcaId") &"', '"& parcaAdet("ParcaAdet") &"', 'true', 'false', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"', '"& StoktanKullanilanSayi &"', '"& SiparisVerilenSayi &"')"
                    set ekle = baglanti.execute(SQL)

                    SQL = "select adi, case when departmanlar like '%proje-%' then SUBSTRING((select value from string_split(departmanlar, ',') where value like '%proje-%'), CHARINDEX('-', (select value from string_split(departmanlar, ',') where value like '%proje-%' )) + 1, 10) else '0' end as ProjeID from ucgem_is_listesi where id = '"& IsID &"' and firma_id = '"& FirmaID &"'"
                    set isListesi = baglanti.execute(SQL)

                    projeID = isListesi("ProjeID")
                    baslik = isListesi("adi")
                
                    eksikParca = (agacGirilenParca + parcaStokBilgisi("minumum_miktar")) - parcaStokBilgisi("miktar")
                    miktar = parcaStokBilgisi("miktar") - parcaStokBilgisi("minumum_miktar")
                    if eksikParca > 0 then
                        birimFiyat = CDbl(parcaStokBilgisi("birim_maliyet"))
                        birimPB = parcaStokBilgisi("birim_pb")
                        if birimPB = "" or birimPB = null then
                           birimPB = "TL"
                        else
                           if birimPB = "EURO" then
                              birimPB = "EUR"
                           end if
                        end if
                        stokAdeti = miktar
                        toplamTL = "0.00"
                        toplamEUR = "0.00"
                        toplamUSD = "0.00"
                        if birimPB = "TL" then
                           birim = "TL"
                           toplamTL = CDbl(birimFiyat * SiparisVerilenSayi)
                        end if
                        if birimPB = "USD" then
                           birim = "USD"
                           toplamUSD = CDbl(birimFiyat * SiparisVerilenSayi)
                        end if
                        if birimPB = "EUR" then
                           birim = "EUR"
                           toplamEUR = CDbl(birimFiyat * SiparisVerilenSayi)
                        end if
                    end if

                    if SiparisVerilenSayi > 0 then
    
                         SQL="select * from satinalma_siparis_listesi where parcaId = '"& parcaAdet("ParcaId") &"' and IsId = '"& IsID &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
                         set siparisVarmi = baglanti.execute(SQL)

                         SQL="select * from satinalma_listesi where IsId = '"& IsID &"' and cop = 'false' and not durum = 'Iptal Edildi' and firma_id = '"& FirmaID &"'"
                         set siparisFormuVarmi = baglanti.execute(SQL)

                         if siparisFormuVarmi.eof then
                                SQL = "SET NOCOUNT ON; insert into satinalma_listesi(IsId, baslik, siparis_tarihi, oncelik, tedarikci_id, proje_id, toplamtl, toplamusd, toplameur, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& IsID &"', '"& baslik &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& oncelik &"', '"& tedarikci &"', '"& projeID &"', REPLACE('"& toplamTL &"', ',', '.'), REPLACE('"& toplamUSD &"', ',', '.'), REPLACE('"& toplamEUR &"', ',', '.'), '"& satinalmaDurum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"'); SELECT SCOPE_IDENTITY() id;"
                                set satinalmaListesi = baglanti.execute(SQL)
                                satinalmaId = satinalmaListesi(0)
                         else
                                if birimPB = "TL" then
                                  SQL = "update satinalma_listesi set toplamtl = toplamtl + REPLACE('"& toplamTL &"', ',', '.') where IsId = '"& siparisFormuVarmi("IsId") &"' and firma_id = '"& FirmaID &"' and not durum = 'Iptal Edildi'"
                                  set satinalmaListesi = baglanti.execute(SQL)
                                  satinalmaId = siparisFormuVarmi("id")
                               end if

                               if birimPB = "USD" then
                                  SQL = "update satinalma_listesi set toplamusd = toplamusd + REPLACE('"& toplamUSD &"', ',', '.') where IsId = '"& siparisFormuVarmi("IsId") &"' and firma_id = '"& FirmaID &"' and not durum = 'Iptal Edildi'"
                                  set satinalmaListesi = baglanti.execute(SQL)
                                  satinalmaId = siparisFormuVarmi("id")
                               end if
                               
                               if birimPB = "EUR" then
                                  SQL = "update satinalma_listesi set toplameur = toplameur + REPLACE('"& toplamEUR &"', ',', '.') where IsId = '"& siparisFormuVarmi("IsId") &"' and firma_id = '"& FirmaID &"' and not durum = 'Iptal Edildi'"
                                  set satinalmaListesi = baglanti.execute(SQL)
                                  satinalmaId = siparisFormuVarmi("id")
                               end if
                               if satinalmaId = 0 then
                                  satinalmaId = siparisFormuVarmi("id")
                               end if
                          end if
                            
                         if siparisVarmi.eof then
                            SQL = "insert into satinalma_siparis_listesi(SatinalmaId, IsId, parcaId, maliyet, pb, adet, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& satinalmaId &"', '"& IsID &"', '"& parcaAdet("ParcaId") &"', REPLACE('"& birimFiyat &"',',', '.'), '"& birim &"', '"& SiparisVerilenSayi &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"','"& ekleyen_id &"','"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
                            set satinalmaSiparisListesi = baglanti.execute(SQL)
                         else
                            SQL = "update satinalma_siparis_listesi set adet = adet + '"& SiparisVerilenSayi &"' where parcaId = '"& siparisVarmi("parcaId") &"' and IsId = '"& siparisVarmi("IsId") &"' and firma_id = '"& FirmaID &"' and cop = 'false'"
                            set siparisGuncelle = baglanti.execute(SQL)
                         end if  
                    end if
   
                    sonuc = parcaStokBilgisi("miktar") - parcaAdet("ParcaAdet")
                    if sonuc < parcaStokBilgisi("minumum_miktar") then
                        if parcaStokBilgisi("miktar") > parcaAdet("ParcaAdet") Then
                            sonuc = parcaStokBilgisi("miktar") - parcaAdet("ParcaAdet") 
                            SQL="update parca_listesi set miktar ='"& sonuc &"' where id = '"& parcaAdet("ParcaId") &"' and firma_id = '"& FirmaID &"'"
                            set guncelle = baglanti.execute(SQL)
                        else
                            if sonuc < 0 then
                                SQL="update parca_listesi set miktar = 0 where id = '"& parcaAdet("ParcaId") &"' and firma_id = '"& FirmaID &"'"
                                set guncelle = baglanti.execute(SQL)
                                else
                                SQL="update parca_listesi set miktar ='"& sonuc &"' where id = '"& parcaAdet("ParcaId") &"' and firma_id = '"& FirmaID &"'"
                                set guncelle = baglanti.execute(SQL)
                            end if
                            
                        end if
                    else
                        SQL="update parca_listesi set miktar = miktar - '"& parcaAdet("ParcaAdet") &"' where id = '"& parcaAdet("ParcaId") &"' and firma_id = '"& FirmaID &"'"
                        set guncelle = baglanti.execute(SQL)
                    end if

                else
                    SQL = "select * from parca_listesi where id = '"& parcaAdet("ParcaId") &"' and firma_id = '"& FirmaID &"'"
                    set parcaStokBilgisi = baglanti.execute(SQL)
                    
                    agacGirilenParca = parcaAdet("ParcaAdet")
                    stoktakimiktar = parcaStokBilgisi("miktar")
                    stoktakiminimum = parcaStokBilgisi("minumum_miktar")
                    
                    if agacGirilenParca + stoktakiminimum > stoktakimiktar then
                        SiparisVerilenSayi = CInt(agacGirilenParca + stoktakiminimum) - CInt(stoktakimiktar)
                    else
                        SiparisVerilenSayi = 0
                    end if
                    
                    StoktanKullanilanSayi = 0
                    if stoktakimiktar > CInt(agacGirilenParca) then
                        StoktanKullanilanSayi = agacGirilenParca
                    elseif stoktakimiktar < CInt(agacGirilenParca) then
                        StoktanKullanilanSayi = stoktakimiktar
                    else
                        StoktanKullanilanSayi = stoktakimiktar
                    end if

                    SQL="update is_parca_listesi set Adet = Adet + '"& parcaAdet("ParcaAdet") &"', StoktanKullanilanAdet = StoktanKullanilanAdet + '"& StoktanKullanilanSayi &"', SiparisVerilenAdet = SiparisVerilenAdet + '"& SiparisVerilenSayi &"' where ParcaId = '"& parcaAdet("ParcaId") &"' and IsID = '"& IsID &"' and firma_id = '"& FirmaID &"'"
                    set guncelle = baglanti.execute(SQL)

                    SQL = "select adi, case when departmanlar like '%proje-%' then SUBSTRING((select value from string_split(departmanlar, ',') where value like '%proje-%'), CHARINDEX('-', (select value from string_split(departmanlar, ',') where value like '%proje-%' )) + 1, 10) else '0' end as ProjeID from ucgem_is_listesi where id = '"& IsID &"' and firma_id = '"& FirmaID &"'"
                    set isListesi = baglanti.execute(SQL)

                    projeID = isListesi("ProjeID")
                    baslik = isListesi("adi")
                
                    eksikParca = (parcaAdet("ParcaAdet") + parcaStokBilgisi("minumum_miktar")) - parcaStokBilgisi("miktar")
                    miktar = parcaStokBilgisi("miktar") - parcaStokBilgisi("minumum_miktar")
                    if eksikParca > 0 then
                        birimFiyat = CDbl(parcaStokBilgisi("birim_maliyet"))
                        birimPB = parcaStokBilgisi("birim_pb")
                        if birimPB = "" or birimPB = null then
                           birimPB = "TL"
                        else
                           if birimPB = "EURO" then
                              birimPB = "EUR"
                           end if
                        end if
                        stokAdeti = miktar
                        toplamTL = "0.00"
                        toplamEUR = "0.00"
                        toplamUSD = "0.00"
                        if birimPB = "TL" then
                           birim = "TL"
                           toplamTL = CDbl(birimFiyat * SiparisVerilenSayi)
                        end if
                        if birimPB = "USD" then
                           birim = "USD"
                           toplamUSD = CDbl(birimFiyat * SiparisVerilenSayi)
                        end if
                        if birimPB = "EUR" then
                           birim = "EUR"
                           toplamEUR = CDbl(birimFiyat * SiparisVerilenSayi)
                        end if
                    end if

                    if SiparisVerilenSayi > 0 then
    
                         SQL="select * from satinalma_siparis_listesi where parcaId = '"& parcaAdet("ParcaId") &"' and IsId = '"& IsID &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
                         set siparisVarmi = baglanti.execute(SQL)

                         SQL="select * from satinalma_listesi where IsId = '"& IsID &"' and cop = 'false' and not durum = 'Iptal Edildi' and firma_id = '"& FirmaID &"'"
                         set siparisFormuVarmi = baglanti.execute(SQL)

                         if siparisFormuVarmi.eof then
                                SQL = "SET NOCOUNT ON; insert into satinalma_listesi(IsId, baslik, siparis_tarihi, oncelik, tedarikci_id, proje_id, toplamtl, toplamusd, toplameur, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& IsID &"', '"& baslik &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& oncelik &"', '"& tedarikci &"', '"& projeID &"', REPLACE('"& toplamTL &"', ',', '.'), REPLACE('"& toplamUSD &"', ',', '.'), REPLACE('"& toplamEUR &"', ',', '.'), '"& satinalmaDurum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"'); SELECT SCOPE_IDENTITY() id;"
                                set satinalmaListesi = baglanti.execute(SQL)
                                satinalmaId = satinalmaListesi(0)
                         else
                                if birimPB = "TL" then
                                  SQL = "update satinalma_listesi set toplamtl = toplamtl + REPLACE('"& toplamTL &"', ',', '.') where IsId = '"& siparisFormuVarmi("IsId") &"' and firma_id = '"& FirmaID &"' and not durum = 'Iptal Edildi'"
                                  set satinalmaListesi = baglanti.execute(SQL)
                                  satinalmaId = siparisFormuVarmi("id")
                               end if

                               if birimPB = "USD" then
                                  SQL = "update satinalma_listesi set toplamusd = toplamusd + REPLACE('"& toplamUSD &"', ',', '.') where IsId = '"& siparisFormuVarmi("IsId") &"' and firma_id = '"& FirmaID &"' and not durum = 'Iptal Edildi'"
                                  set satinalmaListesi = baglanti.execute(SQL)
                                  satinalmaId = siparisFormuVarmi("id")
                               end if
                               
                               if birimPB = "EUR" then
                                  SQL = "update satinalma_listesi set toplameur = toplameur + REPLACE('"& toplamEUR &"', ',', '.') where IsId = '"& siparisFormuVarmi("IsId") &"' and firma_id = '"& FirmaID &"' and not durum = 'Iptal Edildi'"
                                  set satinalmaListesi = baglanti.execute(SQL)
                                  satinalmaId = siparisFormuVarmi("id")
                               end if
                               if satinalmaId = 0 then
                                  satinalmaId = siparisFormuVarmi("id")
                               end if
                          end if
                            
                         if siparisVarmi.eof then
                            SQL = "insert into satinalma_siparis_listesi(SatinalmaId, IsId, parcaId, maliyet, pb, adet, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& satinalmaId &"', '"& IsID &"', '"& parcaAdet("ParcaId") &"', REPLACE('"& birimFiyat &"',',', '.'), '"& birim &"', '"& SiparisVerilenSayi &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"','"& ekleyen_id &"','"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
                            set satinalmaSiparisListesi = baglanti.execute(SQL)
                         else
                            SQL = "update satinalma_siparis_listesi set adet = adet + '"& SiparisVerilenSayi &"' where parcaId = '"& siparisVarmi("parcaId") &"' and IsId = '"& siparisVarmi("IsId") &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
                            set siparisGuncelle = baglanti.execute(SQL)
                         end if  
                    end if
   
                    sonuc = parcaStokBilgisi("miktar") - parcaAdet("ParcaAdet")
                    if sonuc < parcaStokBilgisi("minumum_miktar") then
                        if parcaStokBilgisi("miktar") > parcaAdet("ParcaAdet") Then
                            sonuc = parcaStokBilgisi("miktar") - parcaAdet("ParcaAdet") 
                            SQL="update parca_listesi set miktar ='"& sonuc &"' where id = '"& parcaAdet("ParcaId") &"' and firma_id = '"& FirmaID &"'"
                            set guncelle = baglanti.execute(SQL)
                        else
                            if sonuc < 0 then
                                SQL="update parca_listesi set miktar = 0 where id = '"& parcaAdet("ParcaId") &"' and firma_id = '"& FirmaID &"'"
                                set guncelle = baglanti.execute(SQL)
                                else
                                SQL="update parca_listesi set miktar ='"& sonuc &"' where id = '"& parcaAdet("ParcaId ") & "' and firma_id = '"& FirmaID &"'"
                                set guncelle = baglanti.execute(SQL)
                            end if
                            
                        end if
                    else
                        SQL="update parca_listesi set miktar = miktar - '"& parcaAdet("ParcaAdet") &"' where id = '"& parcaAdet("ParcaId") &"' and firma_id = '"& FirmaID &"'"
                        set guncelle = baglanti.execute(SQL)
                    end if
                end if

            parcaAdet.movenext
            loop                

        elseif trn(request("islem2"))="guncelle" then

            guncellenecekler = trn(request("guncellenecekler"))

            for x = 0 to ubound(split(guncellenecekler, "|"))
                if len(split(guncellenecekler, "|")(x))>2 then
                    KayitId = split(split(guncellenecekler, "|")(x), "-")(0)
                    Adet = split(split(guncellenecekler, "|")(x), "-")(1)                
                end if
            next

        elseif trn(request("islem2"))="ekle" then

            AdetSayisi = trn(request("Adet"))
            ToplamAdet = trn(request("ToplamAdet"))
            ParcaId = trn(request("ParcaId"))
            IsID = trn(request("IsID"))
            
            Adet = AdetSayisi
            durum = "true"
            cop = "false"
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time
            oncelik = "Normal"
            satinalmaDurum = "Onay Bekliyor"
            baslik = "Eksik Parça"

            SQL="select * from is_parca_listesi where ParcaID = '"& ParcaId &"' and IsID = '"& IsID &"' and firma_id = '"& FirmaID &"'"
            set varmi = baglanti.execute(SQL)
            
            SQL = "select * from parca_listesi where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
            set stokSayisi = baglanti.execute(SQL)

            StoktanKullanilanSayi = 0
            SiparisVerilenSayi = AdetSayisi

            if CInt(stokSayisi("miktar")) > CInt(ToplamAdet) then
                StoktanKullanilanSayi = ToplamAdet
            elseif CInt(stokSayisi("miktar")) < CInt(ToplamAdet) then
                StoktanKullanilanSayi = stokSayisi("miktar")
            else
                StoktanKullanilanSayi = ToplamAdet
            end if

            if varmi.eof then

                if CDbl(ToplamAdet) > 0 then
                    SQL="insert into is_parca_listesi(Adet, IsID, ParcaId, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, StoktanKullanilanAdet, SiparisVerilenAdet) values('"& ToplamAdet &"', '"& IsID &"', '"& ParcaId &"', '"& durum &"', '"& cop &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"', '"& StoktanKullanilanSayi &"', '"& SiparisVerilenSayi &"')"
                    set ekle = baglanti.execute(SQL)
                else
                    SQL="insert into is_parca_listesi(Adet, IsID, ParcaId, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, StoktanKullanilanAdet, SiparisVerilenAdet) values('"& AdetSayisi &"', '"& IsID &"', '"& ParcaId &"', '"& durum &"', '"& cop &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"', '"& StoktanKullanilanSayi &"', 0)"
                    set ekle = baglanti.execute(SQL)
                end if 

                SQL = "select * from parca_listesi where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
                set parcalar = baglanti.execute(SQL)

                SQL = "select adi, case when departmanlar like '%proje-%' then SUBSTRING((select value from string_split(departmanlar, ',') where value like '%proje-%'), CHARINDEX('-', (select value from string_split(departmanlar, ',') where value like '%proje-%' )) + 1, 10) else '0' end as ProjeID from ucgem_is_listesi where id = '"& IsID &"' and firma_id = '"& FirmaID &"'"
                set isListesi = baglanti.execute(SQL)

                projeID = isListesi("ProjeID")
                baslik = isListesi("adi")
                
                eksikParca = (ToplamAdet + parcalar("minumum_miktar")) - parcalar("miktar")
                miktar = parcalar("miktar") - parcalar("minumum_miktar")
                if eksikParca > 0 then
                   
                   birimFiyat = CDbl(parcalar("birim_maliyet"))

                   birimPB = parcalar("birim_pb")
                   if birimPB = "" or birimPB = null then
                      birimPB = "TL"
                   else
                      if birimPB = "EURO" then
                         birimPB = "EUR"
                      end if
                   end if
                   stokAdeti = miktar
                   toplamTL = "0.00"
                   toplamEUR = "0.00"
                   toplamUSD = "0.00"
                   if birimPB = "TL" then
                      birim = "TL"
                      toplamTL = CDbl(birimFiyat * eksikParca)
                   end if
                   if birimPB = "USD" then
                      birim = "USD"
                      toplamUSD = CDbl(birimFiyat * eksikParca)
                   end if
                   if birimPB = "EUR" then
                      birim = "EUR"
                      toplamEUR = CDbl(birimFiyat * eksikParca)
                   end if

                   if eksikParca > 0 then

                         SQL="select * from satinalma_siparis_listesi where parcaId = '"& ParcaId &"' and IsId = '"& IsID &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
                         set siparisVarmi = baglanti.execute(SQL)

                         SQL="select * from satinalma_listesi where IsId = '"& IsID &"' and cop = 'false' and not durum = 'Iptal Edildi' and firma_id = '"& FirmaID &"'"
                         set siparisFormuVarmi = baglanti.execute(SQL)

                         if siparisFormuVarmi.eof then
                                SQL = "SET NOCOUNT ON; insert into satinalma_listesi(IsId, baslik, siparis_tarihi, oncelik, tedarikci_id, proje_id, toplamtl, toplamusd, toplameur, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& IsID &"', '"& baslik &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& oncelik &"', '"& tedarikci &"', '"& projeID &"', REPLACE('"& toplamTL &"', ',', '.'), REPLACE('"& toplamUSD &"', ',', '.'), REPLACE('"& toplamEUR &"', ',', '.'), '"& satinalmaDurum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"'); SELECT SCOPE_IDENTITY() id;"
                                set satinalmaListesi = baglanti.execute(SQL)
                                satinalmaId = satinalmaListesi(0)
                            else
                                if birimPB = "TL" then
                                  SQL = "update satinalma_listesi set toplamtl = toplamtl + REPLACE('"& toplamTL &"', ',', '.') where IsId = '"& siparisFormuVarmi("IsId") &"' and firma_id = '"& FirmaID &"'"
                                  set satinalmaListesi = baglanti.execute(SQL)
                                  satinalmaId = siparisFormuVarmi("id")
                               end if

                               if birimPB = "USD" then
                                  SQL = "update satinalma_listesi set toplamusd = toplamusd + REPLACE('"& toplamUSD &"', ',', '.') where IsId = '"& siparisFormuVarmi("IsId") &"' and firma_id = '"& FirmaID &"'"
                                  set satinalmaListesi = baglanti.execute(SQL)
                                  satinalmaId = siparisFormuVarmi("id")
                               end if
                               
                               if birimPB = "EUR" then
                                  SQL = "update satinalma_listesi set toplameur = toplameur + REPLACE('"& toplamEUR &"', ',', '.') where IsId = '"& siparisFormuVarmi("IsId") &"' and firma_id = '"& FirmaID &"'"
                                  set satinalmaListesi = baglanti.execute(SQL)
                                  satinalmaId = siparisFormuVarmi("id")
                               end if
                               if satinalmaId = 0 then
                                  satinalmaId = siparisFormuVarmi("id")
                               end if
                        end if    
                         if siparisVarmi.eof then
                            SQL = "insert into satinalma_siparis_listesi(SatinalmaId, IsId, parcaId, maliyet, pb, adet, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& satinalmaId &"', '"& IsID &"', '"& ParcaId &"', REPLACE('"& birimFiyat &"',',', '.'), '"& birim &"', '"& AdetSayisi &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"','"& ekleyen_id &"','"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
                            set satinalmaSiparisListesi = baglanti.execute(SQL)
                         else
                               SQL = "update satinalma_siparis_listesi set adet = adet + '"& AdetSayisi &"' where parcaId = '"& siparisVarmi("parcaId") &"' and IsId = '"& siparisVarmi("IsId") &"' and firma_id = '"& FirmaID &"'"
                               set siparisGuncelle = baglanti.execute(SQL)
                         end if                           
                    end if

                    sonuc = parcalar("miktar") - ToplamAdet
                    if sonuc < parcalar("minumum_miktar") then
                        if parcalar("miktar") > ToplamAdet Then
                            sonuc = parcalar("miktar") - ToplamAdet 
                            SQL="update parca_listesi set miktar = '"& sonuc &"' where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
                            set guncelle = baglanti.execute(SQL)
                        else
                            if sonuc < 0 then
                                SQL="update parca_listesi set miktar = 0 where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
                                set guncelle = baglanti.execute(SQL)
                                else
                                SQL="update parca_listesi set miktar = '"& sonuc &"' where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
                                set guncelle = baglanti.execute(SQL)
                            end if
                            
                        end if
                    else
                        SQL="update parca_listesi set miktar = miktar - '"& ToplamAdet &"' where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
                        set guncelle = baglanti.execute(SQL)
                    end if
                        
                else
                    sonuc = parcalar("miktar") - ToplamAdet
                    if sonuc < parcalar("minumum_miktar") then
                        if parcalar("miktar") > ToplamAdet then
                            sonuc = parcalar("miktar") - ToplamAdet
                            SQL="update parca_listesi set miktar = '"& sonuc &"' where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
                            set guncelle = baglanti.execute(SQL)
                        else
                            if sonuc < 0 then
                                SQL="update parca_listesi set miktar = 0 where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
                                set guncelle = baglanti.execute(SQL)
                            else
                                SQL="update parca_listesi set miktar = '"& sonuc &"' where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
                                set guncelle = baglanti.execute(SQL)
                            end if
                        end if
                    else
                        SQL="update parca_listesi set miktar = miktar - '"& ToplamAdet &"' where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
                        set guncelle = baglanti.execute(SQL)
                    end if

                end if
                
            else

                SQL = "select * from parca_listesi where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
                set stokSayisi = baglanti.execute(SQL)

                SQL="update is_parca_listesi set Adet = Adet + '"& ToplamAdet &"', StoktanKullanilanAdet = StoktanKullanilanAdet + '"& StoktanKullanilanSayi &"', SiparisVerilenAdet = SiparisVerilenAdet + '"& SiparisVerilenSayi &"' where id = '"& varmi("id") &"' and firma_id = '"& FirmaID &"'"
                set guncelle = baglanti.execute(SQL)

               SQL = "select * from parca_listesi where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
                set parcalar = baglanti.execute(SQL)

               SQL = "select adi, case when departmanlar like '%proje-%' then SUBSTRING((select value from string_split(departmanlar, ',') where value like '%proje-%'), CHARINDEX('-', (select value from string_split(departmanlar, ',') where value like '%proje-%' )) + 1, 10) else '0' end as ProjeID from ucgem_is_listesi where id = '"& IsID &"' and firma_id = '"& FirmaID &"'"
                set isListesi = baglanti.execute(SQL)

                projeID= isListesi("ProjeID")
                baslik = isListesi("adi")

                eksikParca = (ToplamAdet + parcalar("minumum_miktar")) - parcalar("miktar")
                if eksikParca > 0 then
                   
                   birimFiyat = CDbl(parcalar("birim_maliyet"))
                   stokAdeti = miktar
                   birimPB = parcalar("birim_pb")
                   if birimPB = "" or birimPB = null then
                      birimPB = "TL"
                   else
                      if birimPB = "EURO" then
                         birimPB = "EUR"
                      end if
                   end if
                   toplamTL = "0.00"
                   toplamEUR = "0.00"
                   toplamUSD = "0.00"
                   if birimPB = "TL" then
                      birim = "TL"
                      toplamTL = CDbl(birimFiyat * eksikParca)
                   end if
                   if birimPB = "USD" then
                      birim = "USD"
                      toplamUSD = CDbl(birimFiyat * eksikParca)
                   end if
                   if birimPB = "EUR" then
                      birim = "EUR"
                      toplamEUR = CDbl(birimFiyat * eksikParca)
                   end if

                         if eksikParca > 0 then

                         SQL="select * from satinalma_siparis_listesi where parcaId = '"& ParcaId &"' and IsId = '"& IsID &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
                         set siparisVarmi = baglanti.execute(SQL)

                         SQL="select * from satinalma_listesi where IsId = '"& IsID &"' and cop = 'false' and not durum = 'Iptal Edildi' and firma_id = '"& FirmaID &"'"
                         set siparisFormuVarmi = baglanti.execute(SQL)

                         if siparisFormuVarmi.eof then
                                SQL = "SET NOCOUNT ON; insert into satinalma_listesi(IsId, baslik, siparis_tarihi, oncelik, tedarikci_id, proje_id, toplamtl, toplamusd, toplameur, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& IsID &"', '"& baslik &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& oncelik &"', '"& tedarikci &"', '"& projeID &"', REPLACE('"& toplamTL &"', ',', '.'), REPLACE('"& toplamUSD &"', ',', '.'), REPLACE('"& toplamEUR &"', ',', '.'), '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"'); SELECT SCOPE_IDENTITY() id;"
                                set satinalmaListesi = baglanti.execute(SQL)
   
                                satinalmaId = satinalmaListesi(0)
                            else
                                if birimPB = "TL" then
                                  SQL = "update satinalma_listesi set toplamtl = toplamtl + REPLACE('"& toplamTL &"', ',', '.') where IsId = '"& siparisFormuVarmi("IsId") &"' and firma_id = '"& FirmaID &"'"
                                  set satinalmaListesi = baglanti.execute(SQL)
                                  satinalmaId = siparisFormuVarmi("id")
                               end if

                               if birimPB = "USD" then
                                  SQL = "update satinalma_listesi set toplamusd = toplamusd + REPLACE('"& toplamUSD &"', ',', '.') where IsId = '"& siparisFormuVarmi("IsId") &"' and firma_id = '"& FirmaID &"'"
                                  set satinalmaListesi = baglanti.execute(SQL)
                                  satinalmaId = siparisFormuVarmi("id")
                               end if
                               
                               if birimPB = "EUR" then
                                  SQL = "update satinalma_listesi set toplameur = toplameur + REPLACE('"& toplamEUR &"', ',', '.') where IsId = '"& siparisFormuVarmi("IsId") &"' and firma_id = '"& FirmaID &"'"
                                  set satinalmaListesi = baglanti.execute(SQL)
                                  satinalmaId = siparisFormuVarmi("id")
                               end if

                               if satinalmaId = 0 then
                                  satinalmaId = siparisFormuVarmi("id")
                               end if
                        end if
                         if siparisVarmi.eof then
                            SQL = "insert into satinalma_siparis_listesi(SatinalmaId, IsId, parcaId, maliyet, pb, adet, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& satinalmaId &"', '"& IsID &"', '"& ParcaId &"', REPLACE('"& birimFiyat &"', ',', '.'), '"& birim &"', '"& eksikParca &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"','"& ekleyen_id &"','"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
                            set satinalmaSiparisListesi = baglanti.execute(SQL)
                         else
                               SQL = "update satinalma_siparis_listesi set adet = adet + '"& eksikParca &"' where parcaId = '"& siparisVarmi("parcaId") &"' and IsId = '"& siparisVarmi("IsId") &"' and firma_id = '"& FirmaID &"'"
                               set siparisGuncelle = baglanti.execute(SQL)
                         end if                        
                    end if

                    sonuc = parcalar("miktar") - ToplamAdet
                    if sonuc < parcalar("minumum_miktar") then
                        if parcalar("miktar") > ToplamAdet then
                            sonuc = parcalar("miktar") - ToplamAdet
                            SQL="update parca_listesi set miktar = '"& sonuc &"' where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
                            set guncelle = baglanti.execute(SQL)
                        else
                            if sonuc < 0 then
                                SQL="update parca_listesi set miktar = 0 where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
                                set guncelle = baglanti.execute(SQL)
                            else
                                SQL="update parca_listesi set miktar ='"& sonuc &"' where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
                                set guncelle = baglanti.execute(SQL)
                            end if
                        end if
                    else
                        SQL="update parca_listesi set miktar = miktar - '"& ToplamAdet &"' where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
                        set guncelle = baglanti.execute(SQL)
                    end if
                        
                else
                    sonuc = parcalar("miktar") - ToplamAdet
                    if sonuc < parcalar("minumum_miktar") then
                        if parcalar("miktar") > ToplamAdet then
                            sonuc = parcalar("miktar") - ToplamAdet
                            SQL="update parca_listesi set miktar ='"& sonuc &"' where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
                            set guncelle = baglanti.execute(SQL)
                        else
                            if sonuc < 0 then
                                SQL="update parca_listesi set miktar = 0 where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
                                set guncelle = baglanti.execute(SQL)
                                else
                                SQL="update parca_listesi set miktar ='"& sonuc &"' where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
                                set guncelle = baglanti.execute(SQL)
                            end if
                        end if
                    else
                        SQL="update parca_listesi set miktar = miktar - '"& ToplamAdet &"' where id = '"& ParcaId &"' and firma_id = '"& FirmaID &"'"
                        set guncelle = baglanti.execute(SQL)
                    end if

                end if

            end if

        elseif trn(request("islem2"))="sil" then

            KayitID = trn(request("KayitID"))
            IsId = trn(request("IsID"))
            SQL = "select * from is_parca_listesi where id = '"& KayitID &"' and IsID = '"& IsId &"' and firma_id = '"& FirmaID &"'"
            set silinecekKayit = baglanti.execute(SQL)
            
            ParcaID = silinecekKayit("ParcaId")
            
            if not silinecekKayit.eof then
                SQL = "update parca_listesi set miktar = miktar + '"& silinecekKayit("StoktanKullanilanAdet") &"' where id = '"& silinecekKayit("ParcaId") &"' and firma_id = '"& FirmaID &"'"
                set stokGuncelle = baglanti.execute(SQL)
            end if 

            SQL="delete from is_parca_listesi where id = '"& KayitID &"' and IsID = '"& IsId &"' and firma_id = '"& FirmaID &"'"
            set sil = baglanti.execute(SQL)
            
            SQL = "select * from satinalma_siparis_listesi where IsId = '"& IsId &"' and parcaId = '"& ParcaID &"' and firma_id = '"& FirmaID &"'"
            set SaparisSayiKontrol = baglanti.execute(SQL)
    
            if not SaparisSayiKontrol.eof then
                SQL = "update satinalma_siparis_listesi set cop = 'true' where parcaId = '"& ParcaID &"' and IsId = '"& IsId &"' and firma_id = '"& FirmaID &"'"
                set SilinenSiparisKaydi = baglanti.execute(SQL)

                SQL = "select SUM(maliyet * adet) as maliyet, pb from satinalma_siparis_listesi where cop = 'false' and IsId = '"& IsId &"' and firma_id = '"& FirmaID &"' group by pb"
                set sonDurum = baglanti.execute(SQL)
                
                TL = "0.00"
                USD = "0.00"
                EUR = "0.00"
                if not sonDurum.eof then
                    do while not sonDurum.eof
                        if sonDurum("pb") = "TL" then
                            TL = sonDurum("maliyet")
                        elseif sonDurum("pb") = "USD" then
                            USD = sonDurum("maliyet")
                        elseif sonDurum("pb") = "EUR" then
                            EUR = sonDurum("maliyet")
                        end if
                    sonDurum.movenext
                    loop
                end if
                SQL = "update satinalma_listesi set toplamtl = '"& TL &"', toplamusd = '"& USD &"', toplameur = '"& EUR &"' where IsId = '"& IsId &"' and firma_id = '"& FirmaID &"'"
                set formGuncelle = baglanti.execute(SQL)
            end if

            SQL = "select * from satinalma_siparis_listesi where IsId = '"& IsId &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
            set SaparisKayitKontrol = baglanti.execute(SQL)
    
            if SaparisKayitKontrol.eof then
                SQL = "select * from satinalma_listesi where IsId = '"& IsId &"' and firma_id = '"& FirmaID &"'"
                set siparisKontrol = baglanti.execute(SQL)

                if not siparisKontrol.eof then
                    SQL = "update satinalma_listesi set durum = 'Iptal Edildi', toplamtl = '0.00', toplamusd = '0.00', toplameur = '0.00' where isId = '"& IsId &"' and firma_id = '"& FirmaID &"'"
                    set IptalSiparis = baglanti.execute(SQL)
                end if
            end if


        
        elseif trn(request("islem2"))="listetemizle" then

            'KayitID = trn(request("KayitID"))
            IsId = trn(request("IsID"))

            SQL = "select * from is_parca_listesi where IsID = '"& IsId &"' and firma_id = '"& FirmaID &"'"
            set parcakontrol = baglanti.execute(SQL)

            if not parcakontrol.eof then
                do while not parcakontrol.eof
                    SQL = "update parca_listesi set miktar = miktar + '"& parcakontrol("StoktanKullanilanAdet") &"' where id = '"& parcakontrol("ParcaId") &"' and firma_id = '"& FirmaID &"'"
                    set guncellenenStok = baglanti.execute(SQL)

                    SQL = "delete from is_parca_listesi where IsID = '"& IsId &"' and firma_id = '"& FirmaID &"'"
                    set silinenParcalar = baglanti.execute(SQL)

                    SQL = "update satinalma_siparis_listesi set cop = 'true' where parcaId = '"& parcakontrol("ParcaId") &"' and firma_id = '"& FirmaID &"'"
                    set siparisSayisiSil = baglanti.execute(SQL)
                parcakontrol.movenext
                loop
            end if

            SQL = "select * from satinalma_listesi where IsId = '"& IsId &"'"
            set siparisKontrol = baglanti.execute(SQL)

            if not siparisKontrol.eof then
                SQL = "update satinalma_listesi set durum = 'Iptal Edildi', toplamtl = '0.00', toplamusd = '0.00', toplameur = '0.00' where IsId = '"& IsId &"' and firma_id = '"& FirmaID &"'"
                set IptalSiparis = baglanti.execute(SQL)
            end if

        end if

        SQL="select tanim.marka, tanim.parca_kodu, parca.*, kullanici.personel_ad + ' ' + kullanici.personel_soyad as ekleyen from is_parca_listesi parca join ucgem_firma_kullanici_listesi kullanici on kullanici.id = parca.ekleyen_id join parca_listesi tanim on tanim.id = parca.ParcaId where parca.IsID = '"& IsID &"' and firma_id = '"& FirmaID &"' and parca.cop = 'false' order by parca.id asc"
            set parca = baglanti.execute(SQL)
            if parca.eof then
%>
<div class="well" style="text-align: center;">
    <br />
    <center>Kullanılan Parça Kaydı Bulunamadı</center>
    <br />

</div>
<%
            else

%>
<button type="button" class="btn btn-danger btn-mini" onclick="IsParcaListesiListeTemizle('<%=IsID %>');" style="float: right; margin-bottom: 5px">Listeyi Temizle</button>
<table class="table text-nowrap">
    <thead>
        <tr>
            <th style="width: 80px; text-align: center;">Adet</th>
            <th style="text-align: center">Parça</th>
            <th style="text-align: center">Ekleyen</th>
            <th style="text-align: center">Ekleme Tarihi</th>
            <th style="width: 100px; text-align: center;">İşlem</th>
        </tr>
    </thead>
    <tbody>
        <% 
                    do while not parca.eof
        %>
        <tr>
            <td style="padding: 1px!important; text-align: center;">
                <!--<input kayitid="<%=parca("id") %>" type="number" class="ictekiparcalar<%=IsID %>" style="width: 50px; text-align: center;" value="<%=parca("Adet") %>" />-->
                <span kayitid="<%=parca("id") %>" style="width: 50px; text-align: center; font-weight: bold"><%=parca("Adet") %></span>
            </td>
            <td style="padding: 1px!important; text-align: center"><%=parca("marka") & " - " & parca("parca_kodu") %></td>
            <td style="padding: 1px!important; text-align: center"><%=parca("ekleyen") %></td>
            <td style="padding: 1px!important; text-align: center"><%=cdate(parca("ekleme_tarihi")) %></td>
            <td style="padding: 1px!important; text-align: center;" class="icon-list-demo2">
                <a href="javascript:void(0);" onclick="KullanilanParcaSil('<%=IsID %>', '<%=parca("id") %>');" rel="tooltip" data-placement="top" data-original-title="Kaydı Sil"><i class="ti-trash"></i>
                </a>
            </td>
        </tr>
        <% 
                    parca.movenext
                    loop
        %>
    </tbody>
</table>
<input type="button" style="display: none" class="btn btn-primary btn-mini" onclick="KullanilanParcaListesiGuncelle('<%=IsID %>');" value="Güncelle" />

<% end if %>

<% 
    elseif trn(request("islem"))="ParcadanIsListesiBul" then

        parcaId = trn(request("parcaId"))
        stok = trn(request("stok"))

        SQL="select * from parca_listesi where id = '"& parcaId &"' and firma_id = '"& FirmaID &"'"
        set parca = baglanti.execute(SQL)

%>
<div class="modal-header">
    <b><%=parca("parca_kodu") %>    Parçasının Kullanıldığı İşler</b>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_parca_giris_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <div class="col-sm-12">
            <div id="tum_isler">
                <script>
                    $(function (){
                       is_listesi_etiket('parca', '<%=parcaId %>', '<%=stok %>');
                    });
                </script>
            </div>
        </div>
    </div>
    <style>
        span.gecikmis {
            background-color: #FF5377;
        }


        span.baslamamis {
            background-color: #00bcd4;
        }


        span.biten {
            background-color: #2ed8b6;
        }


        span.devam_eden {
            background-color: #FFB64D;
        }

        span.tag2 {
            width: 36px;
            height: 30px;
            border-radius: 50%;
            color: #fff;
            padding: 10px 12px 10px 12px;
            font-size: 11px;
            text-align: center;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .btn-lg {
            line-height: 0.7;
        }

        .ustunegelince2 {
            background-color: #fffbae;
        }
    </style>
    <style>
        #s2id_sayac_departman {
            text-align: left !important;
            margin-bottom: 2px !important;
            margin-top: 2px !important;
            width: 60% !important;
        }

        .tablo_is_adi {
            overflow-wrap: break-word;
            word-wrap: break-word;
            -ms-word-break: break-all;
            word-break: break-all;
            word-break: break-word;
            -ms-hyphens: auto;
            -moz-hyphens: auto;
            -webkit-hyphens: auto;
            hyphens: auto;
        }
    </style>
</form>

<% 
    elseif trn(request("islem"))="StokListesiTemizle" then

    SQL = "delete from parca_listesi where firma_id = '"& FirmaID &"'"
    set deleteTable = baglanti.execute(SQL)
%>

<% elseif trn(request("islem"))="ModalParcaArama" then %>

<div class="modal-header">
    Parça Arama
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_parca_giris_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">

    <div class="row">
        <label class="col-sm-12 col-form-label">Kodu :</label>
        <div class="col-sm-12">
            <input type="text" id="kodu" class="form-control" />
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Marka :</label>
        <div class="col-sm-12">
            <input type="text" id="marka" class="form-control" />
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Parça Adı :</label>
        <div class="col-sm-12">
            <input type="text" id="parca_adi" class="form-control" />
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Kategori :</label>
        <div class="col-sm-12">
            <select id="kategori" class="select2">
                <option value="0">Tümü</option>
                <%
                    SQL="select * from tanimlama_kategori_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and cop = 'false' order by kategori_adi asc"
                    set kategori = baglanti.execute(SQL)
                    do while not kategori.eof
                %>
                <option value="<%=kategori("id") %>"><%=kategori("kategori_adi") %></option>
                <%
                    kategori.movenext
                    loop
                %>
            </select>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Açıklama :</label>
        <div class="col-sm-12">
            <input type="text" id="aciklama" class="form-control" />
        </div>
    </div>




    <div class="row">
        <label class="col-sm-12 col-md-12 col-form-label">Barcode :</label>
        <div class="col-sm-12 col-md-12">
            <input type="text" id="barcode" class="form-control" />
        </div>
    </div>
    <div class="modal-footer">
        <input type="button" onclick="Modaldan_parca_ara();" class="btn btn-primary" value="Arama Yap" />
    </div>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#kategori").select2({
                    dropdownParent: $("#modal_div")
                });
            });
        </script>
</form>

<% elseif trn(request("islem"))="ModalExcellUpload" then %>

<div class="modal-header">
    Excell Upload
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_parca_giris_upload" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">

    <div class="row mb-2">
        <label class="col-sm-12 col-form-label">Excell Dosyası :</label>
        <div class="col-sm-12">
            <input class="form-control required" required type="file" id="FileUpload" tip="kucuk" folder="envanter" />
            <img src="../img/loader_green.gif" style="display: none" id="fileLoading" />
        </div>
    </div>

    <div class="modal-footer">
        <input type="button" onclick="upload();" class="btn btn-success btn-sm" value="Kaydet" id="btnUploadKaydet" />
    </div>
</form>

<% elseif trn(request("islem"))="ModalSatinalmaArama" then 

%>
<div class="modal-header">
    Satınalma Siparişi Arama
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="satinalmasiparisi" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">

    <div class="row">
        <label class="col-sm-12 col-form-label">Başlık :</label>
        <div class="col-sm-12">
            <input type="text" name="satinalma_baslik" id="satinalma_baslik" class="form-control" />
        </div>
    </div>

    <div class="row">
        <label class="col-sm-6 col-form-label">Sipariş Tarihi :</label>
        <label class="col-sm-6 col-form-label">Öncelik :</label>
        <div class="col-sm-6">
            <input type="text" name="siparis_tarihi" id="siparis_tarihi" class="form-control takvimyap" />
        </div>
        <div class="col-sm-6">
            <select name="satinalma_oncelik" id="satinalma_oncelik" class="select2">
                <option value="0">Tümü</option>
                <option value="Normal">Normal</option>
                <option value="Düşük">Düşük</option>
                <option value="Yüksek">Yüksek</option>
            </select>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Tedarikçi :</label>
        <div class="col-sm-12">
            <select name="satinalma_tedarikci_id" id="satinalma_tedarikci_id" class="select2">
                <option value="0">Tümü</option>
                <%
                    SQL="select id, firma_adi from ucgem_firma_listesi where ekleyen_firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and cop = 'false' and yetki_kodu = 'TASERON'"
                    set firmacek = baglanti.execute(SQL)
                    do while not firmacek.eof
                %>
                <option value="<%=firmacek("id") %>"><%=firmacek("firma_adi") %></option>
                <%
                    firmacek.movenext
                    loop
                %>
            </select>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Satınalma Durum :</label>
        <div class="col-sm-12">
            <select name="satinalma_durum" id="satinalma_durum" class="select2">
                <option value="0">Tümü</option>
                <option value="Sipariş Edildi">Sipariş Edildi</option>
                <option value="İptal Edildi">İptal Edildi</option>
                <option value="Tamamlandı">Tamamlandı</option>
                <option value="Onay Bekliyor">Onay Bekliyor</option>
            </select>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Açıklama :</label>
        <div class="col-sm-12">
            <input type="text" name="satinalma_aciklama" id="satinalma_aciklama" class="form-control" />
        </div>
    </div>


    <div class="modal-footer">
        <input type="button" class="btn btn-primary" onclick="SatinalmaSiparisAramaYap();" value="AramaYap" />
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#satinalma_oncelik, #satinalma_tedarikci_id, #satinalma_durum").select2({
                dropdownParent: $("#modal_div")
            });
        });
    </script>
</form>
<% elseif trn(request("islem"))="ModalBakimArama" then

%>
<div class="modal-header">
    Bakım Arama
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="bakimarama" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">

    <div class="row">
        <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Proje")%></label>
        <div class="col-sm-12 col-lg-12">
            <select id="proje_id" name="proje_id" class="select2">
                <option value="0">Tümü</option>
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
        <label class="col-sm-6 col-form-label">Tarih Aralığı :</label>
        <label class="col-sm-6 col-form-label"></label>
        <div class="col-sm-6">
            <input type="text" name="baslangic_tarihi" id="baslangic_tarihi" class="form-control takvimyap" />
            <script>
                 $("#baslangic_tarihi").val(new Date().toLocaleDateString());
                 $("#bitis_tarihi").val(new Date().toLocaleDateString());
            </script>
        </div>
        <div class="col-sm-6">
            <input type="text" name="bitis_tarihi" id="bitis_tarihi" class="form-control takvimyap" />
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label">Durum :</label>
        <div class="col-sm-12">
            <select name="bakim_durum" id="bakim_durum" class="select2">
                <option value="0">Tümü</option>
                <option value="Tamamlandı">Tamamlandı</option>
                <option value="İşlem Bekliyor">İşlem Bekliyor</option>
            </select>
        </div>
    </div>

    <div class="modal-footer">
        <input type="button" class="btn btn-primary" onclick="ModalBakimAramaYap();" value="Arama Yap" />
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#proje_id, #bakim_durum").select2({
                dropdownParent: $("#modal_div")
            });
        });
    </script>
</form>
<% 
    elseif trn(request("islem"))="dosya_listesi_getir_montaj" then

        IsID = trn(request("IsID"))

        SQL="select dosya.is_id, kullanici.personel_ad + ' ' + kullanici.personel_soyad as personel_adsoyad, dosya.id, dosya.dosya_adi, CONVERT(date, dosya.ekleme_tarihi, 104) as ekleme_tarihi, left(dosya.ekleme_saati,5) as ekleme_saati, dosya.dosya_yolu from ucgem_is_dosya_listesi dosya join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = dosya.ekleyen_id  where dosya.is_id = '"& IsID &"' and kullanici.firma_id = '"& FirmaID &"'"
        set cek = baglanti.execute(SQL)

%>
<table class="table table-bordered">
    <thead>
        <tr>
            <th style="width: 20px; text-align: center;">ID</th>
            <th><% Response.Write(LNG("Dosya Adı")) %></th>
            <th><% Response.Write(LNG("Ekleme Tarihi")) %></th>
            <th><% Response.Write(LNG("Ekleme Saati")) %></th>
            <th><% Response.Write(LNG("Ekleyen")) %></th>
            <th><% Response.Write(LNG("İşlem")) %></th>
        </tr>
    </thead>
    <tbody>
        <% if cek.eof then %>
        <tr>
            <td colspan="6" style="text-align: center;"><% Response.Write(LNG("Kayıt Yok")) %></td>
        </tr>
        <% end if %>
        <%
                    do while not cek.eof
        %>
        <tr>
            <td style="text-align: center;"><%=cek("id") %></td>
            <td><%=cek("dosya_adi")%></td>
            <td><%=cdate(cek("ekleme_tarihi")) %></td>
            <td><%=left(cek("ekleme_saati"),5) %></td>
            <td><%=cek("personel_adsoyad") %></td>
            <td><a class="btn btn-primary btn-xs" onclick="yeni_is_dosyasi_indir('<%=cek("id") %>');" href="javascript:void(0);"><% Response.Write(LNG("İndir")) %></a>&nbsp;<a class="btn btn-info btn-xs" href="<%=cek("dosya_yolu") %>" download><% Response.Write(LNG("Aç")) %></a></td>
        </tr>
        <%
                            cek.movenext
                            loop
        %>
    </tbody>
</table>
<%
    elseif trn(request("islem"))="profil_personel_izin_kayitlarini_getir" then

        personel_id = trn(request("personel_id"))
        baslangic_tarihi = trn(request("baslangic_tarihi"))
        bitis_tarihi = trn(request("bitis_tarihi"))
        izin_turu = trn(request("turu"))

        SQL="select * from ucgem_firma_kullanici_listesi where id = '"& personel_id &"' and firma_id = '"& FirmaID &"'"
        set personel = baglanti.execute(SQL)

        personel_yillik_izin_hakedis = personel("personel_yillik_izin_hakedis")
        personel_yillik_izin = personel("personel_yillik_izin")

        if izin_turu = "Ücretsiz İzin" then
            
        else
            if isdate(personel_yillik_izin_hakedis)=true then
                personel_yillik_izin_hakedis = cdate(personel_yillik_izin_hakedis)
            else
                personel_yillik_izin_hakedis = cdate(personel_yillik_izin_hakedis)+1
            end if

            if cdate(personel_yillik_izin_hakedis)>cdate(baslangic_tarihi) then
                Response.Clear()
%>
<script>
                $(function (){
                    mesaj_ver("İzin Talepleri", "İzin Hakediş Tarihiniz :  <%=cdate(personel_yillik_izin_hakedis) %> Bu tarihten öncesine izin talebinde bulunamazsınız.", "danger");
                });
</script>
<%
                Response.End
            end if

            SQL="select * from tanimlama_yasakli_izin_gunleri where (CONVERT(date, '"& baslangic_tarihi &"', 103) between baslangic_tarihi and bitis_tarihi) or (CONVERT(date, '"& bitis_tarihi &"', 103) between baslangic_tarihi and bitis_tarihi) and firma_id = '"& FirmaID &"'"
            set cek = baglanti.execute(SQL)
            if not cek.eof then
                Response.Clear()
%>
<script>
                $(function (){
                    mesaj_ver("İzin Talepleri", "Seçtiğiniz Tarihler İzin Kullanımına uygun değildir.", "danger");
                });
</script>
<%
                Response.End
            end if

            if cdbl(personel_yillik_izin)>0 then
                if cdbl(personel_yillik_izin)/2 < (cdate(bitis_tarihi)-cdate(baslangic_tarihi)) then
                Response.Clear()
%>
<script>
                    $(function (){
                        mesaj_ver("İzin Talepleri", "Bir Defada İzninizin Yalnızca Yarısını Kullanabilirsiniz. İzin Taleplerinizi 1 Nisan öncesi <%=cint(cdbl(personel_yillik_izin)/2) %> gün 1 Nisan sonrası <%=cint(cdbl(personel_yillik_izin)/2) %> gün şeklinde gönderiniz.", "danger");
                    });
</script>

<%
                Response.End
                end if
            end if
        end if
        
        ' 1 nisan 1/2
        Response.Clear()
        Response.Write "ok"
        Response.End()

    end if %>


<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.10/js/select2.min.js"></script>
