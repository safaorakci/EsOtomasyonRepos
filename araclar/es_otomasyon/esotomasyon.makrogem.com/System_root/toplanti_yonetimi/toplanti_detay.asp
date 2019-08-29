<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

%>
<style>
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

    .table td, .table th {
        padding: .75rem !important;
    }

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
<%
    toplanti_id = trn(request("toplanti_id"))

    SQL="select * from ahtapot_toplanti_listesi where id = '"& toplanti_id &"'"
    set toplanti = baglanti.execute(SQL)

    SQL="select * from ahtapot_toplanti_kaydi where id = '"& toplanti("toplanti_kayit_id") &"'"
    set kayit = baglanti.execute(SQL)

%>
<input type="hidden" name="toplanti_id" id="toplanti_id" value="<%=toplanti_id %>" />
<div class="row">
    <div class="col-md-6 col-xl-3">
        <div class="card bg-c-blue notification-card">
            <div class="card-block">
                <div class="row align-items-center">
                    <div class="col-4 notify-icon"><i class="fa fa-calendar-plus-o"></i></div>
                    <div class="col-8 notify-cont">
                        <h4>4</h4>
                        <p><%=LNG("Davetli Sayısı")%></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-6 col-xl-3">
        <div class="card bg-c-green notification-card">
            <div class="card-block">
                <div class="row align-items-center">
                    <div class="col-4 notify-icon"><i class="fa fa-calendar-check-o"></i></div>
                    <div class="col-8 notify-cont">
                        <h4>1</h4>
                        <p><%=LNG("Bekleyen Gündem Sayısı")%></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-6 col-xl-3">
        <div class="card bg-c-yellow notification-card">
            <div class="card-block">
                <div class="row align-items-center">
                    <div class="col-4 notify-icon"><i class="fa fa-calendar-minus-o"></i></div>
                    <div class="col-8 notify-cont">
                        <h4>3</h4>
                        <p><%=LNG("Alınan Karar")%></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-6 col-xl-3">
        <div class="card bg-c-pink notification-card">
            <div class="card-block">
                <div class="row align-items-center">
                    <div class="col-4 notify-icon"><i class="fa fa-check-square-o"></i></div>
                    <div class="col-8 notify-cont">
                        <h4>0</h4>
                        <p><%=LNG("Bekleyen Görev")%></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<div class="page-body breadcrumb-page">
    <div class="card page-header p-0">
        <div class="card-block front-icon-breadcrumb row align-items-end">
            <div class="breadcrumb-header col">
                <div class="big-icon">
                    <i class="icofont icofont-home"></i>
                </div>
                <div class="d-inline-block">
                    <h5 style="font-size: 15px;"><%=kayit("toplanti_adi") %></h5>
                    <span><%=day(cdate(toplanti("toplanti_tarihi"))) %>&nbsp;<%=monthname(month(cdate(toplanti("toplanti_tarihi")))) %>&nbsp;<%=year(cdate(toplanti("toplanti_tarihi"))) %>&nbsp;<%=weekdayname(weekday(cdate(toplanti("toplanti_tarihi")))) %></span>
                </div>
                <div style="float: right; text-align: center;">
                    <div class="label label-inverse" style="width: 125px; text-align: center; padding: 10px; margin-top: -20px;">
                        <span style="line-height: 25px;"><i class="fa fa-clock-o"></i><%=LNG("Geçen Süre")%></span><br />
                        <span style="font-size: 25px;" id="counter">00:00</span>
                    </div>
                </div>
                <script>
                        $(function () {
                            sayac_baslat();
                        });
                </script>
            </div>
            <div class="col" style="display: none;">
                <div class="page-header-breadcrumb">
                    <ul class="breadcrumb-title" style="display: none;">
                        <li class="breadcrumb-item"><a href="javascript:void(0);" class="btn btn-labeled btn-success btn-mini btn-round" style="color: white;"><span class="btn-label" style="color: white;"><i class="fa fa-trash-o"></i></span>&nbsp;<%=LNG("Toplantıyı Başlat")%></a>
                        </li>
                        <li class="breadcrumb-item"><a href="javascript:void(0);" class="btn btn-labeled btn-info btn-mini btn-round" style="color: white;"><span class="btn-label" style="color: white;"><i class="fa fa-history"></i></span>&nbsp;<%=LNG("Toplantıyı Düzenle")%></a>
                        </li>
                        <li class="breadcrumb-item"><a href="javascript:void(0);" class="btn btn-labeled btn-danger btn-mini btn-round" style="color: white;"><span class="btn-label" style="color: white;"><i class="fa fa-history"></i></span>&nbsp;<%=LNG("Toplantıyı Ertele")%></a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .md-tabs .nav-item {
        width: calc(100% / 4);
        border-right: solid 1px #007bff;
    }

    .nav-tabs .slide {
        width: calc(100% / 4);
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
        color: #fff !important;
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
                    <li class="nav-link_yeni"><a style="-webkit-border-top-left-radius: 10px; -webkit-border-bottom-left-radius: 10px; -moz-border-radius-topleft: 10px; -moz-border-radius-bottomleft: 10px; border-top-left-radius: 10px; border-bottom-left-radius: 10px;" href="#gundem_tab" onclick="toplanti_gundem_listesi('<%=toplanti_id %>', this);" class="icon icon-home"><span><%=LNG("Gündemler")%></span></a></li>
                    <li class="nav-link_yeni"><a href="#notlar_tab" onclick="toplanti_not_listesi('<%=toplanti_id %>', this);" class="icon icon-box"><span><%=LNG("Notlar")%></span></a></li>
                    <li class="nav-link_yeni"><a href="#kararlar_tab" onclick="toplanti_karar_listesi('<%=toplanti_id %>');" class="icon icon-upload"><span><%=LNG("Kararlar")%></span></a></li>
                    <li class="nav-link_yeni"><a onclick="toplanti_is_listesi('<%=toplanti("toplanti_kayit_id") %>');" style="-webkit-border-top-right-radius: 10px; -webkit-border-bottom-right-radius: 10px; -moz-border-radius-topright: 10px; -moz-border-radius-bottomright: 10px; border-top-right-radius: 10px; border-bottom-right-radius: 10px;" href="#is_listesi_tab" class="icon icon-tools"><span><%=LNG("İş Listesi")%></span></a></li>
                </ul>
            </nav>
            <div class="content-wrap">
                <section id="gundem_tab" class="toplanti_tablar">
                    <script>
                        $(function (){
                            toplanti_gundem_listesi('<%=toplanti_id %>');
                        });
                    </script>
                </section>
                <section id="notlar_tab" class="toplanti_tablar"></section>
                <section id="kararlar_tab" class="toplanti_tablar"></section>
                <section id="is_listesi_tab" class="toplanti_tablar"></section>
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
<% if 1 = 2 then %>
<div class="row">
    <div class="col-lg-12">
        <!-- tab header start -->
        <div class="tab-header card">
            <ul class="nav nav-tabs md-tabs tab-timeline" style="border: solid 1px #007bff;" role="tablist" id="mytab">
                <li class="nav-item">
                    <a class="nav-link active" data-toggle="tab" href="#gundem_tab" onclick="toplanti_gundem_listesi('<%=toplanti_id %>', this);" role="tab"><span class="yuvarla"><i class="icofont icofont-home"></i></span><%=LNG("Gündem")%></a>
                    <div class="slide"></div>
                </li>
                <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",40,")>0 then %>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#notlar_tab" onclick="toplanti_not_listesi('<%=toplanti_id %>', this);" role="tab"><span class="yuvarla" style="background-color: #F88EA4;"><i class="icofont icofont-ui-user "></i></span><%=LNG("Notlar")%></a>
                    <div class="slide"></div>
                </li>
                <% end if %>
                <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",41,")>0 then %>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#kararlar_tab" onclick="toplanti_karar_listesi('<%=toplanti_id %>', this);" role="tab"><span class="yuvarla" style="background-color: #2ed8b6;"><i class="icofont icofont-ui-message"></i></span><%=LNG("Kararlar")%></a>
                    <div class="slide"></div>
                </li>
                <% end if %>
                <% if instr(Request.Cookies("kullanici")("yetkili_sayfalar"), ",42,")>0 then %>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#is_listesi_tab" onclick="toplanti_is_listesi('<%=toplanti_id %>', this);" onclick=' return false;' role="tab"><span class="yuvarla" style="background-color: #f1c40f;"><i class="icofont icofont-ui-settings"></i></span><%=LNG("İş Listesi")%></a>
                    <div class="slide"></div>
                </li>
                <% end if %>
            </ul>
        </div>
        <div class="tab-content">
            <div class="tab-pane active toplanti_tablar" id="gundem_tab" role="tabpanel">
                <script>
                        $(function (){
                            toplanti_gundem_listesi('<%=toplanti_id %>');
                        });
                </script>
            </div>

            <div class="tab-pane toplanti_tablar" id="notlar_tab" role="tabpanel">
            </div>

            <div class="tab-pane toplanti_tablar" id="kararlar_tab" role="tabpanel">
            </div>

            <div class="tab-pane toplanti_tablar" id="is_listesi_tab" role="tabpanel">
            </div>
        </div>
    </div>
</div>
<% end if %>

<link rel="stylesheet" type="text/css" href="/files/assets/pages/timeline/style.css">
<script src="/files/assets/pages/store-js/store.min.js"></script>


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


