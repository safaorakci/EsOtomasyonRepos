<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

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

<section id="widget-grid">
    <div class="row">
        <div class="col-md-4">
            <div class="accordion" id="accordionExample">
                <div class="card">
                    <div class="card-header border-bottom p-3" id="headingOne" style="padding: 15px !important; border-bottom: 1px solid #ccc">
                        <h6 class="card-title mb-0">
                            Zorunlu Belgeler
                        </h6>
                    </div>

                    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
                        <div class="card-body p-3">
                            <div class="form-group mb-1">
                                <label class="col-form-label">Dosya Adı</label>
                                <input type="text" id="dosyaAdi" class="form-control" placeholder="Dosya Adı" required />
                            </div>
                            <div class="form-group">
                                <label class="col-form-label" style="margin-right: 10px">Zorunlu</label>
                                <div class="col-md-12">
                                    <div class="row">
                                        <label id="sms_label" class="col-form-label" style="margin-bottom: 0px">
                                            <span style="margin-right: 3px; font-size: 13px; font-weight: 600;">Hayır</span>
                                            <input type="checkbox" class="form-control js-switch" id="zorunlu" />
                                            <span style="margin-left: 3px; font-size: 13px; font-weight: 600;">Evet</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer p-3">
                            <button id="dosyaDuzenle" class="btn btn-info float-right btn-mini" style="display:none">Düzenle</button>
                            <button id="dosyaKaydet" class="btn btn-success float-right btn-mini" onclick="ZorunluDosyaKayıt('/System_Root/ajax/islem1.aspx/ZorunluDosyaKayıt');">Kaydet</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-8">
            <div class="card">
                <div class="card-header border-bottom p-3">
                    <h6 class="mb-0">Tanımlanan Belgeler</h6>
                </div>
                <div class="card-body p-3" id="dosyalar">
                    <script>
                        $(function (){
                            ZorunluDosyaListesi();
                        });
                    </script>
                </div>
            </div>
        </div>
    </div>
</section>
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

