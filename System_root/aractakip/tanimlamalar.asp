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
                <div class="card" style="margin-bottom: 15px">
                    <div class="card-header" id="headingOne" style="padding: 15px !important; border-bottom: 1px solid #ccc">
                        <h6 class="mb-0">
                            <a class="btn-link" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne" style="cursor: pointer">Grup Tanımı</a>
                            <i class="fa fa-chevron-down float-right" style="color: #ccc; font-size: 1rem"></i>
                        </h6>
                    </div>

                    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
                        <div class="card-body">
                            <div class="form-group">
                                <label class="col-form-label">Grup Adı</label>
                                <input type="text" id="grupAdi" class="form-control" placeholder="Grup Adı" required />
                            </div>
                            <div class="form-group">
                                <button id="grupKaydet" class="btn btn-success mb-3 float-right btn-mini" onclick="AracTakipGrupKaydet('/System_Root/ajax/islem1.aspx/AracTakipGrupKaydet');">Kaydet</button>
                                <button id="grupDuzenle" class="btn btn-info mb-3 float-right btn-mini" style="display:none">Duzenle</button>
                                <!--<button class="btn btn-info btn-mini mb-1" style="cursor: pointer" onclick="GrupListesi();">Grup Listesi</button>-->
                            </div>
                            <div class="form-group" id="AracTakipGrupListesi">
                                <script>
                                    $(function () {
                                        AracTakipGrupList();
                                    });
                                </script>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card" id="parametreTanimi">
                    <div class="card-header" id="headingTwo" style="padding: 15px !important; border-bottom: 1px solid #ccc">
                        <h6 class="mb-0">
                            <a class="btn-link" id="parametre" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo" style="cursor: pointer">Parametre Tanımı</a>
                            <i class="fa fa-chevron-down float-right" style="color: #ccc; font-size: 1rem"></i>
                        </h6>
                    </div>
                    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
                        <div class="card-block">
                            <div class="form-group">
                                <label class="col-form-label">Grup Adı</label>
                                <select id="gruplar" class="form-control">
                                    <option value="0">Grup Seç</option>
                                    <%
                                        SQL = "select * from AracTakip.Grup where Silindi = 'false'"
                                        set grup = baglanti.execute(SQL)

                                        if not grup.eof then
                                        do while not grup.eof
                                    %>
                                        <option value="<%=grup("AracTakipGrupID") %>"><%=grup("GrupAdi") %></option>
                                    <%
                                        grup.movenext
                                        loop
                                        end if
                                    %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label class="col-form-label">Parametre Adı</label>
                                <input type="text" id="parametreAdi" class="form-control" placeholder="Parametre Adı" required />
                            </div>
                            <div class="form-group">
                                <label class="col-form-label">Parametre Tipi</label>
                                <select id="parametreTipi" class="form-control" onchange="tip();">
                                    <option value="0">Tip Seç</option>
                                    <option value="Metin">Metin</option>
                                    <option value="Tarih">Tarih</option>
                                    <option value="Sayi">Sayı</option>
                                </select>
                            </div>
                            <div class="form-group" id="hatirlatma">
                                <label class="col-form-label">Hatırlatma</label>
                                <label class="col-form-label" style="margin-bottom: 0px">
                                    <span style="margin-left: 30px; margin-right: 7px; font-size: 13px; font-weight: 600;">Hayır</span>
                                    <input type="checkbox" class="js-switch" id="hatirlatma_chk" />
                                    <span style="margin-left: 7px; font-size: 13px; font-weight: 600;">Evet</span>
                                </label>
                            </div>
                            <button id="ParametreKaydet" class="btn btn-success mb-3 float-right" onclick="AracTakipGrupParametreKaydet('/System_Root/ajax/islem1.aspx/AracTakipGrupParametreKaydet');">Kaydet</button>
                            <button id="ParametreDuzenle" class="btn btn-info mb-3 float-right" style="display: none">Düzenle</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-8">
            <div class="card">
                <div class="card-header" style="border-bottom: 1px solid #ccc; padding: 15px">
                    <h6 class="mb-0">Parametre Tanımlamaları</h6>
                </div>
                <div class="card-body" id="aracTakipParametreleri">
                    <script>
                        $(function (){
                            AracaTakipParametreleri();
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
