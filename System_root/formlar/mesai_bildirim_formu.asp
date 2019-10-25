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
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

</head>
<body>

    <!-- <table border="1" cellpadding="5" cellspacing="0" style="width: 100%; border: solid 1px black;">
        <tbody>
            <tr>
                <td colspan="2" style="vertical-align: middle;">
                    <span style="float: left;">
                        <img src="/images/esotomasyon_logo.png" style="width: 150px;" />
                    </span>
                    <br />
                    <center>
                        <span style="font-weight:bold; font-size:30px;">Fazla Mesai Formu</span>
                    </center>
                </td>
            </tr>
            <tr>
                <td style="height: 40px;"><strong>İZİN TALEP EDEN PERSONELİN</strong></td>
                <td style="width: 15%; text-align: center;">Tarih </td>
            </tr>
            <tr>
                <td style="height: 40px;">T.C. No : </td>
                <td></td>
            </tr>
            <tr>
                <td style="height: 40px;">Adı ve Soyadı : </td>
                <td rowspan="3" style="text-align: center; vertical-align: top;">İmza</td>
            </tr>
            <tr>
                <td style="height: 40px;">Bölümü : </td>
            </tr>
            <tr>
                <td style="height: 40px;">Görevi : </td>
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
                <td style="height: 40px;">Ayrılış Tarihi : </div>
                </td>
                <td style="height: 40px;">Dönüş Tarihi : </div>
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
                <td style="height: 40px;"></td>
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
                <td style="height: 40px;"></td>
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
                </td>
            </tr>
        </tbody>
    </table> -->

    <div style="width: 1300px; margin-right: auto; margin-left: auto;">
            <table border="1" cellpadding="5" cellspacing="0" style="width: 100%; border: solid 1px black;">
                    <tbody>
                        <tr>
                            <td colspan="7" style="vertical-align: middle;">
                                <span style="float: left;">
                                    <img src="/images/esotomasyon_logo.png" style="width: 150px;" />
                                </span>
                                <br />
                                <center>
                                    <span style="font-weight:bold; font-size:30px;">Fazla Mesai Formu</span>
                                </center>
                            </td>
                            <td style="width: 250px;">
                                <center><h2>Tanzim Tarihi</h2></center>
                                <center><h3><span> . . . . / . . . / 20 . . </span></h3></center>
                            </td>
                        </tr>
                        <tr style="background-color: lightgray;">
                            <th>Tarih</th>
                            <th>Adı Soyadı</th>
                            <th>Mesai Nedeni</th>
                            <th>Kodu *</th>
                            <th>Başlama / Saat</th>
                            <th>Başlama / Saat</th>
                            <th>F.M Süresi (Saat)</th>
                            <th>İmza</td>
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
                                <strong>* FM KODU : </strong> <br />
                                <span><strong>1 = </strong> Normal yapılan fazla mesai</span> <br>
                                <span><strong>2 = </strong> Bayramlarda yapılan fazla mesai</span>
                            </th>
                            <th colspan="3">Birim Yetkisi</th>
                            <th colspan="3">Onay</th>
                        </tr>
                        <tr>
                            <th colspan="3" style="height: 40px;">

                            </th>
                            <th colspan="3" style="height: 40px;">

                                </th>
                        </tr>
                    </tbody>
                </table>
    </div>

</body>
</html>

