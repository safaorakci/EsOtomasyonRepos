<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    izin_id = trn(request("izin_id"))
    personel_id = trn(request("personel_id"))


    SQL="SELECT talep.*, personel.tcno, personel.personel_ad, personel.personel_soyad, isnull(gorev.gorev_adi, '') as gorev_adi FROM ucgem_personel_izin_talepleri talep JOIN dbo.ucgem_firma_kullanici_listesi personel ON personel.id = talep.personel_id left join dbo.tanimlama_gorev_listesi gorev on gorev.id = personel.gorevler where talep.id = '"& izin_id &"'"
    set izin = baglanti.execute(SQL)

    SQL="select * from ucgem_firma_kullanici_listesi where id = '"& izin("OnaylayanId") &"'"
    set onaylayancek = baglanti.execute(SQL)

    SQL="select STUFF((select departman_adi + ', ' from dbo.tanimlama_departman_listesi departman join ucgem_firma_kullanici_listesi personel on dbo.iceriyormu(personel.departmanlar, departman.id)=1 where personel.id = '1' FOR XML PATH('')), 1, 0, '') as departmanlar"
    set departmancek = baglanti.execute(SQL)

    SQL = "select * from ucgem_firma_listesi where yetki_kodu = 'BOSS'"
    set firmaBilgileri = baglanti.execute(SQL)

    firmaLogo = firmaBilgileri("firma_logo")
    if firmaBilgileri("firma_logo") = "undefined" then
        firmaLogo = ""    
    end if

    departmanlar = ""
    if not departmancek.eof then
        departmanlar = departmancek(0)
    end if

    if len(departmanlar)>2 then
        departmanlar = left(departmanlar, len(departmanlar)-2)
    end if


%>
<html lang="tr">
<head>
    <title><%=LNG("İzin Talep Formu")%></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

</head>
<body>

    <table border="1" cellpadding="5" cellspacing="0" style="width: 100%; border: solid 1px black;">
        <tbody>
            <tr>
                <td colspan="2" style="vertical-align: middle;">
                    <span style="float: left;">
                        <%if firmaBilgileri("firma_kodu") = "ESOTOMASYON" then %>
                            <img src="<%=firmaLogo %>" style="width: 150px;" />
                        <%end if %>
                    </span>
                    <br />
                    <center>
                                       <span style="font-weight:bold; font-size:30px;">İZİN TALEP FORMU</span>
                                   </center>
                </td>
            </tr>
            <tr>
                <td style="height: 40px;"><strong>İZİN TALEP EDEN PERSONELİN</strong></td>
                <td style="width: 15%; text-align: center;">Tarih <%=cdate(izin("ekleme_tarihi")) %></td>
            </tr>
            <tr>
                <td style="height: 40px;">T.C. No : <%=izin("tcno") %></td>
                <td></td>
            </tr>
            <tr>
                <td style="height: 40px;">Adı ve Soyadı : <%=izin("personel_ad") & " " & izin("personel_soyad") %></td>
                <td rowspan="3" style="text-align: center; vertical-align: top;">İmza</td>
            </tr>
            <tr>
                <td style="height: 40px;">Bölümü : <%=departmanlar %></td>
            </tr>
            <tr>
                <td style="height: 40px;">Görevi : <%=izin("gorev_adi") %></td>
            </tr>
        </tbody>
    </table>
    <br />
    <br />
    <table border="1" cellpadding="5" cellspacing="0" style="width: 100%; border: solid 1px black;">
        <tbody>
            <tr>
                <td style="height: 40px;" colspan="2"><strong>İZİN SÜRESİ</strong></td>
            </tr>
            <tr>
                <td style="height: 40px;">Ayrılış Tarihi : <%=cdate(izin("baslangic_tarihi")) %><div style="width: 50%; float: right;">Saati : <%=left(izin("baslangic_saati"),5) %></div>
                </td>
                <td style="height: 40px;">Dönüş Tarihi : <%=cdate(izin("bitis_tarihi")) %><div style="width: 50%; float: right;">Saati : <%=left(izin("bitis_saati"),5) %></div>
                </td>
            </tr>
        </tbody>
    </table>
    <br />
    <br />
    <table border="1" cellpadding="5" cellspacing="0" style="width: 100%; border: solid 1px black;">
        <tbody>
            <tr>
                <td style="height: 40px;"><strong>İZİN NEDENİ : </strong></td>
            </tr>
            <tr>
                <td style="height: 40px;"><%=izin("nedeni") %></td>
            </tr>
        </tbody>
    </table>
    <br />
    <br />
    <table border="1" cellpadding="5" cellspacing="0" style="width: 100%; border: solid 1px black;">
        <tbody>
            <tr>
                <td style="height: 40px;"><strong>İZİN ŞEKLİ : </strong></td>
            </tr>
            <tr>
                <td style="height: 40px;"><%=izin("turu") %></td>
            </tr>
        </tbody>
    </table>
    <br />
    <br />
    <table border="1" cellpadding="5" cellspacing="0" style="width: 100%; border: solid 1px black;">
        <tbody>
            <tr>
                <td style="height: 40px;"><strong>ONAYLAYAN YETKİLİ :</strong></td>
            </tr>
            <tr>
                <td style="height: 40px;">
                    <% if not onaylayancek.eof then %>
                    <%=onaylayancek("personel_ad") & " " & onaylayancek("personel_soyad") %>
                    <% end if %>
                </td>
            </tr>
        </tbody>
    </table>


</body>
</html>
