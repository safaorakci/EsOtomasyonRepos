<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<%  
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001
%>

<style type="text/css">
    .border-bottom {
        border-bottom: 1px solid rgba(0, 0, 0, .1) !important;
    }

    .border-right {
        border-right: 1px solid rgba(0, 0, 0, .1) !important;
    }

    .border {
        border: 1px solid rgba(0, 0, 0, .1) !important;
    }

    .border-bottom-0 {
        border-bottom: none !important;
    }

    .border-top-0 {
        border-top: none !important;
    }

    .border-bottom-radio-0 {
        border-bottom-left-radius: 0px;
        border-bottom-right-radius: 0px;
    }

    .border-top-radio-0 {
        border-top-left-radius: 0px;
        border-top-right-radius: 0px;
    }

    .card-culture:hover > .card-header {
        background-color: #eee;
    }

    .card:hover {
        box-shadow: 0px 1px 2px 0px #ccc;
    }

    .main-body .page-wrapper {
        padding: 0.8rem;
    }

    .f-15 {
        font-size: 15px !important;
    }

    .f-20 {
        font-size: 20px !important;
    }

    .cursor-pointer {
        cursor: pointer !important;
    }

    .float-right {
        float: right !important;
    }

    .wt-40 {
        width: 40px;
    }

    .arrow-icon {
        transition: .8s all;
    }

    .flip {
        -webkit-transform: rotate(180deg);
        -moz-transform: rotate(180deg);
        -o-transform: rotate(180deg);
        -ms-transform: rotate(180deg);
        transform: rotate(180deg);
    }

    .dt-toolbar {
        padding: 0px;
    }

    .yetmislik {
        margin-bottom: 5px;
    }

    .select2-container--default .select2-selection--single .select2-selection__rendered {
        color: #444;
        padding: 8px 25px 8px 10px;
    }

    .select2-container .select2-selection--single {
        cursor: pointer;
        height: 31px !important;
    }

    section {
        padding: 60px 0;
    }

        section .section-title {
            text-align: center;
            color: #007b5e;
            margin-bottom: 50px;
            text-transform: uppercase;
        }

    #tabs {
        background: #007b5e;
        color: #eee;
    }

        #tabs h6.section-title {
            color: #eee;
        }

        #tabs .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
            font-weight: normal !important;
            color: black !important;
            border: 1px solid rgba(0, 0, 0, .1) !important;
            border-top-left-radius: .25rem;
            border-top-right-radius: .25rem;
            margin-top: 0px !important;
        }

    .nav-item:hover {
        padding-bottom: 0px !important;
    }

    .nav-link {
        padding: 10px !important;
    }

    #tabs .nav-tabs .nav-link {
        border: 1px solid transparent;
        border-top-left-radius: .25rem;
        border-top-right-radius: .25rem;
        color: #eee;
        font-size: 20px;
    }
</style>


<script type="text/javascript">
    $(document).ready(function () {
        if (window.innerWidth < 768) {
            $(".questionTitle").addClass("mt-2");
        }
        else {
            $(".questionTitle").removeClass("mt-2");
        }
    });
</script>

<div class="card">
    <div class="card-header border-bottom p-3">
        <h6 class="card-title">Personel Puanlama</h6>
    </div>
    <div class="card-body p-3">

        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item">
                <a class="nav-link active cursor-pointer" id="criterion-tab" data-toggle="tab" onclick="TabsPassage('criterion');" aria-selected="true">Puanlama Kriterleri</a>
            </li>
            <li class="nav-item">
                <a class="nav-link cursor-pointer" id="scoring-tab" data-toggle="tab" onclick="TabsPassage('scoring');" aria-selected="false">Personel Puanlama</a>
            </li>
        </ul>
        <div class="tab-content border border-top-0 p-3" id="myTabContent">
            <div class="tab-pane fade show active" id="criterion" role="tabpanel" aria-labelledby="criterion-tab">
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label class="col-form-label">Puanlama Sorusu</label>
                            <input type="text" class="form-control form-control-sm" placeholder="Soru" id="PuanlamaSorusu" />
                        </div>
                        <div class="form-group">
                            <button type="button" class="btn btn-success btn-mini" onclick="PersonelPuanlamaSorulariEkle();">Kaydet</button>
                        </div>
                    </div>
                    <div class="col-md-9">
                        <div class="row">
                            <div class="col-md-12">
                                <span class="f-15 font-weight-bold">Puanlama Soruları</span>
                            </div>
                            <div class="col-md-12" id="PersonelPuanlamaSorulari">
                                <script type="text/javascript">
                                    PersonelPuanlamaSorulari();
                                </script>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="tab-pane fade" id="scoring" role="tabpanel" aria-labelledby="scoring-tab">
                <div class="col-md-12 p-0">
                    <div class="col-md-3 col-lg-2 p-0 float-none">
                        <div class="form-group">
                            <label class="col-form-label">Personel</label>
                            <select class="form-control form-control-sm select2" onchange="PersonelPuanlama();" id="Personeller">
                                <option value="0" selected="selected">- Personel Seç -</option>
                                <%
                            SQL = "select id, personel_ad +' '+ personel_soyad as AdSoyad from ucgem_firma_kullanici_listesi where durum = 'true' and cop = 'false' and firma_id = '"& Request.Cookies("kullanici")("firma_id") &"'"
                            set Kullanicilar = baglanti.execute(SQL)

                            if not Kullanicilar.eof then
                                do while not Kullanicilar.eof
                                %>
                                <option value="<%=Kullanicilar("id") %>"><%=Kullanicilar("AdSoyad") %></option>
                                <%
                                Kullanicilar.movenext
                                loop
                            end if
                                %>
                            </select>
                        </div>
                    </div>
                    <hr />
                    <div class="col-lg-12 col-big-lg-7 col-md-12 float-none" id="PersonelPuanlama">
                        <script type="text/javascript">
                            PersonelPuanlama(0);
                        </script>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
