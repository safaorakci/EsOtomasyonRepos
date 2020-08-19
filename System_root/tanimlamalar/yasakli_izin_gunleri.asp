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

    .border-bottom {
        border-bottom: 1px solid #eee !important;
    }
</style>
<section id="widget-grid" class="">
    <div class="row">
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
            <div class="card">
                <div class="card-header border-bottom p-3">
                    <h5 class="card-title">Yasaklı İzin Günleri Ekle</h5>
                </div>
                <div class="card-block p-3">
                    <form autocomplete="off" id="departman_ekle_form">
                        <div class="form-group">
                            <label class="col-form-label"><% Response.Write(LNG("Başlangıç Tarihi")) %></label>
                            <input type="text" class="takvimyap form-control" name="baslangic_tarihi" id="baslangic_tarihi" value="<%=FormatDate(date, "00") %>" />
                        </div>
                        <div class="form-group">
                            <label class="col-form-label"><% Response.Write(LNG("Başlangıç Tarihi")) %></label>
                            <input type="text" class="takvimyap form-control" name="bitis_tarihi" id="bitis_tarihi" value="<%=FormatDate(date, "00") %>" />
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <input type="button" class="btn btn-primary btn-mini" onclick="YasakliGunEkle();" value="<% Response.Write(LNG("Yasaklı Gün Ekle")) %>" />
                </div>
            </div>
        </article>
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-8">
            <div class="card">
                <div class="card-header border-bottom p-3">
                    <h5 class="card-title"><% Response.Write(LNG("Yasaklı İzin Günleri")) %></h5>
                </div>
                <div class="card-block p-3">
                    <div id="yasakli_izin_listesi">
                        <script>
                            $(function (){
                                tanimlama_yasakli_getir();
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
    <script>
        $(function (){
            var elem = Array.prototype.slice.call(document.querySelectorAll('.js-switch:not(.yapilan)'));
            elem.forEach(function (html) {
                var switchery = new Switchery(html, { color: '#4099ff', jackColor: '#fff', size: 'small' });
            });
        $(".js-switch").addClass("yapilan");
            $('select:not(.yapilan)').select2().addClass("yapilan");
        });
    </script>
</section>
