<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    proje_id = trn(request("proje_id"))
    
    SQL="select DISTINCT CASE WHEN satinalma.tedarikci_id = firma.id THEN firma.firma_adi ELSE 'Firma Belirtilmedi' END as firmaadi, satinalma.id, IsId, baslik, siparis_tarihi, oncelik, tedarikci_id, proje_id, toplamtl, toplamusd, toplameur, aciklama, satinalma.durum, satinalma.cop, satinalma.firma_kodu, satinalma.ekleme_tarihi, satinalma.ekleme_saati from satinalma_listesi satinalma INNER JOIN ucgem_firma_listesi firma on satinalma.tedarikci_id = firma.id  or satinalma.tedarikci_id = 0 where satinalma.proje_id = '"& proje_id &"' and not satinalma.durum = 'Iptal Edildi' and satinalma.cop = 'false'"
    set satinalma = baglanti.execute(SQL)

    SQL="select is_parca.IsID, is_parca.ParcaId, is_parca.StoktanKullanilanAdet, is_parca.SiparisVerilenAdet from ucgem_is_listesi is_listesi, is_parca_listesi is_parca where is_parca.IsID = is_listesi.id and departmanlar like '%proje-"&proje_id&"%' and is_listesi.durum = 'true' and is_listesi.cop = 'false'"
    set stoktanKullanilan = baglanti.execute(SQL)
    'response.Write(SQL)

    SQL="SELECT personel_ad,personel_soyad FROM ucgem_firma_kullanici_listesi kullanici INNER JOIN satinalma_listesi satinalma on satinalma.ekleyen_id = kullanici.id WHERE satinalma.proje_id = '"& proje_id &"' and not satinalma.durum = 'Iptal Edildi'"
    set kullanici = baglanti.execute(SQL)

    SQL = "SELECT ROW_NUMBER() OVER(ORDER BY kullanici.id) AS Id, kullanici.personel_ad + ' ' + personel_soyad as ad_soyad, proje.proje_adi, dbo.DakikadanSaatYap((SELECT ISNULL(SUM ((DATEDIFF(n, CONVERT(DATETIME, calisma.baslangic,103), CONVERT(DATETIME, calisma.bitis,103)))), 0) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT((select departmanlar from ucgem_is_listesi where id = calisma.is_id), ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(50), proje.id)) > 0 AND calisma.durum = 'true' AND calisma.cop = 'false' and calisma.ekleyen_id = kullanici.id)) AS calismaSuresi, CONVERT(decimal(18,2), ((SELECT ISNULL(SUM((DATEDIFF(n, CONVERT(DATETIME, calisma.baslangic,103), CONVERT(DATETIME, calisma.bitis,103)))) * 0.016667, 0) * kullanici.personel_saatlik_maliyet FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT((select departmanlar from ucgem_is_listesi where id = calisma.is_id), ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(50), proje.id)) > 0 AND calisma.durum = 'true' AND calisma.cop = 'false' and calisma.ekleyen_id = kullanici.id))) AS toplamMaliyet, kullanici.personel_maliyet_pb FROM dbo.ucgem_proje_listesi proje, ucgem_firma_kullanici_listesi kullanici where proje.firma_id = '1' AND proje.id = '"& proje_id &"' AND proje.cop = 'false' AND proje.durum = 'true' AND ( ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT(DATETIME, calisma.baslangic,103), CONVERT(DATETIME, calisma.bitis,103)))), 0) FROM dbo.ucgem_is_calisma_listesi calisma WITH (NOLOCK) WHERE (SELECT COUNT(value) FROM STRING_SPLIT((select departmanlar from ucgem_is_listesi where id = calisma.is_id), ',') WHERE value = 'proje-' + CONVERT(NVARCHAR(50), proje.id)) > 0 AND calisma.durum = 'true' AND calisma.cop = 'false' and calisma.ekleyen_id = kullanici.id)) > 0 " 
    set personelAdamSaat = baglanti.execute(SQL)

    SQL = "select * from ucgem_firma_listesi where yetki_kodu = 'BOSS'"
    set firmaBilgileri = baglanti.execute(SQL)

    firmaLogo = firmaBilgileri("firma_logo")
    if firmaBilgileri("firma_logo") = "undefined" then
        firmaLogo = ""    
    end if

    ProjeToplamTL = 0
    ProjeToplamUSD = 0
    ProjeToplamEUR = 0
%>
<html lang="tr">
<head>
    <title><%=LNG("Proje Maliyet Formu")%></title>
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
                    <center><span style="font-weight:bold; font-size:30px;">PROJE MALİYET FORMU</span></center>
                </td>
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
                 s = s + 1
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
                 
                 if birimPB = "TL" then
                     SPTMTL = SPTMTL + Cdbl(parcaBilgi("birim_maliyet")) * adet
                     ProjeToplamTL = ProjeToplamTL + Cdbl(parcaBilgi("birim_maliyet")) * adet
                 end if
                 if birimPB = "USD" then
                     SPTMUSD = SPTMUSD + Cdbl(parcaBilgi("birim_maliyet")) * adet
                     ProjeToplamUSD = ProjeToplamUSD + Cdbl(parcaBilgi("birim_maliyet")) * adet
                 end if
                 if birimPB = "EUR" then
                     SPTMEUR = SPTMEUR + Cdbl(parcaBilgi("birim_maliyet")) * adet
                     ProjeToplamEUR = ProjeToplamEUR + Cdbl(parcaBilgi("birim_maliyet")) * adet
                 end if
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
            <tr>
                <td colspan="4" style="font-weight: bold; text-align: right; padding: 5px;">Toplam Maliyet</td>
                <td colspan="2" class="total" style="font-weight: bold; padding: 5px;"><%=SPTMTL %> TL - <%=SPTMUSD %> USD - <%=SPTMEUR %> EUR</td>
            </tr>
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
                if stoktanKullanilan.eof then
            %>
            <tr>
                <td colspan="6" style="text-align: center; padding: 5px">Kayıt Bulunamadı</td>
            </tr>
            <%
                end if
                do while not stoktanKullanilan.eof
                k = k + 1
                SQL = "select * from parca_listesi where id = '"& stoktanKullanilan("ParcaId") &"'"
                set parca = baglanti.execute(SQL)

                birimPB = "TL"
                if parca("birim_pb") = "" then
                else
                   birimPB = parca("birim_pb")
                   if birimPB = "EURO" then
                       birimPB = "EUR"
                   end if
                end if

                KullanilanToplamMaliyet = Cdbl(parca("birim_maliyet")) * stoktanKullanilan("StoktanKullanilanAdet")

                if birimPB = "TL" then
                    STMTL = STMTL + Cdbl(parca("birim_maliyet")) * stoktanKullanilan("StoktanKullanilanAdet")
                    ProjeToplamTL = ProjeToplamTL + Cdbl(parca("birim_maliyet")) * stoktanKullanilan("StoktanKullanilanAdet")
                end if
                if birimPB = "USD" then
                    STMUSD = STMUSD + Cdbl(parca("birim_maliyet")) * stoktanKullanilan("StoktanKullanilanAdet")
                    ProjeToplamUSD = ProjeToplamUSD + Cdbl(parca("birim_maliyet")) * stoktanKullanilan("StoktanKullanilanAdet")
                end if
                if birimPB = "EUR" then
                    STMEUR = STMEUR + Cdbl(parca("birim_maliyet")) * stoktanKullanilan("StoktanKullanilanAdet")
                    ProjeToplamEUR = ProjeToplamEUR + Cdbl(parca("birim_maliyet")) * stoktanKullanilan("StoktanKullanilanAdet")
                end if
            %>
            <tr>
                <td style="padding: 5px; text-align: left"><%=parca("parca_kodu") %> - <%=parca("parca_adi") %></td>
                <td style="padding: 5px; text-align: left"><%=parca("marka") %></td>
                <td style="padding: 5px; text-align: left"><%=parca("aciklama") %></td>
                <td style="padding: 5px; text-align: left"><%=stoktanKullanilan("StoktanKullanilanAdet") %></td>
                <td style="padding: 5px; text-align: left"><%=parca("birim_maliyet") %>&nbsp;<%=birimPB %></td>
                <td style="padding: 5px; text-align: left" class="toplamMaliyet"><%=KullanilanToplamMaliyet %>&nbsp;<%=birimPB %></td>
            </tr>
            <%
                stoktanKullanilan.movenext
                loop
            %>
            <tr>
                <td colspan="4" style="font-weight: bold; text-align: right; padding: 5px;">Toplam Maliyet</td>
                <td colspan="2" class="total" style="font-weight: bold; padding: 5px;"><%=STMTL %> TL - <%=STMUSD %> USD - <%=STMEUR %> EUR</td>
            </tr>
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
                <th style="padding: 5px; text-align: left">Maliyet</th>
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

                 personelMaliyetPB = personelAdamSaat("personel_maliyet_pb")
                 if personelMaliyetPB = "TL" then
                     ASTL = Cdbl(ASTL + Cdbl(personelAdamSaat("toplamMaliyet")))
                     ProjeToplamTL = Cdbl(ProjeToplamTL + Cdbl(personelAdamSaat("toplamMaliyet")))
                 end if
                 if personelMaliyetPB = "USD" then
                     ASUSD = Cdbl(ASUSD + Cdbl(personelAdamSaat("toplamMaliyet")))
                     ProjeToplamUSD = Cdbl(ProjeToplamUSD + Cdbl(personelAdamSaat("toplamMaliyet")))
                 end if
                 if personelMaliyetPB = "EUR" then
                     ASEUR = Cdbl(ASEUR + Cdbl(personelAdamSaat("toplamMaliyet")))
                     ProjeToplamEUR = Cdbl(ProjeToplamEUR + Cdbl(personelAdamSaat("toplamMaliyet")))
                 end if
            %>
            <tr>
                <td style="padding: 5px; text-align: left"><%=personelAdamSaat("ad_soyad") %></td>
                <td style="padding: 5px; text-align: left"><%=personelAdamSaat("calismaSuresi") %></td>
                <td style="padding: 5px; text-align: left" class="toplamMaliyet"><%=Replace(personelAdamSaat("toplamMaliyet"),",",".") %>&nbsp;<%=personelMaliyetPB %></td>
            </tr>
            <%
                 personelAdamSaat.movenext
                 loop
            %>
            <tr>
                <td colspan="2" style="font-weight: bold; text-align: right; padding: 5px;">Toplam Maliyet</td>
                <td class="total" style="font-weight: bold; padding: 5px;">
                    <%=Replace(FormatNumber(ASTL,,,,0),",",".") %>&nbsp;TL - 
                    <%=Replace(FormatNumber(ASUSD,,,,0),",",".") %>&nbsp;USD -
                    <%=Replace(FormatNumber(ASEUR,,,,0),",",".") %>&nbsp;EUR
                </td>
            </tr>
        </tbody>
    </table>

    <br />
    <br />
    <table style="font-family: Arial; font-size: 13px; float:right">
        <thead>
            <tr>
                <th style="padding:6px 10px; margin-right:0px; text-align:right; font-weight:700; background: linear-gradient(45deg, #FFB64D, #ffcb80)">
                    Toplam Proje Maliyeti: <%=ProjeToplamTL %>&nbsp;TL - <%=ProjeToplamUSD %>&nbsp;USD - <%=ProjeToplamEUR %>&nbsp;EUR
                </th>
            </tr>
        </thead>
    </table>
</body>
</html>
