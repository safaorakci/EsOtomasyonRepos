<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    is_id = trn(request("is_id"))
    
    SQL="select * from ucgem_is_listesi where id = '"& is_id &"'"
    set cek = baglanti.execute(SQL)

    SQL="select top 1 * from ucgem_firma_kullanici_listesi where dbo.iceriyormu('"& cek("gorevliler") &"', id)=1"
    set personel = baglanti.execute(SQL)



%>
<html lang="tr">
<head>
    <title><%=LNG("Teknik Servis Formu")%></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style>
        body {
            font-family: Arial;
        }
    </style>
</head>
<body>

    <section id="widget-grid" class="">
        <div class="row">
            <article class="col-xs-12 ">
                <div class="card">
                    <div id="beta_donus" class="card-block">
                        <table border="1" cellpadding="5" cellspacing="0" style="width: 100%; border: solid 1px black;">
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
                                    <td style="width: 10%; text-align: right;">ESPSE000<%=cek("id") %></td>
                                </tr>
                                <tr>
                                    <td style="width: 5%; text-align: right;">Yayın Tarihi : </td>
                                    <td style="width: 5%; text-align: right;"><%=cdate(cek("ekleme_tarihi")) %></td>
                                </tr>

                                <tr>
                                    <td style="width: 5%; text-align: right;">Revizyon No : </td>
                                    <td style="width: 5%; text-align: right;">ESPSE000<%=cek("id") %>001</td>
                                </tr>

                                <tr>
                                    <td style="width: 5%; text-align: right;">Revizyon Tarihi : </td>
                                    <td style="width: 5%; text-align: right;"><%=cdate(cek("baslangic_tarihi")) %></td>
                                </tr>

                            </tbody>
                        </table>

                        <br />
                        <br />
                        <table border="1" cellpadding="5" cellspacing="0" style="width: 100%; border: solid 1px black;">
                            <tbody>
                                <tr>
                                    <td rowspan="7" style="text-align: center; vertical-align: middle; width: 15%;">TETKİK</td>
                                    <td rowspan="3" style="text-align: center; vertical-align: middle; width: 10%;">Servis Personeli</td>
                                    <td style="width: 20%;">Adı Soyadı</td>
                                    <td><%=personel("personel_ad") & " " & personel("personel_soyad") %></td>
                                </tr>
                                <tr>
                                    <td>Telefon : </td>
                                    <td><%=personel("personel_telefon") %></td>
                                </tr>
                                <tr>
                                    <td>E-Mail : </td>
                                    <td><%=personel("personel_eposta") %></td>
                                </tr>
                                <tr>
                                    <td rowspan="4" style="text-align: center; vertical-align: middle; width: 15%;">Servis Detayları</td>
                                    <td>Başlangıç Tarihi : </td>
                                    <td><%=cdate(cek("baslangic_tarihi")) %></td>
                                </tr>
                                <tr>
                                    <td>Başlangıç Saati : </td>
                                    <td><%=left(cek("baslangic_saati"),5) %></td>
                                </tr>
                                <tr>
                                    <td>Bitiş Tarihi : </td>
                                    <td><%=cdate(cek("bitis_tarihi")) %></td>
                                </tr>
                                <tr>
                                    <td>Bitiş Saati : </td>
                                    <td><%=left(cek("bitis_saati"),5) %></td>
                                </tr>
                            </tbody>
                        </table>
                        <br />
                        <br />
                        <table border="1" cellpadding="5" cellspacing="0" style="width: 100%; border: solid 1px black;">
                            <tbody>
                                <tr>
                                    <td style="height: 40px;"><strong>İŞ EMRİ :</strong></td>
                                </tr>
                                <tr>
                                    <td style="height: 40px;">
                                        <br />
                                        <%=cek("adi") %><br />
                                        <br />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <br />
                        <br />
                        <table border="1" cellpadding="5" cellspacing="0" style="width: 100%; border: solid 1px black;">
                            <tbody>
                                <tr>
                                    <td style="height: 40px;"><strong>YAPILAN İŞLEMLER :</strong></td>
                                </tr>
                                <tr>
                                    <td style="height: 40px;">
                                        <br />
                                        <br />
                                        <br />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <br />
                        <br />
                        <table border="1" cellpadding="5" cellspacing="0" style="width: 100%; border: solid 1px black;">
                            <tbody>
                                <tr>
                                    <td colspan="5" style="height: 40px; text-align: center;"><strong>Kullanılan Malzemeler</strong></td>
                                </tr>
                                <tr>
                                    <td style="text-align: center; width: 10%;">Marka</td>
                                    <td style="text-align: center; width: 10%;">Referans</td>
                                    <td style="text-align: center;">Açıklama</td>
                                    <td style="text-align: center; width: 10%;">Miktar</td>
                                    <td style="text-align: center; width: 10%;">Birim</td>
                                </tr>
                                <% 
                                
                                

        SQL="select tanim.aciklama as referans, tanim.marka, tanim.parca_adi, parca.*, kullanici.personel_ad + ' ' + kullanici.personel_soyad as ekleyen from is_parca_listesi parca join ucgem_firma_kullanici_listesi kullanici on kullanici.id = parca.ekleyen_id join parca_listesi tanim on tanim.id = parca.ParcaId where parca.IsID = '"& is_id &"' and parca.cop = 'false' order by parca.id asc"
            set parca = baglanti.execute(SQL)

                                if parca.eof then

                                %>
                                <tr>
                                    <td style="height: 30px;">&nbsp;</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <% else
                               p = 0
                               do while not parca.eof
                                p = p + 1
                                %>
                                <tr>
                                    <td style="height: 30px;"><%=parca("marka") %></td>
                                    <td><%=parca("parca_adi") %></td>
                                    <td><%=parca("referans") %></td>
                                    <td><%=parca("adet") %></td>
                                    <td>Adet</td>
                                </tr>
                                <%
                                parca.movenext
                                loop
                                end if
                                %>
                            </tbody>
                        </table>

                        <br />
                        <br />
                        <table border="1" cellpadding="5" cellspacing="0" style="width: 40%; border: solid 1px black;">
                            <tbody>
                                <tr>
                                    <td style="width: 50%;">Çalışan Personel</td>
                                    <td style="width: 50%;"><%=personel("personel_ad") & " " & personel("personel_soyad") %></td>
                                </tr>
                            </tbody>
                        </table>
                        <br />
                    </div>
                </div>
            </article>
        </div>
    </section>
</body>
</html>
