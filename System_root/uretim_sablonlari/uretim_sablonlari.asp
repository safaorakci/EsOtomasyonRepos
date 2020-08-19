<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<style>
    .ustunegelince {
        background-color: #eff2f7 !important;
        color: #41454e !important;
        text-transform: uppercase !important;
        font-family: Roboto,sans-serif !important;
        font-size: 14px !important;
    }

        .ustunegelince:hover {
            background-color: #bfc4cd !important;
            color: #fff !important;
            padding-left: 25px !important;
        }

    .ustunegelince2:hover {
        background-color: #bfc4cd !important;
        color: #fff !important;
        padding-left: 25px !important;
    }


    .ui-widget-content {
        border: none !important;
    }

    #color-accordion a:nth-child(1) {
        -webkit-border-top-left-radius: 10px;
        -webkit-border-top-right-radius: 10px;
        -moz-border-radius-topleft: 10px;
        -moz-border-radius-topright: 10px;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
    }


    #color-accordion a:nth-last-child(2) {
        -webkit-border-bottom-right-radius: 10px;
        -webkit-border-bottom-left-radius: 10px;
        -moz-border-radius-bottomright: 10px;
        -moz-border-radius-bottomleft: 10px;
        border-bottom-right-radius: 10px;
        border-bottom-left-radius: 10px;
    }

    #color-accordion .accordion-desc {
        border-left: 5px solid #4099ff !important;
        margin-top: 0px !important;
        padding-top: 10px;
    }
</style>
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

    .border-bottom {
        border-bottom: 1px solid #eee !important;
    }
    
    .vertical-align-wbl-middle {
        vertical-align: -webkit-baseline-middle;
    }
</style>

<section id="widget-grid" class="">
    <div class="row">
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="card">
                <div class="card-header card-header-inline border-bottom p-2">
                    <h5 class="card-title mt-1">Üretim Şablonları</h5>
                    <button type="button" onclick="yeni_uretim_sablonu_ekle();" class="btn btn-round btn-labeled btn-success btn-mini text-white float-right"><i class="fa  fa-cube"></i>Yeni Üretim Şablonu Ekle</button>
                </div>
                <div class="card-block p-0">
                    <div id="uretim_sablonlari">
                        <script>
                            $(function (){
                                UretimSablonlariGetir();
                            });
                        </script>
                    </div>
                </div>
            </div>
        </article>
    </div>



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
</section>




