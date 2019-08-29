<!--#include virtual="/data_root/conn.asp"-->
<!--#include virtual="/data_root/functions.asp"-->
<%
    Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
    Response.CodePage = 65001

    kid = trn(request("kid"))

    SQL="select * from cari_hareketler where id = '"& kid &"'"
    set cari = baglanti.execute(SQL)

    if trim(cari("islem_tipi"))="Ödeme" and trim(cari("alacakli_tipi"))="firma" then
        SQL="select firma_adi from ucgem_firma_listesi where id = '"& cari("alacakli_id") &"'"
    elseif trim(cari("islem_tipi"))="Tahsilat" and trim(cari("borclu_tipi"))="firma" then
        SQL="select firma_adi from ucgem_firma_listesi where id = '"& cari("borclu_id") &"'"
    elseif trim(cari("islem_tipi"))="Ödeme" and trim(cari("alacakli_tipi"))="personel" then
        SQL="select personel_ad + ' ' + personel_soyad as personel_adi from ucgem_firma_kullanici_listesi where id = '"& cari("alacakli_id") &"'"
    elseif trim(cari("islem_tipi"))="Tahsilat" and trim(cari("borclu_tipi"))="personel" then
        SQL="select personel_ad + ' ' + personel_soyad as personel_adi from ucgem_firma_kullanici_listesi where id = '"& cari("borclu_id") &"'"
    end if
    set cari_hesap = baglanti.execute(SQL)

%>
<html>
<head>
    <title><%=LNG("Makbuz")%></title>
</head>
<body style="background-color: #e8e8e8;">
    <br />
    <br />
    <center><img src="/images/proskop_buyuk2_form.png" /></center><br /><br />

    <div style="width: 400px; margin-left: auto; margin-right: auto; border: solid 1px black; background-color: white; padding: 15px;">
        <table style="width: 100%; font-family:Tahoma;">
        <tr>
            <td style="vertical-align: top; text-align: left; line-height:25px;">
                <strong><%=trim(cari("islem_tipi")) %> <%=LNG("Makbuzu")%></strong><br />
                <span style="font-size:12px;"><%=LNG("Oluşturma Tarihi")%>&nbsp;:&nbsp;<%=now %></span></td>
            
        </tr>
    </table><br />
        <table style="width: 100%; font-family: Arial; line-height: 20px; font-size: 12px;">
            <thead>
                <tr>
                    <td style="font-weight: bold; width: 100px;">
                        <div style="width: 100px;"><%=LNG("Cari Hesap")%></div>
                    </td>
                    <td>:</td>
                    <td><%=cari_hesap(0) %></td>
                </tr>
                <tr>
                    <td style="font-weight: bold;"><%=LNG("İşlem Tarihi")%></td>
                    <td>:</td>
                    <td><%=day(cdate(cari("islem_tarihi"))) %>&nbsp;<%=monthname(month(cdate(cari("islem_tarihi")))) %>&nbsp;<%=year(cdate(cari("islem_tarihi"))) %>&nbsp;<%=weekdayname(weekday(cdate(cari("islem_tarihi")))) %></td>
                </tr>
                <tr>
                    <td style="font-weight: bold;"><%=LNG("Açıklama")%></td>
                    <td>:</td>
                    <td><%=cari("aciklama") %></td>
                </tr>
                <tr>
                    <td style="font-weight: bold;">
                        <% if trim(cari("islem_tipi"))="Tahsilat" then %>
                        <%=LNG("Tahsil Edilen Meblağ")%>
                        <% else %>
                        <%=LNG("Ödenen Meblağ")%>
                        <% end if %>
                    </td>
                    <td>:</td>
                    <td><%=formatnumber(cari("meblag"),2) %>&nbsp;<%=cari("parabirimi") %></td>
                </tr>
            </thead>
        </table>
    </div>
</body>
</html>
