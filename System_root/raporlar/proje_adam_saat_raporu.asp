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
                    <h5><%=LNG("Proje Adam-Saat Raporu")%></h5>
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
                            <select name="is_yuku_donem"  class="select2" id="is_yuku_donem">
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

                        <div class=" col-sm-12 col-md-2">
                            <%=LNG("Departman")%><br />
                            <select class="select2" name="etiketler" id="etiketler">
                                <option value="0"><%=LNG("TÜMÜ")%></option>
                                <%
                                songrup = ""
                                SQL="select * from etiketler etiket with(nolock) where etiket.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and tip = 'departman' order by grup, adi asc;"
                                set etiketler = baglanti.execute(SQL)
                                do while not etiketler.eof
                                    if not trim(songrup) = trim(etiketler("grup")) then
                                        if not songrup = "" then
                                %>
                                        </optgroup>
                                        <% end if %>
                                <optgroup label="<%=etiketler("grup") %>">
                                    <%
                                        songrup = etiketler("grup")
                                    end if
                                    %>
                                    <option value="<%=etiketler("tip") %>-<%=etiketler("id") %>"><%=etiketler("adi") %></option>
                                    <%
                                etiketler.movenext
                                loop
                                    %>
                                </optgroup>
                            </select>
                        </div>
                        <div class=" col-sm-12 col-md-2">
                            <%=LNG("Proje")%><br />
                            <select name="yeni_is_yuku_proje_id" class="select2" id="yeni_is_yuku_proje_id">
                                <option value="0"><%=LNG("Tüm Projeler")%></option>
                                <%
                        SQL="select id, proje_adi,proje_kodu from ucgem_proje_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and durum = 'true' and cop = 'false' order by proje_adi asc"
                        set proje = baglanti.execute(SQL)
                        do while not proje.eof
                                %>
                                <option value="<%=proje("id") %>"><%=proje("proje_adi") %>-<%=proje("proje_kodu") %></option>
                                <%
                        proje.movenext
                        loop
                                %>
                            </select>
                        </div>

                        <div class=" col-sm-12 col-md-1">
                            <a class="btn btn-labeled btn-primary btn-sm" onclick="proje_adam_saat_getir_rapor();" href="javascript:void(0);"><span class="btn-label"><i class="fa fa-download"></i></span><%=LNG("Sorgula")%></a>
                        </div>

                        <div class=" col-sm-12 col-md-12"><br />
                            <div style="float: right;">
                                <a class="btn btn-labeled btn-success btn-sm" href="javascript:void(0);" onclick="rapor_pdf_indir('proje_adam_saat_raporu');"><span class="btn-label"><i class="fa fa-download"></i></span><%=LNG("İndir")%> </a>&nbsp;&nbsp;<a class="btn btn-labeled btn-warning btn-sm" href="javascript:void(0);" onclick="rapor_pdf_yazdir('proje_adam_saat_raporu');"><span class="btn-label"><i class="fa fa-print"></i></span><%=LNG("Yazdır")%> </a>&nbsp;&nbsp;<a class="btn btn-labeled btn-primary btn-sm" href="javascript:void(0);" onclick="rapor_pdf_gonder('proje_adam_saat_raporu');"><span class="btn-label"><i class="fa fa-send "></i></span><%=LNG("Gönder")%> </a>
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
                        <div class="col-xs-12" id="proje_adam_saat_donus">
                <script type="text/javascript">
                    $(function () {
                        proje_adam_saat_getir_rapor();
                    });
                </script>
            </div>
                    </div>
                </div>
            </div>
        </article>
          </div>
</section>
