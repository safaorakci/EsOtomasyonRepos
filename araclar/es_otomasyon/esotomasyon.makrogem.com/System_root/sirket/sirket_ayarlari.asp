<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    SQL="select isnull(firma.firma_tema, 1) as firma_tema2, firma.*, sehir.sehir from ucgem_firma_listesi firma left join tanimlama_destinasyon_sehir sehir on sehir.id = firma.firma_sehir where firma.id = '"& Request.Cookies("kullanici")("firma_id") &"'"
    set firma = baglanti.execute(SQL)

%>

<div class="page-body breadcrumb-page">
    <div class="card page-header p-0">
        <div class="card-block front-icon-breadcrumb row align-items-end">
            <div class="breadcrumb-header col">
                <div class="big-icon">
                    <div class="card-block user-info" style=" bottom: -73px;">
                        <div class="media-left">
                            <a href="#" class="profile-image">
                                <img class="user-img img-radius" src="/img/taseron_logo.jpg" style="width: 140px!important; height:149px!important;">
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
                                <input type="file" value="<%=firma("firma_logo") %>" id="firma_logo" tip="buyuk" yol="firma_logo/" class="form-control" />
                            </div>
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

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Firma Şehir")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <select name="firma_sehir" class="select2" onchange="sirket_sehir_sectim_bolge_getir(this.value);" id="firma_sehir">
                                    <%

                                    bolge_id = 0
                                    SQL="select id, sehir from tanimlama_destinasyon_sehir where ulke_id = '85' order by sehir asc"
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

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Firma İlçe")%></label>
                            <div class="col-sm-12 col-lg-12" id="ilce_yeri">
                                <select name="firma_ilce" id="firma_ilce" class="select2">
                                    <%
                                        SQL="select id, bolge from tanimlama_destinasyon_bolge where sehir_id = '"& firma_sehir &"' order by bolge asc"
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