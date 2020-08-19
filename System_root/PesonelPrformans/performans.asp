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
</style>

<div class="card">
    <div class="card-header border-bottom p-3">
        <h6 class="card-title">Performans</h6>
    </div>
    <div class="card-body p-3" id="Performans">
        <script type="text/javascript">
            Performans();
        </script>
    </div>
</div>
