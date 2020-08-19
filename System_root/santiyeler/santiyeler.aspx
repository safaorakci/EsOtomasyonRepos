<%@ Page Language="C#" AutoEventWireup="true" CodeFile="santiyeler.aspx.cs" Inherits="System_root_santiyeler_santiyeler" %>

<form autocomplete="off" id="form1" runat="server">
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
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-header-text" style="width: 100%; font-size: 20px;"><% Response.Write(LNG("PROJELER")); %>
                        <div style="float: right; margin-right: 15px;"><a href="javascript:void(0);" onclick="yeni_santiye_ekle(<%=Request.QueryString["ustId"] %>);" class="btn btn-round btn-labeled btn-success"><i class="fa  fa-cube"></i><% Response.Write(LNG("Yeni Proje Ekle")); %></a></div>
                    </h5>
                </div>
                <div style="padding-left: 25px; padding-right: 25px;">
                    <asp:listbox id="hizli_proje_arama" onchange="hizli_proje_sectim(this);" class="select2" runat="server"></asp:listbox>
                </div>
                <div class="card-block accordion-block color-accordion-block">
                    <div>
                        <div>
                            <div class="color-accordion" id="color-accordion">
                            <asp:repeater id="santiyeler_repeater" runat="server">
                                <ItemTemplate>
                        <a class="accordion-msg ustunegelince" 
                            onclick="proje_ic_liste_getir(<%# DataBinder.Eval(Container.DataItem, "id") %>, <%=Request.QueryString["ustId"] %>);" 
                            href="#collapseOne<%# DataBinder.Eval(Container.DataItem, "id") %>" id="acilacak_santiye<%# DataBinder.Eval(Container.DataItem, "id") %>" style="color:#4f4e4e; border-top:1px solid #fff; font-weight:normal; "><i class="fa fa-map-o projeikon"></i>&nbsp;&nbsp;<%# DataBinder.Eval(Container.DataItem, "durum_adi") %>
                            <div style="float: right; width: 50px; padding: 6px; text-align: center; -webkit-border-radius: 10px; -moz-border-radius: 10px; border-radius: 10px; margin-top: -25px; position: absolute; right: 30px; ">
                            <div class="pcoded-badge label label-inverse" style="width:35px; font-size:100%;">
                            <%# DataBinder.Eval(Container.DataItem, "santiye_sayisi") %>
                                </div>
                            </div>
                        </a>
                        <div class="accordion-desc">
                            <ps>
                                <div id="accoric<%# DataBinder.Eval(Container.DataItem, "id") %>">

                                </div>
                            </ps>
                        </div>
                        </ItemTemplate>
                            </asp:repeater>
                        </div>
                        </div>

                        <div id="accordiv2" class="col-md-6">


                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>

        $(function () {

            var icons = {
                header: "zmdi zmdi-chevron-down",
                activeHeader: "zmdi zmdi-chevron-up"
            };

            $("#color-accordion").accordion({
                heightStyle: "content",
                icons: icons,
                active: 50,
                collapsible: true
            });

            $("#hizli_proje_arama").attr("size", "1");

            var songrup = "";
            $("#hizli_proje_arama option").each(function () {
                var grup = $(this).attr("optiongroup");
                if (grup != songrup) {
                    songrup = grup;
                    $("select#hizli_proje_arama option[optiongroup='" + grup + "']").wrapAll("<optgroup label='" + grup + "'>");
                }
            });

            // $("#accordiv2").html($("#accordiv1").html());
        });

    </script>



    <%
        string acilacak = "0";
        try
        {
            acilacak = Request.QueryString["acilacak"].ToString();
        }
        catch (Exception)
        {

        }

        if (acilacak != "0")
        {
    %>
    <script>
        $(function () {
            setTimeout(function () {
                $("#acilacak_santiye" + <%Response.Write(acilacak);%>).click();
            }, 300);
        });
    </script>
    <%
        }
    %>
</form>
