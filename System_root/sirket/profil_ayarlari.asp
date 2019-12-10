<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    personel_id = Request.Cookies("kullanici")("kullanici_id")

    SQL="select gorev.gorev_adi, kullanici.* from ucgem_firma_kullanici_listesi kullanici join tanimlama_gorev_listesi gorev on gorev.id = kullanici.gorevler where kullanici.id = '"& personel_id &"' and kullanici.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"'"
    set personel = baglanti.execute(SQL)

    personel_resim = personel("personel_resim")
    if len(trim(personel_resim))<15 then
        personel_resim = "/img/user.png"
    end if

%>
<script type="text/javascript">
    if ($(window).width() < 500) {
        $("#mobilGorunum").css("padding-left", "0px");
        $("#userCardBlock").css("height", "140px");
        $("#userGorunum").css("margin-left", "-40px").css("margin-top", "-29px");
        $("#userPhoto").css("width", "120px").css("height", "119px");
    }
    else {
        $("#userPhoto").css("width", "140px").css("height", "149px !important");
    }
</script>
<div class="page-body breadcrumb-page">
    <div class="card page-header p-0">
        <div class="card-block front-icon-breadcrumb row align-items-end" id="userCardBlock">
            <div class="breadcrumb-header col">
                <div class="big-icon">
                    <div class="card-block user-info" id="userGorunum" style=" bottom: -73px;">
                        <div class="media-left">
                            <a href="#" class="profile-image">
                                <img class="user-img img-radius" src="<%=personel_resim %>" id="userPhoto" style="width: 140px; height:149px !important">
                            </a>
                        </div>
                    </div>
                </div>
                <div id="mobilGorunum" class="d-inline-block" style="padding-left: 175px;">
                    <h5 style="font-size: 15px;"><%=personel("personel_ad") & " " & personel("personel_soyad") %></h5>
                    <span><%=personel("gorev_adi") %></span>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="row">
    <div class="col-lg-12">
        <div class="tabs tabs-style-bar">
            <nav>
                <ul>
                    <li class="nav-link_yeni"><a style="-webkit-border-top-left-radius: 10px; -webkit-border-bottom-left-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-bottomleft: 10px; border-top-left-radius: 10px; border-bottom-left-radius: 10px;" href="#personel_bilgileri" id="personel_ilk_buton" onclick="profil_personel_bilgileri_getir('<%=personel_id %>', this);" class="icon icon-home"><span><%=LNG("Personel")%></span></a></li>

                    <li class="nav-link_yeni"><a href="#giris_cikis" onclick="profil_personel_giris_cikis_getir('<%=personel_id %>', this);" class="icon icon-box"><span><%=LNG("Giriş-Çıkış Bilgileri")%></span></a></li>
                    <li class="nav-link_yeni"><a href="#izin_bilgileri" onclick="profil_personel_izin_getir('<%=personel_id %>', this);" class="icon icon-display"><span><%=LNG("İzin Bilgileri")%></span></a></li>
                    <li class="nav-link_yeni"><a href="#mesai_bilgileri" onclick="profil_personel_mesai_getir('<%=personel_id %>', this);" class="icon icon-upload"><span><%=LNG("Mesai Bilgileri")%></span></a></li>
                    <li class="nav-link_yeni"><a href="#dosyalar" onclick="profil_personel_dosya_getir('<%=personel_id %>', this);" class="icon icon-tools"><span><%=LNG("Dosyalar")%></span></a></li>
                    <li class="nav-link_yeni"><a href="#bordrolar" onclick="profil_personel_bordro_getir('<%=personel_id %>', this);" class="icon icon-tools"><span><%=LNG("Bordrolarım")%></span></a></li>
                </ul>
            </nav>
            <div class="content-wrap">
                <section id="personel_bilgileri" class="personel_tablar">
                    
                </section>
                <section id="giris_cikis" class="personel_tablar"></section>
                <section id="izin_bilgileri" class="personel_tablar"></section>
                <section id="mesai_bilgileri" class="personel_tablar"></section>
                <section id="dosyalar" class="personel_tablar"></section>
                <section id="bordrolar" class="personel_tablar"></section>
            </div>
        </div>
    </div>
</div>

<script>
	(function() {
		[].slice.call( document.querySelectorAll( '.tabs' ) ).forEach( function( el ) {
			new CBPFWTabs( el );
		});
        $("#personel_ilk_buton").click();
	})();
</script>
