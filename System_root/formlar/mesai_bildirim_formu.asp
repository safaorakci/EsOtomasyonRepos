﻿<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    izin_id = trn(request("izin_id"))
    FirmaID = Request.Cookies("kullanici")("firma_id")

    SQL="SELECT bildirim.baslangic_tarihi, kullanici.personel_ad, kullanici.personel_soyad, bildirim.aciklama, LEFT(bildirim.baslangic_saati,5) as baslangic_saati , LEFT(bildirim.bitis_saati,5) as bitis_saati, DATEDIFF(MINUTE,bildirim.baslangic_saati,bildirim.bitis_saati) - ((DATEDIFF(MINUTE,bildirim.baslangic_saati,bildirim.bitis_saati) / 60 ) *60) as dakika, DATEDIFF(MINUTE,bildirim.baslangic_saati,bildirim.bitis_saati)/60 as saat FROM ucgem_personel_mesai_bildirimleri bildirim INNER JOIN ucgem_firma_kullanici_listesi kullanici on kullanici.id = bildirim.personel_id WHERE bildirim.id =  '"& izin_id &"' and bildirim.firma_id = '"& FirmaID &"' and kullanici.firma_id = '"& FirmaID &"'"
    set mesai = baglanti.execute(SQL)

    SQL = "select * from ucgem_firma_listesi where yetki_kodu = 'BOSS'"
    set firmaBilgileri = baglanti.execute(SQL)

    firmaLogo = firmaBilgileri("firma_logo")
    if firmaBilgileri("firma_logo") = "undefined" then
        firmaLogo = ""    
    end if
%>
<html lang="tr">
<head>
    <title><%=LNG("Fazla Mesai Formu")%></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

</head>
<body>

    <table border="1" cellpadding="5" cellspacing="0" style="width: 100%; border: solid 1px black;">
        <tbody>
            <tr>
                <td colspan="7" style="vertical-align: middle;">
                    <span style="float: left;">
                        <%if firmaBilgileri("firma_kodu") = "ESOTOMASYON" then %>
                            <img src="<%=firmaLogo %>" style="width: 150px;" />
                        <%end if %>
                    </span>
                    <br />
                    <center>
                                    <span style="font-weight:bold; font-size:30px;">Fazla Mesai Formu</span>
                                </center>
                </td>
                <td style="width: 250px;">
                    <center><h2>Tanzim Tarihi</h2></center>
                    <center><h3><span id="sp"><%Response.Write Date()%></span></h3></center>

                </td>
            </tr>
            <tr style="background-color: lightgray;">
                <th>Tarih</th>
                <th>Adı Soyadı</th>
                <th>Mesai Nedeni</th>
                <th>Kodu *</th>
                <th>Başlama / Saat</th>
                <th>Bitiş / Saat</th>
                <th>F.M Süresi (Saat)</th>
                <th>İmza</th>

            </tr>
            <tr>
                <td style="height: 40px;"><%=cdate(mesai("baslangic_tarihi")) %></td>
                <td style="height: 40px;"><%=mesai("personel_ad") %>   <%=mesai("personel_soyad") %></td>
                <td style="height: 40px;"><%=mesai("aciklama") %></td>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"><%=mesai("baslangic_saati") %></td>
                <td style="height: 40px;"><%=mesai("bitis_saati") %></td>

                <%
                        mesaiSaat = ""
                        mesaiDakika = ""
                        if mesai("saat") < 10 then
                           mesaiSaat = "0" & mesai("saat")
                        else
                           mesaiSaat = mesai("saat")
                        end if
                        if mesai("dakika") < 10 then
                           mesaiDakika = "0" & mesai("dakika")
                        else
                           mesaiDakika = mesai("dakika")
                        end if
                %>
                <td style="height: 40px;">
                    <%=mesaiSaat %> : <%=mesaiDakika %>
                </td>
                <td style="height: 40px;"></td>
            </tr>
            <tr>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"></td>
            </tr>
            <tr>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"></td>
            </tr>
            <tr>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"></td>
                <td style="height: 40px;"></td>
            </tr>
            <tr>
                <th colspan="3" rowspan="2" style="text-align: left;">
                    <strong>* FM KODU : </strong>
                    <br />
                    <span><strong>1 = </strong>Normal yapılan fazla mesai</span>
                    <br>
                    <span><strong>2 = </strong>Bayramlarda yapılan fazla mesai</span>
                </th>
                <th colspan="3">Birim Yetkisi</th>
                <th colspan="3">Onay</th>
            </tr>
            <tr>
                <th colspan="3" style="height: 40px;"></th>
                <th colspan="3" style="height: 40px;"></th>
            </tr>
        </tbody>
    </table>

</body>
<script type="text/javascript">
    $(function () {
        var d = new Date();
        var strDate = d.getDate() + "/" + (d.getMonth() + 1) + "/" + d.getFullYear();
        //$("#sp").html("bİLAL");
    });
</script>
</html>
