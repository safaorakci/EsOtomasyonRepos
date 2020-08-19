<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001
%>

<style type="text/css">
    .border-bottom {
        border-bottom: 1px solid rgba(0, 0, 0, .2) !important;
    }

    .border-right {
        border-right: 1px solid rgba(0, 0, 0, .2) !important;
    }

    .border {
        border: 1px solid rgba(0, 0, 0, .2) !important;
    }

    .main-body .page-wrapper {
        padding: 0.8rem;
    }

    .f-11 {
        font-size: 11px !important;
    }

    .f-13 {
        font-size: 13px !important;
    }

    .cursor-pointer {
        cursor: pointer !important;
    }

    .img-40 {
        width: 40px;
    }

    .round {
        border-radius: 5px;
    }
</style>

<div class="card">
    <div class="card-header border-bottom p-3">
        <h6 class="card-title">Toplantı Yönetimi</h6>
    </div>
    <div class="card-body p-3">
        <div class="row">
            <div class="col-md-3">
                <div class="form-group">
                    <label class="col-form-label">Toplantı Grup Adı</label>
                    <input type="text" class="form-control form-control-sm" placeholder="Group adı" id="GrupAdi" />
                    <button type="button" class="btn btn-success btn-mini mt-2 f-11 font-weight-bold float-right" onclick="ToplantiGrubuEkle();">Kaydet</button>
                </div>
            </div>
            <div class="col-md-9">
                <label class="col-form-label font-weight-bold">Toplantı Grubu</label>

                <div class="accordion mt-2" id="accordionExample">
                    <script type="text/javascript">
                        ToplantiGrubu();
                    </script>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    })
</script>
