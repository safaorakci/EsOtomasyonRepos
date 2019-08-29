<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001


%>
    <style>
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
<%
    SQL="declare @cari_id int = "& request.Cookies("kullanici")("firma_id") &", @cari_tip NVARCHAR(50) = 'firma'; SELECT ( SELECT ISNULL(SUM(cari.meblag), 0) FROM cari_hareketler cari JOIN ucgem_firma_listesi firma ON firma.id = borclu_id AND firma.cop = 'false' WHERE cari.borclu_tipi = @cari_tip AND cari.alacakli_id = @cari_id AND cari.parabirimi = 'TL' AND cari.cop = 'false' ) AS borclu_tl, ( SELECT ISNULL(SUM(meblag), 0) FROM cari_hareketler cari JOIN ucgem_firma_listesi firma ON firma.id = borclu_id AND firma.cop = 'false' WHERE borclu_tipi = @cari_tip AND alacakli_id = @cari_id AND parabirimi = 'USD' AND cari.cop = 'false' ) AS borclu_usd, ( SELECT ISNULL(SUM(meblag), 0) FROM cari_hareketler cari JOIN ucgem_firma_listesi firma ON firma.id = borclu_id AND firma.cop = 'false' WHERE borclu_tipi = @cari_tip AND alacakli_id = @cari_id AND parabirimi = 'EUR' AND cari.cop = 'false' ) AS borclu_eur, ( SELECT ISNULL(SUM(meblag), 0) FROM cari_hareketler cari JOIN ucgem_firma_listesi firma ON firma.id = alacakli_id AND firma.cop = 'false' WHERE alacakli_tipi = @cari_tip AND borclu_id = @cari_id AND parabirimi = 'TL' AND cari.cop = 'false' ) AS alacakli_tl, ( SELECT ISNULL(SUM(meblag), 0) FROM cari_hareketler cari JOIN ucgem_firma_listesi firma ON firma.id = alacakli_id AND firma.cop = 'false' WHERE alacakli_tipi = @cari_tip AND borclu_id = @cari_id AND parabirimi = 'USD' AND cari.cop = 'false' ) AS alacakli_usd, ( SELECT ISNULL(SUM(meblag), 0) FROM cari_hareketler cari JOIN ucgem_firma_listesi firma ON firma.id = alacakli_id AND firma.cop = 'false' WHERE alacakli_tipi = @cari_tip AND borclu_id = @cari_id AND parabirimi = 'EUR' AND cari.cop = 'false' ) AS alacakli_eur, ( ( SELECT ISNULL(SUM(meblag), 0) FROM cari_hareketler cari JOIN ucgem_firma_listesi firma ON firma.id = borclu_id AND firma.cop = 'false' WHERE borclu_tipi = @cari_tip AND alacakli_id = @cari_id AND parabirimi = 'TL' AND cari.cop = 'false' ) - ( SELECT ISNULL(SUM(meblag), 0) FROM cari_hareketler cari JOIN ucgem_firma_listesi firma ON firma.id = alacakli_id AND firma.cop = 'false' WHERE alacakli_tipi = @cari_tip AND borclu_id = @cari_id AND parabirimi = 'TL' AND cari.cop = 'false' ) ) AS bakiye_tl, ( ( SELECT ISNULL(SUM(meblag), 0) FROM cari_hareketler cari JOIN ucgem_firma_listesi firma ON firma.id = borclu_id AND firma.cop = 'false' WHERE borclu_tipi = @cari_tip AND alacakli_id = @cari_id AND parabirimi = 'USD' AND cari.cop = 'false' ) - ( SELECT ISNULL(SUM(meblag), 0) FROM cari_hareketler cari JOIN ucgem_firma_listesi firma ON firma.id = cari.alacakli_id AND firma.cop = 'false' WHERE alacakli_tipi = @cari_tip AND borclu_id = @cari_id AND parabirimi = 'USD' AND cari.cop = 'false' ) ) AS bakiye_usd, ( ( SELECT ISNULL(SUM(meblag), 0) FROM cari_hareketler cari JOIN ucgem_firma_listesi firma ON firma.id = borclu_id AND firma.cop = 'false' WHERE borclu_tipi = @cari_tip AND alacakli_id = @cari_id AND parabirimi = 'EUR' AND cari.cop = 'false' ) - ( SELECT ISNULL(SUM(meblag), 0) FROM cari_hareketler cari JOIN ucgem_firma_listesi firma ON firma.id = cari.alacakli_id AND firma.cop = 'false' WHERE alacakli_tipi = @cari_tip AND borclu_id = @cari_id AND parabirimi = 'EUR' AND cari.cop = 'false' ) ) AS bakiye_eur;"
    set tabela = baglanti.execute(SQL)
 %>
    <div class="row">
        <!-- notification counter start -->
        <div class="col-md-12 col-lg-4">

            <div class="card bg-c-green notification-card">
                <div class="card-block">
                    <div class="row">
                        
                        <div class="col-md-9" style="padding:0; padding-left:10px;">
                            <div class="row" style="padding:0;">
                                <div class="col-xs-12" style="padding: 10px;">
                                    <center>
                                <h5 style="font-weight:300; line-height:45px;"><i class="fa fa-money"></i> <%=LNG("Toplam Nakit Girişi")%></h5>
                            </center>
                                </div>
                            </div>
                            <div class="row align-items-center" style="padding:0; padding-top:15px;">
                                <div class="col-4" style="padding:0;">
                                    <h5 style="font-size:13px;"><%=formatnumber(tabela("borclu_tl"),0) %> ₺</h5>
                                </div>
                                <div class="col-4 notify-cont" style="padding:0;">
                                    <h5 style="font-size:13px;"><%=formatnumber(tabela("borclu_usd"),0) %> $</h5>
                                </div>
                                <div class="col-4 notify-cont" style="padding:0;">
                                    <h5 style="font-size:13px;"><%=formatnumber(tabela("borclu_eur"),0) %> €</h5>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div id="chart_Exploading" style="width: 100%; height: 150px;"></div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="col-md-12 col-lg-4">
            <div class="card bg-c-pink notification-card">
                <div class="card-block">
                    <div class="row">
                        
                        <div class="col-md-9" style="padding:0; padding-left:10px;">
                            <div class="row" style="padding:0;">
                                <div class="col-xs-12" style="padding: 10px;">
                                    <center>
                                <h5 style="font-weight:300; line-height:45px;"><i class="fa fa-money"></i> <%=LNG("Toplam Nakit Çıkışı")%></h5>
                            </center>
                                </div>
                            </div>
                            <div class="row align-items-center" style="padding:0; padding-top:15px;">
                                <div class="col-4" style="padding:0;">
                                    <h5 style="font-size:13px;"><%=formatnumber(tabela("alacakli_tl"),0) %> ₺</h5>
                                </div>
                                <div class="col-4 notify-cont" style="padding:0;">
                                    <h5 style="font-size:13px;"><%=formatnumber(tabela("alacakli_usd"),0) %> $</h5>
                                </div>
                                <div class="col-4 notify-cont" style="padding:0;">
                                    <h5 style="font-size:13px;"><%=formatnumber(tabela("alacakli_eur"),0) %> €</h5>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div id="chart_Exploading2" style="width: 100%; height: 150px;"></div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="col-md-12 col-lg-4">
            <div class="card bg-c-blue notification-card">
                <div class="card-block">
                    <div class="row">
                        <div class="col-md-9" style="padding:0; padding-left:10px;">
                            <div class="row" style="padding:0;">
                                <div class="col-xs-12" style="padding: 10px;">
                                    <center>
                                <h5 style="font-weight:300; line-height:45px;"><i class="fa fa-money"></i> <%=LNG("Net Nakit Girişi")%></h5>
                            </center>
                                </div>
                            </div>
                            <div class="row align-items-center" style="padding:0; padding-top:15px;">
                                <div class="col-4" style="padding:0;">
                                    <h5 style="font-size:13px;"><%=formatnumber(tabela("bakiye_tl"),0) %> ₺</h5>
                                </div>
                                <div class="col-4 notify-cont" style="padding:0;">
                                    <h5 style="font-size:13px;"><%=formatnumber(tabela("bakiye_usd"),0) %> $</h5>
                                </div>
                                <div class="col-4 notify-cont" style="padding:0;">
                                    <h5 style="font-size:13px;"><%=formatnumber(tabela("bakiye_eur"),0) %> €</h4>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div id="chart_Exploading3" style="width: 100%; height: 150px;"></div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-12">
            <div class="card">
                <div class="card-header">
                    <h5><%=LNG("Cari Hesap Listesi")%></h5>
                    <span><%=LNG("Bu bölümden firmalarınızın cari hareketlerinin takibini yapabilirsiniz.")%></span>
                </div>
                <div id="cari_hareket_listesi" class="card-block">
                    <script>
                        $(function (){
                            cari_hareket_listesi_getir('<%=cari_id %>', 'firma', 'disardan');
                        });
                    </script>

                    
                </div>
            </div>
        </div>
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
    <script>
        $(function () {






            function drawChartExploading() {
                var dataExploading = google.visualization.arrayToDataTable([
                    ['Nakit Giriş', 'Nakit Giriş'],
                    ['TL', 33],
                    ['Dolar', 34],
                    ['EUR', 33]
                ]);

                var optionsExploading = {
                    title: '',
                    legend: 'none',
                    pieSliceText: 'label',
                    backgroundColor: 'transparent',
                    slices: {
                        4: { offset: 0.2 },
                        12: { offset: 0.3 },
                        14: { offset: 0.4 },
                        15: { offset: 0.5 },
                    },
                    pieHole: 0.4,
                    colors: ['#FC6180', '#4680ff', '#FFB64D', '#FE8A7D', '#69CEC6']
                };

                var chart = new google.visualization.PieChart(document.getElementById('chart_Exploading'));
                chart.draw(dataExploading, optionsExploading);
            }

            google.charts.load("current", { packages: ["corechart"] });
            google.charts.setOnLoadCallback(drawChartExploading);




            function drawChartExploading2() {
                var dataExploading = google.visualization.arrayToDataTable([
                    ['Nakit Giriş', 'Nakit Giriş'],
                    ['TL', 40],
                    ['Dolar', 30],
                    ['EUR', 30]
                ]);

                var optionsExploading = {
                    title: '',
                    legend: 'none',
                    pieSliceText: 'label',
                    backgroundColor: 'transparent',
                    slices: {
                        4: { offset: 0.2 },
                        12: { offset: 0.3 },
                        14: { offset: 0.4 },
                        15: { offset: 0.5 },
                    },
                    pieHole: 0.4,
                    colors: [ '#4680ff', '#FFB64D', '#69CEC6']
                };

                var chart = new google.visualization.PieChart(document.getElementById('chart_Exploading2'));
                chart.draw(dataExploading, optionsExploading);
            }

            google.charts.load("current", { packages: ["corechart"] });
            google.charts.setOnLoadCallback(drawChartExploading2);



            function drawChartExploading3() {
                var dataExploading = google.visualization.arrayToDataTable([
                    ['Nakit Giriş', 'Nakit Giriş'],
                    ['TL', 10],
                    ['Dolar', 60],
                    ['EUR', 30]
                ]);

                var optionsExploading = {
                    title: '',
                    legend: 'none',
                    pieSliceText: 'label',
                    backgroundColor: 'transparent',
                    slices: {
                        4: { offset: 0.2 },
                        12: { offset: 0.3 },
                        14: { offset: 0.4 },
                        15: { offset: 0.5 },
                    },
                    pieHole: 0.4,
                    colors: [ '#FC6180', '#93BE52', '#FFB64D', '#FE8A7D', '#69CEC6']
                };

                var chart = new google.visualization.PieChart(document.getElementById('chart_Exploading3'));
                chart.draw(dataExploading, optionsExploading);
            }

            google.charts.load("current", { packages: ["corechart"] });
            google.charts.setOnLoadCallback(drawChartExploading3);


        });
    </script>
