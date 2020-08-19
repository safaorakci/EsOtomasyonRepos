<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001


    if isnumeric(ay)=false then
        ay = month(date)
    end if
    if isnumeric(yil)=false then
        yil = year(date)
    end if

    dongu_baslangic = cdate("01."& ay &"." & yil)
    dongu_bitis = cdate(AyinSonGunu(dongu_baslangic) & "." & ay & "." & yil)
    dongu_baslangic = cdate(date)
    dongu_bitis = cdate(date) + 60


%>
<script type="text/javascript">
    $(function () {
        rapor_is_yuku_gosterim_proje_sectim_verimlilik('<%=cdate(dongu_baslangic) %>', '<%=cdate(dongu_bitis) %>');
    });
</script>
<section id="widget-grid" class="">
    <div class="row">
        <article class="col-xs-12 ">
            <div id="is_yuku_birinci_ekran">
                <div class="card">

                    <div class="card-header">
                        <h5><%=LNG("Personel İş Yükü Verimlilik Raporu")%></h5>
                    </div>
                    <div class="card-block">
                        <style>
                            .guncizelge {
                                width: 30px;
                                text-align: center;
                                margin-left: auto;
                                margin-right: auto;
                            }

                            .ikincisi td {
                                background-color: #f8f5f5;
                            }

                            .ilkth {
                                width: 150px;
                                padding: 5px;
                                background-color: #32506d;
                                color: white;
                                line-height: 25px;
                                border: solid 1px #e8e8e8;
                            }

                            .ust_th_ilk {
                                background-color: #32506d;
                                border: solid 1px #e8e8e8;
                                border-left: 3px solid #32506d;
                                color: white;
                                line-height: 40px;
                                vertical-align: bottom;
                                padding: 5px;
                            }

                            .ust_th {
                                background-color: #32506d;
                                border: solid 1px #e8e8e8;
                                border-left: solid 3px white;
                                color: white;
                                line-height: 40px;
                                vertical-align: bottom;
                                padding: 5px;
                            }

                            .alt_th {
                                text-align: center;
                                background-color: #4d7193;
                                border: solid 1px #e8e8e8;
                                color: white;
                                line-height: 25px;
                            }

                            .ustunegelince {
                                background-color: #fff;
                            }


                            .ustunegelince2 td {
                                background-color: #cce6ff !important;
                            }

                            .ust_td2 {
                                border: solid 1px #e8e8e8;
                                padding: 5px;
                                line-height: 20px;
                                font-weight: bold;
                                background-color: #32506d !important;
                                color: white !important;
                            }

                            .gosterge_td {
                                text-align: center;
                                background-color: #4d7193 !important;
                                color: white !important;
                            }

                            .sagcizgi {
                                border-right: 3px solid #32506d !important;
                            }

                            .alt_td {
                                text-align: center;
                                border: solid 1px #e8e8e8;
                                line-height: 20px;
                                padding: 5px;
                            }

                            .alt_td2 {
                                border-left: 3px solid #32506d;
                            }

                            .sarialan {
                                background-color: #f5ffa6 !important;
                            }


                            .tablediv {
                                padding-bottom: 15px;
                            }


                                .tablediv::-webkit-scrollbar-track {
                                    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
                                    border-radius: 10px;
                                    background-color: #F5F5F5;
                                }

                                .tablediv::-webkit-scrollbar {
                                    width: 12px;
                                    background-color: #F5F5F5;
                                }

                                .tablediv::-webkit-scrollbar-thumb {
                                    border-radius: 10px;
                                    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
                                    background-color: #32506d;
                                }
                        </style>
                        <script>
                            $(function (){
                                $(".ustunegelince").hover(function (){
                                    $(this).addClass("ustunegelince2");
                                },function (){
                                    $(this).removeClass("ustunegelince2");
                                });
                            });
                        </script>
                        <div class="row">
                            <div class="col-sm-12 col-md-2">
                                <%=LNG("Gösterim Tipi")%><br />
                                <select name="yeni_is_yuku_gosterim_tipi" class="select2" onchange="rapor_is_yuku_gosterim_proje_sectim_verimlilik('<%=cdate(dongu_baslangic) %>', '<%=cdate(dongu_bitis) %>');" id="yeni_is_yuku_gosterim_tipi">
                                    <option value="0"><%=LNG("Verimlilik")%></option>
                                    <option value="1"><%=LNG("Müsaitlik")%></option>
                                </select>
                            </div>
                            <div class="col-sm-12 col-md-2">
                                <%=LNG("Proje")%><br />
                                <select name="yeni_is_yuku_proje_id" class="select2" id="yeni_is_yuku_proje_id" onchange="rapor_is_yuku_gosterim_proje_sectim_verimlilik('<%=cdate(dongu_baslangic) %>', '<%=cdate(dongu_bitis) %>');">
                                    <option value="0"><%=LNG("Tüm Projeler")%></option>
                                    <%
                                        SQL="select id, proje_adi,proje_kodu from ucgem_proje_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and durum = 'true' and cop = 'false' order by proje_adi asc"
                                        set proje = baglanti.execute(SQL)
                                        do while not proje.eof
                                    %>
                                    <option value="<%=proje("id") %>"><%=proje("proje_adi") %> - <%=proje("proje_kodu") %></option>
                                    <%
                                        proje.movenext
                                        loop
                                    %>
                                </select>
                            </div>
                            <div class="col-sm-12 col-md-2">
                                <%=LNG("Dönem")%><br />
                                <select name="rapor_is_yuku_donem" class="select2" id="rapor_is_yuku_donem" onchange="rapor_is_yuku_gosterim_proje_sectim_verimlilik('<%=cdate(dongu_baslangic) %>', '<%=cdate(dongu_bitis) %>');">
                                    <% for x = 1 to 12 
                                                
                                            dongu_baslangic = cdate("01."& x &"." & year(date)-1)
                                            dongu_bitis = cdate(AyinSonGunu(dongu_baslangic) & "."& x &"." & year(date)-1)

                                    %>
                                    <option dongu_baslangic="<%=dongu_baslangic %>" dongu_bitis="<%=dongu_bitis %>" value="<%=x & "-" & year(date)-1 %>"><%=monthname(x) & " " & year(date)-1 %> </option>
                                    <% next %>
                                    <% for x = 1 to month(date)
                                                
                                        dongu_baslangic = cdate("01."& x &"." & year(date))
                                        dongu_bitis = cdate(AyinSonGunu(dongu_baslangic) & "."& x &"." & year(date))
                                    %>
                                    <option dongu_baslangic="<%=dongu_baslangic %>" dongu_bitis="<%=dongu_bitis %>" <% if trim(x & "-" & year(date))=trim(month(date) & "-" & year(date)) then %> selected="selected" <% end if %> value="<%=x & "-" & year(date) %>"><%=monthname(x) & " " & year(date) %> </option>
                                    <% next %>
                                </select>
                            </div>
                            <div class="col-sm-12 col-md-6 align-self-end mt-2">
                                <div class="float-right">
                                    <a class="btn btn-labeled btn-success btn-sm mr-1 text-white" onclick="rapor_pdf_indir('personel_is_yuku_verimlilik');"><span class="btn-label"><i class="fa fa-download"></i></span><%=LNG("İndir")%> </a>
                                    <a class="btn btn-labeled btn-warning btn-sm mr-1 text-white" onclick="rapor_pdf_yazdir('personel_is_yuku_verimlilik');"><span class="btn-label"><i class="fa fa-print"></i></span><%=LNG("Yazdır")%> </a>
                                    <a class="btn btn-labeled btn-primary btn-sm text-white" onclick="rapor_pdf_gonder('personel_is_yuku_verimlilik');" ><span class="btn-label"><i class="fa fa-send "></i></span><%=LNG("Gönder")%> </a>
                                </div>
                            </div>

                        </div>

                        <div id="is_yuku_donus2" class="tablediv" style="width: 100%; margin-top: 15px; overflow: auto;"></div>

                    </div>

                </div>


            </div>

            <div id="is_yuku_birinci_ekran2" style="display: none;"></div>
    </div>
    </article>
    </div>
</section>
