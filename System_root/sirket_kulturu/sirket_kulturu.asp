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
        padding:0px;
    }

    .yetmislik {
        margin-bottom:5px;
    }
</style>

<div class="card">
    <div class="card-header border-bottom p-3">
        <h6 class="card-title">Şirket Kültür Listesi</h6>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-6">
                <span class="f-15 font-weight-bold">Departmanlar</span>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <div class="col-md-2 float-right p-0">
                        <select class="form-control form-control-sm d-none" id="maxRows">
                            <option value="5000">Tüm Liste</option>
                            <option value="10">10</option>
                            <option value="25">25</option>
                            <option value="50">50</option>
                            <option value="75">75</option>
                            <option value="100">100</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-12 p-0 mt-2" id="DepartmanListesi">
            <script type="text/javascript">
                DepartmanListesi();
            </script>
        </div>
        <div class="pagination-container float-right">
            <nav>
                <ul class="pagination">
                    <li data-page="prev">
                        <span>< <span class="sr-only">(current)</span></span>
                    </li>
                    <li data-page="next" id="prev">
                        <span>> <span class="sr-only">(current)</span></span>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>

<script type="text/javascript">
    getPagination("#Departman-Listesi");
</script>
