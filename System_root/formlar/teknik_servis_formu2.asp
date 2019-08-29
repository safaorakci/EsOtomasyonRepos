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
                    <table border="1" cellpadding="0" cellspacing="0" style="width: 100%; border: solid 1px black;">
                        <tbody>
                            <tr>
                                <td rowspan="4" style="width: 15%; text-align: center; vertical-align: middle;">
                                    <img src="/images/esotomasyon_logo.png" style="width: 150px;" />
                                </td>
                                <td rowspan="4" colspan="2" style="vertical-align: middle;">
                                    <center>
                                       <span style="font-weight:bold; font-size:30px;">TEKNİK SERVİS FORMU</span>
                                   </center>
                                </td>
                                <td style="width: 16%; text-align: right;">Döküman No : </td>
                                <td style="width: 10%; text-align: right;">ES19001</td>
                            </tr>
                            <tr>
                                <td style="width: 5%; text-align: right;">Yayın Tarihi : </td>
                                <td style="width: 5%; text-align: right;">22.04.2019</td>
                            </tr>

                            <tr>
                                <td style="width: 5%; text-align: right;">Revizyon No : </td>
                                <td style="width: 5%; text-align: right;">0</td>
                            </tr>

                            <tr>
                                <td style="width: 5%; text-align: right;">Revizyon Tarihi : </td>
                                <td style="width: 5%; text-align: right;">22.04.2019</td>
                            </tr>
                            <tr>
                                <td rowspan="5" style="text-align: center; vertical-align: middle;">SERVİS TALEP</td>
                                <td style="width: 15%;">Firma Ünvanı : </td>
                                <td></td>
                                <td style="text-align: right;">Talep Tarihi : </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Adres :</td>
                                <td></td>
                                <td style="text-align: right;">Fiş Seri No :</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Vergi Dairesi :</td>
                                <td></td>
                                <td style="text-align: right;">Vergi No :</td>
                                <td></td>
                            </tr>

                            <tr>
                                <td>Telefon :</td>
                                <td></td>
                                <td style="text-align: right;">E-Mail :</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Yetkili Personel :</td>
                                <td colspan="3"></td>
                            </tr>
                        </tbody>
                    </table>z
                    <br /><br />
                    <table border="1" cellpadding="0" cellspacing="0" style="width: 100%; border: solid 1px black;">
                        <tbody>
                            <tr>
                                <td rowspan="10" style="text-align:center; vertical-align:middle; width:15%;">SERVİS DETAY</td>
                                <td rowspan="5" style="text-align:center; vertical-align:middle; width:10%;">İletişim</td>
                                <td style="width:20%;">Firma Ünvanı</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Adres : </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Adı Soyadı : </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Telefon : </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>E-Mail : </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td rowspan="5" style="text-align:center; vertical-align:middle; width:15%;">Ürün Detay</td>
                                <td>Üretici Firma : </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Model No : </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Seri No : </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Servis Türü : </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Bildirilen Arıza :<br />&nbsp; </td>
                                <td></td>
                            </tr>

                        </tbody>
                    </table>

                    <br /><br />
                    <table border="1" cellpadding="0" cellspacing="0" style="width: 100%; border: solid 1px black;">
                        <tbody>
                            <tr>
                                <td rowspan="7" style="text-align:center; vertical-align:middle; width:15%;">TETKİK</td>
                                <td rowspan="3" style="text-align:center; vertical-align:middle; width:10%;">Servis Personeli</td>
                                <td style="width:20%;">Adı Soyadı</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Telefon : </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>E-Mail : </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td rowspan="4" style="text-align:center; vertical-align:middle; width:15%;">Servis Detayları</td>
                                <td>Başlangıç Tarihi : </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Başlangıç Saati : </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Bitiş Tarihi : </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>Bitiş Saati : </td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                    <br /><br />
                    <table border="1" cellpadding="0" cellspacing="0" style="width:100%; border:solid 1px black; ">
                        <tbody>
                           <tr>
                               <td style="height:40px;"><strong>YAPILAN İŞLEMLER :</strong></td>
                            </tr>
                            <tr>
                                <td style="height:40px;"><br /><br /><br /></td>
                            </tr>
                        </tbody>
                    </table>
                    <br /><br />
                    <table border="1" cellpadding="0" cellspacing="0" style="width:100%; border:solid 1px black; ">
                        <tbody>
                           <tr>
                               <td colspan="5" style="height:40px; text-align:center;"><strong>Kullanılan Malzemeler</strong></td>
                            </tr>
                            <tr>
                                <td style="text-align:center; width:10%;">Marka</td>
                                <td style="text-align:center; width:10%;">Referans</td>
                                <td style="text-align:center; ">Açıklama</td>
                                <td style="text-align:center; width:10%;">Miktar</td>
                                <td style="text-align:center; width:10%;">Birim</td>
                            </tr>
                            <% for x = 1 to 12 %>
                            <tr>
                                <td style="height:30px;">&nbsp;</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                           <% next %>
                        </tbody>
                    </table>

                    <br /><br />
                    <table border="1" cellpadding="0" cellspacing="0" style="width:20%; border:solid 1px black; ">
                        <tbody>
                            <tr>
                                <td style="width:50%;">Çalışan Personel</td>
                                <td style="width:50%;">Adı Soyadı</td>
                            </tr>
                        </tbody>
                    </table>
                    


                    <br />
                </div>
            </div>
        </article>
    </div>
</section>
