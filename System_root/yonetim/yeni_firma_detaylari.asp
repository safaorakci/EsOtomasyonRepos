<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    firma_id = trn(request("firma_id"))
    yetki_kodu = trn(request("yetki_kodu"))

    SQL="select firma.*, sehir.sehir from ucgem_firma_listesi firma left join tanimlama_destinasyon_sehir sehir on sehir.id = firma.firma_sehir where firma.id = '"& firma_id &"'"
    set firma = baglanti.execute(SQL)

    sayi = 6
    if trim(yetki_kodu)="TASERON" then
        sayi = 8
    end if

%>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <div class="page-body breadcrumb-page">
        <div class="card page-header p-0">
            <div class="card-block front-icon-breadcrumb row align-items-end">
                <div class="breadcrumb-header col">
                    <div class="big-icon">
                        <div class="card-block user-info" style="bottom: -65px;">
                            <div class="media-left">
                                <a href="#" class="profile-image">
                                    <img class="user-img img-radius" src="<%=firma("firma_logo") %>" style="width: 140px;" alt="user-img">
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="d-inline-block" style="padding-left: 175px;">
                        <h5 style="font-size:15px;"><%=firma("firma_adi") %></h5>
                        <span><%=firma("firma_yetkili") %></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <style>
        .md-tabs .nav-item {
            width: calc(100% / <%=sayi%>);
            border-right: solid 1px #007bff;
        }

        .nav-tabs .slide {
            width: calc(100% / <%=sayi%>);
        }

        .yuvarla {
            font-size: 13px;
            border-radius: 50%;
            color: white;
            width: 25px;
            height: 25px;
            background-color: #4099ff;


            font-size: 14px;
            padding: 4px;
            margin-right: 10px;
            color: #fff;
            border-radius: 4px;
            width: 30px;
            display: inline-block;
            height: 30px;
            text-align: center;


        }
        .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active i {
            color: #fff!important;
        }
            .yuvarla i {
                
                font-family: 'themify';
                speak: none;
                font-style: normal;
                font-weight: normal;
                font-variant: normal;
                text-transform: none;
                line-height: 1;
                -webkit-font-smoothing: antialiased;
                -moz-osx-font-smoothing: grayscale;
            }
    </style>

<div class="row">
    <div class="col-lg-12">
        <div class="tabs tabs-style-bar">
            <nav>
                <ul>
                    <li class="nav-link_yeni"><a style="-webkit-border-top-left-radius: 10px; -webkit-border-bottom-left-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-bottomleft: 10px; border-top-left-radius: 10px; border-bottom-left-radius: 10px;" href="#musteri_bilgileri" class="icon icon-home"><span><%=LNG("Müşteri Bilgileri")%></span></a></li>
                    <li class="nav-link_yeni"><a href="#personel_bilgileri" class="icon icon-box"><span><%=LNG("Personel Bilgileri")%></span></a></li>
                </ul>
            </nav>
            <div class="content-wrap">
                <section id="musteri_bilgileri" class="">
                <script>
                        $(function (){
                            musteri_bilgilerini_getir('<%=firma_id %>');
                        });
                    </script>
                </section>
                <section id="personel_bilgileri" class="">
                    <div class="card">
                        <%
                            
        SQL="select top 1 * from ucgem_firma_kullanici_listesi where firma_id = '"& firma_id &"' order by id asc"
        set personel = baglanti.execute(SQL)
                            %>
    <div class="card-header">
        <h5 class="card-header-text"><%=LNG("Personel Bilgileri")%></h5>
        
    </div>
    <div class="card-block">
        <div class="view-info">
            <form id="koftiform"></form>
            <form autocomplete="off" id="personel_guncelleme_form">
                <div class="row">

                    <div class="col-lg-2">
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Personel Resim")%></label>
                            <div class="col-sm-12 col-lg-12" style="margin-bottom: 15px;">
                                <input type="file" value="<%=personel("personel_resim") %>" id="personel_resim" tip="buyuk" yol="personel_resim/" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-5">
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
                             <div class="col-sm-3 col-lg-3" style="display:none;">
                                <select id="personel_maliyet_pb" name="personel_maliyet_pb" class="select2">
                                    <option <% if trim(personel("personel_maliyet_pb"))="TL" then %> selected="selected" <% end if %> value="TL">TL</option>
                                    <option <% if trim(personel("personel_maliyet_pb"))="USD" then %> selected="selected" <% end if %> value="USD">USD</option>
                                    <option <% if trim(personel("personel_maliyet_pb"))="EUR" then %> selected="selected" <% end if %> value="EUR">EUR</option>
                                </select>
                            </div>
                        </div>

                        

                        <div class="row">
                            <div class="col-sm-12">
                                <input type="button" class="btn btn-primary" onclick="personel_bilgilerini_guncelle('<%=personel("id")%>');" value="<%=LNG("Personel Bilgilerini Güncelle")%>" />
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
                                        SQL="select id, departman_adi from tanimlama_departman_listesi where firma_id = '"& firma_id &"' and durum = 'true' and cop = 'false' order by sirano asc;"
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
                                        SQL="select id, gorev_adi from tanimlama_gorev_listesi where firma_id = '"& firma_id &"' and durum = 'true' and cop = 'false' order by gorev_adi asc"
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
                    </div>
                </div>
            </form>

        </div>
    </div>
</div>
                    
                </section>
            </div>
        </div>
    </div>
</div>
		<script>
			(function() {

				[].slice.call( document.querySelectorAll( '.tabs' ) ).forEach( function( el ) {
					new CBPFWTabs( el );
				});

			})();
		</script>
