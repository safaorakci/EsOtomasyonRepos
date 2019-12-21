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

                <div id="beta_donus" class="card-block">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card-header" style="padding-left: 0;">
                                <h5><%=LNG("Departmanlardaki İş Hacmi Raporu")%></h5>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div style="text-align: right;">
                                <a class="btn btn-labeled btn-success btn-sm" href="javascript:void(0);" onclick="rapor_pdf_indir('departmanlardaki_is_hacmi');"><span class="btn-label"><i class="fa fa-download"></i></span><%=LNG("İndir")%> </a>&nbsp;&nbsp;<a class="btn btn-labeled btn-warning btn-sm" href="javascript:void(0);" onclick="rapor_pdf_yazdir('departmanlardaki_is_hacmi');"><span class="btn-label"><i class="fa fa-print"></i></span><%=LNG("Yazdır")%> </a>&nbsp;&nbsp;<a class="btn btn-labeled btn-primary btn-sm" href="javascript:void(0);" onclick="rapor_pdf_gonder('departmanlardaki_is_hacmi');"><span class="btn-label"><i class="fa fa-send "></i></span><%=LNG("Gönder")%> </a>
                            </div>
                        </div>
                    </div>
                    <br />
                    <table class="table" width="100%" style="width: 100%;">
                        <thead>
                            <tr>
                                <th style="padding: 10px; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; width: 25%; background-color: #e9ecef!important;"><%=LNG("DEPARTMAN")%></th>
                                <th style="padding: 10px; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important; text-align: center;"><%=LNG("İŞ HACMİ")%></th>
                                <th style="padding: 10px; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; width: 65%; background-color: #e9ecef!important;"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                        SQL="SELECT ROW_NUMBER() OVER (ORDER BY departman.id ASC) AS rowid, 0 AS santiye_sayi, departman.id, departman.departman_adi, departman.departman_tipi, departman.sirano, ( SELECT COUNT(id) FROM ucgem_is_listesi WHERE durum = 'true' AND cop = 'false' AND (ISNULL(tamamlanma_orani, 0) != 100) AND dbo.iceriyormu(departmanlar, 'departman-' + CONVERT(NVARCHAR(10), departman.id)) = 1 ) + ( SELECT COUNT(id) FROM ucgem_proje_olay_listesi olay WHERE olay.departman_id = departman.id AND olay.durum = 'true' AND olay.cop = 'false' ) AS gosterge_sayisi, ( SELECT COUNT(id) FROM ucgem_is_listesi WHERE durum = 'true' AND cop = 'false' ) + ( SELECT COUNT(id) FROM ucgem_proje_olay_listesi olay WHERE olay.durum = 'true' AND olay.cop = 'false' ) AS tum_sayi FROM tanimlama_departman_listesi departman LEFT JOIN ucgem_firma_kullanici_listesi kullanici ON dbo.iceriyormu(kullanici.departmanlar, departman.id) = 1 WHERE departman.firma_id = '"& Request.Cookies("kullanici")("firma_id") &"' and departman.durum = 'true' AND departman.cop = 'false'  GROUP BY departman.id, departman.departman_adi, departman.departman_tipi, departman.sirano ORDER BY  gosterge_sayisi desc;"
                        set sayilar = baglanti.execute(SQL)
                        'response.Write(SQL)

                        en_yuksek = 0
                        do while not sayilar.eof
                            if cdbl(en_yuksek) < cdbl(sayilar("gosterge_sayisi")) then
                                en_yuksek = cdbl(sayilar("gosterge_sayisi"))
                            end if
                        sayilar.MoveNext
                        loop
                        if en_yuksek = 0 then
                            en_yuksek = 1
                        end if

                        sayilar.Movefirst

                        toplam_tutar = 0

                        do while not sayilar.eof

                            eldeki = cint((cdbl(sayilar("gosterge_sayisi"))*100) / cdbl(en_yuksek))
                            if eldeki = 0 then
                                eldeki = 1
                            end if

                            if eldeki>1 then
                                eldeki = eldeki 
                            end if

                            toplam_tutar = cdbl(toplam_tutar) + cdbl(sayilar("gosterge_sayisi"))

                            %>

                            <tr>
                                <td style="text-align: center; padding: 5px; font-weight: bold; text-align: left;"><%=sayilar("departman_adi") %></td>
                                <td style="text-align: center; padding: 5px;"><%=sayilar("gosterge_sayisi") %></td>
                                <td style="padding-left: 15px; padding: 5px; text-align: left;">
                                    <img src="/img/raporbar.png" width="<%=eldeki %>%" style="width: <%=eldeki %>%; height: 20px;" /></td>
                            </tr>

                            <%
                        sayilar.movenext
                        loop
                            %>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td style="text-align: right; padding: 10px;"><strong><%=LNG("TOPLAM:")%> </strong></td>
                                <td style="text-align: center; padding: 10px;"><%=toplam_tutar %></td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </table>

                </div>
            </div>

        </article>


    </div>

</section>
