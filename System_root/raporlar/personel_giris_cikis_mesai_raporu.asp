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
                    <h5><%=LNG("Özel Personel Puantaj Raporu")%></h5>
                </div>
                <div class="card-block">
                    <div class="row">

                        <div class=" col-sm-12 col-md-3">
                            <%=LNG("Personel")%><br />
                            <select name="rapor_personel_id" class="select2" id="rapor_personel_id">
                                <option value="0"><%=LNG("Tümü")%></option>
                                <%
                            SQL="select id, personel_ad + ' ' + personel_soyad as personel from ucgem_firma_kullanici_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and durum = 'true' and cop = 'false' order by personel_ad + ' ' + personel_soyad asc"
                            set kullanici = baglanti.execute(SQL)
                            do while not kullanici.eof
                                %>
                                <option value="<%=kullanici("id") %>"><%=kullanici("personel") %></option>
                                <%
                            kullanici.movenext
                            loop
                                %>
                            </select>
                        </div>

                        <div class=" col-sm-12 col-md-2">
                            <%=LNG("Dönem")%><br />
                            <select name="personel_giris_cikis_saati_donem" class="select2" id="personel_giris_cikis_saati_donem">
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

                        <div class=" col-sm-12 col-md-1">
                            <a class="btn btn-labeled btn-primary btn-mini mt-2" style="margin-top: 20px !important" onclick="personel_giris_cikis_mesai_getir_rapor();" href="javascript:void(0);"><span class="btn-label"><i class="fa fa-download"></i></span><%=LNG("Sorgula")%></a>
                        </div>

                        <div class=" col-sm-12 col-md-12">
                            <br />
                            <div style="float: right;">
                                <a class="btn btn-labeled btn-success btn-mini mr-1 text-white mt-1" onclick="exportToExcel();"><span class="btn-label"><i class="fa fa-file-excel-o"></i></span><%=LNG("Export To Excell")%> </a>
                                <a class="btn btn-labeled btn-success btn-mini mr-1 text-white mt-1" onclick="rapor_pdf_indir('personel_giris_cikis_raporu');"><span class="btn-label"><i class="fa fa-download"></i></span><%=LNG("İndir")%> </a>
                                <a class="btn btn-labeled btn-warning btn-mini mr-1 text-white mt-1" onclick="rapor_pdf_yazdir('personel_giris_cikis_raporu');"><span class="btn-label"><i class="fa fa-print"></i></span><%=LNG("Yazdır")%> </a>
                                <a class="btn btn-labeled btn-primary btn-mini text-white mt-1" onclick="rapor_pdf_gonder('personel_giris_cikis_raporu');"><span class="btn-label"><i class="fa fa-send "></i></span><%=LNG("Gönder")%> </a>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

        </article>


    </div>

    <div class="row">
        <article class="col-xs-12 ">
            <div class="card">
                <div class="card-block">
                    <div class="row">
                        <div class="col-xs-12" id="personel_giris_cikis_donus">
                            <script type="text/javascript">
                                $(function () {
                                    personel_giris_cikis_mesai_getir_rapor();
                                });
                            </script>
                        </div>
                    </div>
                </div>
            </div>
        </article>
    </div>
</section>

<script type="text/javascript">
    function exportToExcel() {
        $("#tablegosterge").table2excel({
            // exclude bu class verdiğiniz yerler aktarılmayacak. 
            exclude: ".bunu_aktarma",
            filename: "PersonelÖzelPuantajRaporu" //burada .(nokta) ve uzantı kullanmayın
        });
    }
</script>
