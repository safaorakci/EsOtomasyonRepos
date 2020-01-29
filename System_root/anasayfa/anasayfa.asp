<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    'Hatırlatma
    SQL = "select id, firma_kodu, yetki_kodu, ISNULL(sms_entegrasyon, 0) as sms_entegrasyon, ISNULL(mail_entegrasyon, 0) as mail_entegrasyon from ucgem_firma_listesi where cop = 'false' and yetki_kodu = 'BOSS'"
    set firmaBilgileri = baglanti.execute(SQL)

    SQL = "select HatirlaticiGrupParametreleriID, HatirlaticiGrupID, Tip, GrupParametre, Hatirlatma from Hatirlatici.GrupParametreleri where Silindi = 'false' and Hatirlatma = 'true'"
    set grupParametreleri = baglanti.execute(SQL)

    if not grupParametreleri.eof then
        do while not grupParametreleri.eof
            SQL = "select * from Hatirlatici.Hatirlatma where ParametreID = '"& grupParametreleri("HatirlaticiGrupParametreleriID") &"' and Silindi = 'false'"
            set hatirlatma = baglanti.execute(SQL)
 
            SQL = "select * from Hatirlatici.GrupDegerleri where HatirlaticiGrupParametreID = '"& grupParametreleri("HatirlaticiGrupParametreleriID") &"' and Silindi = 'false'"
            set grupDegerleri = baglanti.execute(SQL)

            if not hatirlatma.eof then
                if hatirlatma("TarihindeHatirlat") = True then
                    tarihinde = grupDegerleri("GrupValue")
                    if Cdate(tarihinde) = Date then
                        for i = 0 to ubound(split(hatirlatma("TarihBildirim"), ","))
                            bildirim = split(hatirlatma("TarihBildirim"), ",")(i)
                            if hatirlatma("TarihindeHatirlatildi") = False then
                                if bildirim = "bildirim" then
                                    SQL = "select GrupAdi from Hatirlatici.Grup where HatirlaticiGrupID = '"& grupParametreleri("HatirlaticiGrupID") &"' and Silindi = 'false'"
                                    set grup = baglanti.execute(SQL)
                                    
                                    bildirim = grup("GrupAdi") & " Grubunun " & grupParametreleri("GrupParametre") & " gelmiştir."
                                    tip = "hatirlatici"
                                    click = "CokluIsYap(''hatirlatici'',0,'' '',''0'');"
                                    okudumu = "0"
                                    durum = "true"
                                    cop = "false"
                                    firma_kodu = Request.Cookies("kullanici")("firma_kodu")
                                    firma_id = Request.Cookies("kullanici")("firma_id")
                                    ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
                                    ekleyen_ip = Request.ServerVariables("Remote_Addr")
                                
                                    SQL="insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& bildirim &"', '"& tip &"', N'"& click &"', ISNULL('"& hatirlatma("BildirimiAlacakPersonelID") &"', 0), '"& okudumu &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate())"
                                    set hatirlatmaBildirim = baglanti.execute(SQL)

                                    SQL = "update Hatirlatici.Hatirlatma set TarihindeHatirlatildi = 'true' where HatirlatmaID = '"& hatirlatma("HatirlatmaID") &"'"
                                    set hatirlatildi = baglanti.execute(SQL)
                                end if
                            end if
                        next
                    end if
                end if
                if hatirlatma("TarihindenOnceHatirlat") = True then
                    tarihindenOnce = grupDegerleri("GrupValue")
                    fark = DateDiff("d", Date, tarihindenOnce)
                    if fark = hatirlatma("TarihindenOnce") or fark < hatirlatma("TarihindenOnce") then

                        for i = 0 to ubound(split(hatirlatma("TarihBildirim"), ","))
                            bildirim = split(hatirlatma("TarihBildirim"), ",")(i)
                            if hatirlatma("TarihindenOnceHatirlatildi") = False then
                                if bildirim = "bildirim" then
                                    SQL = "select GrupAdi from Hatirlatici.Grup where HatirlaticiGrupID = '"& grupParametreleri("HatirlaticiGrupID") &"' and Silindi = 'false'"
                                    set grup = baglanti.execute(SQL)
                                    
                                    bildirim = grup("GrupAdi") & " Grubunun " & grupParametreleri("GrupParametre") & "ne " & fark & " gün kaldı."
                                    tip = "hatirlatici"
                                    click = "CokluIsYap(''hatirlatici'',0,'' '',''0'');"
                                    okudumu = "0"
                                    durum = "true"
                                    cop = "false"
                                    firma_kodu = Request.Cookies("kullanici")("firma_kodu")
                                    firma_id = Request.Cookies("kullanici")("firma_id")
                                    ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
                                    ekleyen_ip = Request.ServerVariables("Remote_Addr")
                                
                                    SQL="insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& bildirim &"', '"& tip &"', N'"& click &"', ISNULL('"& hatirlatma("BildirimiAlacakPersonelID") &"', 0), '"& okudumu &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate())"
                                    set hatirlatmaBildirim = baglanti.execute(SQL)

                                    SQL = "update Hatirlatici.Hatirlatma set TarihindenOnceHatirlatildi = 'true' where HatirlatmaID = '"& hatirlatma("HatirlatmaID") &"'"
                                    set hatirlatildi = baglanti.execute(SQL)
                                end if
                            end if
                        next
                    end if
                end if
                if hatirlatma("SayiyaKalaHatirlat") = True then
                    sayiyaGeldiginde = hatirlatma("SayiyaGeldiginde")
                    sonuc = 0
                    sonuc = hatirlatma("SayiyaGeldiginde") - grupDegerleri("GrupValue")
                    if sonuc > 0 and sonuc < hatirlatma("SayiyaKala") or sonuc = hatirlatma("SayiyaKala") then
                       for i = 0 to ubound(split(hatirlatma("SayiBildirim"), ","))
                            bildirim = split(hatirlatma("SayiBildirim"), ",")(i)
                            if hatirlatma("SayiyaKalaHatirlatildi") = False then
                                if bildirim = "bildirim" then
                                    SQL = "select GrupAdi from Hatirlatici.Grup where HatirlaticiGrupID = '"& grupParametreleri("HatirlaticiGrupID") &"' and Silindi = 'false'"
                                    set grup = baglanti.execute(SQL)
                                    
                                    bildirim = grup("GrupAdi") & " Grubunun " & grupParametreleri("GrupParametre") & " sayısı " & sayiyaGeldiginde & " ulaşmasına " & sonuc & " kaldı."
                                    tip = "hatirlatici"
                                    click = "CokluIsYap(''hatirlatici'',0,'' '',''0'');"
                                    okudumu = "0"
                                    durum = "true"
                                    cop = "false"
                                    firma_kodu = Request.Cookies("kullanici")("firma_kodu")
                                    firma_id = Request.Cookies("kullanici")("firma_id")
                                    ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
                                    ekleyen_ip = Request.ServerVariables("Remote_Addr")
                                
                                    SQL="insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& bildirim &"', '"& tip &"', N'"& click &"', ISNULL('"& hatirlatma("BildirimiAlacakPersonelID") &"', 0), '"& okudumu &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate())"
                                    set hatirlatmaBildirim = baglanti.execute(SQL)

                                    SQL = "update Hatirlatici.Hatirlatma set SayiyaKalaHatirlatildi = 'true' where HatirlatmaID = '"& hatirlatma("HatirlatmaID") &"'"
                                    set hatirlatildi = baglanti.execute(SQL)
                                end if
                            end if
                        next 
                    end if
                end if
                if hatirlatma("SayiyaGeldigindeHatirlat") = True then
                    sayiyaGeldiginde = Int(hatirlatma("SayiyaGeldiginde"))
                    grupValue = Int(grupDegerleri("GrupValue"))

                    if grupValue = sayiyaGeldiginde or grupValue > sayiyaGeldiginde then
                        for i = 0 to ubound(split(hatirlatma("SayiBildirim"), ","))
                            bildirim = split(hatirlatma("SayiBildirim"), ",")(i)
                            if hatirlatma("SayiyaGelinceHatirlatildi") = False then
                                if bildirim = "bildirim" then
                                    SQL = "select GrupAdi from Hatirlatici.Grup where HatirlaticiGrupID = '"& grupParametreleri("HatirlaticiGrupID") &"' and Silindi = 'false'"
                                    set grup = baglanti.execute(SQL)

                                    bildirim = grup("GrupAdi") & " Grubunun " & grupParametreleri("GrupParametre") & " sayısını " & grupDegerleri("GrupValue") & " ulaştı."
                                    tip = "hatirlatici"
                                    click = "CokluIsYap(''hatirlatici'',0,'' '',''0'');"
                                    okudumu = "0"
                                    durum = "true"
                                    cop = "false"
                                    firma_kodu = Request.Cookies("kullanici")("firma_kodu")
                                    firma_id = Request.Cookies("kullanici")("firma_id")
                                    ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
                                    ekleyen_ip = Request.ServerVariables("Remote_Addr")
                                
                                    SQL="insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& bildirim &"', '"& tip &"', N'"& click &"', ISNULL('"& hatirlatma("BildirimiAlacakPersonelID") &"', 0), '"& okudumu &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate())"
                                    set hatirlatmaBildirim = baglanti.execute(SQL)

                                    SQL = "update Hatirlatici.Hatirlatma set SayiyaGelinceHatirlatildi = 'true' where HatirlatmaID = '"& hatirlatma("HatirlatmaID") &"'"
                                    set hatirlatildi = baglanti.execute(SQL)
                                end if
                            end if
                        next
                    end if
                end if
            end if
        grupParametreleri.movenext
        loop
    end if
    'Hatırlatma


    SQL="SELECT ROW_NUMBER() OVER (ORDER BY departman.id ASC) AS rowid, 0 AS santiye_sayi, departman.id, departman.departman_adi, departman.departman_tipi, departman.sirano, ( SELECT COUNT(id) FROM ucgem_is_listesi WHERE durum = 'true' AND cop = 'false' AND (ISNULL(tamamlanma_orani, 0) != 100) AND dbo.iceriyormu(departmanlar, 'departman-' + CONVERT(NVARCHAR(10), departman.id)) = 1 ) + ( SELECT COUNT(id) FROM ucgem_proje_olay_listesi olay WHERE olay.departman_id = departman.id AND olay.durum = 'true' AND olay.cop = 'false' ) AS gosterge_sayisi, ( SELECT COUNT(id) FROM ucgem_is_listesi WHERE durum = 'true' AND cop = 'false' ) + ( SELECT COUNT(id) FROM ucgem_proje_olay_listesi olay WHERE olay.durum = 'true' AND olay.cop = 'false' ) AS tum_sayi FROM tanimlama_departman_listesi departman LEFT JOIN ucgem_firma_kullanici_listesi kullanici ON dbo.iceriyormu(kullanici.departmanlar, departman.id) = 1 WHERE departman.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' AND departman.durum = 'true' AND departman.cop = 'false' AND departman.departman_tipi = 'santiye' GROUP BY departman.id, departman.departman_adi, departman.departman_tipi, departman.sirano ORDER BY departman.sirano ASC;"
    set sayilar = baglanti.execute(SQL)
    'response.Write(SQL)

    SQL = "select * from tbl_ModulYetkileri where FirmaId = '"& Request.Cookies("kullanici")("firma_id") &"'"
    set tblModulYetkiler = baglanti.execute(SQL)

        ay = trn(request("ay"))
        yil = trn(request("yil"))


        if isnumeric(ay)=false then
            ay = month(date)
        end if

        if isnumeric(yil)=false then
            yil = year(date)
        end if


    dongu_baslangic = cdate("01."& ay &"." & yil)
    dongu_bitis = cdate(AyinSonGunu(dongu_baslangic) & "." & ay & "." & yil)

    dongu_baslangic = cdate(date)
    dongu_bitis = cdate(date) + 60


    if Request.Cookies("kullanici")("firma_id")="1" then
        sayi = 16
    else
        sayi = 0
    end if

    if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",74,")>0 then
%>
<script>
    
       $(function () {
            sayfagetir('/is_listesi2/','jsid=4559');
        });
</script>
<% 
    Response.End
    end if %>
<script type="text/javascript">

    $(function () {
        personel_raporlarini_getir('<%=Request.cookies("kullanici")("kullanici_id") %>', '', 'true');
        is_yuku_gosterim_proje_sectim('<%=cdate(dongu_baslangic) %>', '<%=cdate(dongu_bitis) %>');
    });


    google.charts.load("current", { packages: ["corechart"] });
    google.charts.setOnLoadCallback(drawChartDonut);

    function drawChartDonut() {
        var dataDonut = google.visualization.arrayToDataTable([
            ['DEPARTMANLAR', '%'],
    <%
    do while not sayilar.eof
        if sayilar("gosterge_sayisi") > 0 then
    %>
        ['<%=sayilar("departman_adi") %>', <%=sayilar("gosterge_sayisi") %>],
    <%
        end if
    sayilar.movenext
    loop
    %>
        ]);
        var optionsDonut = {
            //pieHole: 0.4,
            is3D: true
        };

        var chart = new google.visualization.PieChart(document.getElementById('chart_Donut'));
        chart.draw(dataDonut, optionsDonut);
    }




</script>

<div class="page-body">
    <style>
        .okunmadi {
            background-color: #edf6ff;
            cursor: pointer;
        }


        #scrol_bildirim::-webkit-scrollbar-track {
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
            background-color: #F5F5F5;
        }

        #scrol_bildirim::-webkit-scrollbar {
            width: 6px;
            background-color: #F5F5F5;
        }

        #scrol_bildirim::-webkit-scrollbar-thumb {
            background-color: #6cb0ff;
        }
    </style>
    <div class="row">
        <div class="col-md-12">
            <div id="is_yuku_birinci_ekran">
                <div class="card">

                    <div class="card-header">
                        <h5><%=LNG("Personel İş Yükü Çizelgesi") %></h5>
                    </div>
                    <div class="card-block">
                        <%



                        %>
                        <style>
                            .guncizelge {
                                width: 30px;
                                text-align: center;
                                margin-left: auto;
                                margin-right: auto;
                            }

                            .ikincisi td {
                                background-color: #f8f5f5;
                            }

                            .ilkth {
                                width: 150px;
                                padding: 5px;
                                background-color: #32506d;
                                color: white;
                                line-height: 25px;
                                border: solid 1px #e8e8e8;
                            }

                            .ust_th_ilk {
                                background-color: #32506d;
                                border: solid 1px #e8e8e8;
                                border-left: 3px solid #32506d;
                                color: white;
                                line-height: 40px;
                                vertical-align: bottom;
                                padding: 5px;
                            }

                            .ust_th {
                                background-color: #32506d;
                                border: solid 1px #e8e8e8;
                                border-left: solid 3px white;
                                color: white;
                                line-height: 40px;
                                vertical-align: bottom;
                                padding: 5px;
                            }

                            .alt_th {
                                text-align: center;
                                background-color: #4d7193;
                                border: solid 1px #e8e8e8;
                                color: white;
                                line-height: 25px;
                            }

                            .ustunegelince {
                                background-color: #fff;
                            }


                            .ustunegelince2 td {
                                background-color: #cce6ff !important;
                            }

                            .ust_td2 {
                                border: solid 1px #e8e8e8;
                                padding: 5px;
                                line-height: 20px;
                                font-weight: bold;
                                background-color: #32506d !important;
                                color: white !important;
                            }

                            .gosterge_td {
                                text-align: center;
                                background-color: #4d7193 !important;
                                color: white !important;
                            }

                            .sagcizgi {
                                border-right: 3px solid #32506d !important;
                            }

                            .alt_td {
                                text-align: center;
                                border: solid 1px #e8e8e8;
                                line-height: 20px;
                                padding: 5px;
                            }

                            .alt_td2 {
                                border-left: 3px solid #32506d;
                            }

                            .sarialan {
                                background-color: #f5ffa6 !important;
                            }


                            .tablediv {
                                padding-bottom: 15px;
                            }


                                .tablediv::-webkit-scrollbar-track {
                                    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
                                    border-radius: 10px;
                                    background-color: #F5F5F5;
                                }

                                .tablediv::-webkit-scrollbar {
                                    width: 12px;
                                    background-color: #F5F5F5;
                                }

                                .tablediv::-webkit-scrollbar-thumb {
                                    border-radius: 10px;
                                    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
                                    background-color: #32506d;
                                }
                        </style>
                        <script>

    $(function (){

        $(".ustunegelince").hover(function (){
            $(this).addClass("ustunegelince2");
        },function (){
            $(this).removeClass("ustunegelince2");
        });

    });
                        </script>

                        <div class="row">
                            <div class="col-sm-12 col-md-4">
                                <%=LNG("İş Yükü Gösterim Tipi:")%><br />
                                <select name="yeni_is_yuku_gosterim_tipi" onchange="is_yuku_gosterim_proje_sectim('<%=cdate(dongu_baslangic) %>', '<%=cdate(dongu_bitis) %>');" id="yeni_is_yuku_gosterim_tipi" class="select2">
                                    <option value="0"><%=LNG("Günlük İş Sayıları")%></option>
                                    <option value="1"><%=LNG("Günlük İş Saatleri")%></option>
                                </select>
                            </div>
                            <div class="col-sm-12 col-md-4">
                                <%=LNG("Proje:")%><br />
                                <select name="yeni_is_yuku_proje_id" id="yeni_is_yuku_proje_id" onchange="is_yuku_gosterim_proje_sectim('<%=cdate(dongu_baslangic) %>', '<%=cdate(dongu_bitis) %>');" class="select2">
                                    <option selected value="0"><%=LNG("Tüm Projeler")%></option>
                                    <%
                                                SQL="select id, proje_adi,proje_kodu from ucgem_proje_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and durum = 'true' and cop = 'false' order by proje_adi asc"
                                                set proje = baglanti.execute(SQL)
                                                do while not proje.eof
                                    %>
                                    <option value="<%=proje("id") %>"><%=proje("proje_adi") %> - <%=proje("proje_kodu") %></option>
                                    <%
                                                proje.movenext
                                                loop
                                    %>
                                </select>
                            </div>
                            <div class="col-sm-12 col-md-1" style="display: none;">
                                <input type="button" onclick="isyuku_timeline_calistir();" class="btn btn-mini btn-rnd btn-primary" value="Timeline" />
                            </div>
                        </div>


                        <div id="is_yuku_donus2" class="tablediv" style="width: 100%; margin-top: 15px; overflow: auto;"></div>

                    </div>
                </div>
            </div>
            <div id="is_yuku_birinci_ekran2" style="display: none;"></div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 col-lg-5">
            <div class="card">
                <div class="card-header">
                    <h5><%=LNG("Bildirimler")%></h5>
                </div>
                <div class="card-block">
                    <div style="max-height: 400px; overflow-x: hidden; overflow-y: auto;" id="scrol_bildirim">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <tbody>
                                    <%
                                SQL="SELECT TOP 20 convert(datetime, bildirim.ekleme_tarihi) as ekleme_zamani, kullanici.personel_ad + ' ' + kullanici.personel_soyad AS personel_ad_soyad, kullanici.personel_resim, bildirim.* FROM ahtapot_bildirim_listesi bildirim JOIN dbo.ucgem_firma_kullanici_listesi kullanici ON kullanici.id = bildirim.ekleyen_id WHERE bildirim.user_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' ORDER BY bildirim.id desc"
                                set bildirim = baglanti.execute(SQL)
                                bildirimler = ""

                                girdimi =false
                                if bildirim.eof then
                                girdimi = true
                                    %>
                                    <tr>
                                        <td><%=LNG("Bildirim Kaydı Bulunamadı")%></td>
                                    </tr>

                                    <%

                                end if
                                do while not bildirim.eof

                                if bildirim("okudumu")="False" then
                                    bildirimler = bildirimler & bildirim("id") & ","
                                end if
                                    %>
                                    <tr <% if bildirim("okudumu")="False" then %> class="okunmadi" <% end if %> onclick="<%=bildirim("click") %>">
                                        <td style="width: 60px;"><a href="#!">
                                            <img class="img-rounded" src="<%=bildirim("personel_resim") %>" style="width: 43px; height: 43px;" alt="chat-user"></a>
                                        </td>
                                        <td>
                                            <h6><%=bildirim("personel_ad_soyad") %></h6>
                                            <p class="text-muted"><%=bildirim("bildirim") %></p>
                                        </td>
                                        <td style="width: 150px;"><span title=""><span><%=RelativeTime(bildirim("ekleme_zamani")) %></span><br />
                                        </span></td>
                                    </tr>
                                    <%
                                bildirim.movenext
                                loop

                                bildirimler = bildirimler & "0"

                                if  len(bildirimler)>1 then
                                    SQL="update ahtapot_bildirim_listesi set okudumu = 1 where id in ("& bildirimler &")"
                                    ' set guncelle = baglanti.execute(SQL)
                                end if

                                if girdimi = false then
                                    %>
                                    <tr>
                                        <td colspan="3" onclick="sayfagetir('/bildirim_merkezi/','jsid=4559');" style="cursor: pointer;">
                                            <strong><%=LNG("Tümünü Gör")%></strong>
                                        </td>

                                    </tr>
                                    <%
                                end if
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <h5><%=LNG("Departmanlardaki İş Hacmi")%></h5>
                </div>
                <div class="card-block">
                    <div id="chart_Donut" style="width: 100%; height: 450px;"></div>
                </div>
            </div>
        </div>
        <%
            if request.Cookies("kullanici")("firma_id")="1" then
                sayi = 16
            else
                sayi = 0
            end if
        %>
        <%
            Projeilerleme = False
            if not tblModulYetkiler.eof then
                do while not tblModulYetkiler.eof
                    if tblModulYetkiler("ModulId") = 5 and tblModulYetkiler("Status") = True then
                        Projeilerleme = True
                    end if
                tblModulYetkiler.movenext
                loop
            end if
        %>
        <%if Projeilerleme = True then %>
        <div class="col-md-12 col-lg-7">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-md-8">
                            <h5><%=LNG("Proje İlerleme Durumları")%></h5>
                        </div>
                        <div class="col-md-4">
                            <div class="row">
                                <div class="col-md-3" style="display: flex"><span style="align-self: center;">Proje</span></div>
                                <div class="col-md-9">
                                    <select name="rapor_proje_ilerleme_proje_id" onchange="anasayfa_proje_durum_bilgisi_getir(this.value);" id="rapor_proje_ilerleme_proje_id" class="select2">
                                        <%
                                            SQL="select id, proje_adi,proje_kodu from ucgem_proje_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and durum = 'true' and cop = 'false' and proje_firma_id != 0"
                                            set projeler = baglanti.execute(SQL)
                                            'response.Write(SQL)

                                            ilk_proje_id = 0
                                            do while not projeler.eof
                                                if trim(ilk_proje_id)=0 then
                                                    ilk_proje_id = projeler("id")
                                                end if
                                        %>
                                        <option <% if trim(ilk_proje_id)=trim(projeler("id")) then %> selected="selected" <% end if %> value="<%=projeler("id") %>"><%=projeler("proje_adi") %> - <%=projeler("proje_kodu") %></option>
                                        <%
                                            projeler.movenext
                                            loop
                                        %>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="float: right; margin-bottom: 0;">
                        <table>
                            <tr>
                                <td></td>
                                <td style="width: 30px;"></td>
                                <td style="width: 200px; padding-right: 15px;"></td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="card-block">
                    <div id="proje_durum_yeri" style="width: 100%;">
                        <script>
                            $(function (){
                                anasayfa_proje_durum_bilgisi_getir('<%=ilk_proje_id %>');
                            });
                        </script>
                    </div>
                </div>
            </div>
        </div>
        <%end if %>
    </div>
    <div class="row">
        <div class="col-md-12 col-lg-12">
            <div id="raporlar">
            </div>
        </div>
    </div>
</div>

