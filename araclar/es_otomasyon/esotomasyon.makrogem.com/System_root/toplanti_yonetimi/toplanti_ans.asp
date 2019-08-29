<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001


%>

    <style>

        table.dataTable thead>tr>th.sorting_asc, table.dataTable thead>tr>th.sorting_desc, table.dataTable thead>tr>th.sorting, table.dataTable thead>tr>td.sorting_asc, table.dataTable thead>tr>td.sorting_desc, table.dataTable thead>tr>td.sorting {
            padding-right: 30px!important;
        }

        table.table-bordered.dataTable th, table.table-bordered.dataTable td {
            border-left-width: 0!important;
        }
        table.dataTable thead .sorting, table.dataTable thead .sorting_asc, table.dataTable thead .sorting_desc, table.dataTable thead .sorting_asc_disabled, table.dataTable thead .sorting_desc_disabled {
            cursor: pointer!important;
            position: relative!important;
        }
       
        .table > thead > tr > th {
            border-bottom-color: #ccc!important;
            background-color:white!important;
        }
        table.dataTable td, table.dataTable th {
            -webkit-box-sizing: content-box!important;
            box-sizing: content-box!important;
            vertical-align:middle!important;
        }
        .table-bordered thead td, .table-bordered thead th {
            border-bottom-width: 2px!important;
        }
        .table thead th {
            vertical-align: bottom!important;
            border-bottom: 2px solid #e9ecef!important;
        }

    

        .table.dataTable{
            margin-bottom:15px!important;
            border-top:none;
        }
        table.table-bordered.dataTable {
            border-collapse: collapse!important;
        }

        .dt-toolbar-footer {
            border-top:none;
        }

        .dt-toolbar {
            padding: 6px 1px 10px!important;
        }

        .dataTables_filter .input-group-addon + .form-control {
            height:32px!important;
        }
    </style>
    <div class="row">
        <%
            SQL="select (select count(id) as planlanan from ahtapot_toplanti_listesi toplanti where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and durum = 'true' and cop = 'false') as planlanan, (select count(id) as gerceklesen from ahtapot_toplanti_listesi toplanti where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and durum = 'true' and cop = 'false' and convert(datetime, toplanti.toplanti_tarihi) + convert(datetime, toplanti.toplanti_saati)>getdate()) as gerceklesen, (select count(id) as bekleyen from ahtapot_toplanti_listesi toplanti where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and durum = 'true' and cop = 'false' and convert(datetime, toplanti.toplanti_tarihi) + convert(datetime, toplanti.toplanti_saati)<getdate()) as bekleyen"
            set toplantisayi = baglanti.execute(SQL)
        %>
        <div class="col-md-6 col-xl-3">
            <div class="card bg-c-blue notification-card">
                <div class="card-block">
                    <div class="row align-items-center">
                        <div class="col-4 notify-icon"><i class="fa fa-calendar-plus-o"></i></div>
                        <div class="col-8 notify-cont">
                            <h4><%=toplantisayi("planlanan") %></h4>
                            <p><%=LNG("Planlanan Toplantı")%></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-xl-3">
            <div class="card bg-c-green notification-card">
                <div class="card-block">
                    <div class="row align-items-center">
                        <div class="col-4 notify-icon"><i class="fa fa-calendar-check-o"></i></div>
                        <div class="col-8 notify-cont">
                            <h4><%=toplantisayi("gerceklesen") %></h4>
                            <p><%=LNG("Gerçekleşen Toplantı")%></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-xl-3">
            <div class="card bg-c-yellow notification-card">
                <div class="card-block">
                    <div class="row align-items-center">
                        <div class="col-4 notify-icon"><i class="fa fa-calendar-minus-o"></i></div>
                        <div class="col-8 notify-cont">
                            <h4><%=toplantisayi("bekleyen") %></h4>
                            <p><%=LNG("Bekleyen Toplantı")%></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-xl-3">
            <div class="card bg-c-pink notification-card">
                <div class="card-block">
                    <div class="row align-items-center">
                        <div class="col-4 notify-icon"><i class="fa fa-check-square-o"></i></div>
                        <div class="col-8 notify-cont">
                            <h4>0</h4>
                            <p><%=LNG("Alınan Karar")%></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <div class="row">
        <div class="col-md-12 col-lg-9">
            <div class="card statustic-card" id="toplanti_listesi">
                <div class="card-header">
                    <h5 class="m-b-10" id="toplanti_baslik" ay="<%=month(cdate(date)) %>" yil="<%=year(date) %>" style="font-size:1.25em;"><%=monthname(month(cdate(date))) %>&nbsp;<%=year(date) %> <%=LNG("Toplantı Listesi")%></h5>
                    <div style="float: right; margin-right: 15px; margin-bottom: -20px;">
                    <a href="javascript:void(0);" onclick="yeni_toplanti_planla();" class="btn btn-success btn-round"><i class="fa  fa-cube"></i>&nbsp;<%=LNG("Yeni Toplantı Planla")%></a>
                </div>
                </div>
                <div class="card-block">
                    
                        <script>
                            $(function (){
                                toplantilari_getir('<%=month(date) %>', '<%=year(date) %>');
                            });
                        </script>
                        
                    
                </div>
            </div>
        </div>
        <div class="col-md-12 col-lg-3">
            <div class="card statustic-card">
                <div class="card-block">
                    <div class="fb-timeliner">
                        <h2 class="recent-highlight bg-success"><%=year(cdate(date)) %></h2>
                        <ul>

                            <%
                                SQL="select month(toplanti_tarihi) as ay, count(id) as adet from ahtapot_toplanti_listesi where year(toplanti_tarihi) = '"& year(date) &"' group by month(toplanti_tarihi)"
                                set toplantilar = baglanti.execute(sQL)
                                if toplantilar.eof then
                                %>
                            <li><%=year(cdate(date)) %> <%=LNG("yılında planlanan toplantı kaydı bulunamadı.")%></li>
                            <%
                                end if
                                do while not toplantilar.eof
                            %>
                            <li <% if month(date) = cint(toplantilar("ay")) then %> class="active" <% end if %>><a href="javascript:void(0)" onclick="toplantilari_getir('<%=toplantilar("ay") %>', '<%=year(date) %>');"><%=monthname(toplantilar("ay")) %>&nbsp;<%=year(date) %><label class="badge badge-inverse-success" style="float: right; margin-right: 15px;"><%=toplantilar("adet") %></label></a></li>
                            <%
                                toplantilar.movenext
                                loop
                            %>
                        
                        </ul>
                    </div>
                    <div class="fb-timeliner">
                        <h2 class="recent-highlight bg-warning"><%=year(cdate(date))+1 %></h2>
                        <ul>
                            <%
                                SQL="select month(toplanti_tarihi) as ay, count(id) as adet from ahtapot_toplanti_listesi where year(toplanti_tarihi) = '"& year(date)+1 &"' group by month(toplanti_tarihi)"
                                set toplantilar = baglanti.execute(sQL)
                                if toplantilar.eof then
                                %>
                            <li><%=year(cdate(date))+1 %> <%=LNG("yılında planlanan toplantı kaydı bulunamadı.")%></li>
                            <%
                                end if
                                do while not toplantilar.eof
                            %>
                            <li><a href="javascript:void(0)" onclick="toplantilari_getir('<%=toplantilar("ay") %>', '<%=year(date) %>');"><%=monthname(toplantilar("ay")) %>&nbsp;<%=year(date) %><label class="badge badge-inverse-warning" style="float: right; margin-right: 15px;"><%=toplantilar("adet") %></label></a></li>
                            <%
                                toplantilar.movenext
                                loop
                            %>
                        </ul>
                    </div>
                    <div class="fb-timeliner">
                        <h2 class="recent-highlight bg-danger"><%=year(cdate(date))-1 %></h2>
                        <ul>
                            <%
                                SQL="select month(toplanti_tarihi) as ay, count(id) as adet from ahtapot_toplanti_listesi where year(toplanti_tarihi) = '"& year(date)-1 &"' group by month(toplanti_tarihi)"
                                set toplantilar = baglanti.execute(sQL)
                                if toplantilar.eof then
                                %>
                            <li><%=year(cdate(date))-1 %> <%=LNG("yılında planlanan toplantı kaydı bulunamadı.")%></li>
                            <%
                                end if
                                do while not toplantilar.eof
                            %>
                            <li><a href="javascript:void(0)" onclick="toplantilari_getir('<%=toplantilar("ay") %>', '<%=year(date)-1 %>');"><%=monthname(toplantilar("ay")) %>&nbsp;<%=year(date)-1 %><label class="badge badge-inverse-danger" style="float:right; margin-right: 15px;"><%=toplantilar("adet") %></label></a></li>
                            <%
                                toplantilar.movenext
                                loop
                            %>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    <link rel="stylesheet" type="text/css" href="/files/assets/pages/data-table/extensions/responsive/css/responsive.dataTables.css">
    <script src="/files/bower_components/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
    <script src="/files/bower_componesnts/datatables.net-responsive-bs4/js/responsive.bootstrap4.min.js"></script>
        <style>
            .dt-toolbar-footer {
                background: #ffffff!important;
            }

            .dt-toolbar {
                background: #ffffff!important;
            }

        </style>
    
    </div>
