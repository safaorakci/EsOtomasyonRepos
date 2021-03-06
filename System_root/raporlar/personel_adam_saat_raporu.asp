﻿<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

%>
<script>
    $(function (){

            $("#baslangic_tarihi").datepicker({
                beforeShow: function (input, inst) {
                    inst.dpDiv.css({ marginTop: -input.offsetHeight + 'px', marginLeft: input.offsetWidth + 'px' });
                },
                firstDay: 1,
                onSelect: function (dateText, inst) {
                    setTimeout(function () {
                        var tarih = $("#baslangic_tarihi").datepicker("getDate");
                        var eldeki_date = $("#baslangic_tarihi").datepicker("getDate");
                        eldeki_date.setDate(eldeki_date.getDate());
                        tarih.setDate(tarih.getDate());
                        ay = parseFloat(tarih.getMonth()) + 1;
                        if (ay < 10) {
                            ay = "0" + ay;
                        }
                        gun = parseFloat(tarih.getDate());
                        if (gun < 10) {
                            gun = "0" + gun;
                        }
                        var yeni_tarih = gun + "." + ay + "." + tarih.getFullYear();
                        $("#bitis_tarihi").val(yeni_tarih);
                        $("#bitis_tarihi").datepicker('option', 'minDate', eldeki_date).focus();

                    }, 500);
                }
            }).mask("99.99.9999");



            $("#bitis_tarihi").datepicker({
                beforeShow: function (input, inst) {
                    inst.dpDiv.css({ marginTop: -input.offsetHeight + 'px', marginLeft: input.offsetWidth + 'px' });
                },
                firstDay: 1,
                minDate: 0,
                disableTouchKeyboard: true,
                onSelect: function (dateText, inst) {


                }
            }).mask("99.99.9999");


            $("#etiketler").attr("size", "1");

            $("select#etiketler option[optiongroup='<%=LNG("Departmanlar")%>']").wrapAll("<optgroup label='<%=LNG("Departmanlar")%>'>");
            $("select#etiketler option[optiongroup='<%=LNG("Firmalar")%>']").wrapAll("<optgroup label='<%=LNG("Firmalar")%>'>");
            $("select#etiketler option[optiongroup='<%=LNG("Projeler")%>']").wrapAll("<optgroup label='<%=LNG("Projeler")%>'>");
            $("select#etiketler option[optiongroup='<%=LNG("Toplantılar")%>']").wrapAll("<optgroup label='<%=LNG("Toplantılar")%>'>");

            $("select#etiketler option").each(function () {
                if ($(this).text() == "") {
                    $(this).remove();
                }
            });

         

    });
</script>
<section id="widget-grid" class="">
    <div class="row">
        <article class="col-xs-12 ">
            <div class="card">
                <div class="card-header">
                    <h5><%=LNG("Proje Adam Saat Raporu")%></h5>
                </div>
                <div id="beta_donus" class="card-block">
                    <div class="row">
                        <div class="col-sm-12 col-md-2">
                            <%=LNG("Personel")%><br />
                            <select name="rapor_personel_id" class="select2" id="rapor_personel_id">
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

                        <div class="col-sm-12 col-md-2">
                            <%=LNG("Dönem")%><br />
                            <select name="is_yuku_donem" class="select2" id="is_yuku_donem">
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
                        <div class="col-sm-12 col-md-2">
                            <%=LNG("Gösterim")%><br />
                            <select name="is_yuku_gosterim_tipi" class="select2" id="is_yuku_gosterim_tipi">
                                <option <% if trim(gosterim_tipi)="0" then %> selected="selected" <% end if %> value="0"><%=LNG("Maliyet")%></option>
                                <option <% if trim(gosterim_tipi)="1" then %> selected="selected" <% end if %> value="1"><%=LNG("Saat")%></option>
                            </select>
                        </div>


                        <div class="col-sm-12 col-md-2">
                            <%=LNG("Departman")%><br />
                            <select class="select2" name="etiketler" id="etiketler" multiple="multiple">
                                <option value="0" selected><%=LNG("TÜMÜ")%></option>
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
                        <div class="col-sm-12 col-md-2">
                            <%=LNG("Proje")%><br />
                            <select name="yeni_is_yuku_proje_id" class="select2" id="yeni_is_yuku_proje_id">
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

                        <div class="col-sm-12 col-md-1 align-self-end mt-2">
                            <a class="btn btn-labeled btn-primary btn-mini text-white" onclick="personel_adam_saat_rapor_getir();"><span class="btn-label"><i class="fa fa-download"></i></span><%=LNG("Sorgula")%></a>
                        </div>

                        <div class="col-sm-12 col-md-12 align-self-end">
                            <div class="float-right">
                                <a class="btn btn-labeled btn-success btn-mini mr-1 text-white" onclick="rapor_pdf_indir('personel_adam_saat_raporu');"><span class="btn-label"><i class="fa fa-download"></i></span><%=LNG("İndir")%> </a>
                                <a class="btn btn-labeled btn-warning btn-mini mr-1 text-white" onclick="rapor_pdf_yazdir('personel_adam_saat_raporu');"><span class="btn-label"><i class="fa fa-print"></i></span><%=LNG("Yazdır")%> </a>
                                <a class="btn btn-labeled btn-primary btn-mini text-white" onclick="rapor_pdf_gonder('personel_adam_saat_raporu');"><span class="btn-label"><i class="fa fa-send "></i></span><%=LNG("Gönder")%> </a>
                            </div>

                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <table>
                            <tr>
                                <td style="width: 125px;"></td>
                            </tr>
                        </table>
                    </div>

                    <div class="row">
                        <div id="personel_rapor_donus" class="col-lg-12">
                            <script>
                                $(function (){
                                    personel_adam_saat_rapor_getir();
                                });
                            </script>
                        </div>
                    </div>
                </div>
        </article>
    </div>
</section>
