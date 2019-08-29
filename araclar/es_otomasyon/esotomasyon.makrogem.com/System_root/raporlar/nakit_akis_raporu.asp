<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

%>
<section id="widget-grid" class="">

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
                disableTouchKeyboard: true,
                onSelect: function (dateText, inst) {


                }
            }).mask("99.99.9999");

        });
    </script>


    <div class="row">
        <article class="col-xs-12 ">
            <div class="card">
                <div class="card-header">
                    <h5><%=LNG("Nakit Akış Raporu")%></h5>

                </div>
                <div id="beta_donus" class="card-block">
                    <div class="row">
                       <div class="col-md-2">
                            <%=LNG("Başlangıç Tarihi")%><br />
                            <input type="text" id="baslangic_tarihi" value="<%=cdate(date) %>" class="takvimyap_yeni form-control" />
                        </div>
                        <div class="col-md-2">
                            <%=LNG("Bitiş Tarihi")%><br />
                            <input type="text" id="bitis_tarihi" value="<%=cdate(date)+180 %>" class="takvimyap_yeni form-control" />
                        </div>
                        <div class="col-md-2">
                            <div style="text-align: left;">
                                <br />
                                <br />
                                <a class="btn btn-labeled btn-primary btn-sm" href="javascript:void(0);" onclick="nakit_akis_takvim_getir();"><span class="btn-label"><i class="fa fa-download"></i></span><%=LNG("Sorgula")%></a>
                            </div>
                        </div>
                        <div class="col-md-6"><br />
                            <div style="float:right; ">
                            <a class="btn btn-labeled btn-success btn-sm" href="javascript:void(0);" onclick="rapor_pdf_indir('nakit_akis_raporu');"><span class="btn-label"><i class="fa fa-download"></i></span><%=LNG("İndir")%> </a>&nbsp;&nbsp;<a class="btn btn-labeled btn-warning btn-sm" href="javascript:void(0);" onclick="rapor_pdf_yazdir('nakit_akis_raporu');"><span class="btn-label"><i class="fa fa-print"></i></span><%=LNG("Yazdır")%> </a>&nbsp;&nbsp;<a class="btn btn-labeled btn-primary btn-sm" href="javascript:void(0);" onclick="rapor_pdf_gonder('nakit_akis_raporu');"><span class="btn-label"><i class="fa fa-send "></i></span><%=LNG("Gönder")%> </a>
                        </div>
                        </div>
                    </div>
                    
                    
                </div>
            </div>
        </article>

        <article class="col-xs-12 ">
            <div class="card">
                <div class="card-header">
                    <h5><%=LNG("Yapılacak Tahsilat ve Ödemeler")%></h5>
                </div>
                <div id="beta_donus" class="card-block">
                    

                             <div id="nakit_akis1_donus">
                        <script>
                            $(function (){
                                nakit_akis_takvim_getir();
                            });
                        </script>

                    </div>
                </div>
            </div>
        </article>
    </div>
</section>