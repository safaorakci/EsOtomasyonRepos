<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001


    dil = trn(request("dil"))

    SQL="update ucgem_firma_kullanici_listesi set dil = '"& dil &"' where id = '"& Request.Cookies("kullanici")("kullanici_id") &"'"
    set guncelle = baglanti.execute(SQL)

    Response.Cookies("kullanici2")("dil_secenek2") = dil
    Response.Cookies("kullanici2").Expires = Date() + 30

    Response.Redirect "/default.aspx"
%>