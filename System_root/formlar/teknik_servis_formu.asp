﻿<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001
    
    FirmaID = Request.Cookies("kullanici")("firma_id")
    kullanici_id = trn(request("personel_id"))

    SQL = "select personel_ad + ' ' + personel_soyad as adsoyad from ucgem_firma_kullanici_listesi where id='"& kullanici_id &"' and firma_id = '"& FirmaID &"'"
    set kullanici = baglanti.execute(SQL)

    form_id = trn(request("izin_id"))

    SQL = "select LEFT(servis.BaslangicSaati,5) as Baslangic, LEFT(servis.BitisSaati,5) as Bitis, servis.* from servis_bakim_kayitlari servis where Durum = 'true' and Cop = 'false' and id = '"& form_id &"' and firma_id = '"& FirmaID &"'"
    set servisformu = baglanti.execute(SQL)

    SQL = "SELECT ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 2)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, servis.EklemeTarihi)),3,2) + RIGHT('00' + SUBSTRING(CONVERT(NVARCHAR(10), servis.id),1,4), 3 )  AS seri_no FROM servis_bakim_kayitlari servis WHERE id = '"& form_id &"' and firma_id = '"& FirmaID &"'"
    set seriNo = baglanti.execute(SQL)

    SQL = "select * from ucgem_firma_listesi where yetki_kodu = 'BOSS'"
    set firmaBilgileri = baglanti.execute(SQL)

    firmaLogo = firmaBilgileri("firma_logo")
    if firmaBilgileri("firma_logo") = "undefined" then
        firmaLogo = ""    
    end if
    
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
                                        <%if firmaBilgileri("firma_kodu") = "ESOTOMASYON" then %>
                                            <img src="<%=firmaLogo %>" style="width: 150px;" />
                                        <%end if %>
                                    </td>
                                    <td rowspan="2" colspan="1" style="vertical-align: middle;">
                                        <center>
                                            <span style="font-weight:bold; font-size:30px;">TEKNİK SERVİS FORMU</span>
                                        </center>
                                    </td>
                                    <td>Seri No : </td>
                                    <td>
                                        <%=seriNo("seri_no") %>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Tarih</td>
                                    <td><%Response.Write Date()%> </td>
                                </tr>
                                <tr>
                                    <td rowspan="1" colspan="3" style="height: 50px;">
                                        <center>
                                            <%=firmaBilgileri("firma_adres") %> <br /> <%=firmaBilgileri("firma_telefon") %> &nbsp; <%=firmaBilgileri("firma_mail") %>
                                        </center>
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                        <br />
                        <br />
                        <table border="1" cellpadding="5" cellspacing="0" style="width: 100%; border: solid 1px black;">
                            <tbody>
                                <tr>
                                    <td rowspan="5" style="text-align: center; vertical-align: middle;">SERVIS TALEP</td>
                                    <td style="width: 150px">Firma Ünvanı</td>
                                    <td><%=servisformu("FirmaUnvani") %> </td>
                                    <td style="width: 150px">Yetkili</td>
                                    <td><%=servisformu("Yetkili") %> </td>
                                </tr>
                                <tr>
                                    <td rowspan="2">Adres</td>
                                    <td rowspan="2"><%=servisformu("Adress") %></td>
                                    <td>Email</td>
                                    <td><%=servisformu("Email") %></td>
                                </tr>
                                <tr>
                                    <td>Telefon</td>
                                    <td><%=servisformu("Telefon") %></td>
                                </tr>
                                <tr>
                                    <td>Vergi Dairesi</td>
                                    <td><%=servisformu("VergiDairesi") %></td>
                                    <td rowspan="2">İmza</td>
                                    <td rowspan="2"></td>
                                </tr>
                                <tr>
                                    <td>Vergi No</td>
                                    <td><%=servisformu("VergiNo") %></td>
                                </tr>
                            </tbody>
                        </table>
                        <br />
                        <br />
                        <table border="1" cellpadding="5" cellspacing="0" style="width: 100%; border: solid 1px black;">
                            <tbody>
                                <tr>
                                    <td rowspan="7" style="text-align: center; vertical-align: middle;">SERVIS DETAY</td>
                                    <td style="width: 70px;">Servis Personeli</td>
                                    <td colspan="2"><%=kullanici("adsoyad") %> </td>
                                    <td>Başlangıç Tarihi</td>
                                    <td><%=servisformu("BaslangicTarihi") %> </td>
                                </tr>
                                <tr>
                                    <td style="width: 70px;">Makine Bilgileri</td>
                                    <td colspan="2"><%=servisformu("MakinaBilgileri") %> </td>
                                    <td>Başlangıç Saati</td>
                                    <td><%=servisformu("Baslangic") %> </td>
                                </tr>
                                <tr>
                                    <td rowspan="2">Bildirilen Arıza</td>
                                    <td rowspan="2" colspan="2"><%=servisformu("BildirilenAriza") %></td>
                                    <td>Bitiş Tarihi</td>
                                    <td><%=servisformu("BitisTarihi") %> </td>
                                </tr>
                                <tr>
                                    <td>Bitiş Saati</td>
                                    <td><%=servisformu("Bitis") %> </td>
                                </tr>
                            </tbody>
                        </table>
                        <br />
                        <br />
                        <table border="1" cellpadding="5" cellspacing="0" style="width: 100%; border: solid 1px black;">
                            <tbody>
                                <tr>
                                    <td style="width: 10%; text-align: center;" rowspan="1">YAPILAN İŞLEMLER </td>
                                    <td rowspan="1">
                                        <%=servisformu("YapilanIslemler") %>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%; text-align: center;" rowspan="1">NOT </td>
                                    <td rowspan="1">
                                        <%=servisformu("FormNot") %>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <br />
                        <br />
                        <table border="1" cellpadding="5" cellspacing="0" style="width: 100%; border: solid 1px black; border-bottom: 0px;">
                            <tbody>
                                <td colspan="7" style="text-align: center;">Kullanılan Malzemeler</td>
                            </tbody>
                        </table>
                        <table border="1" cellpadding="5" cellspacing="0" style="width: 100%; border: solid 1px black;">
                            <thead>
                                <tr>
                                    <!--<th style="text-align: center; width: 10%;">Sıra No</th>-->
                                    <th style="text-align: center; width: 10%;">Marka</th>
                                    <th style="text-align: center; width: 10%;">Kod</th>
                                    <th style="text-align: center;">Açıklama</th>
                                    <th style="text-align: center; width: 10%;">Miktar</th>
                                    <th style="text-align: center; width: 10%;">Birim</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                        for x = 0 to ubound(split(servisformu("ParcaId"), ","))
                                            id = split(servisformu("ParcaId"), ",")(x)
                                            Adet = split(servisformu("Adet"), ",")(x)

                                        SQL = "select * from parca_listesi where durum = 'true' and cop = 'false' and id = '"& id &"' and firma_id = '"& FirmaID &"'"
                                        set parcadetay = baglanti.execute(SQL)

                                        if parcadetay.eof then
                                %>
                                <tr>
                                    <td colspan="6" style="text-align: center">Kayıt Bulunamadı !</td>
                                </tr>
                                <%
                                        end if
                                        k = 0
                                        do while not parcadetay.eof
                                            k = k + 1
                                    %>
                                <tr>
                                    <!--<td style="text-align:center"><%=k %></td>-->
                                    <td style="text-align: center">
                                        <%if parcadetay("marka") = "" then %>
                                                -
                                            <%else %>
                                        <%=parcadetay("marka") %>
                                        <%end if %>
                                    </td>
                                    <td style="text-align: center">
                                        <%if parcadetay("parca_kodu") = "" then %>
                                                -
                                            <%else %>
                                        <%=parcadetay("parca_kodu") %>
                                        <%end if %>
                                    </td>
                                    <td style="text-align: center">
                                        <%if parcadetay("aciklama") = "" then %>
                                                -
                                            <%else %>
                                        <%=parcadetay("aciklama") %>
                                        <%end if %>
                                    </td>
                                    <td style="text-align: center"><%=Adet %></td>
                                    <td style="text-align: center">
                                        <%if IsNull(parcadetay("birim")) then %>
                                                -
                                            <%else %>
                                        <%=parcadetay("birim") %>
                                        <%end if %>
                                    </td>
                                </tr>
                                <% 
                                        parcadetay.movenext 
                                        loop
                                %>
                                <% next %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </article>
        </div>
    </section>
</body>
</html>
