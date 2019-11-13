<%@ Page Language="C#" AutoEventWireup="true" CodeFile="firma_yonetimi.aspx.cs" Inherits="System_root_firma_yonetimi_firma_yonetimi" %>




<section id="widget-grid" class="">
    <div class="row">
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-8">

            <div class="card">
                <div class="card-header">
                    <h5><% Response.Write(LNG("Firma Listesi")); %></h5>
                </div>
                <div class="card-block">
                    <div id="firma_listesi">
                        <script>
                            $(function () {
                                firma_listesi('MUSTERI');
                            });
                        </script>
                    </div>
                </div>
            </div>
        </article>
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-4">


            <div class="card">
                <div class="card-header">
                    <h5><% Response.Write(LNG("Firma Ekle")); %></h5>
                </div>
                <div class="card-block">
                    <input id="ManagersDatas" type="hidden" />
                    <form autocomplete="off" id="firma_ekle_form" runat="server">
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><% Response.Write(LNG("Firma Logo")); %></label>
                            <div class="col-sm-12 col-lg-12" style="margin-bottom: 15px;">
                                <input type="file" value="/img/buyukboy.png" id="firma_logo" tip="buyuk" yol="firma_logo/" class="form-control" folder="FirmaLogo"/>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><% Response.Write(LNG("Firma Adı")); %></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="firma_adi" required class="form-control" />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><% Response.Write(LNG("Yetkili Kişi")); %></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="firma_yetkili" required class="form-control" />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><% Response.Write(LNG("Yetkili Kişi Telefon")); %></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" required data-mask="0(999) 999 99 99" placeholder="0(532) 123 45 67" id="yetkili_telefon" class="form-control" />
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><% Response.Write(LNG("Yetkili Kişi E-Posta")); %></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="email" id="yetkili_mail" class="form-control" />

                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><% Response.Write(LNG("Firma Telefon")); %></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" required data-mask="0(999) 999 99 99" placeholder="0(532) 123 45 67" id="firma_telefon" class="form-control" />
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><% Response.Write(LNG("Firma E-Posta")); %></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="email" id="firma_mail" class="form-control" />

                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><% Response.Write(LNG("Supervisor")); %></label>
                            <div class="col-sm-12 col-lg-12">
                                <asp:dropdownlist id="firma_supervisor_id" runat="server"></asp:dropdownlist>
                            </div>
                        </div>


                    </form>
                    

                    <div class="row modal-footer" style="margin-top: 20px;">
                        <input type="button" style="float:left; margin-left:45px;" class="btn btn-warning" onclick="ModalYetkiliEkle();" value="Firma Yetkilisi Ekle" autocomplete="new-password">
                        <input type="button" onclick="firma_ekle('MUSTERI');" class="btn btn-primary" value="Firma Ekle" />
                    </div>
                </div>
            </div>

        </article>
        
    </div>
    <style>
    .table > caption + thead > tr:first-child > td, .table > caption + thead > tr:first-child > th, .table > colgroup + thead > tr:first-child > td, .table > colgroup + thead > tr:first-child > th, .table > thead:first-child > tr:first-child > td, .table > thead:first-child > tr:first-child > th {
        border-top:1px solid #ccc!important;
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
    </style>
</section>






