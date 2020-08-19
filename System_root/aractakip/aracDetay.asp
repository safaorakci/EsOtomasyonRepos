<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    FirmaID = Request.Cookies("kullanici")("firma_id")
    id = trn(request("id"))

    SQL = "select AracTakipAracID, Marka, Model, Yil, Plaka from AracTakip.Arac where AracTakipAracID = '"& id &"' and FirmaID = '"& FirmaID &"' and Silindi = 'false' and Durum = 'true'"
    set aracDetaylari = baglanti.execute(SQL)

%>
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

<div class="page-body breadcrumb-page">
    <div class="card page-header p-0">
        <div class="card-block front-icon-breadcrumb row align-items-end">
            <div class="breadcrumb-header col">
                <div class="d-inline-block">
                    <h5 style="font-size: 15px;" id="plaka"><%=aracDetaylari("Plaka") %></h5>
                    <span>Plakalı Aracın Detayları</span>
                </div>
                <span style="float: right;">
                    <a href="javascript:void(0);" onclick="sayfagetir('/aracTakip/','jsid=4559');" class="btn btn-mini btn-labeled btn-success  btn-round" style="color: white; float: right; margin-right: 10px;"><span class="btn-label" style="color: white;"><i class="fa fa-history"></i></span>&nbsp;Geri Dön</a>
                </span>
            </div>
        </div>
    </div>
</div>

<section id="widget-grid">
    <div class="row">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header" style="padding: 15px !important; border-bottom: 1px solid #ccc">
                    <h6 class="mb-0">Araç Kilometre Kayıtları</h6>
                </div>
                <div class="card-body" id="AracTakipKilometreKayitlari">
                    <script>
                        $(function(){
                            AracTakipKilometreKayitlari(<%=aracDetaylari("AracTakipAracID") %>);
                        });
                    </script>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card">
                <div class="card-header" style="padding: 15px !important; border-bottom: 1px solid #ccc">
                    <h6 class="mb-0">Kilometre Bilgileri</h6>
                </div>

                <div class="card-body">
                    <div class="form-group" style="margin-bottom: 0.25rem">
                        <label class="col-form-label">Kilometre</label>
                        <input type="text" class="form-control" id="aracKilometre" placeholder="Km" />
                    </div>
                    <button class="btn btn-success btn-mini mt-2 float-right" id="AracKilometreKaydet" onclick="AracKilometreKaydet('/System_Root/ajax/islem1.aspx/AracKilometreKaydet', '<%=aracDetaylari("AracTakipAracID") %>');">Kaydet</button>
                    <button class="btn btn-info btn-mini mt-2 float-right" id="AracKilometreDuzenlemeYap" style="display: none">Güncelle</button>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header" style="padding: 15px !important; border-bottom: 1px solid #ccc">
                    <h6 class="mb-0">Servis Bakım Kayıtları</h6>
                </div>
                <div class="card-body" id="ServisBakimKayitlari">
                    <script>
                        $(function(){
                            ServisBakimKayitlari(<%=aracDetaylari("AracTakipAracID") %>);
                        });
                    </script>
                </div>
            </div>
        </div>
    </div>
</section>

<script type="text/javascript">
    $(document).ready(function () {
        $("#aracKilometre").keypress(function (e) {
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                return false;
            }
        });
    });
</script>

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
