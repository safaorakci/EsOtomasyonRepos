<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<%
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001
    
    FirmaID = Request.Cookies("kullanici")("firma_id")
    KullaniciID = Request.Cookies("kullanici")("kullanici_id")

    if trn(request("islem"))="personel_calisma_form_kaydet" then

        personel_id = trn(request("personel_id"))
        gun1 = trn(request("gun1"))
        gun2 = trn(request("gun2"))
        gun3 = trn(request("gun3"))
        gun4 = trn(request("gun4"))
        gun5 = trn(request("gun5"))
        gun6 = trn(request("gun6"))
        gun7 = trn(request("gun7"))
        gun1_saat1 = trn(request("gun1_saat1"))
        gun1_saat2 = trn(request("gun1_saat2"))
        gun2_saat1 = trn(request("gun2_saat1"))
        gun2_saat2 = trn(request("gun2_saat2"))
        gun3_saat1 = trn(request("gun3_saat1"))
        gun3_saat2 = trn(request("gun3_saat2"))
        gun4_saat1 = trn(request("gun4_saat1"))
        gun4_saat2 = trn(request("gun4_saat2"))
        gun5_saat1 = trn(request("gun5_saat1"))
        gun5_saat2 = trn(request("gun5_saat2"))
        gun6_saat1 = trn(request("gun6_saat1"))
        gun6_saat2 = trn(request("gun6_saat2"))
        gun7_saat1 = trn(request("gun7_saat1"))
        gun7_saat2 = trn(request("gun7_saat2"))


        SQL="update ucgem_firma_kullanici_listesi set gun1 = '" & gun1 & "', gun2 = '" & gun2 & "', gun3 = '" & gun3 & "', gun4 = '" & gun4 & "', gun5 = '" & gun5 & "', gun6 = '" & gun6 & "', gun7 = '" & gun7 & "', gun1_saat1 = '" & gun1_saat1 & "', gun1_saat2 = '" & gun1_saat2 & "', gun2_saat1 = '" & gun2_saat1 & "', gun2_saat2 = '" & gun2_saat2 & "', gun3_saat1 = '" & gun3_saat1 & "', gun3_saat2 = '" & gun3_saat2 & "', gun4_saat1 = '" & gun4_saat1 & "', gun4_saat2 = '" & gun4_saat2 & "', gun5_saat1 = '" & gun5_saat1 & "', gun5_saat2 = '" & gun5_saat2 & "', gun6_saat1 = '" & gun6_saat1 & "', gun6_saat2 = '" & gun6_saat2 & "', gun7_saat1 = '" & gun7_saat1 & "', gun7_saat2 = '" & gun7_saat2 & "' where id = '"& personel_id &"' and firma_id = '"& FirmaID &"'"
        set guncelle = baglanti.execute(SQL)

    elseif trn(request("islem"))="personel_giris_cikis_kayitlarini_getir" then

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
            
            SQL="insert into ucgem_personel_mesai_girisleri(tarih, saat, personel_id, cihazID, giris_tipi, ekleme_zamani, durum, cop, ekleme_tarihi, ekleme_saati, ekleyen_ip, firma_id, ekleyen_id) values(CONVERT(date, '"& tarih &"', 103), '"& saat &"', '" & personel_id & "', '" & cihazID & "', '" & giris_tipi & "', getdate(), '" & durum & "', '" & cop & "', getdate(), getdate(), '" & ekleyen_ip & "', '"& firma_id &"', '"& ekleyen_id &"')"
            set ekle = baglanti.execute(SQL)

        elseif trn(request("islem2"))="guncelle" then
    
            giris_tipi = trn(request("saat_tipi"))
            saat = trn(request("giris_cikis_saati"))
            tarih = trn(request("giris_cikis_tarihi"))
            kayit_id = trn(request("kayit_id"))

            SQL="update ucgem_personel_mesai_girisleri set giris_tipi = '"& giris_tipi &"', saat = '"& saat &"', tarih = CONVERT(date, '"& tarih &"', 103), ekleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"', ekleme_tarihi = getdate(), ekleme_saati = getdate(), ekleme_zamani = getdate() where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
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
                SQL="set datefirst 1; SELECT mesai.id as form_id, CASE WHEN mesai.giris_tipi = 1 THEN DATEDIFF( MINUTE, (CONVERT(DATETIME, mesai.tarih) + CONVERT(DATETIME, ISNULL( CASE WHEN DATEPART(dw, mesai.tarih) = 1 THEN kullanici.gun1_saat1 WHEN DATEPART(dw, mesai.tarih) = 2 THEN kullanici.gun2_saat1 WHEN DATEPART(dw, mesai.tarih) = 3 THEN kullanici.gun3_saat1 WHEN DATEPART(dw, mesai.tarih) = 4 THEN kullanici.gun4_saat1 WHEN DATEPART(dw, mesai.tarih) = 5 THEN kullanici.gun5_saat1 WHEN DATEPART(dw, mesai.tarih) = 6 THEN kullanici.gun6_saat1 WHEN DATEPART(dw, mesai.tarih) = 7 THEN kullanici.gun7_saat1 END, '00:00' ) ) ), CONVERT(DATETIME, mesai.tarih) + CONVERT(DATETIME, mesai.saat) ) ELSE DATEDIFF( MINUTE, (CONVERT(DATETIME, mesai.tarih) + CONVERT(DATETIME, ISNULL( CASE WHEN DATEPART(dw, mesai.tarih) = 1 THEN kullanici.gun1_saat2 WHEN DATEPART(dw, mesai.tarih) = 2 THEN kullanici.gun2_saat2 WHEN DATEPART(dw, mesai.tarih) = 3 THEN kullanici.gun3_saat2 WHEN DATEPART(dw, mesai.tarih) = 4 THEN kullanici.gun4_saat2 WHEN DATEPART(dw, mesai.tarih) = 5 THEN kullanici.gun5_saat2 WHEN DATEPART(dw, mesai.tarih) = 6 THEN kullanici.gun6_saat2 WHEN DATEPART(dw, mesai.tarih) = 7 THEN kullanici.gun7_saat2 END, '00:00' ) ) ), CONVERT(DATETIME, mesai.tarih) + CONVERT(DATETIME, mesai.saat) ) END AS fark, * FROM ucgem_personel_mesai_girisleri mesai JOIN ucgem_firma_kullanici_listesi kullanici ON kullanici.id = mesai.personel_id WHERE mesai.personel_id = '"& personel_id &"' and mesai.firma_id = '"& FirmaID &"' AND mesai.cop = 'false' ORDER BY mesai.tarih DESC;"
                set giris = baglanti.execute(SQL)
                'response.Write(SQL)
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


    elseif trn(request("islem"))="giris_cikis_kaydi_ekle" then
        
        personel_id = trn(request("personel_id"))
        tarih = trn(request("tarih"))
%>
<div class="modal-header">
    <%=LNG("Personel Giriş Çıkış Saati Ekle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_personel_giris_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Saat Tipi")%></label>
        <div class="col-sm-12">
            <select class="form-control" onchange="personel_giris_cikis_saat_tipi_sectim(this.value);" name="saat_tipi" id="saat_tipi">
                <option value="1"><%=LNG("Giriş Saati")%></option>
                <option value="0"><%=LNG("Çıkış Saati")%></option>
            </select>
        </div>
    </div>
    <div class="row">
        <label id="giris_cikis_tarih_text" class="col-sm-12 col-form-label"><%=LNG("Giriş Tarihi")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" class="takvimyap form-control required" value="<%=FormatDate(tarih, "00") %>" required name="giris_cikis_tarihi" id="giris_cikis_tarihi" />
            </div>
        </div>
    </div>
    <div class="row">
        <label id="giris_cikis_text" class="col-sm-12 col-form-label"><%=LNG("Giriş Saati")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" class="required timepicker form-control" required name="giris_cikis_saati" id="giris_cikis_saati" placeholder="00:00" />
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <input type="button" onclick="personel_giris_cikis_kayit(this, '<%=personel_id %>');" class="btn btn-primary" value="<%=LNG("Kaydet")%>" />
    </div>
</form>
<%

    
    elseif trn(request("islem"))="giris_cikis_izin_ekle" then
        
        personel_id = trn(request("personel_id"))
        tarih = trn(request("tarih"))
%>
<div class="modal-header">
    <%=LNG("Personel İzin Ekle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_personel_giris_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <input type="hidden" name="saat_tipi" id="saat_tipi" value="2" />
    <div class="row">
        <label id="giris_cikis_tarih_text" class="col-sm-12 col-form-label"><%=LNG("İzin Tarihi")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" class="takvimyap form-control required" value="<%=cdate(tarih) %>" required name="izin_tarihi" id="izin_tarihi" />
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <input type="button" onclick="personel_izin_kayit(this, '<%=personel_id %>');" class="btn btn-primary" value="<%=LNG("Kaydet")%>" />
    </div>
</form>
<%

    elseif trn(request("islem"))="personel_giris_cikis_kaydi_duzenle" then

        personel_id = trn(request("personel_id"))
        kayit_id = trn(request("kayit_id"))

        SQL="select * from ucgem_personel_mesai_girisleri where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
        set giris = baglanti.execute(SQL)

%>
<div class="modal-header">
    <%=LNG("Personel Giriş Çıkış Saati Düzenle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_personel_giris_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Saat Tipi")%></label>
        <div class="col-sm-12">
            <select class="form-control" onchange="personel_giris_cikis_saat_tipi_sectim(this.value);" name="saat_tipi" id="saat_tipi">
                <option <% if trim(giris("giris_tipi"))="1" then %> selected="selected" <% end if %> value="1"><%=LNG("Giriş Saati")%></option>
                <option <% if trim(giris("giris_tipi"))="0" then %> selected="selected" <% end if %> value="0"><%=LNG("Çıkış Saati")%></option>
            </select>
        </div>
    </div>
    <div class="row">
        <label id="giris_cikis_tarih_text" class="col-sm-12 col-form-label"><%=LNG("Giriş Tarihi")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" value="<%=cdate(giris("tarih")) %>" class="takvimyap form-control required" required name="giris_cikis_tarihi" id="giris_cikis_tarihi" />
            </div>
        </div>
    </div>
    <div class="row">
        <label id="giris_cikis_text" class="col-sm-12 col-form-label"><%=LNG("Giriş Saati")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" value="<%=left(giris("saat"),5) %>" class="required timepicker form-control" required name="giris_cikis_saati" id="giris_cikis_saati" placeholder="00:00" />
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <input type="button" onclick="personel_giris_cikis_guncelle(this, '<%=personel_id %>', '<%=giris("id")%>');" class="btn btn-primary" value="<%=LNG("Güncelle")%>" />
    </div>
</form>
<%


    elseif trn(request("islem"))="personel_yillik_takvimi_getir" then
        
        personel_id = trn(request("personel_id"))
        yil = trn(request("yil"))


        tarih1 = "01.01." & yil
        tarih2 = "31.12." & yil

        SQL="DECLARE @Date1 DATE = CONVERT(date, '"& tarih1 &"', 103), @Date2 DATE = CONVERT(date, '"& tarih2 &"', 103), @personel_id int = '"& personel_id &"'; SELECT DATEADD(DAY, number, @Date1) AS gun, CASE WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 1 THEN kullanici.gun1 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 2 THEN kullanici.gun2 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 3 THEN kullanici.gun3 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 4 THEN kullanici.gun4 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 5 THEN kullanici.gun5 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 6 THEN kullanici.gun6 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 7 THEN kullanici.gun7 END AS varmi, (SELECT TOP 1 mesai3.giris_tipi FROM ucgem_personel_mesai_girisleri mesai3 WHERE mesai3.firma_id = '"& FirmaID &"' and mesai3.tarih = DATEADD(DAY, number, @Date1) AND mesai3.cop = 'false' AND mesai3.personel_id = kullanici.id AND mesai3.giris_tipi = 2 ) AS giris_tipi, ISNULL( ( SELECT TOP 1 ISNULL( CASE WHEN mesai1.giris_tipi = 1 THEN DATEDIFF( MINUTE, (CONVERT(DATETIME, mesai1.tarih) + CONVERT( DATETIME, ISNULL( CASE WHEN DATEPART(dw, mesai1.tarih) = 1 THEN kullanici.gun1_saat1 WHEN DATEPART(dw, mesai1.tarih) = 2 THEN kullanici.gun2_saat1 WHEN DATEPART(dw, mesai1.tarih) = 3 THEN kullanici.gun3_saat1 WHEN DATEPART(dw, mesai1.tarih) = 4 THEN kullanici.gun4_saat1 WHEN DATEPART(dw, mesai1.tarih) = 5 THEN kullanici.gun5_saat1 WHEN DATEPART(dw, mesai1.tarih) = 6 THEN kullanici.gun6_saat1 WHEN DATEPART(dw, mesai1.tarih) = 7 THEN kullanici.gun7_saat1 END, '00:00' ) ) ), CONVERT(DATETIME, mesai1.tarih) + CONVERT(DATETIME, mesai1.saat) ) END, '999' ) FROM ucgem_personel_mesai_girisleri mesai1 WHERE mesai1.tarih = DATEADD(DAY, number, @Date1) AND mesai1.cop = 'false' AND mesai1.personel_id = kullanici.id AND mesai1.giris_tipi = 1 ), '999' ) AS fark, ISNULL( ( SELECT top 1 ISNULL( CASE WHEN mesai2.giris_tipi = 0 THEN DATEDIFF( MINUTE, (CONVERT(DATETIME, mesai2.tarih) + CONVERT( DATETIME, ISNULL( CASE WHEN DATEPART(dw, mesai2.tarih) = 1 THEN kullanici.gun1_saat2 WHEN DATEPART(dw, mesai2.tarih) = 2 THEN kullanici.gun2_saat2 WHEN DATEPART(dw, mesai2.tarih) = 3 THEN kullanici.gun3_saat2 WHEN DATEPART(dw, mesai2.tarih) = 4 THEN kullanici.gun4_saat2 WHEN DATEPART(dw, mesai2.tarih) = 5 THEN kullanici.gun5_saat2 WHEN DATEPART(dw, mesai2.tarih) = 6 THEN kullanici.gun6_saat2 WHEN DATEPART(dw, mesai2.tarih) = 7 THEN kullanici.gun7_saat2 END, '00:00' ) ) ), CONVERT(DATETIME, mesai2.tarih) + CONVERT(DATETIME, mesai2.saat) ) END, '999' ) FROM ucgem_personel_mesai_girisleri mesai2 WHERE mesai2.tarih = DATEADD(DAY, number, @Date1) AND mesai2.cop = 'false' and mesai2.firma_id = '"& FirmaID &"' AND mesai2.personel_id = kullanici.id AND mesai2.giris_tipi = 0 ), '999' ) AS fark2 FROM master..spt_values JOIN dbo.ucgem_firma_kullanici_listesi kullanici ON kullanici.id = @personel_id WHERE type = 'P' AND DATEADD(DAY, number, @Date1) <= @Date2;"
        set cek = baglanti.execute(SQL)
%>
<style>
    .backrenk {
        background-color: #f2f2f2;
    }

    .reserve-list tr td {
        min-width: 30px !important;
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
            <td onclick="giris_cikis_kaydi_ekle('<%=personel_id %>','<%=cdate(tarih) %>');" tarih="<%=cdate(tarih) %>" style="<% if cdate(tarih)=cdate(date) then %> border: solid 2px red; <% else %> border: solid 1px black; <% end if %> width: 3%; background-color: <%=yenirenk %>!important;" class="<% if cdate(tarih)>=cdate(date) then %> secilebilir3 <% else %> secilemez3 <% end if %> ustunesari" align="center">&nbsp;</td>
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
    elseif trn(request("islem"))="personel_zimmet_kaydi_ekle" then

        etiket = trn(request("etiket"))
        etiket_id = trn(request("etiket_id"))
%>
<div class="modal-header">
    <%=LNG("Zimmet Kaydı Ekle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="personel_zimmet_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Zimmet Edilen")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <textarea id="zimmet_edilen" name="zimmet_edilen" class="required form-control" style="width: 93%; padding-left: 5px; padding-top: 6px;" required></textarea>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            setTimeout(function () { $("#zimmet_edilen").focus() }, 1500);
            autosize($("#zimmet_edilen"));
        });
    </script>
    <div class="modal-footer">
        <input type="button" onclick="personel_zimmet_kaydet(this, '<%=etiket %>', '<%=etiket_id %>');" class="btn btn-primary" value="<%=LNG("Kaydet")%>" />
    </div>
</form>
<%
    
    elseif trn(request("islem"))="zimmet_kaydi_duzenle" then

        etiket = trn(request("etiket"))
        etiket_id = trn(request("etiket_id"))
        kayit_id = trn(request("kayit_id"))

        SQL="select * from personel_zimmet_listesi where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
        set zimmet = baglanti.execute(SQL)

%><div class="modal-header">
    <%=LNG("Zimmet Kaydı Düzenle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="personel_zimmet_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Zimmet Edilen")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <textarea id="zimmet_edilen" name="zimmet_edilen" class="required form-control" style="width: 93%; padding-left: 5px; padding-top: 6px;" required><%=zimmet("zimmet_edilen") %></textarea>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            setTimeout(function () { $("#zimmet_edilen").focus() }, 1500);
            autosize($("#zimmet_edilen"));
        });
    </script>
    <div class="modal-footer">
        <input type="button" onclick="personel_zimmet_guncelle(this, '<%=etiket %>', '<%=etiket_id %>', '<%=kayit_id %>');" class="btn btn-primary" value="<%=LNG("Kaydet")%>" />
    </div>
</form>
<%


    elseif trn(request("islem"))="zimmet_kayitlarini_getir" then

        etiket = trn(request("etiket"))
        etiket_id = trn(request("etiket_id"))

        if trn(request("islem2"))="ekle" then

            zimmet_edilen = trn(request("zimmet_edilen"))
            durum = "true"
            cop = "false"
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")

            SQL="insert into personel_zimmet_listesi(etiket, etiket_id, zimmet_edilen, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('" & etiket & "', '"& etiket_id &"', '" & zimmet_edilen & "', '" & durum & "', '" & cop & "', '" & firma_kodu & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate())"
            set ekle = baglanti.execute(SQL)

        elseif trn(request("islem2"))="sil" then

            kayit_id = trn(request("kayit_id"))

            SQL="update personel_zimmet_listesi set cop = 'true', silen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"', silen_tarihi = getdate(), silen_saati = getdate() where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set sil = baglanti.execute(SQL)

        elseif trn(request("islem2"))="guncelle" then

            kayit_id = trn(request("kayit_id"))
            zimmet_edilen = trn(request("zimmet_edilen"))

            SQL="update personel_zimmet_listesi set zimmet_edilen = '"& zimmet_edilen &"' where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)

        end if

%><div class="dt-responsive table-responsive">
    <table id="new-cons" class="table table-striped table-bordered table-hover" width="100%">
        <thead>
            <tr>
                <th style="width: 30px;">ID</th>
                <th><%=LNG("Zimmet Edilen")%></th>
                <th><%=LNG("Zimmet Eden")%></th>
                <th><%=LNG("Zimmet Zamanı")%></th>
                <th><%=LNG("İşlem")%></th>
            </tr>
        </thead>
        <tbody>
            <%
                SQL="select kullanici.personel_ad + ' ' + kullanici.personel_soyad as zimmet_eden, zimmet.* from personel_zimmet_listesi zimmet join ucgem_firma_kullanici_listesi kullanici on kullanici.id = zimmet.ekleyen_id where zimmet.etiket = '"& etiket &"' and zimmet.etiket_id = '"& etiket_id &"' and zimmet.cop = 'false' and zimmet.firma_id = '"& FirmaID &"' and kullanici.firma_id = '"& FirmaID &"'"
                set zimmet = baglanti.execute(SQL)
                if zimmet.eof then
            %>
            <tr>
                <td colspan="5" style="text-align: center;"><%=LNG("Zimmet Kaydı Bulunamadı")%></td>
            </tr>
            <%
                end if
                do while not zimmet.eof
            %>
            <tr>
                <td><%=zimmet("id") %></td>
                <td><%=zimmet("zimmet_edilen") %></td>
                <td><%=zimmet("zimmet_eden") %></td>
                <td><%=cdate(zimmet("ekleme_tarihi")) %></td>
                <td class="dropdown">
                    <button type="button" class="btn btn-primary btn-mini dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-cog" aria-hidden="true"></i></button>
                    <div class="dropdown-menu dropdown-menu-right b-none contact-menu">
                        <a class="dropdown-item" href="javascript:void(0);" onclick="zimmet_kaydi_duzenle('<%=etiket %>', '<%=etiket_id %>', '<%=zimmet("id") %>');"><i class="icofont icofont-edit"></i><%=LNG("Düzenle")%></a>
                        <a class="dropdown-item" href="javascript:void(0);" onclick="zimmet_kaydi_sil('<%=etiket %>', '<%=etiket_id %>', '<%=zimmet("id") %>');"><i class="icofont icofont-ui-delete"></i><%=LNG("Sil")%></a>
                    </div>
                </td>
            </tr>
            <%
                zimmet.movenext
                loop
            %>
        </tbody>
    </table>
</div>
<!-- #include virtual="/ajax/include/yenidt.asp" -->
<%

    elseif trn(request("islem"))="depo_dosyalari_getir" then

        etiket = trn(request("etiket"))
        kayit_id = trn(request("kayit_id"))

        SQL = "select yonetici_yetkisi from ucgem_firma_kullanici_listesi where id = '"& Request.Cookies("kullanici")("kullanici_id") &"' and firma_id = '"& FirmaID &"'"
        set personel = baglanti.execute(SQL)

        if trim(request("islem2"))="ekle" then

            depo_dosya_yolu = trn(request("depo_dosya_yolu"))
            depo_dosya_adi = trn(request("depo_dosya_adi"))
            aciklama = trn(request("aciklama"))
            depo_dosya_id = trn(request("depo_dosya_id"))

            durum = "true"
            cop = "false"
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")

            SQL="insert into ahtapot_dosya_deposu(etiket, kayit_id, depo_dosya_yolu, depo_dosya_adi, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, aciklama, dosya_id) values('" & etiket & "', '" & kayit_id & "', '" & depo_dosya_yolu & "', '" & depo_dosya_adi & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', GETDATE(), GETDATE(), '"& aciklama &"', '"& depo_dosya_id &"')"
            set ekle = baglanti.execute(SQL)

            if trim(etiket)="proje" then

                SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
                set guncelle = baglanti.execute(SQL)

            end if

        elseif trim(request("islem2"))="sil" then

            dosya_id = trn(request("dosya_id")) 

            SQL="update ahtapot_dosya_deposu set cop = 'true', silen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"', silen_tarihi = getdate(), silen_saati = getdate() where id = '"& dosya_id &"' and firma_id = '"& FirmaID &"'"
            set sil = baglanti.execute(SQL)

            if trim(etiket)="proje" then
                SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
                set guncelle = baglanti.execute(SQL)
            end if

        end if

%>
<div class="dt-responsive table-responsive" style="padding-bottom: 15px">
    <table id="new-cons" class="table table-striped table-bordered table-hover" width="100%">
        <thead>
            <tr>
                <th style="width: 20px; text-align: center;">ID</th>
                <th><%=LNG("Dosya Adı")%></th>
                <th><%=LNG("Açıklama")%></th>
                <th><%=LNG("Ekleme Tarihi")%></th>
                <th><%=LNG("Ekleme Saati")%></th>
                <th><%=LNG("Ekleyen")%></th>
                <th><%=LNG("İşlem")%></th>
            </tr>
        </thead>
        <tbody>
            <%
                SQL="select kullanici.personel_ad + ' ' + kullanici.personel_soyad as ekleyen, depo.* from ahtapot_dosya_deposu depo join ucgem_firma_kullanici_listesi kullanici on kullanici.id = depo.ekleyen_id where depo.etiket = '"& etiket &"' and depo.kayit_id = '"& kayit_id &"' and depo.cop = 'false' and depo.firma_id = '"& FirmaID &"' and kullanici.firma_id = '"& FirmaID &"'"
                set depo = baglanti.execute(SQL)
                
                if depo.eof then
            %>
            <tr>
                <td colspan="7" style="text-align: center;"><%=LNG("Kayıt Yok")%></td>
            </tr>
            <%
                end if
                d = 0
                do while not depo.eof
                d = d + 1
            %>
            <tr>
                <td><%=d %></td>
                <td><%=depo("depo_dosya_adi") %></td>
                <td><%=depo("aciklama") %></td>
                <td><%=FormatDate(depo("ekleme_tarihi"), "00") %></td>
                <td><%=left(depo("ekleme_saati"),5) %></td>
                <td><%=depo("ekleyen") %></td>
                <td class="dropdown">
                    <button type="button" class="btn btn-primary dropdown-toggle btn-mini" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-cog" aria-hidden="true"></i></button>
                    <div class="dropdown-menu dropdown-menu-right b-none contact-menu">
                        <%if InStr(depo("depo_dosya_yolu"), "jpg") or InStr(depo("depo_dosya_yolu"), "jpeg") or InStr(depo("depo_dosya_yolu"), "png") or InStr(depo("depo_dosya_yolu"), "pdf") then %>
                        <a class="dropdown-item" href="javascript:void(0);" onclick="OpenOrDownloadFile('<%=depo("depo_dosya_yolu") %>');"><i class="icofont icofont-edit"></i><%=LNG("Aç")%></a>
                        <%else %>
                        <a class="dropdown-item" href="javascript:void(0);" onclick="OpenOrDownloadFile('<%=depo("depo_dosya_yolu") %>');"><i class="icofont icofont-edit"></i><%=LNG("İndir")%></a>
                        <%end if %>
                        <a class="dropdown-item" href="javascript:void(0);" onclick="depo_dosya_sil('<%=etiket %>', '<%=kayit_id %>', '<%=depo("id") %>');"><i class="icofont icofont-ui-delete"></i><%=LNG("Sil")%></a>
                    </div>
                </td>
            </tr>
            <%
                depo.movenext
                loop
            %>
        </tbody>
    </table>
</div>
<%
    elseif trn(request("islem")) = "proje_depo_dosyalari_getir" then

        etiket = trn(request("etiket"))
        kayit_id = trn(request("kayit_id"))

        if trim(request("islem2"))="ekle" then

            depo_dosya_yolu = trn(request("depo_dosya_yolu"))
            depo_dosya_adi = trn(request("depo_dosya_adi"))

            durum = "true"
            cop = "false"
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")

            SQL="insert into ahtapot_dosya_deposu(etiket, kayit_id, depo_dosya_yolu, depo_dosya_adi, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('" & etiket & "', '" & kayit_id & "', '" & depo_dosya_yolu & "', '" & depo_dosya_adi & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', GETDATE(), GETDATE())"
            set ekle = baglanti.execute(SQL)

            if trim(etiket)="proje" then

                SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
                set guncelle = baglanti.execute(SQL)

            end if

        elseif trim(request("islem2"))="sil" then

            dosya_id = trn(request("dosya_id")) 

            SQL="update ahtapot_dosya_deposu set cop = 'true', silen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"', silen_tarihi = getdate(), silen_saati = getdate() where id = '"& dosya_id &"' and firma_id = '"& FirmaID &"'"
            set sil = baglanti.execute(SQL)

            if trim(etiket)="proje" then
                SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
                set guncelle = baglanti.execute(SQL)
            end if

        end if
%>
<div class="dt-responsive table-responsive" style="padding-bottom: 85px">
    <table id="new-cons" class="table table-striped table-bordered table-hover" width="100%">
        <thead>
            <tr>
                <th style="width: 20px; text-align: center;">ID</th>
                <th><%=LNG("Dosya Adı")%></th>
                <th><%=LNG("Ekleme Tarihi")%></th>
                <th><%=LNG("Ekleme Saati")%></th>
                <th><%=LNG("Ekleyen")%></th>
                <th><%=LNG("İşlem")%></th>
            </tr>
        </thead>
        <tbody>
            <%
                SQL="select kullanici.personel_ad + ' ' + kullanici.personel_soyad as ekleyen, depo.* from ahtapot_dosya_deposu depo join ucgem_firma_kullanici_listesi kullanici on kullanici.id = depo.ekleyen_id where depo.etiket = '"& etiket &"' and depo.kayit_id = '"& kayit_id &"' and depo.cop = 'false' and depo.firma_id = '"& FirmaID &"' and kullanici.firma_id = '"& FirmaID &"'"
                set depo = baglanti.execute(SQL)
                if depo.eof then
            %>
            <tr>
                <td colspan="6" style="text-align: center;"><%=LNG("Kayıt Yok")%></td>
            </tr>
            <%
                end if
                do while not depo.eof
            %>
            <tr>
                <td><%=depo("id") %></td>
                <td><%=depo("depo_dosya_adi") %></td>
                <td><%=cdate(depo("ekleme_tarihi")) %></td>
                <td><%=left(depo("ekleme_saati"),5) %></td>
                <td><%=depo("ekleyen") %></td>
                <td class="dropdown">
                    <button type="button" class="btn btn-primary dropdown-toggle btn-mini" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-cog" aria-hidden="true"></i></button>
                    <div class="dropdown-menu dropdown-menu-right b-none contact-menu">
                        <!--<a class="dropdown-item" href="javascript:void(0);" onclick="depo_dosya_indir('<%=etiket %>', '<%=kayit_id %>', '<%=depo("id") %>');"><i class="icofont icofont-edit"></i><%=LNG("İndir")%></a>-->
                        <%if InStr(depo("depo_dosya_yolu"), "jpg") or InStr(depo("depo_dosya_yolu"), "jpeg") or InStr(depo("depo_dosya_yolu"), "png") or InStr(depo("depo_dosya_yolu"), "pdf") then %>
                        <a class="dropdown-item" href="javascript:void(0);" onclick="OpenOrDownloadFile('<%=depo("depo_dosya_yolu") %>');"><i class="icofont icofont-edit"></i><%=LNG("Aç")%></a>
                        <%else %>
                        <a class="dropdown-item" href="javascript:void(0);" onclick="OpenOrDownloadFile('<%=depo("depo_dosya_yolu") %>');"><i class="icofont icofont-edit"></i><%=LNG("İndir")%></a>
                        <%end if %>
                        <a class="dropdown-item" href="javascript:void(0);" onclick="depo_dosya_sil('<%=etiket %>', '<%=kayit_id %>', '<%=depo("id") %>');"><i class="icofont icofont-ui-delete"></i><%=LNG("Sil")%></a>
                    </div>
                </td>
            </tr>
            <%
                depo.movenext
                loop
            %>
        </tbody>
    </table>
</div>

<%
    elseif trn(request("islem")) = "zorunlu_dosyalar" then
        etiket = trn(request("etiket"))
        kayit_id = trn(request("kayit_id"))
        FirmaID = Request.Cookies("kullanici")("firma_id")
%>
<div class="dt-responsive table-responsive" style="padding-bottom: 25px">
    <table id="new-cons" class="table table-striped table-bordered table-hover" width="100%">
        <thead>
            <tr>
                <th style="width: 20px; text-align: center;">ID</th>
                <th><%=LNG("Dosya Adı")%></th>
                <th><%=LNG("Zorunlu")%></th>
            </tr>
        </thead>
        <tbody>
            <%
                SQL = "select * from ZorunluDosyalar where Zorunlu = 'true' and Silindi = 'false' and FirmaID = '"& FirmaID &"' and DosyaID not in(select dosya_id from ahtapot_dosya_deposu where kayit_id = '"& kayit_id &"' and etiket = '"& etiket &"' and firma_id = '"& FirmaID &"' and dosya_id is not null and cop = 'false')"
                set zorunluDosya = baglanti.execute(SQL)

                if zorunluDosya.eof then
            %>
            <tr>
                <td colspan="6" style="text-align: center;"><%=LNG("Eksik Belge Yok")%></td>
            </tr>
            <%
                end if
                d = 0
                do while not zorunluDosya.eof
                d = d + 1
            %>
            <tr>
                <td><%=d %></td>
                <td><%=zorunluDosya("DosyaAdi") %></td>
                <td>
                    <%if zorunluDosya("Zorunlu") = True then %>
                    <label class="label label-danger" style="padding: 4px; font-size: 11px; font-weight: 600; text-align: center">Zorunlu</label>
                    <%elseif zorunluDosya("Zorunlu") = False then %>
                    <label class="label label-success" style="padding: 4px; font-size: 11px; font-weight: 600; text-align: center">Zorunlu Değil</label>
                    <%end if %>
                </td>
            </tr>
            <%
                zorunluDosya.movenext
                loop
            %>
        </tbody>
    </table>
</div>
<!-- #include virtual="/ajax/include/yenidt.asp" -->
<% 
    elseif trn(request("islem"))="firma_bilgilerini_guncelle" then

        firma_id = trn(request("firma_id"))
        firma_logo = trn(request("firma_logo"))
        firma_adres = trn(request("firma_adres"))
        
        firma_telefon = trn(request("firma_telefon"))
        firma_mail = trn(request("firma_mail"))
        firma_adi = trn(request("firma_adi"))
        firma_supervisor_id = trn(request("firma_supervisor_id"))
        taseron_saatlik_maliyet = trim(replace(replace(replace(trn(request("taseron_saatlik_maliyet")),".",""),",","."),"TL",""))
        taseron_maliyet_pb = trn(request("taseron_maliyet_pb"))

        firma_vergi_no = trn(request("firma_vergi_no"))
        firma_vergi_daire = trn(request("firma_vergi_daire"))

        firma_yetkili = trn(request("firma_yetkili"))
        yetkili1_telefon = trn(request("yetkili1_telefon"))
        yetkili1_mail = trn(request("yetkili1_mail"))
       
        yetkili2_adi = trn(request("yetkili2_adi"))
        yetkili2_telefon = trn(request("yetkili2_telefon"))
        yetkili2_mail = trn(request("yetkili2_mail"))

        yetkili3_adi = trn(request("yetkili3_adi"))
        yetkili3_telefon = trn(request("yetkili3_telefon"))
        yetkili3_mail = trn(request("yetkili3_mail"))

        yetkili4_adi = trn(request("yetkili4_adi"))
        yetkili4_telefon = trn(request("yetkili4_telefon"))
        yetkili4_mail = trn(request("yetkili4_mail"))


    yetkiliSorgu = ""
    if (trn(request("yetkili2_adi"))="") then
       yetkiliSorgu = yetkiliSorgu & ", yetkili2_adi = NULL, yetkili2_telefon = NULL, yetkili2_mail = NULL"
    else
        yetkiliSorgu = yetkiliSorgu & ", yetkili2_adi = '" & yetkili2_adi & "', yetkili2_telefon = '" & yetkili2_telefon & "', yetkili2_mail = '" & yetkili2_mail & "' "
    end if

    if (trn(request("yetkili3_adi"))="") then
       yetkiliSorgu = yetkiliSorgu & ", yetkili3_adi = NULL, yetkili3_telefon = NULL, yetkili3_mail = NULL"
    else
        yetkiliSorgu = yetkiliSorgu & ", yetkili3_adi = '" & yetkili3_adi & "', yetkili3_telefon = '" & yetkili3_telefon & "', yetkili3_mail = '" & yetkili3_mail & "'"
    end if

   if (trn(request("yetkili4_adi"))="") then
       yetkiliSorgu = yetkiliSorgu & ", yetkili4_adi = NULL, yetkili4_telefon = NULL, yetkili4_mail = NULL"
    else
        yetkiliSorgu = yetkiliSorgu & ", yetkili4_adi = '" & yetkili4_adi & "', yetkili4_telefon = '" & yetkili4_telefon & "', yetkili4_mail = '" & yetkili4_mail & "'"
    end if
        

    SQL="update ucgem_firma_listesi set firma_adi = '"& firma_adi &"', taseron_saatlik_maliyet = CAST('"& taseron_saatlik_maliyet &"' AS DECIMAL(18, 4)) , taseron_maliyet_pb = '"& taseron_maliyet_pb &"', firma_logo = '" & firma_logo & "', firma_yetkili = '" & firma_yetkili & "', firma_telefon = '" & firma_telefon & "', firma_adres = '" & firma_adres & "', firma_mail = '" & firma_mail & "', firma_supervisor_id = '" & firma_supervisor_id & "', firma_vergi_no = '" & firma_vergi_no & "' , firma_vergi_daire = '" & firma_vergi_daire & "', yetkili1_telefon = '" & yetkili1_telefon & "', yetkili1_mail = '" & yetkili1_mail & "' " & yetkiliSorgu & "  where id = '"& firma_id &"'"

    'response.Write(SQL)
    set guncelle = baglanti.execute(SQL)

    elseif trn(request("islem"))="cari_detay_tabela_getir" then

        cari_id = trn(request("cari_id"))
        tip = trn(request("tip"))


        if trim(tip)="firma" then

            SQL="select * from ucgem_firma_listesi where id = '"& cari_id &"' and ekleyen_firma_id = '"& Request.Cookies("kullanici")("firma_id") &"'"
            set firma = baglanti.execute(SQL)

            cari_hesap_adi = firma("firma_adi")

        elseif trim(tip)="personel" then

            SQL="select personel_ad + ' ' + personel_soyad as personel from ucgem_firma_kullanici_listesi where id = '"& cari_id &"' and firma_id = '"& Request.Cookies("kullanici")("firma_id") &"'"
            set personel = baglanti.execute(SQL)

            cari_hesap_adi = personel("personel")

        end if

        SQL="declare @cari_id int = "& cari_id &", @cari_tip nvarchar(50) = '"& tip &"'; select  (select isnull(sum(meblag),0) from cari_hareketler where borclu_tipi = @cari_tip and borclu_id = @cari_id and parabirimi = 'TL' and cop = 'false') as borclu_tl,  (select isnull(sum(meblag),0) from cari_hareketler where borclu_tipi = @cari_tip and borclu_id = @cari_id and parabirimi = 'USD' and cop = 'false') as borclu_usd, (select isnull(sum(meblag),0) from cari_hareketler where borclu_tipi = @cari_tip and borclu_id = @cari_id and parabirimi = 'EUR' and cop = 'false') as borclu_eur, (select isnull(sum(meblag),0) from cari_hareketler where alacakli_tipi = @cari_tip and alacakli_id = @cari_id and parabirimi = 'TL' and cop = 'false') as alacakli_tl,  (select isnull(sum(meblag),0) from cari_hareketler where alacakli_tipi = @cari_tip and alacakli_id = @cari_id and parabirimi = 'USD' and cop = 'false') as alacakli_usd,  (select isnull(sum(meblag),0) from cari_hareketler where alacakli_tipi = @cari_tip and alacakli_id = @cari_id and parabirimi = 'EUR' and cop = 'false') as alacakli_eur, ((select isnull(sum(meblag),0) from cari_hareketler where borclu_tipi = @cari_tip and borclu_id = @cari_id and parabirimi = 'TL' and cop = 'false')- (select isnull(sum(meblag),0) from cari_hareketler where alacakli_tipi = @cari_tip and alacakli_id = @cari_id and parabirimi = 'TL' and cop = 'false')) as bakiye_tl,  ((select isnull(sum(meblag),0) from cari_hareketler where borclu_tipi = @cari_tip and borclu_id = @cari_id and parabirimi = 'USD' and cop = 'false')- (select isnull(sum(meblag),0) from cari_hareketler where alacakli_tipi = @cari_tip and alacakli_id = @cari_id and parabirimi = 'USD' and cop = 'false')) as bakiye_usd,  ((select isnull(sum(meblag),0) from cari_hareketler where borclu_tipi = @cari_tip and borclu_id = @cari_id and parabirimi = 'EUR' and cop = 'false')- (select isnull(sum(meblag),0) from cari_hareketler where alacakli_tipi = @cari_tip and alacakli_id = @cari_id and parabirimi = 'EUR' and cop = 'false' and firma_id = '"& FirmaID &"')) as bakiye_eur"
        set tabela = baglanti.execute(SQL)

%>
<div class="col-lg-4">

    <div class="card bg-c-green notification-card">
        <div class="card-block">
            <div class="row">

                <div class="col-md-9" style="padding: 0; padding-left: 10px;">
                    <div class="row" style="padding: 0;">
                        <div class="col-xs-12" style="padding: 10px;">
                            <center>
                                <h5 style="font-weight:300; line-height:45px;"><i class="fa fa-money"></i> <%=LNG("Tahsilatlar")%></h5>
                            </center>
                        </div>
                    </div>
                    <div class="row align-items-center" style="padding: 0; padding-top: 15px;">
                        <div class="col-4" style="padding: 0;">
                            <h5 style="font-size: 13px; font-weight: normal;"><%=formatnumber(tabela("borclu_tl"),0) %> TL</h5>
                        </div>
                        <div class="col-4 notify-cont" style="padding: 0;">
                            <h5 style="font-size: 13px; font-weight: normal;"><%=formatnumber(tabela("borclu_usd"),0) %> $</h5>
                        </div>
                        <div class="col-4 notify-cont" style="padding: 0;">
                            <h5 style="font-size: 13px; font-weight: normal;"><%=formatnumber(tabela("borclu_eur"),0) %> €</h5>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div id="chart_Exploading" style="width: 100%; height: 150px;"></div>
                </div>
            </div>

        </div>
    </div>
</div>
<div class="col-lg-4">
    <div class="card bg-c-pink notification-card">
        <div class="card-block">
            <div class="row">

                <div class="col-md-9" style="padding: 0; padding-left: 10px;">
                    <div class="row" style="padding: 0;">
                        <div class="col-xs-12" style="padding: 10px;">
                            <center>
                                <h5 style="font-weight:300; line-height:45px;"><i class="fa fa-money"></i> <%=LNG("Ödemeler")%></h5>
                            </center>
                        </div>
                    </div>
                    <div class="row align-items-center" style="padding: 0; padding-top: 15px;">
                        <div class="col-4" style="padding: 0;">
                            <h5 style="font-size: 13px; font-weight: normal;"><%=formatnumber(tabela("alacakli_tl"),0) %> TL</h5>
                        </div>
                        <div class="col-4 notify-cont" style="padding: 0;">
                            <h5 style="font-size: 13px; font-weight: normal;"><%=formatnumber(tabela("alacakli_usd"),0) %> $</h5>
                        </div>
                        <div class="col-4 notify-cont" style="padding: 0;">
                            <h5 style="font-size: 13px; font-weight: normal;"><%=formatnumber(tabela("alacakli_eur"),0) %> €</h5>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div id="chart_Exploading2" style="width: 100%; height: 150px;"></div>
                </div>
            </div>

        </div>
    </div>
</div>
<div class="col-lg-4">
    <div class="card bg-c-blue notification-card">
        <div class="card-block">
            <div class="row">

                <div class="col-md-9" style="padding: 0; padding-left: 10px;">
                    <div class="row" style="padding: 0;">
                        <div class="col-xs-12" style="padding: 10px;">
                            <center>
                                <h5 style="font-weight:300; line-height:45px;"><i class="fa fa-money"></i> <%=LNG("Bakiye")%></h5>
                            </center>
                        </div>
                    </div>
                    <div class="row align-items-center" style="padding: 0; padding-top: 15px;">
                        <div class="col-4" style="padding: 0;">
                            <h5 style="font-size: 13px; font-weight: normal;"><%=formatnumber(tabela("bakiye_tl"),0) %> TL</h5>
                        </div>
                        <div class="col-4 notify-cont" style="padding: 0;">
                            <h5 style="font-size: 13px; font-weight: normal;"><%=formatnumber(tabela("bakiye_usd"),0) %> $</h5>
                        </div>
                        <div class="col-4 notify-cont" style="padding: 0;">
                            <h5 style="font-size: 13px; font-weight: normal;"><%=formatnumber(tabela("bakiye_eur"),0) %>
                            €</h4>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div id="chart_Exploading3" style="width: 100%; height: 150px;"></div>
                </div>
            </div>

        </div>
    </div>
</div>

<script>

        $(function () {
            function drawChartExploading() {
                var dataExploading = google.visualization.arrayToDataTable([
                    ['Nakit Giriş', 'Nakit Giriş'],
                    ['TL', <%=NoktalamaDegis(tabela("borclu_tl")) %>],
                    ['Dolar', <%=NoktalamaDegis(tabela("borclu_usd")) %>],
                    ['EUR', <%=NoktalamaDegis(tabela("borclu_eur")) %>]
                ]);

                var optionsExploading = {
                    title: '',
                    legend: 'none',
                    pieSliceText: 'label',
                    backgroundColor: 'transparent',
                    slices: {
                        4: { offset: 0.2 },
                        12: { offset: 0.3 },
                        14: { offset: 0.4 },
                        15: { offset: 0.5 },
                    },
                    pieHole: 0.4,
                    colors: ['#FC6180', '#4680ff', '#FFB64D', '#FE8A7D', '#69CEC6']
                };

                var chart = new google.visualization.PieChart(document.getElementById('chart_Exploading'));
                chart.draw(dataExploading, optionsExploading);
            }

            google.charts.load("current", { packages: ["corechart"] });
            google.charts.setOnLoadCallback(drawChartExploading);




            function drawChartExploading2() {
                var dataExploading = google.visualization.arrayToDataTable([
                    ['<%=LNG("Nakit Giriş")%>', '<%=LNG("Nakit Giriş")%>'],
                    ['TL', <%=NoktalamaDegis(tabela("alacakli_tl")) %>],
                    ['Dolar', <%=NoktalamaDegis(tabela("alacakli_usd")) %>],
                    ['EUR', <%=NoktalamaDegis(tabela("alacakli_eur")) %>]
                ]);

                var optionsExploading = {
                    title: '',
                    legend: 'none',
                    pieSliceText: 'label',
                    backgroundColor: 'transparent',
                    slices: {
                        4: { offset: 0.2 },
                        12: { offset: 0.3 },
                        14: { offset: 0.4 },
                        15: { offset: 0.5 },
                    },
                    pieHole: 0.4,
                    colors: ['#4680ff', '#FFB64D', '#69CEC6']
                };

                var chart = new google.visualization.PieChart(document.getElementById('chart_Exploading2'));
                chart.draw(dataExploading, optionsExploading);
            }

            google.charts.load("current", { packages: ["corechart"] });
            google.charts.setOnLoadCallback(drawChartExploading2);



            function drawChartExploading3() {
                var dataExploading = google.visualization.arrayToDataTable([
                    ['<%=LNG("Nakit Giriş")%>', '<%=LNG("Nakit Giriş")%>'],
                    ['TL', <%=NoktalamaDegisMutlak(tabela("bakiye_tl")) %>],
                    ['Dolar', <%=NoktalamaDegisMutlak(tabela("bakiye_usd")) %>],
                    ['EUR', <%=NoktalamaDegisMutlak(tabela("bakiye_eur")) %>]
                ]);

                var optionsExploading = {
                    title: '',
                    legend: 'none',
                    pieSliceText: 'label',
                    backgroundColor: 'transparent',
                    slices: {
                        4: { offset: 0.2 },
                        12: { offset: 0.3 },
                        14: { offset: 0.4 },
                        15: { offset: 0.5 },
                    },
                    pieHole: 0.4,
                    colors: ['#FC6180', '#93BE52', '#FFB64D', '#FE8A7D', '#69CEC6']
                };

                var chart = new google.visualization.PieChart(document.getElementById('chart_Exploading3'));
                chart.draw(dataExploading, optionsExploading);
            }

            google.charts.load("current", { packages: ["corechart"] });
            google.charts.setOnLoadCallback(drawChartExploading3);
        });
</script>

<%






    
    elseif trn(request("islem"))="ajanda_calistir" then

        etiket = trn(request("etiket"))
        etiket_id = trn(request("etiket_id"))

%>
<link rel="stylesheet" type="text/css" href="/files/bower_components/fullcalendar/css/fullcalendar.css">
<link rel="stylesheet" type="text/css" href="/files/bower_components/fullcalendar/css/fullcalendar.print.css" media='print'>
<div class="page-body">
    <div class="card">
        <div class="card-block">
            <div class="row">
                <div class="col-lg-8">
                    <div style="width: 200px; width: 200px; margin-left: 15px; margin-top: -3px; float: right; margin-bottom: 40px;">
                        <input id="takvim_arama_input" onkeyup="takvim_arama_yap(this.value);" placeholder="<%=LNG("Arama...")%>" class="form-control" type="text" />
                    </div>
                    <div id='calendar' etiket="<%=etiket %>" etiket_id="<%=etiket_id %>"></div>
                </div>

                <div class="col-lg-4">
                    <div id='calendar_gunluk' etiket="<%=etiket %>" etiket_id="<%=etiket_id %>"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<!--<div class="page-error">
    <div class="card text-center">
        <div class="card-block">
            <div class="m-t-10">
                <i class="icofont icofont-warning text-white bg-c-yellow"></i>
                <h4 class="f-w-600 m-t-25"><%=LNG("Hata Oluştu")%></h4>
                <p class="text-muted m-b-0"><%=LNG("Tarayıcınız Ajanda Uygulamasını Desteklemiyor.")%></p>
            </div>
        </div>
    </div>
</div>-->
<script src="/files/bower_components/moment/js/moment.min.js"></script>
<script src="/files/bower_components/fullcalendar/js/fullcalendar.js"></script>
<script src="/files/bower_components/fullcalendar/js/tr.js"></script>
<script>

    $(function (){
        icerden_ajanda_calistir('<%=etiket %>', '<%=etiket_id %>');
    });

</script>
<style>
    .fc-time {
        color: white;
    }

    .fc-title {
        color: white;
        padding-left: 5px;
    }

    .fc-header {
        background-color: #4099ff !important;
        padding: 10px !important;
    }
</style>
<%
    elseif trn(request("islem"))="ajanda_olay_kaydet" then
    
        etiket = trn(request("etiket"))
        etiket_id = trn(request("etiket_id"))

        if trn(request("islem2"))="ekle" then

            baslik = trn(request("baslik"))
            renk = trn(request("renk"))
            baslangic_tarihi = trn(request("baslangic_tarihi"))
            baslangic_saati = trn(request("baslangic_saati"))
            bitis_tarihi = trn(request("bitis_tarihi"))
            bitis_saati = trn(request("bitis_saati"))
            aciklama = trn(request("aciklama"))
            etiketler = trn(request("etiketler"))
            kisiler = trn(request("kisiler"))

            isEmriEkleme = trn(request("isEmriEkleme"))
            bagimsizRenk = trn(request("bagimsizRenk"))

            title = baslik
            allDay = 0
            baslangic = baslangic_tarihi
            bitis = bitis_tarihi
            url = ""
            color = renk
            description = aciklama

            durum = "true"
            cop = "false"
            firma_id = Request.Cookies("kullanici")("firma_id")
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")

            olay_tipi = trn(request("olay_tipi"))

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
    
            

            if instr("asd-asd," & etiketler & ",asd-asd", "proje")>0 then
                for x = 0 to ubound(split(etiketler, ","))

                    etiket_tip = split(split(etiketler, ",")(x),"-")(0)
                    etiket_id = split(split(etiketler, ",")(x), "-")(1)

                    if trim(etiket_tip) = "proje" then

                        proje_id = etiket_id
                        olay = "Ajanda Kaydı Eklendi : " & baslik
                        olay_tarihi = cdate(date)
                        olay_saati = time
                        departman_id = 0
                        durum = "true"
                        cop = "false"
                        firma_kodu = Request.Cookies("kullanici")("firma_kodu")
                        firma_id = Request.Cookies("kullanici")("firma_id")
                        ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
                        ekleyen_ip = Request.ServerVariables("Remote_Addr")
                        ekleme_tarihi = date
                        ekleme_saati = time

                        SQL="insert into ucgem_proje_olay_listesi(proje_id, olay, olay_tarihi, olay_saati, departman_id, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', '"& olay &"', CONVERT(date, '"& olay_tarihi &"', 103), '"& olay_saati &"', '"& departman_id &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
    
                        set olay_ekle = baglanti.execute(SQL)
                    
                        SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& etiket_id &"' and firma_id = '"& FirmaID &"'"
                        set guncelle = baglanti.execute(SQL)
                    end if
                next
            end if

            if trim(olay_tipi) <> "rutin" then
    
                ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
    response.Write("Rutin")
                if isEmriEkleme = "false" then
                    color = bagimsizRenk
                end if

                SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, IsID) values('0', '"& kisiler &"', '"& baslangic_saati &"', '"& bitis_saati &"', '" & etiket & "', '" & trn(request("etiket_id")) & "', '" & title & "', '" & allDay & "', CONVERT(date, '"& baslangic_tarihi &"', 103), CONVERT(date, '"& bitis_tarihi &"', 103), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate(), '0'); SELECT SCOPE_IDENTITY() id;"
                set ekle = baglanti.execute(SQL)

                ana_kayit_id = ekle(0)

                for k = 0 to ubound(split(kisiler, ","))
                    kisi_id = split(kisiler, ",")(k)
                            
                    etiket_id = kisi_id
                    SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, IsID, manuel_kayit) values('"& ana_kayit_id &"', '"& kisiler &"', '"& baslangic_saati &"', '"& bitis_saati &"', '" & etiket & "', '" & etiket_id & "', '" & title & "', '" & allDay & "', CONVERT(date, '"& baslangic_tarihi &"', 103), CONVERT(date, '"& bitis_tarihi &"', 103), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate(), '"& is_id &"', '1'); SELECT SCOPE_IDENTITY() id;"
                    set ekle = baglanti.execute(SQL)
                next

                SQL = "select personel_ad + ' ' + personel_soyad as ad_soyad from ucgem_firma_kullanici_listesi where id = '"& ekleyen_id &"' and firma_id = '"& FirmaID &"'"
                set guncelleyen = baglanti.execute(SQL)

                if isEmriEkleme = "true" then
                    if kisiler = "" or kisiler = null then
                        gorevliler = ekleyen_id
                    else
                        gorevliler = ekleyen_id & "," & kisiler
                    end if

                    SQL = "SET NOCOUNT ON; insert into ucgem_is_listesi(adi, firma_kodu, aciklama, gorevliler, departmanlar, oncelik, baslangic_tarihi, baslangic_saati, bitis_tarihi, bitis_saati, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, guncelleme_tarihi, guncelleme_saati, guncelleyen, renk, ajanda_gosterim, toplam_sure, gunluk_sure, toplam_gun, sinirlama_varmi) values('"& baslik &"', '"& firma_kodu &"', '"& aciklama &"', '"& gorevliler &"', '"& etiketler &"', 'Normal', Convert(date, '"& baslangic_tarihi &"', 103), '"& baslangic_saati &"', Convert(date, '"& bitis_tarihi &"', 103), '"& bitis_saati &"', 'true', 'false', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', GETDATE(), '"& ekleme_saati &"', Convert(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"', '"& guncelleyen("ad_soyad") &"', '"& renk &"', '1', (SELECT CONVERT(varchar(5), DATEADD(minute, DATEDIFF(Minute, '"& baslangic_saati &"', '"& bitis_saati &"'), 0), 114)), '', (select DATEDIFF(DAY, CONVERT(date, '"& baslangic_tarihi &"', 103), CONVERT(date, '"& bitis_tarihi &"', 103))), '0'); SELECT SCOPE_IDENTITY() id;"
                    set ajandaYeniIsEmri = baglanti.execute(SQL)
                    'response.Write(SQL)
                
                    is_id = ajandaYeniIsEmri(0)

                    SQL="update ahtapot_ajanda_olay_listesi set ana_kayit_id = '"& ana_kayit_id &"', IsID = '"& is_id &"' where id = '"& ana_kayit_id &"' and firma_id = '"& FirmaID &"'"
                    set guncelle = baglanti.execute(SQL)

                    SQL = "insert into ucgem_is_gorevli_durumlari(gorevli_id, tamamlanma_orani, tamamlanma_tarihi, tamamlanma_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, is_id, toplam_sure, gunluk_sure, toplam_gun) values('"& ekleyen_id &"', '0', Convert(date, '"& baslangic_tarihi &"', 103), '"& baslangic_saati &"', 'true', 'false', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', GETDATE(), '"& ekleme_saati &"', '"& is_id &"', (SELECT CONVERT(varchar(5), DATEADD(minute, DATEDIFF(Minute, '"& baslangic_saati &"', '"& bitis_saati &"'), 0), 114)), '', (select DATEDIFF(DAY, CONVERT(date, '"& baslangic_tarihi &"', 103), CONVERT(date, '"& bitis_tarihi &"', 103))))"
                    set isGorevliDurumlari = baglanti.execute(SQL)

                    for k = 0 to ubound(split(kisiler, ","))
                        kisi_id = split(kisiler, ",")(k)
                            
                        etiket_id = kisi_id
                        SQL = "insert into ucgem_is_gorevli_durumlari(gorevli_id, tamamlanma_orani, tamamlanma_tarihi, tamamlanma_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, is_id, toplam_sure, gunluk_sure, toplam_gun) values('"& etiket_id &"', '0', Convert(date, '"& baslangic_tarihi &"', 103), '"& baslangic_saati &"', 'true', 'false', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', GETDATE(), '"& ekleme_saati &"', '"& is_id &"', (SELECT CONVERT(varchar(5), DATEADD(minute, DATEDIFF(Minute, '"& baslangic_saati &"', '"& bitis_saati &"'), 0), 114)), '', (select DATEDIFF(DAY, CONVERT(date, '"& baslangic_tarihi &"', 103), CONVERT(date, '"& bitis_tarihi &"', 103))))"
                        set isGorevliDurumlari = baglanti.execute(SQL)
                    next
                end if
            

            elseif trim(olay_tipi) = "rutin" then

                ana_kayit_id = 0

                yineleme_baslangic = cdate(yineleme_baslangic)
                yineleme_bitis = cdate(yineleme_bitis)

                if trim(yineleme_donemi) = "gunluk" then

                    if trim(gunluk_yineleme_secim)="gunluk" then

                        y = 0
                        for x = cdate(yineleme_baslangic) to cdate(yineleme_bitis) step cint(gunluk_yineleme_gun_aralik)

                            y = y + 1
                            toplanti_sira = y
                            baslangic = cdate(x)
                            baslangic_saati = trn(request("baslangic_saati"))
                            olay_suresi = trn(request("olay_suresi"))


                            SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& ana_kayit_id &"', '"& kisiler &"', '"& baslangic_saati &"', cast((convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"')) as time), '" & etiket & "', '" & trn(request("etiket_id")) & "', '" & title & "', '" & allDay & "', '" & baslangic & "', convert(date, convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"'), 104), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate()); SELECT SCOPE_IDENTITY() id;"
                            set ekle = baglanti.execute(SQL)

                            if cdbl(ana_kayit_id) = 0 then
                                ana_kayit_id = ekle(0)
                                SQL="update ahtapot_ajanda_olay_listesi set ana_kayit_id = '"& ana_kayit_id &"' where id = '"& ana_kayit_id &"' and firma_id = '"& FirmaID &"'"
                                set guncelle = baglanti.execute(SQL)
                            end if

                            for k = 0 to ubound(split(kisiler, ","))
                                kisi_id = split(kisiler, ",")(k)
                                if isnumeric(kisi_id)=true then
                                    if cdbl(kisi_id)>0 then
                                        etiket_id = kisi_id
                                        SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& ana_kayit_id &"', '"& kisiler &"', '"& baslangic_saati &"', cast((convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"')) as time), '" & etiket & "', '" & etiket_id & "', '" & title & "', '" & allDay & "', '" & baslangic & "', convert(date, convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"'), 104), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate()); SELECT SCOPE_IDENTITY() id;"
                                        set ekle = baglanti.execute(SQL)
                                    end if
                                end if
                            next

                        next

                    else
                        ' iş günü
                        y = 0
                        for k = cdate(yineleme_baslangic) to cdate(yineleme_bitis)

                            if weekday(cdate(k))=1 or weekday(cdate(k))=7 then
                            else
                                y = y + 1
                                toplanti_sira = y
                                baslangic = cdate(x)
                                baslangic_saati = trn(request("baslangic_saati"))
                                olay_suresi = trn(request("olay_suresi"))

                                SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& ana_kayit_id &"', '"& kisiler &"', '"& baslangic_saati &"', cast((convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"')) as time), '" & etiket & "', '" & trn(request("etiket_id")) & "', '" & title & "', '" & allDay & "', '" & baslangic & "', convert(date, convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"'), 104), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate()); SELECT SCOPE_IDENTITY() id;"
                                set ekle = baglanti.execute(SQL)

                                if cdbl(ana_kayit_id) = 0 then
                                    ana_kayit_id = ekle(0)
                                    SQL="update ahtapot_ajanda_olay_listesi set ana_kayit_id = '"& ana_kayit_id &"' where id = '"& ana_kayit_id &"' and firma_id = '"& FirmaID &"'"
                                    set guncelle = baglanti.execute(SQL)
                                end if

                                for kk = 0 to ubound(split(kisiler, ","))
                                    kisi_id = split(kisiler, ",")(kk)
                                    if isnumeric(kisi_id)=true then
                                        if cdbl(kisi_id)>0 then
                                            etiket_id = kisi_id
                                            SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& ana_kayit_id &"', '"& kisiler &"', '"& baslangic_saati &"', cast((convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"')) as time), '" & etiket & "', '" & etiket_id & "', '" & title & "', '" & allDay & "', '" & baslangic & "', convert(date, convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"'), 104), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate()); SELECT SCOPE_IDENTITY() id;"
                                            set ekle = baglanti.execute(SQL)
                                        end if
                                    end if
                                next

                            end if

                        next

                    end if

                elseif trim(yineleme_donemi) = "haftalik" then

                    gunler = "," & gunler & ","
                    hafta = 0
                    y = 0
                    girdimi = false
                    for k = cdate(yineleme_baslangic) to cdate(yineleme_bitis)
                        if weekday(cdate(k))= 2 then
                            if hafta = 0 and girdimi = true then
                                hafta = 1
                            else
                                hafta = hafta + 1
                            end if
                        end if
                        if hafta mod cint(haftalik_yineleme_sikligi) = 0 or hafta = 0 then
                            if instr(gunler, "," & weekday(cdate(k)) & ",")>0 then

                                y = y + 1
                                toplanti_sira = y
                                baslangic = cdate(k)
                                baslangic_saati = trn(request("baslangic_saati"))
                                olay_suresi = trn(request("olay_suresi"))

                                SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& ana_kayit_id &"', '"& kisiler &"', '"& baslangic_saati &"', cast((convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"')) as time), '" & etiket & "', '" & trn(request("etiket_id")) & "', '" & title & "', '" & allDay & "', '" & baslangic & "', convert(date, convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"'), 104), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate()); SELECT SCOPE_IDENTITY() id;"
                                set ekle = baglanti.execute(SQL)

                                if cdbl(ana_kayit_id) = 0 then
                                    ana_kayit_id = ekle(0)
                                    SQL="update ahtapot_ajanda_olay_listesi set ana_kayit_id = '"& ana_kayit_id &"' where id = '"& ana_kayit_id &"' and firma_id = '"& FirmaID &"'"
                                    set guncelle = baglanti.execute(SQL)
                                end if

                                for kk = 0 to ubound(split(kisiler, ","))
                                    kisi_id = split(kisiler, ",")(kk)
                                    if isnumeric(kisi_id)=true then
                                        if cdbl(kisi_id)>0 then
                                            etiket_id = kisi_id
                                            SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& ana_kayit_id &"', '"& kisiler &"', '"& baslangic_saati &"', cast((convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"')) as time), '" & etiket & "', '" & etiket_id & "', '" & title & "', '" & allDay & "', '" & baslangic & "', convert(date, convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"'), 104), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate()); SELECT SCOPE_IDENTITY() id;"
                                            set ekle = baglanti.execute(SQL)
                                        end if
                                    end if
                                next
                                girdimi = true

                            end if
                        end if
                    next

                elseif trim(yineleme_donemi) = "aylik" then

                        

                    if trim(aylik_yenileme_tipi)="1" then
                        y = 0
                        ay = 0
                        girdimi = false
                        for k = cdate(yineleme_baslangic) to cdate(yineleme_bitis)
                            if day(cdate(k)) = 1 then
                                if ay = 0 and girdimi = true then
                                    ay = 1
                                else
                                    ay = ay + 1
                                end if
                            end if
                            if ay mod cint(aylik_aralik) = 0 or ay = 0 then
                                if day(cdate(k))=cint(aylik_gun) then

                                    y = y + 1
                                    toplanti_sira = y
                                    baslangic = cdate(k)
                                    baslangic_saati = trn(request("baslangic_saati"))
                                    olay_suresi = trn(request("olay_suresi"))

                                    SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& ana_kayit_id &"', '"& kisiler &"', '"& baslangic_saati &"', cast((convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"')) as time), '" & etiket & "', '" & trn(request("etiket_id")) & "', '" & title & "', '" & allDay & "', '" & baslangic & "', convert(date, convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"'), 104), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate()); SELECT SCOPE_IDENTITY() id;"
                                    set ekle = baglanti.execute(SQL)

                                    if cdbl(ana_kayit_id) = 0 then
                                        ana_kayit_id = ekle(0)
                                        SQL="update ahtapot_ajanda_olay_listesi set ana_kayit_id = '"& ana_kayit_id &"' where id = '"& ana_kayit_id &"' and firma_id = '"& FirmaID &"'"
                                        set guncelle = baglanti.execute(SQL)
                                    end if

                                    for kk = 0 to ubound(split(kisiler, ","))
                                        kisi_id = split(kisiler, ",")(kk)
                                        if isnumeric(kisi_id)=true then
                                            if cdbl(kisi_id)>0 then
                                                etiket_id = kisi_id
                                                SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& ana_kayit_id &"', '"& kisiler &"', '"& baslangic_saati &"', cast((convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"')) as time), '" & etiket & "', '" & etiket_id & "', '" & title & "', '" & allDay & "', '" & baslangic & "', convert(date, convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"'), 104), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate()); SELECT SCOPE_IDENTITY() id;"
                                                set ekle = baglanti.execute(SQL)
                                            end if
                                        end if
                                    next
                                    girdimi = true

                                end if
                            end if
                        next

                    elseif trim(aylik_yenileme_tipi)="2" then

                      

                        if trim(aylik_yineleme2)="gün" then
                            if aylik_yineleme1 = "son" then

                                    y = 0
                                    for k = cdate(yineleme_baslangic) to cdate(yineleme_bitis)
                                        son_gun = cdate(AyinSonGunu(k) & "." & month(cdate(k)) & "." & year(cdate(k)))

                                        if cdate(son_gun) = cdate(k) then

                                            y = y + 1
                                            toplanti_sira = y
                                            baslangic = cdate(k)
                                            baslangic_saati = trn(request("baslangic_saati"))
                                            olay_suresi = trn(request("olay_suresi"))

                                            SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& ana_kayit_id &"', '"& kisiler &"', '"& baslangic_saati &"', cast((convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"')) as time), '" & etiket & "', '" & trn(request("etiket_id")) & "', '" & title & "', '" & allDay & "', '" & baslangic & "', convert(date, convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"'), 104), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate()); SELECT SCOPE_IDENTITY() id;"
                                            set ekle = baglanti.execute(SQL)

                                            if cdbl(ana_kayit_id) = 0 then
                                                ana_kayit_id = ekle(0)
                                                SQL="update ahtapot_ajanda_olay_listesi set ana_kayit_id = '"& ana_kayit_id &"' where id = '"& ana_kayit_id &"' and firma_id = '"& FirmaID &"'"
                                                set guncelle = baglanti.execute(SQL)
                                            end if

                                            for kk = 0 to ubound(split(kisiler, ","))
                                                kisi_id = split(kisiler, ",")(kk)
                                                if isnumeric(kisi_id)=true then
                                                    if cdbl(kisi_id)>0 then
                                                        etiket_id = kisi_id
                                                        SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& ana_kayit_id &"', '"& kisiler &"', '"& baslangic_saati &"', cast((convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"')) as time), '" & etiket & "', '" & etiket_id & "', '" & title & "', '" & allDay & "', '" & baslangic & "', convert(date, convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"'), 104), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate()); SELECT SCOPE_IDENTITY() id;"
                                                        set ekle = baglanti.execute(SQL)
                                                    end if
                                                end if
                                            next

                                        end if

                                    next

                                else

                                    y = 0
                                    for k = cdate(yineleme_baslangic) to cdate(yineleme_bitis)
                                        if int(day(cdate(k))) = int(aylik_yineleme1) then

                                            y = y + 1
                                            toplanti_sira = y
                                            baslangic = cdate(k)
                                            baslangic_saati = trn(request("baslangic_saati"))
                                            olay_suresi = trn(request("olay_suresi"))

                                            SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& ana_kayit_id &"', '"& kisiler &"', '"& baslangic_saati &"', cast((convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"')) as time), '" & etiket & "', '" & trn(request("etiket_id")) & "', '" & title & "', '" & allDay & "', '" & baslangic & "', convert(date, convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"'), 104), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate()); SELECT SCOPE_IDENTITY() id;"
                                            set ekle = baglanti.execute(SQL)

                                            if cdbl(ana_kayit_id) = 0 then
                                                ana_kayit_id = ekle(0)
                                                SQL="update ahtapot_ajanda_olay_listesi set ana_kayit_id = '"& ana_kayit_id &"' where id = '"& ana_kayit_id &"' and firma_id = '"& FirmaID &"'"
                                                set guncelle = baglanti.execute(SQL)
                                            end if

                                            for kk = 0 to ubound(split(kisiler, ","))
                                                kisi_id = split(kisiler, ",")(kk)
                                                if isnumeric(kisi_id)=true then
                                                    if cdbl(kisi_id)>0 then
                                                        etiket_id = kisi_id
                                                        SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& ana_kayit_id &"', '"& kisiler &"', '"& baslangic_saati &"', cast((convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"')) as time), '" & etiket & "', '" & etiket_id & "', '" & title & "', '" & allDay & "', '" & baslangic & "', convert(date, convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"'), 104), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate()); SELECT SCOPE_IDENTITY() id;"
                                                        set ekle = baglanti.execute(SQL)
                                                    end if
                                                end if
                                            next

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

                                    for k = cdate(yineleme_bitis) to cdate(son_gun)

                                        if weekday(cdate(k))= int(aylik_yineleme2) and cdate(k) <= cdate(request("yineleme_baslangic")) then
                                            if not cint(son_ay) = cint(month(cdate(k))) then
                                                son_ay = int(month(cdate(k)))

                                                y = y + 1
                                                toplanti_sira = y
                                                baslangic = cdate(k)
                                                baslangic_saati = trn(request("baslangic_saati"))
                                                olay_suresi = trn(request("olay_suresi"))

                                                SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& ana_kayit_id &"', '"& kisiler &"', '"& baslangic_saati &"', cast((convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"')) as time), '" & etiket & "', '" & trn(request("etiket_id")) & "', '" & title & "', '" & allDay & "', '" & baslangic & "', convert(date, convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"'), 104), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate()); SELECT SCOPE_IDENTITY() id;"
                                                set ekle = baglanti.execute(SQL)


                                                if cdbl(ana_kayit_id) = 0 then
                                                    ana_kayit_id = ekle(0)
                                                    SQL="update ahtapot_ajanda_olay_listesi set ana_kayit_id = '"& ana_kayit_id &"' where id = '"& ana_kayit_id &"' and firma_id = '"& FirmaID &"'"
                                                    set guncelle = baglanti.execute(SQL)
                                                end if

                                                for kk = 0 to ubound(split(kisiler, ","))
                                                    kisi_id = split(kisiler, ",")(kk)
                                                    if isnumeric(kisi_id)=true then
                                                        if cdbl(kisi_id)>0 then
                                                            etiket_id = kisi_id
                                                            SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& ana_kayit_id &"', '"& kisiler &"', '"& baslangic_saati &"', cast((convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"')) as time), '" & etiket & "', '" & etiket_id & "', '" & title & "', '" & allDay & "', '" & baslangic & "', convert(date, convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"'), 104), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate()); SELECT SCOPE_IDENTITY() id;"
                                                            set ekle = baglanti.execute(SQL)
                                                        end if
                                                    end if
                                                next

                                            end if
                                        end if

                                    next
                                    
                                else


                                    baslangic_ay = "01." & month(cdate(yineleme_baslangic)) & "." & year(cdate(yineleme_baslangic))
                                    y = 0
                                    kacinci = 0
                                    for k = cdate(baslangic_ay) to cdate(yineleme_bitis)
                                        if cint(weekday(cdate(k)))=cint(aylik_yineleme2) then
                                            kacinci = kacinci + 1
                                            if cint(aylik_yineleme1)=cint(kacinci) then

                                                y = y + 1
                                                toplanti_sira = y
                                                baslangic = cdate(k)
                                                baslangic_saati = trn(request("baslangic_saati"))
                                                olay_suresi = trn(request("olay_suresi"))

                                                SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& ana_kayit_id &"', '"& kisiler &"', '"& baslangic_saati &"', cast((convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"')) as time), '" & etiket & "', '" & trn(request("etiket_id")) & "', '" & title & "', '" & allDay & "', '" & baslangic & "', convert(date, convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"'), 104), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate()); SELECT SCOPE_IDENTITY() id;"
                                                set ekle = baglanti.execute(SQL)

                                                if cdbl(ana_kayit_id) = 0 then
                                                    ana_kayit_id = ekle(0)
                                                    SQL="update ahtapot_ajanda_olay_listesi set ana_kayit_id = '"& ana_kayit_id &"' where id = '"& ana_kayit_id &"' and firma_id = '"& FirmaID &"'"
                                                    set guncelle = baglanti.execute(SQL)
                                                end if

                                                for kk = 0 to ubound(split(kisiler, ","))
                                                    kisi_id = split(kisiler, ",")(kk)
                                                    if isnumeric(kisi_id)=true then
                                                        if cdbl(kisi_id)>0 then
                                                            etiket_id = kisi_id
                                                            SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& ana_kayit_id &"', '"& kisiler &"', '"& baslangic_saati &"', cast((convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"')) as time), '" & etiket & "', '" & etiket_id & "', '" & title & "', '" & allDay & "', '" & baslangic & "', convert(date, convert(datetime, '"& baslangic &"') + convert(datetime, '"& baslangic_saati &"') + convert(datetime, '"& olay_suresi &"'), 104), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate()); SELECT SCOPE_IDENTITY() id;"
                                                            set ekle = baglanti.execute(SQL)
                                                        end if
                                                    end if
                                                next
                                            end if
                                        end if
                                    next
                                end if
                            end if
                        end if
                end if
            


        elseif trn(request("islem2"))="sil" then

            olay_id = trn(request("olay_id"))

            SQL="select IsID from ahtapot_ajanda_olay_listesi where durum = 'true' and cop = 'false' and id = '"& olay_id &"' and firma_id = '"& FirmaID &"'"
            set olay = baglanti.execute(SQL)

            SQL="update ahtapot_ajanda_olay_listesi set cop = 'true', silen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"', silen_tarihi = getdate(), silen_saati = getdate() where id = '"& olay_id &"' and firma_id = '"& FirmaID &"'"
            set sil = baglanti.execute(SQL)

            if isnumeric(olay(0)) = true then
                if cdbl(olay(0)) > 0 then
                    
                    SQL="select count(id) from ucgem_is_gorevli_durumlari where is_id = '"& olay(0) &"' and durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"'"
                    set kactane = baglanti.execute(SQL)

                    if cdbl(kactane(0)) = 1 then

                        SQL="update ucgem_is_listesi set cop = 'true' where id = '"& olay(0) &"' and firma_id = '"& FirmaID &"'; update ucgem_is_gorevli_durumlari set durum = 'false' where is_id = '"& olay(0) &"' and firma_id = '"& FirmaID &"'"
                        set guncelle = baglanti.execute(SQL)

                    elseif cdbl(kactane(0))>1 then

                        SQL="update ucgem_is_gorevli_durumlari set durum = 'false' where gorevli_id = '"& olay("etiket_id") &"' and is_id = '"& olay(0) &"' and firma_id = '"& FirmaID &"'"
                        set guncelle = baglanti.execute(SQL)

                    end if

                end if
            end if

        elseif trn(request("islem2"))="komplesil" then

            ana_kayit_id = trn(request("ana_kayit_id"))

            if cdbl(ana_kayit_id)>0 then
                SQL="update ahtapot_ajanda_olay_listesi set cop = 'true', silen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"', silen_tarihi = getdate(), silen_saati = getdate() where ana_kayit_id = '"& ana_kayit_id &"' and firma_id = '"& FirmaID &"'"
                set sil = baglanti.execute(SQL)
            end if

        elseif trn(request("islem2"))="sundur" then

            olay_id = trn(request("olay_id"))
            baslangic = left(trn(request("baslangic")),10)
            bitis = left(trn(request("bitis")),10)

            baslangic_saati = right(trn(request("baslangic")),5)
            bitis_saati = right(trn(request("bitis")),5)

            'baslangic = cdate(right(baslangic, 2) & "." & mid(baslangic, 6,2) & "." & left(baslangic, 4))
            'bitis = cdate(right(bitis, 2) & "." & mid(bitis, 6,2) & "." & left(bitis, 4))

            'baslangic_saati = right(trn(request("baslangic")),5)
            'bitis_saati = right(trn(request("bitis")),5)

            SQL="select *, Isnull(IsID, 0) as is_id, IsNull(tamamlandi, 0) as tamamlandi from ahtapot_ajanda_olay_listesi where id = '"& olay_id &"' and firma_id = '"& FirmaID &"'"
            response.Write(SQL)
            set olay = baglanti.execute(SQL)

            acikmi = true
            baslanmis = false
            if cdbl(olay("tamamlandi")) = -1 then
               baslanmis = true
            end if
            if cdbl(olay("is_id"))>0 then

                SQL="select count(id) from ucgem_is_gorevli_durumlari where is_id = '"& olay("is_id") &"' and durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"'"
                set kactane = baglanti.execute(SQL)
                
                if cdbl(kactane(0))>1 then
                    acikmi = false
                end if
            end if

            if acikmi = true then
                
             if baslanmis = false then
        
                ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
                ekleyen_ip = Request.Cookies("kullanici")("kullanici_ip")
                
                'SQL="update ucgem_is_listesi set baslangic_tarihi = '"& olay("baslangic") &"', bitis_tarihi = '"& olay("bitis") &"', baslangic_saati = '"& olay("baslangic_saati") &"', bitis_saati = '"& olay("bitis_saati") &"' where id = '"& olay("is_id") &"'"
                'set guncelle = baglanti.execute(SQL)

                SQL="select top 1 case when isnull(ana_kayit_id,0) = 0 then id else ana_kayit_id end as ana_kayit_id from ahtapot_ajanda_olay_listesi where id = '"& olay_id &"' and firma_id = '"& FirmaID &"'"
                set olay = baglanti.execute(SQL)

                ana_kayit_id = olay("ana_kayit_id")
         
                SQL="update ahtapot_ajanda_olay_listesi set baslangic = '"& baslangic &"', baslangic_saati = '"& baslangic_saati &"', bitis = '"& bitis &"', bitis_saati = '"& bitis_saati &"', ekleyen_id = '"& ekleyen_id &"', ekleyen_ip = '"& ekleyen_ip &"' where id = '"& olay_id &"' and firma_id = '"& FirmaID &"'"
                set guncelle = baglanti.execute(SQL)
response.Write(SQL)
    'case when isnull(ana_kayit_id,0) = 0 then id else ana_kayit_id end = '"& ana_kayit_id &"'
%>
<script type="text/javascript">
    $(function () {
        mesaj_ver("Ajanda", "Kayıt Başarıyla Güncelleme", "success");
        $('#calendar').fullCalendar('refetchEvents');
        $('#calendar_gunluk').fullCalendar('refetchEvents');
    });
</script>
<%
        else
%>
<script type="text/javascript">
    $(function () {
        mesaj_ver("Ajanda", " 'Başlanmış' Bir Kaydı Güncelleyemezsiniz !", "danger");
        $('#calendar').fullCalendar('refetchEvents');
        $('#calendar_gunluk').fullCalendar('refetchEvents');
    });
</script>
<%
        end if

     else
%>
<script>
                $(function (){
                    mesaj_ver("<%=LNG("Ajanda")%>", "<%=LNG("Ortak Görevli Olduğunuz İşlerde Güncelleme İşlemini İş Listesinden Yapınız.")%>", "danger");
                          $('#calendar').fullCalendar('refetchEvents');
                    $('#calendar_gunluk').fullCalendar('refetchEvents');
                });
</script>
<%
           end if
         
        elseif trn(request("islem2"))="guncelle" then

            olay_id = trn(request("olay_id"))
            baslik = trn(request("baslik"))
            renk = trn(request("renk"))
            baslangic_tarihi = trn(request("baslangic_tarihi"))
            baslangic_saati = trn(request("baslangic_saati"))
            bitis_tarihi = trn(request("bitis_tarihi"))
            bitis_saati = trn(request("bitis_saati"))
            aciklama = trn(request("aciklama"))
            etiketler = trn(request("etiketler"))
            kisiler = trn(request("kisiler"))
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")

            if instr("asd," & etiketler & ", asd", "proje")>0 then

                for x = 0 to ubound(split(etiketler, ","))

                    etiket_tip = split(etiketler,"-")(0)
                    etiket_id = split(etiketler, "-")(1)

                    if trim(etiket_tip) = "proje" then

                        proje_id = etiket_id
                        olay = "Ajanda Kaydı Güncellendi : " & baslik
                        olay_tarihi = cdate(date)
                        olay_saati = time
                        departman_id = 0
                        durum = "true"
                        cop = "false"
                        firma_id = Request.Cookies("kullanici")("firma_id")
                        ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
                        ekleyen_ip = Request.ServerVariables("Remote_Addr")
                        ekleme_tarihi = date
                        ekleme_saati = time

                        SQL="insert into ucgem_proje_olay_listesi(proje_id, olay, olay_tarihi, olay_saati, departman_id, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', '"& olay &"', CONVERT(date, '"& olay_tarihi &"', 103), '"& olay_saati &"', '"& departman_id &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"'); "
                        set olay_ekle = baglanti.execute(SQL)

                        SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& etiket_id &"' and firma_id = '"& FirmaID &"'"
                        set guncelle = baglanti.execute(SQL)

                        for k = 0 to ubound(split(kisiler, ","))
                            kisi_id = split(kisiler, ",")(k)
                            etiket_id = kisi_id

                            SQL = "select * from ahtapot_ajanda_olay_listesi where etiket_id = '"& etiket_id &"' and IsID = '"& olay("IsID") &"' and ana_kayit_id = '"& olay_id &"' and durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"'"
                            set kayitKontrol = baglanti.execute(SQL)

                            if kayitKontrol.eof then
                                SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, IsID) values('"& ana_kayit_id &"', '"& kisiler &"', '"& baslangic_saati &"', '"& bitis_saati &"', '" & etiket & "', '" & etiket_id & "', '" & title & "', '" & allDay & "', CONVERT(date, '"& baslangic_tarihi &"', 103), CONVERT(date, '"& bitis_tarihi &"', 103), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', 'true', 'false', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate(), '"& olay("IsID") &"'); SELECT SCOPE_IDENTITY() id;"
                                set ekle = baglanti.execute(SQL)
                            end if

                            if olay("IsID") > 0 then
                                SQL = "insert into ucgem_is_gorevli_durumlari(gorevli_id, tamamlanma_orani, tamamlanma_tarihi, tamamlanma_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, is_id, toplam_sure, gunluk_sure, toplam_gun) values('"& etiket_id &"', '0', Convert(date, '"& baslangic_tarihi &"', 103), '"& baslangic_saati &"', 'true', 'false', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', GETDATE(), '"& ekleme_saati &"', '"& olay("IsID") &"', (SELECT CONVERT(varchar(5), DATEADD(minute, DATEDIFF(Minute, '"& baslangic_saati &"', '"& bitis_saati &"'), 0), 114)), '', (select DATEDIFF(DAY, CONVERT(date, '"& baslangic_tarihi &"', 103), CONVERT(date, '"& bitis_tarihi &"', 103))))"
                                set isGorevliDurumlari = baglanti.execute(SQL)

                                SQL = "update ucgem_is_listesi set gorevliler = gorevliler + ',"& kisi_id &"' where id = '"& olay("IsID") &"' and firma_id = '"& FirmaID &"'"
                                set isGuncelle = baglanti.execute(SQL)
                            end if
                        next
                    end if
                next
            end if

            title = baslik
            allDay = 0
            baslangic = baslangic_tarihi
            bitis = bitis_tarihi
            url = ""
            color = renk
            description = aciklama
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")

            SQL="update ahtapot_ajanda_olay_listesi set etiketler = '"& etiketler &"', title = N'"& title &"', color = '"& color &"', baslangic = CONVERT(date, '"& baslangic &"', 103), baslangic_saati = '"& baslangic_saati &"', bitis = CONVERT(date, '"& bitis &"', 103), bitis_saati = '"& bitis_saati &"', description = N'"& description &"', ekleyen_id = '"& ekleyen_id &"', ekleyen_ip = '"& ekleyen_ip &"', kisiler = '"& kisiler &"' where id = '"& olay_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)

            SQL="select case when isnull(ana_kayit_id,0) = 0 then id else ana_kayit_id end as ana_kayit_id from ahtapot_ajanda_olay_listesi where id = '"& olay_id &"' and firma_id = '"& FirmaID &"'"
            set olay = baglanti.execute(SQL)

            ana_kayit_id = olay(0)

            SQL="update ahtapot_ajanda_olay_listesi set etiketler = '"& etiketler &"', title = N'"& title &"', color = '"& color &"', baslangic = CONVERT(date, '"& baslangic &"', 103), baslangic_saati = '"& baslangic_saati &"', bitis = CONVERT(date, '"& bitis &"', 103), bitis_saati = '"& bitis_saati &"', description = N'"& description &"', ekleyen_id = '"& ekleyen_id &"', ekleyen_ip = '"& ekleyen_ip &"' where case when isnull(ana_kayit_id,0) = 0 then id else ana_kayit_id end = '"& ana_kayit_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)


            SQL="select *, Isnull(IsID, 0) as is_id from ahtapot_ajanda_olay_listesi where id = '"& olay_id &"' and firma_id = '"& FirmaID &"'"
            set olay = baglanti.execute(SQL)

            acikmi = true
            if cdbl(olay("is_id"))>0 then

                SQL="select count(id) from ucgem_is_gorevli_durumlari where is_id = '"& olay("is_id") &"' and durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"'"
                set kactane = baglanti.execute(SQL)

                if cdbl(kactane(0))>0 then
                    acikmi = false
                end if
            else
                acikmi = false
            end if

            for k = 0 to ubound(split(kisiler, ","))
                kisi_id = split(kisiler, ",")(k)
                etiket_id = kisi_id

                SQL = "select * from ahtapot_ajanda_olay_listesi where etiket_id = '"& etiket_id &"' and IsID = '"& olay("IsID") &"' and ana_kayit_id = '"& olay_id &"' and durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"'"
                set kayitKontrol = baglanti.execute(SQL)
    
                if kayitKontrol.eof then
    response.Write("kayıt kontrol")
                    SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, IsID) values('"& ana_kayit_id &"', '"& kisiler &"', '"& baslangic_saati &"', '"& bitis_saati &"', '" & etiket & "', '" & etiket_id & "', '" & title & "', '" & allDay & "', CONVERT(date, '"& baslangic_tarihi &"', 103), CONVERT(date, '"& bitis_tarihi &"', 103), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', 'true', 'false', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate(), '"& olay("IsID") &"'); SELECT SCOPE_IDENTITY() id;"
                    set ekle = baglanti.execute(SQL)
                end if

                if olay("IsID") > 0 then
                    SQL = "insert into ucgem_is_gorevli_durumlari(gorevli_id, tamamlanma_orani, tamamlanma_tarihi, tamamlanma_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, is_id, toplam_sure, gunluk_sure, toplam_gun) values('"& etiket_id &"', '0', Convert(date, '"& baslangic_tarihi &"', 103), '"& baslangic_saati &"', 'true', 'false', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', GETDATE(), '"& ekleme_saati &"', '"& olay("IsID") &"', (SELECT CONVERT(varchar(5), DATEADD(minute, DATEDIFF(Minute, '"& baslangic_saati &"', '"& bitis_saati &"'), 0), 114)), '', (select DATEDIFF(DAY, CONVERT(date, '"& baslangic_tarihi &"', 103), CONVERT(date, '"& bitis_tarihi &"', 103))))"
                    set isGorevliDurumlari = baglanti.execute(SQL)

                    SQL = "update ucgem_is_listesi set gorevliler = gorevliler + ',"& kisi_id &"' where id = '"& olay("IsID") &"' and firma_id = '"& FirmaID &"'"
                    set isGuncelle = baglanti.execute(SQL)
                end if
            next

            if acikmi = true then
                SQL="update ucgem_is_listesi set baslangic_tarihi = CONVERT(date, '"& olay("baslangic") &"', 103), bitis_tarihi = CONVERT(date, '"& olay("bitis") &"', 103), baslangic_saati = '"& olay("baslangic_saati") &"', bitis_saati = '"& olay("bitis_saati") &"' where id = '"& olay("is_id") &"' and firma_id = '"& FirmaID &"'"
                set guncelle = baglanti.execute(SQL)
            end if
        end if

    elseif trn(request("islem"))="is_listesi_lineer_takvim_getir" then
%>
<div class="card">
    <div class="card-block" style="padding: 0;">
        <div id="visualization" style="display: none;">
            <div class="visualizationmenu" style="display: none;">
                <div class="btn-group " role="group" data-toggle="tooltip" data-placement="top" title="" data-original-title=".btn-xlg">
                    <button type="button" value="250" id="toggleZoomMode" class="btn btn-primary btn-sm waves-effect waves-light"><i class="fa fa-arrows-v"></i></button>
                    <button type="button" id="zoomIn" class="btn btn-primary btn-sm waves-effect waves-light"><i class="fa fa-plus"></i></button>
                    <button type="button" id="zoomOut" class="btn btn-primary btn-sm waves-effect waves-light"><i class="fa fa-minus"></i></button>
                    <button type="button" id="moveLeft" class="btn btn-primary btn-sm waves-effect waves-light" style="font-weight: bold; font-size: 17px;"><</button>
                    <button type="button" id="moveRight" class="btn btn-primary btn-sm waves-effect waves-light" style="font-weight: bold; font-size: 17px;">></button>
                </div>
            </div>
        </div>

        <%
                ay = month(cdate(date))
                gun = day(cdate(date))

                ay1 = month(cdate(date)+60)
                gun1 = day(cdate(date)+60)
                yil1 = year(cdate(date)+60)

                baslangic_tarihi = year(cdate(date)) & "-" & ay & "-" & gun 
                bitis_tarihi = yil1 & "-" & ay1 & "-" & gun1 
        %>
        <script>
            $(function (){
                is_listesi_timeline_calistir('<%=baslangic_tarihi %>', '<%=bitis_tarihi %>');
            })
        </script>
    </div>
</div>
<%
    elseif trn(request("islem"))="ajanda_olay_durum_guncelle" then

        olay_id = trn(request("olay_id"))
        durum = trn(request("durum"))
        color = "rgb(46, 204, 113)"
        SQL="update ahtapot_ajanda_olay_listesi set tamamlandi = '"& durum &"', color = '"& color &"' where id = '"& olay_id &"' and firma_id = '"& FirmaID &"'"
        set guncelle = baglanti.execute(SQL)

        SQL="SELECT gorevli.id, olay.IsID, gorevli.gorevli_id FROM ahtapot_ajanda_olay_listesi olay JOIN dbo.ucgem_is_gorevli_durumlari gorevli ON gorevli.is_id = olay.IsID AND gorevli.gorevli_id = olay.etiket_id AND olay.etiket = 'personel' WHERE olay.id = '"& olay_id &"' and olay.firma_id = '"& FirmaID &"'"
        set olay = baglanti.execute(SQL)

        if not olay.eof then
            SQL = "select * from ucgem_is_calisma_listesi where baslangic IS NOT NULL and bitis IS NULL and is_id = '"& olay("IsID") &"' and ekleyen_id = '"& olay("gorevli_id") &"' and firma_id = '"& FirmaID &"'"
            set calisma_kayit = baglanti.execute(SQL)

            if not calisma_kayit.eof then
                SQL = "update ucgem_is_calisma_listesi set bitis = GETDATE() where baslangic IS NOT NULL and bitis IS NULL and is_id = '"& olay("IsID") &"' and ekleyen_id = '"& olay("gorevli_id") &"' and firma_id = '"& FirmaID &"'"
                set calismaBitir = baglanti.execute(SQL)
            end if
        end if

        if not olay.eof then
%>
<script>
        $(function (){
            manuel_isi_bitir('<%=olay("id") %>', 100, '<%=olay("IsID") %>');
        });
</script>
<%
        end if

    elseif trn(request("islem"))="is_listesi_tarih_saat_update" then

%>
<script language="JScript" runat="server">

    function datetomillis(yil, ay, gun, saat, dakika) {
        var d = new Date(yil, ay, gun, saat, dakika, 0, 0);
        var n = d.getTime();
        return n;
    }

</script>
<%

        id = trn(request("id"))
        baslangic = trn(request("baslangic"))
        bitis = trn(request("bitis"))

        baslangic_tarihi = cdate(left(baslangic,10))
        bitis_tarihi = cdate(left(bitis,10))

        baslangic_saati = right(baslangic,5)
        bitis_saati = right(bitis,5)

        SQL="update ucgem_is_listesi set baslangic_tarihi = '"& baslangic_tarihi &"', bitis_tarihi = '"& bitis_tarihi &"', baslangic_saati = '"& baslangic_saati &"', bitis_saati = '"& bitis_saati &"' where id = '"& id &"' and firma_id = '"& FirmaID &"'"
        set guncelle = baglanti.execute(SQL)

        SQL="select isnull(GantAdimID,0) as GantAdimID from ucgem_is_listesi where id = '"& id &"' and firma_id = '"& FirmaID &"'"
        set iss = baglanti.execute(SQL)

        if cdbl(iss("GantAdimID"))>0 then

            yil = year(cdate(baslangic_tarihi))
            ay = month(cdate(baslangic_tarihi))-1
            gun = day(cdate(baslangic_tarihi))
            saat = cint(left(baslangic_saati,2))
            dakika = cint(right(baslangic_saati,2))

            start_uygulama = datetomillis(yil, ay, gun, 0, 0)

            yil = year(cdate(bitis_tarihi))
            ay = month(cdate(bitis_tarihi))-1
            gun = day(cdate(bitis_tarihi))
            saat = cint(left(bitis_saati,2))
            dakika = cint(right(bitis_saati,2))

            iend_uygulama = datetomillis(yil, ay, gun, 0, 0)

            start_tarih_uygulama = cdate(baslangic_tarihi)
            end_tarih_uygulama = cdate(bitis_tarihi)
            duration_uygulama = cdate(bitis_tarihi) - cdate(baslangic_tarihi)-1

            SQL="update ahtapot_proje_gantt_adimlari set start_uygulama = '"& start_uygulama &"', iend_uygulama = '"& iend_uygulama &"', start_tarih_uygulama = '"& start_tarih_uygulama &"', end_tarih_uygulama = '"& end_tarih_uygulama &"', duration_uygulama = '"& duration_uygulama &"' where id = '"& iss("GantAdimID") &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)

        end if

    elseif trn(request("islem"))="proje_planlama_getir" then

        proje_id = trn(request("proje_id"))
        tip = trn(request("tip"))
%>
<input type="hidden" name="cikma_kontrol" id="cikma_kontrol" value="true" />
<div class="card">
    <div class="card-block">
        <div class="view-info">
            <div class="row">

                <div class="col-lg-12" id="planlama_body">
                    <script>
                        $(function (){
                            $("#planframe").css("height", parseInt(window.height)-500);
                        });
                    </script>
                    <iframe id="planframe" src="/system_root/santiyeler/planlama_frame.asp?jsid=4559&proje_id=<%=proje_id %>&tip=<%=tip %>" style="width: 100%; height: 1050px; overflow: scroll; border: none;"></iframe>
                </div>
            </div>
        </div>
    </div>
</div>


<%
    elseif trn(request("islem"))="santiye_adam_saat_getir" then

        proje_id = trn(request("proje_id"))

        SQL="SELECT ekleme_tarihi as baslangic, CASE WHEN DATEADD(DAY, 180, ekleme_tarihi) < GETDATE() THEN DATEADD(DAY, 30 , GETDATE()) ELSE DATEADD(DAY, 180, ekleme_tarihi) END as bitis FROM dbo.ucgem_proje_listesi WHERE id = '"& proje_id &"' and firma_id = '"& FirmaID &"'"
        set tarihcek = baglanti.execute(SQL)
       
%>
<script>
    $(function (){
        $("#adamsaatframe").css("height", parseInt(window.height)-500);
    });
</script>

<div class="card">

    <div class="card-block">
        <div class="view-info">
            <div class="row">
                <div class="col-lg-12">
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

                    <%
                        dongu_baslangic = cdate(tarihcek("baslangic"))
                        dongu_bitis = cdate(tarihcek("bitis"))                        
                    %>
                    <div class="h5" style="font-size: 15px;"><%=LNG("Adam-Saat Cetveli")%></div>

                    <div class="tablediv" style="width: 100%; margin-top: 15px; overflow: auto;">
                        <div id="tablediv">
                            <table id="tablegosterge" style="border-color: #e8e8e8; font-family: Tahoma;">
                                <thead id="thead">
                                    <tr>
                                        <th rowspan="2" class="ilkth headcol">
                                            <div style="width: 150px;"><%=LNG("Kaynaklar")%></div>
                                        </th>
                                        <th rowspan="2" class="ilkth headcol ">
                                            <div style="width: 80px; text-align: center; margin-left: auto; margin-right: auto;">
                                                <%=LNG("Saat")%>
                                            </div>
                                        </th>
                                        <th rowspan="2" class="ilkth headcol ">
                                            <div style="width: 80px; text-align: center; margin-left: auto; margin-right: auto;">
                                                <%=LNG("Maliyet")%>
                                            </div>
                                        </th>
                                        <% 
                                            son_ay = 0
                                            for x = dongu_baslangic to dongu_bitis 
                                                if not son_ay = month(x) then
                                                    son_ay = month(x)

                                                    cols = AyinSonGunu(cdate(x)) - day(cdate(x))

                                                    if cdate( AyinSonGunu(cdate(x)) & "." & month(cdate(x)) & "." & year(cdate(x))) > dongu_bitis then
                                                        cols = day(dongu_bitis)
                                                    end if

                                                    cols = cols + 1
                                        %>
                                        <th class="ust_th" colspan="<%=cols %>"><%=monthname(son_ay) %>&nbsp;<%=year(x) %></th>
                                        <% 
                                                end if
                                            next
                                        %>
                                    </tr>
                                    <tr>
                                        <% for x = dongu_baslangic to dongu_bitis  %>
                                        <th class="alt_th" style="<% if day(x)=1 then %> border-left: solid 3px white; <% end if %>">
                                            <div class="guncizelge"><%=day(x) %></div>
                                        </th>
                                        <% next %>
                                    </tr>
                                </thead>
                                <tbody id="tbody">

                                    <%
                                        SQL="EXEC dbo.ProjeAdamSaatCetveli @proje_id = '"& proje_id &"', @firma_id = '"& Request.Cookies("kullanici")("firma_id") &"', @baslangic = '"& dongu_baslangic &"', @bitis = '"& dongu_bitis &"';"
                                        set cetvel = baglanti.execute(sql)
                                        response.Write(SQL)

                                        tarih_sayi = cdate(dongu_bitis) - cdate(dongu_baslangic) + 1

                                        Dim gun_toplam()
                                        Redim gun_toplam(tarih_sayi)
                                        k = 0
                                        son_kaynak = ""
                                        do while not cetvel.eof 
                                            girdimi = false
                                            if not sonkaynak = cetvel("tip") & cetvel("id") then
                                                sonkaynak = cetvel("tip") & cetvel("id")
                                                girdimi = true
                                                k = k + 1
                                                klas = ""
                                                if k mod 2 = 0 then
                                                    klas = "ikincisi"
                                                end if
                                                
                                                gunsayi = 0

                                                if k > 1 then
                                    %>
                                        </tr>
                                        <% end if %>
                                    <tr class=" ustunegelince <%=klas %>">
                                        <%
                                                toplam_saat = cdbl(toplam_saat) + cdbl(cetvel("kaynak_toplam_saat"))
                                                toplam_tutar = cdbl(toplam_tutar) + cdbl(cetvel("kaynak_toplam_maliyet"))
                                        %>
                                        <td style="width: 150px;" class="ust_td2 headcol"><%=cetvel("kaynak") %></td>
                                        <td class="gosterge_td alt_td "><%=DakikadanSaatYap(cetvel("kaynak_toplam_saat")) %></td>
                                        <td class=" gosterge_td alt_td sagcizgi"><%=cetvel("kaynak_toplam_maliyet") %> TL</td>
                                        <% end if %>
                                        <td class="alt_td <% if day(cetvel("tarih"))=1 then %> alt_td2 <% end if %> <% if cdate(cetvel("tarih"))=cdate(date) then %> sarialan <% end if %> "><% if cdbl(cetvel("maliyet_tutari"))=0 then %>-<% else %><%=cetvel("saat") %><br />
                                            <%=cetvel("maliyet_tutari") %> TL<% end if %></td>
                                        <%  
                                                gun_toplam(gunsayi) = cdbl(gun_toplam(gunsayi)) + cdbl(cetvel("maliyet_tutari"))
                                                gunsayi = gunsayi + 1

                                            cetvel.movenext
                                            loop
                                        %>
                                    </tr>
                                    <tr>
                                        <td class="ust_td2 headcol" style="width: 150px; background-color: #4d7193; color: white!important;"><%=LNG("TOPLAM")%></td>
                                        <td class="gosterge_td alt_td "><%=DakikadanSaatYap(toplam_saat) %></td>
                                        <td class=" gosterge_td alt_td sagcizgi"><%=toplam_tutar %> TL</td>
                                        <% for x = 0 to ubound(gun_toplam)-2 %>
                                        <td class="alt_td" style="background-color: #4d7193; color: white;"><%=gun_toplam(x) %>TL</td>
                                        <% next %>
                                    </tr>
                                    <%
                                        Erase gun_toplam
                                    %>

                                    <!--                                    <%
            SQL="SELECT id, kaynak, tip FROM dbo.gantt_kaynaklar WHERE firma_id = '"& Request.Cookies("kullanici")("firma_id") &"';"
            set kaynak = baglanti.execute(SQL)
                k = 0
            do while not kaynak.eof

                
                k = k + 1
                klas = ""
                if k mod 2 = 0 then
                    klas = "ikincisi"
                end if
                                    %>
                                    <tr class=" ustunegelince <%=klas %>">
                                        <td style="width: 150px;" class="ust_td headcol"><%=kaynak("kaynak") %></td>
                                        <% for x = dongu_baslangic to dongu_bitis %>
                                        <td class="alt_td <% if day(x)=1 then %> alt_td2 <% end if %> <% if cdate(baslangic)<=cdate(x) and cdate(bitis)>=cdate(x) then %> sarialan <% end if %> ">0 TL</td>
                                        <% next %>
                                    </tr>
                                    <%
            kaynak.movenext
            loop
                                    %>-->


                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!--                    <iframe id="adamsaatframe" src="/system_root/santiyeler/adamsaat_frame.asp" style="width: 100%; height: 1050px; overflow: scroll; border: none;"></iframe>-->
                </div>
            </div>
        </div>
    </div>
</div>
<%
    elseif trn(request("islem"))="proje_cari_getir" then

        cari_id = trn(request("proje_id"))
        tip = "proje"


%>
<div id="tabela_yeri" class="row">
    <script>
            $(function (){
                cari_detay_tabela_getir('<%=cari_id %>', '<%=tip %>');
            });
    </script>
</div>
<div class="card">
    <div class="card-header">
        <h5 style="font-size: 20px;"><%=LNG("Cari İşlemler Dökümü")%></h5>
        <div class="col">
            <div class="page-header-breadcrumb" style="margin-top: -35px;">
                <ul class="breadcrumb-title">
                    <li class="breadcrumb-item"><a href="javascript:void(0);" onclick="cari_hareket_tahsilat_ekle('<%=cari_id %>', '<%=tip %>', 'icerden');" class="btn btn-success btn-round" style="color: white;"><i class="fa fa-money"></i>&nbsp;<%=LNG("Tahsilat Ekle")%></a>
                    </li>
                    <li class="breadcrumb-item"><a href="javascript:void(0);" onclick="cari_hareket_odeme_ekle('<%=cari_id %>', '<%=tip %>', 'icerden');" class="btn btn-danger btn-round" style="color: white;"><i class="fa fa-paper-plane-o"></i>&nbsp;<%=LNG("Ödeme Ekle")%></a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <div id="cari_hareket_listesi" class="card-block">
        <script>
            $(function (){
                cari_hareket_listesi_getir('<%=cari_id %>', '<%=tip %>', 'icerden');
            });
        </script>
    </div>
</div>
<%
    elseif trn(request("islem"))="proje_ajanda_getir" then

        proje_id = trn(request("proje_id"))
%>
<div class="row">
    <div class="col-lg-12">
        <div id="takvim_yeri">
            <%
                etiket = "proje"
                etiket_id = proje_id
            %>
            <script>
                $(document).ready(function() {
                    yeni_ajanda_calistir('<%=etiket %>', '<%=etiket_id %>');
                });
            </script>
        </div>
    </div>
</div>

<%
    elseif trn(request("islem"))="proje_satinalma_getir" then

        proje_id = trn(request("proje_id"))

%>
<style type="text/css">
    .border-bottom {
        border-bottom: 1px solid #eee !important;
    }
</style>
<div class="card">
    <div class="card-header p-3 border-bottom">
        <h6 class="card-title">Proje Maliyet</h6>
    </div>
    <div class="card-body p-3">
        <div class="row">
            <div id="proje_butce_yeri" class="col-lg-6">
                <script type="text/javascript">
                    $(function () {
                        proje_butce_listesi_getir('<%=proje_id %>');
                    });
                </script>
            </div>
            <div id="proje_gider_yeri" class="col-lg-6">
            </div>
            <hr class="col-lg-12 pl-5 pr-5" />
            <div id="proje_gelir_yer" class="col-lg-12">
                <script type="text/javascript">
                    $(function () {
                        proje_gelir_cek('<%=proje_id %>');
                    });
                </script>
            </div>
        </div>
    </div>
</div>
<%
    elseif trn(request("islem"))="proje_gelir_getir" then

        proje_id = trn(request("proje_id"))

%>
<div class="col-md-12 p-0 pt-2 pb-2 mb-2 d-none">
    <h6 class="d-inline-block mb-0"><i class="fa fa-arrow-right mr-1"></i>Proje Gelirleri</h6>
    <button type="button" onclick="proje_gelir_ekle('<%=proje_id %>');" class="btn btn-round btn-mini btn-success waves-effect waves-light f-right">
        <i class="icofont icofont-edit"></i><%=LNG("Gelir Ekle")%>
    </button>
</div>
<div id="proje_gelir_listesi">
    <script>
                            $(function (){
                                proje_gelir_getir2('<%=proje_id %>');
                            });
    </script>

</div>
<%
     elseif trn(request("islem"))="proje_butce_listesi_getir" then

        proje_id = trn(request("proje_id"))

        if trn(request("islem2"))="ekle" then

            butce_hesabi_adi = trn(request("butce_hesabi_adi"))
            ongorulen_tutar = trn(request("ongorulen_tutar"))
            parabirimi = trn(request("parabirimi"))
            tarih = trn(request("tarih"))

            durum = "true"
            cop = "false"
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleme_tarihi = date
            ekleme_saati = time
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")

            ongorulen_tutar = NoktalamaDegis(ongorulen_tutar)

            SQL="insert into ahtapot_proje_butce_listesi(proje_id, butce_hesabi_adi, ongorulen_tutar, tarih, parabirimi, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', '"& butce_hesabi_adi &"', '"& ongorulen_tutar &"', '"& tarih &"', '"& parabirimi &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"');"
            set ekle = baglanti.execute(SQL)

            SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& proje_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)


            ' Olay Ekle
            proje_id = proje_id
            olay = "Yeni Bütçe Hesabı Eklendi. Bütçe Hesabı : " & butce_hesabi_adi
            olay_tarihi = cdate(date)
            olay_saati = time
            departman_id = 0
            durum = "true"
            cop = "false"
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time

            SQL="insert into ucgem_proje_olay_listesi(proje_id, olay, olay_tarihi, olay_saati, departman_id, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', '"& olay &"', CONVERT(date, '"& olay_tarihi &"', 103), '"& olay_saati &"', '"& departman_id &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
            set olay_ekle = baglanti.execute(SQL)


        elseif trn(request("islem2"))="sil" then

            kayit_id = trn(request("kayit_id"))

            SQL="update ahtapot_proje_butce_listesi set cop = 'true', silen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"', silen_tarihi = getdate(), silen_saati = getdate() where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set sil = baglanti.execute(SQL)

            SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& proje_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)


            SQL="select * from ahtapot_proje_butce_listesi where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set butcecek = baglanti.execute(SQL)

            ' Olay Ekle
            proje_id = proje_id
            olay = "Bütçe Hesabı Silindi. Bütçe Hesabı : " & butcecek("butce_hesabi_adi")
            olay_tarihi = cdate(date)
            olay_saati = time
            departman_id = 0
            durum = "true"
            cop = "false"
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time

            SQL="insert into ucgem_proje_olay_listesi(proje_id, olay, olay_tarihi, olay_saati, departman_id, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', '"& olay &"', CONVERT(date, '"& olay_tarihi &"', 103), '"& olay_saati &"', '"& departman_id &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
            set olay_ekle = baglanti.execute(SQL)

        elseif trn(request("islem2"))="guncelle" then

            kayit_id = trn(request("kayit_id"))
            butce_hesabi_adi = trn(request("butce_hesabi_adi"))
            ongorulen_tutar = trn(request("ongorulen_tutar"))
            parabirimi = trn(request("parabirimi"))
            tarih = trn(request("tarih"))

            ongorulen_tutar = NoktalamaDegis(ongorulen_tutar)

            SQL="update ahtapot_proje_butce_listesi set butce_hesabi_adi = '"& butce_hesabi_adi &"', ongorulen_tutar = '"& ongorulen_tutar &"', parabirimi = '"& parabirimi &"', tarih = '"& tarih &"' where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)

            SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& proje_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)


            ' Olay Ekle
            proje_id = proje_id
            olay = "Bütçe Hesabı Güncellendi. Bütçe Hesabı : " & butce_hesabi_adi
            olay_tarihi = cdate(date)
            olay_saati = time
            departman_id = 0
            durum = "true"
            cop = "false"
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time

            SQL="insert into ucgem_proje_olay_listesi(proje_id, olay, olay_tarihi, olay_saati, departman_id, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', '"& olay &"', Convert(date, '"& olay_tarihi &"', 103), '"& olay_saati &"', '"& departman_id &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', Convert(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
            set olay_ekle = baglanti.execute(SQL)


        elseif trn(request("islem2"))="satinalmaekle" then

            satinalma_adi = trn(request("satinalma_adi"))
            butce_hesabi = trn(request("butce_hesabi"))
            satinalma_durum = trn(request("satinalma_durum"))
            ongorulen_tutar = trn(request("ongorulen_tutar"))
            ongorulen_pb = trn(request("ongorulen_pb"))
            gerceklesen_tutar = trn(request("gerceklesen_tutar"))
            gerceklesen_pb = trn(request("gerceklesen_pb"))
            odeme_tarihi = trn(request("odeme_tarihi"))
            tedarikci_id = trn(request("tedarikci_id"))
            satinalma_aciklama = trn(request("satinalma_aciklama"))
            tarih = trn(request("tarih"))

            durum = "true"
            cop = "false"
            firma_kodu = Request.Cookies("v1cnt")("firma_kodu")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleme_tarihi = date
            ekleme_saati = time

            ongorulen_tutar = NoktalamaDegis(ongorulen_tutar)
            gerceklesen_tutar = NoktalamaDegis(gerceklesen_tutar)

            SQL="insert into ahtapot_proje_satinalma_listesi(aciklama, odeme_tarihi, tedarikci_id, proje_id, satinalma_adi, butce_hesabi, satinalma_durum, ongorulen_tutar, tarih, ongorulen_pb, gerceklesen_tutar, gerceklesen_pb, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& satinalma_aciklama &"', '"& odeme_tarihi &"', '"& tedarikci_id &"', '"& proje_id &"', '"& satinalma_adi &"', '"& butce_hesabi &"', '"& satinalma_durum &"', '"& ongorulen_tutar &"', '"& tarih &"', '"& ongorulen_pb &"', '"& gerceklesen_tutar &"', '"& gerceklesen_pb &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
            set ekle = baglanti.execute(SQL)

            SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& proje_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)


            ' Olay Ekle
            proje_id = proje_id
            olay = "Satınalma Kaydı Eklendi. Satınalma Adı : " & satinalma_adi
            olay_tarihi = cdate(date)
            olay_saati = time
            departman_id = 0
            durum = "true"
            cop = "false"
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time

            SQL="insert into ucgem_proje_olay_listesi(proje_id, olay, olay_tarihi, olay_saati, departman_id, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', '"& olay &"', CONVERT(date, '"& olay_tarihi &"', 103), '"& olay_saati &"', '"& departman_id &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
            set olay_ekle = baglanti.execute(SQL)


        elseif trn(request("islem2"))="satinalmaguncelle" then

            kayit_id = trn(request("kayit_id"))
            satinalma_adi = trn(request("satinalma_adi"))
            butce_hesabi = trn(request("butce_hesabi"))
            satinalma_durum = trn(request("satinalma_durum"))
            ongorulen_tutar = trn(request("ongorulen_tutar"))
            ongorulen_pb = trn(request("ongorulen_pb"))
            gerceklesen_tutar = trn(request("gerceklesen_tutar"))
            gerceklesen_pb = trn(request("gerceklesen_pb"))
            satinalma_aciklama = trn(request("satinalma_aciklama"))
            tarih = trn(request("tarih"))
            odeme_tarihi = trn(request("odeme_tarihi"))


            ongorulen_tutar = NoktalamaDegis(ongorulen_tutar)
            gerceklesen_tutar = NoktalamaDegis(gerceklesen_tutar)

            SQL="update ahtapot_proje_satinalma_listesi set aciklama = '"& satinalma_aciklama &"', satinalma_adi = '"& satinalma_adi &"', butce_hesabi = '"& butce_hesabi &"', satinalma_durum = '"& satinalma_durum &"', ongorulen_tutar = '"& ongorulen_tutar &"', ongorulen_pb = '"& ongorulen_pb &"', gerceklesen_tutar = '"& gerceklesen_tutar &"', gerceklesen_pb = '"& gerceklesen_pb &"', tarih = '"& tarih &"', odeme_tarihi = '"& odeme_tarihi &"' where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)

            SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& proje_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)


            ' Olay Ekle
            proje_id = proje_id
            olay = "Satınalma Kaydı Güncellendi. Satınalma Adı : " & satinalma_adi
            olay_tarihi = cdate(date)
            olay_saati = time
            departman_id = 0
            durum = "true"
            cop = "false"
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time

            SQL="insert into ucgem_proje_olay_listesi(proje_id, olay, olay_tarihi, olay_saati, departman_id, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', '"& olay &"', CONVERT(date, '"& olay_tarihi &"', 103), '"& olay_saati &"', '"& departman_id &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
            set olay_ekle = baglanti.execute(SQL)

        elseif trn(request("islem2"))="satinalmasil" then

            satis_id = trn(request("satis_id"))

            SQL="update ahtapot_proje_satinalma_listesi set cop = 'true' where id = '"& satis_id &"' and firma_id = '"& Request.Cookies("kullanici")("firma_id") &"'"
            set guncelle = baglanti.execute(SQL)

            SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& proje_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)

            SQL="select * from ahtapot_proje_satinalma_listesi where id = '"& satis_id &"' and firma_id = '"& FirmaID &"'"
            set satinalmacek = baglanti.execute(SQL)

            ' Olay Ekle
            proje_id = proje_id
            olay = "Satınalma Kaydı Silindi. Satınalma Adı : " & satinalmacek("satinalma_adi")
            olay_tarihi = cdate(date)
            olay_saati = time
            departman_id = 0
            durum = "true"
            cop = "false"
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time

            SQL="insert into ucgem_proje_olay_listesi(proje_id, olay, olay_tarihi, olay_saati, departman_id, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', '"& olay &"', CONVERT(date, '"& olay_tarihi &"', 103), '"& olay_saati &"', '"& departman_id &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
            set olay_ekle = baglanti.execute(SQL)
        end if
%>
<style type="text/css">
    .border {
        border: 1px solid #ccc !important;
    }

    .border-bottom-0 {
        border-bottom: none !important;
    }

    .border-top-0 {
        border-top: none !important;
    }

    .display-inline-block {
        display: inline-block !important;
    }

    .f-13 {
        font-size: 13px;
    }

    .w-auto {
        width: auto;
    }
</style>
<div class="col-md-12 p-0 pt-2 pb-2 mb-2">
    <h6 class="display-inline-block mb-0"><i class="fa fa-arrow-right mr-1"></i>Bütçe Hesapları</h6>
    <button type="button" onclick="proje_butce_hesabi_ekle('<%=proje_id %>');" class="btn btn-mini btn-success waves-effect waves-light f-right btn-round">
        <i class="icofont icofont-edit"></i><%=LNG("Bütçe Hesabı Ekle")%>
    </button>
</div>
<%
             SQL="SELECT ISNULL((SELECT SUM(satinalma.gerceklesen_tutar) FROM ahtapot_proje_satinalma_listesi satinalma WHERE satinalma.proje_id = butce.proje_id and butce.id = satinalma.butce_hesabi AND satinalma.cop = 'false' AND gerceklesen_pb = 'TL'),0) AS gerceklesen_tl, ISNULL((SELECT SUM(satinalma.gerceklesen_tutar) FROM ahtapot_proje_satinalma_listesi satinalma WHERE satinalma.proje_id = butce.proje_id and butce.id = satinalma.butce_hesabi AND satinalma.cop = 'false' AND gerceklesen_pb = 'USD'),0) AS gerceklesen_usd, ISNULL((SELECT SUM(satinalma.gerceklesen_tutar) FROM ahtapot_proje_satinalma_listesi satinalma WHERE satinalma.proje_id = butce.proje_id and butce.id = satinalma.butce_hesabi AND satinalma.cop = 'false' AND gerceklesen_pb = 'EUR'),0) AS gerceklesen_eur, * FROM ahtapot_proje_butce_listesi butce WHERE butce.proje_id = '"& proje_id &"' AND butce.cop = 'false';"
             set butce = baglanti.execute(SQL)
%>
<div class="dt-responsive table-responsive">
    <table class="datatableyap text-nowrap mb-0 <% if butce.eof then %>kayityok<% end if %> table table-bordered" width="100%">
        <thead>
            <tr>
                <th><%=LNG("Bütçe Hesap Adı")%></th>
                <th style="text-align: center;"><%=LNG("Öngörülen / Kalan")%></th>
                <th style="text-align: center;"><%=LNG("Gerçek")%></th>
                <th style="text-align: center;"><%=LNG("Durum")%></th>
                <th style="width: 10px;">İşlem</th>
            </tr>
        </thead>
        <tbody>

            <%
                
                        if butce.eof then
            %>
            <tr>
                <td colspan="5" style="text-align: center;"><%=LNG("Kayıt Yok")%></td>
            </tr>
            <%
                        end if

                        totalTL = 0
                        totalUSD = 0
                        totalEUR = 0

                        remainingTL = 0
                        remainingUSD = 0
                        remainingEUR = 0

                        do while not butce.eof

                            kalan_tutar = (cdbl(butce("ongorulen_tutar"))) - (cdbl(butce("gerceklesen_tl"))) + (cdbl(butce("gerceklesen_usd"))) + (cdbl(butce("gerceklesen_eur")))

                            kalan_tutar2 = cdbl(butce("ongorulen_tutar")) - cdbl(kalan_tutar)
                            hesap = cint(100-(((cdbl(butce("ongorulen_tutar")) - cdbl(kalan_tutar2)) / cdbl(butce("ongorulen_tutar"))) * 100))

                            if Cstr(butce("parabirimi")) = "TL" then
                                totalTL = totalTL + cdbl(butce("ongorulen_tutar"))
                                remainingTL = remainingTL + cdbl(butce("ongorulen_tutar")) - cdbl(butce("gerceklesen_tl"))
                            elseif butce("parabirimi") = "USD" then
                                totalUSD = totalUSD + cdbl(butce("ongorulen_tutar"))
                                remainingUSD = remainingUSD + cdbl(butce("ongorulen_tutar")) - cdbl(butce("gerceklesen_usd"))
                            elseif butce("parabirimi") = "EUR" then
                                totalEUR = totalEUR + cdbl(butce("ongorulen_tutar"))
                                remainingEUR = remainingEUR + cdbl(butce("ongorulen_tutar")) - cdbl(butce("gerceklesen_eur"))
                            end if

            %>
            <tr>
                <td><%=butce("butce_hesabi_adi") %></td>
                <td style="text-align: center;">
                    <label class="label label-primary" style="font-size: 12px;"><%=FormatNumber(butce("ongorulen_tutar"),2) %>&nbsp;<%=butce("parabirimi") %></label>
                    <br />
                    <label class="label label-danger" style="font-size: 12px;"><%=FormatNumber(kalan_tutar,2) %>&nbsp;<%=butce("parabirimi") %></label>
                </td>
                <td style="text-align: center; line-height: 5px;">
                    <label class="label label-warning mb-1" style="font-size: 12px;"><%=FormatNumber(butce("gerceklesen_tl"),2) %>&nbsp;TL</label>
                    <label class="label label-info mb-1" style="font-size: 12px;"><%=FormatNumber(butce("gerceklesen_usd"),2) %>&nbsp;USD</label>
                    <label class="label label-success" style="font-size: 12px;"><%=FormatNumber(butce("gerceklesen_eur"),2) %>&nbsp;EUR</label>
                </td>
                <td>
                    <div>
                        <div id="is_chart1" class="progress progress-xs" data-progressbar-value="<%=hesap %>">
                            <div class="progress-bar"></div>
                        </div>
                        <span class="hiddenspan"><%=hesap %></span>
                    </div>
                </td>
                <td class="dropdown text-center" style="width: 10px;">
                    <button type="button" class="btn btn-mini btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-cog" aria-hidden="true"></i></button>
                    <div class="dropdown-menu dropdown-menu-right b-none contact-menu">
                        <a class="dropdown-item" href="javascript:void(0);" onclick="proje_butce_duzenle('<%=proje_id %>','<%=butce("id") %>');"><i class="icofont icofont-edit"></i><%=LNG("Düzenle")%></a>
                        <a class="dropdown-item" href="javascript:void(0);" onclick="proje_butce_sil('<%=proje_id %>','<%=butce("id") %>');"><i class="icofont icofont-ui-delete"></i><%=LNG("Sil")%></a>
                    </div>
                </td>
            </tr>
            <%
                        butce.movenext
                        loop
            %>
        </tbody>
        <tfoot>
            <tr>
                <td></td>
                <td>
                    <span class="mr-1 font-weight-bold">Öngörülen :</span>
                    <label class="label label-primary display-inline-block f-13 w-auto"><%=FormatNumber(totalTL, 2) %> ₺</label>
                    <label class="label label-primary display-inline-block f-13 w-auto"><%=FormatNumber(totalUSD, 2) %> $</label>
                    <label class="label label-primary display-inline-block f-13 w-auto"><%=FormatNumber(totalEUR, 2) %> €</label>
                    <hr class="m-0 mt-1 mb-1"/>
                    <span class="mr-1 font-weight-bold">Kalan :</span>
                    <label class="label label-danger display-inline-block f-13 w-auto"><%=FormatNumber(remainingTL, 2) %> ₺</label>
                    <label class="label label-danger display-inline-block f-13 w-auto"><%=FormatNumber(remainingUSD, 2) %> $</label>
                    <label class="label label-danger display-inline-block f-13 w-auto"><%=FormatNumber(remainingEUR, 2) %> €</label>
                </td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
        </tfoot>
    </table>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $(".dt-toolbar").addClass("pr-1 pt-1 pb-1 border border-bottom-0");
        $(".dt-toolbar-footer").addClass("border-top-0");
    });
</script>
<%
    elseif trn(request("islem")) = "ProjeGiderleri" then
        projeID = trn(request("projeID"))
%>
<style type="text/css">
    .border {
        border: 1px solid #ccc !important;
    }

    .border-bottom-0 {
        border-bottom: none !important;
    }

    .display-inline-block {
        display: inline-block !important;
    }

    .border-top-0 {
        border-top: none !important;
    }
</style>
<div class="col-md-12 p-0 pt-2 pb-2 mb-2">
    <h6 class="display-inline-block mb-0"><i class="fa fa-arrow-right mr-1"></i>Proje Giderleri</h6>
    <button type="button" onclick="yeni_satinalma_kaydi_ekle('<%=projeID %>');" class="btn btn-mini btn-success waves-effect waves-light f-right btn-round">
        <i class="icofont icofont-edit"></i>
        Yeni Satın Alma Ekle
    </button>
</div>
<%
            SQL="select butce.butce_hesabi_adi, satinalma.* from ahtapot_proje_satinalma_listesi satinalma join ahtapot_proje_butce_listesi butce on butce.id = satinalma.butce_hesabi where satinalma.proje_id = '"& projeID &"' and satinalma.cop = 'false'"
            set satis = baglanti.execute(SQL)
    
%>
<div class="dt-responsive table-responsive">
    <table class="datatableyap mb-0 <% if satis.eof then %>kayityok<% end if %> table table-bordered text-nowrap" width="100%">
        <thead>
            <tr>
                <th><%=LNG("Satınalma Adı")%></th>
                <th><%=LNG("Bütçe Hesabı")%></th>
                <th style="width: 120px;"><%=LNG("Durum")%></th>
                <th style="text-align: center;"><%=LNG("Öngörülen")%></th>
                <th style="text-align: center;"><%=LNG("Gerçek")%></th>
                <th style="width: 10px;"></th>
            </tr>
        </thead>
        <tbody>
            <%
                            if satis.eof then

                            ongorulenTL = 0
                            ongorulenUSD = 0
                            ongorulenEUR = 0

                            gercekTL = 0
                            gercekUSD = 0
                            gercekEUR = 0
            %>
            <tr>
                <td colspan="6" style="text-align: center;"><%=LNG("Kayıt Yok")%></td>
            </tr>
            <%
                            end if
                            do while not satis.eof
                            
                                if satis("ongorulen_pb") = "TL" then
                                    ongorulenTL = ongorulenTL + cdbl(satis("ongorulen_tutar"))
                                elseif satis("ongorulen_pb") = "USD" then
                                    ongorulenUSD = ongorulenUSD + cdbl(satis("ongorulen_tutar"))
                                elseif satis("ongorulen_pb") = "EUR" then
                                    ongorulenEUR = ongorulenEUR + cdbl(satis("ongorulen_tutar"))
                                end if

                                if satis("gerceklesen_pb") = "TL" then
                                    gercekTL = gercekTL + cdbl(satis("gerceklesen_tutar"))
                                elseif satis("gerceklesen_pb") = "USD" then
                                    gercekUSD = gercekUSD + cdbl(satis("gerceklesen_tutar"))
                                elseif satis("gerceklesen_pb") = "EUR" then
                                    gercekEUR = gercekEUR + cdbl(satis("gerceklesen_tutar"))
                                end if
            %>
            <tr>
                <td><%=satis("satinalma_adi") %></td>
                <td><%=satis("butce_hesabi_adi") %></td>
                <td style="width: 120px;">
                    <% if trim(satis("satinalma_durum"))="Planlandi" then %>
                    <span class="label label-primary text-center" style="font-size: 11px;"><%=LNG("PLANLANDI")%></span>
                    <% elseif trim(satis("satinalma_durum"))="Siparis Verildi" then %>
                    <span class="label label-warning text-center" style="font-size: 11px;"><%=LNG("SİPARİŞ VERİLDİ")%></span>
                    <% elseif trim(satis("satinalma_durum"))="Ödendi" then %>
                    <span class="label label-success text-center" style="font-size: 11px;"><%=LNG("ÖDENDİ")%></span>
                    <% end if %>
                </td>
                <td style="text-align: center;"><%=formatnumber(satis("ongorulen_tutar"),2) %>&nbsp;<%=satis("ongorulen_pb") %></td>
                <td class="text-center text-danger font-weight-bold"><%=formatnumber(satis("gerceklesen_tutar"),2) %>&nbsp;<%=satis("gerceklesen_pb") %></td>
                <td class="dropdown">
                    <button type="button" class="btn btn-primary btn-mini dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-cog" aria-hidden="true"></i></button>
                    <div class="dropdown-menu dropdown-menu-right b-none contact-menu">
                        <a class="dropdown-item" href="javascript:void(0);" onclick="proje_satinalma_kayit_duzenle('<%=projeID %>', '<%=satis("id") %>');"><i class="icofont icofont-edit"></i><%=LNG("Düzenle")%></a>
                        <a class="dropdown-item" href="javascript:void(0);" onclick="proje_satinalma_kayit_sil('<%=projeID %>', '<%=satis("id") %>');"><i class="icofont icofont-ui-delete"></i><%=LNG("Sil")%></a>
                    </div>
                </td>
            </tr>
            <%
                            satis.movenext
                            loop
            %>
        </tbody>
        <tfoot>
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td class="text-center">
                    <label class="label label-primary mb-1 f-13 w-auto"><%=FormatNumber(ongorulenTL, 2) %> ₺</label>
                    <label class="label label-primary mb-1 f-13 w-auto"><%=FormatNumber(ongorulenUSD, 2) %> $</label>
                    <label class="label label-primary f-13 w-auto"><%=FormatNumber(ongorulenEUR, 2) %> €</label>
                </td>
                <td class="text-center">
                    <label class="label label-primary mb-1 f-13 w-auto"><%=FormatNumber(gercekTL, 2) %> ₺</label>
                    <label class="label label-primary mb-1 f-13 w-auto"><%=FormatNumber(gercekUSD, 2) %> $</label>
                    <label class="label label-primary f-13 w-auto"><%=FormatNumber(gercekEUR, 2) %> €</label>
                </td>
                <td></td>
            </tr>
        </tfoot>
    </table>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $(".dt-toolbar").addClass("pr-1 pt-1 pb-1 border border-bottom-0");
        $(".dt-toolbar-footer").addClass("border-top-0");
    });
</script>

<script>
        $(function () {


            setTimeout(function () {

    
    if ($('#new-cons2:not(.kayityok)').length>0) {
                     var newcs2 = $('#new-cons2:not(.kayityok)').DataTable();
            new $.fn.dataTable.Responsive(newcs2);
      }

    if ($('#new-cons:not(.kayityok)').length>0) {
                    var newcs = $('#new-cons:not(.kayityok)').DataTable();
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

<%
    elseif trn(request("islem")) = "ProjeGiderleriForm" then
%>
<div class="col-lg-12 col-xl-12 d-none">
    <h5 style="font-size: 15px; line-height: 35px;"><%=LNG("Proje Giderleri")%>
        <button id="edit-btn" style="margin-top: -5px; display: none" type="button" onclick="yeni_satinalma_kaydi_ekle('<%=proje_id %>');" class="btn btn-mini btn-success waves-effect waves-light f-right btn-round"><i class="icofont icofont-edit"></i><%=LNG("Yeni Satın Alma Ekle")%></button></h5>
    <div>
        <%
                    SQL="select id, IsId, sum(toplamtl) as toplamTL, sum(toplamusd) as toplamUSD, sum(toplameur) as toplamEUR from satinalma_listesi where proje_id = '"& proje_id &"' and durum != 'Iptal Edildi' and firma_id = '"& FirmaID &"' and cop = 'false' group by id, IsId"
                    set satinalmaformu = baglanti.execute(SQL)

                    SQL="select id, IsId, sum(toplamtl) as toplamTL, sum(toplamusd) as toplamUSD, sum(toplameur) as toplamEUR from satinalma_listesi where proje_id = '"& proje_id &"' and durum != 'Iptal Edildi' and firma_id = '"& FirmaID &"' and cop = 'false' group by id, IsId"
                    set satinalmaformu2 = baglanti.execute(SQL)

                    SQL = "DECLARE @id int; set @id='"& proje_id &"'; IF EXISTS(select id from satinalma_listesi where proje_id = @id) begin select id from satinalma_listesi where proje_id = @id and durum != 'Iptal Edildi' and firma_id = '"& FirmaID &"' and cop = 'false' END else begin select 0 as id end"
                    set sapariskontrol = baglanti.execute(SQL)

                    SQL = "SELECT ROW_NUMBER() OVER(ORDER BY kullanici.id) AS Id, kullanici.personel_ad + ' ' + personel_soyad as ad_soyad, proje.proje_adi, dbo.DakikadanSaatYap((SELECT ISNULL(SUM ((DATEDIFF(n, CONVERT(DATETIME, calisma.baslangic,103), CONVERT(DATETIME, calisma.bitis,103)))), 0) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT((select departmanlar from ucgem_is_listesi where id = calisma.is_id and firma_id = '"& FirmaID &"'), ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(50), proje.id)) > 0 AND calisma.durum = 'true' AND calisma.cop = 'false' and calisma.firma_id = '"& FirmaID &"' and calisma.ekleyen_id = kullanici.id)) AS calismaSuresi, CONVERT(decimal(18,2), ((SELECT ISNULL(SUM((DATEDIFF(n, CONVERT(DATETIME, calisma.baslangic,103), CONVERT(DATETIME, calisma.bitis,103)))) * 0.016667, 0) * kullanici.personel_saatlik_maliyet FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT((select departmanlar from ucgem_is_listesi where id = calisma.is_id and firma_id = '"& FirmaID &"'), ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(50), proje.id)) > 0 AND calisma.durum = 'true' AND calisma.cop = 'false' and calisma.ekleyen_id = kullanici.id))) AS toplamMaliyet, kullanici.personel_maliyet_pb FROM dbo.ucgem_proje_listesi proje, ucgem_firma_kullanici_listesi kullanici where proje.firma_id = '"& FirmaID &"' AND proje.id = '"& proje_id &"' AND proje.cop = 'false' AND proje.durum = 'true' AND ( ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT(DATETIME, calisma.baslangic,103), CONVERT(DATETIME, calisma.bitis,103)))), 0) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT((select departmanlar from ucgem_is_listesi where id = calisma.is_id), ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(50), proje.id)) > 0 AND calisma.durum = 'true' AND calisma.cop = 'false' and calisma.ekleyen_id = kullanici.id)) > 0 " 
                    set personelAdamSaat = baglanti.execute(SQL)

        %>
        <div class="dt-responsive table-responsive" style="padding-bottom: 50px">
            <table id="new-cons2" class="<% if satinalmaformu.eof then %>kayityok<% end if %> table table-bordered" width="100%">
                <thead>
                    <tr>
                        <th colspan="1">Maliyet Formu</th>
                        <th style="width: 300px;"><%=LNG("Toplam Maliyet")%></th>
                        <th>Dosya</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                                if satinalmaformu.eof and personelAdamSaat.eof then   
                    %>
                    <tr>
                        <td colspan="6" style="text-align: center;"><%=LNG("Kayıt Yok")%></td>
                    </tr>
                    <%
                                else
                    %>
                    <tr>
                        <td class="text-left">
                            <a class="btn-link ml-2 mb-2" id="maliyetformu" onclick="maliyetDetayAc();" style="cursor: pointer"><i id="sipico" class="fa fa-plus mr-2"></i>Proje Maliyet Detayı</a>
                        </td>
                        <td>
                            <span id="subTotal" class="label-warning text-dark" style="padding: 4px 10px; margin-right: 0px; font-weight: bold; border-radius: 5px"></span>
                        </td>
                        <td class="dropdown" style="width: 10px;">
                            <button type="button" class="btn btn-mini btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-cog" aria-hidden="true"></i></button>
                            <div class="dropdown-menu dropdown-menu-right b-none contact-menu">
                                <a class="dropdown-item" href="javascript:void(0);" onclick="rapor_pdf_indir('proje_maliyet_formu', '<%=proje_id %>');"><i class="fa fa-download"></i>İndir</a>
                                <a class="dropdown-item" href="javascript:void(0);" onclick="rapor_pdf_yazdir('proje_maliyet_formu', '<%=proje_id %>');"><i class="fa fa-print"></i>Yazdır</a>
                                <a class="dropdown-item" href="javascript:void(0);" onclick="rapor_pdf_gonder('proje_maliyet_formu', '<%=proje_id %>');"><i class="fa fa-send"></i>Gönder</a>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" id="detayTD" style="display: none">
                            <div class="col-md-7" id="maliyetDetay" style="display: none">
                                <table id="dt_basic" class="table table-bordered datatableyap ml-2 mt-3 mb-3">
                                    <thead>
                                        <tr>
                                            <th colspan="6" style="text-align: center; background-color: lightskyblue !important">Sipariş Verilen Parçalar</th>
                                        </tr>
                                        <tr>
                                            <th style="width: 115px">Parça</th>
                                            <th>Marka</th>
                                            <th>Açıklama</th>
                                            <th>Adet</th>
                                            <th style="width: 100px;">Maliyet</th>
                                            <th style="width: 100px;">Toplam Maliyet</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%  
                                                    do while not satinalmaformu.eof
                                                    if satinalmaformu.eof then
                                                        SQL = "select * from satinalma_siparis_listesi where SatinalmaId = '0' and cop = 'false' and firma_id = '"& FirmaID &"'"
                                                        set siparisparca = baglanti.execute(SQL)
                                                    else
                                                        SQL = "select * from satinalma_siparis_listesi where SatinalmaId = '"& satinalmaformu("id") &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
                                                        set siparisparca = baglanti.execute(SQL)
                                                    end if

                                                    if siparisparca.eof then 
                                        %>
                                        <tr>
                                            <td colspan="6" style="text-align: center">Kayıt Bulunamadı</td>
                                        </tr>
                                        <%
                                                    end if
                                                    do while not siparisparca.eof

                                                    durum = 0
                                                    if NOT IsNull(siparisparca("IsId")) then
                                                        SQL = "select id, IsID, ParcaId, StoktanKullanilanAdet, SiparisVerilenAdet from is_parca_listesi where ParcaId = '"& siparisparca("parcaId") &"' and IsID = '"& siparisparca("IsID") &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
                                                        durum = 1
                                                    else
                                                        SQL = "select * from satinalma_siparis_listesi where SatinalmaId = '"& sapariskontrol("id") &"' and parcaId = '"& siparisparca("parcaId") &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
                                                        durum = 2
                                                    end if
                                                    set sondurum = baglanti.execute(SQL)
                                                    if durum = 1 then
                                                        SQL = "select * from parca_listesi where id = '"& sondurum("ParcaId") &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
                                                    elseif durum = 2 then
                                                        SQL = "select * from parca_listesi where id = '"& sondurum("parcaId") &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
                                                    end if
                                                    set parcaBilgi = baglanti.execute(SQL)

                                                    if durum = 1 then
                                                        adet = CInt(sondurum("SiparisVerilenAdet") - parcaBilgi("minumum_miktar"))
                                                    elseif durum = 2 then
                                                        adet = sondurum("adet")
                                                    end if

                                                    birimPB = "TL"
                                                    if parcaBilgi("birim_pb") = "" then
                                                    else
                                                       birimPB = parcaBilgi("birim_pb")
                                                       if birimPB = "EURO" then
                                                           birimPB = "EUR"
                                                       end if
                                                    end if
                                                    SatinalmaToplamMaliyet = Cdbl(parcaBilgi("birim_maliyet")) * adet

                                                    if birimPB = "TL" then
                                                        SPTMTL = SPTMTL + Cdbl(parcaBilgi("birim_maliyet")) * adet
                                                    end if
                                                    if birimPB = "USD" then
                                                        SPTMUSD = SPTMUSD + Cdbl(parcaBilgi("birim_maliyet")) * adet
                                                    end if
                                                    if birimPB = "EUR" then
                                                        SPTMEUR = SPTMEUR + Cdbl(parcaBilgi("birim_maliyet")) * adet
                                                    end if
                                        %>
                                        <tr>
                                            <td><%=parcaBilgi("parca_kodu") %> - <%=parcaBilgi("parca_adi") %></td>
                                            <td><%=parcaBilgi("marka") %></td>
                                            <td><%=parcaBilgi("aciklama") %></td>
                                            <td><% if durum = 1 then %> <%=CInt(sondurum("SiparisVerilenAdet") - parcaBilgi("minumum_miktar")) %> <%elseif durum = 2 then%> <%=sondurum("adet") %> <%end if %></td>
                                            <td><%=Replace(FormatNumber(parcaBilgi("birim_maliyet"),,,,0),",",".") %>&nbsp;<%=birimPB %></td>
                                            <td class="toplamMaliyet"><%=Replace(FormatNumber(SatinalmaToplamMaliyet,,,,0),",",".") %>&nbsp;<%=birimPB %></td>
                                        </tr>
                                        <%
                                                     siparisparca.movenext
                                                     loop
                                        %>
                                        <%
                                                    satinalmaformu.movenext
                                                    loop
                                        %>
                                        <tr>
                                            <td colspan="4" style="font-weight: bold; text-align: right">Toplam Maliyet</td>
                                            <td colspan="2" class="total" style="font-weight: bold">
                                                <%=Replace(FormatNumber(SPTMTL,,,,0),",",".") %>&nbsp;TL - 
                                                            <%=Replace(FormatNumber(SPTMUSD,,,,0),",",".") %>&nbsp;USD - 
                                                            <%=Replace(FormatNumber(SPTMEUR,,,,0),",",".") %>&nbsp;EUR
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <table id="dt_basic" class="table table-bordered datatableyap ml-2 mt-3 mb-3">
                                    <thead>
                                        <tr>
                                            <th colspan="6" style="text-align: center; background-color: lightskyblue !important">Stoktan Kullanılan Parçalar</th>
                                        </tr>
                                        <tr>
                                            <th style="width: 115px">Parça</th>
                                            <th>Marka</th>
                                            <th>Açıklama</th>
                                            <th>Adet</th>
                                            <th style="width: 100px;">Maliyet</th>
                                            <th style="width: 100px;">Toplam Maliyet</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%  
                                                        do while not satinalmaformu2.eof
                                                            if satinalmaformu2.eof then
                                                                SQL = "select * from satinalma_siparis_listesi where SatinalmaId = '0' and cop = 'false' and firma_id = '"& FirmaID &"'"
                                                                set eksikparca = baglanti.execute(SQL)
                                                            else
                                                                SQL = "select id, Adet, IsID, ParcaId, StoktanKullanilanAdet, SiparisVerilenAdet from is_parca_listesi where IsID = '"& satinalmaformu2("IsId") &"' and firma_id = '"& FirmaID &"'"
                                                                set eksikparca = baglanti.execute(SQL)
                                                            end if
                                                        if eksikparca.eof then
                                        %>
                                        <tr>
                                            <td colspan="6" style="text-align: center">Kayıt Bulunamadı</td>
                                        </tr>
                                        <%
                                                        end if
                                                        do while not eksikparca.eof

                                                        SQL = "select * from parca_listesi where id = '"& eksikparca("ParcaId") &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
                                                        set parcaBilgi = baglanti.execute(SQL)

                                                        birimPB = "TL"
                                                        if parcaBilgi("birim_pb") = "" then
                                                        else
                                                           birimPB = parcaBilgi("birim_pb")
                                                           if birimPB = "EURO" then
                                                               birimPB = "EUR"
                                                           end if
                                                        end if

                                                        KullanilanMaliyet = Cdbl(parcaBilgi("birim_maliyet")) * eksikparca("StoktanKullanilanAdet")
                                                    
                                                        if birimPB = "TL" then
                                                            STMTL = STMTL + Cdbl(parcaBilgi("birim_maliyet")) * eksikparca("StoktanKullanilanAdet")
                                                        end if
                                                        if birimPB = "USD" then
                                                            STMUSD = STMUSD + Cdbl(parcaBilgi("birim_maliyet")) * eksikparca("StoktanKullanilanAdet")
                                                        end if
                                                        if birimPB = "EUR" then
                                                            STMEUR = STMEUR + Cdbl(parcaBilgi("birim_maliyet")) * eksikparca("StoktanKullanilanAdet")
                                                        end if
                                        %>
                                        <tr>
                                            <td><%=parcaBilgi("parca_kodu") %> - <%=parcaBilgi("parca_adi") %></td>
                                            <td><%=parcaBilgi("marka") %></td>
                                            <td><%=parcaBilgi("aciklama") %></td>
                                            <td><%=eksikparca("StoktanKullanilanAdet") %></td>
                                            <td><%=Replace(FormatNumber(parcaBilgi("birim_maliyet"),,,,0),",",".") %>&nbsp;<%=birimPB %></td>
                                            <td class="toplamMaliyet"><%=Replace(FormatNumber(KullanilanMaliyet,,,,0),",",".") %>&nbsp;<%=birimPB %></td>
                                        </tr>
                                        <%
                                                        eksikparca.movenext
                                                        loop
                                        %>
                                        <%
                                                        satinalmaformu2.movenext
                                                        loop
                                        %>
                                        <tr>
                                            <td colspan="4" style="font-weight: bold; text-align: right">Toplam Maliyet</td>
                                            <td colspan="2" class="total" style="font-weight: bold">
                                                <%=Replace(FormatNumber(STMTL,,,,0),",",".")%>&nbsp;TL - 
                                                            <%=Replace(FormatNumber(STMUSD,,,,0),",",".") %>&nbsp; USD - 
                                                            <%=Replace(FormatNumber(STMEUR,,,,0),",",".") %>&nbsp; EUR
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <table class="table table-bordered ml-2 mt-3 mb-3">
                                    <thead>
                                        <tr>
                                            <th colspan="3" style="text-align: center; background-color: lightskyblue !important">Personel Adam Saat</th>
                                        </tr>
                                        <tr>
                                            <th>Personel</th>
                                            <th>Çalışma Süresi</th>
                                            <th>Maliyet</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                                            if personelAdamSaat.eof then
                                        %>
                                        <tr>
                                            <td colspan="3" style="text-align: center">Kayıt Bulunamadı</td>
                                        </tr>
                                        <%
                                                            end if
                                                            do while not personelAdamSaat.eof

                                                            personelMaliyetPB = personelAdamSaat("personel_maliyet_pb")
                                                            if personelMaliyetPB = "TL" then
                                                                ASTL = Cdbl(ASTL + Cdbl(personelAdamSaat("toplamMaliyet")))
                                                            end if
                                                            if personelMaliyetPB = "USD" then
                                                                ASUSD = Cdbl(ASUSD + Cdbl(personelAdamSaat("toplamMaliyet")))
                                                            end if
                                                            if personelMaliyetPB = "EUR" then
                                                                ASEUR = Cdbl(ASEUR + Cdbl(personelAdamSaat("toplamMaliyet")))
                                                            end if
                                        %>
                                        <tr>
                                            <td><%=personelAdamSaat("ad_soyad") %></td>
                                            <td><%=personelAdamSaat("calismaSuresi") %></td>
                                            <td class="toplamMaliyet"><%=Replace(FormatNumber(personelAdamSaat("toplamMaliyet"),,,,0),",",".") %>&nbsp<%=personelAdamSaat("personel_maliyet_pb") %></td>
                                        </tr>
                                        <%
                                                            personelAdamSaat.movenext
                                                            loop
                                        %>
                                        <tr>
                                            <td colspan="2" style="font-weight: bold; text-align: right">Toplam Maliyet</td>
                                            <td class="total" style="font-weight: bold">
                                                <%=Replace(FormatNumber(ASTL,,,,0),",",".") %>&nbsp;TL - 
                                                                    <%=Replace(FormatNumber(ASUSD,,,,0),",",".") %>&nbsp;USD -
                                                                    <%=Replace(FormatNumber(ASEUR,,,,0),",",".") %>&nbsp;EUR
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <%
                                end if
                    %>
                </tbody>
            </table>
            <script type="text/javascript">
                var sumTL = 0;
                var sumUSD = 0;
                var sumEUR = 0;
                var valueTL = 0;
                var valueUSD = 0;
                var valueEUR = 0;

                $(".toplamMaliyet").each(function () {

                    var sonucTL = $(this).text().indexOf("TL");
                    var sonucUSD = $(this).text().indexOf("USD");
                    var sonucEUR = $(this).text().indexOf("EUR");

                    if (sonucTL != -1) {
                        valueTL = $(this).text().replace('TL', '').replace(' ', '');
                        if (!isNaN(valueTL) && valueTL.length != 0 && valueTL > 0) {
                            sumTL = sumTL + parseFloat(valueTL);
                            $("#subTotal").text(sumTL.toFixed(2) + " TL" + " - " + sumUSD.toFixed(2) + " USD" + " - " + sumEUR.toFixed(2) + " EUR");
                        }
                    }

                    if (sonucUSD != -1) {
                        valueUSD = $(this).text().replace('USD', '').replace(' ', '');
                        if (!isNaN(valueUSD) && valueUSD.length != 0 && valueUSD > 0) {
                            sumUSD += parseFloat(valueUSD);
                            $("#subTotal").text(sumTL.toFixed(2) + " TL" + " - " + sumUSD.toFixed(2) + " USD" + " - " + sumEUR.toFixed(2) + " EUR");
                        }
                    }

                    if (sonucEUR != -1) {
                        valueEUR = $(this).text().replace('EUR', '').replace(' ', '');
                        if (!isNaN(valueEUR) && valueEUR.length != 0 && valueEUR > 0) {
                            sumEUR += parseFloat(valueEUR);
                            $("#subTotal").text(sumTL.toFixed(2) + " TL" + " - " + sumUSD.toFixed(2) + " USD" + " - " + sumEUR.toFixed(2) + " EUR");
                        }
                    }
                });
            </script>
        </div>
    </div>
</div>
<%

    elseif trn(request("islem")) = "ProjeAltButceEkle" then
        butceId = trn(request("butceId"))
        projeId = trn(request("projeId"))
%>
<div class="modal-header">
    <%=LNG("Bütçe Hesabı Ekle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="butce_hesabi_ekleme_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <div class="col-md-8">
            <div class="form-group">
                <label class="col-form-label">Bütçe Adı</label>
                <input type="text" class="form-control" id="altbutcemalzemeadi" placeholder="Bütçe Adı" />
            </div>
        </div>
        <div class="col-md-4">
            <div class="form-group">
                <label class="col-form-label">Tutar</label>
                <input type="text" class="form-control" id="altbutcemalzemetutar" placeholder="0,00" />
            </div>
        </div>
    </div>
    <div class="modal-footer pb-0 pr-0">
        <button type="button" class="btn btn-success btn-mini" onclick="ProjeAltButceKayit('<%=butceId %>', '<%=projeId %>');">Kaydet</button>
    </div>
    <script type="text/javascript">
        $("#altbutcemalzemetutar").maskMoney({ allowNegative: true, thousands: '', decimal: ',', affixesStay: false });
    </script>
</form>
<%
    elseif trn(request("islem")) = "ProjeAltButceDuzenle" then
        altButceId = trn(request("altButceId"))
        butceId = trn(request("butceId"))

        SQL = "select * from Maliyet.AltButce where MaliyetAltButceID = '"& altButceId &"' and MaliyetButceID = '"& butceId &"' and Guncellendi = 0 and Silindi = 0 and firma_id = '"& FirmaID &"'"
        set altButceKayit = baglanti.execute(SQL)
%>
<div class="modal-header">
    <%=LNG("Alt Bütçe Güncelle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="butce_hesabi_ekleme_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="col-form-label">Tutar</label>
                <input type="text" class="form-control" id="altButceTutar" value="<%=altButceKayit("AltButceTutari") %>" placeholder="0,00" />
            </div>
        </div>
    </div>
    <div class="modal-footer pb-0 pr-0">
        <button type="button" class="btn btn-info btn-mini" onclick="AltButceKayitGuncelle('<%=altButceId %>', '<%=butceId %>');">Güncelle</button>
    </div>
    <script type="text/javascript">
        $("#altButceTutar").maskMoney({ allowNegative: true, thousands: '', decimal: ',', affixesStay: false });
        $("#altButceTutar").focus();
    </script>
</form>
<%
    elseif trn(request("islem")) = "ProjeAltKalemButceDuzenle" then

        altButceKalemDegerId = trn(request("altButceKalemDegerId"))
        altButceKalemId = trn(request("altButceKalemId"))
        altButceId = trn(request("altButceId"))

        'SQL = "select * from Maliyet.AltButceKalem where MaliyetAltButceKalemID = '"& altButceKalemId &"' and MaliyetAltButceID = '"& altButceId &"' and Guncellendi = 0 and Silindi = 0"
        SQL = "select abk.MaliyetAltButceKalemID, abk.MaliyetAltButceID, abk.AltButceKalemAdi, abkd.MaliyetAltButceKalemDegerID, abkd.AltButceKalemTutar from Maliyet.AltButce ab inner join Maliyet.AltButceKalem abk on abk.MaliyetAltButceID = ab.MaliyetAltButceID inner join Maliyet.AltButceKalemDeger abkd on abkd.MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID where abk.MaliyetAltButceKalemID = '"& altButceKalemId &"' and abk.MaliyetAltButceID = '"& altButceId &"' and ab.Guncellendi = 0 and ab.Silindi = 0"
        set altButceKalemKayit = baglanti.execute(SQL)
%>
<div class="modal-header">
    Alt Bütçe Kalem Güncelle
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="butce_hesabi_ekleme_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <div class="col-md-8">
            <div class="form-group">
                <label class="col-form-label">Bütçe Adı</label>
                <input type="text" class="form-control" id="altButceKalemAdi" value="<%=altButceKalemKayit("AltButceKalemAdi") %>" placeholder="Bütçe Adı" />
            </div>
        </div>
        <div class="col-md-4">
            <div class="form-group">
                <label class="col-form-label">Tutar</label>
                <input type="text" class="form-control" id="altButceKalemTutari" value="<%=altButceKalemKayit("AltButceKalemTutar") %>" placeholder="0,00" />
            </div>
        </div>
    </div>
    <div class="modal-footer pb-0 pr-0">
        <button type="button" class="btn btn-info btn-mini" onclick="AltButceKalemKayitGuncelle('<%=altButceKalemId %>', '<%=altButceKalemDegerId %>', '<%=altButceId %>');">Güncelle</button>
    </div>
    <script type="text/javascript">
        $("#altButceKalemTutari").maskMoney({ allowNegative: true, thousands: '', decimal: ',', affixesStay: false });
        $("#altButceKalemTutari").focus();
    </script>
</form>
<%
    elseif trn(request("islem")) = "ProjeAltButceler" then
        
        butceId = trn(request("butceId"))
        kullaniciID = Request.Cookies("kullanici")("kullanici_id")
        i = 0
        altButceKalemToplam = 0

        SQL = "select * from Maliyet.AltButce where MaliyetButceID = '"& butceId &"' and Guncellendi = 0 and Silindi = 0"
        set projeAltButce = baglanti.execute(SQL)
%>
<table class="table table-bordered table-mini">
    <thead>
        <tr>
            <th>Bütçe Adı</th>
            <th style="width: 120px">Toplam Maliyet</th>
            <th>İşlem</th>
        </tr>
    </thead>
    <tbody>
        <%
                    if projeAltButce.eof then
        %>
        <tr>
            <td colspan="3" style="text-align: center">Kayıt Bulunamadı.</td>
        </tr>
        <%
                    end if
                    do while not projeAltButce.eof
                    i = i + 1

                    SQL = "select sum(abkd.AltButceKalemTutar) as AltButceKalemToplamTutar from Maliyet.AltButce ab inner join Maliyet.AltButceKalem abk on abk.MaliyetAltButceID = ab.MaliyetAltButceID inner join Maliyet.AltButceKalemDeger abkd on abkd.MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID where ab.MaliyetAltButceID = '"& projeAltButce("MaliyetAltButceID") &"' and ab.Guncellendi = 0 and ab.Silindi = 0 and abk.Guncellendi = 0 and abk.Silindi = 0 and abkd.Guncellendi = 0 and abkd.Silindi = 0"
                    set AltButceKalemToplamTutar = baglanti.execute(SQL)                    
        %>
        <tr style="font-size: 13px">
            <td><%=projeAltButce("AltButceAdi") %></td>
            <td>
                <input type="text" class="form-control form-control-sm priceText proje-butcesi-altbutce-tutar" value="<%if not AltButceKalemToplamTutar("AltButceKalemToplamTutar") = "0,00" then%><%=AltButceKalemToplamTutar("AltButceKalemToplamTutar") %><%else %><%=projeAltButce("AltButceTutari") %><%end if %>" id="AltButceTutari<%=projeAltButce("MaliyetAltButceID") %>" <%if AltButceKalemToplamTutar("AltButceKalemToplamTutar") = "0,00" then%> readonly <%end if%> />
            </td>
            <td>
                <button type="button" class="btn btn-info btn-mini" onclick="AltButceDetay('<%=projeAltButce("MaliyetAltButceID") %>');">Detay</button>
                <%if IsNull(AltButceKalemToplamTutar("AltButceKalemToplamTutar")) then %>
                <button type="button" class="btn btn-warning btn-mini" onclick="AltButceKayitGuncelle('<%=projeAltButce("MaliyetAltButceID") %>', '<%=projeAltButce("MaliyetButceID") %>');">Düzenle</button>
                <%end if %>
            </td>
        </tr>
        <tr>
            <td colspan="3" class="tdDetail" id="altButceDetaylari<%=projeAltButce("MaliyetAltButceID") %>" style="display: none; background-color: #ececec">
                <div class="row pl-4 pr-4 pt-4 divDetail" id="altButdeDetayDiv<%=projeAltButce("MaliyetAltButceID") %>" style="display: none">
                    <div class="col-md-12 altButceKalem" id="altButceKalem<%=i %>">
                        <table class="table table-bordered table-mini">
                            <thead>
                                <tr>
                                    <th style="width: 170px">Adı</th>
                                    <th style="width: 100px">Tutar</th>
                                    <th>İşlem</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                        SQL = "select abk.MaliyetAltButceKalemID, abk.MaliyetAltButceID, abk.AltButceKalemAdi, abkd.MaliyetAltButceKalemDegerID, abkd.AltButceKalemTutar from Maliyet.AltButce ab inner join Maliyet.AltButceKalem abk on abk.MaliyetAltButceID = ab.MaliyetAltButceID inner join Maliyet.AltButceKalemDeger abkd on abkd.MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID where ab.MaliyetAltButceID = '"& projeAltButce("MaliyetAltButceID") &"' and ab.Guncellendi = 0 and ab.Silindi = 0 and abk.Guncellendi = 0 and abk.Silindi = 0 and abkd.Guncellendi = 0 and abkd.Silindi = 0"
                                        set altButceKalem = baglanti.execute(SQL)
                                        if altButceKalem.eof then
                                %>
                                <tr>
                                    <td colspan="3" style="text-align: center">Kayıt Bulunamadı.</td>
                                </tr>
                                <%
                                        end if
                                        do while not altButceKalem.eof
                                %>
                                <tr>
                                    <td>
                                        <input type="text" class="form-control form-control-sm" id="altButceKalemAdi<%=altButceKalem("MaliyetAltButceKalemID") %>" value="<%=altButceKalem("AltButceKalemAdi") %>" />
                                    </td>
                                    <td>
                                        <input type="text" class="form-control form-control-sm priceText altButceKalemTutar" value="<%if IsNull(altButceKalem("AltButceKalemTutar")) then %>0,00<%else %> <%=altButceKalem("AltButceKalemTutar") %> <%end if %>" id="AltButceKalem<%=altButceKalem("MaliyetAltButceKalemID") %>" />
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-warning btn-mini" onclick="AltButceKalemKayitGuncelle('<%=altButceKalem("MaliyetAltButceKalemID") %>', '<%=altButceKalem("MaliyetAltButceKalemDegerID") %>', '<%=projeAltButce("MaliyetAltButceID") %>');">Düzenle</button>
                                        <button type="button" class="btn btn-danger btn-mini" onclick="AltButceKalemSil('<%=altButceKalem("MaliyetAltButceKalemID") %>', '<%=altButceKalem("MaliyetAltButceKalemDegerID") %>', '<%=projeAltButce("MaliyetAltButceID") %>');">Sil</button>
                                    </td>
                                </tr>
                                <%
                                            altButceKalem.movenext
                                            loop
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
        <%
                    projeAltButce.movenext
                    loop
        %>
    </tbody>
    <script type="text/javascript">
        $(".priceText").maskMoney({ allowNegative: true, thousands: '', decimal: ',', affixesStay: false });
        var total = 0;
        var tutar = 0;
        $(".proje-butcesi-altbutce-tutar").each(function () {
            if ($(this).val() === "") {
                tutar = 0;
            }
            else {
                tutar = $(this).val();
            }
            total += parseFloat(tutar);
            $("#txtProjeButcesi").val(total);
        });
        if (total > 0) {
            $("#btnProjeButcesiEkle").hide();
        }
    </script>
</table>
<%
    elseif trn(request("islem")) = "ProjeAltButceKayit" then

        altButceId = trn(request("butceId"))
        altButceMalzemeTutar = trn(request("altbutcemalzemetutar"))
        kullaniciID = Request.Cookies("kullanici")("kullanici_id")
        
        if trn(request("islem2")) = "guncelle" then
            SQL = "update Maliyet.AltButce set AltButceTutari = '"& altButceMalzemeTutar &"', GuncellemeZamani = GETDATE(), GuncelleyenKullaniciID = '"& kullaniciID &"' where MaliyetAltButceID = '"& altButceId &"'"
            set AltButceGuncelle = baglanti.execute(SQL)
        end if

    elseif trn(request("islem")) = "AltButceKalemKayit" then
        altButceId = trn(request("altButceId"))
        altButceKalemId = trn(request("altButceKalemId"))
        altButceKalemDegerId = trn(request("altButceKalemDegerId"))
        altButceKalemMalzemeAdi = trn(request("altButceKalemMalzemeAdi"))
        altButceKalemMalzemeTutar = trn(request("altButceKalemMalzemeTutar"))
        kullaniciID = Request.Cookies("kullanici")("kullanici_id")

        if trn(request("islem2")) = "ekle" then
            
            'Malzeme
            SQL = "SET NOCOUNT ON; insert into Maliyet.AltButceKalem(MaliyetAltButceID, AltButceKalemAdi, OlusturmaZamani, OlusturanKullaniciID, Guncellendi, Silindi) values('1', '"& altButceKalemMalzemeAdi &"', GETDATE(), '"& kullaniciID &"', 0, 0); select SCOPE_IDENTITY();"
            set altButceKalemKayit = baglanti.execute(SQL)

            altButceKalemID = altButceKalemKayit(0)

            SQL = "insert into Maliyet.AltButceKalemDeger(MaliyetAltButceKalemID, MaliyetAltButceID, AltButceKalemTutar, OlusturmaZamani, OlusturanKullaniciID) values('"& altButceKalemID &"', '"& 1 &"', '"& altButceKalemMalzemeTutar &"', GETDATE(), '"& kullaniciID &"')"
            set altButceKalemTutarKayit = baglanti.execute(SQL)

            'İşçilik
            SQL = "SET NOCOUNT ON; insert into Maliyet.AltButceKalem(MaliyetAltButceID, AltButceKalemAdi, OlusturmaZamani, OlusturanKullaniciID, Guncellendi, Silindi) values('2', '"& altButceKalemMalzemeAdi &"', GETDATE(), '"& kullaniciID &"', 0, 0); select SCOPE_IDENTITY();"
            set altButceKalemKayit2 = baglanti.execute(SQL)

            altButceKalemID2 = altButceKalemKayit2(0)

            SQL = "insert into Maliyet.AltButceKalemDeger(MaliyetAltButceKalemID, MaliyetAltButceID, OlusturmaZamani, OlusturanKullaniciID) values('"& altButceKalemID2 &"', '"& 2 &"', GETDATE(), '"& kullaniciID &"')"
            set altButceKalemTutarKayit2 = baglanti.execute(SQL)
            
        elseif trn(request("islem2")) = "guncelle" then

            SQL = "update Maliyet.AltButceKalem set AltButceKalemAdi = '"& altButceKalemMalzemeAdi &"', GuncellemeZamani = GETDATE(), GuncelleyenKullaniciID = '"& kullaniciID &"', Guncellendi = 0,  Silindi = 0 where MaliyetAltButceKalemID = '"& altButceKalemId &"' and MaliyetAltButceID = '"& altButceId &"'"
            set altButceKalemGuncelle = baglanti.execute(SQL)

            SQL = "update Maliyet.AltButceKalemDeger set AltButceKalemTutar = '"& altButceKalemMalzemeTutar &"' where MaliyetAltButceKalemDegerID = '"& altButceKalemDegerId &"' and MaliyetAltButceKalemID = '"& altButceKalemId &"'"
            set altButceKalemDegerGuncelle = baglanti.execute(SQL)

        elseif trn(request("islem2")) = "sil" then
            SQL = "update Maliyet.AltButceKalem set GuncellemeZamani = GETDATE(), GuncelleyenKullaniciID = '"& kullaniciID &"', Guncellendi = 1,  Silindi = 1 where MaliyetAltButceKalemID = '"& altButceKalemId &"' and MaliyetAltButceID = '"& altButceId &"'"
            set altButceKalemSilme = baglanti.execute(SQL)
        
            SQL = "update Maliyet.AltButceKalemDeger set Guncellendi = 1, Silindi = 1, GuncellemeZamani = GETDATE(), GuncelleyenKullaniciID = '"& kullaniciID &"' where MaliyetAltButceKalemId = '"& altButceKalemId &"' and MaliyetAltButceID = '"& altButceId &"'"
            set altButceKalemDegerSilme = baglanti.execute(SQL)
        end if

%>
<table class="table table-bordered table-mini">
    <thead>
        <tr>
            <th style="width: 170px">Adı</th>
            <th style="width: 100px">Tutar</th>
            <th>İşlem</th>
        </tr>
    </thead>
    <tbody>
        <%
                    SQL = "select abk.MaliyetAltButceKalemID, abk.MaliyetAltButceID, abk.AltButceKalemAdi, abkd.MaliyetAltButceKalemDegerID, abkd.AltButceKalemTutar from Maliyet.AltButce ab inner join Maliyet.AltButceKalem abk on abk.MaliyetAltButceID = ab.MaliyetAltButceID inner join Maliyet.AltButceKalemDeger abkd on abkd.MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID where ab.MaliyetAltButceID = '"& altButceId &"' and ab.Guncellendi = 0 and ab.Silindi = 0 and abk.Guncellendi = 0 and abk.Silindi = 0 and abkd.Guncellendi = 0 and abkd.Silindi = 0"
                    set altButceKalem = baglanti.execute(SQL)

                    if altButceKalem.eof then
        %>
        <tr>
            <td colspan="3" style="text-align: center">Kayıt Bulunamadı.</td>
        </tr>
        <%
                    end if
                    do while not altButceKalem.eof
        %>
        <tr>
            <td>
                <input type="text" class="form-control form-control-sm" id="altButceKalemAdi<%=altButceKalem("MaliyetAltButceKalemID") %>" value="<%=altButceKalem("AltButceKalemAdi") %>" />
            </td>
            <td>
                <input type="text" class="form-control form-control-sm" value="<%if IsNull(altButceKalem("AltButceKalemTutar")) then %>0,00<%else %> <%=altButceKalem("AltButceKalemTutar") %> <%end if %>" id="AltButceKalem<%=altButceKalem("MaliyetAltButceKalemID") %>" />
            </td>
            <td>
                <button type="button" class="btn btn-warning btn-mini" onclick="AltButceKalemKayitGuncelle('<%=altButceKalem("MaliyetAltButceKalemID") %>', '<%=altButceKalem("MaliyetAltButceKalemDegerID") %>', '<%=altButceKalem("MaliyetAltButceID") %>');">Düzenle</button>
                <button type="button" class="btn btn-danger btn-mini" onclick="AltButceKalemSil('<%=altButceKalem("MaliyetAltButceKalemID") %>', '<%=altButceKalem("MaliyetAltButceKalemDegerID") %>', '<%=altButceKalem("MaliyetAltButceID") %>');">Sil</button>
            </td>
        </tr>
        <%
                    altButceKalem.movenext
                    loop
        %>
    </tbody>
</table>
<%
    elseif trn(request("islem")) = "ProjeAnlasmaBedeliAltButce" then
        alnasmaBedeliButceId = trn(request("alnasmaBedeliButceId"))
        proje_id = trn(request("proje_id"))
        i = 0

        SQL = "select * from Maliyet.ProjeAnlasmaBedeli where MaliyetProjeAnlasmaBedeliID = '"& alnasmaBedeliButceId &"'"
        set projeAnlasmaBedeli = baglanti.execute(SQL)
%>
<table class="table table-bordered table-mini">
    <thead>
        <tr>
            <th>Bütçe Adı</th>
            <th style="width: 120px">Bütçe Tutarı</th>
            <th>İşlem</th>
        </tr>
    </thead>
    <tbody>
        <%
                SQL = "select ab.MaliyetAltButceID, ab.MaliyetButceID, ab.AltButceAdi, (select AnlasmaBedeliTutari from Maliyet.MaliyetProjeAltButceAnlasmaBedeli where MaliyetAltButceID = ab.MaliyetAltButceID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& proje_id &"') as AnlasmaBedeliTutar, (select MaliyetProjeAnlasmaBedeliID from Maliyet.MaliyetProjeAltButceAnlasmaBedeli where MaliyetAltButceID = ab.MaliyetAltButceID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& proje_id &"') as MaliyetProjeAnlasmaBedeliID, (select MaliyetProjeAltButceAnlasmaBedeliID from Maliyet.MaliyetProjeAltButceAnlasmaBedeli where MaliyetAltButceID = ab.MaliyetAltButceID  and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& proje_id &"') as MaliyetProjeAltButceAnlasmaBedeliID, (select ProjeID from Maliyet.ProjeAnlasmaBedeli where MaliyetAltButceID = ab.MaliyetAltButceID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& proje_id &"') as ProjeID, (select MaliyetProjeAnlasmaBedeliID from Maliyet.ProjeAnlasmaBedeli where MaliyetAltButceID = ab.MaliyetAltButceID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& proje_id &"') as ProjeAnlasmaBedeli from Maliyet.AltButce ab where ab.Guncellendi = 0 and ab.Silindi = 0"
                set maliyetProjeAltButceAnlasmaBedeli = baglanti.execute(SQL)

                if maliyetProjeAltButceAnlasmaBedeli.eof then
        %>
        <tr>
            <td colspan="3" style="text-align: center">Kayıt Bulunamadı.</td>
        </tr>
        <%
                end if
                do while not maliyetProjeAltButceAnlasmaBedeli.eof
                i = i + 1

                SQL = "select sum(AnlasmaBedeliTutari) as AnlasmaBedeliTutari from Maliyet.ProjeAnlasmaBedeliDetay where MaliyetAltButceID = '"& maliyetProjeAltButceAnlasmaBedeli("MaliyetAltButceID") &"' and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& proje_id &"'"
                set AnlasmaBedeliTutari = baglanti.execute(SQL)
        %>
        <tr>
            <td><%=maliyetProjeAltButceAnlasmaBedeli("AltButceAdi") %></td>
            <td>
                <input type="text" class="form-control form-control-sm priceText anlasma-bedeli-altbutce-tutar" value="<%if AnlasmaBedeliTutari("AnlasmaBedeliTutari") = "0,00" then %><%=maliyetProjeAltButceAnlasmaBedeli("AnlasmaBedeliTutar") %><%else %><%=AnlasmaBedeliTutari("AnlasmaBedeliTutari") %><%end if %>" id="AnlasmaBedeliAltButceTutari<%=maliyetProjeAltButceAnlasmaBedeli("MaliyetAltButceID") %>" <%if not AnlasmaBedeliTutari("AnlasmaBedeliTutari") = "0,00" then%> readonly="readonly" <%end if %> />
            </td>
            <td>
                <button class="btn btn-info btn-mini" id="btnProjeAnlasmaBedeliDetayAc<%=maliyetProjeAltButceAnlasmaBedeli("MaliyetAltButceID") %>" onclick="ProjeAnlasmaBedeliDetayAc('<%=maliyetProjeAltButceAnlasmaBedeli("MaliyetAltButceID") %>');">Detay</button>
                <%if IsNull(AnlasmaBedeliTutari("AnlasmaBedeliTutari")) then%>
                <button class="btn btn-warning btn-mini" id="btnProjeAnlasmaBedeliDuzenle<%=maliyetProjeAltButceAnlasmaBedeli("MaliyetAltButceID") %>" onclick="projeAnlasmaBedeliAltButceGuncelle('<%=maliyetProjeAltButceAnlasmaBedeli("MaliyetProjeAnlasmaBedeliID") %>', '<%=maliyetProjeAltButceAnlasmaBedeli("MaliyetProjeAltButceAnlasmaBedeliID") %>', '<%=maliyetProjeAltButceAnlasmaBedeli("ProjeID") %>', '<%=maliyetProjeAltButceAnlasmaBedeli("MaliyetAltButceID") %>', '<%=maliyetProjeAltButceAnlasmaBedeli("ProjeAnlasmaBedeli") %>');">Düzenle</button>
                <%end if %>
            </td>
        </tr>
        <tr>
            <td colspan="3" class="tdDetail" id="ProjeAnlasmaBedeliDetaytd<%=maliyetProjeAltButceAnlasmaBedeli("MaliyetAltButceID") %>" style="display: none; background-color: #ececec">
                <div class="row pl-4 pr-4 pt-4 divDetail" id="ProjeAnlasmaBedeliDetaydiv<%=maliyetProjeAltButceAnlasmaBedeli("MaliyetAltButceID") %>" style="display: none">
                    <div class="col-md-12" id="projeAnlasmaBedeliAltKalem<%=maliyetProjeAltButceAnlasmaBedeli("MaliyetAltButceID") %>">
                        <table class="table table-bordered table-mini" id="projeAnlasmaBedeliAltKalemTable<%=maliyetProjeAltButceAnlasmaBedeli("MaliyetAltButceID") %>">
                            <thead>
                                <tr>
                                    <th>Adı</th>
                                    <th style="width: 120px">Tutar</th>
                                    <th>İşlem</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                        SQL = "select abk.MaliyetAltButceKalemID, abk.MaliyetAltButceID, abk.AltButceKalemAdi, (select AnlasmaBedeliTutari from Maliyet.ProjeAnlasmaBedeliDetay where MaliyetAltButceID = abk.MaliyetAltButceID and MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Silindi = 0 and Guncellendi = 0 and ProjeID = '"& proje_id &"') as AnlasmaBedeliTutar, (select MaliyetAltButceKalemID from Maliyet.ProjeAnlasmaBedeliDetay where MaliyetAltButceID = abk.MaliyetAltButceID and MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Silindi = 0 and Guncellendi = 0 and ProjeID = '"& proje_id &"') as MaliyetAltButceKalemDegerID, (select MaliyetProjeAnlasmaBedeliDetayID from Maliyet.ProjeAnlasmaBedeliDetay where MaliyetAltButceID = abk.MaliyetAltButceID and MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Silindi = 0 and Guncellendi = 0 and ProjeID = '"& proje_id &"') as MaliyetProjeAnlasmaBedeliDetayID, (select MaliyetProjeAnlasmaBedeliID from Maliyet.ProjeAnlasmaBedeliDetay where MaliyetAltButceID = abk.MaliyetAltButceID and MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Silindi = 0 and Guncellendi = 0 and ProjeID = '"& proje_id &"') as MaliyetProjeAnlasmaBedeliID  from Maliyet.AltButceKalem abk where abk.MaliyetAltButceID = '"& maliyetProjeAltButceAnlasmaBedeli("MaliyetAltButceID") &"' and abk.Guncellendi = 0 and abk.Silindi = 0"
                                        set altButceKalem = baglanti.execute(SQL)

                                        if altButceKalem.eof then
                                %>
                                <tr>
                                    <td colspan="3" style="text-align: center">Kayıt Bulunamadı.</td>
                                </tr>
                                <%
                                        end if
                                        do while not altButceKalem.eof
                                %>
                                <tr>
                                    <td><%=altButceKalem("AltButceKalemAdi") %></td>
                                    <td>
                                        <input type="text" class="form-control form-control-sm priceText" value="<%if IsNull(altButceKalem("AnlasmaBedeliTutar")) then %>0,00<%else %><%=altButceKalem("AnlasmaBedeliTutar") %><%end if %>" id="AnlasmaBedeliAltButceKalemTutari<%=altButceKalem("MaliyetAltButceKalemID") %>" />
                                    </td>
                                    <td>
                                        <button class="btn btn-warning btn-mini" onclick="projeAnlasmaBedeliGuncelle('<%=altButceKalem("MaliyetAltButceKalemID") %>', '<%=altButceKalem("MaliyetAltButceKalemDegerID") %>', '<%=altButceKalem("MaliyetAltButceID") %>', '<%=proje_id %>', '<%=maliyetProjeAltButceAnlasmaBedeli("MaliyetProjeAnlasmaBedeliID") %>')">Düzenle</button>

                                        <button class="btn btn-danger btn-mini" onclick="projeAnlasmaBedeliTutarSil('<%=altButceKalem("MaliyetAltButceKalemID") %>', '<%=altButceKalem("MaliyetAltButceKalemDegerID") %>', '<%=altButceKalem("MaliyetAltButceID") %>', '<%=maliyetProjeAltButceAnlasmaBedeli("ProjeID") %>', '<%=maliyetProjeAltButceAnlasmaBedeli("MaliyetProjeAnlasmaBedeliID") %>', '<%=altButceKalem("MaliyetProjeAnlasmaBedeliDetayID") %>')">Sil</button>
                                    </td>
                                </tr>
                                <%
                                        altButceKalem.movenext
                                        loop
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
        <%
                maliyetProjeAltButceAnlasmaBedeli.movenext
                loop
        %>
    </tbody>
    <script type="text/javascript">
        $(".priceText").maskMoney({ allowNegative: true, thousands: '', decimal: ',', affixesStay: false });
        var total = 0;
        var tutar = 0;
        $(".anlasma-bedeli-altbutce-tutar").each(function () {
            if ($(this).val() === "") {
                tutar = 0;
            }
            else {
                tutar = $(this).val();
            }
            total += parseFloat(tutar);
            $("#txtProjeAnlasmaBedeli").val(total);
        });
        if (total > 0) {
            $("#btnProjeAnlasmaBedeliEkle").hide();
        }
    </script>
</table>
<%
    elseif trn(request("islem")) = "projeAnlasmaBedeliTutarKayit" then

        maliyetAltButceKalemID = trn(request("maliyetAltButceKalemID"))
        if trn(request("maliyetAltButceKalemDegerID")) = "" then
            maliyetAltButceKalemDegerID = 0
        else
            maliyetAltButceKalemDegerID = trn(request("maliyetAltButceKalemDegerID"))
        end if

        ProjeAnlasmaBedeliId = trn(request("ProjeAnlasmaBedeliId"))
        maliyetAltButceID = trn(request("maliyetAltButceID"))
        i = trn(request("i"))
        projeID = trn(request("projeID"))

        SQL = "select abk.MaliyetAltButceKalemID, abk.MaliyetAltButceID, abk.AltButceKalemAdi, (select AnlasmaBedeliTutari from Maliyet.ProjeAnlasmaBedeliDetay where MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and MaliyetAltButceID = abk.MaliyetAltButceID and Guncellendi = 0 and Silindi = 0) as AltButceKalemTutar, (select AnlasmaBedeliTutari from Maliyet.ProjeAnlasmaBedeliDetay where MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and MaliyetAltButceID = abk.MaliyetAltButceID and Guncellendi = 0 and Silindi = 0) as MaliyetAltButceKalemDegerID from Maliyet.AltButceKalem abk where abk.MaliyetAltButceKalemID = '"& maliyetAltButceKalemID &"' and abk.MaliyetAltButceID = '"& maliyetAltButceID &"' and abk.Guncellendi = 0 and abk.Silindi = 0"
        set projeAnlasmaBedeliTutar = baglanti.execute(SQL)

%>
<div class="modal-header">
    Alt Bütçe Kalem Tutar Güncelle
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="butce_hesabi_ekleme_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="col-form-label">Tutar</label>
                <input type="text" class="form-control" id="projeAnlasmaBedeliTutar" value="<%if IsNull(projeAnlasmaBedeliTutar("AltButceKalemTutar")) then %> 0.00 <%else %> <%=projeAnlasmaBedeliTutar("AltButceKalemTutar") %> <%end if %>" placeholder="0,00" />
            </div>
        </div>
    </div>
    <div class="modal-footer pb-0 pr-0">
        <button type="button" class="btn btn-info btn-mini" onclick="projeAnlasmaBedeliGuncelle('<%=maliyetAltButceKalemID %>', '<%=maliyetAltButceKalemDegerID %>', '<%=maliyetAltButceID %>', '<%=i %>', '<%=projeID %>', '<%=ProjeAnlasmaBedeliId %>');">Güncelle</button>
    </div>
    <script type="text/javascript">
        $("#projeAnlasmaBedeliTutar").maskMoney({ allowNegative: true, thousands: '', decimal: ',', affixesStay: false });
        $("#projeAnlasmaBedeliTutar").focus();
    </script>
</form>
<%
    elseif trn(request("islem")) = "ProjeAnlasmaBedeliKayit" then
        maliyetAltButceKalemID = trn(request("maliyetAltButceKalemID"))
        maliyetAltButceKalemDegerID = trn(request("maliyetAltButceKalemDegerID"))
        maliyetAltButceID = trn(request("maliyetAltButceID"))
        projeAnlasmaBedeliTutar = trn(request("projeAnlasmaBedeliTutar"))
        projeID = trn(request("projeID"))
        ProjeAnlasmaBedeliId = trn(request("ProjeAnlasmaBedeliId"))
        MaliyetProjeAnlasmaBedeliDetayID = trn(request("MaliyetProjeAnlasmaBedeliDetayID"))
        kullaniciID = Request.Cookies("kullanici")("kullanici_id")

        if trn(request("islem2")) = "Guncelle" then
            SQL = "select * from Maliyet.ProjeAnlasmaBedeliDetay where MaliyetAltButceID = '"& maliyetAltButceID &"' and MaliyetAltButceKalemID = '"& maliyetAltButceKalemID &"' and ProjeID = '"& projeID &"' and Guncellendi = 0 and Silindi = 0"
            set ProjeAnlasmaBedeliDetay = baglanti.execute(SQL)

            if not ProjeAnlasmaBedeliDetay.eof then
                SQL = "update Maliyet.ProjeAnlasmaBedeliDetay set MaliyetProjeAnlasmaBedeliID = '"& ProjeAnlasmaBedeliId &"', AnlasmaBedeliTutari = '"& projeAnlasmaBedeliTutar &"', MaliyetAltButceID = '"& maliyetAltButceID &"', MaliyetAltButceKalemID = '"& maliyetAltButceKalemID &"' where MaliyetAltButceID = '"& maliyetAltButceID &"' and MaliyetAltButceKalemID = '"& maliyetAltButceKalemID &"'"
                set ProjeAnlasmaBedeliDetayGuncelle = baglanti.execute(SQL)
            else
                SQL = "insert into Maliyet.ProjeAnlasmaBedeliDetay(MaliyetProjeAnlasmaBedeliID, ProjeID, MaliyetAltButceID, MaliyetAltButceKalemID, AnlasmaBedeliTutari, OlusturanKullaniciID) values('"& ProjeAnlasmaBedeliId &"', '"& ProjeID &"', '"& maliyetAltButceID &"', '"& maliyetAltButceKalemID &"', '"& projeAnlasmaBedeliTutar &"', '"& kullaniciID &"')"
                set ProjeAnlasmaBedeliDetayEkle = baglanti.execute(SQL)
            end if
        elseif trn(request("islem2")) = "Sil" then
            SQL = "update Maliyet.ProjeAnlasmaBedeliDetay set Guncellendi = 1, Silindi = 1 where MaliyetProjeAnlasmaBedeliDetayID = '"& MaliyetProjeAnlasmaBedeliDetayID &"' and MaliyetProjeAnlasmaBedeliID = '"& ProjeAnlasmaBedeliId &"' and ProjeID = '"& projeID &"' and MaliyetAltButceID = '"& maliyetAltButceID &"' and MaliyetAltButceKalemID = '"& maliyetAltButceKalemID &"'"
            set ProjeAnlasmaBedeliDetaySil = baglanti.execute(SQL)
        end if
%>
<table class="table table-bordered table-mini" id="projeAnlasmaBedeliAltKalemTable<%=maliyetAltButceID %>">
    <thead>
        <tr>
            <th>Adı</th>
            <th style="width: 100px">Tutar</th>
            <th>İşlem</th>
        </tr>
    </thead>
    <tbody>
        <%
                    SQL = "select abk.MaliyetAltButceKalemID, abk.MaliyetAltButceID, abk.AltButceKalemAdi, (select AnlasmaBedeliTutari from Maliyet.ProjeAnlasmaBedeliDetay where MaliyetAltButceID = abk.MaliyetAltButceID and MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Silindi = 0 and Guncellendi = 0) as AnlasmaBedeliTutar, (select MaliyetAltButceKalemID from Maliyet.ProjeAnlasmaBedeliDetay where MaliyetAltButceID = abk.MaliyetAltButceID and MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Silindi = 0 and Guncellendi = 0) as MaliyetAltButceKalemDegerID, (select MaliyetProjeAnlasmaBedeliDetayID from Maliyet.ProjeAnlasmaBedeliDetay where MaliyetAltButceID = abk.MaliyetAltButceID and MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Silindi = 0 and Guncellendi = 0) as MaliyetProjeAnlasmaBedeliDetayID, (select MaliyetProjeAnlasmaBedeliID from Maliyet.ProjeAnlasmaBedeliDetay where MaliyetAltButceID = abk.MaliyetAltButceID and MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Silindi = 0 and Guncellendi = 0) as MaliyetProjeAnlasmaBedeliID  from Maliyet.AltButceKalem abk where abk.MaliyetAltButceID = '"& maliyetAltButceID &"' and abk.Guncellendi = 0 and abk.Silindi = 0"
                    set altButceKalem = baglanti.execute(SQL)

                    if altButceKalem.eof then
        %>
        <tr>
            <td colspan="3" style="text-align: center">Kayıt Bulunamadı.</td>
        </tr>
        <%
                    end if
                    do while not altButceKalem.eof
        %>
        <tr>
            <td><%=altButceKalem("AltButceKalemAdi") %></td>
            <td>
                <input type="text" class="form-control form-control-sm priceText" value="<%if IsNull(altButceKalem("AnlasmaBedeliTutar")) then %>0,00<%else %><%=altButceKalem("AnlasmaBedeliTutar") %><%end if %>" id="AnlasmaBedeliAltButceKalemTutari<%=altButceKalem("MaliyetAltButceKalemID") %>" />
            </td>
            <td>
                <button class="btn btn-warning btn-mini" onclick="projeAnlasmaBedeliGuncelle('<%=altButceKalem("MaliyetAltButceKalemID") %>', '<%=altButceKalem("MaliyetAltButceKalemDegerID") %>', '<%=altButceKalem("MaliyetAltButceID") %>', '<%=projeID %>', '<%=ProjeAnlasmaBedeliId %>')">Düzenle</button>

                <button class="btn btn-danger btn-mini" onclick="projeAnlasmaBedeliTutarSil('<%=altButceKalem("MaliyetAltButceKalemID") %>', '<%=altButceKalem("MaliyetAltButceKalemDegerID") %>', '<%=altButceKalem("MaliyetAltButceID") %>', '<%=projeID %>', '<%=ProjeAnlasmaBedeliId %>', '<%=altButceKalem("MaliyetProjeAnlasmaBedeliDetayID") %>')">Sil</button>
            </td>
        </tr>
        <%
                    altButceKalem.movenext
                    loop
        %>
    </tbody>
    <script type="text/javascript">
        $(".priceText").maskMoney({ allowNegative: true, thousands: '', decimal: ',', affixesStay: false });
    </script>
</table>
<%
    elseif trn(request("islem")) = "ProjeAnlasmaBedeliDuzenle" then
        if trn(request("MaliyetProjeAnlasmaBedeliID")) = "" then
            MaliyetProjeAnlasmaBedeliID = 0
        else
            MaliyetProjeAnlasmaBedeliID = trn(request("MaliyetProjeAnlasmaBedeliID"))
        end if
        if trn(request("MaliyetProjeAltButceAnlasmaBedeliID")) = "" then
            MaliyetProjeAltButceAnlasmaBedeliID = 0
        else
            MaliyetProjeAltButceAnlasmaBedeliID = trn(request("MaliyetProjeAltButceAnlasmaBedeliID"))
        end if
        ProjeID = trn(request("ProjeID"))
        MaliyetAltButceID = trn(request("MaliyetAltButceID"))
        ProjeAnlasmaBedeli = trn(request("ProjeAnlasmaBedeli"))

        SQL = "select * from Maliyet.MaliyetProjeAltButceAnlasmaBedeli where MaliyetProjeAnlasmaBedeliID = '"& MaliyetProjeAnlasmaBedeliID &"' and MaliyetProjeAltButceAnlasmaBedeliID = '"& MaliyetProjeAltButceAnlasmaBedeliID &"' and ProjeID = '"& ProjeID &"'"
        set MaliyetProjeAltButceAnlasmaBedeli = baglanti.execute(SQL)
%>
<div class="modal-header">
    Alt Bütçe Kalem Tutar Güncelle
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="butce_hesabi_ekleme_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="col-form-label">Tutar</label>
                <input type="text" class="form-control" id="projeAnlasmaBedeliTutari" value="<%if MaliyetProjeAltButceAnlasmaBedeli.eof then %>0.00<%else %><%=MaliyetProjeAltButceAnlasmaBedeli("AnlasmaBedeliTutari") %><%end if %>" placeholder="0,00" />
            </div>
        </div>
    </div>
    <div class="modal-footer pb-0 pr-0">
        <button type="button" class="btn btn-info btn-mini" onclick="projeAnlasmaBedeliAltButceGuncelle('<%=MaliyetProjeAnlasmaBedeliID %>', '<%=MaliyetProjeAltButceAnlasmaBedeliID %>', '<%=ProjeID %>', '<%=MaliyetAltButceID %>', '<%=ProjeAnlasmaBedeli %>');">Güncelle</button>
    </div>
    <script type="text/javascript">
        $("#projeAnlasmaBedeliTutari").maskMoney({ allowNegative: true, thousands: '', decimal: ',', affixesStay: false });
        $("#projeAnlasmaBedeliTutari").focus();
    </script>
</form>
<%
    elseif trn(request("islem")) = "ProjeAnlasmaBedeliAltButceDuzenle" then

        MaliyetProjeAnlasmaBedeliID = trn(request("MaliyetProjeAnlasmaBedeliID"))
        MaliyetProjeAltButceAnlasmaBedeliID = trn(request("MaliyetProjeAltButceAnlasmaBedeliID"))
        ProjeID = trn(request("ProjeID"))
        projeAnlasmaBedeliTutari = trn(request("projeAnlasmaBedeliTutari"))
        MaliyetAltButceID = trn(request("MaliyetAltButceID"))
        ProjeAnlasmaBedeli = trn(request("ProjeAnlasmaBedeli"))
        kullaniciID = Request.Cookies("kullanici")("kullanici_id")

        if trn(request("islem2")) = "Guncelle" then
            SQL = "select * from Maliyet.MaliyetProjeAltButceAnlasmaBedeli where MaliyetProjeAnlasmaBedeliID = '"& MaliyetProjeAnlasmaBedeliID &"' and MaliyetProjeAltButceAnlasmaBedeliID = '"& MaliyetProjeAltButceAnlasmaBedeliID &"' and ProjeID = '"& ProjeID &"'"
            set MaliyetProjeAltButceAnlasmaBedeliKontrol = baglanti.execute(SQL)

            if MaliyetProjeAltButceAnlasmaBedeliKontrol.eof then
                SQL = "insert into Maliyet.MaliyetProjeAltButceAnlasmaBedeli(MaliyetProjeAnlasmaBedeliID, ProjeID, MaliyetAltButceID, AnlasmaBedeliTutari, OlusturanKullaniciID) values('"& ProjeAnlasmaBedeli &"', '"& ProjeID &"', '"& MaliyetAltButceID &"', '"& projeAnlasmaBedeliTutari &"', '"& kullaniciID &"')"
                set MaliyetProjeAltButceAnlasmaBedeliKayit = baglanti.execute(SQL)
            else
                SQL = "update Maliyet.MaliyetProjeAltButceAnlasmaBedeli set AnlasmaBedeliTutari = '"& projeAnlasmaBedeliTutari &"' where MaliyetProjeAnlasmaBedeliID = '"& MaliyetProjeAnlasmaBedeliID &"' and MaliyetProjeAltButceAnlasmaBedeliID = '"& MaliyetProjeAltButceAnlasmaBedeliID &"' and ProjeID = '"& ProjeID &"' and MaliyetAltButceID = '"& MaliyetAltButceID &"'"
                set MaliyetProjeAltButceAnlasmaBedeliGuncelle = baglanti.execute(SQL)
            end if
        end if

    elseif trn(request("islem")) = "ProjeTahminiBitisBedeliAltButce" then

        tahminiBitisBedeliButceId = trn(request("tahminiBitisBedeliButceId"))
        projeId = trn(request("projeId"))
%>
<table class="table table-bordered table-mini">
    <thead>
        <tr>
            <th>Bütçe Adı</th>
            <th style="width: 120px">Bütçe Tutarı</th>
            <th>İşlem</th>
        </tr>
    </thead>
    <tbody>
        <%
                SQL = "select ab.MaliyetAltButceID, ab.MaliyetButceID, ab.AltButceAdi, (select TahminiBitisBedeliTutari from Maliyet.ProjeAltButceTahminiBitisBedeli where Guncellendi = 0 and Silindi = 0 and MaliyetAltButceID = ab.MaliyetAltButceID and ProjeID = '"& projeId &"') as TahminiBitisBedeli, (select MaliyetProjeAltButceTahminiBitisBedeliID from Maliyet.ProjeAltButceTahminiBitisBedeli where Guncellendi = 0 and Silindi = 0 and MaliyetAltButceID = ab.MaliyetAltButceID and ProjeID = '"& projeId &"') as MaliyetProjeAltButceTahminiBitisBedeliID, (select MaliyetProjeTahminiBitisBedeliID from Maliyet.ProjeAltButceTahminiBitisBedeli where Guncellendi = 0 and Silindi = 0 and MaliyetAltButceID = ab.MaliyetAltButceID and ProjeID = '"& projeId &"') as MaliyetProjeTahminiBitisBedeliID, (select ProjeID from Maliyet.ProjeTahminiBitisBedeli where Guncellendi = 0 and Silindi = 0 and ProjeID = '"& projeId &"') as ProjeID, (select MaliyetProjeTahminiBitisBedeliID from Maliyet.ProjeTahminiBitisBedeli where Guncellendi = 0 and Silindi = 0 and ProjeID = '"& projeId &"') as TahminiBitisBedeliID from Maliyet.AltButce ab where ab.Guncellendi = 0 and ab.Silindi = 0"
                set maliyetProjeAltButceTahminiBitisBedeli = baglanti.execute(SQL)
                
                if maliyetProjeAltButceTahminiBitisBedeli.eof then
        %>
        <tr>
            <td colspan="3" style="text-align: center">Kayıt Bulunamadı.</td>
        </tr>
        <%
                end if
                do while not maliyetProjeAltButceTahminiBitisBedeli.eof
                i = i + 1

                MaliyetProjeAltButceTahminiBitisBedeliID = 0
                if not maliyetProjeAltButceTahminiBitisBedeli("MaliyetProjeAltButceTahminiBitisBedeliID") = "" then
                    MaliyetProjeAltButceTahminiBitisBedeliID = maliyetProjeAltButceTahminiBitisBedeli("MaliyetProjeAltButceTahminiBitisBedeliID")
                end if
                SQL = "select SUM(TahminiBitisBedeliTutari) as TahminiBitisBedeliTutari from Maliyet.ProjeAltButceKalemTahminiBitisBedeli where Guncellendi = 0 and Silindi = 0 and MaliyetProjeAltButceTahminiBitisBedeliID = '"& MaliyetProjeAltButceTahminiBitisBedeliID &"'"
                set TahminiBitisBedeliTutari = baglanti.execute(SQL)

        %>
        <tr>
            <td><%=maliyetProjeAltButceTahminiBitisBedeli("AltButceAdi") %></td>
            <td>
                <input type="text" class="form-control form-control-sm priceText tahminibitis-bedeli-altbutce-tutar" value="<%if TahminiBitisBedeliTutari("TahminiBitisBedeliTutari") = "0,00" then %><%=maliyetProjeAltButceTahminiBitisBedeli("TahminiBitisBedeli") %><%else %><%=TahminiBitisBedeliTutari("TahminiBitisBedeliTutari") %><%end if %>" id="ProjeTahminiBitisBedeliAltButce<%=maliyetProjeAltButceTahminiBitisBedeli("MaliyetAltButceID") %>" <%if not TahminiBitisBedeliTutari("TahminiBitisBedeliTutari") = "0,00" then %> readonly="readonly" <%end if %> />
            </td>
            <td>
                <button class="btn btn-info btn-mini" id="btnProjeTahminiBitisBedeliDetayAc<%=maliyetProjeAltButceTahminiBitisBedeli("MaliyetAltButceID") %>"
                    onclick="ProjeTahminiBitisBedeliDetayAc('<%=maliyetProjeAltButceTahminiBitisBedeli("MaliyetAltButceID") %>');">
                    Detay</button>

                <%if IsNull(TahminiBitisBedeliTutari("TahminiBitisBedeliTutari")) then %>
                <button class="btn btn-warning btn-mini" id="btnProjeTahminiBitisBedeliDuzenle<%=maliyetProjeAltButceTahminiBitisBedeli("MaliyetAltButceID") %>"
                    onclick="projeTahminiBitisBedeliAltButceGuncelle('<%=maliyetProjeAltButceTahminiBitisBedeli("MaliyetProjeTahminiBitisBedeliID") %>', '<%=maliyetProjeAltButceTahminiBitisBedeli("MaliyetProjeAltButceTahminiBitisBedeliID") %>', '<%=projeId %>', '<%=maliyetProjeAltButceTahminiBitisBedeli("MaliyetAltButceID") %>', '<%=maliyetProjeAltButceTahminiBitisBedeli("MaliyetButceID") %>', '<%=maliyetProjeAltButceTahminiBitisBedeli("TahminiBitisBedeliID") %>', '<%=i %>');">
                    Düzenle</button>
                <%end if %>
            </td>
        </tr>
        <tr>
            <td colspan="3" class="tdDetail" id="ProjeTahminiBitisBedeliDetaytd<%=maliyetProjeAltButceTahminiBitisBedeli("MaliyetAltButceID") %>" style="display: none; background-color: #ececec">
                <div class="row pl-4 pr-4 pt-4 divDetail" id="ProjeTahminiBitisBedeliDetaydiv<%=maliyetProjeAltButceTahminiBitisBedeli("MaliyetAltButceID") %>" style="display: none">
                    <div class="col-md-12" id="projeTahminiBitisBedeliAltKalem<%=maliyetProjeAltButceTahminiBitisBedeli("MaliyetAltButceID") %>">
                        <table class="table table-bordered table-mini" id="projeTahminiBitisBedeliAltKalemTable<%=maliyetProjeAltButceTahminiBitisBedeli("MaliyetAltButceID") %>">
                            <thead>
                                <tr>
                                    <th>Adı</th>
                                    <th style="width: 120px">Tutar</th>
                                    <th>İşlem</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                        SQL = "select abk.MaliyetAltButceKalemID, abk.MaliyetAltButceID, AltButceKalemAdi, (select TahminiBitisBedeliTutari from Maliyet.ProjeAltButceKalemTahminiBitisBedeli where Guncellendi = 0 and Silindi = 0 and MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and ProjeID = '"& projeId &"') as TahminiBitisBedeliTutari, (select MaliyetProjeAltButceKalemTahminiBitisBedeliID from Maliyet.ProjeAltButceKalemTahminiBitisBedeli where Guncellendi = 0 and Silindi = 0 and MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and ProjeID = '"& projeId &"') as MaliyetProjeAltButceKalemTahminiBitisBedeliID, (select MaliyetProjeAltButceTahminiBitisBedeliID from Maliyet.ProjeAltButceKalemTahminiBitisBedeli where Guncellendi = 0 and Silindi = 0 and MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and ProjeID = '"& projeId &"') as MaliyetProjeAltButceTahminiBitisBedeliID, (select ProjeID from Maliyet.ProjeTahminiBitisBedeli where Guncellendi = 0 and Silindi = 0 and ProjeID = '"& projeId &"') as ProjeID from Maliyet.AltButceKalem abk where abk.Guncellendi = 0 and abk.Silindi = 0 and abk.MaliyetAltButceID = '"& maliyetProjeAltButceTahminiBitisBedeli("MaliyetAltButceID") &"'"
                                        set ProjeTahminiBitisAltButceKalem = baglanti.execute(SQL)
                                        
                                        if ProjeTahminiBitisAltButceKalem.eof then
                                %>
                                <tr>
                                    <td colspan="3" style="text-align: center">Kayıt Bulunamadı.</td>
                                </tr>
                                <%
                                        end if
                                        do while not ProjeTahminiBitisAltButceKalem.eof
                                %>
                                <tr>
                                    <td><%=ProjeTahminiBitisAltButceKalem("AltButceKalemAdi") %></td>
                                    <td>
                                        <input type="text" class="form-control form-control-sm priceText" value="<%if IsNull(ProjeTahminiBitisAltButceKalem("TahminiBitisBedeliTutari")) then %>0,00<%else %><%=ProjeTahminiBitisAltButceKalem("TahminiBitisBedeliTutari") %><%end if %>" id="TahminiBitisBedeliAlButceKalemTutar<%=ProjeTahminiBitisAltButceKalem("MaliyetAltButceKalemID") %>" />
                                    </td>
                                    <td>

                                        <button class="btn btn-warning btn-mini" onclick="projeTahminiBitisBedeliAltButceKalemGuncelle('<%=ProjeTahminiBitisAltButceKalem("MaliyetAltButceKalemID") %>', '<%=ProjeTahminiBitisAltButceKalem("MaliyetAltButceID") %>', '<%=ProjeTahminiBitisAltButceKalem("MaliyetProjeAltButceKalemTahminiBitisBedeliID") %>', '<%=maliyetProjeAltButceTahminiBitisBedeli("MaliyetProjeAltButceTahminiBitisBedeliID") %>', '<%=projeId %>')">Düzenle</button>

                                        <button class="btn btn-danger btn-mini" onclick="ProjeTahminiBitisBedeliAltKelemSil('<%=ProjeTahminiBitisAltButceKalem("MaliyetAltButceKalemID") %>', '<%=ProjeTahminiBitisAltButceKalem("MaliyetAltButceID") %>', '<%=ProjeTahminiBitisAltButceKalem("MaliyetProjeAltButceKalemTahminiBitisBedeliID") %>', '<%=maliyetProjeAltButceTahminiBitisBedeli("MaliyetProjeAltButceTahminiBitisBedeliID") %>', '<%=projeId %>')">Sil</button>
                                    </td>
                                </tr>
                                <%
                                        ProjeTahminiBitisAltButceKalem.movenext
                                        loop
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
        <%
                maliyetProjeAltButceTahminiBitisBedeli.movenext
                loop
        %>
    </tbody>
    <script type="text/javascript">
        $(".priceText").maskMoney({ allowNegative: true, thousands: '', decimal: ',', affixesStay: false });
        $(".priceText").focus();

        var total = 0;
        var tutar = 0;
        $(".tahminibitis-bedeli-altbutce-tutar").each(function () {
            if ($(this).val() === "") {
                tutar = 0;
            }
            else {
                tutar = $(this).val();
            }
            total += parseFloat(tutar);
            $("#txtProjeTahminiBitisBedeli").val(total);
        });
        if (total > 0) {
            $("#btnProjeTahminiBitisEkle").hide();
        }
    </script>
</table>
<%
    elseif trn(request("islem")) = "ProjeTahminiBitisBedeliTutarDuzenle" then

        if trn(request("MaliyetProjeTahminiBitisBedeliID")) = "" then
            MaliyetProjeTahminiBitisBedeliID = 0
        else
            MaliyetProjeTahminiBitisBedeliID = trn(request("MaliyetProjeTahminiBitisBedeliID"))
        end if
        if trn(request("MaliyetProjeAltButceTahminiBitisBedeliID")) = "" then
            MaliyetProjeAltButceTahminiBitisBedeliID = 0
        else
            MaliyetProjeAltButceTahminiBitisBedeliID = trn(request("MaliyetProjeAltButceTahminiBitisBedeliID"))
        end if
        ProjeID = trn(request("ProjeID"))
        MaliyetAltButceID = trn(request("MaliyetAltButceID"))
        MaliyetButceID = trn(request("MaliyetButceID"))
        TahminiBitisBedeliID = trn(request("TahminiBitisBedeliID"))
        i = trn(request("i"))

        SQL = "select * from Maliyet.ProjeAltButceTahminiBitisBedeli where MaliyetProjeAltButceTahminiBitisBedeliID = '"& MaliyetProjeAltButceTahminiBitisBedeliID &"' and MaliyetProjeTahminiBitisBedeliID = '"& MaliyetProjeTahminiBitisBedeliID &"' and ProjeID = '"& ProjeID &"'"
        set ProjeTahminiBitisBedeliTutari = baglanti.execute(SQL)
%>
<div class="modal-header">
    <%=LNG("Tahmini Bitiş Alt Bütçe Düzenle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="butce_hesabi_ekleme_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="col-form-label">Tutar</label>
                <input type="text" class="form-control" id="projeTahminiBitisBedeliTutar" value="<%if ProjeTahminiBitisBedeliTutari.eof then %>0.00<%else %><%=ProjeTahminiBitisBedeliTutari("TahminiBitisBedeliTutari") %><%end if %>" placeholder="0,00" />
            </div>
        </div>
    </div>
    <div class="modal-footer pb-0 pr-0">
        <button type="button" class="btn btn-info btn-mini" onclick="projeTahminiBitisBedeliAltButceGuncelle('<%=MaliyetProjeTahminiBitisBedeliID %>', '<%=MaliyetProjeAltButceTahminiBitisBedeliID %>', '<%=ProjeID %>', '<%=MaliyetAltButceID %>', '<%=MaliyetButceID %>', '<%=TahminiBitisBedeliID %>', '<%=i %>');">Güncelle</button>
    </div>
    <script type="text/javascript">
        $("#projeTahminiBitisBedeliTutar").maskMoney({ allowNegative: true, thousands: '', decimal: ',', affixesStay: false });
        $("#projeTahminiBitisBedeliTutar").focus();
    </script>
</form>
<%
    elseif trn(request("islem")) = "ProjeTahminiBitisBedeliTutar" then

        MaliyetProjeTahminiBitisBedeliID = trn(request("MaliyetProjeTahminiBitisBedeliID"))
        MaliyetProjeAltButceTahminiBitisBedeliID = trn(request("MaliyetProjeAltButceTahminiBitisBedeliID"))
        ProjeID = trn(request("ProjeID"))
        MaliyetAltButceID = trn(request("MaliyetAltButceID"))
        MaliyetButceID = trn(request("MaliyetButceID"))
        TahminiBitisBedeliID = trn(request("TahminiBitisBedeliID"))
        i = trn(request("i"))
        projeTahminiBitisBedeliTutar = trn(request("projeTahminiBitisBedeliTutar"))
        kullaniciID = Request.Cookies("kullanici")("kullanici_id")


        if trn(request("islem2")) = "Guncelle" then
            SQL = "select * from Maliyet.ProjeAltButceTahminiBitisBedeli where MaliyetProjeAltButceTahminiBitisBedeliID = '"& MaliyetProjeAltButceTahminiBitisBedeliID &"' and MaliyetProjeTahminiBitisBedeliID = '"& MaliyetProjeTahminiBitisBedeliID &"' and ProjeID = '"& ProjeID &"' and Guncellendi = 0 and Silindi = 0"
            set ProjeTahminiBitisBedeliTutariKontrol = baglanti.execute(SQL)
        'response.Write(SQL)

            if ProjeTahminiBitisBedeliTutariKontrol.eof then
                SQL = "insert into Maliyet.ProjeAltButceTahminiBitisBedeli(MaliyetProjeTahminiBitisBedeliID, ProjeID, MaliyetAltButceId, TahminiBitisBedeliTutari, OlusturanKullaniciID) values('"& TahminiBitisBedeliID &"', '"& ProjeID &"', '"& MaliyetAltButceID &"', '"& projeTahminiBitisBedeliTutar &"', '"& kullaniciID &"')"
                set ProjeTahminiBitisBedeliTutariEkleme = baglanti.execute(SQL)
            else
                SQL = "update Maliyet.ProjeAltButceTahminiBitisBedeli set TahminiBitisBedeliTutari = '"& projeTahminiBitisBedeliTutar &"' where MaliyetProjeAltButceTahminiBitisBedeliID = '"& MaliyetProjeAltButceTahminiBitisBedeliID &"' and MaliyetProjeTahminiBitisBedeliID = '"& MaliyetProjeTahminiBitisBedeliID &"' and ProjeID = '"& ProjeID &"'"
                set ProjeTahminiBitisBedeliTutariGuncelleme = baglanti.execute(SQL)
            end if
        end if
    elseif trn(request("islem")) = "ProjeTahminiBitisBedeliAltKelem" then

        MaliyetAltButceKalemID = trn(request("MaliyetAltButceKalemID"))
        MaliyetAltButceID = trn(request("MaliyetAltButceID"))
        MaliyetProjeAltButceKalemTahminiBitisBedeliID = trn(request("MaliyetProjeAltButceKalemTahminiBitisBedeliID"))
        MaliyetProjeAltButceTahminiBitisBedeliID = trn(request("MaliyetProjeAltButceTahminiBitisBedeliID"))
        ProjeID = trn(request("ProjeID"))

        SQL = "select * from Maliyet.ProjeAltButceKalemTahminiBitisBedeli where MaliyetProjeAltButceKalemTahminiBitisBedeliID = '"& MaliyetProjeAltButceKalemTahminiBitisBedeliID &"' and MaliyetProjeAltButceTahminiBitisBedeliID = '"& MaliyetProjeAltButceTahminiBitisBedeliID &"' and ProjeID = '"& ProjeID &"' and MaliyetAltButceKalemID = '"& MaliyetAltButceKalemID &"' and Guncellendi = 0 and Silindi = 0"
        set ProjeTahminiBitisBedeliAltKelemCek = baglanti.execute(SQL)
%>
<div class="modal-header">
    Tahmini Bitiş Alt Bütçe Kalem Düzenle
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="butce_hesabi_ekleme_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <label class="col-form-label">Tutar</label>
                <input type="text" class="form-control" id="projeTahminiBitisBedeliAltKalemTutari" value="<%if ProjeTahminiBitisBedeliAltKelemCek.eof then %>0.00<%else %><%=ProjeTahminiBitisBedeliAltKelemCek("TahminiBitisBedeliTutari") %><%end if %>" placeholder="0,00" />
            </div>
        </div>
    </div>
    <div class="modal-footer pb-0 pr-0">
        <button type="button" class="btn btn-info btn-mini" onclick="projeTahminiBitisBedeliAltButceKalemGuncelle('<%=MaliyetAltButceKalemID %>', '<%=MaliyetAltButceID %>', '<%=MaliyetProjeAltButceKalemTahminiBitisBedeliID %>', '<%=MaliyetProjeAltButceTahminiBitisBedeliID %>', '<%=ProjeID %>');">Güncelle</button>
    </div>
    <script type="text/javascript">
        $("#projeTahminiBitisBedeliAltKalemTutari").maskMoney({ allowNegative: true, thousands: '', decimal: ',', affixesStay: false });
        $("#projeTahminiBitisBedeliAltKalemTutari").focus();
    </script>
</form>
<%
    elseif trn(request("islem")) = "ProjeTahminiBitisBedeliAltKalemTutar" then

        MaliyetAltButceKalemID = trn(request("MaliyetAltButceKalemID"))
        MaliyetAltButceID = trn(request("MaliyetAltButceID"))
        MaliyetProjeAltButceKalemTahminiBitisBedeliID = trn(request("MaliyetProjeAltButceKalemTahminiBitisBedeliID"))
        MaliyetProjeAltButceTahminiBitisBedeliID = trn(request("MaliyetProjeAltButceTahminiBitisBedeliID"))
        ProjeID = trn(request("ProjeID"))
        projeTahminiBitisBedeliAltKalemTutari = trn(request("projeTahminiBitisBedeliAltKalemTutari"))
        kullaniciID = Request.Cookies("kullanici")("kullanici_id")

        if trn(request("islem2")) = "Guncelle" then
            SQL = "select * from Maliyet.ProjeAltButceKalemTahminiBitisBedeli where MaliyetProjeAltButceKalemTahminiBitisBedeliID = '"& MaliyetProjeAltButceKalemTahminiBitisBedeliID &"' and MaliyetProjeAltButceTahminiBitisBedeliID = '"& MaliyetProjeAltButceTahminiBitisBedeliID &"' and ProjeID = '"& ProjeID &"' and MaliyetAltButceKalemID = '"& MaliyetAltButceKalemID &"'"
            set ProjeTahminiBitisBedeliAltKalemKontrol = baglanti.execute(SQL)

            if ProjeTahminiBitisBedeliAltKalemKontrol.eof then
                SQL = "insert into Maliyet.ProjeAltButceKalemTahminiBitisBedeli(MaliyetProjeAltButceTahminiBitisBedeliID, ProjeID, MaliyetAltButceKalemID, TahminiBitisBedeliTutari, OlusturanKullaniciID) values('"& MaliyetProjeAltButceTahminiBitisBedeliID &"', '"& ProjeID &"', '"& MaliyetAltButceKalemID &"', '"& projeTahminiBitisBedeliAltKalemTutari &"', '"& kullaniciID &"')"
                set ProjeTahminiBitisBedeliAltKalemEkle = baglanti.execute(SQL)
            else
                SQL = "update Maliyet.ProjeAltButceKalemTahminiBitisBedeli set TahminiBitisBedeliTutari = '"& projeTahminiBitisBedeliAltKalemTutari &"' where MaliyetProjeAltButceKalemTahminiBitisBedeliID = '"& MaliyetProjeAltButceKalemTahminiBitisBedeliID &"' and MaliyetProjeAltButceTahminiBitisBedeliID = '"& MaliyetProjeAltButceTahminiBitisBedeliID &"' and ProjeID = '"& ProjeID &"' and MaliyetAltButceKalemID = '"& MaliyetAltButceKalemID &"'"
                set ProjeTahminiBitisBedeliAltKalemGuncelle = baglanti.execute(SQL)
            end if
        elseif trn(request("islem2")) = "Sil" then
            SQL = "update Maliyet.ProjeAltButceKalemTahminiBitisBedeli set Guncellendi = '1', Silindi = '1' where MaliyetProjeAltButceKalemTahminiBitisBedeliID = '"& MaliyetProjeAltButceKalemTahminiBitisBedeliID &"' and MaliyetProjeAltButceTahminiBitisBedeliID = '"& MaliyetProjeAltButceTahminiBitisBedeliID &"' and ProjeID = '"& ProjeID &"' and MaliyetAltButceKalemID = '"& MaliyetAltButceKalemID &"'"
            set ProjeTahminiBitisBedeliAltKalemGuncelle = baglanti.execute(SQL)
        end if
%>
<table class="table table-bordered table-mini">
    <thead>
        <tr>
            <th>Adı</th>
            <th style="width: 120px">Tutar</th>
            <th>İşlem</th>
        </tr>
    </thead>
    <tbody>
        <%
                SQL = "select abk.MaliyetAltButceKalemID, abk.MaliyetAltButceID, AltButceKalemAdi, (select TahminiBitisBedeliTutari from Maliyet.ProjeAltButceKalemTahminiBitisBedeli where Guncellendi = 0 and Silindi = 0 and MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and ProjeID = '"& ProjeID &"') as TahminiBitisBedeliTutari, (select MaliyetProjeAltButceKalemTahminiBitisBedeliID from Maliyet.ProjeAltButceKalemTahminiBitisBedeli where Guncellendi = 0 and Silindi = 0 and MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and ProjeID = '"& ProjeID &"') as MaliyetProjeAltButceKalemTahminiBitisBedeliID, (select MaliyetProjeAltButceTahminiBitisBedeliID from Maliyet.ProjeAltButceKalemTahminiBitisBedeli where Guncellendi = 0 and Silindi = 0 and MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and ProjeID = '"& ProjeID &"') as MaliyetProjeAltButceTahminiBitisBedeliID, (select ProjeID from Maliyet.ProjeTahminiBitisBedeli where Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as ProjeID from Maliyet.AltButceKalem abk where abk.Guncellendi = 0 and abk.Silindi = 0 and abk.MaliyetAltButceID = '"& MaliyetAltButceID &"'"
                set ProjeTahminiBitisAltButceKalem = baglanti.execute(SQL)

                if ProjeTahminiBitisAltButceKalem.eof then
        %>
        <tr>
            <td colspan="3" style="text-align: center">Kayıt Bulunamadı.</td>
        </tr>
        <%
                end if
                do while not ProjeTahminiBitisAltButceKalem.eof
        %>
        <tr>
            <td><%=ProjeTahminiBitisAltButceKalem("AltButceKalemAdi") %></td>
            <td>
                <input type="text" class="form-control form-control-sm priceText" value="<%if IsNull(ProjeTahminiBitisAltButceKalem("TahminiBitisBedeliTutari")) then %>0,00<%else %><%=ProjeTahminiBitisAltButceKalem("TahminiBitisBedeliTutari") %><%end if %>" id="TahminiBitisBedeliAlButceKalemTutar<%=ProjeTahminiBitisAltButceKalem("MaliyetAltButceKalemID") %>" />
            </td>
            <td>
                <button class="btn btn-warning btn-mini" onclick="projeTahminiBitisBedeliAltButceKalemGuncelle('<%=ProjeTahminiBitisAltButceKalem("MaliyetAltButceKalemID") %>', '<%=ProjeTahminiBitisAltButceKalem("MaliyetAltButceID") %>', '<%=ProjeTahminiBitisAltButceKalem("MaliyetProjeAltButceKalemTahminiBitisBedeliID") %>', '<%=ProjeTahminiBitisAltButceKalem("MaliyetProjeAltButceTahminiBitisBedeliID") %>', '<%=ProjeID %>')">Düzenle</button>

                <button class="btn btn-danger btn-mini" onclick="ProjeTahminiBitisBedeliAltKelemSil('<%=ProjeTahminiBitisAltButceKalem("MaliyetAltButceKalemID") %>', '<%=ProjeTahminiBitisAltButceKalem("MaliyetAltButceID") %>', '<%=ProjeTahminiBitisAltButceKalem("MaliyetProjeAltButceKalemTahminiBitisBedeliID") %>', '<%=ProjeTahminiBitisAltButceKalem("MaliyetProjeAltButceTahminiBitisBedeliID") %>', '<%=ProjeID %>')">Sil</button>
            </td>
        </tr>
        <%
                ProjeTahminiBitisAltButceKalem.movenext
                loop
        %>
    </tbody>
    <script type="text/javascript">
        $(".priceText").maskMoney({ allowNegative: true, thousands: '', decimal: ',', affixesStay: false });
        $(".priceText").focus();
    </script>
</table>
<%
    elseif trn(request("islem")) = "SatinalmaAltButceDuzenle" then
        
        MaliyetAltButceID = trn(request("MaliyetAltButceID"))
        if trn(request("SatinalmaAltButceID")) = "" then
            SatinalmaAltButceID = 0
        else
            SatinalmaAltButceID = trn(request("SatinalmaAltButceID"))
        end if
        if trn(request("SatinalmaButceID")) = "" then
            SatinalmaButceID = 0
        else
            SatinalmaButceID = trn(request("SatinalmaButceID"))
        end if
        projeId = trn(request("projeId"))
        satinalmaAltButceTutari = trn(request("satinalmaAltButceTutari"))
        kullaniciID = Request.Cookies("kullanici")("kullanici_id")

        if trn(request("islem2")) = "Guncelle" then

            SQL = "select * from Maliyet.SatinalmaAltButce where SatinalmaAltButceID = '"& SatinalmaAltButceID &"' and SatinalmaButceID = '"& SatinalmaButceID &"' and MaliyetAltButceID = '"& MaliyetAltButceID &"'"
            set SatinalmaAltButceKontrol = baglanti.execute(SQL)

            if SatinalmaAltButceKontrol.eof then
                SQL = "insert into Maliyet.SatinalmaAltButce(SatinalmaButceID, MaliyetAltButceID, SatinalmaAltButceTutari, OlusturanKullaniciID) values('"& SatinalmaButceID &"', '"& MaliyetAltButceID &"', '"& satinalmaAltButceTutari &"', '"& kullaniciID &"')"
                set SatinalmaAltButceEkleme = baglanti.execute(SQL)
            else
                SQL = "update Maliyet.SatinalmaAltButce set SatinalmaAltButceTutari = '"& satinalmaAltButceTutari &"', GuncelleyenKullaniciID = '"& kullaniciID &"' where SatinalmaAltButceID = '"& SatinalmaAltButceID &"' and SatinalmaButceID = '"& SatinalmaButceID &"' and MaliyetAltButceID = '"& MaliyetAltButceID &"'"
                set SatinalmaAltButceGuncelle = baglanti.execute(SQL)
            end if

        end if

    elseif trn(request("islem")) = "SatinalmaAltButceKalem" then

        MaliyetAltButceKalemID = trn(request("MaliyetAltButceKalemID"))
        MaliyetAltButceID = trn(request("MaliyetAltButceID"))
        if trn(request("SatinalmaAltButceKalemID")) = "" then
            SatinalmaAltButceKalemID = 0
        else
            SatinalmaAltButceKalemID = trn(request("SatinalmaAltButceKalemID"))
        end if
        SatinalmaAltButceKalemID = trn(request("SatinalmaAltButceKalemID"))
        SatinalmaAltButceID = trn(request("SatinalmaAltButceID"))
        satinalmaAltButceKalemTutari = trn(request("satinalmaAltButceKalemTutari"))
        kullaniciID = Request.Cookies("kullanici")("kullanici_id")

        if trn(request("islem2")) = "Guncelle" then
            SQL = "select * from Maliyet.SatinalmaAltButceKalem where SatinalmaAltButceKalemID = '"& SatinalmaAltButceKalemID &"' and SatinalmaAltButceID = '"& SatinalmaAltButceID &"' and MaliyetAltButceKalemID = '"& MaliyetAltButceKalemID &"'"
            set SatinalmaAltButceKalemKontrol = baglanti.execute(SQL)

            if SatinalmaAltButceKalemKontrol.eof then
                SQL = "insert into Maliyet.SatinalmaAltButceKalem(SatinalmaAltButceID, MaliyetAltButceKalemID, SatinalmaAltButceKalemTutari, OlusturanKullaniciID) values('"& SatinalmaAltButceID &"', '"& MaliyetAltButceKalemID &"', '"& satinalmaAltButceKalemTutari &"', '"& kullaniciID &"')"
                set SatinalmaAltButceKalemEkleme = baglanti.execute(SQL)
            else
                SQL = "update Maliyet.SatinalmaAltButceKalem set SatinalmaAltButceKalemTutari = '"& satinalmaAltButceKalemTutari &"', GuncelleyenKullaniciID = '"& kullaniciID &"' where SatinalmaAltButceKalemID = '"& SatinalmaAltButceKalemID &"' and SatinalmaAltButceID = '"& SatinalmaAltButceID &"' and MaliyetAltButceKalemID = '"& MaliyetAltButceKalemID &"'"
                set SatinalmaAltButceKalemGuncelleme = baglanti.execute(SQL)
            end if
        elseif trn(request("islem2")) = "Sil" then
            SQL = "update Maliyet.SatinalmaAltButceKalem set Guncellendi = 1, GuncelleyenKullaniciID = '"& kullaniciID &"' where SatinalmaAltButceKalemID = '"& SatinalmaAltButceKalemID &"' and SatinalmaAltButceID = '"& SatinalmaAltButceID &"' and MaliyetAltButceKalemID = '"& MaliyetAltButceKalemID &"'"
            set SatinalmaAltButceSil = baglanti.execute(SQL)
        end if
    'Tahsilat
    elseif trn(request("islem")) = "TahsilatKaydi" then

        TahsilatTipi = trn(request("TahsilatTipi"))
        TahsilatTarih = trn(request("Tarih"))
        Meblag = trn(request("Meblag"))
        VadeTarihi = trn(request("VadeTarihi"))
        ParaBirimi = trn(request("ParaBirimi"))
        Aciklama = trn(request("Aciklama"))
        kullaniciID = Request.Cookies("kullanici")("kullanici_id")
        ProjeID = trn(request("ProjeID"))
        MaliyetTahsilatID = trn(request("MaliyetTahsilatID"))

        if trn(request("islem2")) = "Ekle" then
            SQL = "insert into Maliyet.Tahsilat(MaliyetTahsilatTipiID, MaliyetParaBirimiID, ProjeID, TahsilatTutari, TahsilatTarihi, VadeTarihi, Aciklama, OlusturanKullaniciID) values('"& TahsilatTipi &"', '"& ParaBirimi &"', '"& ProjeID &"', '"& Meblag &"', CONVERT(date, '"& TahsilatTarih &"', 103), CONVERT(date, '"& VadeTarihi &"', 103), '"& Aciklama &"', '"& kullaniciID &"')"
            set TahsilatEkle = baglanti.execute(SQL)
        elseif trn(request("islem2")) = "Guncelle" then
            SQL = "update Maliyet.Tahsilat set MaliyetTahsilatTipiID = '"& TahsilatTipi &"', MaliyetParaBirimiID = '"& ParaBirimi &"', TahsilatTutari = '"& Meblag &"', TahsilatTarihi = CONVERT(date, '"& TahsilatTarih &"', 103), VadeTarihi = CONVERT(date, '"& VadeTarihi &"', 103), Aciklama = '"& Aciklama &"', GuncelleyenKullaniciID = '"& kullaniciID &"' where MaliyetTahsilatID = '"& MaliyetTahsilatID &"' and ProjeID = '"& ProjeID &"'"
            set TahsilatGuncelle = baglanti.execute(SQL)
        elseif trn(request("islem2")) = "Sil" then
            SQL = "update Maliyet.Tahsilat set Guncellendi = 1, Silindi = 1, GuncelleyenKullaniciID = '"& kullaniciID &"' where MaliyetTahsilatID = '"& MaliyetTahsilatID &"' and ProjeID = '"& ProjeID &"'"
            set TahsilatSil = baglanti.execute(SQL)
        end if
%>
<div class="dt-responsive table-responsive">
    <table class="table table-bordered table-mini datatableyap text-nowrap" style="width: 100%">
        <thead>
            <tr>
                <td>ID</td>
                <td>Tahasilat Tutari</td>
                <td>Tahsilat Tarihi</td>
                <td>Vade Tarihi</td>
                <td>Para Birimi</td>
                <td>Tahsilat Tipi</td>
                <td>Açıklama</td>
                <td>İşlemler</td>
            </tr>
        </thead>
        <tbody>
            <%
                SQL = "select t.MaliyetTahsilatID, t.TahsilatTarihi, t.TahsilatTutari, t.VadeTarihi, t.Aciklama, tt.TahsilatTipi, pb.ParaBirimi from Maliyet.Tahsilat t inner join Maliyet.TahsilatTipi tt on tt.MaliyetTahsilatTipiID = t.MaliyetTahsilatTipiID inner join Maliyet.ParaBirimi pb on pb.MaliyetParaBirimiID = t.MaliyetParaBirimiID where t.Guncellendi = 0 and t.Silindi = 0 and t.ProjeID = '"& ProjeID &"'"
                set TahsilatListesi = baglanti.execute(SQL)

                i = 0
                if TahsilatListesi.eof then
            %>
            <tr>
                <td colspan="8" style="text-align: center">Kayıt Bulunamadı.</td>
            </tr>
            <%
                end if
                do while not TahsilatListesi.eof
                i = i + 1
            %>
            <tr>
                <td><%=i %></td>
                <td><%=TahsilatListesi("TahsilatTutari") %></td>
                <td><%=TahsilatListesi("TahsilatTarihi") %></td>
                <td><%=TahsilatListesi("VadeTarihi") %></td>
                <td><%=TahsilatListesi("ParaBirimi") %></td>
                <td><%=TahsilatListesi("TahsilatTipi") %></td>
                <td><%=TahsilatListesi("Aciklama") %></td>
                <td>
                    <button type="button" class="btn btn-info btn-mini" onclick="TahsilatKaydiDuzenle('<%=TahsilatListesi("MaliyetTahsilatID") %>', '<%=ProjeID %>');">Düzenle</button>
                    <button type="button" class="btn btn-danger btn-mini" onclick="TahsilatKaydiSil('<%=TahsilatListesi("MaliyetTahsilatID") %>', '<%=ProjeID %>')">Sil</button>
                </td>
            </tr>
            <%
                TahsilatListesi.movenext
                loop
            %>
        </tbody>
    </table>
</div>
<%
    elseif trn(request("islem")) = "TahsilatKaydiForm" then

        ProjeID = trn(request("ProjeID"))
%>
<div class="form-group border p-2">
    <style type="text/css">
        input[type=radio] {
            position: absolute;
            margin: 0px 0px 0px;
            margin-left: -20px;
            width: 17px;
            height: 17px;
        }

        .radio-inline {
            margin-right: 30px;
            cursor: pointer;
        }
    </style>
    <div class="col-md-12">
        <div class="col-md-12 text-center p-1 p-t-0">
            <label id="TahsilatFormTitle" class="col-form-label font-weight-bold" style="font-size: 15px">
                Tahsilat Kaydı Ekleme Formu
            </label>
        </div>
        <hr class="m-t-1 m-b-1" />
        <div class="col-md-12">
            <%
                    SQL = "select * from Maliyet.TahsilatTipi where Guncellendi = 0 and Silindi = 0"
                    set TahsilatTipi = baglanti.execute(SQL)

                    i = 0
                    if TahsilatTipi.eof then
            %>
            <label class="radio-inline">
                <input type="radio" name="optradio" checked onclick="tahsilatTipiSec(1);" id="1">Nakit Tahsilat</label>
            <label class="radio-inline">
                <input type="radio" name="optradio" onclick="tahsilatTipiSec(2);" id="2">Çek Tahsilat</label>
            <label class="radio-inline">
                <input type="radio" name="optradio" onclick="tahsilatTipiSec(3);" id="3">Senet Tahsilat</label>
            <label class="radio-inline">
                <input type="radio" name="optradio" onclick="tahsilatTipiSec(4);" id="4">Kredi Kartı</label>
            <%
                    end if
                    do while not TahsilatTipi.eof
                    i = i + 1
            %>
            <label class="radio-inline">
                <input type="radio" name="optradio" <%if i = 1 then %> checked <%end if%> onclick="tahsilatTipiSec(<%=i %>);" id="<%=TahsilatTipi("MaliyetTahsilatTipiID") %>" />
                <%=TahsilatTipi("TahsilatTipi") %>
            </label>
            <%
                    TahsilatTipi.movenext
                    loop
            %>
        </div>
    </div>
    <script type="text/javascript">

        function tahsilatTipiSec(tip) {
            if (tip === 1) {
                $("#vade_tarihi_yeri").hide();
            }
            else if (tip === 2) {
                $("#vade_tarihi_yeri").show();
            }
            else if (tip === 3) {
                $("#vade_tarihi_yeri").hide();
            }
            else if (tip === 4) {
                $("#vade_tarihi_yeri").hide();
            }
        }
    </script>
    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Tarih")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-calendar"></i>
                </span>
                <input type="text" id="islem_tarihi" value="<%=FormatDate(date, "00")%>" class="form-control takvimyap" />
            </div>
        </div>
    </div>
    <div class="row" id="vade_tarihi_yeri" style="display: none;">
        <label class="col-sm-12 col-form-label"><%=LNG("Vade Tarihi")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-calendar"></i>
                </span>
                <input type="text" id="vade_tarihi" value="<%=FormatDate(date, "00")%>" class="form-control takvimyap" />
            </div>
        </div>
    </div>
    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Meblağ")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-money"></i>
                </span>
                <input type="text" name="meblag" id="meblag" required class="form-control" />
            </div>

        </div>
    </div>
    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Para birimi :")%></label>
        <div class="col-sm-12">
            <select class="select2" name="parabirimi" id="parabirimi">
                <%
                        SQL = "select * from Maliyet.ParaBirimi where Guncellendi = 0 and Silindi = 0"
                        set ParaBirimi = baglanti.execute(SQL)

                        if ParaBirimi.eof then
                %>
                <option value="TL">TL</option>
                <option value="USD">USD</option>
                <option value="EUR">EUR</option>
                <%
                        end if
                        do while not ParaBirimi.eof
                %>
                <option value="<%=ParaBirimi("MaliyetParaBirimiID") %>"><%=ParaBirimi("ParaBirimi") %></option>
                <%
                        ParaBirimi.movenext
                        loop
                %>
            </select>
        </div>
    </div>
    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Açıklama")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <textarea id="aciklama" name="aciklama" class=" form-control" style="width: 100%; padding-left: 10px; padding-top: 6px;"></textarea>
            </div>
        </div>
    </div>
    <div class="col-md-12">
        <div class="row">
            <div class="form-group" style="text-align: end">
                <button type="button" id="btnTahsilatEkle" class="btn btn-success btn-mini float-right" onclick="TahsilatKaydiEkle('<%=ProjeID %>');">Kaydet</button>
                <button type="button" id="btnTahsilatDuzenle" class="btn btn-info btn-mini float-right" style="display: none">Düzenle</button>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $("#meblag").maskMoney({ allowNegative: true, thousands: '', decimal: ',', affixesStay: false });
        $("#meblag").focus();
    </script>
</div>
<%
    elseif trn(request("islem")) = "KarListesi" then

        ProjeID = trn(request("ProjeID"))
        if trn(request("islem2")) = "ekle" then

            MaliyetAltButceID = trn(request("MaliyetAltButceID"))
            MaliyetButceID = trn(request("MaliyetButceID"))
            AltButceOngorulenMaliyetTutari = trn(request("AltButceOngorulenMaliyetTutari"))
            AltButceOngorulenAnlasmaTutari = trn(request("AltButceOngorulenAnlasmaTutari"))
            AltButceOngorulenKarOrani = trn(request("AltButceOngorulenKarOrani"))
            kullaniciID = Request.Cookies("kullanici")("kullanici_id")

            if trn(request("MaliyetProjeAltButceOngorulenKarID")) = "" then
                MaliyetProjeAltButceOngorulenKarID = 0
            else
                MaliyetProjeAltButceOngorulenKarID = trn(request("MaliyetProjeAltButceOngorulenKarID"))
            end if
            if trn(request("MaliyetProjeOngorulenKarID")) = "" then
                MaliyetProjeOngorulenKarID = 0
            else
                MaliyetProjeOngorulenKarID = trn(request("MaliyetProjeOngorulenKarID"))
            end if

            SQL = "select * from Maliyet.ProjeAltButceOngorulenKar where MaliyetProjeAltButceOngorulenKarID = '"& MaliyetProjeAltButceOngorulenKarID &"' and MaliyetProjeOngorulenKarID = '"& MaliyetProjeOngorulenKarID &"' and ProjeID = '"& ProjeID &"' and Guncellendi = 0 and Silindi = 0"
            set ProjeAltButceOngorulenKarKontrol = baglanti.execute(SQL)
            if ProjeAltButceOngorulenKarKontrol.eof then
                SQL = "insert into Maliyet.ProjeAltButceOngorulenKar(MaliyetProjeOngorulenKarID, ProjeID, MaliyetAltButceID, AltButceOngorulenMaliyetTutari, AltButceOngorulenAnlasmaTutari, AltButceOngorulenKarOrani, OlusturanKullaniciID) values('"& MaliyetProjeOngorulenKarID &"', '"& ProjeID &"', '"& MaliyetAltButceID & "', '"& AltButceOngorulenMaliyetTutari &"', '"& AltButceOngorulenAnlasmaTutari &"', '"& AltButceOngorulenKarOrani &"', '"& kullaniciID &"')"
                set ProjeAltButceOngorulenKarEkle = baglanti.execute(SQL)
            else
                SQL = "update Maliyet.ProjeAltButceOngorulenKar set MaliyetProjeOngorulenKarID = '"& MaliyetProjeOngorulenKarID &"', ProjeID = '"& ProjeID &"', MaliyetAltButceID = '"& MaliyetAltButceID &"', AltButceOngorulenMaliyetTutari = '"& AltButceOngorulenMaliyetTutari &"', AltButceOngorulenAnlasmaTutari = '"& AltButceOngorulenAnlasmaTutari &"', AltButceOngorulenKarOrani = '"& AltButceOngorulenKarOrani &"', GuncelleyenKullaniciID = '"& kullaniciID &"' where MaliyetProjeAltButceOngorulenKarID = '"& MaliyetProjeAltButceOngorulenKarID &"' and MaliyetProjeOngorulenKarID = '"& MaliyetProjeOngorulenKarID &"' and ProjeID = '"& ProjeID &"' and MaliyetAltButceID = '"& MaliyetAltButceID &"'"
                set ProjeAltButceOngorulenKarGuncelleme = baglanti.execute(SQL)
            end if
        end if
%>
<table class="table table-bordered table-mini">
    <thead>
        <tr>
            <th>Bütçe Adı</th>
            <th style="width: 300px">Bütçe Tutarı</th>
            <th>İşlem</th>
        </tr>
    </thead>
    <tbody>
        <%
                SQL = "select ab.MaliyetAltButceID, ab.MaliyetButceID, ab.AltButceAdi, (select MaliyetProjeAltButceOngorulenKarID from Maliyet.ProjeAltButceOngorulenKar where MaliyetAltButceID = ab.MaliyetAltButceID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as MaliyetProjeAltButceOngorulenKarID, (select MaliyetProjeOngorulenKarID from Maliyet.ProjeOngorulenKar where MaliyetAltButceID = ab.MaliyetAltButceID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as MaliyetProjeOngorulenKarID, (select AltButceOngorulenMaliyetTutari from Maliyet.ProjeAltButceOngorulenKar where MaliyetAltButceID = ab.MaliyetAltButceID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as AltButceOngorulenMaliyetTutari, (select AltButceOngorulenAnlasmaTutari from Maliyet.ProjeAltButceOngorulenKar where MaliyetAltButceID = ab.MaliyetAltButceID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as AltButceOngorulenAnlasmaTutari, (select AltButceOngorulenKarOrani from Maliyet.ProjeAltButceOngorulenKar where MaliyetAltButceID = ab.MaliyetAltButceID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as AltButceOngorulenKarOrani from Maliyet.AltButce ab where ab.Guncellendi = 0 and ab.Silindi = 0"
                set projeOngorulenKar = baglanti.execute(SQL)
                if projeOngorulenKar.eof then
        %>
        <tr>
            <td colspan="3" style="text-align: center">Kayıt Bulunamadı.</td>
        </tr>
        <%
                end if
                do while not projeOngorulenKar.eof

                SQL = "select Sum(AltButceKalemOngorulenMaliyetTutari) as AltButceKalemOngorulenMaliyetTutari, sum(AltButceKalemOngorulenAnlasmaTutari) as AltButceKalemOngorulenAnlasmaTutari, sum(AltButceKalemOngorulenKarOrani) as AltButceKalemOngorulenKarOrani from Maliyet.ProjeAltButceKalemOngorulenKar where Guncellendi = 0 and Silindi = 0 and MaliyetProjeAltButceOngorulenKarID = '"& projeOngorulenKar("MaliyetProjeAltButceOngorulenKarID") &"'"
                set MaliyetProjeAltButceOngorulenKar = baglanti.execute(SQL)
        %>
        <tr>
            <td><%=projeOngorulenKar("AltButceAdi") %></td>
            <td style="display: flex">
                <input type="text" class="form-control form-control-sm mr-2 priceText AltButceKalem-Ongorulen-Maliyet-Tutari" id="AltButceOngorulenMaliyetTutari<%=projeOngorulenKar("MaliyetAltButceID") %>" value="<%if MaliyetProjeAltButceOngorulenKar("AltButceKalemOngorulenMaliyetTutari") = "0,00" then %><%=projeOngorulenKar("AltButceOngorulenMaliyetTutari") %><%else %><%=MaliyetProjeAltButceOngorulenKar("AltButceKalemOngorulenMaliyetTutari") %><%end if %>" onkeyup="AltButceOranHesapla('<%=projeOngorulenKar("MaliyetAltButceID") %>');"
                    <%if not IsNull(MaliyetProjeAltButceOngorulenKar("AltButceKalemOngorulenMaliyetTutari")) and not IsNull(MaliyetProjeAltButceOngorulenKar("AltButceKalemOngorulenMaliyetTutari")) then %> readonly <%end if %> />

                <input type="text" class="form-control form-control-sm mr-2 priceText AltButceKalem-Ongorulen-Anlasma-Tutari" id="AltButceOngorulenAnlasmaTutari<%=projeOngorulenKar("MaliyetAltButceID") %>" value="<%if MaliyetProjeAltButceOngorulenKar("AltButceKalemOngorulenAnlasmaTutari") then %><%=projeOngorulenKar("AltButceOngorulenAnlasmaTutari") %><%else %><%=MaliyetProjeAltButceOngorulenKar("AltButceKalemOngorulenAnlasmaTutari") %><%end if %>" onkeyup="AltButceOranHesapla('<%=projeOngorulenKar("MaliyetAltButceID") %>');"
                    <%if not IsNull(MaliyetProjeAltButceOngorulenKar("AltButceKalemOngorulenMaliyetTutari")) and not IsNull(MaliyetProjeAltButceOngorulenKar("AltButceKalemOngorulenMaliyetTutari")) then %> readonly <%end if %> />

                <input type="text" class="form-control form-control-sm priceText AltButceKalem-Ongorulen-Kar-Orani" id="AltButceOngorulenKarOrani<%=projeOngorulenKar("MaliyetAltButceID") %>" value="<%if MaliyetProjeAltButceOngorulenKar("AltButceKalemOngorulenKarOrani") then %><%=projeOngorulenKar("AltButceOngorulenKarOrani") %><%else %><%=MaliyetProjeAltButceOngorulenKar("AltButceKalemOngorulenKarOrani") %><%end if %>" readonly />
            </td>
            <td>
                <button class="btn btn-info btn-mini" onclick="MaliyetProjeAltButceOngorulenKarDetay('<%=projeOngorulenKar("MaliyetAltButceID") %>')">Detay</button>
                <%if IsNull(MaliyetProjeAltButceOngorulenKar("AltButceKalemOngorulenMaliyetTutari")) and IsNull(MaliyetProjeAltButceOngorulenKar("AltButceKalemOngorulenMaliyetTutari")) then %>
                <button class="btn btn-warning btn-mini" onclick="MaliyetProjeAltButceOngorulenKarDuzenle('<%=projeOngorulenKar("MaliyetAltButceID") %>', '<%=projeOngorulenKar("MaliyetButceID") %>', '<%=projeOngorulenKar("MaliyetProjeAltButceOngorulenKarID") %>', '<%=projeOngorulenKar("MaliyetProjeOngorulenKarID") %>', '<%=ProjeID %>')">Düzenle</button>
                <%end if %>
            </td>
        </tr>
        <tr>
            <td colspan="3" class="tdDetail" id="MaliyetProjeAltButceOngorulenKarDetayTd<%=projeOngorulenKar("MaliyetAltButceID") %>" style="background-color: #ececec; display: none">
                <div class="row pl-4 pr-4 pt-4 divDetail" id="MaliyetProjeAltButceOngorulenKarDetayDiv<%=projeOngorulenKar("MaliyetAltButceID") %>" style="display: none">
                    <div class="col-md-12" id="projeKarAltKalem">
                        <table class="table table-bordered table-mini" id="projeKarAltKalemTable<%=projeOngorulenKar("MaliyetAltButceID") %>">
                            <thead>
                                <tr>
                                    <th>Adı</th>
                                    <th style="width: 300px;">Tutar</th>
                                    <th>İşlem</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                        SQL = "select abk.MaliyetAltButceKalemID, abk.MaliyetAltButceID, abk.AltButceKalemAdi, (select MaliyetProjeAltButceKalemOngorulenKarID from Maliyet.ProjeAltButceKalemOngorulenKar where MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as MaliyetProjeAltButceKalemOngorulenKarID, (select MaliyetProjeAltButceOngorulenKarID from Maliyet.ProjeAltButceOngorulenKar where MaliyetAltButceID = '"& projeOngorulenKar("MaliyetAltButceID") &"' and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as MaliyetProjeAltButceOngorulenKarID, (select MaliyetProjeOngorulenKarID from Maliyet.ProjeOngorulenKar where MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as MaliyetProjeOngorulenKarID, (select AltButceKalemOngorulenMaliyetTutari from Maliyet.ProjeAltButceKalemOngorulenKar where MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as AltButceKalemOngorulenMaliyetTutari, (select AltButceKalemOngorulenAnlasmaTutari from Maliyet.ProjeAltButceKalemOngorulenKar where MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as AltButceKalemOngorulenAnlasmaTutari, (select AltButceKalemOngorulenKarOrani from Maliyet.ProjeAltButceKalemOngorulenKar where MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as AltButceKalemOngorulenKarOrani from Maliyet.AltButceKalem abk where abk.Guncellendi = 0 and abk.Silindi = 0 and MaliyetAltButceID = '"& projeOngorulenKar("MaliyetAltButceID") &"'"
                                        set projeAltButceOngorulenKar = baglanti.execute(SQL)
                                        
                                        if projeAltButceOngorulenKar.eof then
                                %>
                                <tr>
                                    <td colspan="3" style="text-align: center">Kayıt Bulunamadı</td>
                                </tr>
                                <%
                                        end if
                                        do while not projeAltButceOngorulenKar.eof
                                %>
                                <tr>
                                    <td><%=projeAltButceOngorulenKar("AltButceKalemAdi") %></td>
                                    <td style="display: flex">
                                        <input type="text" class="form-control form-control-sm mr-2 priceText" id="AltButceKalemOngorulenMaliyetTutari<%=projeAltButceOngorulenKar("MaliyetAltButceKalemID") %>" value="<%if IsNull(projeAltButceOngorulenKar("AltButceKalemOngorulenMaliyetTutari")) then %>0,00<%else %><%=projeAltButceOngorulenKar("AltButceKalemOngorulenMaliyetTutari") %><%end if %>" onkeyup="AltButceKalemOranHesapla('<%=projeAltButceOngorulenKar("MaliyetAltButceKalemID") %>');" />

                                        <input type="text" class="form-control form-control-sm mr-2 priceText" id="AltButceKalemOngorulenAnlasmaTutari<%=projeAltButceOngorulenKar("MaliyetAltButceKalemID") %>" value="<%if IsNull(projeAltButceOngorulenKar("AltButceKalemOngorulenAnlasmaTutari")) then %>0,00<%else %><%=projeAltButceOngorulenKar("AltButceKalemOngorulenAnlasmaTutari") %><%end if %>" onkeyup="AltButceKalemOranHesapla('<%=projeAltButceOngorulenKar("MaliyetAltButceKalemID") %>');" />

                                        <input type="text" class="form-control form-control-sm priceText" id="AltButceKalemOngorulenKarOrani<%=projeAltButceOngorulenKar("MaliyetAltButceKalemID") %>" value="<%if IsNull(projeAltButceOngorulenKar("AltButceKalemOngorulenKarOrani")) then %>0,00<%else %><%=projeAltButceOngorulenKar("AltButceKalemOngorulenKarOrani") %><%end if %>" readonly />
                                    </td>
                                    <td>
                                        <button class="btn btn-warning btn-mini" onclick="ProjeAltButceKalemOngorulenKarDuzenle('<%=projeAltButceOngorulenKar("MaliyetAltButceKalemID") %>', '<%=projeAltButceOngorulenKar("MaliyetAltButceID") %>', '<%=projeAltButceOngorulenKar("MaliyetProjeAltButceKalemOngorulenKarID") %>', '<%=projeAltButceOngorulenKar("MaliyetProjeAltButceOngorulenKarID") %>', '<%=projeAltButceOngorulenKar("MaliyetProjeOngorulenKarID") %>', '<%=ProjeID %>')">Düzenle</button>

                                        <button class="btn btn-danger btn-mini" onclick="ProjeAltButceKalemOngorulenKarSil('<%=projeAltButceOngorulenKar("MaliyetAltButceKalemID") %>', '<%=projeAltButceOngorulenKar("MaliyetAltButceID") %>', '<%=projeAltButceOngorulenKar("MaliyetProjeAltButceKalemOngorulenKarID") %>', '<%=projeAltButceOngorulenKar("MaliyetProjeAltButceOngorulenKarID") %>', '<%=projeAltButceOngorulenKar("MaliyetProjeOngorulenKarID") %>', '<%=ProjeID %>')">Sil</button>
                                    </td>
                                </tr>
                                <%
                                        projeAltButceOngorulenKar.movenext
                                        loop
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
        <%
                projeOnGorulenKar.movenext
                loop
        %>
    </tbody>
</table>
<script type="text/javascript">
    $(".priceText").maskMoney({ allowNegative: true, thousands: '', decimal: ',', affixesStay: false });

    function AltButceOranHesapla(inputID) {
        var OngorulenMaliyet = $("#AltButceOngorulenMaliyetTutari" + inputID).val();
        var OngorulenAnlasma = $("#AltButceOngorulenAnlasmaTutari" + inputID).val();

        if (parseFloat(OngorulenMaliyet) > 0 && parseFloat(OngorulenAnlasma) > 0) {
            var ongorulenOran = parseFloat(OngorulenMaliyet) / parseFloat(OngorulenAnlasma);
            $("#AltButceOngorulenKarOrani" + inputID).val(ongorulenOran.toFixed(3));
        }
        else {
            $("#AltButceOngorulenKarOrani" + inputID).val(0, 00);
        }
    }

    function AltButceKalemOranHesapla(inputID) {
        var OngorulenMaliyet = $("#AltButceKalemOngorulenMaliyetTutari" + inputID).val();
        var OngorulenAnlasma = $("#AltButceKalemOngorulenAnlasmaTutari" + inputID).val();

        if (parseFloat(OngorulenMaliyet) > 0 && parseFloat(OngorulenAnlasma) > 0) {
            var ongorulenOran = parseFloat(OngorulenMaliyet) / parseFloat(OngorulenAnlasma);
            $("#AltButceKalemOngorulenKarOrani" + inputID).val(ongorulenOran.toFixed(3));
        }
        else {
            $("#AltButceKalemOngorulenKarOrani" + inputID).val(0, 00);
        }
    }

    tutarOM = 0;
    tutarAT = 0;
    tutarKO = 0;

    totalOM = 0;
    totalAT = 0;
    totalKO = 0;
    $(".AltButceKalem-Ongorulen-Maliyet-Tutari").each(function () {
        if ($(this).val() === "") {
            tutarOM = 0;
        }
        else {
            tutarOM = $(this).val();
        }
        totalOM += parseFloat(tutarOM);
        $(".OngorulenMaliyetTutari").val(totalOM).focus();
    });

    $(".AltButceKalem-Ongorulen-Anlasma-Tutari").each(function () {
        if ($(this).val() === "") {
            tutarAT = 0;
        }
        else {
            tutarAT = $(this).val();
        }
        totalAT += parseFloat(tutarAT);
        $(".OngorulenAnlasmaTutari").val(totalAT).focus();
    });

    $(".AltButceKalem-Ongorulen-Kar-Orani").each(function () {
        if ($(this).val() === "") {
            tutarKO = 0;
        }
        else {
            tutarKO = $(this).val();
        }
        totalKO += parseFloat(tutarKO);
        $(".OngorulenKarOrani").val(totalKO).focus();
    });

    if (totalOM > 0 && totalAT > 0) {
        $("#btnProjeKarEkle").hide();
    }

</script>
<%
    elseif trn(request("islem")) = "AnlikKarListesi" then
        ProjeID = trn(request("ProjeID"))
%>
<table class="table table-bordered table-mini">
    <thead>
        <tr>
            <th>Bütçe Adı</th>
            <th>Bütçe Tutarı</th>
            <th>İşlem</th>
        </tr>
    </thead>
    <tbody>
        <%
                SQL = "select ab.MaliyetAltButceID, ab.MaliyetButceID, ab.AltButceAdi, (select MaliyetProjeAltButceOngorulenKarID from Maliyet.ProjeAltButceOngorulenKar where MaliyetAltButceID = ab.MaliyetAltButceID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as MaliyetProjeAltButceOngorulenKarID, (select MaliyetProjeOngorulenKarID from Maliyet.ProjeOngorulenKar where MaliyetAltButceID = ab.MaliyetAltButceID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as MaliyetProjeOngorulenKarID, (select AltButceOngorulenMaliyetTutari from Maliyet.ProjeAltButceOngorulenKar where MaliyetAltButceID = ab.MaliyetAltButceID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as AltButceOngorulenMaliyetTutari, (select AltButceOngorulenAnlasmaTutari from Maliyet.ProjeAltButceOngorulenKar where MaliyetAltButceID = ab.MaliyetAltButceID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as AltButceOngorulenAnlasmaTutari, (select AltButceOngorulenKarOrani from Maliyet.ProjeAltButceOngorulenKar where MaliyetAltButceID = ab.MaliyetAltButceID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as AltButceOngorulenKarOrani from Maliyet.AltButce ab where ab.Guncellendi = 0 and ab.Silindi = 0"
                set projeOngorulenKar = baglanti.execute(SQL)
                if projeOngorulenKar.eof then
        %>
        <tr>
            <td colspan="3" style="text-align: center">Kayıt Bulunamadı.</td>
        </tr>
        <%
                end if
                do while not projeOngorulenKar.eof
        %>
        <tr>
            <td><%=projeOngorulenKar("AltButceAdi") %></td>
            <td><%=projeOngorulenKar("AltButceOngorulenMaliyetTutari") %> ₺</td>
            <td>
                <button class="btn btn-info btn-mini" onclick="MaliyetProjeAltButceAnlikKarDetay('<%=projeOngorulenKar("MaliyetAltButceID") %>')">Detay</button>
                <!--                    <button class="btn btn-warning btn-mini" onclick="MaliyetProjeAltButceOngorulenKarDuzenle('<%=projeOngorulenKar("MaliyetAltButceID") %>', '<%=projeOngorulenKar("MaliyetButceID") %>', '<%=projeOngorulenKar("MaliyetProjeAltButceOngorulenKarID") %>', '<%=projeOngorulenKar("MaliyetProjeOngorulenKarID") %>', '<%=ProjeID %>')">Düzenle</button>-->
            </td>
        </tr>
        <tr>
            <td colspan="3" class="tdDetail" id="MaliyetProjeAltButceAnlikKarDetayTd<%=projeOngorulenKar("MaliyetAltButceID") %>" style="background-color: #ececec; display: none">
                <div class="row pl-4 pr-4 pt-4 divDetail" id="MaliyetProjeAltButceAnlikKarDetayDiv<%=projeOngorulenKar("MaliyetAltButceID") %>" style="display: none">
                    <div class="col-md-12" id="projeAnlikKarAltKalem">
                        <table class="table table-bordered table-mini" id="projeAnlikKarAltKalemTable<%=projeOngorulenKar("MaliyetAltButceID") %>">
                            <thead>
                                <tr>
                                    <th>Adı</th>
                                    <th>Tutar</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                        SQL = "select abk.MaliyetAltButceKalemID, abk.MaliyetAltButceID, abk.AltButceKalemAdi, (select MaliyetProjeAltButceKalemOngorulenKarID from Maliyet.ProjeAltButceKalemOngorulenKar where MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as MaliyetProjeAltButceKalemOngorulenKarID, (select MaliyetProjeAltButceOngorulenKarID from Maliyet.ProjeAltButceOngorulenKar where MaliyetAltButceID = '"& projeOngorulenKar("MaliyetAltButceID") &"' and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as MaliyetProjeAltButceOngorulenKarID, (select MaliyetProjeOngorulenKarID from Maliyet.ProjeOngorulenKar where MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as MaliyetProjeOngorulenKarID, (select AltButceKalemOngorulenMaliyetTutari from Maliyet.ProjeAltButceKalemOngorulenKar where MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as AltButceKalemOngorulenMaliyetTutari, (select AltButceKalemOngorulenAnlasmaTutari from Maliyet.ProjeAltButceKalemOngorulenKar where MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as AltButceKalemOngorulenAnlasmaTutari, (select AltButceKalemOngorulenKarOrani from Maliyet.ProjeAltButceKalemOngorulenKar where MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as AltButceKalemOngorulenKarOrani from Maliyet.AltButceKalem abk where abk.Guncellendi = 0 and abk.Silindi = 0 and MaliyetAltButceID = '"& projeOngorulenKar("MaliyetAltButceID") &"'"
                                        set projeAltButceOngorulenKar = baglanti.execute(SQL)
                                        if projeAltButceOngorulenKar.eof then
                                %>
                                <tr>
                                    <td colspan="3" style="text-align: center">Kayıt Bulunamadı</td>
                                </tr>
                                <%
                                        end if
                                        do while not projeAltButceOngorulenKar.eof
                                %>
                                <tr>
                                    <td><%=projeAltButceOngorulenKar("AltButceKalemAdi") %></td>
                                    <td><%=projeAltButceOngorulenKar("AltButceKalemOngorulenAnlasmaTutari") %> ₺</td>
                                    <!--                                        <td>
                                            <button class="btn btn-warning btn-mini" onclick="ProjeAltButceKalemOngorulenKarDuzenle('<%=projeAltButceOngorulenKar("MaliyetAltButceKalemID") %>', '<%=projeAltButceOngorulenKar("MaliyetAltButceID") %>', '<%=projeAltButceOngorulenKar("MaliyetProjeAltButceKalemOngorulenKarID") %>', '<%=projeAltButceOngorulenKar("MaliyetProjeAltButceOngorulenKarID") %>', '<%=projeAltButceOngorulenKar("MaliyetProjeOngorulenKarID") %>', '<%=ProjeID %>')">Düzenle</button>

                                            <button class="btn btn-danger btn-mini" onclick="ProjeAltButceKalemOngorulenKarSil('<%=projeAltButceOngorulenKar("MaliyetAltButceKalemID") %>', '<%=projeAltButceOngorulenKar("MaliyetAltButceID") %>', '<%=projeAltButceOngorulenKar("MaliyetProjeAltButceKalemOngorulenKarID") %>', '<%=projeAltButceOngorulenKar("MaliyetProjeAltButceOngorulenKarID") %>', '<%=projeAltButceOngorulenKar("MaliyetProjeOngorulenKarID") %>', '<%=ProjeID %>')">Sil</button>
                                        </td>-->
                                </tr>
                                <%
                                        projeAltButceOngorulenKar.movenext
                                        loop
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
        <%
                projeOnGorulenKar.movenext
                loop
        %>
    </tbody>
</table>
<%
    elseif trn(request("islem")) = "AltButceKalemKarListesi" then

        ProjeID = trn(request("ProjeID"))
        MaliyetAltButceKalemID = trn(request("MaliyetAltButceKalemID"))
        MaliyetAltButceID = trn(request("MaliyetAltButceID"))
        MaliyetProjeAltButceKalemOngorulenKarID = trn(request("MaliyetProjeAltButceKalemOngorulenKarID"))
        MaliyetProjeAltButceOngorulenKarID = trn(request("MaliyetProjeAltButceOngorulenKarID"))
        MaliyetProjeOngorulenKarID = trn(request("MaliyetProjeOngorulenKarID"))
        AltButceKalemOngorulenMaliyetTutari = trn(request("AltButceKalemOngorulenMaliyetTutari"))
        AltButceKalemOngorulenAnlasmaTutari = trn(request("AltButceKalemOngorulenAnlasmaTutari"))
        AltButceKalemOngorulenKarOrani = trn(request("AltButceKalemOngorulenKarOrani"))
        kullaniciID = Request.Cookies("kullanici")("kullanici_id")

        if trn(request("islem2")) = "guncelle" then
            SQL = "select * from Maliyet.ProjeAltButceKalemOngorulenKar where MaliyetProjeAltButceKalemOngorulenKarID = '"& MaliyetProjeAltButceKalemOngorulenKarID &"' and MaliyetProjeAltButceOngorulenKarID = '"& MaliyetProjeAltButceOngorulenKarID &"' and MaliyetProjeOngorulenKarID = '"& MaliyetProjeOngorulenKarID &"' and ProjeID = '"& ProjeID &"'"
            set ProjeAltButceKalemOngorulenKarKontrol = baglanti.execute(SQL)
            
            if ProjeAltButceKalemOngorulenKarKontrol.eof then
                SQL = "insert into Maliyet.ProjeAltButceKalemOngorulenKar(MaliyetProjeAltButceOngorulenKarID, MaliyetProjeOngorulenKarID, ProjeID, MaliyetAltButceKalemID, AltButceKalemOngorulenMaliyetTutari, AltButceKalemOngorulenAnlasmaTutari, AltButceKalemOngorulenKarOrani, OlusturanKullaniciID) values('"& MaliyetProjeAltButceOngorulenKarID &"', '"& MaliyetProjeOngorulenKarID &"', '"& ProjeID &"', '"& MaliyetAltButceKalemID &"', '"& AltButceKalemOngorulenMaliyetTutari &"', '"& AltButceKalemOngorulenAnlasmaTutari &"', '"& AltButceKalemOngorulenKarOrani &"', '"& kullaniciID &"')"
                set ProjeAltButceKalemOngorulenKarEkleme = baglanti.execute(SQL)
            else
                SQL = "update Maliyet.ProjeAltButceKalemOngorulenKar set AltButceKalemOngorulenMaliyetTutari = '"& AltButceKalemOngorulenMaliyetTutari &"', AltButceKalemOngorulenAnlasmaTutari = '"& AltButceKalemOngorulenAnlasmaTutari &"', AltButceKalemOngorulenKarOrani = '"& AltButceKalemOngorulenKarOrani &"', GuncelleyenKullaniciID = '"& kullaniciID &"' where MaliyetProjeAltButceKalemOngorulenKarID = '"& MaliyetProjeAltButceKalemOngorulenKarID &"' and MaliyetProjeAltButceOngorulenKarID = '"& MaliyetProjeAltButceOngorulenKarID &"' and MaliyetProjeOngorulenKarID = '"& MaliyetProjeOngorulenKarID &"' and ProjeID = '"& ProjeID &"' and MaliyetAltButceKalemID = '"& MaliyetAltButceKalemID &"'"
                set ProjeAltButceKalemOngorulenKarGuncelleme = baglanti.execute(SQL)
            end if

        elseif trn(request("islem2")) = "sil" then
            SQL = "update Maliyet.ProjeAltButceKalemOngorulenKar set Guncellendi = 1, Silindi = 1, GuncelleyenKullaniciID = '"& kullaniciID &"' where MaliyetProjeAltButceKalemOngorulenKarID = '"& MaliyetProjeAltButceKalemOngorulenKarID &"' and MaliyetProjeAltButceOngorulenKarID = '"& MaliyetProjeAltButceOngorulenKarID &"' and MaliyetProjeOngorulenKarID = '"& MaliyetProjeOngorulenKarID &"' and ProjeID = '"& ProjeID &"' and MaliyetAltButceKalemID = '"& MaliyetAltButceKalemID &"'"
            set ProjeAltButceKalemOngorulenKarSil = baglanti.execute(SQL)
        end if
%>
<table class="table table-bordered table-mini" id="projeKarAltKalemTable<%=MaliyetAltButceID %>">
    <thead>
        <tr>
            <th>Adı</th>
            <th style="width: 300px;">Tutar</th>
            <th>İşlem</th>
        </tr>
    </thead>
    <tbody>
        <%
                SQL = "select abk.MaliyetAltButceKalemID, abk.MaliyetAltButceID, abk.AltButceKalemAdi, (select MaliyetProjeAltButceKalemOngorulenKarID from Maliyet.ProjeAltButceKalemOngorulenKar where MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as MaliyetProjeAltButceKalemOngorulenKarID, (select MaliyetProjeAltButceOngorulenKarID from Maliyet.ProjeAltButceOngorulenKar where MaliyetAltButceID = '"& MaliyetAltButceID &"' and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as MaliyetProjeAltButceOngorulenKarID, (select MaliyetProjeOngorulenKarID from Maliyet.ProjeOngorulenKar where MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as MaliyetProjeOngorulenKarID, (select AltButceKalemOngorulenMaliyetTutari from Maliyet.ProjeAltButceKalemOngorulenKar where MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as AltButceKalemOngorulenMaliyetTutari, (select AltButceKalemOngorulenAnlasmaTutari from Maliyet.ProjeAltButceKalemOngorulenKar where MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as AltButceKalemOngorulenAnlasmaTutari, (select AltButceKalemOngorulenKarOrani from Maliyet.ProjeAltButceKalemOngorulenKar where MaliyetAltButceKalemID = abk.MaliyetAltButceKalemID and Guncellendi = 0 and Silindi = 0 and ProjeID = '"& ProjeID &"') as AltButceKalemOngorulenKarOrani from Maliyet.AltButceKalem abk where abk.Guncellendi = 0 and abk.Silindi = 0 and MaliyetAltButceID = '"& MaliyetAltButceID &"'"
                set projeAltButceOngorulenKar = baglanti.execute(SQL)

                if projeAltButceOngorulenKar.eof then
        %>
        <tr>
            <td colspan="3" style="text-align: center">Kayıt Bulunamadı</td>
        </tr>
        <%
                end if
                do while not projeAltButceOngorulenKar.eof
        %>
        <tr>
            <td><%=projeAltButceOngorulenKar("AltButceKalemAdi") %></td>
            <td style="display: flex">
                <input type="text" class="form-control form-control-sm mr-2 priceText" id="AltButceKalemOngorulenMaliyetTutari<%=projeAltButceOngorulenKar("MaliyetAltButceKalemID") %>" value="<%if IsNull(projeAltButceOngorulenKar("AltButceKalemOngorulenMaliyetTutari")) then %>0,00<%else %><%=projeAltButceOngorulenKar("AltButceKalemOngorulenMaliyetTutari") %><%end if %>" onkeyup="AltButceKalemOranHesapla('<%=projeAltButceOngorulenKar("MaliyetAltButceKalemID") %>');" />

                <input type="text" class="form-control form-control-sm mr-2 priceText" id="AltButceKalemOngorulenAnlasmaTutari<%=projeAltButceOngorulenKar("MaliyetAltButceKalemID") %>" value="<%if IsNull(projeAltButceOngorulenKar("AltButceKalemOngorulenAnlasmaTutari")) then %>0,00<%else %><%=projeAltButceOngorulenKar("AltButceKalemOngorulenAnlasmaTutari") %><%end if %>" onkeyup="AltButceKalemOranHesapla('<%=projeAltButceOngorulenKar("MaliyetAltButceKalemID") %>');" />

                <input type="text" class="form-control form-control-sm priceText" id="AltButceKalemOngorulenKarOrani<%=projeAltButceOngorulenKar("MaliyetAltButceKalemID") %>" value="<%if IsNull(projeAltButceOngorulenKar("AltButceKalemOngorulenKarOrani")) then %>0,00<%else %><%=projeAltButceOngorulenKar("AltButceKalemOngorulenKarOrani") %><%end if %>" readonly />
            </td>
            <td>
                <button class="btn btn-warning btn-mini" onclick="ProjeAltButceKalemOngorulenKarDuzenle('<%=projeAltButceOngorulenKar("MaliyetAltButceKalemID") %>', '<%=projeAltButceOngorulenKar("MaliyetAltButceID") %>', '<%=projeAltButceOngorulenKar("MaliyetProjeAltButceKalemOngorulenKarID") %>', '<%=projeAltButceOngorulenKar("MaliyetProjeAltButceOngorulenKarID") %>', '<%=projeAltButceOngorulenKar("MaliyetProjeOngorulenKarID") %>', '<%=ProjeID %>')">Düzenle</button>

                <button class="btn btn-danger btn-mini" onclick="ProjeAltButceKalemOngorulenKarSil('<%=projeAltButceOngorulenKar("MaliyetAltButceKalemID") %>', '<%=projeAltButceOngorulenKar("MaliyetAltButceID") %>', '<%=projeAltButceOngorulenKar("MaliyetProjeAltButceKalemOngorulenKarID") %>', '<%=projeAltButceOngorulenKar("MaliyetProjeAltButceOngorulenKarID") %>', '<%=projeAltButceOngorulenKar("MaliyetProjeOngorulenKarID") %>', '<%=ProjeID %>');">Sil</button>
            </td>
        </tr>
        <%
                projeAltButceOngorulenKar.movenext
                loop
        %>
    </tbody>
</table>
<script type="text/javascript">
    $(".priceText").maskMoney({ allowNegative: true, thousands: '', decimal: ',', affixesStay: false });

    function AltButceKalemOranHesapla(inputID) {
        var OngorulenMaliyet = $("#AltButceKalemOngorulenMaliyetTutari" + inputID).val();
        var OngorulenAnlasma = $("#AltButceKalemOngorulenAnlasmaTutari" + inputID).val();

        if (parseFloat(OngorulenMaliyet) > 0 && parseFloat(OngorulenAnlasma) > 0) {
            var ongorulenOran = parseFloat(OngorulenMaliyet) / parseFloat(OngorulenAnlasma);
            $("#AltButceKalemOngorulenKarOrani" + inputID).val(ongorulenOran.toFixed(3));
        }
        else {
            $("#AltButceKalemOngorulenKarOrani" + inputID).val(0, 00);
        }
    }
</script>
<%
    elseif trn(request("islem"))="proje_butce_hesabi_ekle" then

        proje_id = trn(request("proje_id"))
%>
<style type="text/css">
    .select2-container--default .select2-selection--single .select2-selection__rendered {
        color: #444;
        padding: 8px 25px 8px 10px;
    }

    .select2-container .select2-selection--single {
        cursor: pointer;
        height: 31px !important;
    }
</style>
<div class="modal-header">
    <%=LNG("Bütçe Hesabı Ekle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="butce_hesabi_ekleme_form" class="smart-form validateform" novalidate="novalidate">
    <div class="modal-body">
        <div class="col-md-12 p-0">
            <div class="form-group">
                <label class="col-form-label"><%=LNG("Bütçe Hesabı Adı")%></label>
                <input type="text" class="form-control required form-control-sm" required name="butce_hesabi_adi" id="butce_hesabi_adi" />
            </div>
        </div>
        <div class="row">
            <div class="col-sm-9">
                <label class=""><%=LNG("Tutar")%></label>
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-money"></i>
                    </span>
                    <input type="text" class="form-control paraonly required regexonly form-control-sm" required name="ongorulen_tutar" value="0,00" id="ongorulen_tutar" />
                </div>
            </div>
            <div class="col-sm-3">
                <label class="col-sm-12 "><%=LNG("Parabirimi")%></label>
                <select name="parabirimi" id="parabirimi" class="form-control form-control-sm">
                    <option value="TL">TL</option>
                    <option value="USD">USD</option>
                    <option value="EUR">EUR</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-form-label">Tarih</label>
            <select class="form-control form-control-sm select2" id="tarih">
                <%
                        j = 0
                        for i = 1 to 12
                        j = j + 1
                            value = MONTHNAME(i) & " " & YEAR(date)
                            if i < 10 then 
                                i = "0" & i
                            end if
                            insertValue = "01." & i & "." & YEAR(date)
                %>
                <option <%if j = Month(date) then  %> selected="selected" <%end if %> value="<%=insertValue %>"><%=value %></option>
                <%
                        next
                %>
            </select>
        </div>
    </div>
    <div class="modal-footer">
        <input type="button" onclick="proje_butce_hesabi_kaydet(this, '<%=proje_id %>');" class="btn btn-primary btn-sm" value="<%=LNG("Kaydı Ekle")%>" />
    </div>
</form>
<script>
        $(function (){
            $('.paraonly:not(.yapilan)').addClass("yapilan").maskMoney({ thousands: '.', decimal: ',', allowZero: true, suffix: '' });
        });
</script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#parabirimi, #tarih").select2({
            dropdownParent: $("#modal_div")
        });
    });
</script>
<%
        elseif trn(request("islem"))="proje_butce_hesabi_duzenle" then

            kayit_id = trn(request("kayit_id"))
            proje_id = trn(request("proje_id"))

            SQL="select * from ahtapot_proje_butce_listesi where id = '"& kayit_id &"' and durum = 'true' and cop = 'false' and firma_id = '"& FirmaID &"'"
            set cek = baglanti.execute(SQL)

%>
<style type="text/css">
    .select2-container--default .select2-selection--single .select2-selection__rendered {
        color: #444;
        padding: 8px 25px 8px 10px;
    }

    .select2-container .select2-selection--single {
        cursor: pointer;
        height: 31px !important;
    }
</style>
<div class="modal-header">
    <%=LNG("Bütçe Hesabı Düzenle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="butce_hesabi_ekleme_form" class="smart-form validateform" novalidate="novalidate">
    <div class="modal-body">
        <div class="col-md-12 p-0">
            <div class="form-group">
                <label class="col-form-label"><%=LNG("Bütçe Hesabı Adı")%></label>
                <input type="text" class="form-control required form-control-sm" required name="butce_hesabi_adi" id="butce_hesabi_adi" value="<%=cek("butce_hesabi_adi") %>" />
            </div>
        </div>
        <div class="row">
            <div class="col-sm-9">
                <label class=""><%=LNG("Tutar")%></label>
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-money"></i>
                    </span>
                    <input type="text" class="form-control form-control-sm required regexonly paraonly" required name="ongorulen_tutar" id="ongorulen_tutar" value="<%=cek("ongorulen_tutar") %>" />
                </div>
            </div>
            <div class="col-sm-3">
                <label class="col-sm-12 "><%=LNG("Parabirimi")%></label>
                <select name="parabirimi" class="form-control form-control-sm" id="parabirimi">
                    <option <% if trim(cek("parabirimi"))="TL" then %> selected="selected" <% end if %> value="TL">TL</option>
                    <option <% if trim(cek("parabirimi"))="USD" then %> selected="selected" <% end if %> value="USD">USD</option>
                    <option <% if trim(cek("parabirimi"))="EUR" then %> selected="selected" <% end if %> value="EUR">EUR</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-form-label">Tarih</label>
            <select class="form-control form-control-sm select2" id="tarih">
                <%
                        for i = 1 to 12
                            value = MONTHNAME(i) & " " & YEAR(date)
                            if i < 10 then 
                                i = "0" & i
                            end if
                            insertValue = "01." & i & "." & YEAR(date)
                    
                            if IsNull(cek("tarih")) then
                                getDate = "01" & "." & Month(date) & "." & YEAR(date)
                            else
                                getDate = cek("tarih")
                            end if
                %>
                <option <%if cdate(insertValue) = cdate(getDate) then  %> selected="selected" <%end if %> value="<%=insertValue %>"><%=value %></option>
                <%
                        next
                %>
            </select>
        </div>
    </div>
    <div class="modal-footer">
        <input type="button" onclick="proje_butce_hesabi_guncelle(this, '<%=proje_id %>', '<%=cek("id")%>');" class="btn btn-primary btn-sm" value="<%=LNG("Güncelle")%>" />
    </div>
</form>
<script>
        $(function (){
            $('.paraonly:not(.yapilan)').addClass("yapilan").maskMoney({ thousands: '.', decimal: ',', allowZero: true, suffix: '' });
        });
</script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#parabirimi, #tarih").select2({
            dropdownParent: $("#modal_div")
        });
    });
</script>

<% elseif trn(request("islem"))="gantt_liste_gorunumu" then 
        
        proje_id = trn(request("proje_id"))
        tip = trn(request("tip"))

        tip_str = ""
        ters_str = "_uygulama"
        if tip = "uygulama" then
            tip_str = "_uygulama"
            ters_str = ""
        end if
        
%>
<script>

        $(function (){
          runAllCharts

            $(".ictenustunegelince").hover(function (){
                $(this).addClass("ictenustunegelince2");
            }, function (){
                $(this).removeClass("ictenustunegelince2");
            });

        });


</script>
<input type="hidden" id="gantt_proje_id" value="<%=proje_id %>" />
<input type="hidden" id="gantt_tip" value="<%=tip %>" />
<div style="margin-right: 4%; margin-top: 15px;">
    <div style="text-align: right; padding-top: 15px;">

        <a class="btn btn-labeled btn-success btn-mini" href="javascript:void(0);" onclick="rapor_pdf_indir('gantt_liste');" style="margin-top: -27px;"><span class="btn-label"><i class="fa fa-download"></i></span><%=LNG("İndir")%> </a>&nbsp;&nbsp;<a class="btn btn-labeled btn-warning btn-mini" href="javascript:void(0);" onclick="rapor_pdf_yazdir('gantt_liste');" style="margin-top: -27px;"><span class="btn-label"><i class="fa fa-print"></i></span><%=LNG("Yazdır")%> </a>&nbsp;&nbsp;<a class="btn btn-labeled btn-primary btn-mini" href="javascript:void(0);" onclick="rapor_pdf_gonder('gantt_liste');" style="margin-top: -27px;"><span class="btn-label"><i class="fa fa-send "></i></span><%=LNG("Gönder")%> </a>

    </div>
</div>
<div style="margin: 4%; margin-top: 10px;">
    <div class="dt-responsive table-responsive">
        <table class="table" style="font-size: 14px;">
            <tbody>
                <%
                    SQL="select * from ahtapot_proje_gantt_adimlari where proje_id = '"& proje_id &"' and cop = 'false' and firma_id = '"& FirmaID &"'"
                    set adim = baglanti.execute(SQL)
                    do while not adim.eof
                %>
                <tr class="ictenustunegelince">
                    <td></td>
                    <% if cdbl(adim("ilevel"))=0 then %>
                    <td colspan="6" style="padding-left: <%=cint(adim("ilevel"))*20%>px!important; font-weight: bold;"><i class="fa fa-sort-desc"></i>&nbsp&nbsp&nbsp;<%=ucase(adim("name")) %></td>
                    <% elseif cdbl(adim("ilevel"))=1 then %>
                    <td style="padding-left: <%=cint(adim("ilevel"))*30%>px!important; font-weight: bold;"><i class="fa fa-sort-desc"></i>&nbsp&nbsp&nbsp<%=adim("name") %></td>
                    <td><strong><%=LNG("Süre")%></strong></td>
                    <td style="width: 150px; padding-right: 30px!important;">
                        <div>
                            <div id="is_chart<%=adim("id") %>" class="progress progress-xs" data-progressbar-value="<%=adim("progress") %>">
                                <div class="progress-bar"></div>
                            </div>
                            <span class="hiddenspan"><%=adim("progress") %></span>
                        </div>
                    </td>
                    <td><strong><%=LNG("Başlangıç")%></strong></td>
                    <td><strong><%=LNG("Bitiş")%></strong></td>

                    <td style="text-align: right;"><strong><%=LNG("Görevli Kaynaklar")%></strong></td>
                    <% elseif cdbl(adim("ilevel"))=2 then %>
                    <td style="padding-left: <%=cint(adim("ilevel"))*30%>px!important;"><%=adim("name") %></td>
                    <td><%=adim("duration" & tip_str) %> <%=LNG("gün")%></td>
                    <td style="width: 150px; padding-right: 30px!important;">
                        <div>
                            <div id="is_chart<%=adim("id") %>" class="progress progress-xs" data-progressbar-value="<%=adim("progress") %>">
                                <div class="progress-bar"></div>
                            </div>
                            <span class="hiddenspan"><%=adim("progress") %></span>
                        </div>
                    </td>
                    <td><%=cdate(adim("start_tarih" & tip_str)) %></td>
                    <td><%=cdate(adim("end_tarih" & tip_str)) %></td>

                    <td style="text-align: right;"></td>
                    <% end if %>
                </tr>
                <%
                    adim.movenext
                    loop
                %>
            </tbody>
        </table>
    </div>
</div>
<% 
        
    elseif trn(request("islem"))="is_ilerleme_ajanda_senkronizasyon" then

        IsID = trn(request("IsID"))
        TamamlanmaID = trn(request("TamamlanmaID"))
        tamamlanma_orani = trn(request("tamamlanma_orani"))
        onceki_oran = trn(request("onceki_oran"))
        ilerleme = cint(tamamlanma_orani)-cint(onceki_oran)

        if cdbl(ilerleme)<1 then
            ilerleme = 0
        end if

        SQL="SELECT iss.adi, ISNULL(kaynak.toplam_sure,'0:00') AS toplam_sure, ISNULL(kaynak.gunluk_sure,'0:00') AS gunluk_sure, ISNULL(kaynak.toplam_gun, '0:00') AS toplam_gun, isnull(iss.GantAdimID, 0) as GantAdimID, convert(datetime,gorevli.ekleme_tarihi) + convert(datetime, gorevli.ekleme_saati) as tamamlanma_zamani, kullanici.personel_resim, kullanici.personel_ad + ' ' + kullanici.personel_soyad as personel_adsoyad,gorevli.gorevli_id, gorevli.id, gorevli.tamamlanma_orani from ucgem_is_gorevli_durumlari gorevli  with(nolock) join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = gorevli.gorevli_id join ucgem_is_listesi iss on iss.id = gorevli.is_id LEFT JOIN dbo.ahtapot_gantt_adim_kaynaklari kaynak  with(nolock) ON kaynak.adimID = iss.GantAdimID WHERE gorevli.id = '"& TamamlanmaID &"' GROUP BY kaynak.toplam_sure, kaynak.gunluk_sure, kaynak.toplam_gun, isnull(iss.GantAdimID, 0), convert(datetime,gorevli.ekleme_tarihi) + convert(datetime, gorevli.ekleme_saati), kullanici.personel_resim, kullanici.personel_ad + ' ' + kullanici.personel_soyad, gorevli.gorevli_id, gorevli.id, gorevli.tamamlanma_orani, iss.adi"
        set bilgicek = baglanti.execute(SQL)


        if trim(bilgicek("GantAdimID"))="0" then

            baslangic_tarihi = cdate(date)
            baslangic_saati = time
            bitis_tarihi = cdate(date)
            bitis_saati = time

        else

            planlanan_toplam = (cint(split(bilgicek("toplam_sure"),":")(0)) * 60) + cint(split(bilgicek("toplam_sure"),":")(1))
            ilerleme_hesap = (cdbl(planlanan_toplam) / 100) * cint(cint(tamamlanma_orani)-cint(onceki_oran))

            if cdbl(ilerleme_hesap)<1 then
                ilerleme_hesap = 0
            end if


            baslangic_tarihi = cdate(DateAdd("n", (ilerleme_hesap*-1), now()))
            saat = DatePart("h", (DateAdd("n", (ilerleme_hesap*-1), now())))
            if  cint(saat)<10 then
                saat = "0" & cint(saat)
            end if
            dakika = DatePart("n", (DateAdd("n", (ilerleme_hesap*-1), now())))
            if  cint(dakika)<10 then
                dakika = "0" & cint(dakika)
            end if
            baslangic_saati = saat & ":" & dakika

            saat = (cint(ilerleme_hesap) / 60)
            dakika = cint(ilerleme_hesap) mod 60

            if isnumeric(saat)=false then
                saat = 0
            end if

            if isnumeric(dakika)=false then
                dakika = 0
            end if

            if  cint(saat)<10 then
                saat = "0" & cint(saat)
            end if
        
            if  cint(dakika)<10 then
                dakika = "0" & cint(dakika)
            end if

            ongorulen_sure = left(saat,2) & ":" & left(dakika,2)

        end if

%>
<div class="modal-header">
    <%=LNG("Ajandayı Senkronize Et")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="ajanda_senkronize_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <input type="hidden" name="ajanda_baslik" id="ajanda_baslik" value="<%=bilgicek("adi") %>" />
    <input type="hidden" name="ajanda_aciklama" id="ajanda_aciklama" value="%<%=ilerleme %> ilerleme kaydedildi. (%<%=onceki_oran %> -> %<%=tamamlanma_orani %>)" />
    <div class="row">
        <div class="col-sm-12">
            <div class="alert alert-danger icons-alert">
                "<%=bilgicek("adi") %>" <strong><%=LNG("adlı işi hangi saatlerde yaptınız?")%></strong>
            </div>
        </div>
    </div>
    <div class="alert-primary alert " style="width: 300px; margin-left: auto; margin-right: auto; <% if trim(bilgicek("GantAdimID"))="0" then %> display: none; <% end if %>">
        <hr />
        <table style="text-align: center; width: 100%;">
            <tr>
                <td style="padding-right: 15px;"><%=LNG("İlerleme Oranı")%></td>
                <td style="padding-right: 15px;"><%=LNG("Öngörülen Süre")%></td>
            </tr>
            <tr>
                <td style="padding-right: 15px;">
                    <h5>%<%=ilerleme %></h5>
                </td>
                <td style="padding-right: 15px;">
                    <h5><%=ongorulen_sure %></h5>
                </td>
            </tr>
        </table>
        <hr />
    </div>

    <div class="row">
        <div class="col-sm-6">
            <label class=" col-form-label"><%=LNG("Başlama Saati")%></label>
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" class="timepicker form-control required" value="<%=baslangic_saati %>" required name="baslama_saati" id="baslama_saati" />
            </div>
        </div>

        <div class="col-sm-6">
            <label class=" col-form-label"><%=LNG("Bitirme Saati")%></label>
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" class="timepicker form-control required" value="<%=left(time,5) %>" required name="bitirme_saati" id="bitirme_saati" />
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <span style="float: right;">
                <a href="javascript:void(0);" onclick="senkronizasyon_tarih_degistir();"><i class="fa fa-calendar"></i><%=LNG("Tarih Değiştir")%></a>
            </span>
        </div>
    </div>

    <div id="tarih_degistirme_yeri" class="row" style="display: none;">
        <div class="col-sm-6">
            <label class=" col-form-label"><%=LNG("Başlama Tarihi")%></label>
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" class="takvimyap form-control required" value="<%=cdate(left(baslangic_tarihi,10)) %>" required name="baslama_tarihi" id="baslama_tarihi" />
            </div>
        </div>

        <div class="col-sm-6">
            <label class=" col-form-label"><%=LNG("Bitirme Tarihi")%></label>
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" class="takvimyap form-control required" value="<%=cdate(date) %>" required name="bitirme_tarihi" id="bitirme_tarihi" />
            </div>
        </div>
    </div>

    <div class="modal-footer" style="justify-content: space-between!important;">

        <input type="button" onclick="manuel_isi_bitir2('<%=TamamlanmaID%>', '<%=tamamlanma_orani%>', '<%=IsID %>');" class="btn btn-sm btn-danger" value="<%=LNG("Ajanda Kaydı Oluşturma")%>!" style="float: left;" />

        <input type="button" onclick="is_ilerleme_ajanda_senkronizasyon_kaydet(this, '<%=IsID %>', '<%=TamamlanmaID%>', '<%=tamamlanma_orani%>', '<%=onceki_oran%>');" class="btn btn-sm btn-success" value="<%=LNG("Ajanda'ya Ekle")%>" style="float: right;" />

    </div>
</form>
<%

                
    elseif trn(request("islem"))="is_ilerleme_ajanda_senkronizasyon2" then

        IsID = trn(request("IsID"))
        TamamlanmaID = trn(request("TamamlanmaID"))
        tamamlanma_orani = trn(request("tamamlanma_orani"))
        onceki_oran = trn(request("onceki_oran"))
        ilerleme = cint(tamamlanma_orani)-cint(onceki_oran)
        rbaslangic_tarihi = trn(request("baslangic_tarihi"))
        rbaslangic_saati = trn(request("baslangic_saati"))

        if cdbl(ilerleme)<1 then
            ilerleme = 0
        end if

        SQL="SELECT iss.adi, ISNULL(kaynak.toplam_sure,'0:00') AS toplam_sure, ISNULL(kaynak.gunluk_sure,'0:00') AS gunluk_sure, ISNULL(kaynak.toplam_gun, '0:00') AS toplam_gun, isnull(iss.GantAdimID, 0) as GantAdimID, convert(datetime,gorevli.ekleme_tarihi) + convert(datetime, gorevli.ekleme_saati) as tamamlanma_zamani, kullanici.personel_resim, kullanici.personel_ad + ' ' + kullanici.personel_soyad as personel_adsoyad,gorevli.gorevli_id, gorevli.id, gorevli.tamamlanma_orani from ucgem_is_gorevli_durumlari gorevli  with(nolock) join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = gorevli.gorevli_id join ucgem_is_listesi iss on iss.id = gorevli.is_id LEFT JOIN dbo.ahtapot_gantt_adim_kaynaklari kaynak  with(nolock) ON kaynak.adimID = iss.GantAdimID WHERE gorevli.id = '"& TamamlanmaID &"' GROUP BY kaynak.toplam_sure, kaynak.gunluk_sure, kaynak.toplam_gun, isnull(iss.GantAdimID, 0), convert(datetime,gorevli.ekleme_tarihi) + convert(datetime, gorevli.ekleme_saati), kullanici.personel_resim, kullanici.personel_ad + ' ' + kullanici.personel_soyad, gorevli.gorevli_id, gorevli.id, gorevli.tamamlanma_orani, iss.adi"
        set bilgicek = baglanti.execute(SQL)


        if trim(bilgicek("GantAdimID"))="0" then

            baslangic_tarihi = rbaslangic_tarihi
            baslangic_saati = rbaslangic_saati

            bitis_tarihi = cdate(date)
            bitis_saati = time

        else

            planlanan_toplam = (cint(split(bilgicek("toplam_sure"),":")(0)) * 60) + cint(split(bilgicek("toplam_sure"),":")(1))
            ilerleme_hesap = (cdbl(planlanan_toplam) / 100) * cint(cint(tamamlanma_orani)-cint(onceki_oran))

            if cdbl(ilerleme_hesap)<1 then
                ilerleme_hesap = 0
            end if


            baslangic_tarihi = cdate(DateAdd("n", (ilerleme_hesap*-1), now()))
            saat = DatePart("h", (DateAdd("n", (ilerleme_hesap*-1), now())))
            if  cint(saat)<10 then
                saat = "0" & cint(saat)
            end if
            dakika = DatePart("n", (DateAdd("n", (ilerleme_hesap*-1), now())))
            if  cint(dakika)<10 then
                dakika = "0" & cint(dakika)
            end if
            baslangic_saati = saat & ":" & dakika

            saat = (cint(ilerleme_hesap) / 60)
            dakika = cint(ilerleme_hesap) mod 60

            if isnumeric(saat)=false then
                saat = 0
            end if

            if isnumeric(dakika)=false then
                dakika = 0
            end if

            if  cint(saat)<10 then
                saat = "0" & cint(saat)
            end if
        
            if  cint(dakika)<10 then
                dakika = "0" & cint(dakika)
            end if

            ongorulen_sure = left(saat,2) & ":" & left(dakika,2)

        end if

        baslangic_tarihi = rbaslangic_tarihi
        baslangic_saati = rbaslangic_saati

%>
<div class="modal-header">
    <%=LNG("Ajandayı Senkronize Et")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="ajanda_senkronize_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <input type="hidden" name="ajanda_baslik" id="ajanda_baslik" value="<%=bilgicek("adi") %>" />
    <input type="hidden" name="ajanda_aciklama" id="ajanda_aciklama" value="%<%=ilerleme %> ilerleme kaydedildi. (%<%=onceki_oran %> -> %<%=tamamlanma_orani %>)" />
    <div class="row">
        <div class="col-sm-12">
            <div class="alert alert-danger icons-alert">
                "<%=bilgicek("adi") %>" <strong><%=LNG("adlı işi hangi saatlerde yaptınız?")%></strong>
            </div>
        </div>
    </div>
    <div class="alert-primary alert " style="width: 300px; margin-left: auto; margin-right: auto; <% if trim(bilgicek("GantAdimID"))="0" then %> display: none; <% end if %>">
        <hr />
        <table style="text-align: center; width: 100%;">
            <tr>
                <td style="padding-right: 15px;"><%=LNG("İlerleme Oranı")%></td>
                <td style="padding-right: 15px;"><%=LNG("Öngörülen Süre")%></td>
            </tr>
            <tr>
                <td style="padding-right: 15px;">
                    <h5>%<%=ilerleme %></h5>
                </td>
                <td style="padding-right: 15px;">
                    <h5><%=ongorulen_sure %></h5>
                </td>
            </tr>
        </table>
        <hr />
    </div>

    <div class="row">
        <div class="col-sm-6">
            <label class=" col-form-label"><%=LNG("Başlama Saati")%></label>
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" class="timepicker form-control required" value="<%=baslangic_saati %>" required name="baslama_saati" id="baslama_saati" />
            </div>
        </div>

        <div class="col-sm-6">
            <label class=" col-form-label"><%=LNG("Bitirme Saati")%></label>
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" class="timepicker form-control required" value="<%=left(time,5) %>" required name="bitirme_saati" id="bitirme_saati" />
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <span style="float: right;">
                <a href="javascript:void(0);" onclick="senkronizasyon_tarih_degistir();"><i class="fa fa-calendar"></i><%=LNG("Tarih Değiştir")%></a>
            </span>
        </div>
    </div>

    <div id="tarih_degistirme_yeri" class="row" style="display: none;">
        <div class="col-sm-6">
            <label class=" col-form-label"><%=LNG("Başlama Tarihi")%></label>
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" class="takvimyap form-control required" value="<%=cdate(left(baslangic_tarihi,10)) %>" required name="baslama_tarihi" id="baslama_tarihi" />
            </div>
        </div>

        <div class="col-sm-6">
            <label class=" col-form-label"><%=LNG("Bitirme Tarihi")%></label>
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" class="takvimyap form-control required" value="<%=cdate(date) %>" required name="bitirme_tarihi" id="bitirme_tarihi" />
            </div>
        </div>
    </div>

    <div class="modal-footer" style="justify-content: space-between!important;">


        <!--<input type="button" onclick="manuel_isi_bitir2('<%=TamamlanmaID%>', '<%=tamamlanma_orani%>', '<%=IsID %>');" class="btn btn-sm btn-danger" value="<%=LNG("Ajanda Kaydı Oluşturma")%>!" style="float:left;" />-->

        <input type="button" onclick="is_ilerleme_ajanda_senkronizasyon_kaydet(this, '<%=IsID %>', '<%=TamamlanmaID%>', '<%=tamamlanma_orani%>', '<%=onceki_oran%>');" class="btn btn-sm btn-success" value="<%=LNG("Ajanda'ya Ekle")%>" style="float: right;" />

    </div>
</form>
<%

        elseif trn(request("islem")) = "is_ilerleme_ajanda_senkronizasyon_kaydet" then

            IsID = trn(request("IsID"))
            TamamlanmaID = trn(request("TamamlanmaID"))
            tamamlanma_orani = trn(request("tamamlanma_orani"))
            onceki_oran = trn(request("onceki_oran"))
            baslama_saati = trn(request("baslama_saati"))
            bitirme_saati = trn(request("bitirme_saati"))
            baslama_tarihi = trn(request("baslama_tarihi"))
            bitirme_tarihi = trn(request("bitirme_tarihi"))
            ajanda_baslik = trn(HTMLDecode(urldecodes(request("ajanda_baslik"))))
            ajanda_aciklama = trn(HTMLDecode(urldecodes(request("ajanda_aciklama"))))

            if trn(request("islem2"))="islem2" then
                bitirme_saati = time()
                bitirme_tarihi = cdate(date)
            end if

            SQL="SELECT iss.departmanlar, iss.adi, ISNULL(kaynak.toplam_sure,'0:00') AS toplam_sure, ISNULL(kaynak.gunluk_sure,'0:00') AS gunluk_sure, ISNULL(kaynak.toplam_gun, '0:00') AS toplam_gun, isnull(iss.GantAdimID, 0) as GantAdimID, convert(datetime,gorevli.ekleme_tarihi) + convert(datetime, gorevli.ekleme_saati) as tamamlanma_zamani, kullanici.personel_resim, kullanici.personel_ad + ' ' + kullanici.personel_soyad as personel_adsoyad,gorevli.gorevli_id, gorevli.id, gorevli.tamamlanma_orani from ucgem_is_gorevli_durumlari gorevli  with(nolock) join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = gorevli.gorevli_id join ucgem_is_listesi iss on iss.id = gorevli.is_id LEFT JOIN dbo.ahtapot_gantt_adim_kaynaklari kaynak  with(nolock) ON kaynak.adimID = iss.GantAdimID WHERE gorevli.id = '"& TamamlanmaID &"' GROUP BY kaynak.toplam_sure, kaynak.gunluk_sure, kaynak.toplam_gun, isnull(iss.GantAdimID, 0), convert(datetime,gorevli.ekleme_tarihi) + convert(datetime, gorevli.ekleme_saati), kullanici.personel_resim, kullanici.personel_ad + ' ' + kullanici.personel_soyad, gorevli.gorevli_id, gorevli.id, gorevli.tamamlanma_orani, iss.adi, iss.departmanlar"
            set bilgicek = baglanti.execute(SQL)

            etiket = "personel"
            etiket_id = Request.Cookies("kullanici")("kullanici_id")
            title = ajanda_baslik
            allDay = 0 
            baslangic = baslama_tarihi
            bitis = bitirme_tarihi
            baslangic_saati = baslama_saati
            bitis_saati = bitirme_saati
            url = ""

            renk = "rgb(52, 152, 219)"
            renk2 = "rgb(250, 0, 0, 1)"
            color = ""
            if trn(request("tamamlanma_orani")) = "100" then
                color = "rgb(46, 204, 113)"
            elseif trn(request("tamamlanma_orani")) = "10" then
                color = "rgb(241, 196, 15)"
            end if
            description = ajanda_aciklama
            etiketler = bilgicek("departmanlar")
            durum = "true"
            cop = "false"
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            ekleme_tarihi = date
            ekleme_saati = time
            kisiler = ""
            ana_kayit_id = 0
            tamamlandi = trn(request("TamamlanmaID"))


            SQL="update ahtapot_ajanda_olay_listesi set cop = 'true' where color='"& renk &"' and IsID = '"& IsID &"' and etiket = '"& etiket &"' and etiket_id = '"& etiket_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)

            SQL="update ahtapot_ajanda_olay_listesi set cop = 'true' where color='"& renk2 &"' and IsID = '"& IsID &"' and etiket = '"& etiket &"' and etiket_id = '"& etiket_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle2 = baglanti.execute(SQL)

            if trn(request("tamamlanma_orani")) = "100" then
                SQL = "update ahtapot_ajanda_olay_listesi set color = '"& color &"' where durum = 'true' and cop = 'false' and IsID = '"& IsID &"' and etiket = '"& etiket &"' and etiket_id = '"& etiket_id &"' and not color = 'rgb(52, 152, 219)' and not color = 'rgb(250, 0, 0, 1)' and firma_id = '"& FirmaID &"'"
                set tamamlananKayitlar = baglanti.execute(SQL)
            end if
        
        elseif trn(request("islem"))="is_yuku_gosterim_proje_sectim" then

            proje_id = trn(request("proje_id"))
            dongu_baslangic = cdate(trn(request("baslangic")))
            dongu_bitis = cdate(trn(request("bitis")))
            gosterim_tipi = trn(request("gosterim_tipi"))
%>
<style>
    .taskin {
        background-color: #fb8f8f !important;
    }
</style>
<div>
    <div id="tablediv">
        <table id="tablegosterge" style="border-color: #e8e8e8; font-family: Tahoma;">
            <thead id="thead">
                <tr>
                    <th rowspan="2" class="ilkth headcol">
                        <div style="width: 150px;"><%=LNG("Kaynaklar")%></div>
                    </th>
                    <th rowspan="2" class="ilkth headcol ">
                        <div style="width: 80px; text-align: center; margin-left: auto; margin-right: auto;">
                            <%=LNG("İş Sayısı")%>
                        </div>
                    </th>

                    <% 
                            son_ay = 0
                            for x = dongu_baslangic to dongu_bitis 
                                if not son_ay = month(x) then
                                    son_ay = month(x)

                                    cols = AyinSonGunu(cdate(x)) - day(cdate(x))

                                    if cdate( AyinSonGunu(cdate(x)) & "." & month(cdate(x)) & "." & year(cdate(x))) > dongu_bitis then
                                        cols = day(dongu_bitis)
                                    end if

                                    cols = cols + 1
                    %>
                    <th class="ust_th" colspan="<%=cols %>"><%=monthname(son_ay) %>&nbsp;<%=year(x) %></th>
                    <% 
                                end if
                            next
                    %>
                </tr>
                <tr>

                    <% for x = dongu_baslangic to dongu_bitis  %>
                    <th class="alt_th" style="<% if day(x)=1 then %> border-left: solid 3px white; <% end if %>">
                        <div class="guncizelge"><%=day(x) %></div>
                    </th>
                    <% next %>
                </tr>
            </thead>
            <tbody id="tbody">

                <%

                                        SQL="Exec [dbo].[ProjeIsYukuCetveli] @proje_id = '"& proje_id &"', @firma_id = '"& Request.Cookies("kullanici")("firma_id") &"', @baslangic = '"& dongu_baslangic &"', @bitis = '"& dongu_bitis &"', @gosterim_tipi = '"& gosterim_tipi &"';"
                                        set cetvel = baglanti.execute(sql)
                                        'response.Write(SQL)
                                        tarih_sayi = cdate(dongu_bitis) - cdate(dongu_baslangic) + 1

                                        Dim gun_toplam2()
                                        Redim gun_toplam2(tarih_sayi)
                                        k = 0
                                        son_kaynak = ""
                                        do while not cetvel.eof 
                                            girdimi = false
                                            if not sonkaynak = cetvel("tip") & cetvel("id") then
                                                sonkaynak = cetvel("tip") & cetvel("id")
                                                girdimi = true
                                                k = k + 1
                                                klas = ""
                                                if k mod 2 = 0 then
                                                    klas = "ikincisi"
                                                end if
                                                
                                                gunsayi = 0

                                                if k > 1 then
                %>
                                        </tr>
                                        <% end if %>
                <tr class=" ustunegelince <%=klas %>">
                    <%
                            if trim(gosterim_tipi)="0" then
                                toplam_sayi = cdbl(toplam_sayi) + cdbl(cetvel("kaynak_toplam_sayi"))
                            elseif trim(gosterim_tipi)="1" then
                                toplam_sayi = cdbl(toplam_sayi) + cdbl(cetvel("kaynak_toplam_dakika"))
                            end if
                    %>
                    <td style="width: 150px;" class="ust_td2 headcol"><a href="javascript:void(0);" onclick="KaynakIsYukuDetayGoster('<%=cetvel("tip") %>', '<%=cetvel("id") %>');" style="color: white;"><i class="fa fa-plus-square"></i>&nbsp;&nbsp;<%=cetvel("kaynak") %></a></td>
                    <td class="gosterge_td alt_td ">
                        <% if trim(gosterim_tipi)="0" then %>
                        <%=cetvel("kaynak_toplam_sayi") %>
                        <% elseif trim(gosterim_tipi)="1" then %>
                        <%=cetvel("kaynak_toplam_saat") %>
                        <% end if %></td>

                    <% end if %>
                    <td class="alt_td  <% if cdbl(cetvel("saat"))>480 then %> taskin <% end if %> <% if day(cetvel("tarih"))=1 then %> alt_td2 <% end if %> <% if cdate(cetvel("tarih"))=cdate(date) then %> sarialan <% end if %> ">
                        <% if trim(gosterim_tipi)="0" then %>
                        <% if cdbl(cetvel("sayi"))=0 then %>-<% else %>
                        <!--<a href="javascript:void(0);" onclick="aiyda('<%=cetvel("id") %>','<%=cdate(cetvel("tarih")) %>');">-->
                        <%=cetvel("sayi") %>
                        <!--</a>-->
                        <% end if %>
                        <% elseif trim(gosterim_tipi)="1" then %>
                        <% if trim(cetvel("saat2"))="00:00" then %>-<% else %>
                        <!--<a href="javascript:void(0);" onclick="aiyda('<%=cetvel("id") %>','<%=cetvel("tarih") %>');">-->
                        <%=cetvel("saat2") %>
                        <!--</a>-->
                        <% end if %>
                        <% end if %>

                    </td>
                    <%  
                                                if trim(gosterim_tipi)="0" then
                                                    gun_toplam2(gunsayi) = cdbl(gun_toplam2(gunsayi)) + cdbl(cetvel("sayi"))
                                                elseif trim(gosterim_tipi)="1" then
                                                    gun_toplam2(gunsayi) = cdbl(gun_toplam2(gunsayi)) + cdbl(cetvel("saat"))
                                                end if
                                                gunsayi = gunsayi + 1

                                            cetvel.movenext
                                            loop
                    %>
                </tr>
                <tr>
                    <td class="ust_td2 headcol" style="width: 150px; background-color: #4d7193; color: white!important;"><%=LNG("TOPLAM")%></td>
                    <td class="gosterge_td alt_td ">
                        <% if trim(gosterim_tipi)="0" then %>
                        <%=toplam_sayi %>
                        <% elseif trim(gosterim_tipi)="1" then %>
                        <%=DakikadanSaatYap(toplam_sayi) %>
                        <% end if %>
                    </td>

                    <% for x = 0 to ubound(gun_toplam2)-1 %>
                    <td class="alt_td" style="background-color: #4d7193; color: white;">
                        <% if trim(gosterim_tipi)="0" then %>
                        <%=gun_toplam2(x) %>
                        <% elseif trim(gosterim_tipi)="1" then %>
                        <%=DakikadanSaatYap(gun_toplam2(x)) %>
                        <% end if %>
                    </td>
                    <% next %>
                </tr>
                <%
                                        Erase gun_toplam2
                %>

                <!--                                    <%
            SQL="SELECT id, kaynak, tip FROM dbo.gantt_kaynaklar WHERE firma_id = '"& Request.Cookies("kullanici")("firma_id") &"';"
            set kaynak = baglanti.execute(SQL)
                k = 0
            do while not kaynak.eof

                
                k = k + 1
                klas = ""
                if k mod 2 = 0 then
                    klas = "ikincisi"
                end if
                                    %>
                                    <tr class=" ustunegelince <%=klas %>">
                                        <td style="width: 150px;" class="ust_td headcol"><%=kaynak("kaynak") %></td>
                                        <% for x = dongu_baslangic to dongu_bitis %>
                                        <td class="alt_td <% if day(x)=1 then %> alt_td2 <% end if %> <% if cdate(baslangic)<=cdate(x) and cdate(bitis)>=cdate(x) then %> sarialan <% end if %> ">0</td>
                                        <% next %>
                                    </tr>
                                    <%
            kaynak.movenext
            loop
                                    %>-->


            </tbody>
        </table>
    </div>

    <div id="tablediv2" style="display: none;"></div>
</div>
<%

            elseif trn(request("islem"))="personel_rapor_is_yuku_gosterim_proje_sectim" then

                personel_id  = trn(request("personel_id"))
                proje_id = trn(request("proje_id"))
                dongu_baslangic = cdate(trn(request("baslangic")))
                dongu_bitis = cdate(trn(request("bitis")))
                gosterim_tipi = trn(request("gosterim_tipi"))

%>
<div>
    <div id="container"></div>
    <div id="tablediv">
        <table id="tablegosterge" style="border-color: #e8e8e8; font-family: Tahoma;">
            <thead id="thead">
                <tr>
                    <th rowspan="2" class="ilkth headcol">
                        <div style="width: 150px;"><%=LNG("Kaynaklar")%></div>
                    </th>
                    <th rowspan="2" class="ilkth headcol ">
                        <div style="width: 80px; text-align: center; margin-left: auto; margin-right: auto;">
                            <%=LNG("İş Sayısı")%>
                        </div>
                    </th>
                    <% 
                            son_ay = 0
                            for x = dongu_baslangic to dongu_bitis 
                                if not son_ay = month(x) then
                                    son_ay = month(x)
                                    cols = AyinSonGunu(cdate(x)) - day(cdate(x))
                                    if cdate( AyinSonGunu(cdate(x)) & "." & month(cdate(x)) & "." & year(cdate(x))) > dongu_bitis then
                                        cols = day(dongu_bitis)
                                    end if
                                    cols = cols + 1
                    %>
                    <th class="ust_th" colspan="<%=cols %>"><%=monthname(son_ay) %>&nbsp;<%=year(x) %></th>
                    <% 
                                end if
                            next
                    %>
                </tr>
                <tr>

                    <% for x = dongu_baslangic to dongu_bitis 
                            tarihler = tarihler & "'"& cdate(x) &"',"
                    %>
                    <th class="alt_th" style="<% if day(x)=1 then %> border-left: solid 3px white; <% end if %>">
                        <div class="guncizelge"><%=day(x) %></div>
                    </th>
                    <% next %>
                </tr>
            </thead>
            <tbody id="tbody">
                <%
                        SQL="Exec [dbo].[PersonelProjeIsYukuCetveli] @personel_id = '"& personel_id &"',  @proje_id = '"& proje_id &"', @firma_id = '"& Request.Cookies("kullanici")("firma_id") &"', @baslangic = '"& dongu_baslangic &"', @bitis = '"& dongu_bitis &"', @gosterim_tipi = '"& gosterim_tipi &"';"
                        set cetvel = baglanti.execute(sql)

                        tarih_sayi = cdate(dongu_bitis) - cdate(dongu_baslangic) + 1

                        Dim personel_rapor_gun_toplam2()
                        Redim personel_rapor_gun_toplam2(tarih_sayi)
                        k = 0
                        son_kaynak = ""
                        do while not cetvel.eof 
                            girdimi = false
                            if not sonkaynak = cetvel("tip") & cetvel("id") then
                                sonkaynak = cetvel("tip") & cetvel("id")
                                girdimi = true
                                k = k + 1
                                klas = ""
                                if k mod 2 = 0 then
                                    klas = "ikincisi"
                                end if
                                                
                                gunsayi = 0

                                if k > 1 then
                %>
                                        </tr>
                                        <% end if %>
                <tr class=" ustunegelince <%=klas %>">
                    <%
                                                if trim(gosterim_tipi)="0" then
                                                    toplam_sayi = cdbl(toplam_sayi) + cdbl(cetvel("kaynak_toplam_sayi"))
                                                elseif trim(gosterim_tipi)="1" then
                                                    toplam_sayi = cdbl(toplam_sayi) + cdbl(cetvel("kaynak_toplam_dakika"))
                                                end if
                                                
                    %>
                    <td style="width: 150px;" class="ust_td2 headcol"><%=cetvel("kaynak") %></td>
                    <td class="gosterge_td alt_td ">
                        <% if trim(gosterim_tipi)="1" then %>
                        <%=cetvel("kaynak_toplam_saat") %>
                        <% else %>
                        <%=cetvel("kaynak_toplam_sayi") %>
                        <% end if %></td>

                    <% end if %>
                    <td class="alt_td <% if day(cetvel("tarih"))=1 then %> alt_td2 <% end if %> <% if cdate(cetvel("tarih"))=cdate(date) then %> sarialan <% end if %> ">
                        <% if trim(gosterim_tipi)="1" then %>
                        <% if cdbl(cetvel("sayi"))=0 then %>-<% else %><% if trim(cetvel("saat2"))="00:00" then %>-<% else %><%=cetvel("saat2") %><% end if %><% end if %>
                        <% else %>
                        <%=cetvel("sayi") %>
                        <% end if %>

                    </td>
                    <%  
                                                if trim(gosterim_tipi)="1" then
maliyetler = maliyetler & NoktalamaDegis(cdbl(cetvel("saat"))/60) & ","
                                                    personel_rapor_gun_toplam2(gunsayi) = cdbl(personel_rapor_gun_toplam2(gunsayi)) + cdbl(cetvel("saat"))

                                                else
                                                        maliyetler = maliyetler & NoktalamaDegis(cdbl(cetvel("sayi"))) & ","
                                                    personel_rapor_gun_toplam2(gunsayi) = cdbl(personel_rapor_gun_toplam2(gunsayi)) + cdbl(cetvel("sayi"))                            
                                                end if
                                                gunsayi = gunsayi + 1

                                            cetvel.movenext
                                            loop



                                                            
                                       
                                                if len(maliyetler)>0 then
                                                    maliyetler = left(maliyetler, len(maliyetler)-1)
                                                end if

                    %>
                </tr>
                <tr>
                    <td class="ust_td2 headcol" style="width: 150px; background-color: #4d7193; color: white!important;"><%=LNG("TOPLAM")%></td>
                    <td class="gosterge_td alt_td ">
                        <% if trim(gosterim_tipi)="0" then %>
                        <%=toplam_sayi %>
                        <% elseif trim(gosterim_tipi)="1" then %>
                        <%=DakikadanSaatYap(toplam_sayi) %>
                        <% end if %>
                    </td>

                    <% for x = 0 to ubound(personel_rapor_gun_toplam2)-1 %>
                    <td class="alt_td" style="background-color: #4d7193; color: white;">
                        <% if trim(gosterim_tipi)="0" then %>
                        <%=personel_rapor_gun_toplam2(x) %>
                        <% elseif trim(gosterim_tipi)="1" then %>
                        <%=DakikadanSaatYap(personel_rapor_gun_toplam2(x)) %>
                        <% end if %>
                    </td>
                    <% next %>
                </tr>
                <%
                                        Erase personel_rapor_gun_toplam2
                %>

                <!--                                    <%
            SQL="SELECT id, kaynak, tip FROM dbo.gantt_kaynaklar WHERE firma_id = '"& Request.Cookies("kullanici")("firma_id") &"';"
            set kaynak = baglanti.execute(SQL)
                k = 0
            do while not kaynak.eof

                
                k = k + 1
                klas = ""
                if k mod 2 = 0 then
                    klas = "ikincisi"
                end if
                                    %>
                                    <tr class=" ustunegelince <%=klas %>">
                                        <td style="width: 150px;" class="ust_td headcol"><%=kaynak("kaynak") %></td>
                                        <% for x = dongu_baslangic to dongu_bitis %>
                                        <td class="alt_td <% if day(x)=1 then %> alt_td2 <% end if %> <% if cdate(baslangic)<=cdate(x) and cdate(bitis)>=cdate(x) then %> sarialan <% end if %> ">0</td>
                                        <% next %>
                                    </tr>
                                    <%
            kaynak.movenext
            loop
                                    %>-->


            </tbody>
        </table>
    </div>


    <script type="text/javascript">
        var data = [
            ['<%=LNG("Maliyetler")%>', <%=maliyetler %>]
        ];

        var update = function (obj, cel, val) {
            // Get the cell position x, y
            var id = $(cel).prop('id').split('-');
            // If the related series does not exists create a new one
            if (!chart.series[id[1]]) {
                // Create a new series row
                var row = [];
                for (i = 1; i < data[id[1]].length; i++) {
                    row.push(parseFloat(data[id[1]][i]));
                }
                // Append new series to the chart
                chart.addSeries({ name: data[id[1]][0], data: row });
            } else {
                // Update the value from the chart
                chart.series[id[1]].data[id[0] - 1].update({ y: parseFloat(val) });
            }
        }




        // Kepp it global
        var chart = null;

        $(function () {


            chart = Highcharts.chart('container', {
                chart: {
                    type: 'column'
                },
                title: {
                    text: '<%=proje_adi%>',
                    x: -20 //center
                },
                subtitle: {
                    text: '<%=LNG("Adam Saat Cetveli")%>',
                    x: -20
                },
                xAxis: {
                    categories: [<%=tarihler %>]
                },
                yAxis: {
                    title: {
                        text: 'Adam-Saat'
                    },
                    plotLines: [{
                        value: 0,
                        width: 1,
                        color: '#808080'
                    }]
                },
                tooltip: {
                                        <% if trim(gosterim_tipi) = "0" then %>
                valueSuffix: ' adet'
            <% else %>
            valueSuffix: ' saat'
            <% end if %>
                                    },
            legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
            series: [{
                name: '<%=LNG("İşçilik")%>',
                data: [<%=maliyetler %>]
            }]
                                });
                            });


    </script>

</div>
<%

        
            elseif trn(request("islem"))="firma_rapor_is_yuku_gosterim_proje_sectim" then

            firma_id  = trn(request("firma_id"))
            proje_id = trn(request("proje_id"))
            dongu_baslangic = cdate(trn(request("baslangic")))
            dongu_bitis = cdate(trn(request("bitis")))
            gosterim_tipi = trn(request("gosterim_tipi"))

%>
<div>
    <div id="container"></div>

    <div id="tablediv">
        <table id="tablegosterge" style="border-color: #e8e8e8; font-family: Tahoma;">
            <thead id="thead">
                <tr>
                    <th rowspan="2" class="ilkth headcol">
                        <div style="width: 150px;"><%=LNG("Kaynaklar")%></div>
                    </th>
                    <th rowspan="2" class="ilkth headcol ">
                        <div style="width: 80px; text-align: center; margin-left: auto; margin-right: auto;">
                            <%=LNG("İş Sayısı")%>
                        </div>
                    </th>

                    <% 
                                            son_ay = 0
                                            for x = dongu_baslangic to dongu_bitis 
                                                if not son_ay = month(x) then
                                                    son_ay = month(x)

                                                    cols = AyinSonGunu(cdate(x)) - day(cdate(x))

                                                    if cdate( AyinSonGunu(cdate(x)) & "." & month(cdate(x)) & "." & year(cdate(x))) > dongu_bitis then
                                                        cols = day(dongu_bitis)
                                                    end if

                                                    cols = cols + 1
                    %>
                    <th class="ust_th" colspan="<%=cols %>"><%=monthname(son_ay) %>&nbsp;<%=year(x) %></th>
                    <% 
                                                end if
                                            next
                    %>
                </tr>
                <tr>

                    <% for x = dongu_baslangic to dongu_bitis 
                            tarihler = tarihler & "'"& cdate(x) &"',"
                    %>
                    <th class="alt_th" style="<% if day(x)=1 then %> border-left: solid 3px white; <% end if %>">
                        <div class="guncizelge"><%=day(x) %></div>
                    </th>
                    <% next %>
                </tr>
            </thead>
            <tbody id="tbody">

                <%

                                        SQL="Exec [dbo].[TaseronProjeIsYukuCetveli] @taseron_id = '"& firma_id &"',  @proje_id = '"& proje_id &"', @firma_id = '"& Request.Cookies("kullanici")("firma_id") &"', @baslangic = '"& dongu_baslangic &"', @bitis = '"& dongu_bitis &"', @gosterim_tipi = '"& gosterim_tipi &"';"
                                        set cetvel = baglanti.execute(SQL)
                                                                               
                                        tarih_sayi = cdate(dongu_bitis) - cdate(dongu_baslangic) + 1

                                        Dim taseron_rapor_gun_toplam2()
                                        Redim taseron_rapor_gun_toplam2(tarih_sayi)
                                        k = 0
                                        son_kaynak = ""
                                        do while not cetvel.eof 
                                            girdimi = false
                                            if not sonkaynak = cetvel("tip") & cetvel("id") then
                                                sonkaynak = cetvel("tip") & cetvel("id")
                                                girdimi = true
                                                k = k + 1
                                                klas = ""
                                                if k mod 2 = 0 then
                                                    klas = "ikincisi"
                                                end if
                                                
                                                gunsayi = 0

                                                if k > 1 then
                %>
                                        </tr>
                                        <% end if %>
                <tr class=" ustunegelince <%=klas %>">
                    <%
                                                if trim(gosterim_tipi)="0" then
                                                    toplam_sayi = cdbl(toplam_sayi) + cdbl(cetvel("kaynak_toplam_sayi"))
                                                elseif trim(gosterim_tipi)="1" then
                                                    toplam_sayi = cdbl(toplam_sayi) + cdbl(cetvel("kaynak_toplam_dakika"))
                                                end if
                                                
                    %>
                    <td style="width: 150px;" class="ust_td2 headcol"><%=cetvel("kaynak") %></td>
                    <td class="gosterge_td alt_td ">
                        <% if trim(gosterim_tipi)="0" then %>
                        <%=cetvel("kaynak_toplam_sayi") %>
                        <% elseif trim(gosterim_tipi)="1" then %>
                        <%=cetvel("kaynak_toplam_saat") %>
                        <% end if %></td>

                    <% end if %>
                    <td class="alt_td <% if day(cetvel("tarih"))=1 then %> alt_td2 <% end if %> <% if cdate(cetvel("tarih"))=cdate(date) then %> sarialan <% end if %> ">
                        <% if trim(gosterim_tipi)="0" then %>
                        <% if cdbl(cetvel("sayi"))=0 then %>-<% else %><%=cetvel("sayi") %><% end if %>
                        <% elseif trim(gosterim_tipi)="1" then %>
                        <% if trim(cetvel("saat2"))="00:00" then %>-<% else %><%=cetvel("saat2") %><% end if %>
                        <% end if %>

                    </td>
                    <%  
                                if trim(gosterim_tipi)="0" then
                                        maliyetler = maliyetler & NoktalamaDegis(cdbl(cetvel("sayi"))) & ","
                                    taseron_rapor_gun_toplam2(gunsayi) = cdbl(taseron_rapor_gun_toplam2(gunsayi)) + cdbl(cetvel("sayi"))
                                elseif trim(gosterim_tipi)="1" then
                                    maliyetler = maliyetler & NoktalamaDegis(cdbl(cetvel("saat"))/60) & ","
                                    taseron_rapor_gun_toplam2(gunsayi) = cdbl(taseron_rapor_gun_toplam2(gunsayi)) + cdbl(cetvel("saat"))
                                end if
                                gunsayi = gunsayi + 1

                            cetvel.movenext
                            loop

                            if len(maliyetler)>0 then
                                maliyetler = left(maliyetler, len(maliyetler)-1)
                            end if

                    %>
                </tr>
                <tr>
                    <td class="ust_td2 headcol" style="width: 150px; background-color: #4d7193; color: white!important;"><%=LNG("TOPLAM")%></td>
                    <td class="gosterge_td alt_td ">
                        <% if trim(gosterim_tipi)="0" then %>
                        <%=toplam_sayi %>
                        <% elseif trim(gosterim_tipi)="1" then %>
                        <%=DakikadanSaatYap(toplam_sayi) %>
                        <% end if %>
                    </td>

                    <% for x = 0 to ubound(taseron_rapor_gun_toplam2)-1 %>
                    <td class="alt_td" style="background-color: #4d7193; color: white;">
                        <% if trim(gosterim_tipi)="0" then %>
                        <%=taseron_rapor_gun_toplam2(x) %>
                        <% elseif trim(gosterim_tipi)="1" then %>
                        <%=DakikadanSaatYap(taseron_rapor_gun_toplam2(x)) %>
                        <% end if %>
                    </td>
                    <% next %>
                </tr>
                <%
                                        Erase taseron_rapor_gun_toplam2
                %>

                <!--                                    <%
            SQL="SELECT id, kaynak, tip FROM dbo.gantt_kaynaklar WHERE firma_id = '"& Request.Cookies("kullanici")("firma_id") &"';"
            set kaynak = baglanti.execute(SQL)
                k = 0
            do while not kaynak.eof

                
                k = k + 1
                klas = ""
                if k mod 2 = 0 then
                    klas = "ikincisi"
                end if
                                    %>
                                    <tr class=" ustunegelince <%=klas %>">
                                        <td style="width: 150px;" class="ust_td headcol"><%=kaynak("kaynak") %></td>
                                        <% for x = dongu_baslangic to dongu_bitis %>
                                        <td class="alt_td <% if day(x)=1 then %> alt_td2 <% end if %> <% if cdate(baslangic)<=cdate(x) and cdate(bitis)>=cdate(x) then %> sarialan <% end if %> ">0</td>
                                        <% next %>
                                    </tr>
                                    <%
            kaynak.movenext
            loop
                                    %>-->


            </tbody>
        </table>
    </div>


    <script type="text/javascript">
        var data = [
            ['<%=LNG("Maliyetler")%>', <%=maliyetler %>]
        ];

        var update = function (obj, cel, val) {
            // Get the cell position x, y
            var id = $(cel).prop('id').split('-');
            // If the related series does not exists create a new one
            if (!chart.series[id[1]]) {
                // Create a new series row
                var row = [];
                for (i = 1; i < data[id[1]].length; i++) {
                    row.push(parseFloat(data[id[1]][i]));
                }
                // Append new series to the chart
                chart.addSeries({ name: data[id[1]][0], data: row });
            } else {
                // Update the value from the chart
                chart.series[id[1]].data[id[0] - 1].update({ y: parseFloat(val) });
            }
        }




        // Kepp it global
        var chart = null;

        $(function () {


            chart = Highcharts.chart('container', {
                chart: {
                    type: 'column'
                },
                title: {
                    text: '<%=proje_adi%>',
                    x: -20 //center
                },
                subtitle: {
                    text: '<%=LNG("Adam Saat Cetveli")%>',
                    x: -20
                },
                xAxis: {
                    categories: [<%=tarihler %>]
                },
                yAxis: {
                    title: {
                        text: '<%=LNG("Adam-Saat")%>'
                    },
                    plotLines: [{
                        value: 0,
                        width: 1,
                        color: '#808080'
                    }]
                },
                tooltip: {
                                        <% if trim(gosterim_tipi) = "0" then %>
                valueSuffix: ' adet'
            <% else %>
            valueSuffix: ' saat'
            <% end if %>
                                    },
            legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
            series: [{
                name: '<%=LNG("İşçilik")%>',
                data: [<%=maliyetler %>]
            }]
                                });
                            });


    </script>

</div>
<%
        elseif trn(request("islem"))="gorev_duzenle" then

            gorev_id = trn(request("gorev_id"))

            SQL="SELECT * FROM dbo.tanimlama_gorev_listesi where id = '"& gorev_id &"' and firma_id = '"& FirmaID &"'"
            set gorev = baglanti.execute(SQL)
%>


<div class="modal-header">
    <h6 class="modal-title"><%=LNG("Görev Güncelle")%></h6>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<div class="modal-body">
    <form id="koftiden"></form>
    <form autocomplete="off" id="gorev_duzenle_form">
        <div class="row">
            <label class="col-sm-5 col-lg-5 col-form-label">
                <%=LNG("Görev Adı")%>
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-user"></i>
                    </span>
                    <input type="text" name="dgorev_adi" id="dgorev_adi" value="<%=gorev("gorev_adi") %>" required data-msg="Görev Giriniz" class="form-control" />
                </div>
            </label>


            <style>
                .yetki_tablos tbody tr td {
                    height: 20px !important;
                    padding: 0 !important;
                }
            </style>
        </div>
        <hr />
        <h6><%=LNG("Yetkili Olduğu Bölümler")%></h6>
        <br />
        <div class="row">
            <div class="col-sm-12">
                <table style="width: 100%;">
                        <tr>
                            <td style="width: 50%; vertical-align: top;">
                                <table class="table yetki_tablo" style="font-size: 14px;">
                                    <tbody>
                                        <%
                                            SQL="select ISNULL((select COUNT(*) from Page.GorevYetkileri where GorevID = '"& gorev_id &"' and firma_id = 1 and durum = 'true' and cop = 'false' and Yetki = 1 and SayfaID = ms.SayfaID), 0) as states, * from Page.MenuSayfalar ms where ms.UstID = 0 and ms.Basamak = 0 and ms.durum = 1 and ms.cop = 0 and ms.firma_id = '"& FirmaID &"'"
                                            set basamak1 = baglanti.execute(SQL)
                                            
                                            x = 0
                                            do while not basamak1.eof
                                             x = x + 1
                                        %>
                                        <tr class="ictenustunegelince">
                                            <td style="width: 40px!important">
                                                <input type="checkbox" <% if basamak1("states") = 1 or basamak1("states") = True then %> checked="checked" <% end if %> onclick="ul_secim(1, this);" id="check<%=basamak1("SayfaID") %>" class="checksecim" kayit_id="<%=basamak1("SayfaID") %>" ust-id="<%=basamak1("UstID") %>" yetki="<%=basamak1("SayfaLink") %>"/>
                                            </td>
                                            <td style="font-weight: bold;"><i class="fa fa-sort-desc"></i>&nbsp&nbsp&nbsp;<%=basamak1("SayfaAdi") %></td>
                                        </tr>
                                        <%
                                            SQL="select ISNULL((select COUNT(*) from Page.GorevYetkileri where GorevID = '"& gorev_id &"' and firma_id = 1 and durum = 'true' and cop = 'false' and Yetki = 1 and SayfaID = ms.SayfaID), 0) as states, * from Page.MenuSayfalar ms where ms.UstID = '"& basamak1("SayfaID") &"' and ms.Basamak = 1 and ms.durum = 1 and ms.cop = 0 and ms.firma_id = '"& FirmaID &"'"
                                            set basamak2 = baglanti.execute(SQL)
                                            
                                            do while not basamak2.eof
                                        %>
                                        <tr>
                                            <td style="padding-left: 30px!important;">
                                                <input type="checkbox" <% if basamak2("states") = 1 or basamak2("states") = True then %> checked="checked" <% end if %> id="check<%=basamak2("SayfaID") %>" onclick="ul_secim(2, this);" kayit_id="<%=basamak2("SayfaID") %>" class="checksecim ul1_<%=basamak1("SayfaID") %>" ust-id="<%=basamak2("UstID") %>" />
                                            </td>
                                            <td style="padding-left: 30px!important;"><i class="fa fa-circle-o"></i>&nbsp&nbsp&nbsp;<%=basamak2("SayfaAdi") %></td>
                                        </tr>
                                        <%
                                            basamak2.movenext
                                            loop
                                        %>
                                        <%
                                            if x = 6 then
                                        %>
                                    </tbody>
                                </table>

                            </td>
                            <td style="width: 50%; vertical-align: top;">
                                <table class="table" style="font-size: 14px;">
                                    <tbody>
                                        <%
                                            end if
                                            basamak1.movenext
                                            loop
                                        %>
                            </td>
                        </tr>
                    </table>
            </div>
        </div>
    </form>
</div>
<div class="modal-footer">
    <input type="button" class="btn btn-primary" id="gorev_guncelle_buton" onclick="gorev_guncelle('<%=gorev("id")%>'); return false;" value="<%=LNG("Görev Güncelle")%>" />
</div>
<% elseif trn(request("islem"))="santiye_rapor_getir" then
        
        personel_id = trn(request("personel_id"))
        ay = trn(request("ay"))
        yil = trn(request("yil"))
        gosterim_tipi = trn(request("gosterim_tipi"))
        proje_id = trn(request("proje_id"))

        if trim(gosterim_tipi)="" then
            gosterim_tipi = 0
        end if

        if trim(proje_id)="" then
            proje_id = 0
        end if

        if isnumeric(ay)=false then
            ay = month(date)
        end if

        if isnumeric(yil)=false then
            yil = year(date)
        end if

        SQL="select * from ucgem_proje_listesi where id = '"& proje_id &"' and firma_id = '"& FirmaID &"'"
        set proje_adi_cek = baglanti.execute(SQL)

        if not proje_adi_cek.eof then
            proje_adi = proje_adi_cek("proje_adi")
        end if

%>


<div class="card">

    <div class="card-block">
        <div class="view-info">
            <div class="h5" style="font-size: 15px;"><%=LNG("Kaynak Maliyet Çizelgesi")%></div>
            <div class="row">

                <div class="col-md-3">
                    <%=LNG("Dönem")%><br />
                    <select name="rapor_is_yuku_donem" class="select2" onchange="proje_rapor_adam_saat_gosterim_tarih_sectim('<%=personel_id %>');" id="rapor_is_yuku_donem">
                        <% for x = 1 to 12 %>
                        <option value="<%=x & "-" & year(date)-1 %>"><%=monthname(x) & " " & year(date)-1 %> </option>
                        <% next %>
                        <% for x = 1 to month(date) %>
                        <option <% if trim(x & "-" & year(date))=trim(ay & "-" & yil) then %> selected="selected" <% end if %> value="<%=x & "-" & year(date) %>"><%=monthname(x) & " " & year(date) %> </option>
                        <% next %>
                    </select>
                </div>
                <div class="col-md-3">
                    <%=LNG("Gösterim")%><br />
                    <select name="rapor_is_yuku_gosterim_tipi" class="select2" onchange="proje_rapor_adam_saat_gosterim_tarih_sectim('<%=personel_id %>');" id="rapor_is_yuku_gosterim_tipi">
                        <option <% if trim(gosterim_tipi)="0" then %> selected="selected" <% end if %> value="0"><%=LNG("Maliyet")%></option>
                        <option <% if trim(gosterim_tipi)="1" then %> selected="selected" <% end if %> value="1"><%=LNG("Saat")%></option>
                    </select>
                </div>
                <div class="col-md-3">
                    <%=LNG("Proje")%><br />
                    <select name="rapor_is_yuku_proje_id" class="select2" onchange="proje_rapor_adam_saat_gosterim_tarih_sectim('<%=personel_id %>');" id="rapor_is_yuku_proje_id">
                        <option value="0"><%=LNG("Tüm Projeler")%></option>
                        <%
                                SQL="select id, proje_adi from ucgem_proje_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and durum = 'true' and cop = 'false'"
                                set projeler = baglanti.execute(SQL)
                                do while not projeler.eof
                        %>
                        <option <% if trim(proje_id)=trim(projeler("id")) then %> selected="selected" <% end if %> value="<%=projeler("id") %>"><%=projeler("proje_adi") %></option>
                        <%
                                projeler.movenext
                                loop
                        %>
                    </select>
                </div>

                <div class="col-lg-12">


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
                    <%
                        dongu_baslangic = cdate("01."& ay &"." & yil)
                        dongu_bitis = cdate(AyinSonGunu(dongu_baslangic) & "." & ay & "." & yil)

                    %>

                    <div id="container"></div>
                    <div class="tablediv" style="width: 100%; margin-top: 15px; overflow: auto;">
                        <div id="tablediv">
                            <table id="tablegosterge" style="border-color: #e8e8e8; font-family: Tahoma;">
                                <thead id="thead">
                                    <tr>
                                        <th rowspan="2" class="ilkth headcol">
                                            <div style="width: 250px;"><%=LNG("Kaynaklar")%></div>
                                        </th>
                                        <th rowspan="2" class="ilkth headcol ">
                                            <div style="width: 80px; text-align: center; margin-left: auto; margin-right: auto;">
                                                <%=LNG("Saat")%>
                                            </div>
                                        </th>
                                        <th rowspan="2" class="ilkth headcol ">
                                            <div style="width: 80px; text-align: center; margin-left: auto; margin-right: auto;">
                                                <%=LNG("Maliyet")%>
                                            </div>
                                        </th>
                                        <% 

                                                tarihler = ""
                                            son_ay = 0
                                            for x = dongu_baslangic to dongu_bitis 
                                                if not son_ay = month(x) then
                                                    son_ay = month(x)

                                                    cols = AyinSonGunu(cdate(x)) - day(cdate(x))

                                                    if cdate( AyinSonGunu(cdate(x)) & "." & month(cdate(x)) & "." & year(cdate(x))) > dongu_bitis then
                                                        cols = day(dongu_bitis)
                                                    end if

                                                    cols = cols + 1

                                                
                                        %>
                                        <th class="ust_th" colspan="<%=cols %>"><%=monthname(son_ay) %>&nbsp;<%=year(x) %></th>
                                        <% 
                                                end if
                                            next
                                        %>
                                    </tr>
                                    <tr>
                                        <% for x = dongu_baslangic to dongu_bitis 
                                                tarihler = tarihler & "'"& cdate(x) &"',"

                                        %>
                                        <th class="alt_th" style="<% if day(x)=1 then %> border-left: solid 3px white; <% end if %>">
                                            <div class="guncizelge"><%=day(x) %></div>
                                        </th>
                                        <% next 
                                                tarihler = left(tarihler, len(tarihler)-1)
                                        %>
                                    </tr>
                                </thead>
                                <tbody id="tbody">

                                    <%

                                        SQL="EXEC dbo.ProjeAdamSaatRaporu @firma_id = '"& Request.Cookies("kullanici")("firma_id") &"', @baslangic = '"& dongu_baslangic &"', @bitis = '"& dongu_bitis &"', @proje_id = '"& proje_id &"';"
                                        set cetvel = baglanti.execute(sql)

                                        tarih_sayi = cdate(dongu_bitis) - cdate(dongu_baslangic) + 1

                                        Dim gun_toplam_santiye()
                                        Redim gun_toplam_santiye(tarih_sayi)
                                        k = 0
                                        son_kaynak = ""
                                        do while not cetvel.eof 
                                            girdimi = false
                                            if not sonkaynak = cetvel("id") then
                                                sonkaynak = cetvel("id")
                                                girdimi = true
                                                k = k + 1
                                                klas = ""
                                                if k mod 2 = 0 then
                                                    klas = "ikincisi"
                                                end if
                                                
                                                gunsayi = 0

                                                if k > 1 then
                                    %>
                                        </tr>
                                        <% end if %>
                                    <tr class=" ustunegelince <%=klas %>">
                                        <%
                                                toplam_saat = cdbl(toplam_saat) + cdbl(cetvel("kaynak_toplam_saat"))
                                                toplam_tutar = cdbl(toplam_tutar) + cdbl(cetvel("kaynak_toplam_maliyet"))
                                        %>
                                        <td style="width: 150px;" class="ust_td2 headcol"><%=cetvel("kaynak") %></td>
                                        <td class="gosterge_td alt_td "><%= DakikadanSaatYap(cdbl(cetvel("kaynak_toplam_saat"))*60) %></td>
                                        <td class=" gosterge_td alt_td sagcizgi">
                                            <%=cetvel("kaynak_toplam_maliyet") %> TL
                                                
                                        </td>
                                        <% end if %>
                                        <td class="alt_td <% if day(cetvel("tarih"))=1 then %> alt_td2 <% end if %> <% if cdate(cetvel("tarih"))=cdate(date) then %> sarialan <% end if %> ">
                                            <% if trim(gosterim_tipi)="0" then %>
                                            <% if cdbl(cetvel("maliyet_tutari"))=0 then %>-<% else %><%=cetvel("maliyet_tutari") %>TL<% end if %>
                                            <% else %>
                                            <% if DakikadanSaatYap(cdbl(cetvel("saat"))*60)="00:00" then %>-<% else %><%=DakikadanSaatYap(cdbl(cetvel("saat"))*60) %><% end if %>
                                            <% end if %>

                                        </td>
                                        <%  

                                                
                                                if trim(gosterim_tipi)="0" then
                                                    maliyetler = maliyetler & NoktalamaDegis(cdbl(cetvel("maliyet_tutari"))) & ","
                                                    gun_toplam_santiye(gunsayi) = cdbl(gun_toplam_santiye(gunsayi)) + cdbl(cetvel("maliyet_tutari"))
                                                else
                                                    maliyetler = maliyetler & NoktalamaDegis(cdbl(cetvel("saat"))) & ","
                                                    gun_toplam_santiye(gunsayi) = cdbl(gun_toplam_santiye(gunsayi)) + (cdbl(cetvel("saat"))*60)
                                                end if

                                                gunsayi = gunsayi + 1

                                            cetvel.movenext
                                            loop

                                                maliyetler = left(maliyetler, len(maliyetler)-1)
                                        %>
                                    </tr>
                                    <tr>
                                        <td class="ust_td2 headcol" style="width: 150px; background-color: #4d7193; color: white!important;"><%=LNG("TOPLAM")%></td>
                                        <td class="gosterge_td alt_td "><%=DakikadanSaatYap(toplam_saat) %></td>
                                        <td class=" gosterge_td alt_td sagcizgi"><%=toplam_tutar %> TL</td>
                                        <% for x = 0 to ubound(gun_toplam_santiye)-1 %>
                                        <td class="alt_td" style="background-color: #4d7193; color: white;">
                                            <% if trim(gosterim_tipi)="0" then %>
                                            <%=gun_toplam_santiye(x) %> TL
                                            <% else %>
                                            <%=DakikadanSaatYap(gun_toplam_santiye(x)) %>
                                            <% end if %>
                                        </td>
                                        <% next %>
                                    </tr>
                                    <%
                                        Erase gun_toplam_santiye
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>


                    <script type="text/javascript">
                        var data = [
                            ['Maliyetler', <%=maliyetler %>]
                        ];

                        var update = function (obj, cel, val) {
                            // Get the cell position x, y
                            var id = $(cel).prop('id').split('-');
                            // If the related series does not exists create a new one
                            if (!chart.series[id[1]]) {
                                // Create a new series row
                                var row = [];
                                for (i = 1; i < data[id[1]].length; i++) {
                                    row.push(parseFloat(data[id[1]][i]));
                                }
                                // Append new series to the chart
                                chart.addSeries({ name: data[id[1]][0], data: row });
                            } else {
                                // Update the value from the chart
                                chart.series[id[1]].data[id[0] - 1].update({ y: parseFloat(val) });
                            }
                        }




                        // Kepp it global
                        var chart = null;

                        $(function () {


                            chart = Highcharts.chart('container', {
                                chart: {
                                    type: 'column'
                                },
                                title: {
                                    text: '<%=proje_adi%>',
                                    x: -20 //center
                                },
                                subtitle: {
                                    text: '<%=LNG("Adam Saat Cetveli")%>',
                                    x: -20
                                },
                                xAxis: {
                                    categories: [<%=tarihler %>]
                                },
                                yAxis: {
                                    title: {
                                        text: '<%=LNG("Adam-Saat")%>'
                                    },
                                    plotLines: [{
                                        value: 0,
                                        width: 1,
                                        color: '#808080'
                                    }]
                                },
                                tooltip: {
                                        <% if gosterim_tipi = "0" then %>
                                valueSuffix: ' TL'
                            <% else %>
                            valueSuffix: ' <%=LNG("saat")%>'
                            <% end if %>
                                    },
                            legend: {
                            layout: 'vertical',
                            align: 'right',
                            verticalAlign: 'middle',
                            borderWidth: 0
                        },
                            series: [{
                                name: '<%=LNG("İşçilik")%>',
                                data: [<%=maliyetler %>]
                            }]
                                });
                            });
                    </script>
                    <!-- <iframe id="adamsaatframe" src="/system_root/santiyeler/adamsaat_frame.asp" style="width: 100%; height: 1050px; overflow: scroll; border: none;"></iframe>-->
                </div>
            </div>
        </div>
    </div>
</div>
<% 

    elseif trn(request("islem"))="isyuku_timeline_calistir" then
%>
<style>
    .vis-labelset .vis-label {
        padding-top: 0 !important;
    }
</style>
<div id="visualization" style="display: none;"></div>
<script>

        $(function (){
        
           

        var groups = new vis.DataSet([
        <%
            SQL="select * from ucgem_firma_kullanici_listesi where firma_id = '"& Request.cookies("kullanici")("firma_id") &"' order by personel_ad + ' ' + personel_soyad asc"
            set kullanici = baglanti.execute(SQL)
            x = 0
            do while not kullanici.eof
        %>
            { id: <%=x %>, content: '<%=kullanici("personel_ad") & " " & kullanici("personel_soyad") %>', value: <%=kullanici("id") %> },
        <%
                x = x + 1
            kullanici.movenext
            loop
        %>
        ]);
          <% if 1 = 2 then %>
   
        var items = new vis.DataSet([
    <%
        SQL="SELECT STRING_ESCAPE(isler.adi, 'json') as is_adi, kullanici.id AS kullanici_id, ISNULL(isler.renk, '') AS renk, REPLACE( REPLACE( STUFF( ( ( SELECT '~' FROM etiketler etiket WITH (NOLOCK) WHERE CHARINDEX( ',' + ISNULL(etiket.sorgu, '') + ',', ',' + ISNULL(isler.departmanlar, '') + ',' ) > 0 FOR XML PATH('') ) ), 1, 1, '' ), '<', '<' ), '>', '>' ) hidden_etiketler, CASE WHEN isler.durum = 'false' THEN 'İPTAL' WHEN ISNULL(isler.tamamlanma_orani, 0) = 100 THEN 'BİTTİ' WHEN GETDATE() > CONVERT(DATETIME, isler.bitis_tarihi) + CONVERT(DATETIME, isler.bitis_saati) THEN 'GECİKTİ' WHEN ISNULL(isler.tamamlanma_orani, 0) = 0 THEN 'BEKLİYOR' WHEN ISNULL(isler.tamamlanma_orani, 0) < 100 THEN 'DEVAM EDİYOR' END AS is_durum, ( SELECT CONVERT(NVARCHAR(50), kullanici.id) + '~' + ISNULL(kullanici.personel_resim, '') + '~' + ISNULL(kullanici.personel_ad, '') + ' ' + ISNULL(kullanici.personel_soyad, '') + '|' FROM ucgem_firma_kullanici_listesi kullanici WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value =  kullanici.id ) > 0 FOR XML PATH('') ) AS gorevli_personeller, STUFF( ( ( SELECT '~' + etiket.adi FROM etiketler etiket WITH (NOLOCK) WHERE CHARINDEX(',' + ISNULL(etiket.sorgu, '') + ',', ',' + ISNULL(isler.departmanlar, '') + ',') > 0 FOR XML PATH('') ) ), 1, 1, '' ) AS departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad AS ekleyen_adsoyad, isler.* FROM ucgem_is_listesi isler WITH (NOLOCK) JOIN ucgem_firma_kullanici_listesi ekleyen WITH (NOLOCK) ON ekleyen.id = isler.ekleyen_id JOIN ucgem_firma_kullanici_listesi kullanici WITH (NOLOCK) ON (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value =  kullanici.id ) > 0 LEFT JOIN tanimlama_departman_listesi departman2 WITH (NOLOCK) ON (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  departman2.id ) > 0 WHERE isler.firma_id = '"& FirmaID &"' AND isler.durum = 'true' AND isler.cop = 'false' AND isler.baslangic_tarihi > GETDATE() ORDER BY (CONVERT(DATETIME, isler.guncelleme_tarihi) + CONVERT(DATETIME, isler.guncelleme_saati)) DESC;"
        
        set isler = baglanti.execute(SQL)
        do while not isler.eof


            yil = year(cdate(isler("baslangic_tarihi")))
            ay = month(cdate(isler("baslangic_tarihi")))
            gun = day(cdate(isler("baslangic_tarihi")))
            saat = left(isler("baslangic_saati"),2)
            dakika = right(left(isler("baslangic_saati"),5),2)

        
            yil2 = year(cdate(isler("bitis_tarihi")))
            ay2 = month(cdate(isler("bitis_tarihi")))
            gun2 = day(cdate(isler("bitis_tarihi")))
            saat2 = left(isler("bitis_saati"),2)
            dakika2 = right(left(isler("bitis_saati"),5),2)
                
                


        %>
            { id: <%=isler("kullanici_id") %><%=isler("id") %>, group: <%=isler("kullanici_id") %>, content: '<%=replace(isler("is_adi"),"'","\'") %>', start: new Date(<%=yil %>, <%=ay %>, <%=gun %>, <%=saat %>, <%=dakika %>, 0), end: new Date(<%=yil2 %>, <%=ay2 %>, <%=gun2 %>, <%=saat2 %>, <%=dakika2 %>, 0), className: 'kuturenk4' },
        <%
        isler.movenext
        loop
        %>
        ]);

        <% end if %>



    var items = new vis.DataSet([
      
            { id: 0, group: 0, content: 'Birinci İş', start: new Date(2018, 10, 17), end: new Date(2018, 10, 21), className: 'kuturenk4' },
            { id: 1, group: 0, content: 'İkinci iş', start: new Date(2018, 10, 19), end: new Date(2018, 10, 20), className: 'kuturenk4' },
            { id: 6, group: 0, content: 'Altıncı İş', start: new Date(2018, 10, 25), end: new Date(2018, 10, 28), className: 'kuturenk4' },
            { id: 2, group: 1, content: 'Üçüncü İş', start: new Date(2018, 10, 16), end: new Date(2018, 10, 24), className: 'kuturenk4' },
            { id: 3, group: 1, content: 'Dördüncü İş', start: new Date(2018, 10, 23), end: new Date(2018, 10, 24), className: 'kuturenk4' },
            { id: 4, group: 1, content: 'Beşinci İş', start: new Date(2018, 10, 22), end: new Date(2018, 10, 26), className: 'kuturenk4' },
            { id: 5, group: 2, content: 'Yedinci İş', start: new Date(2018, 10, 24), end: new Date(2018, 10, 27), className: 'kuturenk4' }
      
        ]);



        var container = document.getElementById('visualization');
        var options = {
            groupOrder: function (a, b) {
                return a.value - b.value;
            },
            editable: true,
            stack: false,
            zoomMin: 1000 * 60 * 60 * 24,
            zoomMax: 1000 * 60 * 60 * 24 * 31 * 3,
        };

        var timeline = new vis.Timeline(container);
        timeline.setOptions(options);
        timeline.setGroups(groups);
        timeline.setItems(items);

              timeline.setOptions({ orientation: { axis: "both" } });
                timeline.setOptions({ height: 550, maxHeight: 550 });


        items.on('*', function (event, properties) {

            if ("update" == event) {


                var items2 = items.get({
                    order: function (a, b) {
                        if (a.start > b.start)
                            return -1;
                        if (a.start < b.start)
                            return 1;
                        return 0;
                    }
                });

                items2.forEach(function (item) {
                    if (properties.data[0].group == item.group && properties.data[0].id != item.id && item.start >= properties.data[0].start) {
                        items.update({ id: item.id, start: properties.data[0].end, end: properties.data[0].end.addDays(Math.floor((item.end - item.start) / (1000 * 60 * 60 * 24))), group: item.group, content: item.content, className: 'kuturenk4' });
                    }
                });
            }
        });

        setTimeout(function () {

            timeline.setOptions({
                locale: "tr"
            });
            timeline.zoomOut(0.8);

        }, 500);

        Date.prototype.addDays = function (days) {
            var date = new Date(this.valueOf());
            date.setDate(date.getDate() + days);
            return date;
        }

         });
</script>
<%


    end if
%>
