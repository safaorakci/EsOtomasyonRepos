<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    
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


        SQL="update ucgem_firma_kullanici_listesi set gun1 = '" & gun1 & "', gun2 = '" & gun2 & "', gun3 = '" & gun3 & "', gun4 = '" & gun4 & "', gun5 = '" & gun5 & "', gun6 = '" & gun6 & "', gun7 = '" & gun7 & "', gun1_saat1 = '" & gun1_saat1 & "', gun1_saat2 = '" & gun1_saat2 & "', gun2_saat1 = '" & gun2_saat1 & "', gun2_saat2 = '" & gun2_saat2 & "', gun3_saat1 = '" & gun3_saat1 & "', gun3_saat2 = '" & gun3_saat2 & "', gun4_saat1 = '" & gun4_saat1 & "', gun4_saat2 = '" & gun4_saat2 & "', gun5_saat1 = '" & gun5_saat1 & "', gun5_saat2 = '" & gun5_saat2 & "', gun6_saat1 = '" & gun6_saat1 & "', gun6_saat2 = '" & gun6_saat2 & "', gun7_saat1 = '" & gun7_saat1 & "', gun7_saat2 = '" & gun7_saat2 & "' where id = '"& personel_id &"'"
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

            SQL="update ucgem_personel_mesai_girisleri set giris_tipi = '"& giris_tipi &"', saat = '"& saat &"', tarih = CONVERT(date, '"& tarih &"', 103), ekleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"', ekleme_tarihi = getdate(), ekleme_saati = getdate(), ekleme_zamani = getdate() where id = '"& kayit_id &"'"
            set guncelle = baglanti.execute(SQL)
            

        elseif trn(request("islem2"))="sil" then

            kayit_id = trn(request("kayit_id"))

            SQL="update ucgem_personel_mesai_girisleri set cop = 'true', silen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"', silme_tarihi = getdate(), silme_saati = getdate() where id = '"& kayit_id &"'"
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
                SQL="set datefirst 1;SELECT mesai.id as form_id, CASE WHEN mesai.giris_tipi = 1 THEN DATEDIFF( MINUTE, (CONVERT(DATETIME, mesai.tarih) + CONVERT(DATETIME, ISNULL( CASE WHEN DATEPART(dw, mesai.tarih) = 1 THEN kullanici.gun1_saat1 WHEN DATEPART(dw, mesai.tarih) = 2 THEN kullanici.gun2_saat1 WHEN DATEPART(dw, mesai.tarih) = 3 THEN kullanici.gun3_saat1 WHEN DATEPART(dw, mesai.tarih) = 4 THEN kullanici.gun4_saat1 WHEN DATEPART(dw, mesai.tarih) = 5 THEN kullanici.gun5_saat1 WHEN DATEPART(dw, mesai.tarih) = 6 THEN kullanici.gun6_saat1 WHEN DATEPART(dw, mesai.tarih) = 7 THEN kullanici.gun7_saat1 END, '00:00' ) ) ), CONVERT(DATETIME, mesai.tarih) + CONVERT(DATETIME, mesai.saat) ) ELSE DATEDIFF( MINUTE, (CONVERT(DATETIME, mesai.tarih) + CONVERT(DATETIME, ISNULL( CASE WHEN DATEPART(dw, mesai.tarih) = 1 THEN kullanici.gun1_saat2 WHEN DATEPART(dw, mesai.tarih) = 2 THEN kullanici.gun2_saat2 WHEN DATEPART(dw, mesai.tarih) = 3 THEN kullanici.gun3_saat2 WHEN DATEPART(dw, mesai.tarih) = 4 THEN kullanici.gun4_saat2 WHEN DATEPART(dw, mesai.tarih) = 5 THEN kullanici.gun5_saat2 WHEN DATEPART(dw, mesai.tarih) = 6 THEN kullanici.gun6_saat2 WHEN DATEPART(dw, mesai.tarih) = 7 THEN kullanici.gun7_saat2 END, '00:00' ) ) ), CONVERT(DATETIME, mesai.tarih) + CONVERT(DATETIME, mesai.saat) ) END AS fark, * FROM ucgem_personel_mesai_girisleri mesai JOIN ucgem_firma_kullanici_listesi kullanici ON kullanici.id = mesai.personel_id WHERE mesai.personel_id = '"& personel_id &"' AND mesai.cop = 'false' ORDER BY mesai.tarih DESC;"
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

        SQL="select * from ucgem_personel_mesai_girisleri where id = '"& kayit_id &"'"
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

        SQL="DECLARE @Date1 DATE = CONVERT(date, '"& tarih1 &"', 103), @Date2 DATE = CONVERT(date, '"& tarih2 &"', 103), @personel_id int = '"& personel_id &"'; SELECT DATEADD(DAY, number, @Date1) AS gun, CASE WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 1 THEN kullanici.gun1 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 2 THEN kullanici.gun2 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 3 THEN kullanici.gun3 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 4 THEN kullanici.gun4 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 5 THEN kullanici.gun5 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 6 THEN kullanici.gun6 WHEN DATEPART(dw, DATEADD(DAY, number, @Date1)) = 7 THEN kullanici.gun7 END AS varmi, ( SELECT TOP 1 mesai3.giris_tipi FROM ucgem_personel_mesai_girisleri mesai3 WHERE mesai3.tarih = DATEADD(DAY, number, @Date1) AND mesai3.cop = 'false' AND mesai3.personel_id = kullanici.id AND mesai3.giris_tipi = 2 ) AS giris_tipi, ISNULL( ( SELECT TOP 1 ISNULL( CASE WHEN mesai1.giris_tipi = 1 THEN DATEDIFF( MINUTE, (CONVERT(DATETIME, mesai1.tarih) + CONVERT( DATETIME, ISNULL( CASE WHEN DATEPART(dw, mesai1.tarih) = 1 THEN kullanici.gun1_saat1 WHEN DATEPART(dw, mesai1.tarih) = 2 THEN kullanici.gun2_saat1 WHEN DATEPART(dw, mesai1.tarih) = 3 THEN kullanici.gun3_saat1 WHEN DATEPART(dw, mesai1.tarih) = 4 THEN kullanici.gun4_saat1 WHEN DATEPART(dw, mesai1.tarih) = 5 THEN kullanici.gun5_saat1 WHEN DATEPART(dw, mesai1.tarih) = 6 THEN kullanici.gun6_saat1 WHEN DATEPART(dw, mesai1.tarih) = 7 THEN kullanici.gun7_saat1 END, '00:00' ) ) ), CONVERT(DATETIME, mesai1.tarih) + CONVERT(DATETIME, mesai1.saat) ) END, '999' ) FROM ucgem_personel_mesai_girisleri mesai1 WHERE mesai1.tarih = DATEADD(DAY, number, @Date1) AND mesai1.cop = 'false' AND mesai1.personel_id = kullanici.id AND mesai1.giris_tipi = 1 ), '999' ) AS fark, ISNULL( ( SELECT top 1 ISNULL( CASE WHEN mesai2.giris_tipi = 0 THEN DATEDIFF( MINUTE, (CONVERT(DATETIME, mesai2.tarih) + CONVERT( DATETIME, ISNULL( CASE WHEN DATEPART(dw, mesai2.tarih) = 1 THEN kullanici.gun1_saat2 WHEN DATEPART(dw, mesai2.tarih) = 2 THEN kullanici.gun2_saat2 WHEN DATEPART(dw, mesai2.tarih) = 3 THEN kullanici.gun3_saat2 WHEN DATEPART(dw, mesai2.tarih) = 4 THEN kullanici.gun4_saat2 WHEN DATEPART(dw, mesai2.tarih) = 5 THEN kullanici.gun5_saat2 WHEN DATEPART(dw, mesai2.tarih) = 6 THEN kullanici.gun6_saat2 WHEN DATEPART(dw, mesai2.tarih) = 7 THEN kullanici.gun7_saat2 END, '00:00' ) ) ), CONVERT(DATETIME, mesai2.tarih) + CONVERT(DATETIME, mesai2.saat) ) END, '999' ) FROM ucgem_personel_mesai_girisleri mesai2 WHERE mesai2.tarih = DATEADD(DAY, number, @Date1) AND mesai2.cop = 'false' AND mesai2.personel_id = kullanici.id AND mesai2.giris_tipi = 0 ), '999' ) AS fark2 FROM master..spt_values JOIN dbo.ucgem_firma_kullanici_listesi kullanici ON kullanici.id = @personel_id WHERE type = 'P' AND DATEADD(DAY, number, @Date1) <= @Date2;"
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

        SQL="select * from personel_zimmet_listesi where id = '"& kayit_id &"'"
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

            SQL="update personel_zimmet_listesi set cop = 'true', silen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"', silen_tarihi = getdate(), silen_saati = getdate() where id = '"& kayit_id &"'"
            set sil = baglanti.execute(SQL)

        elseif trn(request("islem2"))="guncelle" then

            kayit_id = trn(request("kayit_id"))
            zimmet_edilen = trn(request("zimmet_edilen"))

            SQL="update personel_zimmet_listesi set zimmet_edilen = '"& zimmet_edilen &"' where id = '"& kayit_id &"'"
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
                SQL="select kullanici.personel_ad + ' ' + kullanici.personel_soyad as zimmet_eden, zimmet.* from personel_zimmet_listesi zimmet join ucgem_firma_kullanici_listesi kullanici on kullanici.id = zimmet.ekleyen_id where zimmet.etiket = '"& etiket &"' and zimmet.etiket_id = '"& etiket_id &"' and zimmet.cop = 'false'"
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
                <td><%=cdate(zimmet("ekleme_tarihi")) & " " & left(zimmet("ekleme_saati"),5) %></td>
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

                SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& kayit_id &"'"
                set guncelle = baglanti.execute(SQL)

            end if

        elseif trim(request("islem2"))="sil" then

            dosya_id = trn(request("dosya_id")) 

            SQL="update ahtapot_dosya_deposu set cop = 'true', silen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"', silen_tarihi = getdate(), silen_saati = getdate() where id = '"& dosya_id &"'"
            set sil = baglanti.execute(SQL)

            if trim(etiket)="proje" then
                SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& kayit_id &"'"
                set guncelle = baglanti.execute(SQL)
            end if

        end if

%>
<div class="dt-responsive table-responsive" style="padding-bottom:85px">
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
                SQL="select kullanici.personel_ad + ' ' + kullanici.personel_soyad as ekleyen, depo.* from ahtapot_dosya_deposu depo join ucgem_firma_kullanici_listesi kullanici on kullanici.id = depo.ekleyen_id where depo.etiket = '"& etiket &"' and depo.kayit_id = '"& kayit_id &"' and depo.cop = 'false'"
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
                        <a class="dropdown-item" href="javascript:void(0);" onclick="depo_dosya_indir('<%=etiket %>', '<%=kayit_id %>', '<%=depo("id") %>');"><i class="icofont icofont-edit"></i><%=LNG("İndir")%></a>
                        <a class="dropdown-item" href="javascript:void(0);" onclick="depo_dosya_ac('<%=etiket %>', '<%=kayit_id %>', '<%=depo("id") %>');"><i class="icofont icofont-edit"></i><%=LNG("Aç")%></a>
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

    response.Write(SQL)
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

        SQL="declare @cari_id int = "& cari_id &", @cari_tip nvarchar(50) = '"& tip &"'; select  (select isnull(sum(meblag),0) from cari_hareketler where borclu_tipi = @cari_tip and borclu_id = @cari_id and parabirimi = 'TL' and cop = 'false') as borclu_tl,  (select isnull(sum(meblag),0) from cari_hareketler where borclu_tipi = @cari_tip and borclu_id = @cari_id and parabirimi = 'USD' and cop = 'false') as borclu_usd, (select isnull(sum(meblag),0) from cari_hareketler where borclu_tipi = @cari_tip and borclu_id = @cari_id and parabirimi = 'EUR' and cop = 'false') as borclu_eur, (select isnull(sum(meblag),0) from cari_hareketler where alacakli_tipi = @cari_tip and alacakli_id = @cari_id and parabirimi = 'TL' and cop = 'false') as alacakli_tl,  (select isnull(sum(meblag),0) from cari_hareketler where alacakli_tipi = @cari_tip and alacakli_id = @cari_id and parabirimi = 'USD' and cop = 'false') as alacakli_usd,  (select isnull(sum(meblag),0) from cari_hareketler where alacakli_tipi = @cari_tip and alacakli_id = @cari_id and parabirimi = 'EUR' and cop = 'false') as alacakli_eur, ((select isnull(sum(meblag),0) from cari_hareketler where borclu_tipi = @cari_tip and borclu_id = @cari_id and parabirimi = 'TL' and cop = 'false')- (select isnull(sum(meblag),0) from cari_hareketler where alacakli_tipi = @cari_tip and alacakli_id = @cari_id and parabirimi = 'TL' and cop = 'false')) as bakiye_tl,  ((select isnull(sum(meblag),0) from cari_hareketler where borclu_tipi = @cari_tip and borclu_id = @cari_id and parabirimi = 'USD' and cop = 'false')- (select isnull(sum(meblag),0) from cari_hareketler where alacakli_tipi = @cari_tip and alacakli_id = @cari_id and parabirimi = 'USD' and cop = 'false')) as bakiye_usd,  ((select isnull(sum(meblag),0) from cari_hareketler where borclu_tipi = @cari_tip and borclu_id = @cari_id and parabirimi = 'EUR' and cop = 'false')- (select isnull(sum(meblag),0) from cari_hareketler where alacakli_tipi = @cari_tip and alacakli_id = @cari_id and parabirimi = 'EUR' and cop = 'false')) as bakiye_eur"
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
<div class="page-error" style="display: none;">
    <div class="card text-center">
        <div class="card-block">
            <div class="m-t-10">
                <i class="icofont icofont-warning text-white bg-c-yellow"></i>
                <h4 class="f-w-600 m-t-25"><%=LNG("Hata Oluştu")%></h4>
                <p class="text-muted m-b-0"><%=LNG("Tarayıcınız Ajanda Uygulamasını Desteklemiyor.")%></p>
            </div>
        </div>
    </div>
</div>
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

                        SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& etiket_id &"'"
                        set guncelle = baglanti.execute(SQL)


                    end if
                next
            end if

            if trim(olay_tipi) <> "rutin" then

                SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('0', '"& kisiler &"', '"& baslangic_saati &"', '"& bitis_saati &"', '" & etiket & "', '" & trn(request("etiket_id")) & "', '" & title & "', '" & allDay & "', CONVERT(date, '"& baslangic_tarihi &"', 103), CONVERT(date, '"& bitis_tarihi &"', 103), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate()); SELECT SCOPE_IDENTITY() id;"
                set ekle = baglanti.execute(SQL)

                ana_kayit_id = ekle(0)

                SQL="update ahtapot_ajanda_olay_listesi set ana_kayit_id = '"& ana_kayit_id &"' where id = '"& ana_kayit_id &"'"
                set guncelle = baglanti.execute(SQL)

                for k = 0 to ubound(split(kisiler, ","))
                    kisi_id = split(kisiler, ",")(k)
                    if isnumeric(kisi_id)=true then
                        if cdbl(kisi_id)>0 then
                            etiket_id = kisi_id
                            SQL="SET NOCOUNT ON; insert into ahtapot_ajanda_olay_listesi(ana_kayit_id, kisiler, baslangic_saati, bitis_saati, etiket, etiket_id, title, allDay, baslangic, bitis, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& ana_kayit_id &"', '"& kisiler &"', '"& baslangic_saati &"', '"& bitis_saati &"', '" & etiket & "', '" & etiket_id & "', '" & title & "', '" & allDay & "', CONVERT(date, '"& baslangic_tarihi &"', 103), CONVERT(date, '"& bitis_tarihi &"', 103), '" & url & "', '" & color & "', '" & description & "', '" & etiketler & "', '" & durum & "', '" & cop & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate()); SELECT SCOPE_IDENTITY() id;"
                            set ekle = baglanti.execute(SQL)
                        end if
                    end if
                next

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
                                SQL="update ahtapot_ajanda_olay_listesi set ana_kayit_id = '"& ana_kayit_id &"' where id = '"& ana_kayit_id &"'"
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
                                    SQL="update ahtapot_ajanda_olay_listesi set ana_kayit_id = '"& ana_kayit_id &"' where id = '"& ana_kayit_id &"'"
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
                                    SQL="update ahtapot_ajanda_olay_listesi set ana_kayit_id = '"& ana_kayit_id &"' where id = '"& ana_kayit_id &"'"
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
                                        SQL="update ahtapot_ajanda_olay_listesi set ana_kayit_id = '"& ana_kayit_id &"' where id = '"& ana_kayit_id &"'"
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
                                                SQL="update ahtapot_ajanda_olay_listesi set ana_kayit_id = '"& ana_kayit_id &"' where id = '"& ana_kayit_id &"'"
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
                                                SQL="update ahtapot_ajanda_olay_listesi set ana_kayit_id = '"& ana_kayit_id &"' where id = '"& ana_kayit_id &"'"
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
                                                    SQL="update ahtapot_ajanda_olay_listesi set ana_kayit_id = '"& ana_kayit_id &"' where id = '"& ana_kayit_id &"'"
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
                                                    SQL="update ahtapot_ajanda_olay_listesi set ana_kayit_id = '"& ana_kayit_id &"' where id = '"& ana_kayit_id &"'"
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

            SQL="update ahtapot_ajanda_olay_listesi set cop = 'true', silen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"', silen_tarihi = getdate(), silen_saati = getdate() where id = '"& olay_id &"'"
            set sil = baglanti.execute(SQL)

            SQL="select IsID from ahtapot_ajanda_olay_listesi where id = '"& olay_id &"'"
            set olay = baglanti.execute(SQL)

            if isnumeric(olay(0))=true and 1 = 2 then
                if cdbl(olay(0))>0 then
                    
                    SQL="select count(id) from ucgem_is_gorevli_durumlari where is_id = '"& olay(0) &"' and durum = 'true' and cop = 'false'"
                    set kactane = baglanti.execute(SQL)

                    if cdbl(kactane(0))=1 then

                        SQL="update ucgem_is_listesi set durum = 'false' where id = '"& olay(0) &"'; update ucgem_is_gorevli_durumlari set durum = 'false' where is_id = '"& olay(0) &"';"
                        set guncelle = baglanti.execute(SQL)

                    elseif cdbl(kactane(0))>1 then

                        SQL="update ucgem_is_gorevli_durumlari set durum = 'false' where gorevli_id = '"& olay("etiket_id") &"' and is_id = '"& olay(0) &"';"
                        set guncelle = baglanti.execute(SQL)

                    end if

                end if
            end if

        elseif trn(request("islem2"))="komplesil" then

            ana_kayit_id = trn(request("ana_kayit_id"))

            if cdbl(ana_kayit_id)>0 then
                SQL="update ahtapot_ajanda_olay_listesi set cop = 'true', silen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"', silen_tarihi = getdate(), silen_saati = getdate() where ana_kayit_id = '"& ana_kayit_id &"'"
                set sil = baglanti.execute(SQL)
            end if

        elseif trn(request("islem2"))="sundur" then

            olay_id = trn(request("olay_id"))
            baslangic = left(trn(request("baslangic")),10)
            bitis = left(trn(request("bitis")),10)

            'baslangic = cdate(right(baslangic, 2) & "." & mid(baslangic, 6,2) & "." & left(baslangic, 4))
            'bitis = cdate(right(bitis, 2) & "." & mid(bitis, 6,2) & "." & left(bitis, 4))

            'baslangic_saati = right(trn(request("baslangic")),5)
            'bitis_saati = right(trn(request("bitis")),5)


            SQL="select *, Isnull(IsID, 0) as is_id from ahtapot_ajanda_olay_listesi where id = '"& olay_id &"'"
            response.Write(SQL)
            set olay = baglanti.execute(SQL)

            acikmi = true
            baslanmis = false
            if cdbl(olay("tamamlandi")) = -1 then
               baslanmis = true
            end if
            if cdbl(olay("is_id"))>0 then

                SQL="select count(id) from ucgem_is_gorevli_durumlari where is_id = '"& olay("is_id") &"' and durum = 'true' and cop = 'false'"
                set kactane = baglanti.execute(SQL)
                
                if cdbl(kactane(0))>1 then
                    acikmi = false
                end if
            end if

            if acikmi = true then
                
             if baslanmis = false then
        
                ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
                ekleyen_ip = Request.Cookies("kullanici")("kullanici_ip")
                
                SQL="update ucgem_is_listesi set baslangic_tarihi = '"& olay("baslangic") &"', bitis_tarihi = '"& olay("bitis") &"', baslangic_saati = '"& olay("baslangic_saati") &"', bitis_saati = '"& olay("bitis_saati") &"' where id = '"& olay("is_id") &"'"
                set guncelle = baglanti.execute(SQL)

                SQL="select top 1 case when isnull(ana_kayit_id,0) = 0 then id else ana_kayit_id end as ana_kayit_id from ahtapot_ajanda_olay_listesi where id = '"& olay_id &"'"
                set olay = baglanti.execute(SQL)

                ana_kayit_id = olay("ana_kayit_id")
         
                SQL="update ahtapot_ajanda_olay_listesi set baslangic = '"& baslangic &"', bitis = '"& bitis &"', ekleyen_id = '"& ekleyen_id &"', ekleyen_ip = '"& ekleyen_ip &"' where case when isnull(ana_kayit_id,0) = 0 then id else ana_kayit_id end = '"& ana_kayit_id &"'"
                set guncelle = baglanti.execute(SQL)
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
                        firma_kodu = Request.Cookies("kullanici")("firma_kodu")
                        firma_id = Request.Cookies("kullanici")("firma_id")
                        ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
                        ekleyen_ip = Request.ServerVariables("Remote_Addr")
                        ekleme_tarihi = date
                        ekleme_saati = time

                        SQL="insert into ucgem_proje_olay_listesi(proje_id, olay, olay_tarihi, olay_saati, departman_id, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', '"& olay &"', '"& olay_tarihi &"', '"& olay_saati &"', '"& departman_id &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', '"& ekleme_tarihi &"', '"& ekleme_saati &"'); "
                        set olay_ekle = baglanti.execute(SQL)

                        SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& etiket_id &"'"
                        set guncelle = baglanti.execute(SQL)

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

            SQL="update ahtapot_ajanda_olay_listesi set etiketler = '"& etiketler &"', title = N'"& title &"', color = '"& color &"', baslangic = CONVERT(date, '"& baslangic &"', 103), baslangic_saati = '"& baslangic_saati &"', bitis = CONVERT(date, '"& bitis &"', 103), bitis_saati = '"& bitis_saati &"', description = N'"& description &"', ekleyen_id = '"& ekleyen_id &"', ekleyen_ip = '"& ekleyen_ip &"' where id = '"& olay_id &"'"
            set guncelle = baglanti.execute(SQL)

            SQL="select case when isnull(ana_kayit_id,0) = 0 then id else ana_kayit_id end as ana_kayit_id from ahtapot_ajanda_olay_listesi where id = '"& olay_id &"'"
            set olay = baglanti.execute(SQL)

            ana_kayit_id = olay(0)

            SQL="update ahtapot_ajanda_olay_listesi set etiketler = '"& etiketler &"', title = N'"& title &"', color = '"& color &"', baslangic = CONVERT(date, '"& baslangic &"', 103), baslangic_saati = '"& baslangic_saati &"', bitis = CONVERT(date, '"& bitis &"', 103), bitis_saati = '"& bitis_saati &"', description = N'"& description &"', ekleyen_id = '"& ekleyen_id &"', ekleyen_ip = '"& ekleyen_ip &"' where case when isnull(ana_kayit_id,0) = 0 then id else ana_kayit_id end = '"& ana_kayit_id &"'"
            set guncelle = baglanti.execute(SQL)


            SQL="select *, Isnull(IsID, 0) as is_id from ahtapot_ajanda_olay_listesi where id = '"& olay_id &"'"
            set olay = baglanti.execute(SQL)

            acikmi = true
            if cdbl(olay("is_id"))>0 then

                SQL="select count(id) from ucgem_is_gorevli_durumlari where is_id = '"& olay("is_id") &"' and durum = 'true' and cop = 'false'"
                set kactane = baglanti.execute(SQL)

                if cdbl(kactane(0))>0 then
                    acikmi = false
                end if
            else
                acikmi = false
            end if

            if acikmi = true then

                SQL="update ucgem_is_listesi set baslangic_tarihi = CONVERT(date, '"& olay("baslangic") &"', 103), bitis_tarihi = CONVERT(date, '"& olay("bitis") &"', 103), baslangic_saati = '"& olay("baslangic_saati") &"', bitis_saati = '"& olay("bitis_saati") &"' where id = '"& olay("is_id") &"'"
                set guncelle = baglanti.execute(SQL)

            end if


        end if

    elseif trn(request("islem"))="is_listesi_lineer_takvim_getir" then
%>
<div class="card">
    <div class="card-block" style="padding: 0;">
        <div id="visualization" style="display:none;">
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
        SQL="update ahtapot_ajanda_olay_listesi set tamamlandi = '"& durum &"', color = '"& color &"' where id = '"& olay_id &"'"
        set guncelle = baglanti.execute(SQL)

        SQL="SELECT gorevli.id, olay.IsID FROM ahtapot_ajanda_olay_listesi olay JOIN dbo.ucgem_is_gorevli_durumlari gorevli ON gorevli.is_id = olay.IsID AND gorevli.gorevli_id = olay.etiket_id AND olay.etiket = 'personel' WHERE olay.id = '"& olay_id &"'"
        set olay = baglanti.execute(SQL)

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

        SQL="update ucgem_is_listesi set baslangic_tarihi = '"& baslangic_tarihi &"', bitis_tarihi = '"& bitis_tarihi &"', baslangic_saati = '"& baslangic_saati &"', bitis_saati = '"& bitis_saati &"' where id = '"& id &"'"
        set guncelle = baglanti.execute(SQL)

        SQL="select isnull(GantAdimID,0) as GantAdimID from ucgem_is_listesi where id = '"& id &"'"
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

            SQL="update ahtapot_proje_gantt_adimlari set start_uygulama = '"& start_uygulama &"', iend_uygulama = '"& iend_uygulama &"', start_tarih_uygulama = '"& start_tarih_uygulama &"', end_tarih_uygulama = '"& end_tarih_uygulama &"', duration_uygulama = '"& duration_uygulama &"' where id = '"& iss("GantAdimID") &"'"
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
                <div class="col-lg-12">
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

        SQL="SELECT ekleme_tarihi as baslangic, CASE WHEN DATEADD(DAY, 180, ekleme_tarihi) < GETDATE() THEN DATEADD(DAY, 30 , GETDATE()) ELSE DATEADD(DAY, 180, ekleme_tarihi) END as bitis FROM dbo.ucgem_proje_listesi WHERE id = '"& proje_id &"'"
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
<div class="card">

    <div class="card-blocks" style="padding-top: 10px;">
        <div class="view-info">
            <div class="row">
                <div id="proje_butce_yeri" class="col-lg-12">
                    <script>
                            $(function (){
                                proje_butce_listesi_getir('<%=proje_id %>');
                            });
                    </script>
                </div>
            </div>
        </div>
    </div>
</div>

<%
    elseif trn(request("islem"))="proje_gelir_getir" then

        proje_id = trn(request("proje_id"))

%>
<div class="card">
    <div class="card-block">
        <div class="view-info">
            <div class="row">
                <div id="proje_gelir_yeri" class="col-lg-12">
                    <h5><%=LNG("Proje Gelirleri")%>
                        <button id="edit-btn" type="button" style="margin-bottom: 10px;" onclick="proje_gelir_ekle('<%=proje_id %>');" class="btn btn-round btn-mini btn-success waves-effect waves-light f-right"><i class="icofont icofont-edit"></i><%=LNG("Gelir Ekle")%></button></h5>
                    <div id="proje_gelir_listesi">
                        <script>
                            $(function (){
                                proje_gelir_getir2('<%=proje_id %>');
                            });
                        </script>

                    </div>
                </div>
            </div>
        </div>
    </div>



    <%
     elseif trn(request("islem"))="proje_butce_listesi_getir" then

        proje_id = trn(request("proje_id"))

        if trn(request("islem2"))="ekle" then

            butce_hesabi_adi = trn(request("butce_hesabi_adi"))
            ongorulen_tutar = trn(request("ongorulen_tutar"))
            parabirimi = trn(request("parabirimi"))

            durum = "true"
            cop = "false"
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleme_tarihi = date
            ekleme_saati = time
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")

            ongorulen_tutar = NoktalamaDegis(ongorulen_tutar)

            SQL="insert into ahtapot_proje_butce_listesi(proje_id, butce_hesabi_adi, ongorulen_tutar, parabirimi, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', '"& butce_hesabi_adi &"', '"& ongorulen_tutar &"', '"& parabirimi &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', CONVERT(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"');"
            set ekle = baglanti.execute(SQL)

            SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& proje_id &"'"
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

            SQL="update ahtapot_proje_butce_listesi set cop = 'true', silen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"', silen_tarihi = getdate(), silen_saati = getdate() where id = '"& kayit_id &"'"
            set sil = baglanti.execute(SQL)

            SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& proje_id &"'"
            set guncelle = baglanti.execute(SQL)


            SQL="select * from ahtapot_proje_butce_listesi where id = '"& kayit_id &"'"
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

            SQL="insert into ucgem_proje_olay_listesi(proje_id, olay, olay_tarihi, olay_saati, departman_id, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', '"& olay &"', '"& olay_tarihi &"', '"& olay_saati &"', '"& departman_id &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', '"& ekleme_tarihi &"', '"& ekleme_saati &"')"
            set olay_ekle = baglanti.execute(SQL)

        elseif trn(request("islem2"))="guncelle" then

            kayit_id = trn(request("kayit_id"))
            butce_hesabi_adi = trn(request("butce_hesabi_adi"))
            ongorulen_tutar = trn(request("ongorulen_tutar"))
            parabirimi = trn(request("parabirimi"))

            ongorulen_tutar = NoktalamaDegis(ongorulen_tutar)

            SQL="update ahtapot_proje_butce_listesi set butce_hesabi_adi = '"& butce_hesabi_adi &"', ongorulen_tutar = '"& ongorulen_tutar &"', parabirimi = '"& parabirimi &"' where id = '"& kayit_id &"'"
            set guncelle = baglanti.execute(SQL)

            SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& proje_id &"'"
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

            SQL="insert into ucgem_proje_olay_listesi(proje_id, olay, olay_tarihi, olay_saati, departman_id, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', '"& olay &"', '"& olay_tarihi &"', '"& olay_saati &"', '"& departman_id &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', '"& ekleme_tarihi &"', '"& ekleme_saati &"')"
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

            SQL="insert into ahtapot_proje_satinalma_listesi(aciklama, odeme_tarihi, tedarikci_id, proje_id, satinalma_adi, butce_hesabi, satinalma_durum, ongorulen_tutar, ongorulen_pb, gerceklesen_tutar, gerceklesen_pb, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& satinalma_aciklama &"', '"& odeme_tarihi &"', '"& tedarikci_id &"', '"& proje_id &"', '"& satinalma_adi &"', '"& butce_hesabi &"', '"& satinalma_durum &"', '"& ongorulen_tutar &"', '"& ongorulen_pb &"', '"& gerceklesen_tutar &"', '"& gerceklesen_pb &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', '"& ekleme_tarihi &"', '"& ekleme_saati &"')"
            set ekle = baglanti.execute(SQL)

            SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& proje_id &"'"
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

            SQL="insert into ucgem_proje_olay_listesi(proje_id, olay, olay_tarihi, olay_saati, departman_id, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', '"& olay &"', '"& olay_tarihi &"', '"& olay_saati &"', '"& departman_id &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', '"& ekleme_tarihi &"', '"& ekleme_saati &"')"
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


            ongorulen_tutar = NoktalamaDegis(ongorulen_tutar)
            gerceklesen_tutar = NoktalamaDegis(gerceklesen_tutar)

            SQL="update ahtapot_proje_satinalma_listesi set aciklama = '"& satinalma_aciklama &"', satinalma_adi = '"& satinalma_adi &"', butce_hesabi = '"& butce_hesabi &"', satinalma_durum = '"& satinalma_durum &"', ongorulen_tutar = '"& ongorulen_tutar &"', ongorulen_pb = '"& ongorulen_pb &"', gerceklesen_tutar = '"& gerceklesen_tutar &"', gerceklesen_pb = '"& gerceklesen_pb &"' where id = '"& kayit_id &"'"
            set guncelle = baglanti.execute(SQL)

            SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& proje_id &"'"
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

            SQL="insert into ucgem_proje_olay_listesi(proje_id, olay, olay_tarihi, olay_saati, departman_id, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', '"& olay &"', '"& olay_tarihi &"', '"& olay_saati &"', '"& departman_id &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', '"& ekleme_tarihi &"', '"& ekleme_saati &"')"
            set olay_ekle = baglanti.execute(SQL)

        elseif trn(request("islem2"))="satinalmasil" then

            satis_id = trn(request("satis_id"))

            SQL="update ahtapot_proje_satinalma_listesi set cop = 'true' where id = '"& satis_id &"' and firma_id = '"& Request.Cookies("kullanici")("firma_id") &"'"
            set guncelle = baglanti.execute(SQL)

            SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& proje_id &"'"
            set guncelle = baglanti.execute(SQL)

            SQL="select * from ahtapot_proje_satinalma_listesi where id = '"& satis_id &"'"
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

            SQL="insert into ucgem_proje_olay_listesi(proje_id, olay, olay_tarihi, olay_saati, departman_id, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', '"& olay &"', '"& olay_tarihi &"', '"& olay_saati &"', '"& departman_id &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', '"& ekleme_tarihi &"', '"& ekleme_saati &"')"
            set olay_ekle = baglanti.execute(SQL)



        end if
    %>
    <div class="col-lg-12 col-xl-4" style="display: none">
        <h5 style="font-size: 15px; line-height: 35px;"><%=LNG("Bütçe Hesapları")%>
            <button id="edit-btn" style="margin-top: 0" type="button" onclick="proje_butce_hesabi_ekle('<%=proje_id %>');" class="btn btn-mini btn-success waves-effect waves-light f-right btn-round"><i class="icofont icofont-edit"></i><%=LNG("Bütçe Hesabı Ekle")%></button>
        </h5>
        <div>
            <%
                sql="SELECT ISNULL((SELECT SUM(satinalma.gerceklesen_tutar) FROM ahtapot_proje_satinalma_listesi satinalma WHERE satinalma.proje_id = butce.proje_id and butce.id = satinalma.butce_hesabi AND satinalma.cop = 'false' AND gerceklesen_pb = 'TL'),0) AS gerceklesen_tl, ISNULL((SELECT SUM(satinalma.gerceklesen_tutar) FROM ahtapot_proje_satinalma_listesi satinalma WHERE satinalma.proje_id = butce.proje_id and butce.id = satinalma.butce_hesabi AND satinalma.cop = 'false' AND gerceklesen_pb = 'USD'),0) AS gerceklesen_usd, ISNULL((SELECT SUM(satinalma.gerceklesen_tutar) FROM ahtapot_proje_satinalma_listesi satinalma WHERE satinalma.proje_id = butce.proje_id and butce.id = satinalma.butce_hesabi AND satinalma.cop = 'false' AND gerceklesen_pb = 'EUR'),0) AS gerceklesen_eur, * FROM ahtapot_proje_butce_listesi butce WHERE butce.proje_id = '"& proje_id &"' AND butce.cop = 'false';"
                set butce = baglanti.execute(SQL)

            %>

            <div class="dt-responsive table-responsive">
                <table id="new-cons" class="<% if butce.eof then %>kayityok<% end if %> table table-striped table-bordered table-hover" width="100%">
                    <thead>
                        <tr>
                            <th><%=LNG("Bütçe Hesap Adı")%></th>
                            <th style="text-align: center;"><%=LNG("Öngörülen / Kalan")%></th>
                            <th style="text-align: center;"><%=LNG("Gerçek")%></th>
                            <th style="text-align: center;"><%=LNG("Durum")%></th>
                            <th style="width: 10px;"></th>
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
                        do while not butce.eof


                            kalan_tutar = cdbl(butce("ongorulen_tutar")) - (cdbl(Ciftparacevir(butce("gerceklesen_tl"), "TL", butce("parabirimi"))) + cdbl(Ciftparacevir(butce("gerceklesen_usd"), "USD", butce("parabirimi")))+ cdbl(Ciftparacevir(butce("gerceklesen_eur"), "EUR", butce("parabirimi"))))
                            kalan_tutar2 = cdbl(butce("ongorulen_tutar")) - cdbl(kalan_tutar)
                            hesap = cint(100-(((cdbl(butce("ongorulen_tutar")) - cdbl(kalan_tutar2)) / cdbl(butce("ongorulen_tutar"))) * 100))

                        %>
                        <tr>
                            <td><%=butce("butce_hesabi_adi") %></td>
                            <td style="text-align: center;">
                                <label class="label label-primary" style="font-size: 12px;"><%=FormatNumber(butce("ongorulen_tutar"),2) %>&nbsp;<%=butce("parabirimi") %></label>
                                <br />
                                <label class="label label-danger" style="font-size: 12px;"><%=FormatNumber(kalan_tutar,2) %>&nbsp;<%=butce("parabirimi") %></label>
                            </td>
                            <td style="text-align: center; line-height: 5px;">
                                <label class="label label-warning" style="font-size: 12px;"><%=FormatNumber(butce("gerceklesen_tl"),2) %>&nbsp;TL</label><br />
                                <label class="label label-info" style="font-size: 12px;"><%=FormatNumber(butce("gerceklesen_usd"),2) %>&nbsp;USD</label><br />
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
                            <td class="dropdown" style="width: 10px;">
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
                </table>
            </div>
        </div>
    </div>

    <div class="col-lg-12 col-xl-8" style="display: none">
        <h5 style="font-size: 15px; line-height: 35px;"><%=LNG("Proje Giderleri")%>
            <button id="edit-btn" style="margin-top: -5px;" type="button" onclick="yeni_satinalma_kaydi_ekle('<%=proje_id %>');" class="btn btn-mini btn-success waves-effect waves-light f-right btn-round"><i class="icofont icofont-edit"></i><%=LNG("Yeni Satın Alma Ekle")%></button></h5>
        <div>
            <%
                SQL="select butce.butce_hesabi_adi, satinalma.* from ahtapot_proje_satinalma_listesi satinalma join ahtapot_proje_butce_listesi butce on butce.id = satinalma.butce_hesabi where satinalma.proje_id = '"& proje_id &"' and satinalma.cop = 'false'"
                set satis = baglanti.execute(SQL)
            %>
            <div class="dt-responsive table-responsive">
                <table id="new-cons2" class="<% if satis.eof then %>kayityok<% end if %> table table-striped table-bordered table-hover" width="100%">
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
                        %>
                        <tr>
                            <td colspan="6" style="text-align: center;"><%=LNG("Kayıt Yok")%></td>
                        </tr>
                        <%
                            end if
                            do while not satis.eof
                        %>
                        <tr>
                            <td><%=satis("satinalma_adi") %></td>
                            <td><%=satis("butce_hesabi_adi") %></td>
                            <td style="width: 120px;">
                                <% if trim(satis("satinalma_durum"))="Planlandı" then %>
                                <span class="label label-primary" style="font-size: 12px;"><%=LNG("PLANLANDI")%></span>
                                <% elseif trim(satis("satinalma_durum"))="Alındı" then %>
                                <span class="label label-info" style="font-size: 12px;"><%=LNG("ALINDI")%></span>
                                <% elseif trim(satis("satinalma_durum"))="Sipariş Verildi" then %>
                                <span class="label label-warning" style="font-size: 12px;"><%=LNG("SİPARİŞ VERİLDİ")%></span>
                                <% elseif trim(satis("satinalma_durum"))="Ödendi" then %>
                                <span class="label label-success" style="font-size: 12px;"><%=LNG("ÖDENDİ")%></span>
                                <% end if %>
                            </td>
                            <td style="text-align: center;"><%=formatnumber(satis("ongorulen_tutar"),2) %>&nbsp;<%=satis("ongorulen_pb") %></td>
                            <td style="color: red; text-align: center;"><%=formatnumber(satis("gerceklesen_tutar"),2) %>&nbsp;<%=satis("gerceklesen_pb") %></td>
                            <td class="dropdown">
                                <button type="button" class="btn btn-primary btn-mini dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-cog" aria-hidden="true"></i></button>
                                <div class="dropdown-menu dropdown-menu-right b-none contact-menu">
                                    <a class="dropdown-item" href="javascript:void(0);" onclick="proje_satinalma_kayit_duzenle('<%=proje_id %>', '<%=satis("id") %>');"><i class="icofont icofont-edit"></i><%=LNG("Düzenle")%></a>
                                    <a class="dropdown-item" href="javascript:void(0);" onclick="proje_satinalma_kayit_sil('<%=proje_id %>', '<%=satis("id") %>');"><i class="icofont icofont-ui-delete"></i><%=LNG("Sil")%></a>
                                </div>
                            </td>
                        </tr>
                        <%
                            satis.movenext
                            loop
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="col-lg-12 col-xl-12">
        <h5 style="font-size: 15px; line-height: 35px;"><%=LNG("Proje Giderleri")%>
            <button id="edit-btn" style="margin-top: -5px; display:none" type="button" onclick="yeni_satinalma_kaydi_ekle('<%=proje_id %>');" class="btn btn-mini btn-success waves-effect waves-light f-right btn-round"><i class="icofont icofont-edit"></i><%=LNG("Yeni Satın Alma Ekle")%></button></h5>
        <div>
            <%
                SQL="select id, IsId, sum(toplamtl) as toplamTL, sum(toplamusd) as toplamUSD, sum(toplameur) as toplamEUR from satinalma_listesi where proje_id = '"& proje_id &"' and durum != 'Iptal Edildi' and cop = 'false' group by id, IsId"
                'response.Write(SQL & "- ")
                set satinalmaformu = baglanti.execute(SQL)

                SQL="select id, IsId, sum(toplamtl) as toplamTL, sum(toplamusd) as toplamUSD, sum(toplameur) as toplamEUR from satinalma_listesi where proje_id = '"& proje_id &"' and durum != 'Iptal Edildi' and cop = 'false' group by id, IsId"
                'response.Write(SQL & "- ")
                set satinalmaformu2 = baglanti.execute(SQL)

                SQL = "DECLARE @id int; set @id='"& proje_id &"'; IF EXISTS(select id from satinalma_listesi where proje_id = @id) begin select id from satinalma_listesi where proje_id = @id and durum != 'Iptal Edildi' and cop = 'false' END else begin select 0 as id end"
                'response.Write(SQL & "- ")
                set sapariskontrol = baglanti.execute(SQL)

                SQL = "SELECT ROW_NUMBER() OVER(ORDER BY kullanici.id) AS Id, kullanici.personel_ad + ' ' + personel_soyad as ad_soyad, proje.proje_adi, dbo.DakikadanSaatYap((SELECT ISNULL(SUM ((DATEDIFF(n, CONVERT(DATETIME, calisma.baslangic,103), CONVERT(DATETIME, calisma.bitis,103)))), 0) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT((select departmanlar from ucgem_is_listesi where id = calisma.is_id), ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(50), proje.id)) > 0 AND calisma.durum = 'true' AND calisma.cop = 'false' and calisma.ekleyen_id = kullanici.id)) AS calismaSuresi, CONVERT(decimal(18,2), ((SELECT ISNULL(SUM((DATEDIFF(n, CONVERT(DATETIME, calisma.baslangic,103), CONVERT(DATETIME, calisma.bitis,103)))) * 0.016667, 0) * kullanici.personel_saatlik_maliyet FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT((select departmanlar from ucgem_is_listesi where id = calisma.is_id), ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(50), proje.id)) > 0 AND calisma.durum = 'true' AND calisma.cop = 'false' and calisma.ekleyen_id = kullanici.id))) AS toplamMaliyet FROM dbo.ucgem_proje_listesi proje, ucgem_firma_kullanici_listesi kullanici where proje.firma_id = '1' AND proje.id = '"& proje_id &"' AND proje.cop = 'false' AND proje.durum = 'true' AND ( ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT(DATETIME, calisma.baslangic,103), CONVERT(DATETIME, calisma.bitis,103)))), 0) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT((select departmanlar from ucgem_is_listesi where id = calisma.is_id), ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(50), proje.id)) > 0 AND calisma.durum = 'true' AND calisma.cop = 'false' and calisma.ekleyen_id = kullanici.id)) > 0 " 
                set personelAdamSaat = baglanti.execute(SQL)
                'response.Write(SQL)

            %>
            <div class="dt-responsive table-responsive" style="padding-bottom:50px">
                <table id="new-cons2" class="<% if satinalmaformu.eof then %>kayityok<% end if %> table table-bordered" width="100%" >
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
                                <a class="btn-link ml-2 mb-2" id="maliyetformu" onclick="maliyetDetayAc()"; style="cursor: pointer"><i id="sipico" class="fa fa-plus mr-2"></i>Proje Maliyet Detayı</a>
                            </td>
                            <td>
                                   <span id="subTotal" class="label-warning text-dark" style="padding:4px 10px; margin-right:0px; font-weight:bold; border-radius:5px">

                                   </span>
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
                                <td colspan="3" id="detayTD" style="display:none">
                                    <div class="col-md-7" id="maliyetDetay" style="display: none">
                                        <table id="dt_basic" class="table table-bordered datatableyap ml-2 mt-3 mb-3">
                                            <thead>
                                                <tr>
                                                    <th colspan="6" style="text-align:center; background-color: lightskyblue !important">Sipariş Verilen Parçalar</th>
                                                </tr>
                                                <tr>
                                                    <th>Parça</th>
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
                                                    SQL = "select * from satinalma_siparis_listesi where SatinalmaId = '0' and cop = 'false'"
                                                    set siparisparca = baglanti.execute(SQL)
                                                else
                                                    SQL = "select * from satinalma_siparis_listesi where SatinalmaId = '"& satinalmaformu("id") &"' and cop = 'false'"
                                                    set siparisparca = baglanti.execute(SQL)
                                                end if

                                                if siparisparca.eof then 
                                            %>
                                                 <tr>
                                                     <td colspan="6" style="text-align:center">Kayıt Bulunamadı</td>
                                                 </tr>
                                            <%
                                                end if
                                                do while not siparisparca.eof

                                                durum = 0
                                                if NOT IsNull(siparisparca("IsId")) then
                                                    SQL = "select id, IsID, ParcaId, StoktanKullanilanAdet, SiparisVerilenAdet from is_parca_listesi where ParcaId = '"& siparisparca("parcaId") &"' and IsID = '"& siparisparca("IsID") &"' and cop = 'false'"
                                                    durum = 1
                                                else
                                                    SQL = "select * from satinalma_siparis_listesi where SatinalmaId = '"& sapariskontrol("id") &"' and parcaId = '"& siparisparca("parcaId") &"' and cop = 'false'"
                                                    durum = 2
                                                end if
                                                set sondurum = baglanti.execute(SQL)
                                                if durum = 1 then
                                                    SQL = "select * from parca_listesi where id = '"& sondurum("ParcaId") &"' and cop = 'false'"
                                                elseif durum = 2 then
                                                    SQL = "select * from parca_listesi where id = '"& sondurum("parcaId") &"' and cop = 'false'"
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
                                            %>
                                                <tr>
                                                    <td><%=parcaBilgi("parca_kodu") %> - <%=parcaBilgi("parca_adi") %></td>
                                                    <td><%=parcaBilgi("marka") %></td>
                                                    <td><%=parcaBilgi("aciklama") %></td>
                                                    <td><% if durum = 1 then %> <%=CInt(sondurum("SiparisVerilenAdet") - parcaBilgi("minumum_miktar")) %> <%elseif durum = 2 then%> <%=sondurum("adet") %> <%end if %></td>
                                                    <td><%=parcaBilgi("birim_maliyet") %>&nbsp;<%=birimPB %></td>
                                                    <td class="toplamMaliyet"><%=SatinalmaToplamMaliyet %> &nbsp;<%=birimPB %></td>
                                                </tr>
                                            <%
                                                 siparisparca.movenext
                                                 loop
                                            %>
                                            <%
                                                satinalmaformu.movenext
                                                loop
                                            %>
                                            </tbody>
                                           </table>
                                        <table id="dt_basic" class="table table-bordered datatableyap ml-2 mt-3 mb-3">
                                            <thead>
                                                <tr>
                                                    <th colspan="6" style="text-align:center; background-color: lightskyblue !important">Stoktan Kullanılan Parçalar</th>
                                                </tr>
                                                <tr>
                                                    <th>Parça</th>
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
                                                            SQL = "select * from satinalma_siparis_listesi where SatinalmaId = '0' and cop = 'false'"
                                                            set eksikparca = baglanti.execute(SQL)
                                                        else
                                                            SQL = "select id, Adet, IsID, ParcaId, StoktanKullanilanAdet, SiparisVerilenAdet from is_parca_listesi where IsID = '"& satinalmaformu2("IsId") &"'"
                                                            set eksikparca = baglanti.execute(SQL)
                                                        end if
                                                    if eksikparca.eof then
                                                %>
                                                    <tr>
                                                        <td colspan="6" style="text-align:center">Kayıt Bulunamadı</td>
                                                    </tr>
                                                <%
                                                    end if
                                                    do while not eksikparca.eof

                                                    SQL = "select * from parca_listesi where id = '"& eksikparca("ParcaId") &"' and cop = 'false'"
                                                    set parcaBilgi = baglanti.execute(SQL)

                                                    birimPB = "TL"
                                                    if parcaBilgi("birim_pb") = "" then
                                                    else
                                                       birimPB = parcaBilgi("birim_pb")
                                                       if birimPB = "EURO" then
                                                           birimPB = "EUR"
                                                       end if
                                                    end if

                                                    KullanilanToplamMaliyet = Cdbl(parcaBilgi("birim_maliyet")) * eksikparca("StoktanKullanilanAdet")
                                                %>
                                                    <tr>
                                                        <td><%=parcaBilgi("parca_kodu") %> - <%=parcaBilgi("parca_adi") %></td>
                                                        <td><%=parcaBilgi("marka") %></td>
                                                        <td><%=parcaBilgi("aciklama") %></td>
                                                        <td><%=eksikparca("StoktanKullanilanAdet") %></td>
                                                        <td><%=parcaBilgi("birim_maliyet") %>&nbsp;<%=birimPB %></td>
                                                        <td class="toplamMaliyet"><%=KullanilanToplamMaliyet %>&nbsp;<%=birimPB %></td>
                                                    </tr>
                                                <%
                                                    eksikparca.movenext
                                                    loop
                                                %>
                                                <%
                                                    satinalmaformu2.movenext
                                                    loop
                                                %>
                                            </tbody>
                                        </table>
                                        <table class="table table-bordered ml-2 mt-3 mb-3">
                                            <thead>
                                                <tr>
                                                    <th colspan="3" style="text-align:center; background-color: lightskyblue !important">Personel Adam Saat</th>
                                                </tr>
                                                <tr>
                                                    <th>Personel</th>
                                                    <th>Çalışma Süresi</th>
                                                    <th>Toplam Maliyeti</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                    <%
                                                        if personelAdamSaat.eof then
                                                    %>
                                                        <tr>
                                                            <td colspan="3" style="text-align:center">Kayıt Bulunamadı</td>
                                                        </tr>
                                                    <%
                                                        end if
                                                        do while not personelAdamSaat.eof
                                                    %>
                                                        <tr>
                                                            <td><%=personelAdamSaat("ad_soyad") %></td>
                                                            <td><%=personelAdamSaat("calismaSuresi") %></td>
                                                            <td class="toplamMaliyet"><%=Replace(personelAdamSaat("toplamMaliyet"),",",".") %> TL</td>
                                                        </tr>
                                                    <%
                                                        personelAdamSaat.movenext
                                                        loop
                                                    %>
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
                                sumTL += parseFloat(valueTL);
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

    <script type="text/javascript">
        $("#btn-detay").click(function () {
            $("#parcadetay").slideToggle();
        });
        function maliyetDetayAc() {
            $("#detayTD").slideToggle();
            $("#maliyetDetay").slideToggle();
        }
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
    elseif trn(request("islem"))="proje_butce_hesabi_ekle" then

        proje_id = trn(request("proje_id"))


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
            <label class="col-sm-12 col-form-label"><%=LNG("Bütçe Hesabı Adı")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-cubes"></i>
                    </span>
                    <input type="text" class="form-control required" required name="butce_hesabi_adi" id="butce_hesabi_adi" />
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-9">
                <label class=""><%=LNG("Tutar")%></label>
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-cubes"></i>
                    </span>
                    <input type="text" class="form-control paraonly required regexonly" required name="ongorulen_tutar" value="0,00" id="ongorulen_tutar" />
                </div>
            </div>
            <div class="col-sm-3">
                <label class="col-sm-12 "><%=LNG("Parabirimi")%></label>
                <select name="parabirimi" id="parabirimi" class="select2">
                    <option value="TL">TL</option>
                    <option value="USD">USD</option>
                    <option value="EUR">EUR</option>
                </select>
            </div>
        </div>
        <div class="modal-footer">
            <input type="button" onclick="proje_butce_hesabi_kaydet(this, '<%=proje_id %>');" class="btn btn-primary" value="<%=LNG("Ekle")%>" />
        </div>
    </form>
    <script>
        $(function (){
            $('.paraonly:not(.yapilan)').addClass("yapilan").maskMoney({ thousands: '.', decimal: ',', allowZero: true, suffix: '' });
        });
    </script>
    <%
        elseif trn(request("islem"))="proje_butce_hesabi_duzenle" then

            kayit_id = trn(request("kayit_id"))
            proje_id = trn(request("proje_id"))

            SQL="select * from ahtapot_proje_butce_listesi where id = '"& kayit_id &"'"
            set cek = baglanti.execute(SQL)

    %>
    <div class="modal-header">
        <%=LNG("Bütçe Hesabı Düzenle")%>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <form id="koftiform"></form>
    <form autocomplete="off" id="butce_hesabi_ekleme_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
        <div class="row">
            <label class="col-sm-12 col-form-label"><%=LNG("Bütçe Hesabı Adı")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-cubes"></i>
                    </span>
                    <input type="text" class="form-control required" required name="butce_hesabi_adi" id="butce_hesabi_adi" value="<%=cek("butce_hesabi_adi") %>" />
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-9">
                <label class=""><%=LNG("Tutar")%></label>
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-cubes"></i>
                    </span>
                    <input type="text" class="form-control required regexonly paraonly" required name="ongorulen_tutar" id="ongorulen_tutar" value="<%=cek("ongorulen_tutar") %>" />
                </div>
            </div>
            <div class="col-sm-3">
                <label class="col-sm-12 "><%=LNG("Parabirimi")%></label>
                <select name="parabirimi" id="parabirimi">
                    <option <% if trim(cek("parabirimi"))="TL" then %> selected="selected" <% end if %> value="TL">TL</option>
                    <option <% if trim(cek("parabirimi"))="USD" then %> selected="selected" <% end if %> value="USD">USD</option>
                    <option <% if trim(cek("parabirimi"))="EUR" then %> selected="selected" <% end if %> value="EUR">EUR</option>
                </select>
            </div>
        </div>
        <div class="modal-footer">
            <input type="button" onclick="proje_butce_hesabi_guncelle(this, '<%=proje_id %>', '<%=cek("id")%>');" class="btn btn-primary" value="<%=LNG("Güncelle")%>" />
        </div>
    </form>
    <script>
        $(function (){
            $('.paraonly:not(.yapilan)').addClass("yapilan").maskMoney({ thousands: '.', decimal: ',', allowZero: true, suffix: '' });
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
                    SQL="select * from ahtapot_proje_gantt_adimlari where proje_id = '"& proje_id &"' and cop = 'false'"
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

                        <td style="text-align: right;">Salih ŞAHİN, Safa ORAKÇI</td>
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

        elseif trn(request("islem"))="is_ilerleme_ajanda_senkronizasyon_kaydet" then

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
            'response.Write(SQL)

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

            SQL="update ahtapot_ajanda_olay_listesi set cop = 'true' where color='"& renk &"'  and IsID = '"& IsID &"' and etiket = '"& etiket &"' and etiket_id = '"& etiket_id &"'"
            set guncelle = baglanti.execute(SQL)
        response.Write(SQL)

            SQL="insert into ahtapot_ajanda_olay_listesi(IsID, etiket, etiket_id, title, allDay, baslangic, bitis, baslangic_saati, bitis_saati, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, kisiler, ana_kayit_id, tamamlandi) values('"& IsID &"', '"& etiket &"', '"& etiket_id &"', '"& title &"', '"& allDay &"', CONVERT(date,'"& baslangic &"',103),CONVERT(date,'"& bitis &"',103), '"& baslangic_saati &"', '"& bitis_saati &"', '"& url &"', '"& color &"', '"& description &"', '"& etiketler &"', '"& durum &"', '"& cop &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"',  CONVERT(date, '"& ekleme_tarihi &"',103), '"& ekleme_saati &"', '"& kisiler &"', '"& ana_kayit_id &"', '"& tamamlandi &"')"
            set ekle = baglanti.execute(SQL)
        response.Write(SQL)

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
                                        set cetvel = baglanti.execute(sql)

                                        
                                        
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

            SQL="SELECT * FROM dbo.tanimlama_gorev_listesi where id = '"& gorev_id &"'"
            set gorev = baglanti.execute(SQL)

    %>


    <div class="modal-header">
        <h4 class="modal-title"><%=LNG("Görev Güncelle")%></h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <div class="modal-body">
        <form id="koftiden"></form>
        <form autocomplete="off" id="gorev_duzenle_form">
            <div class="row">

                <label class="col-sm-12  col-lg-12 col-form-label">
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
            <h5><%=LNG("Yetkili Olduğu Bölümler")%></h5>
            <br />
            <div class="row">
                <div class="col-sm-12">
                    <div style="margin: 4%; margin-top: 10px;">
                        <table style="width: 100%;">
                            <tr>
                                <td style="width: 50%; vertical-align: top;">
                                    <table class="table yetki_tablo" style="font-size: 14px;">
                                        <tbody>

                                            <%
                                    SQL="select dbo.iceriyormu('"& gorev("yetkili_sayfalar") &"', id) as varmi, * from ahtapot_sayfa_listesi where ust_id = '0' and basamak = '0'"
                                    set basamak1 = baglanti.execute(SQL)
                                    x = 0
                                    do while not basamak1.eof
                                     x = x + 1
                                                'response.Write("Basamak 1 varmı ? : " & basamak1("varmi"))
                                            %>
                                            <tr class="ictenustunegelince">
                                                <td style="width: 40px!important">
                                                    <input type="checkbox" <% if basamak1("varmi") = "Doğru" or basamak1("varmi") = "True" then %> checked="checked" <% end if %> onclick="ul_secim(1, this);" id="check<%=basamak1("id") %>" class="checksecim" kayit_id="<%=basamak1("id") %>" /></td>
                                                <td style="font-weight: bold;"><i class="fa fa-sort-desc"></i>&nbsp&nbsp&nbsp;<%=basamak1("sayfa_adi") %></td>
                                            </tr>
                                            <%
                                    SQL="select  dbo.iceriyormu('"& gorev("yetkili_sayfalar") &"', id) as varmi, * from ahtapot_sayfa_listesi where ust_id = '"& basamak1("id") &"' and basamak = '1'"
                                    set basamak2 = baglanti.execute(SQL)
                                                'response.Write(SQL)
                                    do while not basamak2.eof
                                            %>
                                            <tr>
                                                <td style="padding-left: 30px!important;">
                                                    <input type="checkbox" <% if basamak2("varmi") = "Doğru" or basamak2("varmi") = "True" then %> checked="checked" <% end if %> id="check<%=basamak2("id") %>" onclick="ul_secim(2, this);" kayit_id="<%=basamak2("id") %>" class="checksecim ul1_<%=basamak1("id") %>" /></td>
                                                <td style="padding-left: 30px!important;"><i class="fa fa-circle-o"></i>&nbsp&nbsp&nbsp;<%=basamak2("sayfa_adi") %></td>
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

        SQL="select * from ucgem_proje_listesi where id = '"& proje_id &"'"
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
    <div id="visualization" style="display:none;"></div>
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
        SQL="SELECT STRING_ESCAPE(isler.adi, 'json') as is_adi, kullanici.id AS kullanici_id, ISNULL(isler.renk, '') AS renk, REPLACE( REPLACE( STUFF( ( ( SELECT '~' FROM etiketler etiket WITH (NOLOCK) WHERE CHARINDEX( ',' + ISNULL(etiket.sorgu, '') + ',', ',' + ISNULL(isler.departmanlar, '') + ',' ) > 0 FOR XML PATH('') ) ), 1, 1, '' ), '<', '<' ), '>', '>' ) hidden_etiketler, CASE WHEN isler.durum = 'false' THEN 'İPTAL' WHEN ISNULL(isler.tamamlanma_orani, 0) = 100 THEN 'BİTTİ' WHEN GETDATE() > CONVERT(DATETIME, isler.bitis_tarihi) + CONVERT(DATETIME, isler.bitis_saati) THEN 'GECİKTİ' WHEN ISNULL(isler.tamamlanma_orani, 0) = 0 THEN 'BEKLİYOR' WHEN ISNULL(isler.tamamlanma_orani, 0) < 100 THEN 'DEVAM EDİYOR' END AS is_durum, ( SELECT CONVERT(NVARCHAR(50), kullanici.id) + '~' + ISNULL(kullanici.personel_resim, '') + '~' + ISNULL(kullanici.personel_ad, '') + ' ' + ISNULL(kullanici.personel_soyad, '') + '|' FROM ucgem_firma_kullanici_listesi kullanici WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value =  kullanici.id ) > 0 FOR XML PATH('') ) AS gorevli_personeller, STUFF( ( ( SELECT '~' + etiket.adi FROM etiketler etiket WITH (NOLOCK) WHERE CHARINDEX(',' + ISNULL(etiket.sorgu, '') + ',', ',' + ISNULL(isler.departmanlar, '') + ',') > 0 FOR XML PATH('') ) ), 1, 1, '' ) AS departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad AS ekleyen_adsoyad, isler.* FROM ucgem_is_listesi isler WITH (NOLOCK) JOIN ucgem_firma_kullanici_listesi ekleyen WITH (NOLOCK) ON ekleyen.id = isler.ekleyen_id JOIN ucgem_firma_kullanici_listesi kullanici WITH (NOLOCK) ON (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value =  kullanici.id ) > 0 LEFT JOIN tanimlama_departman_listesi departman2 WITH (NOLOCK) ON (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  departman2.id ) > 0 WHERE isler.firma_id = '1' AND isler.durum = 'true' AND isler.cop = 'false' AND isler.baslangic_tarihi>'15.10.2018' ORDER BY (CONVERT(DATETIME, isler.guncelleme_tarihi) + CONVERT(DATETIME, isler.guncelleme_saati)) DESC;"
        

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
