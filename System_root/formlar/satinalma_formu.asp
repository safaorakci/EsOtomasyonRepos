﻿<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    satinalma_id = trn(request("satinalma_id"))
    

    SQL="SELECT firma_adi, satinalma.*  FROM ucgem_firma_listesi firma, satinalma_listesi satinalma  WHERE firma.id =( select tedarikci_id from satinalma_listesi satinalma WHERE id = '"& satinalma_id &"') AND satinalma.id = '"& satinalma_id &"'"
    set satinalma = baglanti.execute(SQL)

    SQL="SELECT personel_ad,personel_soyad FROM ucgem_firma_kullanici_listesi kullanici INNER JOIN	 satinalma_listesi satinalma on satinalma.ekleyen_id = kullanici.id WHERE satinalma.id = '"& satinalma_id &"'"
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
                <td style="height: 40px;">Tedarikçi : <%=satinalma("firma_adi") %></td>
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
    <table border="1" cellpadding="0" cellspacing="0" style="width: 100%; border: solid 1px black;  font-family:Arial; font-size:12px;">
        <thead>
                <tr>
                    <th style="padding: 10px; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important; width:40px;"></th>
                    <th style="padding: 10px; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("MARKA")%></th>
                    <th style="padding: 10px; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;"><%=LNG("PARÇA/CİHAZ")%></th>
                    <th style="padding: 10px; vertical-align: middle; font-weight: bold; font-size: 15px; color: #495057; background-color: #e9ecef!important;">ADET</th>
                </tr>
            </thead>
        <tbody>
            <% 
                SQL="select siparis.*, parca.marka, parca.parca_adi, parca.aciklama as paciklama from satinalma_siparis_listesi siparis join parca_listesi parca on parca.id= siparis.parcaId where siparis.SatinalmaId = '"& satinalma_id &"' and siparis.cop = 'false' order by siparis.id asc"
                set cek = baglanti.execute(SQL)
                x = 0
                do while not cek.eof
                    x = x + 1
                %>
            <tr>
                <td style="height:30px;"><%=x %></td>
                <td><%=cek("marka") %></td>
                <td><%=cek("parca_adi") & " - " & cek("paciklama") %></td>
                <td><%=cek("adet") %> ADET</td>
            </tr>
            <% cek.movenext
               loop
                %>
        </tbody>
    </table>
   

</body>
</html>
