<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 

    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    if trn(request("islem"))="J206re15" then

        Response.Cookies("kullanici")("ben_salih")="True"
        Response.End

    elseif trn(request("islem"))="taseron_listesi" then
%>
<div class="dt-responsive table-responsive">
    <table id="dt_basic" class="table table-striped table-bordered table-hover datatableyap" width="100%" style="width: 100%;">
        <thead>
            <tr>
                <th data-hide="phone,tablet">ID</th>
                <th data-class="expand"><%=LNG("Taşeron Adı") %></th>
                <th data-hide="phone,tablet"><%=LNG("Yetkili Kişi") %></th>
                <th data-hide="phone,tablet"><%=LNG("Şehir")%></th>
                <th style="text-align: center;"><%=LNG("Durum")%></th>
                <th>İşlem</th>
            </tr>
        </thead>
        <tbody>
            <% for x = 1 to 10 %>
            <tr>
                <td style="text-align: center;">1</td>
                <td>Taşeron 1 Ltd Şti.</td>
                <td>Salih ŞAHİN</td>
                <td>Bursa</td>
                <td style="text-align: center;">
                    <span class="onoffswitch">
                        <span id="taseronlar_st4_label_0" class="onoffswitch-label">
                            <input id="taseronlar_st4_0" type="checkbox" name="taseronlar_st4" checked="checked" class="js-switch" />
                        </span>
                    </span>
                </td>
                <td class="icon-list-demo2">
                    <a href="javascript:void(0);" onclick="sayfagetir('/taseron_detay/', 'jsid=4559&taseron_id=1');" rel="tooltip" data-placement="top" data-original-title="Taşeron Detaylarını Görüntüle">
                        <i class="fa fa-external-link"></i>
                    </a>
                    &nbsp;
                    <a href="javascript:void(0);" rel="tooltip" data-placement="top" data-original-title="Taşeron Sil">
                        <i class="ti-trash"></i>
                    </a>
                </td>
            </tr>
            <% next %>
        </tbody>
    </table>
</div>
<% 
    elseif trn(request("islem"))="sirket_sehir_sectim_bolge_getir" then

        sehir_id = trn(request("sehir_id"))
%>
<select name="firma_ilce" id="firma_ilce" class="select2">
    <%
        SQL="select id, bolge from tanimlama_destinasyon_bolge where sehir_id = '"& sehir_id &"' order by bolge asc"
        set bolgecek = baglanti.execute(SQL)
        do while not bolgecek.eof
    %>
    <option value="<%=bolgecek("id") %>"><%=bolgecek("bolge") %></option>
    <%
        bolgecek.movenext
        loop
    %>
</select>
<% 
        
    elseif trn(request("islem"))="firma_bilgilerimi_guncelle" then

        kayit_id = Request.Cookies("kullanici")("firma_id")
        firma_logo = trn(request("firma_logo"))
        firma_adi = trn(request("firma_adi"))
        firma_yetkili = trn(request("firma_yetkili"))
        firma_sehir = trn(request("firma_sehir"))
        firma_bolge = trn(request("firma_ilce"))
        firma_adres = trn(request("firma_adres"))
        firma_telefon = trn(request("firma_telefon"))
        firma_gsm = trn(request("firma_gsm"))
        firma_vergi_daire = trn(request("firma_vergi_daire"))
        firma_vergi_no = trn(request("firma_vergi_no"))
        firma_tema  = trn(request("firma_tema"))

        SQL="update ucgem_firma_listesi set firma_tema = '"& firma_tema &"', firma_logo = '"& firma_logo &"', firma_adi = '"& firma_adi &"', firma_yetkili = '"& firma_yetkili &"', firma_sehir = '"& firma_sehir &"', firma_bolge = '"& firma_bolge &"', firma_adres = '"& firma_adres &"', firma_telefon = '"& firma_telefon &"', firma_gsm = '"& firma_gsm &"', firma_vergi_daire = '"& firma_vergi_daire &"', firma_vergi_no = '"& firma_vergi_no &"' where id = '"& kayit_id &"'"
        set guncelle = baglanti.execute(SQL)

    
    elseif trn(request("islem"))="toplanti_gundem_ekle" then

        toplanti_id = trn(request("toplanti_id"))
%>
<form id="koftiforms"></form>
<div class="modal-header">
    <%=LNG("Gündem Ekle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>

<form autocomplete="off" id="yeni_gundem_form" class="smart-form validateform" style="padding: 15px;">
    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Gündem")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <textarea id="gundem" name="gundem" class="required form-control" style="width: 93%; padding-left: 35px; padding-top: 6px;" required></textarea>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            setTimeout(function () { $("#gundem").focus() }, 1500);
            autosize($("#gundem"));
        });
    </script>
    <div class="modal-footer">
        <input type="button" onclick="gundem_ekle(this, '<%=toplanti_id%>');" class="btn btn-primary" value="<%=LNG("Yeni Gündem Ekle")%>" />
    </div>
</form>
<%
    elseif trn(request("islem"))="toplanti_gundem_duzenle" then

        toplanti_id = trn(request("toplanti_id"))
        gundem_id = trn(request("gundem_id"))

        SQL="select * from ahtapot_toplanti_gundem_listesi where id = '"& gundem_id &"'"
        set gundem = baglanti.execute(SQL)

%>

<div class="modal-header">
    <%=LNG("Gündem Düzenle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form autocomplete="off" id="koftiform"></form>
<form autocomplete="off" id="yeni_gundem_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Gündem")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <textarea id="gundem" name="gundem" class="required form-control" style="width: 93%; padding-left: 35px; padding-top: 6px;" required><%=gundem("gundem") %></textarea>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            setTimeout(function () { $("#gundem").focus();$("window").resize(); }, 1000);
            autosize($("#gundem"));
        });
    </script>
    <div class="modal-footer">
        <input type="button" onclick="gundem_guncelle(this, '<%=toplanti_id%>', '<%=gundem_id%>');" class="btn btn-primary" value="<%=LNG("Gündemi Güncelle")%>" />
    </div>
</form>
<%
    elseif trn(request("islem"))="yeni_toplanti_planla" then

%>

<div class="modal-header">
    <%=LNG("Yeni Toplantı Planla")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form autocomplete="off" id="koftiform"></form>
<form autocomplete="off" id="yeni_toplanti_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Toplantı Adı :")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-user"></i>
                </span>
                <input type="text" id="toplanti_adi" name="toplanti_adi" required class="form-control required" />
            </div>
        </div>
    </div>



    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Toplantı Tipi :")%></label>
        <div class="col-sm-12">
            <select name="toplanti_tipi" onchange="toplanti_tipi_sectim(this.value);" id="toplanti_tipi">
                <option value="gundeme_ozel"><%=LNG("Gündeme Özel")%></option>
                <option value="rutin"><%=LNG("Rutin")%></option>
            </select>
        </div>
    </div>



    <div class="row toplanti_tipi rutin" style="display: none;">
        <label class="col-sm-12 col-form-label"><%=LNG("Yineleme Dönemi :")%></label>
        <div class="col-sm-3">
            <table>
                <tr>
                    <td>
                        <input type="radio" class="yineleme_donemi" name="yineleme_donemi" id="yineleme_donemi1" onclick="toplanti_ekle_yineleme_donemi(this);" value="gunluk" checked="checked" checkeds="checkeds" /></td>
                    <td><%=LNG("Günlük")%></td>
                </tr>
                <tr>
                    <td style="padding-top: 5px;">
                        <input type="radio" class="yineleme_donemi" id="yineleme_donemi2" onclick="toplanti_ekle_yineleme_donemi(this);" value="haftalik" name="yineleme_donemi" /></td>
                    <td style="padding-top: 5px;"><%=LNG("Haftalık")%></td>
                </tr>
                <tr>
                    <td style="padding-top: 5px;">
                        <input type="radio" class="yineleme_donemi" id="yineleme_donemi3" onclick="toplanti_ekle_yineleme_donemi(this);" value="aylik" name="yineleme_donemi" /></td>
                    <td style="padding-top: 5px;"><%=LNG("Aylık")%></td>
                </tr>
            </table>
        </div>
        <div class="col-sm-9" style="border-left: 1px solid #e8e8e8;">
            <div class="yineleme_yerleri gunluk_yineleme">
                <table>
                    <tr>
                        <td>
                            <input type="radio" checkeds="checkeds" checked="checked" name="gunluk_yineleme_secim" id="gunluk_yineleme_secim1" onclick="radio_tikle(this);" value="gunluk" /></td>
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

    <div class="row toplanti_tipi rutin" style="display: none;">
        <label class="col-sm-12 col-form-label"><%=LNG("Yineleme Aralığı :")%></label>
        <div class="col-sm-6">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-user"></i>
                </span>
                <input type="text" autocomplete="off" id="yineleme_baslangic" name="yineleme_baslangic" class="form-control takvimyap required" required />
            </div>
        </div>
        <div class="col-sm-6">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-user"></i>
                </span>
                <input type="text" autocomplete="off" id="yineleme_bitis" name="yineleme_bitis" class="form-control takvimyap required" required />
            </div>
        </div>
    </div>


    <div class="row ">
        <div class="toplanti_tipi gundeme_ozel col-sm-8" style="padding: 0;">
            <label class="col-sm-12 col-form-label"><%=LNG("Toplantı Zamanı :")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-user"></i>
                    </span>
                    <input type="text" autocomplete="off" id="toplanti_tarihi" name="toplanti_tarihi" required class="form-control takvimyap required" />
                </div>
            </div>
        </div>
        <div class="col-sm-4" style="padding: 0;">
            <label class="col-sm-12 col-form-label"><%=LNG("Toplantı Saati :")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-user"></i>
                    </span>
                    <input type="text" autocomplete="off" id="toplanti_saati" name="toplanti_saati" class="form-control required timepicker" required />
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Gündem")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <textarea id="gundem" name="gundem" class="required form-control" style="width: 93%; padding-left: 10px; padding-top: 6px;" required></textarea>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            setTimeout(function () { $("#toplanti_adi").focus() }, 1500);
            autosize($("#gundem"));
        });
    </script>
    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Katılımcılar :")%></label>
        <div class="col-sm-12">
            <select class="select2" name="katilimcilar" id="katilimcilar" multiple="multiple">
                <%
                    SQL="select id, personel_ad + ' ' + personel_soyad as personel_ad_soyad from ucgem_firma_kullanici_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and durum = 'true' and cop = 'false';"
                    set katilimci = baglanti.execute(SQL)
                    do while not katilimci.eof
                %>
                <option value="<%=katilimci("id") %>"><%=katilimci("personel_ad_soyad") %></option>
                <%
                    katilimci.movenext
                    loop
                %>
            </select>
        </div>
    </div>


    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Etiketler :")%></label>
        <div class="col-sm-12">
            <select class="select2" name="etiketler" id="etiketler" multiple="multiple">
                <%
                    songrup = ""
                    SQL="select * from etiketler etiket with(nolock) where etiket.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' order by grup, adi asc;"
                    set etiketler = baglanti.execute(SQL)
                    do while not etiketler.eof
                        if not trim(songrup) = trim(etiketler("grup")) then
                            if not songrup = "" then
                %>
                            </optgroup>
                            <% end if %>
                <optgroup label="<%=etiketler("grup") %>">
                    <%
                            songrup = etiketler("grup")
                        end if
                    %>
                    <option value="<%=etiketler("tip") %>-<%=etiketler("id") %>"><%=etiketler("adi") %></option>
                    <%
                    etiketler.movenext
                    loop
                    %>
                </optgroup>
            </select>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Planlanan Toplantı Süresi :")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-user"></i>
                </span>
                <input type="text" id="toplanti_suresi" name="toplanti_suresi" class="form-control timepicker required" required />
            </div>
        </div>
    </div>



    <div class="modal-footer">
        <input type="button" onclick="toplanti_ekle(this);" class="btn btn-primary" value="<%=LNG("Yeni Toplantı Ekle")%>" />
    </div>
</form>
<%  elseif trn(request("islem"))="toplanti_duzenle" then
    
        toplanti_id = trn(request("toplanti_id"))

        SQL="select * from ahtapot_toplanti_kaydi where id = '"& toplanti_id &"'"
        set toplanti = baglanti.execute(SQL)

%>
<div class="modal-header">
    <%=LNG("Toplantı Düzenle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form autocomplete="off" id="koftiform"></form>
<form autocomplete="off" id="yeni_toplanti_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Toplantı Adı :")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-user"></i>
                </span>
                <input type="text" id="toplanti_adi" name="toplanti_adi" value="<%=toplanti("toplanti_adi") %>" required class="form-control required" />
            </div>
        </div>
    </div>
    <%
        radio1 = ""
        if trim(toplanti("yineleme_donemi"))="gunluk" then
            radio1 = "yineleme_donemi1"
        elseif trim(toplanti("yineleme_donemi"))="haftalik" then
            radio1 = "yineleme_donemi2"
        elseif trim(toplanti("yineleme_donemi"))="aylik" then
            radio1 = "yineleme_donemi3"
        end if
    %>
    <script>
        $(function(){
            toplanti_tipi_sectim('<%=toplanti("toplanti_tipi") %>');
            toplanti_ekle_yineleme_donemi2('<%=radio1 %>');
        });
    </script>
    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Toplantı Tipi :")%></label>
        <div class="col-sm-12">
            <select name="toplanti_tipi" onchange="toplanti_tipi_sectim(this.value);" id="toplanti_tipi">
                <option <% if trim(toplanti("toplanti_tipi"))="gundeme_ozel" then %> selected="selected" <% end if %> value="gundeme_ozel"><%=LNG("Gündeme Özel")%></option>
                <option <% if trim(toplanti("toplanti_tipi"))="rutin" then %> selected="selected" <% end if %> value="rutin"><%=LNG("Rutin")%></option>
            </select>
        </div>
    </div>
    <div class="row toplanti_tipi rutin" style="display: none;">
        <label class="col-sm-12 col-form-label"><%=LNG("Yineleme Dönemi :")%></label>
        <div class="col-sm-3">
            <table>
                <tr>
                    <td>
                        <input type="radio" class="yineleme_donemi" name="yineleme_donemi1" id="yineleme_donemi1" onclick="toplanti_ekle_yineleme_donemi(this);" value="gunluk" <% if trim(toplanti("yineleme_donemi"))="gunluk" then %> checked="checked" <% end if %> /></td>
                    <td><%=LNG("Günlük")%></td>
                </tr>
                <tr>
                    <td style="padding-top: 5px;">
                        <input type="radio" class="yineleme_donemi" id="yineleme_donemi2" onclick="toplanti_ekle_yineleme_donemi(this);" value="haftalik" name="yineleme_donemi" <% if trim(toplanti("yineleme_donemi"))="haftalik" then %> checked="checked" <% end if %> /></td>
                    <td style="padding-top: 5px;"><%=LNG("Haftalık")%></td>
                </tr>
                <tr>
                    <td style="padding-top: 5px;">
                        <input type="radio" class="yineleme_donemi" id="yineleme_donemi3" onclick="toplanti_ekle_yineleme_donemi(this);" value="aylik" name="yineleme_donemi" <% if trim(toplanti("yineleme_donemi"))="aylik" then %> checked="checked" <% end if %> /></td>
                    <td style="padding-top: 5px;"><%=LNG("Aylık")%></td>
                </tr>
            </table>
        </div>
        <div class="col-sm-9" style="border-left: 1px solid #e8e8e8;">
            <%
                gunluk_yineleme_gun_aralik = toplanti("gunluk_yineleme_gun_aralik")
                if isnumeric(toplanti("gunluk_yineleme_gun_aralik"))=false then
                    gunluk_yineleme_gun_aralik = 0
                end if
            %>
            <div class="yineleme_yerleri gunluk_yineleme">
                <table>
                    <tr>
                        <td>
                            <input type="radio" checked="checked" name="gunluk_yineleme_secim" id="gunluk_yineleme_secim1" onclick="radio_tikle(this);" value="gunluk" <% if trim(toplanti("gunluk_yineleme_secim"))="gunluk" then %> checkeds="checkeds" <% end if %> /></td>
                        <td><%=LNG("Her")%> </td>
                        <td>
                            <input type="text" required value="<%=gunluk_yineleme_gun_aralik %>" name="gunluk_yineleme_gun_aralik" id="gunluk_yineleme_gun_aralik1" style="width: 35px; text-align: center;" class="numericonly required" /></td>
                        <td><%=LNG("günde bir")%> </td>
                    </tr>
                    <tr>
                        <td style="padding-top: 10px;">
                            <input type="radio" name="gunluk_yineleme_secim" id="gunluk_yineleme_secim2" onclick="radio_tikle(this);" value="is_gunu" <% if trim(toplanti("gunluk_yineleme_secim"))="is_gunu" then %> checked="checked" <% end if %> /></td>
                        <td style="padding-top: 10px;" colspan="3"><%=LNG("Her İş Günü")%></td>
                    </tr>
                </table>
            </div>
            <div class="yineleme_yerleri haftalik_yineleme" style="width: 100%; display: none;">
                <table style="width: 100%;">
                    <tr>
                        <td><%=LNG("Her")%></td>
                        <td>
                            <input required type="text" name="haftalik_yineleme_sikligi" id="haftalik_yineleme_sikligi" value="<%=cint(toplanti("haftalik_yineleme_sikligi")) %>" style="width: 35px; text-align: center;" class="numericonly required" /></td>
                        <td><%=LNG("haftada bir yenile")%></td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <div style="width: 100%; padding-top: 15px;">
                                <table style="width: 100%;">
                                    <tr>
                                        <td><%=LNG("Pzt")%><br />
                                            <label class="onoffswitch-label" id="st4_label">
                                                <input <% if instr(trim(toplanti("gunler")), "2")>0 then %> checked="checked" <% end if %> type="checkbox" value="2" class="js-switch dhaftalik_gunler" id="st4" name="haftalik_gunler" />
                                            </label>
                                        </td>
                                        <td><%=LNG("Sal")%><br />
                                            <label class="onoffswitch-label" id="st5_label">
                                                <input <% if instr(trim(toplanti("gunler")), "3")>0 then %> checked="checked" <% end if %> type="checkbox" value="3" class="js-switch dhaftalik_gunler" id="st5" name="haftalik_gunler" />
                                            </label>
                                        </td>
                                        <td><%=LNG("Çar")%><br />
                                            <label class="onoffswitch-label" id="st6_label">
                                                <input <% if instr(trim(toplanti("gunler")), "4")>0 then %> checked="checked" <% end if %> type="checkbox" value="4" class="js-switch dhaftalik_gunler" id="st6" name="haftalik_gunler" />
                                            </label>
                                        </td>
                                        <td><%=LNG("Per")%><br />
                                            <label class="onoffswitch-label" id="st7_label">
                                                <input <% if instr(trim(toplanti("gunler")), "5")>0 then %> checked="checked" <% end if %> type="checkbox" value="5" class="js-switch dhaftalik_gunler" id="st7" name="haftalik_gunler" />
                                            </label>
                                        </td>
                                        <td><%=LNG("Cum")%><br />
                                            <label class="onoffswitch-label" id="st8_label">
                                                <input <% if instr(trim(toplanti("gunler")), "6")>0 then %> checked="checked" <% end if %> type="checkbox" value="6" class="js-switch dhaftalik_gunler" id="st8" name="haftalik_gunler" />
                                            </label>
                                        </td>
                                        <td><%=LNG("Cmt")%><br />
                                            <label class="onoffswitch-label" id="st9_label">
                                                <input <% if instr(trim(toplanti("gunler")), "7")>0 then %> checked="checked" <% end if %> type="checkbox" value="7" class="js-switch dhaftalik_gunler" id="st9" name="haftalik_gunler" />
                                            </label>
                                        </td>
                                        <td><%=LNG("Pzr")%><br />
                                            <label class="onoffswitch-label" id="st10_label">
                                                <input <% if instr(trim(toplanti("gunler")), "1")>0 then %> checked="checked" <% end if %> type="checkbox" value="1" class="js-switch dhaftalik_gunler" id="st10" name="haftalik_gunler" />
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <%
                aylik_gun = toplanti("aylik_gun")
                if isnumeric(aylik_gun)=false then
                    aylik_gun = 0
                end if

                aylik_aralik = toplanti("aylik_aralik")
                if isnumeric(aylik_aralik)=false then
                    aylik_aralik = 0
                end if

            %>
            <div class="yineleme_yerleri aylik_yineleme" style="width: 100%; display: none;">
                <table>
                    <tr>
                        <td>
                            <input type="radio" checked="checked" name="aylik_yenileme_tipi" id="aylik_yenileme_tipi1" onclick="radio_tikle(this);" value="1" <% if trim(toplanti("aylik_yenileme_tipi"))="1" then %> checkeds="checkeds" <% end if %> /></td>
                        <td style="width: 37px;"><%=LNG("Her")%></td>
                        <td>
                            <input type="text" value="<%=cint(aylik_gun) %>" name="aylik_gun" id="aylik_gun" style="width: 35px; text-align: center;" required class="numericonly required" /></td>
                        <td style="width: 65px;"><%=LNG(". günü")%></td>
                        <td>
                            <input type="text" value="<%=aylik_aralik %>" style="width: 35px; text-align: center;" name="aylik_aralik" id="aylik_aralik" class="numericonly" required /></td>
                        <td><%=LNG("ayda bir")%></td>
                    </tr>
                </table>
                <br />
                <table>
                    <tr>
                        <td>
                            <input type="radio" <% if trim(toplanti("aylik_yenileme_tipi"))="2" then %> checked="checked" <% end if %> name="aylik_yenileme_tipi" id="aylik_yenileme_tipi2" onclick="radio_tikle(this);" value="2" /></td>
                        <td style="width: 37px;"><%=LNG("Her")%></td>
                        <td>
                            <select name="aylik_yineleme1" id="aylik_yineleme1" class="yapilan">
                                <option <% if trim(toplanti("aylik_yineleme1"))="1" then %> selected="selected" <% end if %> value="1"><%=LNG("birinci")%></option>
                                <option <% if trim(toplanti("aylik_yineleme1"))="2" then %> selected="selected" <% end if %> value="2"><%=LNG("ikinci")%></option>
                                <option <% if trim(toplanti("aylik_yineleme1"))="3" then %> selected="selected" <% end if %> value="3"><%=LNG("üçüncü")%></option>
                                <option <% if trim(toplanti("aylik_yineleme1"))="4" then %> selected="selected" <% end if %> value="4"><%=LNG("dördüncü")%></option>
                                <option <% if trim(toplanti("aylik_yineleme1"))="son" then %> selected="selected" <% end if %> value="son"><%=LNG("son")%></option>
                            </select></td>
                        <td style="padding-left: 8px;">
                            <select name="aylik_yineleme2" id="aylik_yineleme2" class="yapilan">
                                <option <% if trim(toplanti("aylik_yineleme2"))="gün" then %> selected="selected" <% end if %> value="gün"><%=LNG("gün")%></option>
                                <option <% if trim(toplanti("aylik_yineleme2"))="2" then %> selected="selected" <% end if %> value="2"><%=LNG("pazartesi")%></option>
                                <option <% if trim(toplanti("aylik_yineleme2"))="3" then %> selected="selected" <% end if %> value="3"><%=LNG("salı")%></option>
                                <option <% if trim(toplanti("aylik_yineleme2"))="4" then %> selected="selected" <% end if %> value="4"><%=LNG("çarşamba")%></option>
                                <option <% if trim(toplanti("aylik_yineleme2"))="5" then %> selected="selected" <% end if %> value="5"><%=LNG("perşembe")%></option>
                                <option <% if trim(toplanti("aylik_yineleme2"))="6" then %> selected="selected" <% end if %> value="6"><%=LNG("cuma")%></option>
                                <option <% if trim(toplanti("aylik_yineleme2"))="7" then %> selected="selected" <% end if %> value="7"><%=LNG("cumartesi")%></option>
                                <option <% if trim(toplanti("aylik_yineleme2"))="1" then %> selected="selected" <% end if %> value="1"><%=LNG("pazar")%></option>
                            </select></td>
                        <td>günü</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <div class="row toplanti_tipi rutin" style="display: none;">
        <label class="col-sm-12 col-form-label"><%=LNG("Yineleme Aralığı :")%></label>
        <div class="col-sm-6">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-user"></i>
                </span>
                <input type="text" id="yineleme_baslangic" name="yineleme_baslangic" value="<%=cdate(toplanti("yineleme_baslangic")) %>" class="form-control takvimyap required" required />
            </div>
        </div>
        <div class="col-sm-6">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-user"></i>
                </span>
                <input type="text" id="yineleme_bitis" name="yineleme_bitis" value="<%=cdate(toplanti("yineleme_bitis")) %>" class="form-control takvimyap required" required />
            </div>
        </div>
    </div>


    <div class="row ">
        <div class="toplanti_tipi gundeme_ozel col-sm-8" style="padding: 0;">
            <label class="col-sm-12 col-form-label"><%=LNG("Toplantı Zamanı :")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-user"></i>
                    </span>
                    <input type="text" id="toplanti_tarihi" value="<%=cdate(toplanti("toplanti_tarihi")) %>" name="toplanti_tarihi" required class="form-control takvimyap required" />
                </div>
            </div>
        </div>
        <div class="col-sm-4" style="padding: 0;">
            <label class="col-sm-12 col-form-label"><%=LNG("Toplantı Saati :")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-user"></i>
                    </span>
                    <input type="text" id="toplanti_saati" name="toplanti_saati" value="<%=left(toplanti("toplanti_saati"),5) %>" class="form-control required timepicker" required />
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Gündem")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <textarea id="gundem" name="gundem" class="required form-control" style="width: 93%; padding-left: 35px; padding-top: 6px;" required><%=toplanti("gundem") %></textarea>
            </div>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Katılımcılar :")%></label>
        <div class="col-sm-12">
            <select class="select2" name="katilimcilar" id="katilimcilar" multiple="multiple">
                <%
                    SQL="select id, personel_ad + ' ' + personel_soyad as personel_ad_soyad from ucgem_firma_kullanici_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and durum = 'true' and cop = 'false';"
                    set katilimci = baglanti.execute(SQL)
                    do while not katilimci.eof
                %>
                <option <% if instr("," & toplanti("katilimcilar") & ",", "," & katilimci("id") & ",")>0 then %> selected="selected" <% end if %> value="<%=katilimci("id") %>"><%=katilimci("personel_ad_soyad") %></option>
                <%
                    katilimci.movenext
                    loop
                %>
            </select>
        </div>
    </div>


    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Etiketler :")%></label>
        <div class="col-sm-12">
            <select class="select2" name="etiketler" id="etiketler" multiple="multiple">
                <%
                    songrup = ""
                    SQL="select * from etiketler etiket with(nolock) where etiket.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' order by grup, adi asc;"
                    set etiketler = baglanti.execute(SQL)
                    do while not etiketler.eof
                        if not trim(songrup) = trim(etiketler("grup")) then
                            if not songrup = "" then
                %>
                            </optgroup>
                            <% end if %>
                <optgroup label="<%=etiketler("grup") %>">
                    <%
                            songrup = etiketler("grup")
                        end if
                    %>
                    <option <% if instr("," & toplanti("etiketler") & ",", "," & etiketler("tip") & "-" & etiketler("id") & ",")>0 then %> selected="selected" <% end if %> value="<%=etiketler("tip") %>-<%=etiketler("id") %>"><%=etiketler("adi") %></option>
                    <%
                    etiketler.movenext
                    loop
                    %>
                </optgroup>
            </select>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Planlanan Toplantı Süresi :")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-user"></i>
                </span>
                <input type="text" id="toplanti_suresi" name="toplanti_suresi" value="<%=left(toplanti("toplanti_suresi"),5) %>" class="form-control timepicker required" required />
            </div>
        </div>
    </div>
    <script>
        $(function () {
            setTimeout(function () { $("#toplanti_adi").focus() }, 1500);
            autosize($("#gundem"));
        });
    </script>
    <div class="modal-footer">
        <input type="button" onclick="toplanti_guncelle(this, '<%=toplanti("id")%>');" class="btn btn-primary" value="<%=LNG("Toplantı Kaydını Güncelle")%>" />
    </div>
</form>
<% 

    elseif trn(request("islem"))="toplanti_listesi" then

        if trn(request("islem2"))="sil" then

            toplanti_id = trn(request("toplanti_id"))
            
            SQL="update ahtapot_toplanti_listesi set cop = 'true' where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and id = '"& toplanti_id &"'"
            set guncelle = baglanti.execute(SQL)

        elseif trn(request("islem2"))="iptal" then

            toplanti_id = trn(request("toplanti_id"))
            
            SQL="update ahtapot_toplanti_listesi set durum = 'iptal' where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and id = '"& toplanti_id &"'"
            set guncelle = baglanti.execute(SQL)

        elseif trn(request("islem2"))="ekle" then

            toplanti_adi = trn(request("toplanti_adi"))
            toplanti_tipi = trn(request("toplanti_tipi"))
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
            toplanti_tarihi = trn(request("toplanti_tarihi"))
            toplanti_saati = trn(request("toplanti_saati"))
            katilimcilar = trn(request("katilimcilar"))
            toplanti_suresi = trn(request("toplanti_suresi"))
            gundem = trn(request("gundem"))
            etiketler = trn(request("etiketler"))
            durum = "true"
            cop = "false"
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")

            SQL="SET NOCOUNT ON; insert into ahtapot_toplanti_kaydi(etiketler, toplanti_adi, toplanti_tipi, yineleme_donemi, gunluk_yineleme_secim, gunluk_yineleme_gun_aralik, haftalik_yineleme_sikligi, gunler, aylik_yenileme_tipi, aylik_gun, aylik_aralik, aylik_yineleme1, aylik_yineleme2, aylik_yineleme3, yineleme_baslangic, yineleme_bitis, toplanti_tarihi, toplanti_saati, katilimcilar, toplanti_suresi, gundem, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& etiketler &"', '"& toplanti_adi & "', '"& toplanti_tipi & "', '"& yineleme_donemi & "', '"& gunluk_yineleme_secim & "', '"& gunluk_yineleme_gun_aralik & "', '"& haftalik_yineleme_sikligi & "', '"& gunler & "', '"& ylik_yenileme_tipi& "', '"& aylik_gun & "', '"& aylik_aralik & "', '"& aylik_yineleme1 & "', '"& aylik_yineleme2 & "', '"& aylik_yineleme3 & "', '"& yineleme_baslangic & "', '"& yineleme_bitis & "', '"& toplanti_tarihi & "', '"&toplanti_saati & "', '"& katilimcilar & "', '"& toplanti_suresi & "', '"& gundem & "', '"& durum & "', '"& cop & "', '"& firma_kodu & "', '"& firma_id & "', '"& ekleyen_id & "', '"& ekleyen_ip & "', getdate(), getdate()); SELECT SCOPE_IDENTITY() id;"
            set ekle = baglanti.execute(SQL)

            toplanti_kayit_id = ekle("id")

            if trim(toplanti_tipi) = "gundeme_ozel" then

                toplanti_sira = 1
                toplanti_tarihi = toplanti_tarihi
                toplanti_saati = toplanti_saati

                SQL="insert into ahtapot_toplanti_listesi(toplanti_kayit_id, toplanti_sira, toplanti_tarihi, toplanti_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('" & toplanti_kayit_id & "', '" & toplanti_sira & "', '" & toplanti_tarihi & "', '" & toplanti_saati & "', '" & durum & "', '" & cop & "', '" & firma_kodu & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate())"
                set ekle = baglanti.execute(SQL)

            elseif trim(toplanti_tipi) = "rutin" then



                yineleme_baslangic = cdate(yineleme_baslangic)
                yineleme_bitis = cdate(yineleme_bitis)

                if trim(yineleme_donemi) = "gunluk" then

                    if trim(gunluk_yineleme_secim)="gunluk" then

                        y = 0
                        for x = cdate(yineleme_baslangic) to cdate(yineleme_bitis) step cint(gunluk_yineleme_gun_aralik)

                            y = y + 1
                            toplanti_sira = y
                            toplanti_tarihi = cdate(x)
                            toplanti_saati = toplanti_saati

                            SQL="insert into ahtapot_toplanti_listesi(toplanti_kayit_id, toplanti_sira, toplanti_tarihi, toplanti_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('" & toplanti_kayit_id & "', '" & toplanti_sira & "', '" & toplanti_tarihi & "', '" & toplanti_saati & "', '" & durum & "', '" & cop & "', '" & firma_kodu & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate())"
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

                                SQL="insert into ahtapot_toplanti_listesi(toplanti_kayit_id, toplanti_sira, toplanti_tarihi, toplanti_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('" & toplanti_kayit_id & "', '" & toplanti_sira & "', '" & toplanti_tarihi & "', '" & toplanti_saati & "', '" & durum & "', '" & cop & "', '" & firma_kodu & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate())"
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

                                SQL="insert into ahtapot_toplanti_listesi(toplanti_kayit_id, toplanti_sira, toplanti_tarihi, toplanti_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('" & toplanti_kayit_id & "', '" & toplanti_sira & "', '" & toplanti_tarihi & "', '" & toplanti_saati & "', '" & durum & "', '" & cop & "', '" & firma_kodu & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate())"
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

                                    SQL="insert into ahtapot_toplanti_listesi(toplanti_kayit_id, toplanti_sira, toplanti_tarihi, toplanti_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('" & toplanti_kayit_id & "', '" & toplanti_sira & "', '" & toplanti_tarihi & "', '" & toplanti_saati & "', '" & durum & "', '" & cop & "', '" & firma_kodu & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate())"
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

                                            SQL="insert into ahtapot_toplanti_listesi(toplanti_kayit_id, toplanti_sira, toplanti_tarihi, toplanti_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('" & toplanti_kayit_id & "', '" & toplanti_sira & "', '" & toplanti_tarihi & "', '" & toplanti_saati & "', '" & durum & "', '" & cop & "', '" & firma_kodu & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate())"
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

                                            SQL="insert into ahtapot_toplanti_listesi(toplanti_kayit_id, toplanti_sira, toplanti_tarihi, toplanti_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('" & toplanti_kayit_id & "', '" & toplanti_sira & "', '" & toplanti_tarihi & "', '" & toplanti_saati & "', '" & durum & "', '" & cop & "', '" & firma_kodu & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate())"
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

                                                SQL="insert into ahtapot_toplanti_listesi(toplanti_kayit_id, toplanti_sira, toplanti_tarihi, toplanti_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('" & toplanti_kayit_id & "', '" & toplanti_sira & "', '" & toplanti_tarihi & "', '" & toplanti_saati & "', '" & durum & "', '" & cop & "', '" & firma_kodu & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate())"
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

                                                SQL="insert into ahtapot_toplanti_listesi(toplanti_kayit_id, toplanti_sira, toplanti_tarihi, toplanti_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('" & toplanti_kayit_id & "', '" & toplanti_sira & "', '" & toplanti_tarihi & "', '" & toplanti_saati & "', '" & durum & "', '" & cop & "', '" & firma_kodu & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate())"
                                                set ekle = baglanti.execute(SQL)

                                            end if
                                        end if
                                    next

                                end if
                            end if
                        end if

                end if

        elseif trn(request("islem2"))="guncelle" then

            toplanti_kayit_id = trn(request("toplanti_id"))
            toplanti_adi = trn(request("toplanti_adi"))
            toplanti_tipi = trn(request("toplanti_tipi"))
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
            toplanti_tarihi = trn(request("toplanti_tarihi"))
            toplanti_saati = trn(request("toplanti_saati"))
            katilimcilar = trn(request("katilimcilar"))
            toplanti_suresi = trn(request("toplanti_suresi"))
            gundem = trn(request("gundem"))
            etiketler = trn(request("etiketler"))
            durum = "true"
            cop = "false"
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")



            SQL="update ahtapot_toplanti_kaydi set toplanti_adi= '" & toplanti_adi & "',  toplanti_tipi= '" & toplanti_tipi & "',  yineleme_donemi= '" & yineleme_donemi & "',  gunluk_yineleme_secim= '" & gunluk_yineleme_secim & "',  gunluk_yineleme_gun_aralik= '" & gunluk_yineleme_gun_aralik & "',  haftalik_yineleme_sikligi= '" & haftalik_yineleme_sikligi & "',  gunler= '" & gunler & "',  aylik_yenileme_tipi= '" & aylik_yenileme_tipi & "',  aylik_gun= '" & aylik_gun & "',  aylik_aralik= '" & aylik_aralik & "',  aylik_yineleme1= '" & aylik_yineleme1 & "',  aylik_yineleme2= '" & aylik_yineleme2 & "',  aylik_yineleme3= '" & aylik_yineleme3 & "',  yineleme_baslangic= '" & yineleme_baslangic & "',  yineleme_bitis= '" & yineleme_bitis & "',  toplanti_tarihi= '" & toplanti_tarihi & "',  toplanti_saati= '" & toplanti_saati & "',  katilimcilar= '" & katilimcilar & "',  toplanti_suresi= '" & toplanti_suresi & "',  gundem= '" & gundem & "',  etiketler = '" & etiketler & "' where id = '"& toplanti_kayit_id &"'"
            set ekle = baglanti.execute(SQL)

            SQL="update ahtapot_toplanti_listesi set cop = 'true' where toplanti_kayit_id = '"& toplanti_kayit_id &"'"
            set guncelle = baglanti.execute(SQL)

            if trim(toplanti_tipi) = "gundeme_ozel" then

                toplanti_sira = 1
                toplanti_tarihi = toplanti_tarihi
                toplanti_saati = toplanti_saati

                SQL="insert into ahtapot_toplanti_listesi(toplanti_kayit_id, toplanti_sira, toplanti_tarihi, toplanti_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('" & toplanti_kayit_id & "', '" & toplanti_sira & "', '" & toplanti_tarihi & "', '" & toplanti_saati & "', '" & durum & "', '" & cop & "', '" & firma_kodu & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate())"
                set ekle = baglanti.execute(SQL)

            elseif trim(toplanti_tipi) = "rutin" then



                yineleme_baslangic = cdate(yineleme_baslangic)
                yineleme_bitis = cdate(yineleme_bitis)

                if trim(yineleme_donemi) = "gunluk" then

                    if trim(gunluk_yineleme_secim)="gunluk" then

                        y = 0
                        for x = cdate(yineleme_baslangic) to cdate(yineleme_bitis) step cint(gunluk_yineleme_gun_aralik)

                            y = y + 1
                            toplanti_sira = y
                            toplanti_tarihi = cdate(x)
                            toplanti_saati = toplanti_saati

                            SQL="insert into ahtapot_toplanti_listesi(toplanti_kayit_id, toplanti_sira, toplanti_tarihi, toplanti_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('" & toplanti_kayit_id & "', '" & toplanti_sira & "', '" & toplanti_tarihi & "', '" & toplanti_saati & "', '" & durum & "', '" & cop & "', '" & firma_kodu & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate())"
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

                                SQL="insert into ahtapot_toplanti_listesi(toplanti_kayit_id, toplanti_sira, toplanti_tarihi, toplanti_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('" & toplanti_kayit_id & "', '" & toplanti_sira & "', '" & toplanti_tarihi & "', '" & toplanti_saati & "', '" & durum & "', '" & cop & "', '" & firma_kodu & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate())"
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

                                SQL="insert into ahtapot_toplanti_listesi(toplanti_kayit_id, toplanti_sira, toplanti_tarihi, toplanti_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('" & toplanti_kayit_id & "', '" & toplanti_sira & "', '" & toplanti_tarihi & "', '" & toplanti_saati & "', '" & durum & "', '" & cop & "', '" & firma_kodu & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate())"
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

                                    SQL="insert into ahtapot_toplanti_listesi(toplanti_kayit_id, toplanti_sira, toplanti_tarihi, toplanti_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('" & toplanti_kayit_id & "', '" & toplanti_sira & "', '" & toplanti_tarihi & "', '" & toplanti_saati & "', '" & durum & "', '" & cop & "', '" & firma_kodu & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate())"
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

                                            SQL="insert into ahtapot_toplanti_listesi(toplanti_kayit_id, toplanti_sira, toplanti_tarihi, toplanti_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('" & toplanti_kayit_id & "', '" & toplanti_sira & "', '" & toplanti_tarihi & "', '" & toplanti_saati & "', '" & durum & "', '" & cop & "', '" & firma_kodu & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate())"
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

                                            SQL="insert into ahtapot_toplanti_listesi(toplanti_kayit_id, toplanti_sira, toplanti_tarihi, toplanti_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('" & toplanti_kayit_id & "', '" & toplanti_sira & "', '" & toplanti_tarihi & "', '" & toplanti_saati & "', '" & durum & "', '" & cop & "', '" & firma_kodu & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate())"
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

                                                SQL="insert into ahtapot_toplanti_listesi(toplanti_kayit_id, toplanti_sira, toplanti_tarihi, toplanti_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('" & toplanti_kayit_id & "', '" & toplanti_sira & "', '" & toplanti_tarihi & "', '" & toplanti_saati & "', '" & durum & "', '" & cop & "', '" & firma_kodu & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate())"
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

                                                SQL="insert into ahtapot_toplanti_listesi(toplanti_kayit_id, toplanti_sira, toplanti_tarihi, toplanti_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('" & toplanti_kayit_id & "', '" & toplanti_sira & "', '" & toplanti_tarihi & "', '" & toplanti_saati & "', '" & durum & "', '" & cop & "', '" & firma_kodu & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate())"
                                                set ekle = baglanti.execute(SQL)

                                            end if
                                        end if
                                    next

                                end if
                            end if
                        end if

                end if

            end if

%>
<script>
        $(function () {
            var newcs = $('#new-cons').DataTable();
            new $.fn.dataTable.Responsive(newcs);
            $(".dataTables_length").hide();

            setTimeout(function () {
                $(".yetmislik").addClass("form-control");
            },500);

        });
</script>
<%
    ay = trn(request("ay"))
    yil = trn(request("yil"))
%>


<div class="card-header">
    <h5 id="toplanti_baslik" ay="<%=ay %>" yil="<%=yil %>" class="m-b-10" style="font-size: 1.25em;"><%=monthname(ay) %>&nbsp;<%=yil %> <%=LNG("Toplantı Listesi")%></h5>
    <div style="float: right; margin-right: 15px; margin-bottom: -20px;">
        <a href="javascript:void(0);" onclick="yeni_toplanti_planla();" class="btn btn-success btn-round"><i class="fa  fa-cube"></i>&nbsp;<%=LNG("Yeni Toplantı Planla")%></a>
    </div>
</div>
<div class="card-block">
    <div class="dt-responsive table-responsive">
        <table id="new-cons" class="table table-striped table-bordered nowrap">
            <thead>
                <tr>
                    <th><%=LNG("Toplantı Adı")%></th>
                    <th style="text-align: center;"><%=LNG("Katılımcılar")%></th>
                    <th style="text-align: center;"><%=LNG("Etiketler")%></th>
                    <th style="text-align: center;"><%=LNG("Durum")%></th>
                    <th style="text-align: center;"><%=LNG("Tarih Saat")%></th>
                    <th style="text-align: center;"><%=LNG("Süre")%></th>
                    <th style="width: 105px; text-align: center;"><%=LNG("İşlem")%></th>
                </tr>
            </thead>
            <tbody>
                <%
      

                SQL="select convert(datetime, toplanti.toplanti_tarihi) + convert(datetime, toplanti.toplanti_saati) as toplanti_zamani, toplanti.*, kayit.toplanti_adi, kayit.toplanti_suresi, (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(kayit.katilimcilar, ',') WHERE value =  kullanici.id ) > 0 for xml path('')) as katilimcilar, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(kayit.etiketler, '') + ',')>0 for xml path(''))), 1, 1, '') as etiketler from ahtapot_toplanti_listesi toplanti join ahtapot_toplanti_kaydi kayit on kayit.id = toplanti.toplanti_kayit_id where toplanti.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and toplanti.cop = 'false' and month(toplanti.toplanti_tarihi) = '"& ay &"' and year(toplanti.toplanti_tarihi) = '"& yil &"' order by convert(datetime, toplanti.toplanti_tarihi) + convert(datetime, toplanti.toplanti_saati) asc"
                set toplanti = baglanti.execute(SQL)
                if toplanti.eof then
                %>
                <tr>
                    <td colspan="7" style="text-align: center;"><%=LNG("Toplantı Kaydı Bulunamadı")%></td>
                </tr>
                <% end if 
                 on error resume next
                                
                
               do while not toplanti.eof
                %>
                <tr>
                    <td><%=toplanti("toplanti_adi") %></td>
                    <td class="tablo_gorevliler">
                        <div style="width: 107px;">
                            <div class="project-members">
                                <% if isnull(toplanti("katilimcilar"))=false then %>
                                <%
                                for x = 0 to ubound(split(toplanti("katilimcilar"),"|"))-1
                                    katilimci = split(toplanti("katilimcilar"),"|")(x)
                                %>
                                <a rel="tooltip" data-toggle="tooltip" data-html="true" data-original-title="<img src='<%=split(katilimci, "~")(1) %>' alt='<%=split(katilimci, "~")(2) %>' class='online' style='width:75px;'><br><%=split(katilimci, "~")(2) %>" data-placement="top" href="javascript:void(0)">
                                    <img src="<%=split(katilimci, "~")(1) %>" class="online"></a>&nbsp;
                            <% next %>
                                <% end if %>
                            </div>
                        </div>
                    </td>
                    <td class="tablo_etiketler">
                        <div>
                            <% 
                               
                                for x = 0 to ubound(split(toplanti("etiketler"),"~")) %>
                            <%=split(toplanti("etiketler"), "~")(x) %><br>
                            <% next %>
                        </div>
                    </td>
                    <td class="tablo_oncelik <% if trim(toplanti("durum"))="iptal" then %> label-danger <% elseif cdate(toplanti("toplanti_zamani"))<now() then %> label-success <% else %> label-warning <% end if %>">
                        <span class="label  <% if trim(toplanti("durum"))="iptal" then %> label-danger <% elseif cdate(toplanti("toplanti_zamani"))<now() then %> label-success <% else %> label-warning <% end if %> arkaplansiz" style="font-size: 11px; color: white; text-align: center;"><% if trim(toplanti("durum"))="iptal" then %> <%=LNG("İPTAL")%> <% elseif cdate(toplanti("toplanti_zamani"))<now() then %> <%=LNG("GERÇEKLEŞTİ")%> <% else %> <%=LNG("BEKLİYOR")%> <% end if %></span>
                    </td>
                    <td class="tablo_baslangic">
                        <div style="font-size: 13px;">
                            <%=day(cdate(toplanti("toplanti_tarihi"))) %>&nbsp;<%=monthname(month(cdate(toplanti("toplanti_tarihi")))) %>&nbsp;<%=year(cdate(toplanti("toplanti_tarihi"))) %><br />
                            <%=weekdayname(weekday(cdate(toplanti("toplanti_tarihi")))) %>&nbsp;<%=left(toplanti("toplanti_saati"),5) %>
                        </div>
                    </td>
                    <td style="text-align: center;">
                        <span class="label label-inverse" style="font-size: 20px; font-weight: bold;"><%=left(toplanti("toplanti_suresi"),5) %></span>
                    </td>

                    <td>
                        <div style="width: 150px; margin-left: auto; margin-right: auto;">
                            <div class="btn-group dropdown-split-primary">
                                <button type="button" onclick="sayfagetir('/toplanti_detay/','jsid=4559&toplanti_id=<%=toplanti("id") %>');" class="btn btn-mini btn-primary"><i class="icofont icofont-exchange"></i><%=LNG("İşlemler")%></button>
                                <button type="button" class="btn btn-mini btn-primary dropdown-toggle dropdown-toggle-split waves-effect waves-light" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <span class="sr-only"><%=LNG("İşlemler")%></span>
                                </button>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item waves-effect waves-light" href="javascript:void(0);" onclick="sayfagetir('/toplanti_detay/','jsid=4559&toplanti_id=<%=toplanti("id") %>');"><%=LNG("Toplantı Detayları")%></a>
                                    <a class="dropdown-item waves-effect waves-light" href="javascript:void(0);" onclick="toplanti_duzenle('<%=toplanti("toplanti_kayit_id") %>');"><%=LNG("Toplantı Düzenle")%></a>
                                    <a class="dropdown-item waves-effect waves-light" href="#"><%=LNG("Gündem Ekle")%></a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item waves-effect waves-light" href="javascript:void(0);" onclick="toplanti_iptal_et(<%=toplanti("id") %>);"><%=LNG("İptal Et")%></a>
                                    <a class="dropdown-item waves-effect waves-light" href="javascript:void(0);" onclick="toplanti_sil(<%=toplanti("id") %>);"><%=LNG("Sil")%></a>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <%
                toplanti.movenext
                loop
                %>
            </tbody>
        </table>
    </div>
</div>

<%

 elseif trn(request("islem"))="toplanti_gundem_listesi" then

        toplanti_id = trn(request("toplanti_id"))

%>
<div class="card">
    <div class="card-header">
        <h5 class="m-b-10" style="font-size: 1.25em;"><%=LNG("Gündem Listesi")%></h5>
        <div style="float: right; margin-right: 15px;">
            <a href="javascript:void(0);" onclick="toplanti_gundem_ekle(<%=toplanti_id %>);" class="btn btn-mini btn-success btn-round"><i class="fa  fa-cube"></i>&nbsp;<%=LNG("Gündem Ekle")%></a>
        </div>
    </div>
    <div class="card-block">
        <div class="view-info">
            <div class="row">
                <div class="col-lg-12">
                    <div id="gundem_listesi">
                        <script>
                            $(function (){
                                toplanti_gundem_listesi_getir('<%=toplanti_id %>');
                            });
                        </script>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%
 elseif trn(request("islem"))="toplanti_not_listesi" then

        toplanti_id = trn(request("toplanti_id"))

%>
<script src="/files/assets/pages/store-js/note.js"></script>
<%
    SQL="select nots.*, kullanici.personel_ad + ' ' + kullanici.personel_soyad as personel from ahtapot_toplanti_not_listesi nots join ucgem_firma_kullanici_listesi kullanici on kullanici.id = nots.ekleyen_id where nots.toplanti_id = '"& toplanti_id &"'"
    set notlar = baglanti.execute(SQL)
    do while not notlar.eof
%>
<input type="hidden" class="notlar" ekleyen="<%=notlar("personel") %>" baslik="<%=notlar("icerik") %>" icerik="<%=notlar("icerik") %>" yil="<%=year(cdate(notlar("ekleme_tarihi"))) %>" ay="<%=cint(month(cdate(notlar("ekleme_tarihi"))))-1 %>" gun="<%=cint(day(cdate(notlar("ekleme_tarihi")))) %>" saat="<%=cint(left(notlar("ekleme_saati"),2)) %>" dakika="<%=cint(mid(notlar("ekleme_saati"),4,2)) %>" />
<%
    notlar.movenext
    loop
%>
<div class="card">
    <div class="card-header">
        <h5 class="card-header-text"><%=LNG("Notlar")%></h5>
        <button id="edit-btn" type="button" class="btn btn-sm btn-primary waves-effect waves-light f-right" style="display: none;">
            <i class="icofont icofont-edit"></i>
        </button>
    </div>
    <div class="card-block">
        <div class="view-info">
            <div class="row">
                <div class="col-lg-12">
                    <div>
                        <div class="card-block note-card">
                            <div class="note-box-wrapper row">
                                <div class="note-box-aside col-lg-12 col-xl-3">
                                    <div class="row">
                                        <div class="col-2">
                                            <h5><i class="icofont icofont-file-text m-r-5"></i></h5>
                                        </div>
                                        <div class="col-10">
                                            <input class="form-control form-control-lg" type="text" id="Note-search" placeholder="Not Ara">
                                        </div>
                                    </div>
                                    <div class="notes-list">
                                        <ul id="Note-list" class="Note-list list-group"></ul>
                                    </div>
                                </div>
                                <div class="note-box-content col-lg-12 col-xl-9">
                                    <div class="Note-header">
                                        <div class="Note-created f-right">
                                            <span class="Note-created__on"><%=LNG("Oluşturma Tarihi")%></span>
                                            <span class="Note-created__date" id="Note-created__date"></span>
                                        </div>
                                        <a href="#" class="btn btn-md btn-primary hidden-xs Note-add"><%=LNG("+ Yeni Not Ekle")%></a>
                                    </div>
                                    <div class="note-body">
                                        <div class="note-write">
                                            <textarea id="Note-pad" class="form-control" placeholder="<%=LNG("Notunuzu Buraya Yazın")%>" rows="10"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%
 elseif trn(request("islem"))="toplanti_karar_listesi" then

        toplanti_id = trn(request("toplanti_id"))

%>
<div class="card">
    <div class="card-header">
        <h5 class="card-header-text"><%=LNG("Kararlar Listesi")%></h5>
        <button id="edit-btn" type="button" onclick="toplanti_karar_ekle('<%=toplanti_id %>');" class="btn btn-rnd btn-sm btn-primary waves-effect waves-light f-right">
            <i class="icofont icofont-edit"></i><%=LNG("Karar Ekle")%>
        </button>
    </div>
    <div class="card-block">
        <div class="view-info">
            <div class="row">
                <div class="col-lg-12">
                    <div>


                        <div class="main-timeline" style="background-color: white;">
                            <div id="karar_listesi" class="cd-timeline cd-container">
                                <script>
                                    $(function (){
                                        toplanti_karar_listesi_getir('<%=toplanti_id %>');
                                    });
                                </script>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%
 elseif trn(request("islem"))="toplanti_is_listesi" then

        toplanti_id = trn(request("toplanti_id"))

%>
<input type="hidden" name="toplantimi" id="toplantimi" value="true" toplanti_id="<%=toplanti_id %>" />
<div class="card">
    <div class="card-header">
        <h5 class="card-header-text"><%=LNG("İş Listesi")%></h5>
        <button id="edit-btn" type="button" onclick="etiketli_yeni_is_ekle('toplanti', '<%=toplanti_id %>');" class="btn btn-sm btn-primary waves-effect waves-light f-right">
            <i class="fa  fa-cube"></i>&nbsp;<%=LNG("Yeni İş Ekle")%>
        </button>
    </div>
    <div class="card-block">
        <div class="view-info">
            <div class="row">
                <div class="col-lg-12">
                    <div id="tum_isler"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<%
    elseif trn(request("islem"))="gundem_ekle" then

        toplanti_id = trn(request("toplanti_id"))
        if trim(request("islem2"))="ekle" then

            gundem = trn(request("gundem"))

            durum = "true"
            cop = "false"
            firma_kodu = request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")

            SQL="insert into ahtapot_toplanti_gundem_listesi(toplanti_id, gundem, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('" & toplanti_id & "', N'" & gundem & "', '" & durum & "', '" & cop & "', '" & firma_kodu & "', '" & firma_id & "', '" & ekleyen_id & "', '" & ekleyen_ip & "', getdate(), getdate())"
            set ekle = baglanti.execute(SQL)

        elseif trn(request("islem2"))="guncelle" then

            gundem_id = trn(request("gundem_id"))
            gundem = trn(request("gundem"))

            SQL="update ahtapot_toplanti_gundem_listesi set gundem = N'"& gundem &"' where id = '"& gundem_id &"'"
            set guncelle = baglanti.execute(SQL)

        elseif trn(request("islem2"))="sil" then

            gundem_id = trn(request("gundem_id"))

            SQL="update ahtapot_toplanti_gundem_listesi set cop = 'true' where id = '"& gundem_id &"'"
            set guncelle = baglanti.execute(SQL)

        elseif trn(request("islem2"))="iptal" then

            gundem_id = trn(request("gundem_id"))

            SQL="update ahtapot_toplanti_gundem_listesi set durum = case when durum = 'true' then 'false' else 'true' end where id = '"& gundem_id &"'"
            set guncelle = baglanti.execute(SQL)

        end if

%>

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
<table id="new-cons" class="table table-striped table-bordered nowrap">
    <thead>
        <tr>
            <th><%=LNG("Gündem")%></th>
            <th style="width: 120px; text-align: center;"><%=LNG("Ekleyen")%></th>
            <th style="width: 120px; text-align: center;"><%=LNG("Ekleme Tarihi")%></th>
            <th style="text-align: center; width: 150px;"><%=LNG("Durum")%></th>
            <th style="width: 150px; text-align: center;"><%=LNG("İşlem")%></th>
        </tr>
    </thead>
    <tbody>
        <%
            SQL="select toplanti_kayit_id from ahtapot_toplanti_listesi where id = '"& toplanti_id &"';"
            set toplanti = baglanti.execute(SQL)

            SQL="select gundem.*, kullanici.personel_ad + ' ' + kullanici.personel_soyad as personel from ahtapot_toplanti_gundem_listesi gundem join ucgem_firma_kullanici_listesi kullanici on kullanici.id = gundem.ekleyen_id where gundem.toplanti_id = '"& toplanti_id &"' and gundem.cop = 'false' order by gundem.id asc"
            set gundem = baglanti.execute(SQL)
            if gundem.eof then
        %>
        <tr>
            <td colspan="5" style="text-align: center;"><%=LNG("Tanımlanan gündem kaydı bulunamadı.")%></td>
        </tr>
        <%
            end if

            do while not gundem.eof
        %>
        <tr>
            <td style="vertical-align: middle;"><%=gundem("gundem") %></td>
            <td style="text-align: center; vertical-align: middle;"><%=gundem("personel") %></td>
            <td style="text-align: center; vertical-align: middle;"><%=cdate(gundem("ekleme_tarihi")) %>&nbsp;<%=left(gundem("ekleme_saati"),5) %></td>
            <td style="text-align: center; vertical-align: middle;">
                <% if trim(gundem("durum"))="false" then %>
                <span class="label label-danger"><%=LNG("İptal Edildi")%></span>
                <% elseif trim(gundem("durum"))="karar" then %>
                <span class="label label-success"><%=LNG("Karara Bağlandı")%></span>
                <% else %>
                <span class="label label-info"><%=LNG("Beklemede")%></span>
                <% end if %>
            </td>
            <td style="text-align: center; vertical-align: middle;">
                <div class="btn-group dropdown-split-primary">
                    <button type="button" class="btn btn-mini btn-primary"><i class="icofont icofont-exchange"></i><%=LNG("İşlemler")%></button>
                    <button type="button" class="btn btn-primary btn-mini dropdown-toggle dropdown-toggle-split waves-effect waves-light" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span class="sr-only"><%=LNG("İşlemler")%></span>
                    </button>
                    <div class="dropdown-menu">
                        <a class="dropdown-item waves-effect waves-light" onclick="gundem_baglantili_is_ekle('<%=toplanti("toplanti_kayit_id") %>', '<%=toplanti_id %>', '<%=gundem("id") %>');" href="javascript:void(0);"><%=LNG("Bağlantılı İş Ekle")%></a>
                        <a class="dropdown-item waves-effect waves-light" href="javascript:void(0);" onclick="gundem_karar_ekle('<%=toplanti_id %>', '<%=gundem("id") %>');"><%=LNG("Karar Ekle")%></a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item waves-effect waves-light" href="javascript:void(0);" onclick="gundem_duzenle('<%=toplanti_id %>', '<%=gundem("id") %>');"><%=LNG("Düzenle")%></a>
                        <a class="dropdown-item waves-effect waves-light" href="javascript:void(0);" onclick="gundem_iptal_et('<%=toplanti_id %>','<%=gundem("id") %>', '<%=gundem("durum") %>');"><% if trim(gundem("durum"))="false" then %><%=LNG("Aktif Et")%><% else %><%=LNG("İptal Et")%><% end if %></a>
                        <a class="dropdown-item waves-effect waves-light" href="javascript:void(0);" onclick="gundem_sil('<%=toplanti_id %>', '<%=gundem("id") %>');"><%=LNG("Sil")%></a>
                    </div>
                </div>
            </td>
        </tr>
        <%
            gundem.movenext
            loop
        %>
    </tbody>
</table>
<%
    elseif trn(request("islem"))="toplanti_not_guncelle" then

        toplanti_id = trn(request("toplanti_id"))
        notlar = trn(HTMLDecode((request("notlar"))))

        SQL="delete from ahtapot_toplanti_not_listesi where toplanti_id = '"& toplanti_id &"' and firma_id = '"& Request.Cookies("kullanici")("firma_id") &"'"
        set guncelle = baglanti.execute(SQL)

        for x = 0 to ubound(split(notlar, "|"))-1
            
            if len(split(notlar, "|")(x))>0 then

                baslik = split(split(notlar, "|")(x), "~")(0)
                icerik = split(split(notlar, "|")(x), "~")(1)

                durum = "true"
                cop = "false"
                firma_kodu = Request.Cookies("kullanici")("firma_kodu")
                firma_id = Request.Cookies("kullanici")("firma_id")
                ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
                ekleyen_ip = Request.ServerVariables("Remote_Addr")

                SQL="insert into ahtapot_toplanti_not_listesi(toplanti_id, baslik, icerik, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& toplanti_id &"', left('"& baslik &"',100), N'"&icerik &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate())"
                set guncelle = baglanti.execute(SQL)
            end if

        next

    elseif trn(request("islem"))="toplanti_karar_ekle" then

        toplanti_id = trn(request("toplanti_id"))

%>
<div class="modal-header">
    <%=LNG("Karar Ekle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_karar_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Etiketler :")%></label>
        <div class="col-sm-12">
            <select class="select2" name="etiketler" id="etiketler" multiple="multiple">
                <%
                    songrup = ""
                    SQL="select * from etiketler etiket with(nolock) where etiket.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' order by grup, adi asc;"
                    set etiketler = baglanti.execute(SQL)
                    do while not etiketler.eof
                        if not trim(songrup) = trim(etiketler("grup")) then
                            if not songrup = "" then
                %>
                            </optgroup>
                            <% end if %>
                <optgroup label="<%=etiketler("grup") %>">
                    <%
                            songrup = etiketler("grup")
                        end if
                    %>
                    <option value="<%=etiketler("tip") %>-<%=etiketler("id") %>"><%=etiketler("adi") %></option>
                    <%
                    etiketler.movenext
                    loop
                    %>
                </optgroup>
            </select>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Karar")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <textarea id="karar" name="karar" class="required form-control" style="width: 93%; padding-left: 35px; padding-top: 6px;" required></textarea>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            setTimeout(function () { $("#karar").focus() }, 1500);
            autosize($("#karar"));
        });
    </script>
    <div class="modal-footer">
        <input type="button" onclick="toplanti_karar_ekle2(this, '<%=toplanti_id%>');" class="btn btn-primary" value="Yeni Karar Ekle" />
    </div>
</form>
<%
    elseif trn(request("islem"))="toplanti_karar_listesi2" then

        toplanti_id = trn(request("toplanti_id"))

        if trn(request("islem2"))="ekle" then

            karar = trn(HTMLDecode(urldecodes(request("karar"))))
            etiketler = trn(request("etiketler"))

            durum = "true"
            cop = "false"
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = request.ServerVariables("Remote_Addr")


            SQL="insert into ahtapot_toplanti_karar_listesi(toplanti_id, etiketler, karar, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values('"& toplanti_id &"', '"& etiketler &"', N'"& karar &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', getdate(), getdate())"
            set ekle = baglanti.execute(SQL)

        elseif trn(request("islem2"))="guncelle" then

            karar_id = trn(request("karar_id"))

            karar = trn(HTMLDecode(urldecodes(request("karar"))))
            etiketler = trn(request("etiketler"))

            SQL="update ahtapot_toplanti_karar_listesi set karar = N'"& karar &"', etiketler = '"& etiketler &"' where id = '"& karar_id &"'"
            set guncelle = baglanti.execute(SQL)

        elseif trn(request("islem2"))="sil" then

            karar_id = trn(request("karar_id"))

            SQL="update ahtapot_toplanti_karar_listesi set cop = 'true' where id = '"& karar_id &"'"
            set guncelle = baglanti.execute(SQL)

        end if


        SQL="select karar.*, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(karar.etiketler, '') + ',')>0 for xml path(''))), 1, 1, '') as etiketler, kullanici.personel_ad + ' ' + kullanici.personel_soyad as personel from ahtapot_toplanti_karar_listesi karar join ucgem_firma_kullanici_listesi kullanici on kullanici.id = karar.ekleyen_id where karar.toplanti_id = '"& toplanti_id &"' and karar.cop = 'false' order by karar.id asc"
        set karar = baglanti.execute(SQL)
        if karar.eof then
%><br />
<br />
<div style="width: 300px; margin-top: -120px; margin-left: auto; margin-right: auto;"><%=LNG("Toplantıyla ilişkili karar kaydı bulunamadı.")%></div>
<br />
<br />
<%

        end if

    on error resume next
        do while not karar.eof
%>
<div class="cd-timeline-block">
    <div class="cd-timeline-icon bg-primary">
        <i class="icofont icofont-ui-file"></i>
    </div>
    <div class="cd-timeline-content card_main z-depth-top-0">
        <div class="p-20">
            <h6><%=replace(karar("etiketler"), "~", " - ") %></h6>
            <div class="timeline-details">
                <a href="#"><i class="icofont icofont-ui-calendar"></i><span><%=day(cdate(karar("ekleme_tarihi"))) %>&nbsp;<%=monthname(month(cdate(karar("ekleme_tarihi")))) %>&nbsp;<%=year(cdate(karar("ekleme_tarihi"))) %>&nbsp;<%=weekdayname(weekday(cdate(karar("ekleme_tarihi")))) %>&nbsp;<%=left(karar("ekleme_saati"),5) %></span> </a>
                <a href="#">
                    <i class="icofont icofont-ui-user"></i><span><%=karar("personel") %></span>
                </a>
                <p class="m-t-20"><%=karar("karar") %></p>
            </div>
            <div style="margin: 15px; margin-right: 0;">
                <input type="button" class="btn btn-rnd btn-mini btn-danger" onclick="toplanti_karar_sil('<%=toplanti_id%>', '<%=karar("id")%>');" style="float: right; margin: 5px;" value="<%=LNG("Sil")%>" /><input type="button" class="btn btn-rnd btn-mini btn-info" style="float: right; margin: 5px;" onclick="toplanti_karar_duzenle('<%=toplanti_id%>', '<%=karar("id")%>');" value="<%=LNG("Güncelle")%>" />
            </div>
        </div>
        <span class="cd-date"><%=day(cdate(karar("ekleme_tarihi"))) %>&nbsp;<%=monthname(month(cdate(karar("ekleme_tarihi")))) %>&nbsp;<%=year(cdate(karar("ekleme_tarihi"))) %>&nbsp;<%=weekdayname(weekday(cdate(karar("ekleme_tarihi")))) %>&nbsp;<%=left(karar("ekleme_saati"),5) %></span>
        <span class="cd-details"><%=replace(karar("etiketler"), "~", " - ") %></span>

    </div>
</div>
<%
        karar.movenext
        loop

    elseif trn(request("islem"))="toplanti_karar_duzenle" then

        toplanti_id = trn(request("toplanti_id"))
        karar_id = trn(request("karar_id"))

        SQL="select * from ahtapot_toplanti_karar_listesi where id = '"& karar_id &"'"
        set karar = baglanti.execute(SQL)

%>
<div class="modal-header">
    <%=LNG("Karar Güncelle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_karar_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Etiketler :")%></label>
        <div class="col-sm-12">
            <select class="select2" name="etiketler" id="etiketler" multiple="multiple">
                <%
                    songrup = ""
                    SQL="select * from etiketler etiket with(nolock) where etiket.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' order by grup, adi asc;"
                    set etiketler = baglanti.execute(SQL)
                    do while not etiketler.eof
                        if not trim(songrup) = trim(etiketler("grup")) then
                            if not songrup = "" then
                %>
                            </optgroup>
                            <% end if %>
                <optgroup label="<%=etiketler("grup") %>">
                    <%
                            songrup = etiketler("grup")
                        end if
                    %>
                    <option <% if instr("," & karar("etiketler") & ",", "," & etiketler("tip") & "-" & etiketler("id") & ",")>0 then %> selected="selected" <% end if %> value="<%=etiketler("tip") %>-<%=etiketler("id") %>"><%=etiketler("adi") %></option>
                    <%
                    etiketler.movenext
                    loop
                    %>
                </optgroup>
            </select>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Karar")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <textarea id="karar" name="karar" class="required form-control" style="width: 93%; padding-left: 35px; padding-top: 6px;" required><%=karar("karar") %></textarea>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            setTimeout(function () { $("#karar").focus() }, 1500);
            autosize($("#karar"));
        });
    </script>
    <div class="modal-footer">
        <input type="button" onclick="toplanti_karar_guncelle(this, '<%=toplanti_id%>', '<%=karar("id") %>');" class="btn btn-primary" value="<%=LNG("Kararı Güncelle")%>" />
    </div>
</form>
<%

    elseif trn(request("islem"))="toplanti_gundem_ekle" then

        toplanti_id = trn(request("toplanti_id"))
%>

<div class="modal-header">
    <%=LNG("Tahslat Ekle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_tahsilat_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Tahsilat Tipi")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <textarea id="gundem" name="gundem" class="required form-control" style="width: 93%; padding-left: 35px; padding-top: 6px;" required></textarea>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            setTimeout(function () { $("#gundem").focus() }, 1500);
            autosize($("#gundem"));
        });
    </script>
    <div class="modal-footer">
        <input type="button" onclick="gundem_ekle(this, '<%=toplanti_id%>');" class="btn btn-primary" value="<%=LNG("Yeni Gündem Ekle")%>" />
    </div>
</form>

<%
    elseif trn(request("islem"))="cari_hareket_tahsilat_ekle" then

        cari_id = trn(request("cari_id"))
        yer = trn(request("yer"))
        tip = trn(request("tip"))
%>

<div class="modal-header">
    <%=LNG("Tahsilat Ekle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_tahsilat_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <div class="col-sm-12">
            <table>
                <tr>
                    <td>
                        <input type="radio" class="tahsilat_tipi" name="tahsilat_tipi" id="tahsilat_tipi1" onclick="tahsilat_tipi_sectim(this);" value="Nakit" checked="checked" /></td>
                    <td>
                        <label for="tahsilat_tipi1" style="cursor: pointer;"><%=LNG("Nakit Tahsilat")%></label></td>
                    <td style="padding-left: 15px;">
                        <input type="radio" class="tahsilat_tipi" name="tahsilat_tipi" id="tahsilat_tipi2" onclick="tahsilat_tipi_sectim(this);" value="Çek" /></td>
                    <td>
                        <label for="tahsilat_tipi2" style="cursor: pointer;"><%=LNG("Çek Tahsilat")%></label></td>
                </tr>
            </table>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Tarih")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" name="islem_tarihi" id="islem_tarihi" value="<%=cdate(date) %>" required class="required form-control takvimyap" />
            </div>
        </div>
    </div>

    <div class="row vade_tarihi_yeri" style="display: none;">
        <label class="col-sm-12 col-form-label"><%=LNG("Vade Tarihi")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" name="vade_tarihi" id="vade_tarihi" required value="<%=cdate(date) %>" class="form-control takvimyap required" />
            </div>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Meblağ")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" name="meblag" id="meblag" required class="form-control regexonly required" />
            </div>

        </div>
    </div>
    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Para birimi :")%></label>
        <div class="col-sm-12">
            <select class="select2" name="parabirimi" id="parabirimi">
                <option value="TL">TL</option>
                <option value="USD">USD</option>
                <option value="EUR">EUR</option>
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
                <textarea id="aciklama" name="aciklama" class=" form-control" style="width: 93%; padding-left: 35px; padding-top: 6px;"></textarea>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            setTimeout(function () { $("#meblag").focus() }, 1500);
            autosize($("#aciklama"));
        });
    </script>

    <div class="modal-footer">
        <input type="button" onclick="tahsilat_kaydet(this, '<%=cari_id%>', '<%=tip%>', '<%=yer %>');" class="btn btn-primary" value="<%=LNG("Yeni Tahsilat Ekle")%>" />
    </div>
</form>
<%
    elseif trn(request("islem"))="cari_hareket_odeme_ekle" then

        cari_id = trn(request("cari_id"))
        yer = trn(request("yer"))
        tip = trn(request("tip"))

%>

<div class="modal-header">
    <%=LNG("Ödeme Ekle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_odeme_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <div class="col-sm-12">
            <table>
                <tr>
                    <td>
                        <input type="radio" class="odeme_tipi" name="odeme_tipi" id="odeme_tipi1" onclick="odeme_tipi_sectim(this);" value="Nakit" checked="checked" /></td>
                    <td>
                        <label for="odeme_tipi1" style="cursor: pointer;"><%=LNG("Nakit Ödeme")%></label></td>
                    <td style="padding-left: 15px;">
                        <input type="radio" class="odeme_tipi" name="odeme_tipi" id="odeme_tipi2" onclick="odeme_tipi_sectim(this);" value="Çek" /></td>
                    <td>
                        <label for="odeme_tipi2" style="cursor: pointer;"><%=LNG("Çek Ödeme")%></label></td>
                </tr>
            </table>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("İşlem Tarihi")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" name="islem_tarihi" id="islem_tarihi" value="<%=cdate(date) %>" required class="form-control takvimyap required" />
            </div>
        </div>
    </div>

    <div class="row vade_tarihi_yeri" style="display: none;">
        <label class="col-sm-12 col-form-label"><%=LNG("Vade Tarihi")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" name="vade_tarihi" id="vade_tarihi" value="<%=cdate(date) %>" required class="form-control takvimyap required" />
            </div>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Meblağ")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" name="meblag" id="meblag" required class="form-control regexonly required" />
            </div>

        </div>
    </div>
    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Para birimi :")%></label>
        <div class="col-sm-12">
            <select class="select2" name="parabirimi" id="parabirimi">
                <option value="TL">TL</option>
                <option value="USD">USD</option>
                <option value="EUR">EUR</option>
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
                <textarea id="aciklama" name="aciklama" class="form-control" style="width: 93%; padding-left: 35px; padding-top: 6px;"></textarea>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            setTimeout(function () { $("#meblag").focus() }, 1500);
            autosize($("#aciklama"));
        });
    </script>

    <div class="modal-footer">
        <input type="button" onclick="odeme_kaydet(this, '<%=cari_id%>', '<%=tip%>', '<%=yer %>');" class="btn btn-primary" value="<%=LNG("Yeni Ödeme Ekle")%>" />
    </div>
</form>
<%
    elseif trn(request("islem"))="cari_hareket_kaydi_duzenle" then

        cari_id = trn(request("cari_id"))
        tip = trn(request("tip"))
        kayit_id = trn(request("kayit_id"))
        islem_tipi = trn(request("islem_tipi"))
        yer = trn(request("yer"))

        SQL="select * from cari_hareketler where id = '"& kayit_id &"'"
        set cari = baglanti.execute(SQL)

        if trim(islem_tipi)="Ödeme" then
%>

<div class="modal-header">
    <%=LNG("Ödeme Kaydını Düzenle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_odeme_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <div class="col-sm-12">
            <table>
                <tr>
                    <td>
                        <input type="radio" class="odeme_tipi" name="odeme_tipi" id="odeme_tipi1" onclick="odeme_tipi_sectim(this);" value="Nakit" <% if trim(cari("akis_tipi"))="Nakit" then %> checked="checked" <% end if %> /></td>
                    <td>
                        <label for="odeme_tipi1" style="cursor: pointer;"><%=LNG("Nakit Ödeme")%></label></td>
                    <td style="padding-left: 15px;">
                        <input type="radio" class="odeme_tipi" name="odeme_tipi" id="odeme_tipi2" onclick="odeme_tipi_sectim(this);" value="Çek" <% if trim(cari("akis_tipi"))="Çek" then %> checked="checked" <% end if %> /></td>
                    <td>
                        <label for="odeme_tipi2" style="cursor: pointer;"><%=LNG("Çek Ödeme")%></label></td>
                </tr>
            </table>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("İşlem Tarihi")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" name="islem_tarihi" id="islem_tarihi" value="<%=cdate(cari("islem_tarihi")) %>" required class="form-control takvimyap required" />
            </div>
        </div>
    </div>

    <div class="row vade_tarihi_yeri" <% if trim(cari("akis_tipi"))="Nakit" then %> style="display: none;" <% end if %>>
        <label class="col-sm-12 col-form-label"><%=LNG("Vade Tarihi")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" name="vade_tarihi" id="vade_tarihi" value="<%=cdate(cari("vade_tarihi")) %>" required class="form-control takvimyap required" />
            </div>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Meblağ")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" name="meblag" id="meblag" value="<%=cari("meblag") %>" required class="form-control regexonly required" />
            </div>

        </div>
    </div>
    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Para birimi :")%></label>
        <div class="col-sm-12">
            <select class="select2" name="parabirimi" id="parabirimi">
                <option <% if trim(cari("parabirimi"))="TL" then %> selected="selected" <% end if %> value="TL">TL</option>
                <option <% if trim(cari("parabirimi"))="USD" then %> selected="selected" <% end if %> value="USD">USD</option>
                <option <% if trim(cari("parabirimi"))="EUR" then %> selected="selected" <% end if %> value="EUR">EUR</option>
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
                <textarea id="aciklama" name="aciklama" class="form-control" style="width: 93%; padding-left: 35px; padding-top: 6px;"><%=cari("aciklama") %></textarea>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            setTimeout(function () { $("#meblag").focus() }, 1500);
            autosize($("#aciklama"));
        });
    </script>

    <div class="modal-footer">
        <input type="button" onclick="odeme_kaydi_guncelle(this, '<%=cari_id%>', '<%=tip%>', '<%=yer %>', '<%=kayit_id%>');" class="btn btn-primary" value="<%=LNG("Ödeme Kaydını Güncelle")%>" />
    </div>
</form>
<% elseif trim(islem_tipi)="Tahsilat" then %>

<div class="modal-header">
    <%=LNG("Tahsilat Kaydını Güncelle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_odeme_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <div class="col-sm-12">
            <table>
                <tr>
                    <td>
                        <input type="radio" class="tahsilat_tipi" name="tahsilat_tipi" id="tahsilat_tipi1" onclick="tahsilat_tipi_sectim(this);" value="Nakit" <% if trim(cari("akis_tipi"))="Nakit" then %> checked="checked" <% end if %> /></td>
                    <td>
                        <label for="odeme_tipi1" style="cursor: pointer;"><%=LNG("Nakit Tahsilat")%></label></td>
                    <td style="padding-left: 15px;">
                        <input type="radio" class="tahsilat_tipi" name="tahsilat_tipi" id="tahsilat_tipi2" onclick="tahsilat_tipi_sectim(this);" value="Çek" <% if trim(cari("akis_tipi"))="Çek" then %> checked="checked" <% end if %> /></td>
                    <td>
                        <label for="odeme_tipi2" style="cursor: pointer;"><%=LNG("Çek Tahsilat")%></label></td>
                </tr>
            </table>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("İşlem Tarihi")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" name="islem_tarihi" id="islem_tarihi" value="<%=cdate(cari("islem_tarihi")) %>" required class="form-control takvimyap required" />
            </div>
        </div>
    </div>

    <div class="row vade_tarihi_yeri" <% if trim(cari("akis_tipi"))="Nakit" then %> style="display: none;" <% end if %>>
        <label class="col-sm-12 col-form-label"><%=LNG("Vade Tarihi")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" name="vade_tarihi" id="vade_tarihi" value="<%=cdate(cari("vade_tarihi")) %>" required class="form-control takvimyap required" />
            </div>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Meblağ")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <input type="text" name="meblag" id="meblag" value="<%=cari("meblag") %>" required class="form-control regexonly required" />
            </div>

        </div>
    </div>
    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Para birimi :")%></label>
        <div class="col-sm-12">
            <select class="select2" name="parabirimi" id="parabirimi">
                <option <% if trim(cari("parabirimi"))="TL" then %> selected="selected" <% end if %> value="TL">TL</option>
                <option <% if trim(cari("parabirimi"))="USD" then %> selected="selected" <% end if %> value="USD">USD</option>
                <option <% if trim(cari("parabirimi"))="EUR" then %> selected="selected" <% end if %> value="EUR">EUR</option>
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
                <textarea id="aciklama" name="aciklama" class="form-control" style="width: 93%; padding-left: 35px; padding-top: 6px;"><%=cari("aciklama") %></textarea>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            setTimeout(function () { $("#meblag").focus() }, 1500);
            autosize($("#aciklama"));
        });
    </script>

    <div class="modal-footer">
        <input type="button" onclick="tahsilat_kaydi_guncelle(this, '<%=cari_id%>', '<%=tip%>', '<%=yer %>', '<%=kayit_id%>');" class="btn btn-primary" value="<%=LNG("Tahsilat Kaydı Güncelle")%>" />
    </div>
</form>

<%
    end if

    elseif trn(request("islem"))="cari_hareket_listesi" then

        cari_id = trn(request("cari_id"))
        tip = trn(request("tip"))
        yer = trn(request("yer"))

        if trn(request("islem2"))="tahsilat_ekle" then

            yer = trn(request("yer"))
            islem_tarihi = trn(request("islem_tarihi"))
            vade_tarihi = trn(request("vade_tarihi"))
            meblag = trn(request("meblag"))
            parabirimi = trn(request("parabirimi"))
            aciklama = trn(request("aciklama"))
            tahsilat_tipi = trn(request("tahsilat_tipi"))

            islem_saati = time()
            islem_tipi = "Tahsilat"
            akis_tipi = tahsilat_tipi
            meblag = NoktalamaDegis(meblag)
            borclu_id = cari_id
            alacakli_id = Request.Cookies("kullanici")("firma_id")
            borclu_tipi = tip
            alacakli_tipi = "firma"
            usd_kur = CiftParaCevir(1, "USD", "TL")
            eur_kur = CiftParaCevir(1, "EUR", "TL")
            durum = "true"
            cop = "false"
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")


            if isdate(vade_tarihi)=false then
                vade_tarihi = cdate(date)
            end if

            SQL="insert into cari_hareketler(islem_tarihi, islem_saati, aciklama, vade_tarihi, islem_tipi, akis_tipi, meblag, borclu_id, alacakli_id, borclu_tipi, alacakli_tipi, usd_kur, eur_kur, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, parabirimi) values('"& islem_tarihi &"', '"& islem_saati &"', '"& aciklama &"', '"& vade_tarihi &"', '"& islem_tipi &"', '"& akis_tipi &"', '"& meblag &"', '"& borclu_id &"', '"& alacakli_id &"', '"& borclu_tipi &"', '"& alacakli_tipi &"', '"& usd_kur &"', '"& eur_kur &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', '"& ekleme_tarihi &"', '"& ekleme_saati &"', '"& parabirimi &"')"
            set ekle = baglanti.execute(SQL)

        elseif trn(request("islem2"))="sil" then

            kayit_id = trn(request("kayit_id"))

            SQL="update cari_hareketler set cop = 'true', silen_id = '"& Request.Cookies("kullanici")("kullanici_id") &"', silen_ip = '"& Request.ServerVariables("Remote_Addr") &"', silme_tarihi = getdate(), silme_saati = getdate() where id = '"& kayit_id &"'"
            set guncelle = baglanti.execute(SQL)

        elseif trn(request("islem2"))="tahsilat_guncelle" then

            yer = trn(request("yer"))
            islem_tarihi = trn(request("islem_tarihi"))
            vade_tarihi = trn(request("vade_tarihi"))
            meblag = trn(request("meblag"))
            parabirimi = trn(request("parabirimi"))
            aciklama = trn(request("aciklama"))
            akis_tipi = trn(request("tahsilat_tipi"))
            kayit_id = trn(request("kayit_id"))

            if isdate(vade_tarihi)=false then
                vade_tarihi = cdate(date)
            end if
            meblag = NoktalamaDegis(meblag)

            SQL="update cari_hareketler set islem_tarihi = '"& islem_tarihi &"', vade_tarihi = '"& vade_tarihi &"', meblag = '"& meblag &"', parabirimi = '"& parabirimi &"', aciklama = '"& aciklama &"', akis_tipi = '"& akis_tipi &"' where id = '"& kayit_id &"'"
            set guncelle = baglanti.execute(SQL)

        elseif trn(request("islem2"))="odeme_guncelle" then

            yer = trn(request("yer"))
            islem_tarihi = trn(request("islem_tarihi"))
            vade_tarihi = trn(request("vade_tarihi"))
            meblag = trn(request("meblag"))
            parabirimi = trn(request("parabirimi"))
            aciklama = trn(request("aciklama"))
            akis_tipi = trn(request("odeme_tipi"))
            kayit_id = trn(request("kayit_id"))

            if isdate(vade_tarihi)=false then
                vade_tarihi = cdate(date)
            end if
            meblag = NoktalamaDegis(meblag)

            SQL="update cari_hareketler set islem_tarihi = '"& islem_tarihi &"', vade_tarihi = '"& vade_tarihi &"', meblag = '"& meblag &"', parabirimi = '"& parabirimi &"', aciklama = '"& aciklama &"', akis_tipi = '"& akis_tipi &"' where id = '"& kayit_id &"'"
            set guncelle = baglanti.execute(SQL)


        elseif trn(request("islem2"))="odeme_ekle" then

            yer = trn(request("yer"))
            islem_tarihi = trn(request("islem_tarihi"))
            vade_tarihi = trn(request("vade_tarihi"))
            meblag = trn(request("meblag"))
            parabirimi = trn(request("parabirimi"))
            aciklama = trn(request("aciklama"))
            odeme_tipi = trn(request("odeme_tipi"))

            islem_saati = time()
            islem_tipi = "Ödeme"
            akis_tipi = odeme_tipi
            meblag = NoktalamaDegis(meblag)
            alacakli_id = cari_id
            borclu_id = Request.Cookies("kullanici")("firma_id")
            alacakli_tipi = tip
            borclu_tipi = "firma"
            usd_kur = CiftParaCevir(1, "USD", "TL")
            eur_kur = CiftParaCevir(1, "EUR", "TL")
            durum = "true"
            cop = "false"
            firma_kodu = Request.Cookies("kullanici")("firma_kodu")
            firma_id = Request.Cookies("kullanici")("firma_id")
            ekleyen_id = Request.Cookies("kullanici")("kullanici_id")
            ekleyen_ip = Request.ServerVariables("Remote_Addr")


            if isdate(vade_tarihi)=false then
                vade_tarihi = cdate(date)
            end if

            SQL="insert into cari_hareketler(islem_tarihi, islem_saati, aciklama, vade_tarihi, islem_tipi, akis_tipi, meblag, borclu_id, alacakli_id, borclu_tipi, alacakli_tipi, usd_kur, eur_kur, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, parabirimi) values('"& islem_tarihi &"', '"& islem_saati &"', '"& aciklama &"', '"& vade_tarihi &"', '"& islem_tipi &"', '"& akis_tipi &"', '"& meblag &"', '"& borclu_id &"', '"& alacakli_id &"', '"& borclu_tipi &"', '"& alacakli_tipi &"', '"& usd_kur &"', '"& eur_kur &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', '"& ekleme_tarihi &"', '"& ekleme_saati &"', '"& parabirimi &"')"
            set ekle = baglanti.execute(SQL)

        end if


        if trim(yer)="icerden" then
%>
<div class="dt-responsive table-responsive">
    <table class="table">
        <thead>
            <tr>
                <th style="width: 150px;"><%=LNG("İşlem Tarihi")%></th>
                <th><%=LNG("İşlem Tipi")%></th>
                <th><%=LNG("Açıklama")%></th>
                <th style="width: 200px;"><%=LNG("Vade Tarihi")%></th>
                <th style="text-align: center; width: 150px;"><%=LNG("Borç")%></th>
                <th style="text-align: center; width: 150px;"><%=LNG("Alacak")%></th>
                <th style="text-align: center; width: 150px; background: linear-gradient(45deg, #4099ff, #73b4ff);"><span class="label label-primary arkaplansiz badge-lg">TL <%=LNG("BAKİYE")%></span></th>
                <th style="text-align: center; width: 150px; background: linear-gradient(45deg, #FF5370, #ff869a);"><span class="label label-danger arkaplansiz badge-lg ">$ <%=LNG("BAKİYE")%></span></th>
                <th style="text-align: center; width: 150px; background: linear-gradient(45deg, #FFB64D, #ffcb80);"><span class="label label-warning arkaplansiz badge-lg">€ <%=LNG("BAKİYE")%></span></th>
                <th style="text-align: center; width: 150px;"><%=LNG("İşlemler")%></th>
            </tr>
        </thead>
        <tbody>
            <%  
                SQL="select * from cari_hareketler where cop = 'false' and ((borclu_tipi = '"& tip &"' and borclu_id = '"& cari_id &"') or (alacakli_tipi = '"& tip &"' and alacakli_id = '"& cari_id &"')) order by id asc"
                set liste = baglanti.execute(SQL)
                if liste.eof then
            %>
            <tr>
                <td colspan="10" style="text-align: center;"><%=LNG("Cari hareket kaydı bulunamadı.")%></td>
            </tr>
            <%
                end if

                tl_bakiye = 0
                usd_bakiye = 0
                eur_bakiye = 0

                borc_tl_bakiye = 0
                borc_usd_bakiye = 0
                borc_eur_bakiye = 0

                alacak_tl_bakiye = 0
                alacak_usd_bakiye = 0
                alacak_eur_bakiye = 0

                do while not liste.eof
                    if trim(liste("islem_tipi"))="Ödeme" then
                        if trim(liste("parabirimi"))="TL" then
                            tl_bakiye = cdbl(tl_bakiye) - cdbl(liste("meblag"))
                        elseif trim(liste("parabirimi"))="USD" then
                            usd_bakiye = cdbl(usd_bakiye) - cdbl(liste("meblag"))
                        elseif trim(liste("parabirimi"))="EUR" then
                            eur_bakiye = cdbl(eur_bakiye) - cdbl(liste("meblag"))
                        end if
                    elseif trim(liste("islem_tipi"))="Tahsilat" then
                        if trim(liste("parabirimi"))="TL" then
                            tl_bakiye = cdbl(tl_bakiye) + cdbl(liste("meblag"))
                        elseif trim(liste("parabirimi"))="USD" then
                            usd_bakiye = cdbl(usd_bakiye) + cdbl(liste("meblag"))
                        elseif trim(liste("parabirimi"))="EUR" then
                            eur_bakiye = cdbl(eur_bakiye) + cdbl(liste("meblag"))
                        end if
                    end if
            %>
            <tr>
                <td><%=day(cdate(liste("islem_tarihi"))) %>&nbsp;<%=monthname(month(cdate(liste("islem_tarihi")))) %>&nbsp;<%=year(cdate(liste("islem_tarihi"))) %></td>
                <td><%=trim(liste("akis_tipi")) %>&nbsp;<%=liste("islem_tipi") %></td>
                <td><%=liste("aciklama") %></td>
                <td><% if trim(liste("akis_tipi"))="Çek" then %><%=cdate(liste("vade_tarihi")) %><% end if %></td>
                <td style="text-align: center;"><% if trim(liste("islem_tipi"))="Ödeme" then %><%=formatnumber(liste("meblag"),2) %><% if trim(liste("parabirimi"))="TL" then %>&nbsp;TL<% elseif trim(liste("parabirimi"))="USD" then %>&nbsp;$<% elseif trim(liste("parabirimi"))="EUR" then %>&nbsp;€<% end if %><% end if %></td>
                <td style="text-align: center; border-right: 2px solid #ddd;"><% if trim(liste("islem_tipi"))="Tahsilat" then %><%=formatnumber(liste("meblag"),2) %><% if trim(liste("parabirimi"))="TL" then %>&nbsp;TL<% elseif trim(liste("parabirimi"))="USD" then %>&nbsp;$<% elseif trim(liste("parabirimi"))="EUR" then %>&nbsp;€<% end if %><% end if %></td>
                <td style="text-align: center;"><%=formatnumber(tl_bakiye,2) %> TL</td>
                <td style="text-align: center;"><%=formatnumber(usd_bakiye,2) %> $</td>
                <td style="text-align: center; border-right: 2px solid #ddd;"><%=formatnumber(eur_bakiye,2) %> €</td>
                <td style="text-align: center;">
                    <div style="width: 120px;">
                        <div class="btn-group dropdown-split-primary">
                            <button type="button" onclick="cari_hareket_kaydi_duzenle('<%=cari_id %>', '<%=tip %>', '<%=liste("id") %>', '<%=liste("islem_tipi") %>', '<%=yer %>');" class="btn btn-mini btn-primary"><i class="icofont icofont-exchange"></i><%=LNG("İşlemler")%></button>
                            <button type="button" class="btn btn-primary btn-mini dropdown-toggle dropdown-toggle-split waves-effect waves-light" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="sr-only"><%=LNG("İşlemler")%></span>
                            </button>
                            <div class="dropdown-menu">
                                <a class="dropdown-item waves-effect waves-light" href="javascript:void(0);" onclick="cari_hareket_kaydi_duzenle('<%=cari_id %>', '<%=tip %>', '<%=liste("id") %>', '<%=liste("islem_tipi") %>', '<%=yer %>');"><%=LNG("Kaydı Düzenle")%></a>
                                <a class="dropdown-item waves-effect waves-light" href="javascript:void(0);" onclick="cari_hareket_kaydi_sil('<%=cari_id %>', '<%=tip %>', '<%=liste("id") %>', '<%=liste("islem_tipi") %>', '<%=yer %>');"><%=LNG("Kaydı Sil")%></a>
                                <a class="dropdown-item waves-effect waves-light" href="javascript:void(0);" onclick="cari_hareket_makbuz_goster('<%=liste("id") %>');"><%=LNG("Makbuz")%></a>
                            </div>
                        </div>
                    </div>
                </td>

            </tr>
            <%
                liste.movenext
                loop
            %>
            <tr>
                <td colspan="4" style="border: none;"></td>
                <td style="border-top: 2px solid #ddd; text-align: right; padding-right: 10px;" colspan="2"><%=LNG("TOPLAM ALACAK")%></td>
                <td style="border-top: 2px solid #ddd; text-align: center;"><%=formatnumber(alacak_tl_bakiye,2) %> TL</td>
                <td style="border-top: 2px solid #ddd; text-align: center;"><%=formatnumber(alacak_usd_bakiye,2) %> $</td>
                <td style="text-align: center; border-top: 2px solid #ddd;"><%=formatnumber(alacak_eur_bakiye,2) %> €</td>
                <td style="border-top: 2px solid #ddd;"></td>
            </tr>
            <tr>
                <td colspan="4" style="border: none;"></td>
                <td style="border-top: 2px solid #ddd; text-align: right; padding-right: 10px;" colspan="2"><%=LNG("TOPLAM BORÇ")%></td>
                <td style="border-top: 2px solid #ddd; text-align: center;"><%=formatnumber(borc_tl_bakiye,2) %> TL</td>
                <td style="border-top: 2px solid #ddd; text-align: center;"><%=formatnumber(borc_usd_bakiye,2) %> $</td>
                <td style="border-top: 2px solid #ddd; text-align: center;"><%=formatnumber(borc_eur_bakiye,2) %> €</td>
                <td style="border-top: 2px solid #ddd;"></td>

            </tr>
            <tr>
                <td colspan="4" style="border: none;"></td>
                <td style="border-top: 2px solid #ddd; text-align: right; padding-right: 10px;" colspan="2"><%=LNG("BAKİYE")%></td>
                <td style="border-top: 2px solid #ddd; text-align: center;"><%=formatnumber(tl_bakiye,2) %> TL</td>
                <td style="border-top: 2px solid #ddd; text-align: center;"><%=formatnumber(usd_bakiye,2) %> $</td>
                <td style="border-top: 2px solid #ddd; text-align: center;"><%=formatnumber(eur_bakiye,2) %> €</td>
                <td style="border-top: 2px solid #ddd;"></td>
            </tr>
        </tbody>
    </table>
</div>
<%
        elseif trim(yer)="disardan" then
%>
<div class="dt-responsives table-responsives">
    <table id="new-cons" class="table table-striped table-bordered nowrap">
        <thead>
            <tr>
                <th data-class="expand"><%=LNG("Cari Hesap Adı")%></th>
                <th data-hide="phone" style="text-align: center; background: linear-gradient(45deg, #4099ff, #73b4ff); width: 150px;"><span class="label label-primary arkaplansiz badge-lg">TL <%=LNG("BAKİYE")%></span></th>
                <th data-hide="phone" style="text-align: center; background: linear-gradient(45deg, #FF5370, #ff869a); width: 150px;"><span class="label label-danger arkaplansiz badge-lg ">$ <%=LNG("BAKİYE")%></span></th>
                <th data-hide="phone" style="text-align: center; background: linear-gradient(45deg, #FFB64D, #ffcb80); width: 150px;"><span class="label label-warning arkaplansiz badge-lg">€ <%=LNG("BAKİYE")%></span></th>
                <th data-hide="phone" style="text-align: center; width: 150px;"><%=LNG("İşlemler")%></th>
            </tr>
        </thead>
        <tbody>
            <%      
                SQL="Declare @cari_tip nvarchar(50) = 'firma'; select firma.id, firma.firma_adi, ((select isnull(sum(meblag),0) from cari_hareketler where borclu_tipi = @cari_tip and borclu_id = firma.id and parabirimi = 'TL' and cop = 'false')- (select isnull(sum(meblag),0) from cari_hareketler where alacakli_tipi = @cari_tip and alacakli_id = firma.id and parabirimi = 'TL' and cop = 'false')) as bakiye_tl, ((select isnull(sum(meblag),0) from cari_hareketler where borclu_tipi = @cari_tip and borclu_id = firma.id and parabirimi = 'USD' and cop = 'false')- (select isnull(sum(meblag),0) from cari_hareketler where alacakli_tipi = @cari_tip and alacakli_id = firma.id and parabirimi = 'USD' and cop = 'false')) as bakiye_usd, ((select isnull(sum(meblag),0) from cari_hareketler where borclu_tipi = @cari_tip and borclu_id = firma.id and parabirimi = 'EUR' and cop = 'false')- (select isnull(sum(meblag),0) from cari_hareketler where alacakli_tipi = @cari_tip and alacakli_id = firma.id and parabirimi = 'EUR' and cop = 'false')) as bakiye_eur from ucgem_firma_listesi firma where firma.ekleyen_firma_id = '"& Request.cookies("kullanici")("firma_id") &"' and firma.cop = 'false' order by firma.firma_adi asc"
                set firma = baglanti.execute(SQL)
                do while not firma.eof
            %>
            <tr>
                <td><%=firma("firma_adi") %></td>
                <td style="text-align: center;"><%=formatnumber(firma("bakiye_tl")) %> TL</td>
                <td style="text-align: center;"><%=formatnumber(firma("bakiye_usd")) %> $</td>
                <td style="text-align: center;"><%=formatnumber(firma("bakiye_eur")) %> €</td>
                <td style="text-align: center;">
                    <div class="btn-group dropdown-split-primary">
                        <button type="button" class="btn btn-mini btn-primary" onclick="sayfagetir('/finansman_detay/','jsid=4559&cari_id=<%=firma("id") %>&tip=firma');"><i class="icofont icofont-exchange"></i><%=LNG("İşlemler")%></button>
                        <button type="button" class="btn btn-primary btn-mini dropdown-toggle dropdown-toggle-split waves-effect waves-light" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="sr-only"><%=LNG("İşlemler")%></span>
                        </button>
                        <div class="dropdown-menu">
                            <a class="dropdown-item waves-effect waves-light" href="javascript:void(0);" onclick="sayfagetir('/finansman_detay/','jsid=4559&cari_id=<%=firma("id") %>&tip=firma');"><%=LNG("Detaylar")%></a>
                            <a class="dropdown-item waves-effect waves-light" href="javascript:void(0);" onclick="cari_hareket_tahsilat_ekle('<%=firma("id") %>', '<%=tip %>', 'disardan');"><%=LNG("Tahsilat Ekle")%></a>
                            <a class="dropdown-item waves-effect waves-light" href="javascript:void(0);" onclick="cari_hareket_odeme_ekle('<%=firma("id") %>', '<%=tip %>', 'disardan');"><%=LNG("Ödeme Ekle")%></a>
                        </div>
                    </div>
                </td>
            </tr>
            <%
                firma.movenext
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
            },500);

        });
</script>
<%
        end if

    elseif trn(request("islem"))="musteri_bilgilerini_getir" then
        
        firma_id = trn(request("firma_id"))

        SQL="select * from ucgem_firma_listesi where id = '"& firma_id &"' and (ekleyen_firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' or yetki_kodu = 'BOSS')"
        set firma = baglanti.execute(SQL)

%>
<div class="card">
    <div class="card-header">
        <h5 class="card-header-text"><% if trim(firma("yetki_kodu"))="MUSTERI" then %><%=LNG("Müşteri")%><% else %><%=LNG("Taşeron")%><% end if %> <%=LNG("Bilgileri")%></h5>
    </div>
    <div class="card-block">
        <div class="view-info">
            <form id="koftiform"></form>
            <form autocomplete="off" id="musteri_guncelleme_form">
                <div class="row">

                    <div class="col-md-4 col-lg-4  ">
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Firma Adı")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="firma_adi" required value="<%=firma("firma_adi") %>" class="form-control">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Yetkili Kişi")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="firma_yetkili" value="<%=firma("firma_yetkili") %>" class="form-control" required>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Müşteri Telefon")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="firma_telefon" class="form-control" value="<%=firma("firma_telefon") %>" required data-mask="0(999) 999 99 99" placeholder="0(532) 123 45 67">
                                </div>
                            </div>
                        </div>






                    </div>
                    <div class="col-md-4 col-lg-4  ">

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Müşteri E-Posta")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="email" id="firma_mail" class="form-control" required value="<%=firma("firma_mail") %>" />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Süpervisor")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <select name="firma_supervisor_id" id="firma_supervisor_id" class="select2">
                                    <%
                                        SQL="select id, personel_ad + ' ' + personel_soyad as personel from ucgem_firma_kullanici_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and durum = 'true' and cop = 'false' order by personel_ad + ' ' + personel_soyad asc"
                                        set kullanici = baglanti.execute(SQL)
                                        do while not kullanici.eof
                                    %>
                                    <option <% if trim(firma("firma_supervisor_id"))=trim(kullanici("id")) then %> selected="selected" <% end if %> value="<%=kullanici("id") %>"><%=kullanici("personel") %></option>
                                    <%
                                        kullanici.movenext
                                        loop
                                    %>
                                </select>
                            </div>
                        </div>


                        <div class="row" <% if not trim(firma("yetki_kodu"))="TASERON" then %> style="display: none;" <% end if %>>
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Taşeron Saatlik Maliyet")%></label>
                            <div class="col-sm-9 col-lg-9">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <%
                                        taseron_saatlik_maliyet = firma("taseron_saatlik_maliyet")
                                        if isnull(taseron_saatlik_maliyet) = true then
                                            taseron_saatlik_maliyet = 0
                                        end if

                                        taseron_maliyet_pb = "TL"
                                        if isnull(firma("taseron_maliyet_pb"))=true then
                                            taseron_maliyet_pb = firma("taseron_maliyet_pb")
                                        end if

                                    %>
                                    <input type="text" class="validate[required] paraonly form-control" id="taseron_saatlik_maliyet" name="taseron_saatlik_maliyet" required value="<%=formatnumber(taseron_saatlik_maliyet,2) %>" />
                                </div>
                            </div>
                            <div class="col-sm-3 col-lg-3" style="display: none;">
                                <select id="taseron_maliyet_pb" name="taseron_maliyet_pb" class="select2">
                                    <option <% if trim(firma("taseron_maliyet_pb"))="TL" then %> selected="selected" <% end if %> value="TL">TL</option>
                                    <option <% if trim(firma("taseron_maliyet_pb"))="USD" then %> selected="selected" <% end if %> value="USD">USD</option>
                                    <option <% if trim(firma("taseron_maliyet_pb"))="EUR" then %> selected="selected" <% end if %> value="EUR">EUR</option>
                                </select>

                            </div>

                        </div>

                        <div class="row">
                            <div class="col-sm-12"><br />
                                <input type="button" class="btn btn-primary btn-mini" onclick="firma_bilgilerini_guncelle('<%=firma("id")%>');" value="<%=LNG("Müşteri Bilgilerini Güncelle")%>" />
                            </div>
                        </div>

                    </div>

                    <div class=" col-md-4 col-lg-4 col-xl-3" style="padding-left: 10%;">
                        <div class="row">
                            <label class="col-sm-12 col-lg-12 col-form-label"><%=LNG("Firma Logo")%></label>
                            <div class="col-sm-12 col-lg-12" style="margin-bottom: 15px;">
                                <input type="file" value="<%=firma("firma_logo") %>" id="firma_logo" tip="buyuk" folder="FirmaLogo" yol="firma_logo/" class="form-control" />
                            </div>
                        </div>
                    </div>

                </div>
            </form>

        </div>
    </div>
</div>

<%
    elseif trn(request("islem"))="musteri_cari_hareketleri_getir" then

        cari_id = trn(request("firma_id"))
        tip = "firma"


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
        <div class="row">
            <div class="col-md-6">
                <h5 style="font-size: 20px;"><%=LNG("Cari İşlemler Dökümü")%></h5>
            </div>
            <div class="col-md-6" style="text-align: right; padding-top: 15px;">
                <a href="javascript:void(0);" onclick="cari_hareket_tahsilat_ekle('<%=cari_id %>', '<%=tip %>', 'icerden');" class="btn btn-mini btn-success btn-round" style="color: white;"><i class="fa fa-money"></i>&nbsp;<%=LNG("Tahsilat Ekle")%></a>&nbsp;&nbsp;
                <a href="javascript:void(0);" onclick="cari_hareket_odeme_ekle('<%=cari_id %>', '<%=tip %>', 'icerden');" class="btn btn-mini btn-danger btn-round" style="color: white;"><i class="fa fa-paper-plane-o"></i>&nbsp;<%=LNG("Ödeme Ekle")%></a>
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
    elseif trn(request("islem"))="musteri_dosyalari_getir" then
        
        firma_id = trn(request("firma_id"))
%>
<div class="card">

    <div class="card-block">
        <div class="view-info">
            <div class="row">
                <div class="col-lg-12">
                    <div class="row">
                        <br>
                        <div class="col-md-3">
                            <h4><%=LNG("Dosya Ekle")%></h4>
                            <br>
                            <div id="upload48">
                                <table border="0" cellspacing="0" cellpadding="0">
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div style="width: 28px; height: 28px; border: solid 1px #dddddd; margin-right: 1px; background-color: White; float: left;">
                                                    <img id="uploadresim48" style="width: 28px; height: 28px;" class="resim" src="/img/kucukboy.png">
                                                </div>
                                            </td>


                                            <td>
                                                <input class="file fileupload" placeholder="<%=LNG("Yeni Dosya Yükle")%>" style="display: inline; color: rgb(102, 102, 102); font-size: 11px; width: 142px; height: 25px;">
                                                <div class="filebtn" style="width: 190px; height: 30px; background: url(/img/addFiles.png) right center no-repeat; display: inline; position: absolute; margin-left: -152px; margin-top: 1px;">
                                                    <input type="file" iid="48" id="uploadsrc48" tip="kucuk" yol="dosya_deposu/" style="height: 30px; position: absolute; width: 170px; margin-left: 5px; display: inline; cursor: pointer; opacity: 0;" class="fileupload" yapildi="true">
                                                </div>
                                                <input type="hidden" resimurl="48" name="dosya_yolu409" id="dosya_yolu409" value="/img/kucukboy.png"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <br>
                            <%=LNG("Dosya Adı:")%><br>
                            <input name="dosya_adi409" type="text" id="dosya_adi409"><br>
                            <br>
                            <input type="submit" name="dosya_kaydet_buton" value="Kaydet" onclick="yeni_is_dosya_ekle('409'); return false;" id="dosya_kaydet_buton" class="btn btn-success"><br>
                        </div>
                        <div class="col-md-8">
                            <h4><%=LNG("Dosya Listesi")%></h4>
                            <br>
                            <div class="table-responsive">

                                <div id="dosya_listesi409">
                                    <form autocomplete="off" method="post" id="form1" class="smart-form validateform">
                                        <div id="dosya_listesi_panel">
                                            <div id="dosya_yok_panel">
                                            </div>
                                            <table class="table table-bordered">
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
                                                    <tr>
                                                        <td colspan="6" style="text-align: center;"><%=LNG("Kayıt Yok")%></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%

    elseif trn(request("islem"))="musteri_ajanda_getir" then

        firma_id = trn(request("firma_id"))
%>
<div class="row">
    <div class="col-lg-12">
        <div id="takvim_yeri">
            <%
                etiket = "firma"
                etiket_id = firma_id
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
    elseif trn(request("islem"))="musteri_is_listesi_getir" then

        firma_id = trn(request("firma_id"))
%>
<div class="card">
    <div class="card-header">
        <h5 class="card-header-text"><%=LNG("İş Listesi")%></h5>
        <button id="edit-btn" type="button" onclick="etiketli_yeni_is_ekle('firma', '<%=firma_id %>');" class="btn btn-sm btn-primary waves-effect waves-light f-right">
            <i class="fa  fa-cube"></i>&nbsp;<%=LNG("Yeni İş Ekle")%>
        </button>
    </div>
    <div class="card-block">
        <div class="view-info">
            <div class="row">
                <div class="col-lg-12">
                    <div id="tum_isler"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<%
    elseif trn(request("islem"))="proje_is_listesi_getir" then

        proje_id = trn(request("proje_id"))
%>
<input type="hidden" name="proje_varmi" id="proje_varmi" value="true" proje_id="<%=proje_id %>" />
<div class="card">
    <div class="card-header">
        <h5 class="card-header-text"><%=LNG("İş Listesi")%></h5>
        <button id="edit-btn" type="button" onclick="etiketli_yeni_is_ekle('proje', '<%=proje_id %>');" class="btn btn-sm btn-primary waves-effect waves-light f-right">
            <i class="fa  fa-cube"></i>&nbsp;<%=LNG("Yeni İş Ekle")%>
        </button>
    </div>
    <div class="card-block">
        <div class="view-info">
            <div class="row">
                <div class="col-lg-12">
                    <div id="tum_isler"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<%
    elseif trn(request("islem"))="musteri_raporlarini_getir" then

        firma_id = trn(request("firma_id"))
%>

<div class="card">
    <div class="card-header">
        <h5 class="card-header-text"><%=LNG("Raporlar")%></h5>
    </div>
    <div class="card-block">
        <div class="view-info">
            <div class="row">
                <div class="col-lg-12">
                    <%
    
    
    ay = trn(request("ay"))
    yil = trn(request("yil"))

    if isnumeric(ay)=false then
        ay = month(date)
    end if

    if isnumeric(yil)=false then
        yil = year(date)
    end if


    dongu_baslangic = cdate("01."& ay &"." & yil)
    dongu_bitis = cdate(AyinSonGunu(dongu_baslangic) & "."& ay &"." & yil)

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
                    <div style="margin-bottom: 0;">

                        <div class="row">
                            <div class="col-md-3">
                                <%=LNG("Dönem :")%><br />
                                <select name="rapor_is_yuku_donem" class="select2" onchange="firma_rapor_is_yuku_gosterim_proje_sectim2('<%=firma_id %>');" id="rapor_is_yuku_donem">
                                    <% for x = 1 to 12 
                                        dongu_baslangic = cdate("01."& x &"." & year(date)-1)
                                        dongu_bitis = cdate(AyinSonGunu(dongu_baslangic) & "."& x &"." & year(date)-1)
                                    %>
                                    <option dongu_baslangic="<%=dongu_baslangic %>" dongu_bitis="<%=dongu_bitis %>" value="<%=x & "-" & year(date)-1 %>"><%=monthname(x) & " " & year(date)-1 %> </option>
                                    <% next %>
                                    <% for x = 1 to month(date)
                                        dongu_baslangic = cdate("01."& x &"." & year(date))
                                        dongu_bitis = cdate(AyinSonGunu(dongu_baslangic) & "."& x &"." & year(date))
                                    %>
                                    <option dongu_baslangic="<%=dongu_baslangic %>" dongu_bitis="<%=dongu_bitis %>" <% if trim(x & "-" & year(date))=trim(ay & "-" & yil) then %> selected="selected" <% end if %> value="<%=x & "-" & year(date) %>"><%=monthname(x) & " " & year(date) %> </option>
                                    <% next %>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <%=LNG("İş Yükü Gösterim Tipi")%><br />
                                <select name="yeni_is_yuku_gosterim_tipi" class="select2" onchange="firma_rapor_is_yuku_gosterim_proje_sectim('<%=firma_id %>','<%=cdate(dongu_baslangic) %>', '<%=cdate(dongu_bitis) %>');" id="yeni_is_yuku_gosterim_tipi">
                                    <option value="0"><%=LNG("Günlük İş Sayıları")%></option>
                                    <option value="1"><%=LNG("Günlük İş Saatleri")%></option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <%=LNG("Proje")%><br />
                                <select name="yeni_is_yuku_proje_id" class="select2" id="yeni_is_yuku_proje_id" class="select2" onchange="firma_rapor_is_yuku_gosterim_proje_sectim('<%=firma_id %>','<%=cdate(dongu_baslangic) %>', '<%=cdate(dongu_bitis) %>');">
                                    <option value="0"><%=LNG("Tüm Projeler")%></option>
                                    <%
                        SQL="select id, proje_adi from ucgem_proje_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and durum = 'true' and cop = 'false' order by proje_adi asc"
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
                    </div>
                    <script>
    $(function (){
        firma_rapor_is_yuku_gosterim_proje_sectim('<%=firma_id %>', '<%=cdate(dongu_baslangic) %>', '<%=cdate(dongu_bitis) %>');
    });
                    </script>
                    <div id="is_yuku_donus" class="tablediv" style="width: 95%; margin-top: 15px; overflow: auto;"></div>

                </div>
            </div>
        </div>
    </div>
</div>

<%
    elseif trn(request("islem"))="personel_bilgileri_getir" then

        personel_id = trn(request("personel_id"))

        SQL="select * from ucgem_firma_kullanici_listesi where id = '"& personel_id &"' and firma_id = '"& Request.Cookies("kullanici")("firma_id") &"'"
        set personel = baglanti.execute(SQL)

%>
<div class="card">
    <div class="card-header">
        <h5 class="card-header-text"><%=LNG("Personel Bilgileri")%></h5>
    </div>
    <div class="card-block">
        <div class="view-info">
            <form id="koftiform"></form>
            <form autocomplete="off" id="personel_guncelleme_form">
                <div class="row">

                    <div class="col-lg-3">
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Personel Resim")%></label>
                            <div class="col-sm-12 col-lg-12" style="margin-bottom: 15px;">
                                <input type="file" value="<%=personel("personel_resim") %>" id="personel_resim" tip="buyuk" folder="PersonelResim" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Personel Ad")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="personel_ad" required value="<%=personel("personel_ad") %>" class="form-control">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Personel Soyad")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="personel_soyad" value="<%=personel("personel_soyad") %>" class="form-control" required>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Personel T.C No")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="personel_tcno" value="<%=personel("tcno") %>" class="form-control" required>
                                </div>
                            </div>
                        </div>


                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Personel Doğum Tarihi")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" class="takvimyap form-control" id="personel_dtarih" required value="<%=cdate(personel("personel_dtarih")) %>" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Personel Cinsiyet")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <select id="personel_cinsiyet" name="personel_cinsiyet" class="select2">
                                    <option <% if trim(personel("personel_cinsiyet"))="Bay" then %> selected="selected" <% end if %>><%=LNG("Bay")%></option>
                                    <option <% if trim(personel("personel_cinsiyet"))="Bayan" then %> selected="selected" <% end if %>><%=LNG("Bayan")%></option>
                                </select>

                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Personel Saatlik Maliyet")%></label>
                            <div class="col-sm-9 col-lg-9">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <%
                                        personel_saatlik_maliyet = personel("personel_saatlik_maliyet")
                                        if isnull(personel_saatlik_maliyet) = true then
                                            personel_saatlik_maliyet = 0
                                        end if

                                        personel_maliyet_pb = "TL"
                                        if isnull(personel("personel_maliyet_pb"))=true then
                                            personel_maliyet_pb = personel("personel_maliyet_pb")
                                        end if

                                    %>
                                    <input type="text" class="validate[required] paraonly form-control" id="personel_saatlik_maliyet" name="personel_saatlik_maliyet" required value="<%=formatnumber(personel_saatlik_maliyet,2) %>" />
                                </div>
                            </div>
                            <div class="col-sm-3 col-lg-3" style="display: none;">
                                <select id="personel_maliyet_pb" name="personel_maliyet_pb" class="select2">
                                    <option <% if trim(personel("personel_maliyet_pb"))="TL" then %> selected="selected" <% end if %> value="TL">TL</option>
                                    <option <% if trim(personel("personel_maliyet_pb"))="USD" then %> selected="selected" <% end if %> value="USD">USD</option>
                                    <option <% if trim(personel("personel_maliyet_pb"))="EUR" then %> selected="selected" <% end if %> value="EUR">EUR</option>
                                </select>
                            </div>
                        </div>


                          <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Yönetici Yetkisi")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <select id="yonetici_yetkisi" name="yonetici_yetkisi" class="select2">
                                    <option value="false" <% if trim(personel("yonetici_yetkisi"))="false" then %> selected="selected" <% end if %>><%=LNG("Hayır")%></option>
                                    <option value="true" <% if trim(personel("yonetici_yetkisi"))="true" then %> selected="selected" <% end if %>><%=LNG("Evet")%></option>
                                </select>

                            </div>
                        </div>

                        

                          <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Parmak İzi Cihaz Eşleştirme ID")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="email" id="parmak_id" class="form-control" required value="<%=personel("parmak_id") %>" />
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-lg-5">
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Personel E-Posta")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="email" id="personel_eposta" class="form-control" required value="<%=personel("personel_eposta") %>" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Personel Telefon")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="personel_telefon" class="form-control" value="<%=personel("personel_telefon") %>" required data-mask="0(999) 999 99 99" placeholder="0(532) 123 45 67">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Departman")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <select name="departmanlar" id="departmanlar" class="select2" multiple="multiple">
                                    <%
                                        SQL="select id, departman_adi from tanimlama_departman_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and durum = 'true' and cop = 'false' order by sirano asc;"
                                        set departman = baglanti.execute(SQL)
                                        do while not departman.eof
                                    %>
                                    <option <% if instr(","& personel("departmanlar") &",", ","& departman("id") &",")>0 then %> selected="selected" <% end if %> value="<%=departman("id") %>"><%=departman("departman_adi") %></option>
                                    <%
                                        departman.movenext
                                        loop
                                    %>
                                </select>

                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Görev")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <select name="gorevler" id="gorevler" class="select2">
                                    <%
                                        SQL="select id, gorev_adi from tanimlama_gorev_listesi where firma_id = '"&  REquest.Cookies("kullanici")("firma_id") &"' and durum = 'true' and cop = 'false' order by gorev_adi asc"
                                        set gorev = baglanti.execute(SQL)
                                        do while not gorev.eof
                                    %>
                                    <option <% if instr(","& personel("gorevler") &",", ","& gorev("id") &",")>0 then %> selected="selected" <% end if %> value="<%=gorev("id") %>"><%=gorev("gorev_adi") %></option>
                                    <%
                                        gorev.movenext
                                        loop
                                    %>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Parola")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <input type="password" id="personel_parola" value="<%=personel("personel_parola") %>" required class="form-control">
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Yıllık İzin Hakkı")%></label>
                            <div class="col-sm-9 col-lg-9">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" class="validate[required] numericonly form-control" id="personel_yillik_izin" name="personel_yillik_izin" required value="<%=personel("personel_yillik_izin") %>" />
                                    <span style="padding-top: 5px;">&nbsp;&nbsp;gün</span>
                                </div>
                            </div>

                        </div>
                        <%
                            personel_yillik_izin_hakedis = personel("personel_yillik_izin_hakedis")

                            if isdate(personel_yillik_izin_hakedis)=true then
                                personel_yillik_izin_hakedis = cdate(personel_yillik_izin_hakedis)
                            end if

                        %>
                         <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Yıllık İzin Hakediş Tarihi")%></label>
                            <div class="col-sm-9 col-lg-9">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" class="validate[required] takvimyap form-control" id="personel_yillik_izin_hakedis" name="personel_yillik_izin_hakedis" required value="<%=personel_yillik_izin_hakedis %>" />
                                </div>
                            </div>

                        </div>


                        <div class="row">
                            <div class="col-sm-12">
                                <br />
                                <input type="button" class="btn btn-sm btn-primary" onclick="personel_bilgilerini_guncelle('<%=personel("id")%>');" value="<%=LNG("Personel Bilgilerini Güncelle")%>" />
                            </div>
                        </div>
                    </div>
                </div>
            </form>

        </div>
    </div>
</div>
<%
    elseif trn(request("islem"))="personel_giris_cikis_getir" then

        personel_id = trn(request("personel_id"))

        sql="select * from ucgem_firma_kullanici_listesi where id = '"& personel_id &"'"
        set personel = baglanti.execute(SQL)

%>
<div class="card">
    <div class="card-block">
        <div class="view-info">
            <div class="row">
                <div class="col-lg-4 col-xl-3">
                    <h5 class="card-header-text"><%=LNG("Personel Çalışma Saatleri")%></h5>
                    <br />
                    <br />
                    <form id="koftiform"></form>
                    <form autocomplete="off" id="personel_calisma_form">
                        <table>
                            <thead>
                                <tr>
                                    <th style="padding: 5px; font-weight: bold;"></th>
                                    <th style="padding: 5px; padding-left: 20px; font-weight: bold;"><%=LNG("Durum")%></th>
                                    <th style="padding: 5px; font-weight: bold;"><%=LNG("Giriş Saati")%></th>
                                    <th style="padding: 5px; font-weight: bold;"><%=LNG("Çıkış Saati")%></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td style="padding: 5px; font-weight: bold;"><%=LNG("Pazartesi")%></td>
                                    <td style="padding-left: 20px;">
                                        <input type="checkbox" onchange="calisma_gunu_sectim(1);" class="js-switch" <% if trim(personel("gun1"))="True" then %> checked="checked" <% end if %> name="gun1" id="gun1" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" <% if trim(personel("gun1"))="True" then %><% else %> disabled="disabled" <% end if %> style="width: 65px;" id="gun1_saat1" required class="timepicker form-control" value="<%=left(personel("gun1_saat1"),5) %>" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" <% if trim(personel("gun1"))="True" then %><% else %> disabled="disabled" <% end if %> style="width: 65px;" id="gun1_saat2" required class="timepicker form-control" value="<%=left(personel("gun1_saat2"),5) %>" /></td>
                                </tr>
                                <tr>
                                    <td style="padding: 5px; font-weight: bold;"><%=LNG("Salı")%></td>
                                    <td style="padding-left: 20px;">
                                        <input type="checkbox" onchange="calisma_gunu_sectim(2);" class="js-switch" <% if trim(personel("gun2"))="True" then %> checked="checked" <% end if %> name="gun2" id="gun2" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" <% if trim(personel("gun2"))="True" then %><% else %> disabled="disabled" <% end if %> style="width: 65px;" id="gun2_saat1" required class="timepicker form-control" value="<%=left(personel("gun2_saat1"),5) %>" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" <% if trim(personel("gun2"))="True" then %><% else %> disabled="disabled" <% end if %> style="width: 65px;" id="gun2_saat2" required class="timepicker form-control" value="<%=left(personel("gun2_saat2"),5) %>" /></td>
                                </tr>
                                <tr>
                                    <td style="padding: 5px; font-weight: bold;"><%=LNG("Çarşamba")%></td>
                                    <td style="padding-left: 20px;">
                                        <input type="checkbox" onchange="calisma_gunu_sectim(3);" class="js-switch" <% if trim(personel("gun3"))="True" then %> checked="checked" <% end if %> name="gun3" id="gun3" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" <% if trim(personel("gun3"))="True" then %><% else %> disabled="disabled" <% end if %> style="width: 65px;" id="gun3_saat1" required class="timepicker form-control" value="<%=left(personel("gun3_saat1"),5) %>" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" <% if trim(personel("gun3"))="True" then %><% else %> disabled="disabled" <% end if %> style="width: 65px;" id="gun3_saat2" required class="timepicker form-control" value="<%=left(personel("gun3_saat2"),5) %>" /></td>
                                </tr>
                                <tr>
                                    <td style="padding: 5px; font-weight: bold;"><%=LNG("Perşembe")%></td>
                                    <td style="padding-left: 20px;">
                                        <input type="checkbox" onchange="calisma_gunu_sectim(4);" class="js-switch" <% if trim(personel("gun4"))="True" then %> checked="checked" <% end if %> name="gun4" id="gun4" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" <% if trim(personel("gun4"))="True" then %><% else %> disabled="disabled" <% end if %> style="width: 65px;" id="gun4_saat1" required class="timepicker form-control" value="<%=left(personel("gun4_saat1"),5) %>" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" <% if trim(personel("gun4"))="True" then %><% else %> disabled="disabled" <% end if %> style="width: 65px;" id="gun4_saat2" required class="timepicker form-control" value="<%=left(personel("gun4_saat2"),5) %>" /></td>
                                </tr>
                                <tr>
                                    <td style="padding: 5px; font-weight: bold;"><%=LNG("Cuma")%></td>
                                    <td style="padding-left: 20px;">
                                        <input type="checkbox" onchange="calisma_gunu_sectim(5);" class="js-switch" <% if trim(personel("gun5"))="True" then %> checked="checked" <% end if %> name="gun5" id="gun5" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" <% if trim(personel("gun5"))="True" then %><% else %> disabled="disabled" <% end if %> style="width: 65px;" id="gun5_saat1" required class="timepicker form-control" value="<%=left(personel("gun5_saat1"),5) %>" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" <% if trim(personel("gun5"))="True" then %><% else %> disabled="disabled" <% end if %> style="width: 65px;" id="gun5_saat2" required class="timepicker form-control" value="<%=left(personel("gun5_saat2"),5) %>" /></td>
                                </tr>
                                <tr>
                                    <td style="padding: 5px; font-weight: bold;"><%=LNG("Cumartesi")%></td>
                                    <td style="padding-left: 20px;">
                                        <input type="checkbox" onchange="calisma_gunu_sectim(6);" class="js-switch" <% if trim(personel("gun6"))="True" then %> checked="checked" <% end if %> name="gun6" id="gun6" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" <% if trim(personel("gun6"))="True" then %><% else %> disabled="disabled" <% end if %> style="width: 65px;" id="gun6_saat1" required class="timepicker form-control" value="<%=left(personel("gun6_saat1"),5) %>" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" <% if trim(personel("gun6"))="True" then %><% else %> disabled="disabled" <% end if %> style="width: 65px;" id="gun6_saat2" required class="timepicker form-control" value="<%=left(personel("gun6_saat2"),5) %>" /></td>
                                </tr>
                                <tr>
                                    <td style="padding: 5px; font-weight: bold;"><%=LNG("Pazar")%></td>
                                    <td style="padding-left: 20px;">
                                        <input type="checkbox" onchange="calisma_gunu_sectim(7);" class="js-switch" <% if trim(personel("gun7"))="True" then %> checked="checked" <% end if %> name="gun1" id="gun7" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" <% if trim(personel("gun7"))="True" then %><% else %> disabled="disabled" <% end if %> style="width: 65px;" id="gun7_saat1" required class="timepicker form-control" value="<%=left(personel("gun7_saat1"),5) %>" /></td>
                                    <td style="text-align: center;">
                                        <input type="text" <% if trim(personel("gun7"))="True" then %><% else %> disabled="disabled" <% end if %> style="width: 65px;" id="gun7_saat2" required class="timepicker form-control" value="<%=left(personel("gun7_saat2"),5) %>" /></td>
                                </tr>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="4" style="text-align: center; padding-top: 15px;">
                                        <input type="button" onclick="personel_calisma_form_kaydet('<%=personel_id %>');" class="btn btn-primary btn-rnd btn-sm" value="<%=LNG("Güncelle")%>" /></td>
                                </tr>
                            </tfoot>
                        </table>
                    </form>

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
                <div class="col-lg-8 col-xl-9" style="padding-top: 15px;">
                    <h5 class="card-header-text"><%=LNG("Personel Giriş Çıkış Bilgileri")%></h5>
                    <input type="button" style="float: right; margin-top: 10px;" onclick="giris_cikis_kaydi_ekle('<%=personel_id%>', '<%=cdate(date)%>');" class="btn btn-primary btn-mini btn-rnd" value="<%=LNG("Giriş Çıkış Kaydı Ekle")%>" /><input type="button" class="btn btn-inverse btn-mini btn-rnd" onclick="giris_cikis_izin_ekle('<%=personel_id%>', '<%=cdate(date)%>');" style="float: right; margin-right: 15px; margin-top: 10px;" value="<%=LNG("İzin Ekle")%>" />
                    <br />
                    <br />
                    <div id="giris_cikis_kayitlari">
                        <script>
                            $(function (){
                                personel_giris_cikis_kayitlarini_getir('<%=personel_id %>');
                            });
                        </script>

                    </div>

                </div>
            </div>

            <hr />

            <div class="row">

                <div class="col-lg-12">

                    <h5 class="card-header-text"><%=LNG("Personel Giriş Çıkış Raporu")%></h5>


                    <br />
                    <br />
                    <div id="yillik_takvim_yeri">
                        <script>
                            $(function (){
                                personel_yillik_takvimi_getir('<%=personel_id %>', '<%=year(date) %>');
                            });
                        </script>
                    </div>
                    <table>
                        <tbody>
                            <tr>
                                <td>
                                    <div style="border: solid 1px black; width: 39px; height: 28px; background-color: #2ed8b6;"></div>
                                </td>
                                <td style="vertical-align: middle; padding: 6px;"><%=LNG("Zamanında")%></td>
                                <td>
                                    <div style="border: solid 1px black; width: 39px; height: 28px; background-color: #f1c40f;"></div>
                                </td>
                                <td style="vertical-align: middle; padding: 6px;"><%=LNG("30 Dakika Geç Kaldı")%></td>
                                <td>
                                    <div style="border: solid 1px black; width: 39px; height: 28px; background-color: #ff5370;"></div>
                                </td>
                                <td style="vertical-align: middle; padding: 6px;"><%=LNG("30 Dakikadan Fazla Geç Kaldı")%></td>
                            </tr>
                        </tbody>
                    </table>
                    <style>
                        .renk2_1 {
                            background-color: #f2f2f2;
                        }

                        .renk2_2 {
                            background-color: #2ed8b6;
                        }

                        .renk2_3 {
                            background-color: #f1c40f;
                        }

                        .renk2_4 {
                            background-color: #ff5370;
                        }

                        .ui-selecting {
                            background-color: #FECA40 !important;
                        }
                    </style>

                </div>
            </div>

            <hr />
            <div class="row">

                <div class="col-lg-12">
                    <%
                        sql="select isnull(kullanici.personel_yillik_izin, 0) - isnull((select count(id) from ucgem_personel_mesai_girisleri where personel_id = kullanici.id and giris_tipi = 2),0) as kalan, kullanici.* from ucgem_firma_kullanici_listesi kullanici where kullanici.id = '"& personel_id &"'"
                        set personel = baglanti.execute(SQL)
                    %>
                    <h5 class="card-header-text"><%=LNG("Personel İzin Talepleri")%></h5>
                    <div style="float:right; margin-top:-15px; font-weight:bold; margin-right:30px;">
                        Kalan İzin Kullanım Hakkı<span class="label label-info" style=" font-size:13px; padding:3px; text-align:center; "><%=personel("kalan") %> gün</span>
                    </div>
                    <br />
                    <br />
                    <div class="dt-responsive table-responsive" style="padding-bottom:400px;">
                        <table id="new-cons" class="table table-striped table-bordered table-hover" width="100%">
                            <thead>
                                <tr>
                                    <th style="width: 30px;">ID</th>
                                    <th><%=LNG("İzin Başlangıç")%></th>
                                    <th><%=LNG("İzin Bitiş")%></th>
                                    <th><%=LNG("İzin Nedeni")%></th>
                                    <th><%=LNG("İzin Şekli")%></th>
                                    <th><%=LNG("Açıklama")%></th>
                                    <th><%=LNG("Durum")%></th>
                                    <th><%=LNG("İşlem")%></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    SQL="select * from ucgem_personel_izin_talepleri where personel_id = '"& personel_id &"' and cop = 'false'"
                                    set izin = baglanti.execute(SQL)

                                    if izin.eof then
                                %>
                                <tr>
                                    <td colspan="8" style="text-align: center;">Kayıt Bulunamadı</td>
                                </tr>
                                <% end if %>
                                <%
                                    do while not izin.eof
                                %>
                                <tr>
                                    <td><%=izin("id") %></td>
                                    <td><%=cdate(izin("baslangic_tarihi")) %>&nbsp;<%=left(izin("baslangic_saati"),5) %></td>
                                    <td><%=cdate(izin("bitis_tarihi")) %>&nbsp;<%=left(izin("bitis_saati"),5) %></td>
                                    <td><%=izin("nedeni") %></td>
                                    <td><%=izin("turu") %></td>
                                    <td><%=izin("aciklama") %></td>
                                    <td><%=izin("durum") %></td>
                                    <td class="dropdown" style="width: 10px;">
                                        <button type="button" class="btn btn-mini btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-cog" aria-hidden="true"></i></button>
                                        <div class="dropdown-menu dropdown-menu-right b-none contact-menu">
                                            <a class="dropdown-item" href="javascript:void(0);" onclick="rapor_pdf_indir('izin_talep_formu', '<%=personel_id %>','<%=izin("id") %>');"><i class="fa fa-download"></i>İndir</a>
                                            <a class="dropdown-item" href="javascript:void(0);" onclick="rapor_pdf_yazdir('izin_talep_formu','<%=personel_id %>','<%=izin("id") %>');"><i class="fa fa-print"></i> Yazdır</a>
                                            <a class="dropdown-item" href="javascript:void(0);" onclick="rapor_pdf_gonder('izin_talep_formu','<%=personel_id %>','<%=izin("id") %>');"><i class="fa fa-send"></i> Gönder</a>
                                            <a class="dropdown-item" href="javascript:void(0);" onclick="personel_izin_talep_onayla('<%=personel_id %>','<%=izin("id") %>', 'Onaylandı');"><i class="icofont icofont-edit"></i>Onayla</a>
                                            <a class="dropdown-item" href="javascript:void(0);" onclick="personel_izin_talep_onayla('<%=personel_id %>','<%=izin("id") %>', 'Reddedildi');"><i class="icofont icofont-ui-delete"></i>Reddet</a>
                                            <a class="dropdown-item" href="javascript:void(0);" onclick="personel_izin_talep_onayla('<%=personel_id %>','<%=izin("id") %>', 'Onay Bekliyor');"><i class="icofont icofont-ui-calendar"></i>Beklet</a>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                    izin.movenext
                                    loop
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%
    elseif trn(request("islem"))="zimmet_getir" then

        etiket = trn(request("etiket"))
        etiket_id = trn(request("etiket_id"))
%>
<div class="card">
    <div class="card-header">
        <h5 class="card-header-text"><%=LNG("Zimmet Listesi")%></h5>
        <button id="edit-btn" type="button" onclick="personel_zimmet_kaydi_ekle('<%=etiket %>', '<%=etiket_id %>');" class="btn btn-mini btn-primary waves-effect waves-light f-right">
            <i class="icofont icofont-edit"></i><%=LNG("Zimmet Kaydı Ekle")%>
        </button>
    </div>
    <div class="card-block">
        <div class="view-info">
            <div class="row">
                <div id="zimmet_kayit_listesi" class="col-lg-12">
                    <script>
                        $(function (){
                            zimmet_kayitlarini_getir('<%=etiket %>', '<%=etiket_id %>');
                        });
                    </script>

                </div>
            </div>
        </div>
    </div>
</div>


<%
    elseif trn(request("islem"))="personel_cari_getir" then

        cari_id = trn(request("personel_id"))
        tip = "personel"


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
        <span style="float: right;">
            <a href="javascript:void(0);" onclick="cari_hareket_tahsilat_ekle('<%=cari_id %>', '<%=tip %>', 'icerden');" class="btn btn-mini btn-success btn-round" style="color: white;"><i class="fa fa-money"></i>&nbsp;<%=LNG("Tahsilat Ekle")%></a>
            <a href="javascript:void(0);" onclick="cari_hareket_odeme_ekle('<%=cari_id %>', '<%=tip %>', 'icerden');" class="btn btn-mini btn-danger btn-round" style="color: white;"><i class="fa fa-paper-plane-o"></i>&nbsp;<%=LNG("Ödeme Ekle")%></a>
        </span>
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
    elseif trn(request("islem"))="file_depo_getir" then

        kayit_id = trn(request("kayit_id"))
        etiket = trn(request("etiket"))
%>
<div class="card">
    <div class="card-block">
        <div class="view-info">
            <div class="row">

                <div class="col-md-4" style="padding-top: 15px;">
                    <form autocomplete="off" id="dosya_yukleme_form">
                        <h5 style="font-size: 15px;"><%=LNG("Dosya Ekle")%></h5>
                        <br>
                        <input class="form-control required" required type="file" id="depo_dosya_yolu" tip="kucuk" folder="Personel" />
                        <br>
                        <%=LNG("Dosya Adı:")%><br>
                        <img src="/img/loader_green.gif" />
                        <input name="depo_dosya_adi" type="text" id="depo_dosya_adi" required class="form-control required" style="max-width: 300px;" /><br>
                        <br>
                        <input type="button" class="btn btn-primary btn-mini" onclick="depo_dosya_yukle('<%=etiket%>', '<%=kayit_id%>');" value="<%=LNG("Dosya Yükle")%>" />
                    </form>
                </div>
                <div class="col-md-8" style="padding-top: 15px;">
                    <h5 style="font-size: 15px;"><%=LNG("Dosya Listesi")%></h5>
                    <br>
                    <div id="depo_dosya_listesi">
                        <script>
                                    $(function (){
                                        depo_dosyalari_getir('<%=etiket%>', '<%=kayit_id%>');
                                    });
                        </script>
                    </div>
                </div>


            </div>
        </div>
    </div>
</div>
</div>
<%
    elseif trn(request("islem"))="personel_ajandasi_getir" then

        personel_id = trn(request("personel_id"))
%>
<div class="row">
    <div class="col-lg-12">
        <div id="takvim_yeri">
            <%
                etiket = "personel"
                etiket_id = personel_id
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
    elseif trn(request("islem"))="personel_is_listesi_getir" then

        personel_id = trn(request("personel_id"))
%>
<div class="card">
    <div class="card-header">
        <h5 class="card-header-text"><%=LNG("İş Listesi")%></h5>
        <button id="edit-btn" type="button" onclick="etiketli_yeni_is_ekle('personel', '<%=personel_id %>');" class="btn btn-sm btn-primary waves-effect waves-light f-right">
            <i class="fa  fa-cube"></i>&nbsp;<%=LNG("Yeni İş Ekle")%>
        </button>
    </div>
    <div class="card-block">
        <div class="view-info">
            <div class="row">
                <div class="col-lg-12">

                    <div id="tum_isler">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%
    elseif trn(request("islem"))="personel_adamsaat_getir" then

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

                <div class="col-md-3">
                    <%=LNG("Dönem")%><br />
                    <select name="is_yuku_donem" class="select2" onchange="personel_adam_saat_gosterim_tarih_sectim('<%=personel_id %>');" id="is_yuku_donem">
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
                    <select name="is_yuku_gosterim_tipi" class="select2" onchange="personel_adam_saat_gosterim_tarih_sectim('<%=personel_id %>');" id="is_yuku_gosterim_tipi">
                        <option <% if trim(gosterim_tipi)="0" then %> selected="selected" <% end if %> value="0"><%=LNG("Maliyet")%></option>
                        <option <% if trim(gosterim_tipi)="1" then %> selected="selected" <% end if %> value="1"><%=LNG("Saat")%></option>
                    </select>
                </div>
                <div class="col-md-3">
                    <%=LNG("Proje")%><br />
                    <select name="is_yuku_proje_id" class="select2" onchange="personel_adam_saat_gosterim_tarih_sectim('<%=personel_id %>');" id="is_yuku_proje_id">
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

                    %><br /><br />
                    <div class="h5" style="font-size: 15px;"><%=LNG("Adam-Saat Cetveli")%></div>

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
                                        SQL="EXEC dbo.PersonelAdamSaatCetveli @personel_id = '"& personel_id &"', @firma_id = '"& Request.Cookies("kullanici")("firma_id") &"', @baslangic = '"& dongu_baslangic &"', @bitis = '"& dongu_bitis &"', @proje_id = '"& proje_id &"';"
                                        set cetvel = baglanti.execute(sql)

                                        tarih_sayi = cdate(dongu_bitis) - cdate(dongu_baslangic) + 1

                                        Dim gun_toplam()
                                        Redim gun_toplam(tarih_sayi)
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
                                                    gun_toplam(gunsayi) = cdbl(gun_toplam(gunsayi)) + cdbl(cetvel("maliyet_tutari"))
                                                else
                                                    gun_toplam(gunsayi) = cdbl(gun_toplam(gunsayi)) + (cdbl(cetvel("saat"))*60)
                                                end if

                                                gunsayi = gunsayi + 1

                                            cetvel.movenext
                                            loop
                                        %>
                                    </tr>
                                    <tr>
                                        <td class="ust_td2 headcol" style="width: 150px; background-color: #4d7193; color: white!important;"><%=LNG("TOPLAM")%></td>
                                        <td class="gosterge_td alt_td "><%=toplam_saat %></td>
                                        <td class=" gosterge_td alt_td sagcizgi"><%=toplam_tutar %> TL</td>
                                        <% for x = 0 to ubound(gun_toplam)-2 %>
                                        <td class="alt_td" style="background-color: #4d7193; color: white;">
                                            <% if trim(gosterim_tipi)="0" then %>
                                            <%=gun_toplam(x) %> TL
                                            <% else %>
                                            <%=DakikadanSaatYap(gun_toplam(x)) %>
                                            <% end if %>
                                        </td>
                                        <% next %>
                                    </tr>
                                    <%
                                        Erase gun_toplam
                                    %>
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
    elseif trn(request("islem"))="taseron_adamsaat_getir" then

        firma_id = trn(request("firma_id"))
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

                <div class="col-md-3">
                    <%=LNG("Dönem:")%><br />
                    <select name="is_yuku_donem" class="select2" onchange="taseron_adam_saat_gosterim_tarih_sectim('<%=firma_id %>');" id="is_yuku_donem">
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
                    <select name="is_yuku_gosterim_tipi" class="select2" onchange="taseron_adam_saat_gosterim_tarih_sectim('<%=firma_id %>');" id="is_yuku_gosterim_tipi">
                        <option <% if trim(gosterim_tipi)="0" then %> selected="selected" <% end if %> value="0"><%=LNG("Maliyet")%></option>
                        <option <% if trim(gosterim_tipi)="1" then %> selected="selected" <% end if %> value="1"><%=LNG("Saat")%></option>
                    </select>
                </div>
                <div class="col-md-3">
                    <%=LNG("Proje")%><br />
                    <select name="is_yuku_proje_id" class="select2" onchange="taseron_adam_saat_gosterim_tarih_sectim('<%=firma_id %>');" id="is_yuku_proje_id">
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
                    %><br />
                    <div class="h5" style="font-size: 15px;"><%=LNG("Adam-Saat Cetveli")%></div>

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


                                        SQL="EXEC dbo.TaseronAdamSaatCetveli @taseron_id = '"& firma_id &"', @firma_id = '"& Request.Cookies("kullanici")("firma_id") &"', @baslangic = '"& dongu_baslangic &"', @bitis = '"& dongu_bitis &"', @proje_id = '"& proje_id &"';"
                                        set cetvel = baglanti.execute(sql)

                                        if cetvel.eof then
                                            Response.Write "<tr><td colspan=10>Girilen Kriterlere Uygun Kayıt Bulunamadı</td></tr>"
                                            Response.End
                                        end if

                                        tarih_sayi = cdate(dongu_bitis) - cdate(dongu_baslangic) + 1

                                        Dim gun_toplam_yeni()
                                        Redim gun_toplam_yeni(tarih_sayi)
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
                                                    gun_toplam_yeni(gunsayi) = cdbl(gun_toplam_yeni(gunsayi)) + cdbl(cetvel("maliyet_tutari"))
                                                else
                                                    gun_toplam_yeni(gunsayi) = cdbl(gun_toplam_yeni(gunsayi)) + (cdbl(cetvel("saat"))*60)
                                                end if

                                                gunsayi = gunsayi + 1

                                            cetvel.movenext
                                            loop
                                        %>
                                    </tr>
                                    <tr>
                                        <td class="ust_td2 headcol" style="width: 150px; background-color: #4d7193; color: white!important;"><%=LNG("TOPLAM")%></td>
                                        <td class="gosterge_td alt_td "><%=toplam_saat %></td>
                                        <td class=" gosterge_td alt_td sagcizgi"><%=toplam_tutar %> TL</td>
                                        <% for x = 0 to ubound(gun_toplam_yeni)-1 %>
                                        <td class="alt_td" style="background-color: #4d7193; color: white;">
                                            <% if trim(gosterim_tipi)="0" then %>
                                            <%=gun_toplam_yeni(x) %> TL
                                            <% else %>
                                            <%=DakikadanSaatYap(gun_toplam_yeni(x)) %>
                                            <% end if %>
                                        </td>
                                        <% next %>
                                    </tr>
                                    <%
                                        Erase gun_toplam_yeni
                                    %>
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
    elseif trn(request("islem"))="personel_raporlarini_getir" then

        personel_id = trn(request("personel_id"))
        coklumu = trn(request("coklumu"))

%>
<div class="card">
    <div class="card-header">
        <h5 class="card-header-text"><%=LNG("Raporlar")%></h5>

    </div>
    <div class="card-block">
        <div class="view-info">
            <div class="row">
                <div class="col-lg-12">
                    <%
    
    
    ay = trn(request("ay"))
    yil = trn(request("yil"))

    if isnumeric(ay)=false then
        ay = month(date)
    end if

    if isnumeric(yil)=false then
        yil = year(date)
    end if


    dongu_baslangic = cdate("01."& ay &"." & yil)
    dongu_bitis = cdate(AyinSonGunu(dongu_baslangic) & "."& ay &"." & yil)

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


                    <div style="margin-bottom: 0;">
                        <div class="row">
                            <div class="col-sm-12 col-md-3">
                                <%=LNG("Dönem:")%><br />
                                <select name="rapor_is_yuku_donem" class="select2" onchange="personel_rapor_is_yuku_gosterim_proje_sectim2('<%=personel_id %>');" id="rapor_is_yuku_donem">
                                    <% for x = 1 to 12 
                                    
                        dongu_baslangic = cdate("01."& x &"." & year(date)-1)
                        dongu_bitis = cdate(AyinSonGunu(dongu_baslangic) & "."& x &"." & year(date)-1)
                                    
                                    %>
                                    <option dongu_baslangic="<%=dongu_baslangic %>" dongu_bitis="<%=dongu_bitis %>" value="<%=x & "-" & year(date)-1 %>"><%=monthname(x) & " " & year(date)-1 %> </option>
                                    <% next %>
                                    <% for x = 1 to month(date)
                                    
                        dongu_baslangic = cdate("01."& x &"." & year(date))
                        dongu_bitis = cdate(AyinSonGunu(dongu_baslangic) & "."& x &"." & year(date))

                                    %>
                                    <option dongu_baslangic="<%=dongu_baslangic %>" dongu_bitis="<%=dongu_bitis %>" <% if trim(x & "-" & year(date))=trim(ay & "-" & yil) then %> selected="selected" <% end if %> value="<%=x & "-" & year(date) %>"><%=monthname(x) & " " & year(date) %> </option>
                                    <% next %>
                                </select>
                            </div>
                            <div class="col-sm-12 col-md-3">
                                <%=LNG("İş Yükü Gösterim Tipi:")%><br />
                                <select class="select2" name="yeni_is_yuku_personel_id" onchange="personel_raporlarini_getir(this.value, '', 'true')" id="yeni_is_yuku_personel_id">
                                    <%
                    SQL="select id, personel_ad + ' ' + personel_soyad as personel_ad_soyad from ucgem_firma_kullanici_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and durum = 'true' and cop = 'false';"
                    set katilimci = baglanti.execute(SQL)
                    do while not katilimci.eof
                                    %>
                                    <option <% if trim(katilimci("id"))=trim(personel_id) then %> selected="selected" <% end if %> value="<%=katilimci("id") %>"><%=katilimci("personel_ad_soyad") %></option>
                                    <%
                    katilimci.movenext
                    loop
                                    %>
                                </select>
                            </div>
                            <div class="col-sm-12 col-md-3">
                                <%=LNG("Proje:")%><br />
                                <select name="yeni_is_yuku_proje_id" class="select2" id="yeni_is_yuku_proje_id" onchange="personel_rapor_is_yuku_gosterim_proje_sectim('<%=personel_id %>','<%=cdate(dongu_baslangic) %>', '<%=cdate(dongu_bitis) %>');">
                                    <option value="0"><%=LNG("Tüm Projeler")%></option>
                                    <%
                        SQL="select id, proje_adi from ucgem_proje_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and durum = 'true' and cop = 'false' order by proje_adi asc"
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
                    </div>


                    <script>
    $(function (){
        personel_rapor_is_yuku_gosterim_proje_sectim('<%=personel_id %>', '<%=cdate(dongu_baslangic) %>', '<%=cdate(dongu_bitis) %>');
    });
                    </script>
                    <div id="is_yuku_donus" class="tablediv" style="width: 95%; margin-top: 15px; overflow: auto;"></div>

                </div>
            </div>
        </div>
    </div>
</div>
<%
    
    elseif trn(request("islem"))="personel_bilgilerini_guncelle" then

        personel_id = trn(request("personel_id"))
        personel_ad = trn(request("personel_ad"))
        personel_soyad = trn(request("personel_soyad"))
        personel_dtarih = trn(request("personel_dtarih"))
        personel_cinsiyet = trn(request("personel_cinsiyet"))
        personel_eposta = trn(request("personel_eposta"))
        personel_telefon = trn(request("personel_telefon"))
        departmanlar = trn(request("departmanlar"))
        gorevler = trn(request("gorevler"))
        personel_parola = trn(request("personel_parola"))
        personel_resim = trn(request("personel_resim"))
        personel_maliyet_pb = trn(request("personel_maliyet_pb"))
        personel_saatlik_maliyet = Trim(REplace(Replace(Replace(trn(request("personel_saatlik_maliyet")),".",""),",","."),"TL",""))
        personel_tcno = trn(request("personel_tcno"))
        personel_yillik_izin = trn(request("personel_yillik_izin"))
        yonetici_yetkisi = trn(request("yonetici_yetkisi"))
        personel_yillik_izin_hakedis = trn(request("personel_yillik_izin_hakedis"))
        parmak_id = trn(request("parmak_id"))

        SQL="update ucgem_firma_kullanici_listesi set parmak_id = '"& parmak_id &"', personel_yillik_izin_hakedis = CONVERT(date, '"& personel_yillik_izin_hakedis &"', 103), yonetici_yetkisi = '"& yonetici_yetkisi &"', personel_yillik_izin = '"& personel_yillik_izin &"', personel_saatlik_maliyet = '"& personel_saatlik_maliyet &"', personel_maliyet_pb = '"& personel_maliyet_pb &"', personel_resim = '"& personel_resim &"', personel_ad = '"& personel_ad &"', personel_soyad = '"& personel_soyad &"', personel_dtarih = CONVERT(date, '"& personel_dtarih &"', 103), personel_cinsiyet = '"& personel_cinsiyet &"', personel_eposta = '"& personel_eposta &"', personel_telefon = '"& personel_telefon &"', departmanlar = '"& departmanlar &"', gorevler = '"& gorevler &"', personel_parola = '"& personel_parola &"', tcno = '"& personel_tcno &"' where id = '"& personel_id &"' and firma_id = '"& request.Cookies("kullanici")("firma_id") &"'; EXEC MailGonderBildirim @personel_id = '"+ personel_id +"', @mesaj = 'Proskop Hesap Bilgileriniz;<br><br>Sistem Giriş Url : <a href=http://www.esflw.com>http://www.esflw.com</a><br>E-Posta : " + personel_eposta + "<br>Parola : " + personel_parola + "<br><br>';"
        set guncelle = baglanti.execute(SQL)


        NetGSM_SMS personel_telefon,  "Proskop Hesap Bilgileriniz; \n Sistem Giriş Url : http://www.esflw.com \n E-Posta : " + personel_eposta + "\n Parola : " + personel_parola



    elseif trn(request("islem"))="kendi_personel_bilgilerini_guncelle" then

        personel_id = Request.Cookies("kullanici")("kullanici_id")
        personel_ad = trn(request("personel_ad"))
        personel_soyad = trn(request("personel_soyad"))
        personel_dtarih = trn(request("personel_dtarih"))
        personel_cinsiyet = trn(request("personel_cinsiyet"))
        personel_eposta = trn(request("personel_eposta"))
        personel_telefon = trn(request("personel_telefon"))
        gorevler = trn(request("gorevler"))
        personel_parola = trn(request("personel_parola"))
        personel_resim = trn(request("personel_resim"))
        personel_tcno = trn(request("personel_tcno"))

        SQL="update ucgem_firma_kullanici_listesi set personel_resim = '"& personel_resim &"', personel_ad = '"& personel_ad &"', personel_soyad = '"& personel_soyad &"', personel_dtarih = '"& personel_dtarih &"', personel_cinsiyet = '"& personel_cinsiyet &"', personel_eposta = '"& personel_eposta &"', personel_telefon = '"& personel_telefon &"', personel_parola = '"& personel_parola &"', tcno = '"& personel_tcno &"' where id = '"& personel_id &"'"
        set guncelle = baglanti.execute(SQL)


    elseif trn(request("islem"))="yeni_ajanda_kayit_ekle" then

        yinelemeli = trn(request("yinelemeli"))
        etiket = trn(request("etiket"))
        etiket_id = trn(request("etiket_id"))

        baslangic = trn(request("start"))
        bitis = trn(request("end"))
        baslangic1 = trn(request("start"))
        bitis1 = trn(request("end"))

        rutinmi = false
        if baslangic = "" then
            baslangic = cdate(date)
            baslangic_tarihi = cdate(date)
            baslangic_saati = left(time,5)
            rutinmi = true
        else
            baslangic = left(baslangic,10)
            baslangic_tarihi = cdate(right(baslangic, 2) & "." & mid(baslangic, 6,2) & "." & left(baslangic, 4))
            baslangic_saati = right(baslangic1,5)
        end if

        if bitis = "" then
            bitis = cdate(date)
            bitis_tarihi = cdate(date)
            bitis_saati = left(time,5)
        else
            bitis = left(bitis,10)
            bitis_tarihi = cdate(right(bitis, 2) & "." & mid(bitis, 6,2) & "." & left(bitis, 4))-1
            bitis_saati = right(bitis1,5)
        end if


        if cdate(bitis_tarihi)<cdate(baslangic_Tarihi) then
            bitis_tarihi = cdate(right(bitis, 2) & "." & mid(bitis, 6,2) & "." & left(bitis, 4))
        end if

%>
<div class="modal-header">
    <%=LNG("Ajanda Kayıt Ekle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_olay_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">
        <div class="col-sm-10">
            <label class="col-sm-12 col-form-label" style="padding-left: 0;"><%=LNG("Başlık")%></label>
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <textarea id="baslik" name="baslik" class="required form-control" style="width: 93%; padding-left: 5px; padding-top: 6px;" required></textarea>
                <script>
                    $(function () {
                        setTimeout(function () { $("#baslik").focus();$("window").resize(); }, 500);
                        autosize($("#baslik"));
                    });
                </script>
            </div>
        </div>
        <div class="col-sm-2">
            <label class="col-sm-12 col-form-label" style="padding-left: 0;"><%=LNG("Renk")%></label>
            <!--<input type="hidden" id="renk" class="demo" value="#FC6180">-->
            <input type='text' id="renk" value="rgb(231, 76, 60)" />
        </div>
    </div>
    <% if trim(yinelemeli)="false" then %>
    <div class="row">
        <div class="col-sm-6" style="padding: 0;">
            <label class="col-sm-12 col-form-label"><%=LNG("Planlanan Başlangıç")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-calendar"></i>
                    </span>
                    <input type="text" required class="required form-control takvimyap" value="<%=cdate(baslangic_tarihi) %>" name="baslangic_tarihi" id="baslangic_tarihi" />
                </div>
            </div>
        </div>
        <div class="col-sm-6" style="padding: 0;">
            <label class="col-sm-12 col-form-label"><%=LNG("Saat")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-calendar"></i>
                    </span>
                    <input type="text" required class="required form-control timepicker" value="<%=baslangic_saati %>" name="baslangic_saati" id="baslangic_saati" />
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-6" style="padding: 0;">
            <label class="col-sm-12 col-form-label"><%=LNG("Planlanan Bitiş :")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-calendar"></i>
                    </span>
                    <input type="text" required class="required form-control takvimyap" value="<%=cdate(bitis_tarihi) %>" name="bitis_tarihi" id="bitis_tarihi" />
                </div>
            </div>
        </div>
        <div class="col-sm-6" style="padding: 0;">
            <label class="col-sm-12 col-form-label"><%=LNG("Saat :")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-calendar"></i>
                    </span>
                    <input type="text" required class="required form-control timepicker" value="<%=bitis_saati %>" name="bitis_saati" id="bitis_saati" />
                </div>
            </div>
        </div>
    </div>
    <% else %>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Olay Tipi :")%></label>
        <div class="col-sm-12">
            <select name="olay_tipi" class="select2" onchange="toplanti_tipi_sectim(this.value);" id="olay_tipi">
                <option value="gundeme_ozel"><%=LNG("Tek")%></option>
                <option value="rutin"><%=LNG("Rutin")%></option>
            </select>
        </div>
    </div>



    <div class="row toplanti_tipi rutin" style="display: none;">
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
    <div class="row toplanti_tipi rutin" style="display: none; margin-top: 10px;">
        <div class="col-sm-6">
            <label class="col-form-label"><%=LNG("Yineleme Başlangıç Tarihi :")%></label>
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-user"></i>
                </span>
                <input type="text" id="yineleme_baslangic" name="yineleme_baslangic" class="form-control takvimyap required" required />
            </div>
        </div>
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
    <div class="row toplanti_tipi rutin" style="display: none;">
        <div class=" col-sm-6" style="padding: 0;">
            <label class="col-sm-12 col-form-label"><%=LNG("Başlangıç Saati :")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-user"></i>
                    </span>
                    <input type="text" id="baslangic_saati" name="baslangic_saati" value="09:00" required class="form-control timepicker required" />
                </div>
            </div>
        </div>
        <div class=" col-sm-6" style="padding: 0;">
            <label class="col-sm-12 col-form-label"><%=LNG("Olay Süresi :")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-user"></i>
                    </span>
                    <input type="text" id="olay_suresi" name="olay_suresi" value="02:00" required class="form-control timepicker required" />
                </div>
            </div>
        </div>
    </div>

    <div class="row toplanti_tipi gundeme_ozel">
        <div class="toplanti_tipi gundeme_ozel col-sm-6" style="padding: 0;">
            <label class="col-sm-12 col-form-label"><%=LNG("Başlangıç Tarihi :")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-user"></i>
                    </span>
                    <input type="text" id="baslangic_tarihi" name="baslangic_tarihi" required class="form-control takvimyap required" />
                </div>
            </div>
        </div>
        <div class="col-sm-6" style="padding: 0;">
            <label class="col-sm-12 col-form-label"><%=LNG("Başlangıç Saati :")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-user"></i>
                    </span>
                    <input type="text" id="baslangic_saati" name="baslangic_saati" class="form-control required timepicker" required />
                </div>
            </div>
        </div>

        <div class="toplanti_tipi gundeme_ozel col-sm-6" style="padding: 0;">
            <label class="col-sm-12 col-form-label"><%=LNG("Bitiş Tarihi :")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-user"></i>
                    </span>
                    <input type="text" id="bitis_tarihi" name="bitis_tarihi" required class="form-control takvimyap required" />
                </div>
            </div>
        </div>
        <div class="col-sm-6" style="padding: 0;">
            <label class="col-sm-12 col-form-label"><%=LNG("Bitiş Saati :")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-user"></i>
                    </span>
                    <input type="text" id="bitis_saati" name="bitis_saati" class="form-control required timepicker" required />
                </div>
            </div>
        </div>
    </div>
    <% end if %>
    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Açıklama")%></label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <textarea id="aciklama" name="aciklama" class="required form-control" style="width: 93%; padding-left: 35px; padding-top: 6px;" required></textarea>
            </div>
        </div>
    </div>

    <script>
        $(function () {
            setTimeout(function () { $("#baslik").focus() }, 500);
            autosize($("#aciklama"));

            $("#renk").spectrum({  
                color:$(this).val(),
                 showPaletteOnly: true,
                showPalette:true,
                hideAfterPaletteSelect:true,
                change: function(color) {
                    $(this).val(color);
                },
                palette: [
                    ["rgb(231, 76, 60)", "rgb(26, 188, 156)", "rgb(46, 204, 113)","rgb(52, 152, 219)", "rgb(241, 196, 15)","rgb(52, 73, 94)"]
                ]
            });

        });
    </script>

    <div class="row" <% if trim(etiket)<>"personel" then %> style="display: none;" <% end if %>>
        <label class="col-sm-12 col-form-label"><%=LNG("Ajanda kaydı senkronize edilecek kişiler :")%></label>
        <div class="col-sm-12">
            <select class="select2" name="kisiler" id="kisiler" multiple="multiple">
                <%
                    SQL="select id, personel_ad + ' ' + personel_soyad as personel_ad_soyad from ucgem_firma_kullanici_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and id != '"& Request.Cookies("kullanici")("kullanici_id") &"' and durum = 'true' and cop = 'false';"
                    set katilimci = baglanti.execute(SQL)
                    do while not katilimci.eof
                %>
                <option value="<%=katilimci("id") %>"><%=katilimci("personel_ad_soyad") %></option>
                <%
                    katilimci.movenext
                    loop
                %>
            </select>
        </div>
    </div>


    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Etiketler :")%></label>
        <div class="col-sm-12">
            <select class="select2" name="etiketler" id="etiketler" multiple="multiple">
                <%
                    songrup = ""
                    SQL="select * from etiketler etiket with(nolock) where etiket.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' order by grup, adi asc;"
                    set etiketler = baglanti.execute(SQL)
                    do while not etiketler.eof
                        if not trim(songrup) = trim(etiketler("grup")) then
                            if not songrup = "" then
                %>
                            </optgroup>
                            <% end if %>
                <optgroup label="<%=etiketler("grup") %>">
                    <%
                            songrup = etiketler("grup")
                        end if
                    %>
                    <option value="<%=etiketler("tip") %>-<%=etiketler("id") %>"><%=etiketler("adi") %></option>
                    <%
                    etiketler.movenext
                    loop
                    %>
                </optgroup>
            </select>
        </div>
    </div>
    <div class="modal-footer">
        <input type="button" onclick="ajanda_olay_kaydet(this, '<%=etiket%>', '<%=etiket_id%>', '<%=yinelemeli%>');" class="btn btn-primary" value="<%=LNG("Yeni Olay Ekle")%>" />

    </div>
</form>
<link rel="stylesheet" type="text/css" href="/files/bower_components/jquery-minicolors/css/jquery.minicolors.css" />
<script src="/files/bower_components/jquery-minicolors/js/jquery.minicolors.min.js"></script>
<%
    elseif trn(request("islem"))="yeni_ajanda_kayit_duzenle" then

        etiket = trn(request("etiket"))
        etiket_id = trn(request("etiket_id"))
        olay_id = trn(request("olay_id"))

        SQL="select *, Isnull(IsID, 0) as is_id from ahtapot_ajanda_olay_listesi where id = '"& olay_id &"'"
        set olay = baglanti.execute(SQL)


        acikmi = true
        if cdbl(olay("is_id"))>0 then

            SQL="select count(id) from ucgem_is_gorevli_durumlari where is_id = '"& olay("is_id") &"' and durum = 'true' and cop = 'false'"
            set kactane = baglanti.execute(SQL)

            if cdbl(kactane(0))>1 then
                acikmi = false
            end if

        end if

%>
<div class="modal-header">
    <%=LNG("Ajanda Kayıt Düzenle")%>
    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
</div>
<form id="koftiform"></form>
<form autocomplete="off" id="yeni_olay_form" class="smart-form validateform" novalidate="novalidate" style="padding: 15px;">
    <div class="row">

        <div class="col-sm-10">
            <label class="col-sm-12 col-form-label" style="padding-left: 0;"><%=LNG("Başlık")%></label>
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <textarea id="baslik" name="baslik" class="required form-control" style="width: 93%; padding-left: 5px; padding-top: 6px;" required><%=olay("title") %></textarea>
                <script>
                    $(function () {
                        setTimeout(function () { $("#baslik").focus();$("window").resize(); }, 500);
                        autosize($("#baslik"));
                    });
                </script>
            </div>
        </div>
        <div class="col-sm-2">
            <label class="col-sm-12 col-form-label" style="padding-left: 0;"><%=LNG("Renk")%></label>
            <input type='text' id="renk" value="<%=olay("color") %>" />
        </div>

    </div>
    <div class="row">
        <div class="col-sm-6" style="padding: 0;">
            <label class="col-sm-12 col-form-label"><%=LNG("Planlanan Başlangıç")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-calendar"></i>
                    </span>
                    <input type="text" <% if acikmi = false then %> disabled="disabled" <% end if %> required class="required form-control takvimyap" value="<%=cdate(olay("baslangic")) %>" name="baslangic_tarihi" id="baslangic_tarihi" />
                </div>
            </div>
        </div>
        <div class="col-sm-6" style="padding: 0;">
            <label class="col-sm-12 col-form-label"><%=LNG("Saat")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-calendar"></i>
                    </span>
                    <input type="text" required <% if acikmi = false then %> disabled="disabled" <% end if %> class="required form-control timepicker" value="<%=left(olay("baslangic_saati"),5) %>" name="baslangic_saati" id="baslangic_saati" />
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-sm-6" style="padding: 0;">
            <label class="col-sm-12 col-form-label"><%=LNG("Planlanan Bitiş :")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-calendar"></i>
                    </span>
                    <input type="text" required <% if acikmi = false then %> disabled="disabled" <% end if %> class="required form-control takvimyap" value="<%=cdate(olay("bitis")) %>" name="bitis_tarihi" id="bitis_tarihi" />
                </div>
            </div>
        </div>
        <div class="col-sm-6" style="padding: 0;">
            <label class="col-sm-12 col-form-label"><%=LNG("Saat :")%></label>
            <div class="col-sm-12">
                <div class="input-group input-group-primary">
                    <span class="input-group-addon">
                        <i class="icon-prepend fa fa-calendar"></i>
                    </span>
                    <input type="text" required <% if acikmi = false then %> disabled="disabled" <% end if %> class="required form-control timepicker" value="<%=left(olay("bitis_saati"),5) %>" name="bitis_saati" id="bitis_saati" />
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <label class="col-sm-12 col-form-label">Gündem</label>
        <div class="col-sm-12">
            <div class="input-group input-group-primary">
                <span class="input-group-addon">
                    <i class="icon-prepend fa fa-cubes"></i>
                </span>
                <textarea id="aciklama" name="aciklama" class="required form-control" style="width: 93%; padding-left: 35px; padding-top: 6px;" required><%=olay("description") %></textarea>
            </div>
        </div>
    </div>

    <script>
        $(function () {
            setTimeout(function () { $("#baslik").focus() }, 500);
            autosize($("#aciklama"));
            $("#renk").spectrum({ 
                color:$(this).val(),
                 showPaletteOnly: true,
                showPalette:true,
                hideAfterPaletteSelect:true,
                change: function(color) {
                    $(this).val(color);
                },
                palette: [
                    ["rgb(231, 76, 60)", "rgb(26, 188, 156)", "rgb(46, 204, 113)","rgb(52, 152, 219)", "rgb(241, 196, 15)","rgb(52, 73, 94)"]
                ]
            });
        });
    </script>

    <div class="row" <% if trim(etiket)<>"personel" then %> style="display: none;" <% end if %>>
        <label class="col-sm-12 col-form-label"><%=LNG("Ajanda kaydı senkronize edilecek kişiler :")%></label>
        <div class="col-sm-12">
            <select class="select2" name="kisiler" id="kisiler" multiple="multiple">
                <%

                    kisiler = olay("kisiler")

                    SQL="select id, personel_ad + ' ' + personel_soyad as personel_ad_soyad from ucgem_firma_kullanici_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and id != '"& Request.Cookies("kullanici")("kullanici_id") &"' and durum = 'true' and cop = 'false';"
                    set katilimci = baglanti.execute(SQL)
                    do while not katilimci.eof
                %>
                <option <% if instr("," & olay("kisiler") & ",", "," & katilimci("id") & ",")>0 then %> selected="selected" <% end if %> value="<%=katilimci("id") %>"><%=katilimci("personel_ad_soyad") %></option>
                <%
                    katilimci.movenext
                    loop
                %>
            </select>
        </div>
    </div>

    <div class="row">
        <label class="col-sm-12 col-form-label"><%=LNG("Etiketler :")%></label>
        <div class="col-sm-12">
            <select class="select2" name="etiketler" id="etiketler" multiple="multiple">
                <%
                    songrup = ""
                    SQL="select * from etiketler etiket with(nolock) where etiket.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' order by grup, adi asc;"
                    set etiketler = baglanti.execute(SQL)
                    do while not etiketler.eof
                        if not trim(songrup) = trim(etiketler("grup")) then
                            if not songrup = "" then
                %>
                            </optgroup>
                            <% end if %>
                <optgroup label="<%=etiketler("grup") %>">
                    <%
                            songrup = etiketler("grup")
                        end if
                    %>
                    <option <% if instr("," & olay("etiketler") & ",", "," & etiketler("tip") & "-" & etiketler("id") & ",")>0 then %> selected="selected" <% end if %> value="<%=etiketler("tip") %>-<%=etiketler("id") %>"><%=etiketler("adi") %></option>
                    <%
                    etiketler.movenext
                    loop
                    %>
                </optgroup>
            </select>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <% if trim(olay("tamamlandi"))="True" then %>
            <input style="float: left;" type="button" onclick="ajanda_olay_durum_guncelle_button('<%=olay("id")%>', '0');" class="btn btn-mini btn-warning" value="<%=LNG("Gerçekleşmedi")%>" />
            <% else %>
            <input style="float: left;" type="button" onclick="ajanda_olay_durum_guncelle_button('<%=olay("id")%>', '1');" class="btn btn-mini btn-success" value="<%=LNG("Gerçekleşti")%>" />
            <% end if %>
            <input style="float: right;" type="button" onclick="ajanda_olay_guncelle(this, '<%=etiket%>', '<%=etiket_id%>', '<%=olay("id")%>');" class="btn btn-mini btn-primary" value="<%=LNG("Olay Güncelle")%>" />
            <input style="float: right; margin-right: 10px;" type="button" onclick="ajanda_olay_sil(this, '<%=etiket%>', '<%=etiket_id%>', '<%=olay("id")%>');" class="btn btn-mini btn-danger" value="<%=LNG("Olay Sil")%>" />
            <%
                ana_kayit_id = olay("ana_kayit_id")
                if isnumeric(ana_kayit_id)=false then
                    ana_kayit_id = 0
                end if
            %>
            <% if cdbl(ana_kayit_id)>0 and trim(olay("ekleyen_id")) = trim(Request.Cookies("kullanici")("kullanici_id")) then %>
            <input style="float: right; margin-right: 10px;" type="button" onclick="ajanda_olay_komple_sil(this, '<%=etiket%>', '<%=etiket_id%>', '<%=olay("ana_kayit_id")%>');" class="btn btn-mini btn-inverse" value="<%=LNG("Tüm Olay Dizisini Sil")%>" />
            <% end if %>
        </div>
    </div>
</form>
<link rel="stylesheet" type="text/css" href="/files/bower_components/jquery-minicolors/css/jquery.minicolors.css" />
<script src="/files/bower_components/jquery-minicolors/js/jquery.minicolors.min.js"></script>
<% 
    
    elseif trn(request("islem"))="anasayfa_proje_durum_bilgisi_getir" then
    
    proje_id = trn(request("proje_id"))

    SQL="select id, proje_adi, santiye_durum_id from ucgem_proje_listesi where id = '"& proje_id &"'"
    set proje_cek = baglanti.execute(SQL)

     SQL="select * from ahtapot_proje_gantt_adimlari where proje_id = '"& proje_id &"' and cop = 'false'"
    set adim = baglanti.execute(SQL)

    if adim.eof then
%>

<br />
<br />
<br />
<br />
<br />
<br />
<center><%=proje_cek("proje_adi") %> <%=LNG("için tanımlananan proje planlaması bulunamadı.")%></center>
<br />
<br />
<br />
<center><input type="button" onclick="sayfagetir('/santiye_detay/', 'jsid=4559&id=<%=proje_id%>&departman_id=<%=santiye_durum_id%>');" value="<%=LNG("Proje Detayı")%>" class="btn btn-primary" /></center>
<br />
<br />
<br />

<%
    response.End
    end if
%>
<script type="text/javascript">

    $(function () {

        google.charts.load('current', { packages: ['corechart', 'bar'] });
        google.charts.setOnLoadCallback(drawStacked);

        function drawStacked() {
            var data = google.visualization.arrayToDataTable([

                ['<%=LNG("Proje")%>', '<%=LNG("Tamamlanan")%>', '<%=LNG("Bekleyen")%>'],
                              
                                <%
                say = 0
                   
                    do while not adim.eof
                        say = say + 1
                %>
                ['<%=adim("name") %>', <%=cint(adim("progress")) %>, <%=100 - cint(adim("progress")) %>],
                           <%
                adim.movenext
                    loop
                %>
        ]);

    var options = {
        chartArea: { width: '50%' },
        isStacked: true,
        hAxis: {
            title: '<%=LNG("Tamamlanma Durumu")%>',
            minValue: 0,
        },
        vAxis: {
            title: '<%=LNG("Projeler")%>'
        },
        colors: ['#93BE52', '#4680ff']
    };
    var chart = new google.visualization.BarChart(document.getElementById('chart_bar'));
    chart.draw(data, options);
    }
        })

</script>
<div id="chart_bar" style="width: auto; height: <%=say *40%>px;"></div>
<% 
    
    elseif trn(request("islem"))="beta_bildirim_yap" then


        bildirim_tipi = trn(request("bildirim_tipi"))
        baslik = trn(request("baslik"))
        dosya_eki = trn(request("dosya_eki"))
        beta_aciklama = trn(request("beta_aciklama"))

        durum = "true"
        cop = "false"
        ekleyen_ip = Request.ServerVariables("Remote_Addr")
        firma_id = Request.Cookies("kullanici")("firma_id")
        ekleyen_id = Request.Cookies("kullanici")("kullanici_id")

        SQL="insert into ahtapot_beta_bildirimleri(bildirim_tipi, baslik, dosya_eki, beta_aciklama, durum, cop, ekleyen_ip, firma_id, ekleyen_id, ekleme_tarihi, ekleme_saati) values('"& bildirim_tipi &"', '"& baslik &"', '"& dosya_eki &"', '"& beta_aciklama &"', '"& durum &"', '"& cop &"', '"& ekleyen_ip &"', '"& firma_id &"', '"& ekleyen_id &"', getdate(), getdate()); SET NOCOUNT ON; EXEC MailGonderBildirim @personel_id = 27, @mesaj = '"& bildirim_tipi & "<br>" & baslik & "<br>" & beta_aciklama & "<br>" & Request.Cookies("kullanici")("kullanici_adsoyad") &"';"
        set ekle = baglanti.execute(SQL)


        
        
        


%>
<br />
<br />
<br />
<br />
<center>
<img src="/img/Gnome-Emblem-Default-48.png" /><br />
    <%=LNG("Bildiriminiz Bize Ulaştı.")%><br /><br />

    <%=LNG("Proskop'a Katkılarınızdan Dolayı Teşekkür Ederiz.")%>
    <br /><br /><br /><br />
    </center>
<%
        
    elseif trn(request("islem"))="siralamakaydet" then

        siralama = request("siralama")
        yaninayaz = "0"

        for indis = 0 to ubound(split(siralama,","))

            temp = split(siralama,",")(indis)

            if instr(temp,"-")>0 then

                menuid = split(temp,"-")(0)
                sira = split(temp,"-")(1)

                sql="update "& request("tablo") &" set sirano = '"& indis &"' where id = '"& menuid &"'"
                set kaydet = baglanti.execute(SQL)

            end if
        next

   
    end if %>