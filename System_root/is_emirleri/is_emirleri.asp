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
<section id="widget-grid" class="">
    <div class="row">
        <article class="col-xs-12 ">
            <div class="card">
                <div class="card-header">
                    <h5>Satınalma Siparişleri</h5>
                    <input type="button" style="float: right;" class="btn btn-primary" onclick="ModalSatinalmaEkle();" value="Yeni Satınalma Siparişi" />
                </div>
                <div class="card-block">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="dt-responsive table-responsive">
                                <table id="simpletable" class="table table-striped table-bordered nowrap datatableyap" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th data-hide="phone,tablet" style>ID</th>
                                            <th data-hide="phone,tablet" style="width:60px;">Öncelik</th>
                                            <th data-class="expand">Başlık</th>
                                            
                                            <th data-hide="phone,tablet">Tarih</th>
                                            
                                            <th data-hide="phone,tablet">Tedarikçi</th>
                                            <th data-hide="phone,tablet">Toplam Maliyet</th>
                                            <th data-hide="phone,tablet">Toplam Adet</th>
                                            <th data-hide="phone,tablet" style="width:60px;">Durum</th>
                                            <th data-hide="phone,tablet">Ekleyen</th>
                                            <th>İşlem</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for x = 1 to 25 %>
                                        <tr>
                                            <td style="text-align: center;"><%=x %></td>
                                            <% if x mod 7 = 0 then %>
                                            <td class="label-warning" style="text-align:center;"><span class="label label-warning arkaplansiz">Düşük</span></td>
                                            <% elseif x mod 5 = 0 then %>
                                            <td class="label-danger" style="text-align:center;"><span class="label label-danger arkaplansiz">Yüksek</span></td>
                                            <% else %>
                                            <td class="label-info" style="text-align:center;"><span class="label label-info arkaplansiz">Normal</span></td>
                                            <% end if %>
                                            <td>Sarf Malzemeleri</td>
                                            
                                            <td>09.04.2019</td>
                                            <td>Tedarikçi Ltd Şti.</td>
                                            <td>1400,00 TL</td>
                                            <td>14</td>
                                            <td>Salih ŞAHİN<br />
                                                09.04.2019</td>
                                            <% if x mod 3 = 0 then %>
                                            <td class="label-info" style="text-align:center;"><span class="label label-info arkaplansiz">Sipariş Edildi</span></td>
                                            <% elseif x mod 5 = 0 then %>
                                            <td class="label-warning" style="text-align:center;"><span class="label label-warning arkaplansiz">Onay Bekliyor</span></td>
                                            <% elseif x mod 7 = 0 then %>
                                            <td class="label-danger" style="text-align:center;"><span class="label label-danger arkaplansiz">İptal Edildi</span></td>
                                            <% else %>
                                            <td class="label-success" style="text-align:center;"><span class="label label-success arkaplansiz">Tamamlandı</span></td>
                                            <% end if %>
                                            <td class="icon-list-demo2" style="width: 100px;">
                                                <a href="javascript:void(0);" rel="tooltip" data-placement="top" data-original-title="Parça Detaylarını Görüntüle">
                                                    <i class="fa fa-external-link"></i>
                                                </a>
                                                &nbsp;
                                        <a href="javascript:void(0);" rel="tooltip" data-placement="top" data-original-title="Taşeron Sil">
                                            <i class="ti-trash"></i>
                                        </a>
                                            </td>
                                        </tr>
                                        <% next %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </article>
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
