<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    satinalma_id = trn(request("satinalma_id"))
    

    SQL="select DISTINCT CASE WHEN satinalma.tedarikci_id = firma.id THEN firma.firma_adi ELSE 'Firma Belirtilmedi' END as firmaadi, satinalma.id, IsId, baslik, siparis_tarihi, oncelik, tedarikci_id, proje_id, toplamtl, toplamusd, toplameur, aciklama, satinalma.durum, satinalma.cop, satinalma.firma_kodu, satinalma.ekleme_tarihi, satinalma.ekleme_saati from satinalma_listesi satinalma INNER JOIN ucgem_firma_listesi firma on satinalma.tedarikci_id = firma.id  or satinalma.tedarikci_id = 0 where satinalma.id = '"& satinalma_id &"'"
    set satinalma = baglanti.execute(SQL)

    SQL="SELECT personel_ad,personel_soyad FROM ucgem_firma_kullanici_listesi kullanici INNER JOIN satinalma_listesi satinalma on satinalma.ekleyen_id = kullanici.id WHERE satinalma.id = '"& satinalma_id &"'"
    set kullanici = baglanti.execute(SQL)

%>
<html lang="tr">
<head>
    <title><%=LNG("Satınalma Formu")%></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

</head>
<body>

    <table border="1" cellpadding="0" cellspacing="0" style="width: 100%; border: solid 1px black;  font-family:Arial; font-size:12px;">
        <tbody>
            <tr>
                <td colspan="2" style="vertical-align: middle; padding-bottom:50px;">
                    <span style="float: left;">
                        <img src="/images/esotomasyon_logo.png" style="width: 150px;" />
                    </span>
                    <br />
                    <center>
                                       <span style="font-weight:bold; font-size:30px;">SATINALMA FORMU</span>
                                   </center>
                </td>
            </tr>
      
            <tr>
                <td style="height: 40px;"><strong>SATINALMA BİLGİLERİ</strong></td>
                <td style="width: 50%; ">Tarih : <%=cdate(satinalma("ekleme_tarihi")) %></td>
            </tr>
            <tr>
                <td style="height: 40px;">Satınalma Adı : <%=satinalma("baslik") %></td>
                <td>Öncelik : </td>
            </tr>
            <tr>
                <td style="height: 40px;">Tedarikçi : <%=satinalma("firmaadi") %></td>
                <td style="height: 40px;">Sipariş Eden : <%=kullanici("personel_ad") %>&nbsp;<%=kullanici("personel_soyad") %></td>
            </tr>
        </tbody>
    </table>
     <br />
    <br />
    <table border="1" cellpadding="0" cellspacing="0" style="width: 100%; border: solid 1px black;">
        <tbody>
            <tr>
                <td style="height: 40px;"><strong>AÇIKLAMA :</strong></td>
            </tr>
            <tr>
                <td style="height: 60px;"><%=satinalma("aciklama") %></td>
            </tr>
        </tbody>
    </table>

    <br />
    <br />
    <strong>SİPARİŞ LİSTESİ</strong>
    <br />
    <table border="1" cellpadding="0" cellspacing="0" style="width: 100%; border: solid 1px black;  font-family:Arial; font-size:12px;">
        <thead>
                <tr>
                    <th style="padding: 10px; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important; width:40px;">NO</th>
                    <th style="padding: 10px; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important; width:40px;"><%=LNG("KODU") %></th>
                    <th style="padding: 10px; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("MARKA")%></th>
                    <th style="padding: 10px; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("PARÇA/CİHAZ")%></th>
                    <th style="padding: 10px; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;">ADET</th>
                </tr>
            </thead>
        <tbody>
            <% 
                SQL="select siparis.*, parca.parca_kodu, parca.marka, parca.parca_adi, parca.minumum_miktar, parca.aciklama as paciklama from satinalma_siparis_listesi siparis join parca_listesi parca on parca.id= siparis.parcaId where siparis.SatinalmaId = '"& satinalma_id &"' and siparis.cop = 'false' order by siparis.id asc"
                set cek = baglanti.execute(SQL)
                x = 0
                do while not cek.eof
                    x = x + 1
                %>
            <tr>
                <td style="height:30px; padding-left:5px"><%=x %></td>
                <td style="padding-left:5px"><%=cek("parca_kodu") %></td>
                <td style="padding-left:5px"><%=cek("marka") %></td>
                <td style="padding-left:5px"><%=cek("parca_adi") & " - " & cek("paciklama") %></td>
                <td style="padding-left:5px"><%=CInt(cek("adet") - cek("minumum_miktar")) %> ADET</td>
            </tr>
            <% cek.movenext
               loop
                %>
        </tbody>
    </table>
   

</body>
</html>
