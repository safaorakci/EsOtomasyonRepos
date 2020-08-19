<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

%>

<style type="text/css">
    .d-block {
        display: block;
    }
    .border-bottom {
        border-bottom: 1px solid #ccc !important;
    }
</style>

<section id="widget-grid" class="">
    <div class="row">

        <article class="col-lg-4 ">


            <div class="card">
                <div class="card-header p-3 border-bottom">
                    <h5 class="card-title"><%=LNG("Destek Bildirim Formu")%></h5>
                </div>
                <div id="beta_donus" class="card-body pt-2 pl-3 pr-3">
                    <form id="koftiden"></form>
                    <form autocomplete="off" id="beta_form" runat="server">
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Talep Tipi")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <select name="bildirim_tipi" class="select2" id="bildirim_tipi">
                                    <option value="Teknik Destek"><%=LNG("Teknik Destek")%></option>
                                    <option value="Muhasebe"><%=LNG("Muhasebe")%></option>
                                    <option value="Satış"><%=LNG("Satış")%></option>
                                    <option value="Uzak Bağlantı Talebi"><%=LNG("Uzak Bağlantı Talebi")%></option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-12 p-0">
                            <div class="form-group mb-0">
                                <label class="col-form-label"><%=LNG("Konu")%></label>
                                <input type="text" id="baslik" required class="form-control" placeholder="Konu" />
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Dosya Eki")%></label>
                            <div class="col-sm-12 col-lg-12" style="margin-bottom: 15px;">
                                <input type="file" value="/img/buyukboy.png" id="dosya_eki" tip="kucuk" yol="beta_bildirim/" folder="BetaBildirim" class="form-control" />
                            </div>
                        </div>
                        <div class="col-md-12 p-0">
                            <div class="form-group">
                                <label class="col-form-label"><%=LNG("Açıklama")%></label>
                                <textarea name="beta_aciklama" class="form-control" required id="beta_aciklama" rows="8" style="width: 100%;"></textarea>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer d-block">
                    <a href="https://download.anydesk.com/AnyDesk.exe?_ga=2.2327792.1129373335.1593002156-180077004.1593002156" class="btn btn-info btn-sm float-left">
                        Uzak Bağlantı Programı İndir
                    </a>
                    <input type="button" onclick="beta_bildirim_yap();" class="btn btn-primary btn-sm float-right" value="Gönder"/>
                </div>
            </div>

        </article>

        <article class="col-lg-8 ">
            <div class="card">
                <div class="card-header p-3 border-bottom">
                    <h5><%=LNG("Destek Taleplerim")%></h5>
                </div>
                <div id="beta_liste_donus" class="card-body p-3">
                    <script>
                        $(function (){
                            destek_listesi_getir();
                        });
                    </script>
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
