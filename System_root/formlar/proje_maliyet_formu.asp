<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    proje_id = trn(request("proje_id"))
    
    SQL="select DISTINCT CASE WHEN satinalma.tedarikci_id = firma.id THEN firma.firma_adi ELSE 'Firma Belirtilmedi' END as firmaadi, satinalma.id, IsId, baslik, siparis_tarihi, oncelik, tedarikci_id, proje_id, toplamtl, toplamusd, toplameur, aciklama, satinalma.durum, satinalma.cop, satinalma.firma_kodu, satinalma.ekleme_tarihi, satinalma.ekleme_saati from satinalma_listesi satinalma INNER JOIN ucgem_firma_listesi firma on satinalma.tedarikci_id = firma.id  or satinalma.tedarikci_id = 0 where satinalma.proje_id = '"& proje_id &"' and not satinalma.durum = 'Iptal Edildi' and satinalma.cop = 'false'"
    set satinalma = baglanti.execute(SQL)

    SQL="select DISTINCT CASE WHEN satinalma.tedarikci_id = firma.id THEN firma.firma_adi ELSE 'Firma Belirtilmedi' END as firmaadi, satinalma.id, IsId, baslik, siparis_tarihi, oncelik, tedarikci_id, proje_id, toplamtl, toplamusd, toplameur, aciklama, satinalma.durum, satinalma.cop, satinalma.firma_kodu, satinalma.ekleme_tarihi, satinalma.ekleme_saati from satinalma_listesi satinalma INNER JOIN ucgem_firma_listesi firma on satinalma.tedarikci_id = firma.id  or satinalma.tedarikci_id = 0 where satinalma.proje_id = '"& proje_id &"' and not satinalma.durum = 'Iptal Edildi' and satinalma.cop = 'false'"
    set satinalma2 = baglanti.execute(SQL)

    SQL="SELECT personel_ad,personel_soyad FROM ucgem_firma_kullanici_listesi kullanici INNER JOIN satinalma_listesi satinalma on satinalma.ekleyen_id = kullanici.id WHERE satinalma.proje_id = '"& proje_id &"' and not satinalma.durum = 'Iptal Edildi'"
    set kullanici = baglanti.execute(SQL)

    SQL = "SELECT ROW_NUMBER() OVER(ORDER BY kullanici.id) AS Id, kullanici.personel_ad + ' ' + personel_soyad as ad_soyad, proje.proje_adi, dbo.DakikadanSaatYap((SELECT ISNULL(SUM ((DATEDIFF(n, CONVERT(DATETIME, calisma.baslangic,103), CONVERT(DATETIME, calisma.bitis,103)))), 0) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT((select departmanlar from ucgem_is_listesi where id = calisma.is_id), ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(50), proje.id)) > 0 AND calisma.durum = 'true' AND calisma.cop = 'false' and calisma.ekleyen_id = kullanici.id)) AS calismaSuresi, CONVERT(decimal(18,2), ((SELECT ISNULL(SUM((DATEDIFF(n, CONVERT(DATETIME, calisma.baslangic,103), CONVERT(DATETIME, calisma.bitis,103)))) * 0.016667, 0) * kullanici.personel_saatlik_maliyet FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT((select departmanlar from ucgem_is_listesi where id = calisma.is_id), ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(50), proje.id)) > 0 AND calisma.durum = 'true' AND calisma.cop = 'false' and calisma.ekleyen_id = kullanici.id))) AS toplamMaliyet FROM dbo.ucgem_proje_listesi proje, ucgem_firma_kullanici_listesi kullanici where proje.firma_id = '1' AND proje.id = '"& proje_id &"' AND proje.cop = 'false' AND proje.durum = 'true' AND ( ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT(DATETIME, calisma.baslangic,103), CONVERT(DATETIME, calisma.bitis,103)))), 0) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT((select departmanlar from ucgem_is_listesi where id = calisma.is_id), ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(50), proje.id)) > 0 AND calisma.durum = 'true' AND calisma.cop = 'false' and calisma.ekleyen_id = kullanici.id)) > 0 " 
    set personelAdamSaat = baglanti.execute(SQL)

    SQL = "select * from ucgem_firma_listesi where yetki_kodu = 'BOSS'"
    set firmaBilgileri = baglanti.execute(SQL)

    firmaLogo = firmaBilgileri("firma_logo")
    if firmaBilgileri("firma_logo") = "undefined" then
        firmaLogo = ""    
    end if
%>
<html lang="tr">
<head>
    <title><%=LNG("Satınalma Formu")%></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

</head>
<body>

    <table border="1" cellpadding="0" cellspacing="0" style="width: 100%; border: solid 1px black; font-family: Arial; font-size: 12px;">
        <tbody>
            <tr>
                <td colspan="2" style="vertical-align: middle; padding-bottom: 50px;">
                    <span style="float: left;">
                        <%if firmaBilgileri("firma_kodu") = "ESOTOMASYON" then %>
                            <img src="<%=firmaLogo %>" style="width: 150px;" />
                        <%end if %>
                    </span>
                    <br />
                    <center>
                                       <span style="font-weight:bold; font-size:30px;">PROJE MALİYET FORMU</span>
                                   </center>
                </td>
            </tr>

            <tr>
                <td style="height: 40px;"><strong>SATINALMA BİLGİLERİ</strong></td>
                <td style="width: 50%;">Tarih : <%if satinalma.eof then %> --- <%else %> <%=cdate(satinalma("ekleme_tarihi")) %> <%end if %></td>
            </tr>
            <tr>
                <td style="height: 40px;">Satınalma Adı : <%if satinalma.eof then %> --- <%else %> <%=satinalma("baslik") %> <%end if %></td>
                <td>Öncelik : </td>
            </tr>
            <tr>
                <td style="height: 40px;">Tedarikçi : <%if satinalma.eof then %> --- <%else %> <%=satinalma("firmaadi") %> <%end if %></td>
                <td style="height: 40px;">Sipariş Eden : <%if kullanici.eof then %> --- <%else %> <%=kullanici("personel_ad") %>&nbsp;<%=kullanici("personel_soyad") %> <%end if %></td>
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
                <td style="height: 60px;"><%if satinalma.eof then %> --- <%else %> <%=satinalma("aciklama") %> <%end if %></td>
            </tr>
        </tbody>
    </table>
    <br />
    <br />
    <table border="1" cellpadding="0" cellspacing="0" style="width: 100%; border: solid 1px black; font-family: Arial; font-size: 12px;">
        <thead>
            <tr>
                <th colspan="6" style="text-align: center; padding: 5px">Sipariş Verilen Parçalar</th>
            </tr>
            <tr>
                <th style="padding: 5px; text-align: left">Parça</th>
                <th style="padding: 5px; text-align: left">Marka</th>
                <th style="padding: 5px; text-align: left">Açıklama</th>
                <th style="padding: 5px; text-align: left">Adet</th>
                <th style="padding: 5px; text-align: left">Maliyet</th>
                <th style="padding: 5px; text-align: left">Toplam Maliyet</th>
            </tr>
        </thead>
        <tbody>
            <% 
                 if satinalma.eof then 
            %>
            <tr>
                <td colspan="6" style="text-align: center; padding: 5px">Kayıt Bulunamadı</td>
            </tr>
            <%
                 end if
                 do while not satinalma.eof

                 SQL = "select * from satinalma_siparis_listesi where SatinalmaId = '"& satinalma("id") &"' and cop = 'false'"
                 set siparisparca = baglanti.execute(SQL)

                 do while not siparisparca.eof
                 durum = 0
                 if NOT IsNull(siparisparca("IsId")) then
                     SQL = "select id, IsID, ParcaId, StoktanKullanilanAdet, SiparisVerilenAdet from is_parca_listesi where ParcaId = '"& siparisparca("parcaId") &"' and IsID = '"& siparisparca("IsId") &"'"
                     durum = 1
                 else
                     SQL = "select * from satinalma_siparis_listesi where SatinalmaId = '"& satinalma("id") &"' and parcaId = '"& siparisparca("parcaId") &"' and cop = 'false'"
                     durum = 2
                 end if
                 set sondurum = baglanti.execute(SQL)

                 if durum = 1 then
                    SQL = "select * from parca_listesi where id = '"& sondurum("ParcaId") &"'"
                 else
                    SQL = "select * from parca_listesi where id = '"& sondurum("parcaId") &"'"
                 end if
                 set parcaBilgi = baglanti.execute(SQL)

                 if durum = 1 then
                     adet = CInt(sondurum("SiparisVerilenAdet") - parcaBilgi("minumum_miktar"))
                 else
                     adet = CInt(sondurum("adet"))
                 end if
                 birimPB = "TL"
                 if parcaBilgi("birim_pb") = "" then
                 else
                    birimPB = parcaBilgi("birim_pb")
                    if birimPB = "EURO" then
                        birimPB = "EUR"
                    end if
                 end if

                 SatinalmaToplamMaliyet = Cdbl(parcaBilgi("birim_maliyet")) * adet
            %>
            <tr>
                <td style="padding: 5px; text-align: left"><%=parcaBilgi("parca_kodu") %> - <%=parcaBilgi("parca_adi") %></td>
                <td style="padding: 5px; text-align: left"><%=parcaBilgi("marka") %></td>
                <td style="padding: 5px; text-align: left"><%=parcaBilgi("aciklama") %></td>
                <td style="padding: 5px; text-align: left"><% if durum = 1 then %> <%=CInt(sondurum("SiparisVerilenAdet") - parcaBilgi("minumum_miktar")) %> <%else %><%=CInt(sondurum("adet")) %> <%end if %></td>
                <td style="padding: 5px; text-align: left"><%=parcaBilgi("birim_maliyet") %>&nbsp;<%=birimPB %></td>
                <td style="padding: 5px; text-align: left" class="toplamMaliyet"><%=SatinalmaToplamMaliyet %>&nbsp;<%=birimPB %></td>
            </tr>
            <%
                 siparisparca.movenext
                 loop
                 satinalma.movenext
                 loop
            %>
        </tbody>
    </table>
    <br />
    <br />
    <table border="1" cellpadding="0" cellspacing="0" style="width: 100%; border: solid 1px black; font-family: Arial; font-size: 12px;">
        <thead>
            <tr>
                <th colspan="6" style="text-align: center; padding: 5px">Stoktan Kullanılan Parçalar</th>
            </tr>
            <tr>
                <th style="padding: 5px; text-align: left">Parça</th>
                <th style="padding: 5px; text-align: left">Marka</th>
                <th style="padding: 5px; text-align: left">Açıklama</th>
                <th style="padding: 5px; text-align: left">Adet</th>
                <th style="padding: 5px; text-align: left">Maliyet</th>
                <th style="padding: 5px; text-align: left">Toplam Maliyet</th>
            </tr>
        </thead>
        <tbody>
            <% 
                if satinalma2.eof then
            %>
            <tr>
                <td colspan="6" style="text-align: center; padding: 5px">Kayıt Bulunamadı</td>
            </tr>
            <%
                end if
                do while not satinalma2.eof

                SQL = "select * from satinalma_siparis_listesi where SatinalmaId = '"& satinalma2("id") &"' and cop = 'false'"
                set eksikparca = baglanti.execute(SQL)

                if NOT IsNull(eksikparca("IsId")) then
                do while not eksikparca.eof
                SQL = "select id, Adet, IsID, ParcaId, StoktanKullanilanAdet, SiparisVerilenAdet from is_parca_listesi where ParcaId = '"& eksikparca("parcaId") &"' and IsID = '"& eksikparca("IsId") &"'"
                'response.Write(SQL)
                set sondurum = baglanti.execute(SQL)

                SQL = "select * from parca_listesi where id = '"& sondurum("ParcaId") &"'"
                set parcaBilgi = baglanti.execute(SQL)

                birimPB = "TL"
                if parcaBilgi("birim_pb") = "" then
                else
                   birimPB = parcaBilgi("birim_pb")
                   if birimPB = "EURO" then
                       birimPB = "EUR"
                   end if
                end if

                KullanilanToplamMaliyet = Cdbl(parcaBilgi("birim_maliyet")) * sondurum("StoktanKullanilanAdet")
            %>
            <tr>
                <td style="padding: 5px; text-align: left"><%=parcaBilgi("parca_kodu") %> - <%=parcaBilgi("parca_adi") %></td>
                <td style="padding: 5px; text-align: left"><%=parcaBilgi("marka") %></td>
                <td style="padding: 5px; text-align: left"><%=parcaBilgi("aciklama") %></td>
                <td style="padding: 5px; text-align: left"><%=sondurum("StoktanKullanilanAdet") %></td>
                <td style="padding: 5px; text-align: left"><%=parcaBilgi("birim_maliyet") %>&nbsp;<%=birimPB %></td>
                <td style="padding: 5px; text-align: left" class="toplamMaliyet"><%=KullanilanToplamMaliyet %>&nbsp;<%=birimPB %></td>
            </tr>
            <%
                eksikparca.movenext
                loop
                end if
                satinalma2.movenext
                loop
            %>
        </tbody>
    </table>
    <br />
    <br />
    <table border="1" cellpadding="0" cellspacing="0" style="width: 100%; border: solid 1px black; font-family: Arial; font-size: 12px;">
        <thead>
            <tr>
                <th colspan="3" style="text-align: center; padding: 5px">Personel Adam Saat</th>
            </tr>
            <tr>
                <th style="padding: 5px; text-align: left">Personel</th>
                <th style="padding: 5px; text-align: left">Çalışma Süresi</th>
                <th style="padding: 5px; text-align: left">Toplam Maliyeti</th>
            </tr>
        </thead>
        <tbody>
            <%
                 if personelAdamSaat.eof then
            %>
            <tr>
                <td colspan="3" style="text-align: center; padding: 5px">Kayıt Bulunamadı</td>
            </tr>
            <%
                 end if
                 do while not personelAdamSaat.eof
            %>
            <tr>
                <td style="padding: 5px; text-align: left"><%=personelAdamSaat("ad_soyad") %></td>
                <td style="padding: 5px; text-align: left"><%=personelAdamSaat("calismaSuresi") %></td>
                <td style="padding: 5px; text-align: left" class="toplamMaliyet"><%=Replace(personelAdamSaat("toplamMaliyet"),",",".") %> TL</td>
            </tr>
            <%
                 personelAdamSaat.movenext
                 loop
            %>
        </tbody>
    </table>

</body>
</html>
