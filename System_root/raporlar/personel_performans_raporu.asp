<!-- #include virtual="/data_root/conn.asp" -->
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
                        $("#bitis_tarihi").val(yeni_tarih).focus();

                    }, 500);
                }
            }).mask("99.99.9999");



            $("#bitis_tarihi").datepicker({
                beforeShow: function (input, inst) {
                    inst.dpDiv.css({ marginTop: -input.offsetHeight + 'px', marginLeft: input.offsetWidth + 'px' });
                },
                firstDay: 1,
                disableTouchKeyboard: true,
                onSelect: function (dateText, inst) {


                }
            }).mask("99.99.9999");


            $("#etiketler").attr("size", "1");

            $("select#etiketler option[optiongroup='Departmanlar']").wrapAll("<optgroup label='Departmanlar'>");
            $("select#etiketler option[optiongroup='Firmalar']").wrapAll("<optgroup label='Firmalar'>");
            $("select#etiketler option[optiongroup='Projeler']").wrapAll("<optgroup label='Projeler'>");
            $("select#etiketler option[optiongroup='Toplantılar']").wrapAll("<optgroup label='Toplantılar'>");

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
                    <h5><%=LNG("Personel Performans Raporu")%></h5>
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
                            <%=LNG("Başlangıç")%><br />
                            <input type="text" id="baslangic_tarihi" value="<%=FormatDate(date, "00") %>" class="takvimyap_yeni form-control" />
                        </div>
                        <div class="col-sm-12 col-md-2">
                            <%=LNG("Bitiş")%><br />
                            <input type="text" id="bitis_tarihi" value="<%=FormatDate(date, "00") %>" class="takvimyap form-control" />
                        </div>
                        

                        <div class="col-sm-12 col-md-2">
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
                        <div class="col-sm-12 col-md-2">
                            <%=LNG("Proje")%><br />
                            <select name="yeni_is_yuku_proje_id" class="select2" id="yeni_is_yuku_proje_id">
                                <option value="0"><%=LNG("Tüm Projeler")%></option>
                                <%
                        SQL="select id, proje_adi,proje_kodu from ucgem_proje_listesi where firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and durum = 'true' and cop = 'false' order by proje_adi asc"
                        set proje = baglanti.execute(SQL)
                        do while not proje.eof
                                %>
                                <option value="<%=proje("id") %>"><%=proje("proje_adi") %><%=proje("proje_kodu") %></option>
                                <%
                        proje.movenext
                        loop
                                %>
                            </select>
                        </div>
                        <div class="col-sm-12 col-md-2">
                            <a class="btn btn-labeled btn-primary btn-mini" href="javascript:void(0);" onclick="personel_performans_raporu_getir();"><span class="btn-label"><i class="fa fa-download"></i></span><%=LNG("Sorgula")%></a>
                        </div>
                        <div class="col-sm-12 col-md-12"><br />
                            <div style="float: right;">
                                <a class="btn btn-labeled btn-success btn-mini" href="javascript:void(0);" onclick="rapor_pdf_indir('personel_performans_raporu');"><span class="btn-label"><i class="fa fa-download"></i></span><%=LNG("İndir")%> </a>&nbsp;&nbsp;<a class="btn btn-labeled btn-warning btn-mini" href="javascript:void(0);" onclick="rapor_pdf_yazdir('personel_performans_raporu');"><span class="btn-label"><i class="fa fa-print"></i></span><%=LNG("Yazdır")%> </a>&nbsp;&nbsp;<a class="btn btn-labeled btn-primary btn-mini" href="javascript:void(0);" onclick="rapor_pdf_gonder('personel_performans_raporu');"><span class="btn-label"><i class="fa fa-send "></i></span><%=LNG("Gönder")%> </a>
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

                    <div class="row" id="personel_performans_donus">
                        <script>
                            $(function (){
                                personel_performans_raporu_getir();
                            });
                        </script>
                    </div>
                </div>
            </div>
        </article>
    </div>
</section>
