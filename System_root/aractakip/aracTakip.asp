<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    FirmaID = Request.Cookies("kullanici")("firma_id")
    tarih = Year(date)

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
            <div class="card">
                <div class="card-header" style="padding: 15px !important; border-bottom: 1px solid #ccc">
                    <h6 class="mb-0">Araç Bilgileri</h6>
                </div>

                <div class="card-body" id="grupDeger">
                    <div class="form-group" style="margin-bottom:0.25rem">
                        <label class="col-form-label">Marka</label>
                        <input type="text" class="form-control" id="aracMarka" placeholder="Marka"/>
                    </div>
                    <div class="form-group" style="margin-bottom:0.25rem">
                        <label class="col-form-label">Model</label>
                        <input type="text" class="form-control" id="aracModel" placeholder="Model"/>
                    </div>
                    <div class="form-group" style="margin-bottom:0.25rem">
                        <label class="col-form-label">Yıl</label>
                        <select class="form-control select2" id="aracYil">
                            <%
                                for x = 1 to 51
                            %>
                                <option value="<%=tarih %>"><%=tarih %></option>
                            <%
                                tarih = tarih - 1
                                next
                            %>
                        </select>
                    </div>
                    <div class="form-group" style="margin-bottom:0.25rem">
                        <label class="col-form-label">Plaka</label>
                        <input type="text" class="form-control" id="aracPlaka" placeholder="Plaka"/>
                    </div>
                    <button class="btn btn-success float-right mt-3" id="aracBilgileriKaydet" onclick="aracBilgileriKaydet('/System_Root/ajax/islem1.aspx/aracBilgileriKaydet');">Kaydet</button>
                </div>
            </div>
        </div>
        <div class="col-md-8">
            <div class="card">
                <div class="card-header" style="padding: 15px !important; border-bottom: 1px solid #ccc">
                    <h6 class="mb-0">Araç Takip Kayıtları</h6>
                </div>
                <div class="card-body" id="AracTakipKayitlari">
                    <script>
                        $(function(){
                            AracTakipKayitlari();
                        });
                    </script>
                </div>
            </div
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
