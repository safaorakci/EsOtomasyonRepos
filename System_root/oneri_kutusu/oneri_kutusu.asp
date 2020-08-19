<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001
%>

<style type="text/css">
    .select2-container--default .select2-selection--single .select2-selection__rendered {
        color: #444;
        padding: 8px 25px 8px 10px;
    }

    .select2-container .select2-selection--single {
        cursor: pointer;
        height: 31px !important;
    }

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

    .f-11 {
        font-size: 11px;
    }

    .f-15 {
        font-size: 15px;
    }

    .f-20 {
        font-size: 20px;
    }

    .cursor-pointer {
        cursor: pointer !important;
    }

    .main-body .page-wrapper {
        padding: 0.8rem;
    }

    .dt-toolbar {
        padding: 0px;
    }

    .yetmislik {
        margin-bottom: 5px;
    }
</style>

<div class="card">
    <div class="card-header p-3 border-bottom">
        <h6 class="card-title">Öneri Kutusu</h6>
    </div>
    <div class="card-body p-3">
        <div class="row">
            <div class="col-md-4">
                <div class="form-group mb-0">
                    <label class="col-form-label">Departman</label>
                    <select class="form-control form-control-sm select2" id="OneriDepartman">
                        <option selected="selected" value="0">- Departman Seç -</option>
                        <%
                            SQL = "select * from tanimlama_departman_listesi where durum = 'true' and cop = 'false' and firma_id = '"& Request.Cookies("kullanici")("firma_id") &"'"
                            set departmanListesi = baglanti.execute(SQL)

                            if not departmanListesi.eof then
                                do while not departmanListesi.eof
                        %>
                        <option value="<%=departmanListesi("id") %>"><%=departmanListesi("departman_adi") %></option>
                        <%
                                departmanListesi.movenext
                                loop
                            end if
                        %>
                    </select>
                </div>
                <div class="form-group mb-0">
                    <label class="col-form-label">Başlık</label>
                    <input type="text" class="form-control form-control-sm" placeholder="Başlık" id="OneriBaslik" />
                </div>
                <div class="form-group">
                    <label class="col-form-label">Açıklama</label>
                    <textarea class="form-control form-control-sm" placeholder="Açıklama" id="OneriAciklama"></textarea>
                </div>
                <div class="form-group">
                    <button type="button" class="btn btn-success btn-mini float-right" onclick="PersonelOneriEkle();">Kaydet</button>
                </div>
            </div>
            <div class="col-md-8">
                <div class="row">
                    <div class="col-md-12">
                        <h6 class="font-weight-bold">Öneri Listesi</h6>
                    </div>
                    <div class="col-md-12" id="PersonelOneriListesi">
                        <script type="text/javascript">
                            PersonelOnerileri();
                        </script>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
