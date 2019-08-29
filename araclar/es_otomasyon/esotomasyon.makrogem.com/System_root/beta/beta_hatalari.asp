<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

%>
<section id="widget-grid" class="">
    <div class="row">
        
        <article class="col-lg-4 ">


            <div class="card">
                <div class="card-header">
                    <h5><%=LNG("Destek Bildirim Formu")%></h5>
                </div>
                <div id="beta_donus" class="card-block">
                    <form id="koftiden"></form>
                    <form autocomplete="off" id="beta_form" runat="server">
                        
                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Departman")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <select name="bildirim_tipi" class="select2" id="bildirim_tipi">
                                    <option value="Teknik Destek"><%=LNG("Teknik Destek")%></option>
                                    <option value="Muhasebe"><%=LNG("Muhasebe")%></option>
                                    <option value="Satış"><%=LNG("Satış")%></option>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Konu")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <input type="text" id="baslik" required class="form-control" />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Dosya Eki")%></label>
                            <div class="col-sm-12 col-lg-12" style="margin-bottom: 15px;">
                                <input type="file" value="/img/buyukboy.png" id="dosya_eki" tip="kucuk" yol="beta_bildirim/" class="form-control" />
                            </div>
                        </div>

                              <div class="row">
                            <label class="col-sm-12  col-lg-12 col-form-label"><%=LNG("Açıklama")%></label>
                            <div class="col-sm-12 col-lg-12">
                                <div class="input-group input-group-primary">
                                    <span class="input-group-addon">
                                        <i class="icon-prepend fa fa-user"></i>
                                    </span>
                                    <textarea name="beta_aciklama" required id="beta_aciklama" rows="8" style="width:100%;"></textarea>
                                </div>
                            </div>
                        </div>
                      

                    </form>

                    <div class="row modal-footer" style="margin-top: 20px;">
                        <input type="button" onclick="beta_bildirim_yap();" class="btn btn-primary" value="<%=LNG("Gönder")%>" />
                    </div>
                </div>
            </div>

        </article>

        <article class="col-lg-8 ">


            <div class="card">
                <div class="card-header">
                    <h5><%=LNG("Destek Taleplerim")%></h5>
                </div>
                <div id="beta_liste_donus" class="card-block">
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