﻿<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    FirmaID = Request.Cookies("kullanici")("firma_id")

    SQL="select isnull(firma.firma_tema, 1) as firma_tema2, firma.*, sehir.sehir, LEFT(firma.haftaici_baslangic_saati,5) as haftaici_baslangic_saati, LEFT(firma.haftaici_bitis_saati,5) as haftaici_bitis_saati , LEFT(firma.cumartesi_baslangic_saati,5) as cumartesi_baslangic_saati, LEFT(firma.cumartesi_bitis_saati,5) as cumartesi_bitis_saati , LEFT(firma.pazar_baslangic_saati,5) as pazar_baslangic_saati, LEFT(firma.pazar_bitis_saati,5) as pazar_bitis_saati from ucgem_firma_listesi firma left join tanimlama_destinasyon_sehir sehir on sehir.id = firma.firma_sehir where firma.id = '"& Request.Cookies("kullanici")("firma_id") &"'"
    set firma = baglanti.execute(SQL)

%>

<div class="page-body breadcrumb-page" style="margin-top: 15px; margin-bottom: 45px;">
    <div class="card page-header p-0">
        <div class="card-block front-icon-breadcrumb row align-items-end">
            <div class="breadcrumb-header col">
                <div class="big-icon">
                    <div class="card-block user-info" style=" bottom: -85px;">
                        <div class="media-left">
                            <a href="#" class="profile-image">
                                <% if firma("firma_logo") = "undefined" or firma("firma_logo") = null or IsNull(firma("firma_logo")) then %>
                                    <img class="user-img img-radius" src="/img/taseron_logo.jpg" style="width: 140px!important; height:149px!important;">
                                <%else %>
                                    <img class="user-img img-radius" src="<%=firma("firma_logo") %>"" style="width: 140px!important; height:149px!important;">
                                <%end if %>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="d-inline-block" style="padding-left: 175px;">
                    <h5 style="font-size: 15px;"><%=firma("firma_adi") %></h5>
                    <span><%=firma("sehir") %></span>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="card">
    <div class="card-header">
        <h5 class="card-header-text"><%=LNG("Şirket Bilgileri")%></h5>
        <span><%=LNG("Şirket bilgilerinizi bu bölümden güncelleyebilirsiniz.")%></span>
    </div>
    <div class="card-block">
        <div class="view-info">
            <form autocomplete="off" id="sirket_bilgileri_form">
                <div class="row">

                    <div class="col-xl-4">
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Firma Logo")%></label>
                            <div class="col-sm-12 col-lg-12" style="margin-bottom: 15px;">
                                <input type="file" value="<%=firma("firma_logo") %>" id="firma_logo" tip="buyuk" filepath="<%=firma("firma_logo") %>" folder="FirmaLogo" yol="firma_logo/" class="form-control" />
                                <span style="color: #a7a7a7; font-weight: 500;">Max resim boyutu 140 x 145</span>
                            </div>
                        </div>
                         <div class="row">
                            
                            <div class="col-sm-6 col-lg-6">
                                <label class="col-form-label"><%=LNG("Haftaiçi Başlangıç Saati")%></label>
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="haftaici_baslangic" value="<%=firma("haftaici_baslangic_saati") %>" class="form-control" />
                                </div>
                            </div>
                            
                            <div class="col-sm-6 col-lg-6">
                                <label class="col-form-label"><%=LNG("Haftaiçi Bitiş Saati")%></label>
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="haftaici_bitis" value="<%=firma("haftaici_bitis_saati") %>" class="form-control" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            
                            <div class="col-sm-6 col-lg-6">
                                <label class="col-form-label"><%=LNG("Cumartesi Başlangıç Saati")%></label>
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="cumartesi_baslangic" value="<%=firma("cumartesi_baslangic_saati") %>" class="form-control" />
                                </div>
                            </div>
                            
                            <div class="col-sm-6 col-lg-6">
                                <label class="col-form-label"><%=LNG("Cumartesi Bitiş Saati")%></label>
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="cumartes_bitis" value="<%=firma("cumartesi_bitis_saati") %>" class="form-control" />
                                </div>
                            </div>
                        </div>
                         <div class="row">
                            
                        </div>
                        <div class="row">
                            
                            <div class="col-sm-6 col-lg-6">
                                <label class="col-form-label"><%=LNG("Pazar Başlangıç Saati")%></label>
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="pazar_baslangic" value="<%=firma("pazar_baslangic_saati") %>" class="form-control" />
                                </div>
                            </div>
                            
                            <div class="col-sm-6 col-lg-6">
                                <label class="col-form-label"><%=LNG("Pazar Bitiş Saati")%></label>
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="pazar_bitis" value="<%=firma("pazar_bitis_saati") %>" class="form-control" />
                                </div>
                            </div>
                        </div>
                         <div class="row">
                            
                        </div>
                    </div>


                    <div class="col-xl-4">


                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Firma Adı")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="firma_adi" required value="<%=firma("firma_adi") %>" class="form-control" />
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
                                    <input type="text" id="firma_yetkili" required value="<%=firma("firma_yetkili") %>" class="form-control" />
                                </div>
                            </div>
                        </div>

                        <div class="row" style="display:none;">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Firma Şehir")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <select name="firma_sehir" class="select2" onchange="sirket_sehir_sectim_bolge_getir(this.value);" id="firma_sehir">
                                    <%

                                    bolge_id = 0
                                    SQL="select id, sehir from tanimlama_destinasyon_sehir where ulke_id = '85' and firma_id = '"& FirmaID &"' order by sehir asc"
                                    set sehircek = baglanti.execute(SQL)
                                    firma_sehir = firma("firma_sehir")

                                    do while not sehircek.eof
                                        
                                        
                                        if isnumeric(firma_sehir)=false then
                                            firma_sehir = 0
                                        end if
                                        if cdbl(firma_sehir)=0 then
                                            firma_sehir = sehircek("id")
                                        end if

                                    %>
                                    <option <% if trim(sehircek("id"))=trim(firma("firma_sehir")) then %> selected="selected" <% end if %> value="<%=sehircek("id") %>"><%=sehircek("sehir") %></option>
                                    <%
                                    sehircek.movenext
                                    loop
                                    %>
                                </select>
                            </div>
                        </div>

                        <div class="row" style="display:none;">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Firma İlçe")%></label>
                            <div class="col-sm-12 col-lg-12" id="ilce_yeri">
                                <select name="firma_ilce" id="firma_ilce" class="select2">
                                    <%
                                        SQL="select id, bolge from tanimlama_destinasyon_bolge where sehir_id = '"& firma_sehir &"' and firma_id = '"& FirmaID &"' order by bolge asc"
                                        set bolgecek = baglanti.execute(SQL)
                                        do while not bolgecek.eof
                                    %>
                                    <option <% if trim(bolgecek("id"))=trim(firma("firma_bolge")) then %> selected="selected" <% end if %> value="<%=bolgecek("id") %>"><%=bolgecek("bolge") %></option>
                                    <%
                                        bolgecek.movenext
                                        loop
                                    %>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Firma Adres")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <textarea type="text" id="firma_adres" required class="form-control" style="width: 100%;" rows="3"><%=firma("firma_adres") %></textarea>
                                </div>
                            </div>
                        </div>

                       
                    </div>

                    <div class="col-xl-4">
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Firma Telefon")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="firma_telefon" value="<%=firma("firma_telefon") %>" required class="form-control telefon_mask" />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Firma GSM")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="firma_gsm" required class="form-control telefon_mask" value="<%=firma("firma_gsm") %>" />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Firma Vergi Dairesi")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="firma_vergi_daire" required class="form-control" value="<%=firma("firma_vergi_daire") %>" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Firma Vergi No")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="firma_vergi_no" required class="form-control" value="<%=firma("firma_vergi_no") %>" />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Tema")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <select id="firma_tema" name="firma_tema" onchange="sistem_tema_degistir(this.value);" class="select2">
                                    <% for k = 1 to 13 %>
                                    <option <% if cint(firma("firma_tema2"))=cint(k) then %> selected="selected" <% end if %> value="<%=k %>">Tema <%=k %></option>
                                    <% next %>
                                </select>
                            </div>
                        </div>
                         <div class="row">
                            <div class="col-sm-12 col-lg-12">
                                <a href="javascript:void(0);" onclick="firma_bilgilerimi_guncelle();" class="btn btn-primary btn-sm " style="color: white;"><i class="fa  fa-cube"></i>&nbsp;<%=LNG("Firma Bilgilerimi Güncelle")%></a>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
    $(function (){
        fileyap();
    });
</script>