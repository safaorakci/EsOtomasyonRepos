﻿<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    FirmaID = Request.Cookies("kullanici")("firma_id")

    if trn(request("islem"))="KaynakIsYukuDetayGoster" then

        kullanici_id = trn(request("kaynak_id"))
        firma_id = Request.Cookies("kullanici")("firma_id")

        SQL="SELECT isler.id, isler.adi, isler.baslangic_tarihi, isler.baslangic_saati, isler.bitis_tarihi, isler.bitis_saati, ISNULL(isler.renk, '') AS renk, REPLACE( REPLACE( STUFF( ( ( SELECT '~' FROM etiketler etiket WITH (NOLOCK) WHERE firma_id = '"& firma_id &"' CHARINDEX( ',' + ISNULL(etiket.sorgu, '') + ',', ',' + ISNULL(isler.departmanlar, '') + ',' ) > 0 FOR XML PATH('') ) ), 1, 1, '' ), '<', '<' ), '>', '>' ) hidden_etiketler, CASE WHEN isler.durum = 'false' THEN 'İPTAL' WHEN ISNULL(isler.tamamlanma_orani, 0) = 100 THEN 'BİTTİ' WHEN GETDATE() > CONVERT(DATETIME, isler.bitis_tarihi) + CONVERT(DATETIME, isler.bitis_saati) THEN 'GECİKTİ' WHEN ISNULL(isler.tamamlanma_orani, 0) = 0 THEN 'BEKLİYOR' WHEN ISNULL(isler.tamamlanma_orani, 0) < 100 THEN 'DEVAM EDİYOR' END AS is_durum, ( SELECT CONVERT(NVARCHAR(50), kullanici.id) + '~' + ISNULL(kullanici.personel_resim, '') + '~' + ISNULL(kullanici.personel_ad, '') + ' ' + ISNULL(kullanici.personel_soyad, '') + '|' FROM ucgem_firma_kullanici_listesi kullanici WITH (NOLOCK) WHERE ( SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = kullanici.id ) > 0 FOR XML PATH('') ) AS gorevli_personeller, STUFF( ( ( SELECT '~' + etiket.adi FROM etiketler etiket WITH (NOLOCK) WHERE CHARINDEX(',' + ISNULL(etiket.sorgu, '') + ',', ',' + ISNULL(isler.departmanlar, '') + ',') > 0 FOR XML PATH('') ) ), 1, 1, '' ) AS departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad AS ekleyen_adsoyad FROM ucgem_is_listesi isler WITH (NOLOCK) JOIN ucgem_firma_kullanici_listesi ekleyen WITH (NOLOCK) ON ekleyen.id = isler.ekleyen_id JOIN ucgem_firma_kullanici_listesi kullanici WITH (NOLOCK) ON kullanici.id = '"& kullanici_id &"' LEFT JOIN tanimlama_departman_listesi departman2 WITH (NOLOCK) ON ( SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value = 'departman-' + CONVERT(NVARCHAR(50), departman2.id) ) > 0 WHERE isler.firma_id = '"& firma_id &"' AND ( SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = '"& kullanici_id &"' ) > 0 AND isler.durum = 'true' AND isler.cop = 'false' AND ( ( SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = '"& kullanici_id &"' ) > 0 OR isler.ekleyen_id = '"& kullanici_id &"' OR ( SELECT COUNT(value) FROM STRING_SPLIT(kullanici.departmanlar, ',') WHERE value = departman2.id ) > 0 ) GROUP BY isler.renk, isler.departmanlar, isler.durum, isler.tamamlanma_orani, isler.bitis_tarihi, isler.bitis_saati, isler.gorevliler, ekleyen.personel_ad, ekleyen.personel_soyad, isler.id, isler.adi, isler.guncelleme_tarihi, isler.guncelleme_saati, isler.baslangic_tarihi, isler.baslangic_saati ORDER BY (CONVERT(DATETIME, isler.guncelleme_tarihi) + CONVERT(DATETIME, isler.guncelleme_saati)) DESC;"
        set isler = baglanti.execute(SQL)

        sql="select personel_ad + ' ' + personel_soyad as personel from ucgem_firma_kullanici_listesi where id = '"& kullanici_id &"' and firma_id = '"& FirmaID &"'"
        set kullanicicek = baglanti.execute(SQL)

%>
<div style="display: none;">
    <% do while not isler.eof %>
    <lineer renk="<%=isler("renk") %>" baslangic_tarihi="<%=cdate(isler("baslangic_tarihi")) %>" baslangic_saati="<%=left(isler("baslangic_saati"),5) %>" bitis_tarihi="<%=cdate(isler("bitis_tarihi")) %>" bitis_saati="<%=left(isler("bitis_saati"),5) %>" id="<%=isler("id") %>" adi="<%=isler("adi") %>" etiketler="<%=isler("departman_isimleri") %>" ekleyen="<%=isler("ekleyen_adsoyad") %>" />
    <%
       isler.movenext
       loop
    %>
</div>

<div class="card">
    <div class="card-header">
        <h5><%=kullanicicek("personel") %> <%=LNG("İş Yükü Çizelgesi")%></h5>
        <span style="float: right;">
            <input type="button" class="btn btn-mini btn-danger" onclick="is_yuku_detay_geri_don();" value="<%=LNG("Geri Dön")%>" /></span>
    </div>

    <div class="card-block">
        <div id="visualization">
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
                is_yuku_timeline_calistir('<%=baslangic_tarihi %>', '<%=bitis_tarihi %>');
            })
        </script>

    </div>
</div>

<%

    
   elseif trn(request("islem"))="proje_kopy" then

        FirmaID = Request.Cookies("kullanici")("firma_id")
        proje_id = trn(request("proje_id"))
        hedef_proje_id = trn(request("hedef_proje_id"))
        islem_tipi = trn(request("islem_tipi"))

        if trim(islem_tipi)="1" then

            SQL="delete from ahtapot_proje_gantt_adimlari where proje_id = '"& hedef_proje_id &"' and firma_id = '"& FirmaID &"'"
            set sil = baglanti.execute(SQL)

            SQL="insert into ahtapot_proje_gantt_adimlari(start_tarih, end_tarih, start_tarih_uygulama, end_tarih_uygulama, cop, proje_id, name, progress, progressByWorklog, irelevance, type, typeId, description, code, ilevel, status, depends, start, duration, iend, start_uygulama, duration_uygulama, iend_uygulama, startIsMilestone, endIsMilestone, collapsed, canWrite, canAdd, canDelete, canAddIssue, hasChild, firma_id) select start_tarih, end_tarih, start_tarih_uygulama, end_tarih_uygulama, cop, '"& hedef_proje_id &"', name, 0, progressByWorklog, irelevance, type, typeId, description, code, ilevel, status, depends, start, duration, iend, start_uygulama, duration_uygulama, iend_uygulama, startIsMilestone, endIsMilestone, collapsed, canWrite, canAdd, canDelete, canAddIssue, hasChild, firma_id from ahtapot_proje_gantt_adimlari where proje_id = '"& proje_id &"'"
            set ekle = baglanti.execute(SQL)

        elseif trim(islem_tipi)="2" then

            SQL="select isnull(count(id),0) from ahtapot_proje_gantt_adimlari where proje_id = '"& hedef_proje_id &"' and firma_id = '"& FirmaID &"'"
            set kactanecek = baglanti.execute(SQL)

            kactane = kactanecek(0)

            SQL="insert into ahtapot_proje_gantt_adimlari(start_tarih, end_tarih, start_tarih_uygulama, end_tarih_uygulama, cop, proje_id, name, progress, progressByWorklog, irelevance, type, typeId, description, code, ilevel, status, depends, start, duration, iend, start_uygulama, duration_uygulama, iend_uygulama, startIsMilestone, endIsMilestone, collapsed, canWrite, canAdd, canDelete, canAddIssue, hasChild, firma_id) select start_tarih, end_tarih, start_tarih, end_tarih, cop, '"& hedef_proje_id &"', name, 0, progressByWorklog, irelevance, type, typeId, description, code, ilevel, status, depends, start, duration, iend, start, duration, iend, startIsMilestone, endIsMilestone, collapsed, canWrite, canAdd, canDelete, canAddIssue, hasChild, firma_id from ahtapot_proje_gantt_adimlari where proje_id = '"& proje_id &"' and ltrim(ilevel) != '0'"
            set ekle = baglanti.execute(SQL)

            SQL="select * from ahtapot_proje_gantt_adimlari where proje_id = '"& proje_id &"' and ltrim(ilevel) != '0' and firma_id = '"& FirmaID &"' order by id asc"
            set cek = baglanti.execute(SQL)
            do while not cek.eof
                depends = cek("depends")
                yeni_depends = ""
                for x = 0 to ubound(split(depends, ","))
                    eldeki = split(depends, ",")(x)
                    if isnumeric(eldeki)=true then
                        if cdbl(eldeki)>0 then
                            yeni_depends = (cdbl(eldeki) + cdbl(kactane)) & ","
                        end if
                    end if
                next
                if len(yeni_depends)>0 then
                    yeni_depends = left(yeni_depends, len(yeni_depends)-1)
                end if

                SQL="insert into ahtapot_proje_gantt_adimlari(start_tarih, end_tarih, start_tarih_uygulama, end_tarih_uygulama, cop, proje_id, name, progress, progressByWorklog, irelevance, type, typeId, description, code, ilevel, status, depends, start, duration, iend, start_uygulama, duration_uygulama, iend_uygulama, startIsMilestone, endIsMilestone, collapsed, canWrite, canAdd, canDelete, canAddIssue, hasChild, firma_id) select start_tarih, end_tarih, start_tarih, end_tarih, cop, '"& hedef_proje_id &"', name, 0, progressByWorklog, irelevance, type, typeId, description, code, ilevel, status, '"& yeni_depends &"', start, duration, iend, start, duration, iend, startIsMilestone, endIsMilestone, collapsed, canWrite, canAdd, canDelete, canAddIssue, hasChild, firma_id from ahtapot_proje_gantt_adimlari where id = '"& cek("id") &"'"
                set ekle = baglanti.execute(SQL)

            cek.movenext
            loop

        end if




    elseif trn(request("islem"))="proje_plan_kopyala" then

        proje_id = trn(request("proje_id"))

        SQL="select proje_adi from ucgem_proje_listesi where id = '"& proje_id &"' and firma_id = '"& Request.Cookies("kullanici")("firma_id") &"'"
        set projecek = baglanti.execute(SQL)

%>
<div class="modal-header">
    <%=LNG("Proje Plan Kopyala")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_personel_giris_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <label id="giris_cikis_tarih_text" class="col-sm-12 col-form-label">
            <center style="font-weight: bold;"><%=LNG("Kopyalanacak Proje Planı")%></center>
        </label>
        <div class="col-sm-12">
            <%=projecek("proje_adi") %><br />
            <br />
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Hedef Proje")%></label>
        <div class="col-sm-12">
            <select class="select2" name="hedef_proje_id" id="hedef_proje_id">
                <%
                    SQL="select id, proje_adi from ucgem_proje_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and durum = 'true' and cop = 'false'"
                    set projecek = baglanti.execute(SQL)
                    do while not projecek.eof
                %>
                <option value="<%=projecek("id") %>"><%=projecek("proje_adi") %></option>
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
                <option value="1"><%=LNG("Hedef Projedeki Planlamanın Üstüne Yaz")%></option>
                <option value="2"><%=LNG("Hedef Projedeki Planlamaya Ekle")%></option>
            </select>
        </div>
    </div>


    <div class="modal-footer">
        <input type="button" onclick="proje_kopyalama_baslat(this, '<%=proje_id %>');" class="btn btn-primary" value="<%=LNG("Kopyala")%>" />
    </div>
    <div id="kopyalama_donus" style="display: none;"></div>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#hedef_proje_id, #islem_tipi").select2({
                dropdownParent: $("#modal_div")
            });
        });
    </script>
</form>
<%
    elseif trn(request("islem"))="yeni_satinalma_kaydi_ekle" then

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
    <%=LNG("Satınalma Ekle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_satinalma_form" class="smart-form validateform" novalidate="novalidate">
    <div class="modal-body">
        <div class="row">
            <label class="col-sm-12 col-form-label"><%=LNG("Satınalma Adı")%></label>
            <div class="col-sm-12">
                <div class="form-group mb-0">
                    <input type="text" class="form-control form-control-sm required" required name="satinalma_adi" id="satinalma_adi" />
                </div>
            </div>
        </div>

        <div class="form-group mb-0">
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

        <div class="row">
            <label class="col-sm-12 col-form-label"><%=LNG("Bütçe Hesabı")%></label>
            <div class="col-sm-12">
                <select class="select2" name="butce_hesabi" id="butce_hesabi">
                    <%
                    SQL="select id , butce_hesabi_adi FROM dbo.ahtapot_proje_butce_listesi WHERE firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' AND proje_id = '"& proje_id &"' and cop = 'false'"
                    set butcecek = baglanti.execute(SQL)
                    do while not butcecek.eof
                    %>
                    <option value="<%=butcecek("id") %>"><%=butcecek("butce_hesabi_adi") %></option>
                    <%
                    butcecek.movenext
                    loop
                    %>
                </select>
            </div>
        </div>

        <div class="row">
            <label class="col-sm-12 col-form-label"><%=LNG("Durum")%></label>
            <div class="col-sm-12">
                <select class="select2" onchange="proje_satinalma_planlamami(this.value);" name="satinalma_durum" id="satinalma_durum">
                    <option value="Planlandı"><%=LNG("Planlandı")%></option>
                    <!--<option value="Alındı"><%=LNG("Alındı")%></option>-->
                    <option value="Sipariş Verildi"><%=LNG("Sipariş Verildi")%></option>
                    <option value="Ödendi"><%=LNG("Ödendi")%></option>
                </select>
            </div>
        </div>

        <div class="row">
            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Öngörülen Tutar")%></label>
            <div class="col-sm-9 col-lg-9">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-money"></i>
                    </span>
                    <input type="text" class="validate[required] paraonly form-control form-control-sm" id="ongorulen_tutar" name="ongorulen_tutar" onkeyup="proje_satinalma_ongorulen_kopyala();" required value="0.00" />
                </div>
            </div>
            <div class="col-sm-3 col-lg-3">
                <select id="ongorulen_pb" name="ongorulen_pb" onchange="proje_satinalma_ongorulen_kopyala();" class="select2">
                    <option value="TL">TL</option>
                    <option value="USD">USD</option>
                    <option value="EUR">EUR</option>
                </select>
            </div>
        </div>

        <div class="row planlama_girisi" style="display: none;">
            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Gerçekleşen Tutar")%></label>
            <div class="col-sm-9 col-lg-9">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-calendar"></i>
                    </span>
                    <input type="text" class="validate[required] paraonly form-control" id="gerceklesen_tutar" name="gerceklesen_tutar" required value="0.00" />
                </div>
            </div>
            <div class="col-sm-3 col-lg-3">
                <select id="gerceklesen_pb" name="gerceklesen_pb" class="select2">
                    <option value="TL">TL</option>
                    <option value="USD">USD</option>
                    <option value="EUR">EUR</option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="col-form-label"><%=LNG("Ödeme Tarihi")%></label>
            <select class="form-control form-control-sm select2" id="odeme_tarihi">
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

        <div class="row">
            <label class="col-sm-12 col-form-label"><%=LNG("Açıklama")%></label>
            <div class="col-sm-12">
                <div class="form-group">
                    <textarea id="satinalma_aciklama" name="satinalma_aciklama" class="required form-control" style="width: 93%; padding-left: 5px; padding-top: 6px;" required></textarea>
                </div>
            </div>
        </div>

        <script>
        $(function () {
            autosize($("#satinalma_aciklama"));
            $('.paraonly:not(.yapilan)').addClass("yapilan").maskMoney({ thousands: '.', decimal: ',', allowZero: true, suffix: '' });
        });
        </script>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#butce_hesabi, #tedarikci_id, #satinalma_durum, #ongorulen_pb, #gerceklesen_pb, #tarih, #odeme_tarihi").select2({
                    dropdownParent: $("#modal_div")
                });
            });
        </script>
    </div>
    <div class="modal-footer">
        <input type="button" onclick="proje_satinalma_kaydet(this, '<%=proje_id %>');" class="btn btn-primary btn-sm" value="<%=LNG("Kaydet")%>" />
    </div>
</form>
<%
    elseif trn(request("islem"))="proje_satinalma_kayit_duzenle" then

       proje_id = trn(request("proje_id"))
       kayit_id = trn(request("kayit_id"))

       SQL="select * from ahtapot_proje_satinalma_listesi where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"' and durum = 'true' and cop = 'false'"
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
    <%=LNG("Satınalma Kaydı Düzenle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="dyeni_satinalma_form" class="smart-form validateform" novalidate="novalidate">
    <div class="modal-body">
        <div class="col-md-12 p-0 mb-0">
            <label class="col-form-label"><%=LNG("Satınalma Adı")%></label>
            <div class="form-group mb-0">
                <input type="text" class="form-control form-control-sm required" required name="satinalma_adi" id="satinalma_adi" value="<%=cek("satinalma_adi") %>" />
            </div>
        </div>

        <div class="form-group mb-0">
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

        <div class="row">
            <label class="col-sm-12 col-form-label"><%=LNG("Bütçe Hesabı")%></label>
            <div class="col-sm-12">
                <select class="select2" name="butce_hesabi" id="butce_hesabi">
                    <%
                    SQL="select id , butce_hesabi_adi FROM dbo.ahtapot_proje_butce_listesi WHERE firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' AND proje_id = '"& proje_id &"' and cop = 'false'"
                    set butcecek = baglanti.execute(SQL)
                    do while not butcecek.eof
                    %>
                    <option <% if trim(cek("butce_hesabi"))=trim(butcecek("id")) then %> selected="selected" <% end if %> value="<%=butcecek("id") %>"><%=butcecek("butce_hesabi_adi") %></option>
                    <%
                    butcecek.movenext
                    loop
                    %>
                </select>
            </div>
        </div>
        <div class="row">
            <label class="col-sm-12 col-form-label"><%=LNG("Durum")%></label>
            <div class="col-sm-12">
                <select class="select2" onchange="proje_satinalma_planlamami(this.value);" name="satinalma_durum" id="satinalma_durum">
                    <option <% if trim(cek("satinalma_durum"))="Planlandı" then %> selected="selected" <% end if %> value="Planlandı"><%=LNG("Planlandı")%></option>
                    <!--<option <% if trim(cek("satinalma_durum"))="Alındı" then %> selected="selected" <% end if %> value="Alındı"><%=LNG("Alındı")%></option>-->
                    <option <% if trim(cek("satinalma_durum"))="Sipariş Verildi" then %> selected="selected" <% end if %> value="Sipariş Verildi"><%=LNG("Sipariş Verildi")%></option>
                    <option <% if trim(cek("satinalma_durum"))="Ödendi" then %> selected="selected" <% end if %> value="Ödendi"><%=LNG("Ödendi")%></option>
                </select>
            </div>
        </div>
        <div class="row">
            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Öngörülen Tutar")%></label>
            <div class="col-sm-9 col-lg-9">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-money"></i>
                    </span>
                    <input type="text" class="validate[required] paraonly form-control" id="ongorulen_tutar" name="ongorulen_tutar" onkeyup="proje_satinalma_ongorulen_kopyala();" required value="<%=formatnumber(cek("ongorulen_tutar"),2) %>" />
                </div>
            </div>
            <div class="col-sm-3 col-lg-3">
                <select id="ongorulen_pb" name="ongorulen_pb" onchange="proje_satinalma_ongorulen_kopyala();" class="select2">
                    <option <% if trim(cek("ongorulen_pb"))="TL" then %> selected="selected" <% end if %> value="TL">TL</option>
                    <option <% if trim(cek("ongorulen_pb"))="USD" then %> selected="selected" <% end if %> value="USD">USD</option>
                    <option <% if trim(cek("ongorulen_pb"))="EUR" then %> selected="selected" <% end if %> value="EUR">EUR</option>
                </select>
            </div>
        </div>
        <div class="row planlama_girisi" <% if trim(cek("satinalma_durum"))="Planlandı" then %> style="display: none;" <% end if %>>
            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Gerçekleşen Tutar")%></label>
            <div class="col-sm-9 col-lg-9">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-money"></i>
                    </span>
                    <input type="text" class="validate[required] paraonly form-control" id="gerceklesen_tutar" name="gerceklesen_tutar" required value="<%=formatnumber(cek("gerceklesen_tutar"),2) %>" />
                </div>
            </div>
            <div class="col-sm-3 col-lg-3">
                <select id="gerceklesen_pb" name="gerceklesen_pb" class="select2">
                    <option <% if trim(cek("ongorulen_pb"))="TL" then %> selected="selected" <% end if %> value="TL">TL</option>
                    <option <% if trim(cek("ongorulen_pb"))="USD" then %> selected="selected" <% end if %> value="USD">USD</option>
                    <option <% if trim(cek("ongorulen_pb"))="EUR" then %> selected="selected" <% end if %> value="EUR">EUR</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="col-form-label"><%=LNG("Ödeme Tarihi")%></label>
            <select class="form-control form-control-sm select2" id="odeme_tarihi">
                <%
                        for i = 1 to 12
                            value = MONTHNAME(i) & " " & YEAR(date)
                            if i < 10 then 
                                i = "0" & i
                            end if
                            insertValue = "01." & i & "." & YEAR(date)
                    
                            if IsNull(cek("odeme_tarihi")) then
                                getDate = "01" & "." & Month(date) & "." & YEAR(date)
                            else
                                getDate = cek("odeme_tarihi")
                            end if
                %>
                <option <%if cdate(insertValue) = cdate(myDateFormat(getDate)) then  %>selected="selected"<%end if %> value="<%=insertValue %>"><%=value %></option>
                <%
                        response.Write(myDateFormat(getDate))
                        next
                %>
            </select>
        </div>
        <div class="row">
            <label class="col-sm-12 col-form-label"><%=LNG("Açıklama")%></label>
            <div class="col-sm-12">
                <div class="form-group">
                    <textarea id="satinalma_aciklama" name="satinalma_aciklama" class="required form-control" style="width: 93%; padding-left: 5px; padding-top: 6px;" required><%=cek("aciklama") %></textarea>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(function () {
                autosize($("#satinalma_aciklama"));
                $('.paraonly:not(.yapilan)').addClass("yapilan").maskMoney({ thousands: '.', decimal: ',', allowZero: true, suffix: '' });
            });
            $(document).ready(function () {
                $("#butce_hesabi, #tedarikci_id, #satinalma_durum, #ongorulen_pb, #gerceklesen_pb, #tarih, #odeme_tarihi").select2({
                    dropdownParent: $("#modal_div")
                });
            });
        </script>
    </div>
    <div class="modal-footer">
        <input type="button" onclick="proje_satinalma_guncelle(this, '<%=proje_id %>', '<%=kayit_id%>');" class="btn btn-primary btn-sm" value="<%=LNG("Güncelle")%>" />
    </div>
</form>
<%

    elseif trn(request("islem"))="proje_gelir_ekle" then
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
    <%=LNG("Gelir Ekle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_gelir_form" class="smart-form validateform" novalidate="novalidate">
    <div class="modal-body">
        <div class="col-md-12 p-0">
            <label class="col-form-label"><%=LNG("Gelir Adı")%></label>
            <div class="form-group">
                <input type="text" class="form-control required" required name="gelir_adi" id="gelir_adi" />
            </div>
        </div>
        <div class="row d-none">
            <label class="col-sm-12 col-form-label"><%=LNG("Durum")%></label>
            <div class="col-sm-12">
                <select class="select2" onchange="proje_gelir_odendimi(this.value);" name="gelir_durum" id="gelir_durum">
                    <option value="Bekliyor"><%=LNG("Bekliyor")%></option>
                    <option value="Ödendi"><%=LNG("Ödendi")%></option>
                    <!--<option value="Ertelendi"><%=LNG("Ertelendi")%></option>-->
                </select>
            </div>
        </div>
        <div class="row">
            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Tutar")%></label>
            <div class="col-sm-9 col-lg-9">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-money"></i>
                    </span>
                    <input type="text" class="validate[required] paraonly form-control" id="odeme_tutar" name="odeme_tutar" required value="0.00" />
                </div>
            </div>
            <div class="col-sm-3 col-lg-3">
                <select id="odeme_pb" name="odeme_pb" class="select2">
                    <option value="TL">TL</option>
                    <option value="USD">USD</option>
                    <option value="EUR">EUR</option>
                </select>
            </div>
        </div>
        <div class="row">
            <label class="col-sm-12 col-form-label"><%=LNG("Planlanan Tarih")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-calendar"></i>
                    </span>
                    <input type="text" class="form-control takvimyap required" required name="planlanan_tarih" id="planlanan_tarih" />
                </div>
            </div>
        </div>
        <div class="row gelir_odendi" style="display: none;">
            <label class="col-sm-12 col-form-label"><%=LNG("Ödeme Tarihi")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-calendar"></i>
                    </span>
                    <input type="text" class="form-control takvimyap required" required name="odeme_tarih" id="odeme_tarih" />
                </div>
            </div>
        </div>
        <div class="row">
            <label class="col-sm-12 col-form-label"><%=LNG("Açıklama")%></label>
            <div class="col-sm-12">
                <div class="form-group">
                    <textarea id="odeme_aciklama" name="odeme_aciklama" class="required form-control" style="width: 93%; padding-left: 5px; padding-top: 6px;" required></textarea>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            autosize($("#odeme_aciklama"));
            $('.paraonly:not(.yapilan)').addClass("yapilan").maskMoney({ thousands: '.', decimal: ',', allowZero: true, suffix: '' });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#gelir_durum, #odeme_pb").select2({
                dropdownParent: $("#modal_div")
            });
        });
    </script>
    <div class="modal-footer">
        <input type="button" onclick="proje_gelir_kaydet(this, '<%=proje_id %>');" class="btn btn-primary btn-sm" value="<%=LNG("Kaydet")%>" />
    </div>
</form>
<%
    elseif trn(request("islem"))="proje_gelir_listesi" then

        proje_id = trn(request("proje_id"))
        FirmaID = Request.Cookies("kullanici")("firma_id")

        if trn(request("islem2"))="ekle" then

            gelir_adi = trn(request("gelir_adi"))
            ongorulen_id = trn(request("ongorulen_id"))
            odeme_tutar = trn(request("odeme_tutar"))
            odeme_pb = trn(request("odeme_pb"))
            tarih = trn(request("tarih"))
            odeme_aciklama = trn(request("odeme_aciklama"))
            gelir_durum = trn(request("durum"))
            
            durum = "true"
            cop = "false"
            ekleyen_ip = Request.ServerVariables("Remote_Addr")
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleme_tarihi = date
            ekleme_saati = time


            odeme_tutar = NoktalamaDegis(odeme_tutar)

            if gelir_durum = "ongorulen" then
                SQL="insert into ahtapot_proje_gelir_listesi(proje_id, gelir_adi, gelir_durum, odeme_tutar, odeme_pb, tarih, odeme_aciklama, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', '"& gelir_adi &"', '"& gelir_durum &"', '"& odeme_tutar &"', '"& odeme_pb &"', '"& tarih &"', '"& odeme_aciklama &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', Convert(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
            elseif gelir_durum = "gerceklesen" then
                SQL="insert into ahtapot_proje_gelir_listesi(proje_id, gelir_adi, ongorulen_id, gelir_durum, odeme_tutar, odeme_pb, tarih, odeme_aciklama, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& proje_id &"', '"& gelir_adi &"', '"& ongorulen_id &"', '"& gelir_durum &"', '"& odeme_tutar &"', '"& odeme_pb &"', '"& tarih &"', '"& odeme_aciklama &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', Convert(date, '"& ekleme_tarihi &"', 103), '"& ekleme_saati &"')"
            end if
            set ekle = baglanti.execute(SQL)

            SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& proje_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)


        elseif trn(request("islem2"))="sil" then

            kayit_id = trn(request("kayit_id"))

            SQL="update ahtapot_proje_gelir_listesi set cop = 'true' where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)

            SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& proje_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)


        elseif trn(request("islem2"))="guncelle" then

            kayit_id = trn(request("kayit_id"))
            ongorulen_id = trn(request("ongorulen_id"))
            tarih = trn(request("tarih"))
            durum = trn(request("durum"))

            gelir_adi = trn(request("gelir_adi"))
            gelir_durum = trn(request("gelir_durum"))
            odeme_tutar = trn(request("odeme_tutar"))
            odeme_pb = trn(request("odeme_pb"))
            planlanan_tarih = trn(request("planlanan_tarih"))
            odeme_tarih = trn(request("odeme_tarih"))
            odeme_aciklama = trn(request("odeme_aciklama"))

            odeme_tutar = NoktalamaDegis(odeme_tutar)
            
            if durum = "ongorulen" then
                SQL="update ahtapot_proje_gelir_listesi set gelir_adi = '"& gelir_adi &"', tarih = '"& tarih &"', gelir_durum = '"& durum &"', odeme_tutar = '"& odeme_tutar &"', odeme_pb = '"& odeme_pb &"', odeme_aciklama = '"& odeme_aciklama &"' where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            elseif durum = "gerceklesen" then
    response.Write("gerceklesen")
                SQL="update ahtapot_proje_gelir_listesi set gelir_adi = '"& gelir_adi &"', ongorulen_id = '"& ongorulen_id &"', tarih = '"& tarih &"', gelir_durum = '"& durum &"', odeme_tutar = '"& odeme_tutar &"', odeme_pb = '"& odeme_pb &"', odeme_aciklama = '"& odeme_aciklama &"' where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
            end if
            set guncelle = baglanti.execute(SQL)

            SQL="update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' where id = '"& proje_id &"' and firma_id = '"& FirmaID &"'"
            set guncelle = baglanti.execute(SQL)

        end if
%>
<div class="row">
    <div class="col-md-6">
        <div class="col-md-12 p-0 mt-2 mb-2 text-right">
            <h6 class="d-inline-block float-left"><i class="fa fa-arrow-circle-right mr-2"></i>Öngörülen Gelir</h6>
            <button type="button" class="btn btn-success btn-mini" onclick="ProjeGelirOngorulenEkle('<%=proje_id %>', 'ongorulen');">Öngörülen Ekle</button>
        </div>
        <div class="dt-responsive table-responsive">
            <table class="table table-bordered datatableyap text-nowrap w-100 mb-0">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Gelir Adı</th>
                        <th>Öngörülen Tutar</th>
                        <th>İşlem</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        SQL = "select * from ahtapot_proje_gelir_listesi where proje_id = '"& proje_id &"' and firma_id = '"& FirmaID &"' and durum = 'true' and cop = 'false' and gelir_durum = 'ongorulen' order by planlanan_tarih asc"
                        set gelir = baglanti.execute(SQL)
                        
                        i = 0
                        totalTL = 0
                        totalUSD = 0
                        totalEUR = 0
                        if gelir.eof then
                    %>
                    <tr>
                        <td colspan="6" class="text-center">Kayıt Bulunamadı... !</td>
                    </tr>
                    <% 
                        end if
                        do while not gelir.eof
                        i = i + 1
                        if gelir("odeme_pb") = "TL" then
                            totalTL = totalTL + cdbl(gelir("odeme_tutar"))
                        elseif gelir("odeme_pb") = "USD" then
                            totalUSD = totalUSD + cdbl(gelir("odeme_tutar"))
                        elseif gelir("odeme_pb") = "EUR" then
                            totalEUR = totalEUR + cdbl(gelir("odeme_tutar"))
                        end if
                    %>
                    <tr>
                        <td><%=i %></td>
                        <td><%=gelir("gelir_adi") %></td>
                        <td>
                            <label class="label label-primary mb-1 f-13 w-auto"><%=gelir("odeme_tutar") %>&nbsp;<%=gelir("odeme_pb") %></label>
                        </td>
                        <td>
                            <div class="btn-group">
                                <button class="btn btn-secondary btn-mini dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-cogs"></i>
                                </button>
                                <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; transform: translate3d(0px, 26px, 0px); top: 0px; left: 0px; will-change: transform;">
                                    <a class="dropdown-item cursor-pointer" onclick="ProjeGerceklesenGelirKaydiDuzenle('<%=proje_id %>', '<%=gelir("id") %>', 'ongorulen');">Düzenle</a>
                                    <a class="dropdown-item cursor-pointer" onclick="proje_gelir_kaydi_sil('<%=proje_id %>', '<%=gelir("id") %>', 'ongorulen');">Sil</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <%
                        gelir.movenext
                        loop
                    %>
                </tbody>
                <tfoot>
                    <tr>
                        <th colspan="2" class="text-right">
                            <h6>Toplam Tutar : </h6>
                        </th>
                        <th colspan="1">
                            <label class="label label-primary mb-1 f-13 w-auto"><%=totalTL %> ₺</label>
                            <label class="label label-primary mb-1 f-13 w-auto"><%=totalUSD %> $</label>
                            <label class="label label-primary mb-1 f-13 w-auto"><%=totalEUR %> €</label>
                        </th>
                        <th></th>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
    <div class="col-md-6">
        <div class="col-md-12 p-0 mt-2 mb-2 text-right">
            <h6 class="d-inline-block float-left"><i class="fa fa-arrow-circle-right mr-2"></i>Gerçekleşen Gelir</h6>
            <button type="button" class="btn btn-success btn-mini" onclick="ProjeGelirGerceklesenEkle('<%=proje_id %>', 'gerceklesen')">Gerçekleşen Ekle</button>
        </div>
        <div class="dt-responsive table-responsive">
            <table class="table table-bordered datatableyap text-nowrap w-100 mb-0">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Öngörülen Gelir</th>
                        <th>Gelir Adı</th>
                        <th>Öngörülen Tutar</th>
                        <th>Gerçekleşen Tutar</th>
                        <th>İşlem</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        SQL = "select ISNULL((select gelir_adi from ahtapot_proje_gelir_listesi where durum = 'true' and cop = 'false' and id = gl.ongorulen_id), '-') as ongorulen_adi, ISNULL((select odeme_tutar from ahtapot_proje_gelir_listesi where durum = 'true' and cop = 'false' and id = gl.ongorulen_id), 0.00) as ongorulen_tutar, ISNULL((select odeme_pb from ahtapot_proje_gelir_listesi where durum = 'true' and cop = 'false' and id = gl.ongorulen_id), 'TL') as ongorulen_pb, * from ahtapot_proje_gelir_listesi gl where gl.durum = 'true' and gl.cop = 'false' and gl.gelir_durum = 'gerceklesen' and gl.proje_id = '"& proje_id  &"' and gl.firma_id = '"& FirmaID &"'"
                        set gelir = baglanti.execute(SQL)
                        
                        i = 0
                        totalTL = 0
                        totalUSD = 0
                        totalEUR = 0

                        OGtotalTL = 0
                        OGtotalUSD = 0
                        OGtotalEUR = 0
                        if gelir.eof then
                    %>
                    <tr>
                        <td colspan="6" class="text-center">Kayıt Bulunamadı... !</td>
                    </tr>
                    <% 
                        end if
                        do while not gelir.eof
                        i = i + 1

                        if gelir("odeme_pb") = "TL" then
                            totalTL = totalTL + cdbl(gelir("odeme_tutar"))
                        elseif gelir("odeme_pb") = "USD" then
                            totalUSD = totalUSD + cdbl(gelir("odeme_tutar"))
                        elseif gelir("odeme_pb") = "EUR" then
                            totalEUR = totalEUR + cdbl(gelir("odeme_tutar"))
                        end if

                        if gelir("ongorulen_pb") = "TL" then
                            OGtotalTL = OGtotalTL + cdbl(gelir("ongorulen_tutar"))
                        elseif gelir("ongorulen_pb") = "USD" then
                            OGtotalUSD = OGtotalUSD + cdbl(gelir("ongorulen_tutar"))
                        elseif gelir("ongorulen_pb") = "EUR" then
                            OGtotalEUR = OGtotalEUR + cdbl(gelir("ongorulen_tutar"))
                        end if
                    %>
                    <tr>
                        <td><%=i %></td>
                        <td><%=gelir("ongorulen_adi") %></td>
                        <td><%=gelir("gelir_adi") %></td>
                        <td><label class="mb-1 f-13 w-auto"><%=gelir("ongorulen_tutar") %>&nbsp;<%=gelir("ongorulen_pb") %></label></td>
                        <td><label class="mb-1 f-13 w-auto text-danger font-weight-bold"><%=gelir("odeme_tutar") %>&nbsp;<%=gelir("odeme_pb") %></label></td>
                        <td>
                            <div class="btn-group">
                                <button class="btn btn-secondary btn-mini dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <i class="fa fa-cogs"></i>
                                </button>
                                <div class="dropdown-menu" x-placement="bottom-start" style="position: absolute; transform: translate3d(0px, 26px, 0px); top: 0px; left: 0px; will-change: transform;">
                                    <a class="dropdown-item cursor-pointer" onclick="ProjeOngorulenGelirKaydiDuzenle('<%=proje_id %>', '<%=gelir("id") %>', '<%=gelir("ongorulen_id") %>', 'gerceklesen');">Düzenle</a>
                                    <a class="dropdown-item cursor-pointer" onclick="proje_gelir_kaydi_sil('<%=proje_id %>', '<%=gelir("id") %>', 'gerceklesen');">Sil</a>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <%
                        gelir.movenext
                        loop
                    %>
                </tbody>
                <tfoot>
                    <tr>
                        <th colspan="3" class="text-right">
                            <h6>Toplam Tutar : </h6>
                        </th>
                        <th colspan="1">
                            <label class="label label-primary mb-1 f-13 w-auto"><%=OGtotalTL %> ₺</label>
                            <label class="label label-primary mb-1 f-13 w-auto"><%=OGtotalUSD %> $</label>
                            <label class="label label-primary mb-1 f-13 w-auto"><%=OGtotalEUR %> €</label>
                        </th>
                        <th colspan="1">
                            <label class="label label-primary mb-1 f-13 w-auto"><%=totalTL %> ₺</label>
                            <label class="label label-primary mb-1 f-13 w-auto"><%=totalUSD %> $</label>
                            <label class="label label-primary mb-1 f-13 w-auto"><%=totalEUR %> €</label>
                        </th>
                        <th></th>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $(".dt-toolbar").addClass("pr-1 pt-1 pb-1 border border-bottom-0");
        $(".dt-toolbar-footer").addClass("border-top-0");
    });
</script>
<%

    elseif trn(request("islem"))="proje_gelir_kaydi_duzenle" then

        proje_id = trn(request("proje_id"))
        kayit_id = trn(request("kayit_id"))
        ongorulen_id = trn(request("ongorulen_id"))
        yer = trn(request("yer"))
        FirmaID = Request.Cookies("kullanici")("firma_id")

        SQL="select * from ahtapot_proje_gelir_listesi where id = '"& kayit_id &"' and firma_id = '"& FirmaID &"'"
        set gelir = baglanti.execute(SQL)

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
    <%if yer = "ongorulen" then %>
        <%=LNG("Öngörülen Gelir Düzenle")%>
    <%elseif yer = "gerceklesen" then %>
        <%=LNG("Gerçekleşen Gelir Düzenle")%>
    <%end if %>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_gelir_form" class="smart-form validateform" novalidate="novalidate">
    <div class="modal-body">
        <div class="col-md-12 p-0">
            <label class="col-form-label"><%=LNG("Gelir Adı")%></label>
            <div class="form-group">
                <select class="form-control form-control-sm select2" id="ongorulen_id">
                    <%
                        SQL = "select * from ahtapot_proje_gelir_listesi where durum = 'true' and cop = 'false' and gelir_durum = 'ongorulen' and proje_id = '"& proje_id &"' and firma_id = '"& FirmaID &"'"
                        set ongorulen = baglanti.execute(SQL)

                        if not ongorulen.eof then
                        do while not ongorulen.eof
                    %>
                        <option value="<%=ongorulen("id") %>" <%if ongorulen("id") = ongorulen_id then %> selected="selected" <%end if %>><%=ongorulen("gelir_adi") %></option>
                    <%
                        ongorulen.movenext
                        loop
                        end if
                    %>
                </select>
                <!--<input type="text" class="form-control required" required name="gelir_adi" id="gelir_adi" value="<%=gelir("gelir_adi") %>" />-->
            </div>
        </div>
        <div class="row">
            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Tutar")%></label>
            <div class="col-sm-9 col-lg-9">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-money"></i>
                    </span>
                    <input type="text" class="validate[required] paraonly form-control" id="odeme_tutar" name="odeme_tutar" required value="<%=formatnumber(gelir("odeme_tutar"),2) %>" />
                </div>
            </div>
            <div class="col-sm-3 col-lg-3">
                <select id="odeme_pb" name="odeme_pb" class="select2">
                    <option <% if trim(gelir("odeme_pb"))="TL" then %> selected="selected" <% end if %> value="TL">TL</option>
                    <option <% if trim(gelir("odeme_pb"))="USD" then %> selected="selected" <% end if %> value="USD">USD</option>
                    <option <% if trim(gelir("odeme_pb"))="EUR" then %> selected="selected" <% end if %> value="EUR">EUR</option>
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
        <div class="row">
            <label class="col-sm-12 col-form-label"><%=LNG("Açıklama")%></label>
            <div class="col-sm-12">
                <div class="form-group">
                    <textarea id="odeme_aciklama" name="odeme_aciklama" class="required form-control" style="width: 93%; padding-left: 5px; padding-top: 6px;" required><%=gelir("odeme_aciklama") %></textarea>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            autosize($("#odeme_aciklama"));
            $('.paraonly:not(.yapilan)').addClass("yapilan").maskMoney({ thousands: '.', decimal: ',', allowZero: true, suffix: '' });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#gelir_durum, #odeme_pb").select2({
                dropdownParent: $("#modal_div")
            });
        });
    </script>
    <div class="modal-footer">
        <input type="button" onclick="proje_gelir_guncelle(this, '<%=proje_id %>', '<%=kayit_id %>');" class="btn btn-primary btn-sm" value="<%=LNG("Güncelle")%>" />
    </div>
</form>
<% elseif trn(request("islem"))="destek_listesi_getir" then %>
<div class="dt-responsive table-responsive">
    <table id="new-cons2" class="table table-striped table-bordered table-hover" width="100%">
        <thead>
            <tr>
                <th style="width: 30px;">ID</th>
                <th><%=LNG("Konu")%></th>
                <th><%=LNG("Departman")%></th>
                <th style="width: 120px;"><%=LNG("Durum")%></th>
                <th style="width: 120px;"><%=LNG("Ekleme Tarihi")%></th>
            </tr>
        </thead>
        <tbody>
            <%
                            SQL="SELECT id, bildirim_tipi, baslik, beta_aciklama, ekleme_tarihi, ekleme_saati FROM dbo.ahtapot_beta_bildirimleri WHERE ekleyen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' AND durum = 'true' AND cop = 'false' and firma_id = '"& FirmaID &"'"
                            set bildirim = baglanti.execute(SQL)
                            if bildirim.eof then
            %>
            <tr>
                <td colspan="5" style="text-align: center;"><%=LNG("Kayıt Yok")%></td>
            </tr>
            <%
                            end if
                            do while not bildirim.eof
            %>
            <tr>
                <td><%=bildirim("id") %></td>
                <td><%=bildirim("baslik") %></td>
                <td><%=bildirim("bildirim_tipi") %></td>
                <td style="width: 120px;"><span class="label label-primary" style="font-size: 12px;"><%=LNG("AÇIK")%></span></td>
                <td><%=cdate(bildirim("ekleme_tarihi")) %>&nbsp;<%=left(bildirim("ekleme_saati"),5) %></td>
            </tr>
            <%
                            bildirim.movenext
                            loop
            %>
        </tbody>
    </table>
</div>
<% 

    elseif trn(request("islem"))="temaal" then
        
        SQL="select isnull(firma_tema,1) as firma_tema from ucgem_firma_listesi where id = '"& Request.Cookies("kullanici")("firma_id") &"'"
        set cek = baglanti.execute(SQL)
%>
<script>
    $(function (){
        sistem_tema_degistir('<%=cek("firma_tema") %>');
    });
</script>
<%

    elseif trn(request("islem"))="rapor_is_yuku_gosterim_proje_sectim" then

            proje_id = trn(request("proje_id"))
            dongu_baslangic = cdate(trn(request("baslangic")))
            dongu_bitis = cdate(trn(request("bitis")))
            gosterim_tipi = trn(request("gosterim_tipi"))
            donem = trn(request("donem"))


        
%>
<style>
    .taskin {
        background-color: #fb8f8f !important;
    }
</style>
<div>
    <div id="tablediv">
        <table id="tablegosterge" style="border-color: #e8e8e8; font-family: Tahoma; width: 100%;">
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
                    <td class="ust_td2 headcol" style="width: 150px; background-color: #4d7193; color: white!important;">TOPLAM</td>
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
            </tbody>
        </table>
    </div>

    <div id="tablediv2" style="display: none;"></div>
</div>
<% 
    elseif trn(request("islem"))="rapor_pdf_indir" then

        Set Pdf = Server.CreateObject("Persits.Pdf")
        Set Doc = Pdf.CreateDocument

        if trn(request("islem2"))="satinalma_formu" then

            satinalma_id = trn(request("satinalma_id"))

            Doc.ImportFromUrl site_url & "/satinalma_formu/?jsid=4559&satinalma_id=" & satinalma_id, "pageWidth=900,DrawBackground=true,pageHeight=1200, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)

            sName = server.MapPath(dosya_yolu)

        if trn(request("islem3"))="yazdir" then

%>
<script>
        $(function (){
            $(".btnPrint").printPage();
        });
</script>
<center>
<img src="/img/Gnome-Emblem-Default-48.png" /><br /><br />
    <h4><%=LNG("Belgeniz Hazır.")%></h4><br /><br /><a class="btn btn-success btn-rnd btnPrint" href="<%=dosya_yolu %>"><i class="fa fa-print"></i> <%=LNG("Yazdır")%></a><br /><br />
    </center>


<%
    else
        ParcaParcaDosyaIndir sName, "Rapor.pdf"
    end if
         elseif trn(request("islem2"))="teklif_formu" then

                satinalma_id = trn(request("satinalma_id"))

                Doc.ImportFromUrl site_url & "/teklif_formu/?jsid=4559&satinalma_id=" & satinalma_id, "pageWidth=900,DrawBackground=true,pageHeight=1200, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
                dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
                Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)

                sName = server.MapPath(dosya_yolu)

             if trn(request("islem3"))="yazdir" then
%>
<script>
        $(function (){
            $(".btnPrint").printPage();
        });
</script>
<center>
<img src="/img/Gnome-Emblem-Default-48.png" /><br /><br />
    <h4><%=LNG("Belgeniz Hazır.")%></h4><br /><br /><a class="btn btn-success btn-rnd btnPrint" href="<%=dosya_yolu %>"><i class="fa fa-print"></i> <%=LNG("Yazdır")%></a><br /><br />
    </center>
<%
            else
                ParcaParcaDosyaIndir sName, "Rapor.pdf"
            end if

             elseif trn(request("islem2"))="proje_maliyet_formu" then

                proje_id = trn(request("proje_id"))

                Doc.ImportFromUrl site_url & "/proje_maliyet_formu/?jsid=4559&proje_id=" & proje_id, "pageWidth=900,DrawBackground=true,pageHeight=1200, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=28"
                
                dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
                Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)

                sName = server.MapPath(dosya_yolu)

             if trn(request("islem3"))="yazdir" then
%>
<script>
        $(function (){
            $(".btnPrint").printPage();
        });
</script>
<center>
<img src="/img/Gnome-Emblem-Default-48.png" /><br /><br />
    <h4><%=LNG("Belgeniz Hazır.")%></h4><br /><br /><a class="btn btn-success btn-rnd btnPrint" href="<%=dosya_yolu %>"><i class="fa fa-print"></i> <%=LNG("Yazdır")%></a><br /><br />
    </center>
<%
            else
                ParcaParcaDosyaIndir sName, "Rapor.pdf"
            end if


            elseif trn(request("islem2"))="teknik_servis_formu" then

                    personel_Id = trn(request("personel_id"))
                    izin_id = trn(request("izin_id"))

                    firma_id = Request.Cookies("kullanici")("firma_id")
                    kullanici_id = Request.Cookies("kullanici")("kullanici_id")

                    Doc.ImportFromUrl site_url & "/teknik_servis_formu/?jsid=4559&personel_id=" & personel_id & "&izin_id=" & izin_id & "&firma_id=" & firma_id & "&kullanici_id=" & kullanici_id , "pageWidth=900,DrawBackground=true,pageHeight=1200, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
                
                    dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
                    Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)

                    sName = server.MapPath(dosya_yolu)

             if trn(request("islem3"))="yazdir" then
%>
<script>
        $(function (){
            $(".btnPrint").printPage();
        });
</script>
<center>
<img src="/img/Gnome-Emblem-Default-48.png" /><br /><br />
    <h4><%=LNG("Belgeniz Hazır.")%></h4><br /><br /><a class="btn btn-success btn-rnd btnPrint" href="<%=dosya_yolu %>"><i class="fa fa-print"></i> <%=LNG("Yazdır")%></a><br /><br />
    </center>
<%
            else
                ParcaParcaDosyaIndir sName, "Rapor.pdf"
            end if
                
            elseif trn(request("islem2"))="mesai_bildirim_formu" then

                personel_id = trn(request("personel_id"))
                izin_id = trn(request("izin_id"))

                firma_id = Request.Cookies("kullanici")("firma_id")
                kullanici_id = Request.Cookies("kullanici")("kullanici_id")

                Doc.ImportFromUrl site_url & "/mesai_bildirim_formu/?jsid=4559&personel_id=" & personel_id & "&izin_id=" & izin_id & "&firma_id=" & firma_id & "&kullanici_id=" & kullanici_id, "pageWidth=900,DrawBackground=true,pageHeight=1200, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"

                dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
                Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)

                sName = server.MapPath(dosya_yolu)

         if trn(request("islem3"))="yazdir" then
%>
<script>
        $(function (){
            $(".btnPrint").printPage();
        });
</script>
<center>
<img src="/img/Gnome-Emblem-Default-48.png" /><br /><br />
    <h4><%=LNG("Belgeniz Hazır.")%></h4><br /><br /><a class="btn btn-success btn-rnd btnPrint" href="<%=dosya_yolu %>"><i class="fa fa-print"></i> <%=LNG("Yazdır")%></a><br /><br />
    </center>
<%
            else
                ParcaParcaDosyaIndir sName, "Rapor.pdf"
            end if



        elseif trn(request("islem2"))="izin_talep_formu" then

            personel_id = trn(request("personel_id"))
            izin_id = trn(request("izin_id"))

            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")

            
            Doc.ImportFromUrl site_url & "/izin_talep_formu/?jsid=4559&personel_id=" & personel_id & "&izin_id=" & izin_id & "&firma_id=" & firma_id & "&kullanici_id=" & kullanici_id, "pageWidth=900,DrawBackground=true,pageHeight=1200, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"

            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)

            
            
            sName = server.MapPath(dosya_yolu)

            

        if trn(request("islem3"))="yazdir" then

%>
<script>
        $(function (){
            $(".btnPrint").printPage();
        });
</script>
<center>
<img src="/img/Gnome-Emblem-Default-48.png" /><br /><br />
    <h4><%=LNG("Belgeniz Hazır.")%></h4><br /><br /><a class="btn btn-success btn-rnd btnPrint" href="<%=dosya_yolu %>"><i class="fa fa-print"></i> <%=LNG("Yazdır")%></a><br /><br />
    </center>
<%
            else
                ParcaParcaDosyaIndir sName, "Rapor.pdf"
            end if



        elseif trn(request("islem2"))="personel_is_yuku" then

            gosterim_tipi = trn(request("gosterim_tipi"))
            proje_id = trn(request("proje_id"))
            baslangic = trn(request("baslangic"))
            bitis = trn(request("bitis"))

            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")

            Doc.ImportFromUrl site_url & "/form_personel_is_yuku/?jsid=4559&tip=" & gosterim_tipi & "&pid=" & proje_id & "&baslangic=" & baslangic & "&bitis=" & bitis & "&fid=" & firma_id & "&kid=" & kullanici_id, "pageWidth=2250,DrawBackground=true,pageHeight=1640, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

            if trn(request("islem3"))="yazdir" then

%>
<script>
        $(function (){
            $(".btnPrint").printPage();
        });
</script>
<center>
<img src="/img/Gnome-Emblem-Default-48.png" /><br /><br />
    <h4><%=LNG("Belgeniz Hazır.")%></h4><br /><br /><a class="btn btn-success btn-rnd btnPrint" href="<%=dosya_yolu %>"><i class="fa fa-print"></i> <%=LNG("Yazdır")%></a><br /><br />
    </center>
<%
            else
                ParcaParcaDosyaIndir sName, "Rapor.pdf"
            end if


        elseif trn(request("islem2"))="personel_is_yuku_verimlilik" then

            gosterim_tipi = trn(request("gosterim_tipi"))
            proje_id = trn(request("proje_id"))
            baslangic = trn(request("baslangic"))
            bitis = trn(request("bitis"))

            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")

            Doc.ImportFromUrl site_url & "/form_personel_is_yuku_verimlilik/?jsid=4559&tip=" & gosterim_tipi & "&pid=" & proje_id & "&baslangic=" & baslangic & "&bitis=" & bitis & "&fid=" & firma_id & "&kid=" & kullanici_id, "pageWidth=2250,DrawBackground=true,pageHeight=1640, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

            if trn(request("islem3"))="yazdir" then
%>
<script>
        $(function (){
            $(".btnPrint").printPage();
        });
</script>
<center>
<img src="/img/Gnome-Emblem-Default-48.png" /><br /><br />
    <h4><%=LNG("Belgeniz Hazır.")%></h4><br /><br /><a class="btn btn-success btn-rnd btnPrint" href="<%=dosya_yolu %>"><i class="fa fa-print"></i> <%=LNG("Yazdır")%></a><br /><br />
    </center>
<%
            else
                ParcaParcaDosyaIndir sName, "Rapor.pdf"
            end if

        elseif trn(request("islem2"))="departmanlardaki_is_hacmi" then

            Doc.ImportFromUrl site_url & "/form_departmanlardaki_is_hacmi/?jsid=4559&firma_id=" & Request.Cookies("kullanici")("firma_id"), "pageWidth=900,DrawBackground=true,pageHeight=1200, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

            if trn(request("islem3"))="yazdir" then
%>
<script>
                    $(function (){
                        $(".btnPrint").printPage();
                    });
</script>
<center>
            <img src="/img/Gnome-Emblem-Default-48.png" /><br /><br />
                <h4><%=LNG("Belgeniz Hazır.")%></h4><br /><br /><a class="btn btn-success btn-rnd btnPrint" href="<%=dosya_yolu %>"><i class="fa fa-print"></i> <%=LNG("Yazdır")%></a><br /><br />
                </center>
<%
            else
                ParcaParcaDosyaIndir sName, "Rapor.pdf"
            end if

        elseif trn(request("islem2"))="personel_performans_raporu" then

            rapor_personel_id = trn(request("rapor_personel_id"))
            baslangic_tarihi = trn(request("baslangic_tarihi"))
            bitis_tarihi = trn(request("bitis_tarihi"))
            etiketler = trn(request("etiketler"))
            yeni_is_yuku_proje_id = trn(request("yeni_is_yuku_proje_id"))

            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")

            Doc.ImportFromUrl site_url & "/form_personel_performans_raporu/?jsid=4559&rapor_personel_id=" & rapor_personel_id & "&baslangic_tarihi=" & baslangic_tarihi & "&bitis_tarihi=" & bitis_tarihi & "&bitis=" & bitis & "&fid=" & firma_id & "&kid=" & kullanici_id & "&etiketler=" & etiketler & "&yeni_is_yuku_proje_id=" & yeni_is_yuku_proje_id, "pageWidth=900,DrawBackground=true,pageHeight=1200, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

            if trn(request("islem3"))="yazdir" then
%>
<script>
        $(function (){
            $(".btnPrint").printPage();
        });
</script>
<center>
<img src="/img/Gnome-Emblem-Default-48.png" /><br /><br />
    <h4><%=LNG("Belgeniz Hazır.")%></h4><br /><br /><a class="btn btn-success btn-rnd btnPrint" href="<%=dosya_yolu %>"><i class="fa fa-print"></i> <%=LNG("Yazdır")%></a><br /><br />
    </center>
<%
            else
                ParcaParcaDosyaIndir sName, "Rapor.pdf"
            end if

        elseif trn(request("islem2"))="proje_adam_saat_raporu" then

            rapor_personel_id = trn(request("rapor_personel_id"))
            etiketler = trn(request("etiketler"))
            yeni_is_yuku_proje_id = trn(request("yeni_is_yuku_proje_id"))
            baslangic = trn(request("baslangic"))
            bitis = trn(request("bitis"))

            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")

            Doc.ImportFromUrl site_url & "/form_proje_adam_saat_raporu/?jsid=4559&rapor_personel_id=" & rapor_personel_id & "&etiketler=" & etiketler & "&yeni_is_yuku_proje_id=" & yeni_is_yuku_proje_id & "&baslangic=" & baslangic & "&fid=" & firma_id & "&kid=" & kullanici_id & "&bitis=" & bitis, "pageWidth=2250,DrawBackground=true,pageHeight=1640, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

            if trn(request("islem3"))="yazdir" then
        
%>
<script>
        $(function (){
            $(".btnPrint").printPage();
        });
</script>
<center>
<img src="/img/Gnome-Emblem-Default-48.png" /><br /><br />
    <h4><%=LNG("Belgeniz Hazır.")%></h4><br /><br /><a class="btn btn-success btn-rnd btnPrint" href="<%=dosya_yolu %>"><i class="fa fa-print"></i> <%=LNG("Yazdır")%></a><br /><br />
    </center>
<%
            else
                ParcaParcaDosyaIndir sName, "Rapor.pdf"
            end if

        elseif trn(request("islem2"))="personel_giris_cikis_raporu" then

            rapor_personel_id = trn(request("personelID"))
    'response.Write("personel Id: " & rapor_personel_id & " ")
            baslangic = trn(request("tarihBaslangic"))
    'response.Write("baslangic: " & baslangic & " ")
            bitis = trn(request("tarihBitis"))
    'response.Write("bitis: " & bitis & " ")

            Doc.ImportFromUrl site_url & "/teknik_servis_formu2/?jsid=4559&rapor_personel_id=" & rapor_personel_id & "&baslangic=" & baslangic & "&bitis=" & bitis, "pageWidth=3000,DrawBackground=true,pageHeight=1640, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            sName = server.MapPath(dosya_yolu)
            if trn(request("islem3"))="yazdir" then
        
%>
<script>
        $(function (){
            $(".btnPrint").printPage();
        });
</script>
<center>
<img src="/img/Gnome-Emblem-Default-48.png" /><br /><br />
    <h4><%=LNG("Belgeniz Hazır.")%></h4><br /><br /><a class="btn btn-success btn-rnd btnPrint" href="<%=dosya_yolu %>"><i class="fa fa-print"></i> <%=LNG("Yazdır")%></a><br /><br />
    </center>
<%
            else
                ParcaParcaDosyaIndir sName, "Rapor.pdf"
            end if

        elseif trn(request("islem2"))="departman_adam_saat_raporu" then

            etiketler = trn(request("etiketler"))
            rapor_personel_id = trn(request("rapor_personel_id"))
            yeni_is_yuku_proje_id = trn(request("yeni_is_yuku_proje_id"))
            baslangic = trn(request("baslangic"))
            bitis = trn(request("bitis"))

            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")

            Doc.ImportFromUrl site_url & "/form_departman_adam_saat_raporu/?jsid=4559&rapor_personel_id=" & rapor_personel_id & "&etiketler=" & etiketler & "&yeni_is_yuku_proje_id=" & yeni_is_yuku_proje_id & "&baslangic=" & baslangic & "&fid=" & firma_id & "&kid=" & kullanici_id & "&bitis=" & bitis, "pageWidth=2250,DrawBackground=true,pageHeight=1640, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

            if trn(request("islem3"))="yazdir" then
        
%>
<script>
        $(function (){
            $(".btnPrint").printPage();
        });
</script>
<center>
<img src="/img/Gnome-Emblem-Default-48.png" /><br /><br />
    <h4><%=LNG("Belgeniz Hazır.")%></h4><br /><br /><a class="btn btn-success btn-rnd btnPrint" href="<%=dosya_yolu %>"><i class="fa fa-print"></i> <%=LNG("Yazdır")%></a><br /><br />
    </center>
<%
            else
                ParcaParcaDosyaIndir sName, "Rapor.pdf"
            end if

        elseif trn(request("islem2"))="proje_maliyet_raporu" then

            yeni_is_yuku_proje_id = trn(request("yeni_is_yuku_proje_id"))
        
            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")


            Doc.ImportFromUrl site_url & "/form_proje_maliyet_raporu/?jsid=4559&yeni_is_yuku_proje_id=" & yeni_is_yuku_proje_id & "&fid=" & firma_id & "&kid=" & kullanici_id, "pageWidth=900,DrawBackground=true,pageHeight=1200, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

            if trn(request("islem3"))="yazdir" then

        
        
%>
<script>
        $(function (){
            $(".btnPrint").printPage();
        });
</script>
<center>
<img src="/img/Gnome-Emblem-Default-48.png" /><br /><br />
    <h4><%=LNG("Belgeniz Hazır.")%></h4><br /><br /><a class="btn btn-success btn-rnd btnPrint" href="<%=dosya_yolu %>"><i class="fa fa-print"></i> <%=LNG("Yazdır")%></a><br /><br />
    </center>
<%
            else
                ParcaParcaDosyaIndir sName, "Rapor.pdf"
            end if

        elseif trn(request("islem2"))="personel_adam_saat_raporu" then

            personel_id = trn(request("rapor_personel_id"))
            baslangic = trn(request("baslangic"))
            bitis = trn(request("bitis"))
            is_yuku_gosterim_tipi = trn(request("is_yuku_gosterim_tipi"))
            etiketler = trn(request("etiketler"))
            yeni_is_yuku_proje_id = trn(request("yeni_is_yuku_proje_id"))
        
            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")


            Doc.ImportFromUrl site_url & "/form_personel_adam_saat_raporu/?jsid=4559&personel_id=" & personel_id & "&baslangic=" & baslangic & "&bitis=" & bitis & "&is_yuku_gosterim_tipi=" & is_yuku_gosterim_tipi & "&fid=" & firma_id & "&kid=" & kullanici_id & "&etiketler=" & etiketler & "&yeni_is_yuku_proje_id="&yeni_is_yuku_proje_id, "pageWidth=2250,DrawBackground=true,pageHeight=1640, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

            if trn(request("islem3"))="yazdir" then

        
        
%>
<script>
        $(function (){
            $(".btnPrint").printPage();
        });
</script>
<center>
<img src="/img/Gnome-Emblem-Default-48.png" /><br /><br />
    <h4><%=LNG("Belgeniz Hazır.")%></h4><br /><br /><a class="btn btn-success btn-rnd btnPrint" href="<%=dosya_yolu %>"><i class="fa fa-print"></i> <%=LNG("Yazdır")%></a><br /><br />
    </center>
<%
            else
                ParcaParcaDosyaIndir sName, "Rapor.pdf"
            end if

       elseif trn(request("islem2"))="tahsilatlar_raporu" then

        
            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")


            Doc.ImportFromUrl site_url & "/form_tahsilatlar_raporu/?jsid=4559&firma_id=" & firma_id & "&kullanici_id=" & kullanici_id, "pageWidth=900,DrawBackground=true,pageHeight=1200, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

            if trn(request("islem3"))="yazdir" then

        
        
%>
<script>
        $(function (){
            $(".btnPrint").printPage();
        });
</script>
<center>
<img src="/img/Gnome-Emblem-Default-48.png" /><br /><br />
    <h4><%=LNG("Belgeniz Hazır.")%></h4><br /><br /><a class="btn btn-success btn-rnd btnPrint" href="<%=dosya_yolu %>"><i class="fa fa-print"></i> <%=LNG("Yazdır")%></a><br /><br />
    </center>
<%
            else
                ParcaParcaDosyaIndir sName, "Rapor.pdf"
            end if

       elseif trn(request("islem2"))="odemeler_raporu" then

        
            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")


            Doc.ImportFromUrl site_url & "/form_odemeler_raporu/?jsid=4559&firma_id=" & firma_id & "&kullanici_id=" & kullanici_id, "pageWidth=900,DrawBackground=true,pageHeight=1200, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

            if trn(request("islem3"))="yazdir" then

        
        
%>
<script>
        $(function (){
            $(".btnPrint").printPage();
        });
</script>
<center>
<img src="/img/Gnome-Emblem-Default-48.png" /><br /><br />
    <h4><%=LNG("Belgeniz Hazır.")%></h4><br /><br /><a class="btn btn-success btn-rnd btnPrint" href="<%=dosya_yolu %>"><i class="fa fa-print"></i> <%=LNG("Yazdır")%></a><br /><br />
    </center>
<%
            else
                ParcaParcaDosyaIndir sName, "Rapor.pdf"
            end if



       elseif trn(request("islem2"))="nakit_akis_raporu" then

        
            baslangic_tarihi = trn(request("baslangic_tarihi"))
            bitis_tarihi = trn(request("bitis_tarihi"))

            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")


            Doc.ImportFromUrl site_url & "/form_nakit_akis_raporu/?jsid=4559&firma_id=" & firma_id & "&kullanici_id=" & kullanici_id & "&baslangic_tarihi=" & baslangic_tarihi & "&bitis_tarihi=" & bitis_tarihi, "pageWidth=1850,DrawBackground=true,pageHeight=1400, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

            if trn(request("islem3"))="yazdir" then

        
        
%>
<script>
        $(function (){
            $(".btnPrint").printPage();
        });
</script>
<center>
<img src="/img/Gnome-Emblem-Default-48.png" /><br /><br />
    <h4><%=LNG("Belgeniz Hazır.")%></h4><br /><br /><a class="btn btn-success btn-rnd btnPrint" href="<%=dosya_yolu %>"><i class="fa fa-print"></i> <%=LNG("Yazdır")%></a><br /><br />
    </center>
<%
            else
                ParcaParcaDosyaIndir sName, "Rapor.pdf"
            end if


       elseif trn(request("islem2"))="gantt_liste" then

        
            proje_id = trn(request("proje_id"))
            tip = trn(request("tip"))

            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")




            Doc.ImportFromUrl site_url & "/form_gantt_liste_gorunumu/?jsid=4559&firma_id=" & firma_id & "&kullanici_id=" & kullanici_id & "&tip=" & tip & "&proje_id=" & proje_id, "pageWidth=1400,DrawBackground=true,pageHeight=1850, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

            if trn(request("islem3"))="yazdir" then

        
        
%>
<script>
        $(function (){
            $(".btnPrint").printPage();
        });
</script>
<center>
<img src="/img/Gnome-Emblem-Default-48.png" /><br /><br />
    <h4><%=LNG("Belgeniz Hazır.")%></h4><br /><br /><a class="btn btn-success btn-rnd btnPrint" href="<%=dosya_yolu %>"><i class="fa fa-print"></i> <%=LNG("Yazdır")%></a><br /><br />
    </center>
<%
            else
                ParcaParcaDosyaIndir sName, "Rapor.pdf"
            end if


        end if

        set doc = nothing
        set pdf = nothing
        
        
    elseif trn(request("islem"))="pdf_yazdir" then
%>
<div class="modal-header">
    <%=LNG("Yazdır")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form autocomplete="off" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <label id="olusturuluyor" class="col-sm-12 col-form-label">
            <center style="font-weight: bold;"><%=LNG("Belgeniz Oluşturuluyor...")%></center>
        </label>
        <div id="olusturulan_belge_yeri" class="col-sm-12">
        </div>
    </div>
</form>
<%
    elseif trn(request("islem"))="pdf_gonder" then

%>
<div class="modal-header">
    <%=LNG("Belge Gönder")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form autocomplete="off" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <label id="olusturuluyor" class="col-sm-12 col-form-label">
            <center style="font-weight: bold;"><%=LNG("Belgeniz Oluşturuluyor...")%></center>
        </label>
        <div id="olusturulan_belge_yeri" class="col-sm-12"></div>
    </div>
</form>
<%

    elseif trn(request("islem"))="rapor_pdf_gonder" then

        Set Pdf = Server.CreateObject("Persits.Pdf")
        Set Doc = Pdf.CreateDocument

    
            SQL="select personel_eposta from ucgem_firma_kullanici_listesi where id = '"& Request.Cookies("kullanici")("kullanici_id") &"' and firma_id = '"& FirmaID &"'"
            set epostacek = baglanti.execute(SQL)

        if trn(request("islem2"))="satinalma_formu" then

            satinalma_id = trn(request("satinalma_id"))

            Doc.ImportFromUrl site_url & "/satinalma_formu/?jsid=4559&satinalma_id=" & satinalma_id, "pageWidth=900,DrawBackground=true,pageHeight=1200, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)

            sName = server.MapPath(dosya_yolu)

        elseif trn(request("islem2"))="proje_maliyet_formu" then

            proje_id = trn(request("proje_id"))

            Doc.ImportFromUrl site_url & "/proje_maliyet_formu/?jsid=4559&proje_id=" & proje_id, "pageWidth=900,DrawBackground=true,pageHeight=1200, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)

            sName = server.MapPath(dosya_yolu)

         elseif trn(request("islem2"))="mesai_bildirim_formu" then
            
                personel_id = trn(request("personel_id"))
                izin_id = trn(request("izin_id"))

                firma_id = Request.Cookies("kullanici")("firma_id")
                kullanici_id = Request.Cookies("kullanici")("kullanici_id")

                Doc.ImportFromUrl site_url & "/mesai_bildirim_formu/?jsid=4559&personel_id=" & personel_id & "&izin_id=" & izin_id & "&firma_id=" & firma_id & "&kullanici_id=" & kullanici_id, "pageWidth=900,DrawBackground=true,pageHeight=1200, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"

                dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
                Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)

                sName = server.MapPath(dosya_yolu)
          
         elseif trn(request("islem2"))="izin_talep_formu" then

            personel_id = trn(request("personel_id"))
            izin_id = trn(request("izin_id"))

            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")


            Doc.ImportFromUrl site_url & "/izin_talep_formu/?jsid=4559&personel_id=" & personel_id & "&izin_id=" & izin_id & "&firma_id=" & firma_id & "&kullanici_id=" & kullanici_id, "pageWidth=900,DrawBackground=true,pageHeight=1200, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)

            sName = server.MapPath(dosya_yolu)

    
        elseif trn(request("islem2"))="personel_is_yuku" then

            gosterim_tipi = trn(request("gosterim_tipi"))
            proje_id = trn(request("proje_id"))
            baslangic = trn(request("baslangic"))
            bitis = trn(request("bitis"))

            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")



            Doc.ImportFromUrl site_url & "/form_personel_is_yuku/?jsid=4559&tip=" & gosterim_tipi & "&pid=" & proje_id & "&baslangic=" & baslangic & "&bitis=" & bitis & "&fid=" & firma_id & "&kid=" & kullanici_id, "pageWidth=2250,DrawBackground=true,pageHeight=1640, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

        elseif trn(request("islem2"))="personel_is_yuku_verimlilik" then

            gosterim_tipi = trn(request("gosterim_tipi"))
            proje_id = trn(request("proje_id"))
            baslangic = trn(request("baslangic"))
            bitis = trn(request("bitis"))

            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")

            Doc.ImportFromUrl site_url & "/personel_is_yuku_verimlilik/?jsid=4559&tip=" & gosterim_tipi & "&pid=" & proje_id & "&baslangic=" & baslangic & "&bitis=" & bitis & "&fid=" & firma_id & "&kid=" & kullanici_id, "pageWidth=2250,DrawBackground=true,pageHeight=1640, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

        elseif trn(request("islem2"))="departmanlardaki_is_hacmi" then

            Doc.ImportFromUrl site_url & "/form_departmanlardaki_is_hacmi/?jsid=4559&firma_id=" & Request.Cookies("kullanici")("firma_id"), "pageWidth=1240,DrawBackground=true,pageHeight=1754, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

        elseif trn(request("islem2"))="personel_performans_raporu" then

            rapor_personel_id = trn(request("rapor_personel_id"))
            baslangic_tarihi = trn(request("baslangic_tarihi"))
            bitis_tarihi = trn(request("bitis_tarihi"))
            etiketler = trn(request("etiketler"))
            yeni_is_yuku_proje_id = trn(request("yeni_is_yuku_proje_id"))

            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")

            Doc.ImportFromUrl site_url & "/form_personel_performans_raporu/?jsid=4559&rapor_personel_id=" & rapor_personel_id & "&baslangic_tarihi=" & baslangic_tarihi & "&bitis_tarihi=" & bitis_tarihi & "&bitis=" & bitis & "&fid=" & firma_id & "&kid=" & kullanici_id & "&etiketler=" & etiketler & "&yeni_is_yuku_proje_id=" & yeni_is_yuku_proje_id, "pageWidth=1240,DrawBackground=true,pageHeight=1754, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

        elseif trn(request("islem2"))="proje_adam_saat_raporu" then

            rapor_personel_id = trn(request("rapor_personel_id"))
            etiketler = trn(request("etiketler"))
            yeni_is_yuku_proje_id = trn(request("yeni_is_yuku_proje_id"))
            baslangic = trn(request("baslangic"))
            bitis = trn(request("bitis"))

            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")

            Doc.ImportFromUrl site_url & "/form_proje_adam_saat_raporu/?jsid=4559&rapor_personel_id=" & rapor_personel_id & "&etiketler=" & etiketler & "&yeni_is_yuku_proje_id=" & yeni_is_yuku_proje_id & "&baslangic=" & baslangic & "&fid=" & firma_id & "&kid=" & kullanici_id & "&bitis=" & bitis, "pageWidth=2250,DrawBackground=true,pageHeight=1640, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

        elseif trn(request("islem2"))="departman_adam_saat_raporu" then

            etiketler = trn(request("etiketler"))
            rapor_personel_id = trn(request("rapor_personel_id"))
            yeni_is_yuku_proje_id = trn(request("yeni_is_yuku_proje_id"))
            baslangic = trn(request("baslangic"))
            bitis = trn(request("bitis"))

            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")

            Doc.ImportFromUrl site_url & "/form_departman_adam_saat_raporu/?jsid=4559&rapor_personel_id=" & rapor_personel_id & "&etiketler=" & etiketler & "&yeni_is_yuku_proje_id=" & yeni_is_yuku_proje_id & "&baslangic=" & baslangic & "&fid=" & firma_id & "&kid=" & kullanici_id & "&bitis=" & bitis, "pageWidth=2250,DrawBackground=true,pageHeight=1640, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

        elseif trn(request("islem2"))="proje_maliyet_raporu" then

            yeni_is_yuku_proje_id = trn(request("yeni_is_yuku_proje_id"))
        
            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")

            Doc.ImportFromUrl site_url & "/form_proje_maliyet_raporu/?jsid=4559&yeni_is_yuku_proje_id=" & yeni_is_yuku_proje_id & "&fid=" & firma_id & "&kid=" & kullanici_id, "pageWidth=1240,DrawBackground=true,pageHeight=1754, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

        elseif trn(request("islem2"))="personel_adam_saat_raporu" then

            personel_id = trn(request("rapor_personel_id"))
            baslangic = trn(request("baslangic"))
            bitis = trn(request("bitis"))
            is_yuku_gosterim_tipi = trn(request("is_yuku_gosterim_tipi"))
            etiketler = trn(request("etiketler"))
            yeni_is_yuku_proje_id = trn(request("yeni_is_yuku_proje_id"))
        
            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")


            Doc.ImportFromUrl site_url & "/form_personel_adam_saat_raporu/?jsid=4559&personel_id=" & personel_id & "&baslangic=" & baslangic & "&bitis=" & bitis & "&is_yuku_gosterim_tipi=" & is_yuku_gosterim_tipi & "&fid=" & firma_id & "&kid=" & kullanici_id & "&etiketler=" & etiketler & "&yeni_is_yuku_proje_id="&yeni_is_yuku_proje_id, "pageWidth=2250,DrawBackground=true,pageHeight=1640, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

       elseif trn(request("islem2"))="tahsilatlar_raporu" then

        
            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")


            Doc.ImportFromUrl site_url & "/form_tahsilatlar_raporu/?jsid=4559&firma_id=" & firma_id & "&kullanici_id=" & kullanici_id, "pageWidth=1240,DrawBackground=true,pageHeight=1754, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

       elseif trn(request("islem2"))="odemeler_raporu" then

        
            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")


            Doc.ImportFromUrl site_url & "/form_odemeler_raporu/?jsid=4559&firma_id=" & firma_id & "&kullanici_id=" & kullanici_id, "pageWidth=1240,DrawBackground=true,pageHeight=1754, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

       elseif trn(request("islem2"))="nakit_akis_raporu" then

        
            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")


            Doc.ImportFromUrl site_url & "/form_nakit_akis_raporu/?jsid=4559&firma_id=" & firma_id & "&kullanici_id=" & kullanici_id, "pageWidth=1754,DrawBackground=true,pageHeight=1240, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

       elseif trn(request("islem2"))="gantt_liste" then

        
            proje_id = trn(request("proje_id"))
            tip = trn(request("tip"))

            firma_id = Request.Cookies("kullanici")("firma_id")
            kullanici_id = Request.Cookies("kullanici")("kullanici_id")


            Doc.ImportFromUrl site_url & "/form_gantt_liste_gorunumu/?jsid=4559&firma_id=" & firma_id & "&kullanici_id=" & kullanici_id & "&tip=" & tip & "&proje_id=" & proje_id, "pageWidth=1400,DrawBackground=true,pageHeight=1850, LeftMargin=30, RightMargin=30, TopMargin=30, BottomMargin=0"
            dosya_yolu = "/downloadRapor/Rapor"& replace(replace(Replace(now(), ".", ""), " ", ""), ":","") &".pdf"
            Filename = Doc.Save(server.MapPath(dosya_yolu), Overwrite = false)
            
            sName = server.MapPath(dosya_yolu)

        elseif trn(request("islem2"))="bordro_gonder" then

        
            dosya_yolu = trn(request("dosya_yolu"))

            sName = server.MapPath(dosya_yolu)


        end if
        

%>

<%
        SQL = "select * from ucgem_firma_listesi where yetki_kodu = 'BOSS' and id = '"& FirmaID &"'"
        set firmaBilgileri = baglanti.execute(SQL)

        if firmaBilgileri("mail_entegrasyon") = True then
%>
<center>
<img src="/img/Gnome-Emblem-Default-48.png" /><br /><br />
    <h4><%=LNG("Belgeniz Hazır.")%></h4><br />
    </center>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_mail_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <input type="hidden" name="ek_dosya" id="ek_dosya" value="<%=dosya_yolu %>" />
    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("E-Posta")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" class="form-control required" required name="eposta" id="eposta" value="<%=epostacek("personel_eposta") %>" />
            </div>
        </div>
    </div>


    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Konu")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" class="form-control required" required name="konu" id="konu" />
            </div>
        </div>
    </div>


    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Mesajınız")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <textarea id="mesaj" name="mesaj" class=" form-control" style="width: 93%; padding-left: 5px; padding-top: 6px;" required></textarea>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <input type="button" onclick="mail_gonderim_baslat(this, '');" class="btn btn-primary" value="<%=LNG("Mail Gönder")%>" />
    </div>
    <script>
        $(function () {
            setTimeout(function () { $("#konu").focus() }, 1500);
            autosize($("#mesaj"));
        });
    </script>
</form>
<%else %>
<center><img src='/img/uyari.png' /><br><br><strong> Mail Entegrasyonunuz Yapılmamıştır.</strong></center>
<%end if %>
<%


        

        set doc = nothing
        set pdf = nothing
        
    elseif trn(request("islem"))="mail_gonderim_baslat" then

        SQL = "select * from ucgem_firma_listesi where yetki_kodu = 'BOSS' and id = '"& FirmaID &"'"
        set firmaBilgileri = baglanti.execute(SQL)

        if firmaBilgileri("mail_entegrasyon") = True then

        ' on error resume next

        ek_dosya = trn(HTMLDecode(urldecodes(request("ek_dosya"))))
        
        e_posta = trn(request("eposta"))
        konu = trn(request("konu"))
        maill = trn(request("mesaj"))
        mail_antet = ""
        'gonderici = "uygulama@proskop.com"
        'gonderici = "esflw@esotomasyon.com.tr"

        mailTLS = false
        if firmaBilgileri("firma_mail_tls") = True then
            mailTLS = true
        end if

        dosya_ismi = "belge.pdf"

        antet_ust = "<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.01 Transitional//EN"" ""http://www.w3.org/TR/html4/loose.dtd""> <html lang=""en""> <head> <meta http-equiv=""Content-Type"" content=""text/html; charset=UTF-8""> <meta name=""viewport"" content=""width=device-width, initial-scale=1""> <meta http-equiv=""X-UA-Compatible"" content=""IE=edge""> <title>Es Otomasyon</title> <style type=""text/css""> </style> </head> <body style=""margin:0; padding:0; background-color:#F2F2F2;""> <center> <img src=""http://otomasyon.esflw.com/images/esotomasyon_logo.png"" width=""150"" style=""width:150px;"" /><br /><br /> <table width=""640"" cellpadding=""0"" cellspacing=""0"" border=""0"" class=""wrapper"" bgcolor=""#FFFFFF""> <tr> <td height=""10"" style=""font-size:10px; line-height:10px;"">&nbsp;</td> </tr> <tr> <td align=""center"" valign=""top""> <table width=""600"" cellpadding=""0"" cellspacing=""0"" border=""0"" class=""container""> <tr> <td align=""left"" valign=""top""> <p style=""font-family:Tahoma; font-size:12px;""> "
        antet_alt = "</p> <p style=""font-family:Tahoma; font-size:12px;""> Sevgiler,<br /><strong>"& firmaBilgileri("firma_adi") &" Ekibi</strong> </p> </td> </tr> </table> </td> </tr> <tr> <td height=""10"" style=""font-size:10px; line-height:10px;"">&nbsp;</td></tr></table><p style=""font-family:Tahoma; font-size:12px; color:#808080;""> <br /> <strong>PROSKOP</strong><br /><br /><br /></p></center></body></html>"
        
		Set Mail = Server.CreateObject("Persits.MailSender")
		'Mail.Host = "mail.makrogem.com.tr"                                                     ' Es-Posta sunucu adresi
		Mail.Host = firmaBilgileri("firma_mail_host")                                           ' E-Posta sunucu adresi
        Mail.Port = CInt(firmaBilgileri("firma_mail_port"))
        Mail.TLS = mailTLS
		Mail.Username = firmaBilgileri("firma_mail")                                            ' Gönderim adresi
		Mail.Password = firmaBilgileri("firma_mail_sifre")                                      ' Gönderen hesabın şifresi
		Mail.From = firmaBilgileri("firma_mail")                                                ' E-Postayı gönderen adres
		Mail.FromName = Mail.EncodeHeader(firmaBilgileri("firma_adi"), "UTF-8")                 ' E-Posta gönderen isim
		Mail.AddAddress e_posta                                                                 ' Alıcı e-posta adresi
		Mail.AddReplyTo firmaBilgileri("firma_mail")                                            ' Alıcı yanıtladığında gidecek adres
		Mail.Subject = Mail.EncodeHeader(firmaBilgileri("firma_adi") & " - " & konu, "UTF-8")   ' Mail konusu
		Mail.Body = antet_ust & maill & antet_alt                                               ' Mail içeriği
		Mail.IsHTML = True
        Mail.CharSet = "UTF-8"

        if ek_dosya = "undefined" then            
        else
            sName = server.MapPath(ek_dosya)
            Mail.AddAttachment sName
        End If

		Mail.Send

        If err Then
            Response.Write err.Description
            Response.Write "<center><strong>Gönderim Hatası.</strong><br><br>" & LNG("Lütfen Tekrar Deneyiniz.") & "</center>"
        else
            Response.Write "<center><img src='/img/Gnome-Emblem-Default-48.png' /><br><br><strong>" & LNG("Mail Başarıyla Gönderildi") & "</strong></center>"
        End If

        Response.End
        else
            Response.Write "<center><img src='/img/uyari.png' /><br><br><strong>" & LNG("Mail Entegrasyonunuz Yapılmamıştır...") & "</strong></center>"
        end if

    end if 

%>