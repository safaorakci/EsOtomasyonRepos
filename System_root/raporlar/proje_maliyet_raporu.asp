<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

%>
<section id="widget-grid" class="">
    <div class="row">
        <article class="col-xs-12 ">
            <div class="card">
                <div class="card-header">
                    <h5><%=LNG("Proje Maliyet Raporu")%></h5>
                </div>
                <div class="card-block">
                    <div class="row">
                        <div class="col-sm-12 col-md-5">
                            <%=LNG("Proje")%><br />
                            <select name="yeni_is_yuku_proje_id" class="select2" id="yeni_is_yuku_proje_id">
                                <%
                                    SQL="select id, proje_adi from ucgem_proje_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and durum = 'true' and cop = 'false' order by proje_adi asc"
                                    set proje = baglanti.execute(SQL)
                                    do while not proje.eof
                                %>
                                <option value="<%=proje("id") %>"><%=proje("proje_adi") %></option>
                                <%
                                    proje.movenext
                                    loop
                                %>
                            </select>
                        </div>
                        <div class="col-md-1" style="display: none;">
                            <%=LNG("Başlangıç Tarihi")%><br />
                            <input type="text" id="baslangic_tarihi" class="takvimyap_yeni form-control" />
                        </div>
                        <div class="col-md-1" style="display: none;">
                            <%=LNG("Bitiş Tarihi")%><br />
                            <input type="text" id="bitis_tarihi" class="takvimyap form-control" />
                        </div>
                        <div class="col-sm-12 col-md-1">
                            <a class="btn btn-labeled btn-primary btn-sm" href="javascript:void(0);" onclick="proje_maliyet_raporu_getir();"><span class="btn-label"><i class="fa fa-download"></i></span><%=LNG("Sorgula")%></a>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <br />
                            <div style="float: right;"><br />
                                <a class="btn btn-labeled btn-success btn-sm" href="javascript:void(0);" onclick="rapor_pdf_indir('proje_maliyet_raporu');"><span class="btn-label"><i class="fa fa-download"></i></span><%=LNG("İndir")%> </a>&nbsp;&nbsp;<a class="btn btn-labeled btn-warning btn-sm" href="javascript:void(0);" onclick="rapor_pdf_yazdir('proje_maliyet_raporu');"><span class="btn-label"><i class="fa fa-print"></i></span><%=LNG("Yazdır")%> </a>&nbsp;&nbsp;<a class="btn btn-labeled btn-primary btn-sm" href="javascript:void(0);" onclick="rapor_pdf_gonder('proje_maliyet_raporu');"><span class="btn-label"><i class="fa fa-send "></i></span><%=LNG("Gönder")%> </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </article>
        <article class="col-xs-12 ">
            <div class="card">
                <div id="maliyet_raporu_donus" class="card-block">
                    <script>
                        $(function (){
                            proje_maliyet_raporu_getir();
                        });
                    </script>
                </div>
            </div>
        </article>
    </div>
</section>
