<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

%>
 <script>
    $( function() {
        $("#accordion").accordion();
    });
</script>
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
                    <h5>Otomatik İş Akışları</h5>
                    <input type="button" style="float: right;" class="btn btn-primary" value="Yeni Otomatik İş Akışı Ekle" />
                </div>
                <div class="card-block">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="dt-responsive table-responsive">
                                    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
                           

                                <div id="accordion">

                                    <% for x = 1 to 10 %>
                                          <h3>Kural <%=x %></h3>
                                          <div>
                                              <p>
                                                <div class="row">
                                                    <div class="col-md-4">Eğer</div>
                                                    <div class="col-md-4">Ve (isteğe bağlı)</div>
                                                    <div class="col-md-4">Sonra</div>
                                                </div>
                                              <div class="row">
                                                    <div class="col-md-4">
                                                        <select>
                                                            <option></option>
                                                            <option>İş Emri Eklendi</option>
                                                            <option>İş Emri Kapatıldı</option>
                                                            <option>İş Talebi Eklendi</option>
                                                            <option>Satınalma Siparişi Eklendi</option>
                                                            <option>Satınalma Siparişi Güncellendi</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <select>
                                                            <option></option>
                                                            <option>İş Emri Önceliği</option>
                                                            <option>İş Emri Kullanıcıya Verildi</option>
                                                            <option>İş Emri Kategorisi</option>
                                                            <option>Satın Alma Siparişi Kategorisi</option>
                                                            <option>Satınalma Siparişi Durumu</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <select>
                                                            <option></option>
                                                            <option>Sms Gönder</option>
                                                            <option>Mail Gönder</option>
                                                            <option>Onayla</option>
                                                            <option>Reddet</option>
                                                            <option>Kategori Ekle</option>
                                                            <option>İş Emri Oluştur</option>
                                                        </select>
                                                    </div>
                                                   
                                                </div>
                                              <div class="row">
                                                    <div class="col-md-4">
                                                  <input type="button" value="Kaydet" class="btn btn-primary" /></div></div>
                                              </p>
                                          </div>
                                    <% next %>
</div>


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
