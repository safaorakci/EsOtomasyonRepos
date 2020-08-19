<%@ Page Language="C#" AutoEventWireup="true" CodeFile="gorev_ans.aspx.cs" Inherits="System_root_tanimlamalar_gorev_gorev_ans" %>


<form autocomplete="off" id="form2" runat="server">
</form>
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

    #dt_basic {
        width: 100% !important;
    }

    .border-bottom {
        border-bottom: 1px solid rgba(0, 0, 0, .1) !important;
    }
</style>
<section id="widget-grid" class="">
    <div class="row">
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-4">


            <div class="card">
                <div class="card-header border-bottom p-3">
                    <h5 class="card-title"><% Response.Write(LNG("Görev Ekle")); %></h5>
                </div>
                <div class="card-block p-3">
                    <form id="gorev_ekle_form">
                        <div class="form-group">
                            <label class="col-form-label"><% Response.Write(LNG("Görev Adı")); %></label>
                            <div class="input-group input-group-primary">
                                <span class="input-group-addon">
                                    <i class="icon-prepend fa fa-user"></i>
                                </span>
                                <input type="text" id="gorev_adi" required data-msg="<% Response.Write(LNG("Görev Giriniz")); %>" class="form-control" />
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer p-3">
                    <input type="button" class="btn btn-primary btn-mini" onclick="gorev_ekle();" value="<% Response.Write(LNG("Görev Ekle")); %>" />
                </div>
            </div>

        </article>
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-8">
            <div class="card">
                <div class="card-header border-bottom p-3">
                    <h5 class="card-title"><% Response.Write(LNG("Görev Listesi")); %></h5>
                </div>
                <div class="card-block p-3">
                    <div id="gorev_listesi">
                        <script>
                            $(function () {
                                gorev_listesi();
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
