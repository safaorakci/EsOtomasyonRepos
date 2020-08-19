<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ans.aspx.cs" Inherits="System_root_tanimlamalar_departman_ans" %>



<form id="form2" runat="server">

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
            border-bottom: 1px solid rgba(0, 0, 0, .1) !important;
        }

        .select2-container--default .select2-selection--single .select2-selection__rendered {
            color: #444;
            padding: 8px 25px 8px 10px;
        }

        .select2-container .select2-selection--single {
            cursor: pointer;
            height: 31px !important;
        }
    </style>
    <section id="widget-grid" class="">
        <div class="row">
            <article class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
                <div class="card">
                    <div class="card-header border-bottom p-3">
                        <h5 class="card-title"><% Response.Write(LNG("Departman Ekle")); %></h5>
                    </div>
                    <div class="card-block p-3">
                        <form autocomplete="off" id="departman_ekle_form">
                            <div class="form-group">
                                <label class="col-form-label"><% Response.Write(LNG("Departman Adı")); %></label>
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="departman_adi" class="form-control" required data-msg="<% Response.Write(LNG("Departman Giriniz")); %>" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-form-label"><% Response.Write(LNG("Departman Tipi")); %></label>
                                <select style="width: 100%" id="departman_tipi" class="form-control form-control-sm select2">
                                    <option value="genel"><% Response.Write(LNG("Genel Departman")); %></option>
                                    <option value="santiye"><% Response.Write(LNG("Proje Departman")); %></option>
                                </select>
                            </div>

                            <div class="row ust_departman_yeri" style="display: none;">
                                <label class="col-sm-12  col-lg-12 col-form-label"><% Response.Write(LNG("Üst Departman")); %></label>
                                <div class="col-sm-12 col-lg-12">
                                    <asp:dropdownlist style="width: 100%" id="ust_id" class="select2" runat="server"></asp:dropdownlist>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <input type="button" class="btn btn-primary btn-mini" onclick="departman_ekle();" value="<% Response.Write(LNG("Departman Ekle")); %>" />
                    </div>
                </div>
            </article>
            <article class="col-xs-12 col-sm-12 col-md-12 col-lg-8">
                <div class="card">
                    <div class="card-header border-bottom p-3">
                        <h5 class="card-title"><% Response.Write(LNG("Departman Listesi")); %></h5>
                    </div>
                    <div class="card-block p-3">
                        <div id="departman_listesi">
                            <script>
                                $(function () {
                                    departman_listesi();
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
</form>
