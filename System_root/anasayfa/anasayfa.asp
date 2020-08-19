<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    FirmaID = Request.Cookies("kullanici")("firma_id")

    SQL = "select * from tbl_ModulYetkileri where FirmaId = '"& FirmaID &"'"
    set tblModulYetkiler = baglanti.execute(SQL)

    Hatirlatici = False
    if not tblModulYetkiler.eof then
        do while not tblModulYetkiler.eof
            if tblModulYetkiler("ModulId") = 28 and tblModulYetkiler("Status") = True then
                Hatirlatici = True
            end if
        tblModulYetkiler.movenext
        loop
    end if

    if Hatirlatici = True then

        'Hatırlatma
        SQL = "select id, firma_kodu, yetki_kodu, ISNULL(sms_entegrasyon, 0) as sms_entegrasyon, ISNULL(mail_entegrasyon, 0) as mail_entegrasyon from ucgem_firma_listesi where cop = 'false' and yetki_kodu = 'BOSS' and id = '"& FirmaID &"'"
        set firmaBilgileri = baglanti.execute(SQL)

        SQL = "select HatirlaticiGrupParametreleriID, HatirlaticiGrupID, Tip, GrupParametre, Hatirlatma from Hatirlatici.GrupParametreleri where Silindi = 'false' and Hatirlatma = 'true' and FirmaID = '"& FirmaID &"'"
        set grupParametreleri = baglanti.execute(SQL)

        if not grupParametreleri.eof then
            do while not grupParametreleri.eof
                SQL = "select * from Hatirlatici.Hatirlatma where ParametreID = '"& grupParametreleri("HatirlaticiGrupParametreleriID") &"' and Silindi = 'false' and FirmaID = '"& FirmaID &"'"
                set hatirlatma = baglanti.execute(SQL)

                SQL = "select * from Hatirlatici.GrupDegerleri where HatirlaticiGrupParametreID = '"& grupParametreleri("HatirlaticiGrupParametreleriID") &"' and Silindi = 'false' and FirmaID = '"& FirmaID &"'"
                set grupDegerleri = baglanti.execute(SQL)

                if not hatirlatma.eof and not grupDegerleri.eof then
                    if hatirlatma("TarihindeHatirlat") = True then
                        tarihinde = grupDegerleri("GrupValue")
                        if Cdate(tarihinde) = Date then
                            for i = 0 to ubound(split(hatirlatma("TarihBildirim"), ","))
                                bildirim = split(hatirlatma("TarihBildirim"), ",")(i)
                                if hatirlatma("TarihindeHatirlatildi") = False then
                                    if bildirim = "bildirim" then
                                        SQL = "select GrupAdi from Hatirlatici.Grup where HatirlaticiGrupID = '"& grupParametreleri("HatirlaticiGrupID") &"' and Silindi = 'false' and FirmaID = '"& FirmaID &"'"
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

                                        SQL = "update Hatirlatici.Hatirlatma set TarihindeHatirlatildi = 'true' where HatirlatmaID = '"& hatirlatma("HatirlatmaID") &"' and FirmaID = '"& FirmaID &"'"
                                        set hatirlatildi = baglanti.execute(SQL)
                                    end if
                                end if
                            next
                        end if
                    end if
                    if hatirlatma("TarihindenOnceHatirlat") = True then
                        if not grupDegerleri.eof then
                            tarihindenOnce = grupDegerleri("GrupValue")
                            fark = DateDiff("d", Date, tarihindenOnce)
                            if fark = hatirlatma("TarihindenOnce") or fark < hatirlatma("TarihindenOnce") then

                                for i = 0 to ubound(split(hatirlatma("TarihBildirim"), ","))
                                    bildirim = split(hatirlatma("TarihBildirim"), ",")(i)
                                    if hatirlatma("TarihindenOnceHatirlatildi") = False then
                                        if bildirim = "bildirim" then
                                            SQL = "select GrupAdi from Hatirlatici.Grup where HatirlaticiGrupID = '"& grupParametreleri("HatirlaticiGrupID") &"' and Silindi = 'false' and FirmaID = '"& FirmaID &"'"
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

                                            SQL = "update Hatirlatici.Hatirlatma set TarihindenOnceHatirlatildi = 'true' where HatirlatmaID = '"& hatirlatma("HatirlatmaID") &"' and FirmaID = '"& FirmaID &"'"
                                            set hatirlatildi = baglanti.execute(SQL)
                                        end if
                                    end if
                                next
                            end if
                        end if
                    end if
                    if hatirlatma("SayiyaKalaHatirlat") = True then
                        if not grupDegerleri.eof then
                            sayiyaGeldiginde = hatirlatma("SayiyaGeldiginde")
                            sonuc = 0
                            sonuc = hatirlatma("SayiyaGeldiginde") - grupDegerleri("GrupValue")
                            if sonuc > 0 and sonuc < hatirlatma("SayiyaKala") or sonuc = hatirlatma("SayiyaKala") then
                               for i = 0 to ubound(split(hatirlatma("SayiBildirim"), ","))
                                    bildirim = split(hatirlatma("SayiBildirim"), ",")(i)
                                    if hatirlatma("SayiyaKalaHatirlatildi") = False then
                                        if bildirim = "bildirim" then
                                            SQL = "select GrupAdi from Hatirlatici.Grup where HatirlaticiGrupID = '"& grupParametreleri("HatirlaticiGrupID") &"' and Silindi = 'false' and FirmaID = '"& FirmaID &"'"
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

                                            SQL = "update Hatirlatici.Hatirlatma set SayiyaKalaHatirlatildi = 'true' where HatirlatmaID = '"& hatirlatma("HatirlatmaID") &"' and FirmaID = '"& FirmaID &"'"
                                            set hatirlatildi = baglanti.execute(SQL)
                                        end if
                                    end if
                                next 
                            end if
                        end if
                    end if
                    if hatirlatma("SayiyaGeldigindeHatirlat") = True then
                        if not grupDegerleri.eof then
                            sayiyaGeldiginde = Int(hatirlatma("SayiyaGeldiginde"))
                            grupValue = Int(grupDegerleri("GrupValue"))

                            if grupValue = sayiyaGeldiginde or grupValue > sayiyaGeldiginde then
                                for i = 0 to ubound(split(hatirlatma("SayiBildirim"), ","))
                                    bildirim = split(hatirlatma("SayiBildirim"), ",")(i)
                                    if hatirlatma("SayiyaGelinceHatirlatildi") = False then
                                        if bildirim = "bildirim" then
                                            SQL = "select GrupAdi from Hatirlatici.Grup where HatirlaticiGrupID = '"& grupParametreleri("HatirlaticiGrupID") &"' and Silindi = 'false' and FirmaID = '"& FirmaID &"'"
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

                                            SQL = "update Hatirlatici.Hatirlatma set SayiyaGelinceHatirlatildi = 'true' where HatirlatmaID = '"& hatirlatma("HatirlatmaID") &"' and FirmaID = '"& FirmaID &"'"
                                            set hatirlatildi = baglanti.execute(SQL)
                                        end if
                                    end if
                                next
                            end if
                        end if
                    end if
                end if
            grupParametreleri.movenext
            loop
        end if
    'Hatırlatma

        SQL = "select h.AracTakipHatirlatmaID, a.AracTakipAracID, a.Plaka, k.Kilometre, b.BakimTarihi, b.ServisAdi, b.ServisAdresi, b.ServisDetayi, h.HatirlatmaKilometresi, h.KilometreyeGeldigindeHatirlat, h.HatirlatmaTarihi, h.TarihindeHatirlat, h.KilometredeHatirlatildi, h.TarihindeHatirlatildi, h.OlusturanID from AracTakip.Hatirlatma h inner join AracTakip.Arac a on a.AracTakipAracID = h.AracTakipAracID inner join AracTakip.Bakim b on b.AracTakipBakimID = h.ServisBakimID inner join AracTakip.Kilometre k on k.AracTakipKilometreID = h.KilometreID where h.FirmaID = '"& FirmaID &"' and b.FirmaID = '"& FirmaID &"' and a.FirmaID = '"& FirmaID &"' and k.FirmaID = '"& FirmaID &"'"
        set AracTakipHatirlatma = baglanti.execute(SQL)
        'response.Write(SQL)

        if not AracTakipHatirlatma.eof then
            do while not AracTakipHatirlatma.eof
            
                SQL = "select MAX(Kilometre) as km from AracTakip.Kilometre where AracTakipAracID = '"& AracTakipHatirlatma("AracTakipAracID") &"' and FirmaID = '"& FirmaID &"'"
                set maxKm = baglanti.execute(SQL)

                'response.Write("Max Km: " & maxKm("km"))
                'response.Write("Hatirlatma Km: " & AracTakipHatirlatma("HatirlatmaKilometresi"))

                if AracTakipHatirlatma("KilometreyeGeldigindeHatirlat") = True then
                    if AracTakipHatirlatma("HatirlatmaKilometresi") = maxKm("km") or AracTakipHatirlatma("HatirlatmaKilometresi") < maxKm("km") then
                        if AracTakipHatirlatma("KilometredeHatirlatildi") = False then
                            bildirim = AracTakipHatirlatma("Plaka") & " Plakalı aracın bakım kilometresi yaklaşıyor. Araç şu anda "& maxKm("km") &" kilometrede. Planlanan Servis detayı " & AracTakipHatirlatma("ServisDetayi") & "."
                            tip = "AracTakip"
                            click = "CokluIsYap(''aractakip'',0,'' '',''0'');"
                            okudumu = "0"
                            durum = "true"
                            cop = "false"
                            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
                            firma_id = Request.Cookies("kullanici")("firma_id")
                            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
                            ekleyen_ip = Request.ServerVariables("Remote_Addr")
                                
                            SQL="insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& bildirim &"', '"& tip &"', N'"& click &"', '"& AracTakipHatirlatma("OlusturanID") &"', '"& okudumu &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate())"
                            set hatirlatmaBildirim = baglanti.execute(SQL)    

                            SQL = "update AracTakip.Hatirlatma set KilometredeHatirlatildi = 'true' where AracTakipHatirlatmaID = '"& AracTakipHatirlatma("AracTakipHatirlatmaID") &"'"
                            set hatirlatmaUpdate = baglanti.execute(SQL)
                        end if
                    end if
                end if
            
                if AracTakipHatirlatma("TarihindeHatirlat") = True then
                    tarih = AracTakipHatirlatma("HatirlatmaTarihi")
                    if cdate(tarih) = Date or cdate(AracTakipHatirlatma("HatirlatmaTarihi")) > Date then
                        if AracTakipHatirlatma("TarihindeHatirlatildi") = False then

                            bildirim = AracTakipHatirlatma("Plaka") & " Plakalı aracın bakım tarihi yaklaşıyor. Planlanan bakım tarihi "& AracTakipHatirlatma("HatirlatmaTarihi") &". Planlanan Servis detayı " & AracTakipHatirlatma("ServisDetayi") & "."
                            tip = "AracTakip"
                            click = "CokluIsYap(''aractakip'',0,'' '',''0'');"
                            okudumu = "0"
                            durum = "true"
                            cop = "false"
                            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
                            firma_id = Request.Cookies("kullanici")("firma_id")
                            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
                            ekleyen_ip = Request.ServerVariables("Remote_Addr")
                                
                            SQL="insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& bildirim &"', '"& tip &"', N'"& click &"', '"& AracTakipHatirlatma("OlusturanID") &"', '"& okudumu &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate())"
                            set hatirlatmaBildirim = baglanti.execute(SQL)    

                            SQL = "update AracTakip.Hatirlatma set TarihindeHatirlatildi = 'true' where AracTakipHatirlatmaID = '"& AracTakipHatirlatma("AracTakipHatirlatmaID") &"' and FirmaID = '"& FirmaID &"'"
                            set hatirlatmaUpdate = baglanti.execute(SQL)
                        end if
                    end if
                end if

            AracTakipHatirlatma.movenext
            loop
        end if



    end if


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

        .border-bottom {
            border-bottom: 1px solid #e3e3e3 !important;
        }

        .border-bottom {
            border-bottom: 1px solid rgba(0, 0, 0, .2) !important;
        }

        .border-bottom-0 {
            border-bottom: none !important;
        }

        .border-top-0 {
            border-top: none !important;
        }

        .border-right {
            border-right: 1px solid rgba(0, 0, 0, .2) !important;
        }

        .border {
            border: 1px solid rgba(0, 0, 0, .2) !important;
        }

        .main-body .page-wrapper {
            padding: 0.8rem;
        }

        .f-11 {
            font-size: 11px !important;
        }

        .f-13 {
            font-size: 13px !important;
        }

        .cursor-pointer {
            cursor: pointer !important;
        }

        .img-40 {
            width: 40px;
        }

        .round {
            border-radius: 5px;
        }

        .bg-skyblue {
            background-color: #9ddce4;
        }

        .font-weight-semibold {
            font-weight: 500 !important;
        }

        .text-dark {
            color: black !important;
        }

        .bg-dark {
            background-color: #153b5d !important;
        }

        .lightcyan {
            background-color: #f5feff;
        }

        .w-auto {
            min-width: 30px !important;
            width: auto !important;
        }

        .h-15 {
            height: 15px !important;
        }

        .prog-val {
            font-size: 14px !important;
            margin-top: -3px !important;
        }

        .b-radius {
            border-radius: 10px !important;
        }

        .w-min {
            min-width: 30px !important;
        }

        .f-20 {
            font-size: 20px !important;
        }
    </style>

    <script type="text/javascript">
        TasksCounter();
    </script>
    <section id="widget-grid">
        <div class="row">
            <div class="col-xs-12 col-sm-6">
                <button onclick="is_listesi_gosterge('benim_tum');" type="button" class="btn btn-sm btn-block" style="-webkit-border-top-left-radius: 15px; -webkit-border-top-right-radius: 15px; -moz-border-radius-topleft: 15px; -moz-border-radius-topright: 15px; border-top-left-radius: 15px; border-top-right-radius: 15px; font-size: 13px; background-color: #e2e2e2; border: 1px solid #ccc; border-bottom: none;"><i class="fa fa-child"></i>&nbsp;&nbsp;<% Response.Write(LNG("Bana Verilen İşler")) %></button>
                <div class="well well-sm well-light" style="padding: 0; background-color: white; -webkit-border-bottom-right-radius: 15px; -webkit-border-bottom-left-radius: 15px; -moz-border-radius-bottomright: 15px; -moz-border-radius-bottomleft: 15px; border-bottom-right-radius: 15px; border-bottom-left-radius: 15px;">
                    <div class="row" style="margin: 0;">
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; margin: 0;">
                            <div class="text-center " onclick="is_listesi_gosterge('benim_baslanmamis');" style="cursor: pointer; padding-top: 10px; padding-bottom: 10px;">
                                <span class="tag2 baslamamis">
                                    <label class="label label-info p-2 f-13 d-inline-block b-radius w-min" id="bana_verilen_baslanmamis"></label>
                                </span>
                                <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight: 400;"><% Response.Write(LNG("Başlanmamış")) %></h5>
                            </div>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; margin: 0;">
                            <div class="text-center " onclick="is_listesi_gosterge('benim_devameden');" style="cursor: pointer; padding-top: 10px; padding-bottom: 10px;">
                                <span class="tag2 devam_eden">
                                    <label class="label label-warning p-2 f-13 d-inline-block b-radius w-min" id="bana_verilen_devameden"></label>
                                </span>
                                <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight: 400;"><% Response.Write(LNG("Devam Eden")) %></h5>
                            </div>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; margin: 0; -webkit-border-bottom-left-radius: 15px; -moz-border-radius-bottomleft: 15px; border-bottom-left-radius: 15px;">
                            <div class="text-center " onclick="is_listesi_gosterge('benim_gecikmis');" style="cursor: pointer; padding-top: 10px; padding-bottom: 10px;">
                                <span class="tag2 gecikmis">
                                    <label class="label label-danger p-2 f-13 d-inline-block b-radius w-min" id="bana_verilen_geciken"></label>
                                </span>
                                <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight: 400;"><span style="color: #ea0036;"><% Response.Write(LNG("Gecikmiş")) %></span></h5>
                            </div>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; margin: 0; -webkit-border-bottom-right-radius: 15px; -moz-border-radius-bottomright: 15px; border-bottom-right-radius: 15px;">
                            <div class="text-center" onclick="is_listesi_gosterge('benim_tamamlanan');" style="cursor: pointer; padding-top: 10px; padding-bottom: 10px;">
                                <span class="tag2 biten">
                                    <label class="label label-success p-2 f-13 d-inline-block b-radius w-min" id="bana_verilen_tamamlanan"></label>
                                </span>
                                <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight: 400;"><% Response.Write(LNG("Tamamlanan")) %></h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-6">
                <button type="button" onclick="is_listesi_gosterge('baskasi_tumu');" class="btn btn-sm btn-block" style="-webkit-border-top-left-radius: 15px; -webkit-border-top-right-radius: 15px; -moz-border-radius-topleft: 15px; -moz-border-radius-topright: 15px; border-top-left-radius: 15px; border-top-right-radius: 15px; font-size: 12px; background-color: #e2e2e2; border: 1px solid #ccc; border-bottom: none;">
                    <i class="fa fa-group"></i>&nbsp;&nbsp;<% Response.Write(LNG("Başkalarına Verdiğim İşler")) %></button>
                <div class="well well-sm well-light" style="padding: 0; background-color: white; -webkit-border-bottom-right-radius: 15px; -webkit-border-bottom-left-radius: 15px; -moz-border-radius-bottomright: 15px; -moz-border-radius-bottomleft: 15px; border-bottom-right-radius: 15px; border-bottom-left-radius: 15px;">
                    <div class="row" style="margin: 0;">
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; margin: 0;">
                            <div class="text-center " onclick="is_listesi_gosterge('baskasi_baslanmamis');" style="padding-top: 10px; padding-bottom: 10px; cursor: pointer;">
                                <span class="tag2 baslamamis">
                                    <label class="label label-info p-2 f-13 d-inline-block b-radius w-min" id="baskasina_baslanmamis"></label>
                                </span>
                                <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight: 400;"><% Response.Write(LNG("Başlanmamış")) %></h5>
                            </div>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; margin: 0;">
                            <div class="text-center " onclick="is_listesi_gosterge('baskasi_devameden');" style="padding-top: 10px; padding-bottom: 10px; cursor: pointer;">
                                <span class="tag2 devam_eden">
                                    <label class="label label-warning p-2 f-13 d-inline-block b-radius w-min" id="baskasina_devameden"></label>
                                </span>
                                <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight: 400;"><% Response.Write(LNG("Devam Eden")) %></h5>
                            </div>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; margin: 0; -webkit-border-bottom-left-radius: 15px; -moz-border-radius-bottomleft: 15px; border-bottom-left-radius: 15px;">
                            <div class="text-center " onclick="is_listesi_gosterge('baskasi_gecikmis');" style="padding-top: 10px; padding-bottom: 10px; cursor: pointer;">
                                <span class="tag2 gecikmis">
                                    <label class="label label-danger p-2 f-13 d-inline-block b-radius w-min" id="baskasina_geciken"></label>
                                </span>
                                <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight: 400;"><span style="color: #ea0036;"><% Response.Write(LNG("Gecikmiş")) %></span></h5>
                            </div>
                        </div>
                        <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ustunegelince" style="border: 1px dotted #dfe5e9; margin: 0; -webkit-border-bottom-right-radius: 15px; -moz-border-radius-bottomright: 15px; border-bottom-right-radius: 15px;">
                            <div class="text-center " onclick="is_listesi_gosterge('baskasi_biten');" style="padding-top: 10px; padding-bottom: 10px; cursor: pointer;">
                                <span class="tag2 biten">
                                    <label class="label label-success p-2 f-13 d-inline-block b-radius w-min" id="baskasina_tamamlanan"></label>
                                </span>
                                <h5 style="padding-top: 0; color: #5a5a5a; font-size: 12px; margin-top: 10px; font-weight: 400;"><% Response.Write(LNG("Tamamlanan")) %></h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header border-bottom p-3">
                    <h6 class="card-title">Proje Listesi</h6>
                </div>
                <div class="card-body p-3">

                    <div class="table-responsive">
                        <table id="example" class="table border table-sm text-nowrap w-100 mb-0">
                            <thead class="bg-dark border-bottom-0">
                                <tr>
                                    <th class="p-2 font-weight-bold f-13" style="width: 20px"></th>
                                    <th class="p-2 font-weight-bold f-13">Proje Kodu</th>
                                    <th class="p-2 font-weight-bold f-13">Proje Adı</th>
                                    <th class="p-2 font-weight-bold f-13">
                                        <i class="fa fa-check f-20"></i>
                                    </th>
                                    <th class="p-2 font-weight-bold f-13" style="width:130px !important;">İlerleme (%)</th>
                                    <th class="p-2 font-weight-bold f-13">Olay</th>
                                    <th class="p-2 font-weight-bold f-13">İş</th>
                                    <th class="p-2 font-weight-bold f-13">Firma</th>
                                    <th class="p-2 font-weight-bold f-13">Başlangıç</th>
                                    <th class="p-2 font-weight-bold f-13">Bitiş</th>
                                    <th class="p-2 font-weight-bold f-13">Sorumlu</th>
                                    <th class="p-2 font-weight-bold f-13">Not</th>
                                </tr>
                            </thead>
                            <tbody class="border-top-0">
                                <%
                                    SQL = "Exec DashboardProject '"& FirmaID &"'"
                                    set projeler = baglanti.execute(SQL)

                                    if projeler.eof then
                                %>

                                <%
                                    end if
                                    lastState = ""
                                    do while not projeler.eof
                                %>
                                <% if not lastState = projeler("durumAdi") then %>
                                <tr>
                                    <td class="bg-skyblue text-dark font-weight-bold" colspan="12"><i class="fa fa-arrow-down mr-2"></i><%=projeler("durumAdi") %></td>
                                </tr>
                                <% end if %>
                                <tr class="lightcyan">
                                    <td></td>
                                    <td class="p-2 pt-3 pb-3 font-weight-semibold"><i class="fa fa-arrow-right mr-2"></i><%=projeler("projeKodu") %></td>
                                    <td class="p-2 pt-3 pb-3 font-weight-semibold"><%=projeler("projeAdi") %></td>
                                    <td class="p-2 pt-3 pb-3 font-weight-semibold">
                                        <%if projeler("durum") = "success" then %>
                                            <i class="fa fa-check f-20 text-success"></i>
                                        <%elseif projeler("durum") = "warning" then %>
                                            <i class="fa fa-exclamation-circle f-20 text-warning"></i>
                                        <%else %>
                                            <i class="fa fa-exclamation-triangle f-20 text-danger"></i>                                            
                                        <%end if %>
                                    </td>
                                    <td class="p-2 pt-3 pb-3 font-weight-semibold" style="width:130px !important;">
                                        <span class="d-inline-block float-right ml-2 prog-val" style="width:45px !important;"><%=CInt(Mid(projeler("ilerleme"), 1, 3)) %> %</span>
                                        <div class="progress mb-0 round h-15">
                                            <div class="progress-bar bg-<%=projeler("durum") %>" role="progressbar" style="width: <%=CInt(Mid(projeler("ilerleme"), 1, 3)) %>%" aria-valuenow="<%=CInt(Mid(projeler("ilerleme"), 1, 3)) %>" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                    </td>
                                    <td class="p-2 pt-3 pb-3">
                                        <label class="label label-primary f-13 p-1 w-auto text-center d-inline-block text-dark font-weight-semibold"><%=projeler("olaySayisi") %></label>
                                    </td>
                                    <td class="p-2 pt-3 pb-3">
                                        <label class="label label-info f-13 p-1 w-auto text-center d-inline-block text-dark font-weight-semibold"><%=projeler("isSayisi") %></label>
                                    </td>
                                    <td class="p-2 pt-3 pb-3 font-weight-semibold"><%=projeler("firmaAdi") %></td>
                                    <td class="p-2 pt-3 pb-3 font-weight-semibold"><% if not IsNull(projeler("baslangicTarihi")) then %> <%=FormatDateTime(projeler("baslangicTarihi"), 1) %> <%else %> --- <%end if %></td>
                                    <td class="p-2 pt-3 pb-3 font-weight-semibold"><% if not IsNull(projeler("bitisTarihi")) then %> <%=FormatDateTime(projeler("bitisTarihi"), 1) %> <%else %> --- <%end if %></td>
                                    <td class="p-2 pt-3 pb-3 font-weight-semibold"><%=projeler("ekleyen") %></td>
                                    <td class="p-2 pt-3 pb-3 font-weight-semibold">Hazırlanıyor
                                    </td>
                                </tr>
                                <%
                                        lastState = projeler("durumAdi")
                                    projeler.movenext
                                    loop
                                %>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <th colspan="12" class="p-2">
                                        <span class="float-left mt-2 text-muted">Burada en fazla
                                            <h6 class="d-inline-block f-15">10</h6>
                                            adet seçtiğiniz proje görünür.</span>
                                        <button type="button" class="btn btn-default btn-sm float-right" onclick="sayfagetir('/santiyeler/','jsid=4559');">DEVAM <i class="fa fa-step-forward ml-2"></i></button>
                                    </th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#example').DataTable({
                    "searching": false,
                    "paging": false,
                    "ordering": true,
                    "responsive": true
                });
            });
        </script>

        <div class="col-md-12 col-lg-12">
            <div id="raporlar">
            </div>
        </div>

        <div class="col-md-12 d-none">
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
                                SQL="SELECT TOP 20 IsNull(convert(datetime, bildirim.ekleme_tarihi), getdate()) as ekleme_zamani, kullanici.personel_ad + ' ' + kullanici.personel_soyad AS personel_ad_soyad, kullanici.personel_resim, bildirim.* FROM ahtapot_bildirim_listesi bildirim JOIN dbo.ucgem_firma_kullanici_listesi kullanici ON kullanici.id = bildirim.ekleyen_id WHERE bildirim.user_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' ORDER BY bildirim.id desc"
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
                                    SQL="update ahtapot_bildirim_listesi set okudumu = 1 where id in ("& bildirimler &") and firma_id = '"& FirmaID &"'"
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
</div>

