<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    FirmaID = Request.Cookies("kullanici")("firma_id")
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
                                <button id="grupKaydet" class="btn btn-success mb-3 float-right btn-mini" onclick="HatirlaticiGrupKaydet('/System_Root/ajax/islem1.aspx/GrupTanimi');">Kaydet</button>
                                <button id="grupDuzenle" class="btn btn-info mb-3 float-right btn-mini" style="display:none">Duzenle</button>
                                <!--<button class="btn btn-info btn-mini mb-1" style="cursor: pointer" onclick="GrupListesi();">Grup Listesi</button>-->
                            </div>
                            <div class="form-group" id="GrupListesi">
                                <script>
                                    $(function (){
                                        GrupList();
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
                                        SQL = "select * from Hatirlatici.Grup where Silindi = 'false' and FirmaID = '"& FirmaID &"'"
                                        set grup = baglanti.execute(SQL)
                                        if not grup.eof then
                                        do while not grup.eof
                                    %>
                                    <option value="<%=grup("HatirlaticiGrupID") %>"><%=grup("GrupAdi") %></option>
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
                                    <input type="checkbox" class="js-switch" id="hatirlatma_Chk" onclick="Hatirlatma();" />
                                    <span style="margin-left: 7px; font-size: 13px; font-weight: 600;">Evet</span>
                                </label>
                            </div>
                            <div id="panel_hatirlatici" style="display: none">
                                <hr style="margin-bottom: 5px; margin-top: 5px" />
                                <div class="form-group" style="margin-bottom: 5px">
                                    <i class="fa fa-caret-right mr-2"></i>
                                    <input type="text" class="mr-2" min="1" style="width: 60px; display: none" id="sayi" />
                                    <label class="col-form-label mr-2" id="hatirlama_adi1">Tarihinde Hatırlat</label>
                                    <label class="col-form-label" style="margin-bottom: 0px">
                                        <input type="checkbox" class="form-control js-switch" id="hatirlama_1" />
                                    </label>
                                </div>
                                <div class="form-group" style="margin-bottom: 5px">
                                    <i class="fa fa-caret-right mr-2"></i>
                                    <label class="col-form-label mr-1" id="ilkYazi">Tarihinden </label>
                                    <input type="text" style="width: 60px" id="inputValue" />
                                    <label class="col-form-label ml-1 mr-1" id="ikinciYazi">gün önce hatırlat</label>
                                    <label class="col-form-label" style="margin-bottom: 0px">
                                        <input type="checkbox" class="form-control js-switch" id="degerile" />
                                    </label>
                                </div>
                                <div class="form-group" style="margin-bottom: 5px">
                                    <label class="col-form-label" style="margin-bottom: 0px">
                                        <input type="checkbox" class="form-control js-switch" id="sms_ile" onclick="bildirimAlacakKullanici();"/>
                                        <span class="mr-4" style="margin-left: 5px; font-size: 13px">Sms ile</span>
                                    </label>
                                    <label class="col-form-label" style="margin-bottom: 0px">
                                        <input type="checkbox" class="form-control js-switch" id="mail_ile" onclick="bildirimAlacakKullanici();"/>
                                        <span class="mr-4" style="margin-left: 5px; font-size: 13px">Mail ile</span>
                                    </label>
                                    <label class="col-form-label" style="margin-bottom: 0px">
                                        <input type="checkbox" class="form-control js-switch" id="bildirim_ile" onclick="bildirimAlacakKullanici();"/>
                                        <span class="" style="margin-left: 5px; font-size: 13px">Bildirim ile</span>
                                    </label>
                                </div>
                                <div class="form-group" id="bildirimiAlan" style="display:none">
                                    <label class="col-form-label">Bildirimi Alacak Personel</label>
                                    <select class="form-control" id="bildirimAlacakPersonel">
                                        <option value="0" selected>Personel Seç...</option>
                                        <%
                                            SQL = "select kullanici.id, left(ISNULL((select gorev_adi + ', ' from tanimlama_gorev_listesi where (SELECT COUNT(value) FROM STRING_SPLIT(kullanici.gorevler, ',') WHERE value =  id ) > 0 and cop = 'false' for xml path('')), '----'), len(ISNULL((select gorev_adi + ', ' from tanimlama_gorev_listesi where (SELECT COUNT(value) FROM STRING_SPLIT(kullanici.gorevler, ',') WHERE value =  id ) > 0 and cop = 'false' for xml path('')), '----'))-1) as gorev_adi, kullanici.personel_ad +' '+ kullanici.personel_soyad as ad_soyad from ucgem_firma_kullanici_listesi kullanici with(nolock) where kullanici.cop = 'false' and kullanici.durum = 'true' and kullanici.firma_id = '"& FirmaID &"'"
                                            set personeller = baglanti.execute(SQL)

                                            if not personeller.eof then
                                            do while not personeller.eof
                                        %>
                                            <option value="<%=personeller("id") %>"><%=personeller("ad_soyad") %> <%if personeller("gorev_adi") = "" then %> <%else %> - [<%=personeller("gorev_adi") %>] <%end if %></option>
                                        <%
                                            personeller.movenext
                                            loop
                                            end if
                                        %>
                                    </select>
                                </div>
                                <hr style="margin-bottom: 15px; margin-top: 5px" />
                            </div>
                            <button id="ParametreKaydet" class="btn btn-success mb-3 float-right" onclick="GrupParametreKaydet('/System_Root/ajax/islem1.aspx/ParametreTanimi');">Kaydet</button>
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
                <div class="card-body" id="grupList">
                    <script>
                        $(function (){
                            GrupParametreleri();
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
<!--<script type="text/javascript">
    $(function () {
        var elem = Array.prototype.slice.call(document.querySelectorAll('.js-switch:not(.yapilan)'));
        elem.forEach(function (html) {
            var switchery = new Switchery(html, { color: '#4099ff', jackColor: '#fff', size: 'small' });
        });
        $(".js-switch").addClass("yapilan");
        $('select:not(.yapilan)').select2().addClass("yapilan");
    });
</script>-->
<script type="text/javascript">
    $(document).ready(function () {
        $("#parametreTipi").trigger("onchange");
    });
    function GrupListesi() {
        $("#GrupListesi").slideToggle();
    }
</script>

