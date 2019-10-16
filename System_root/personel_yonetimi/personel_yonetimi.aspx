<%@ Page Language="C#" AutoEventWireup="true" CodeFile="personel_yonetimi.aspx.cs" EnableViewState="false" Inherits="System_root_personel_yonetimi_personel_yonetimi" %>

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
<section id="widget-grid" class="">
    <div class="row">
        
        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-8">

            <div class="card">
                <div class="card-header">
                    <h5><% Response.Write(LNG("Personel Listesi")); %></h5>
                </div>
                <div class="card-block">
                    <div id="personel_listesi">
                        <script>
                            $(function () {
                                personel_listesi();
                            });
                        </script>
                    </div>
                </div>
            </div>
        </article>


        <article class="col-xs-12 col-sm-12 col-md-12 col-lg-4">


            <div class="card">
                <div class="card-header">
                    <h5><% Response.Write(LNG("Personel Ekle")); %></h5>
                </div>
                <div class="card-block">

                    <form autocomplete="off" id="personel_ekle_form" runat="server">
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><% Response.Write(LNG("Personel Resim")); %></label>
                            <div class="col-sm-12 col-lg-12" style="margin-bottom:15px;">
                                <input type="file" value="/img/buyukboy.png" id="personel_resim" tip="buyuk" yol="personel_resim/" class="form-control" folder="PersonelResim"/>
                            </div>
                        </div>


                         <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><% Response.Write(LNG("Personel T.C. No")); %></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                        <input type="text" id="personel_tcno" required class="form-control" />
                                </div>
                            </div>
                        </div>



                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><% Response.Write(LNG("Personel Ad")); %></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                        <input type="text" id="personel_ad" required class="form-control" />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><% Response.Write(LNG("Personel Soyad")); %></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                        <input type="text" id="personel_soyad" class="form-control" required />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><% Response.Write(LNG("Personel Doğum Tarihi")); %></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" class="takvimyap form-control" id="personel_dtarih" required />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><% Response.Write(LNG("Personel Cinsiyet")); %></label>
                            <div class="col-sm-12 col-lg-12">
                                <select style="width: 100%" id="personel_cinsiyet" class="select2">
                                    <option><% Response.Write(LNG("Bay")); %></option>
                                    <option><% Response.Write(LNG("Bayan")); %></option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><% Response.Write(LNG("Personel E-Posta")); %></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                        <input type="email" id="personel_eposta" class="form-control" required />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><% Response.Write(LNG("Personel Telefon")); %></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                        <input type="text" id="personel_telefon" class="form-control" required data-mask="0(999) 999 99 99" placeholder="0(532) 123 45 67" />
                                </div>
                            </div>
                        </div>
                        <div class="row" style="display:none">
                            <label class="col-sm-12  col-lg-12 col-form-label"><% Response.Write(LNG("Departman")); %></label>
                            <div class="col-sm-12 col-lg-12">
                                <asp:dropdownlist ID="departmanlar" runat="server"></asp:dropdownlist>
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><% Response.Write(LNG("Görev")); %></label>
                            <div class="col-sm-12 col-lg-12">
                                <asp:dropdownlist ID="gorevler" runat="server"></asp:dropdownlist>
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><% Response.Write(LNG("Parola")); %></label>
                            <div class="col-sm-12 col-lg-12">
                                <input type="password" id="personel_parola" required class="form-control" />
                            </div>
                        </div>

                        
                    </form>

                    <div class="row modal-footer" style="margin-top:20px;">
                            <input type="button" id="personel_ekle" onclick="personel_ekle();" class="btn btn-primary" value="<% Response.Write(LNG("Personel Ekle")); %>" />
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




