<%
    
    Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
    Response.CodePage = 65001

    Response.Cookies("kullanici")("default_pb") = ""
    Response.Cookies("kullanici")("dil_secenek") = ""
    Response.Cookies("kullanici")("yetki_kodu") = ""
    Response.Cookies("kullanici")("firma_kodu") = ""
    Response.Cookies("kullanici")("firma_hid") = ""
    Response.Cookies("kullanici")("kullanici_hid") = ""
    Response.Cookies("kullanici")("resim") = ""
    Response.Cookies("kullanici")("firma_id") = ""
    Response.Cookies("kullanici")("kullanici_id") = ""
    Response.Cookies("kullanici")("ekleyen_id") = ""
    Response.Cookies("kullanici")("kullanici_adi") = ""
    Response.Cookies("kullanici")("departmanlar") = ""
    Response.Cookies("kullanici")("yetkili_sayfalar") = ""
    Response.Cookies("kullanici")("kullanici_adsoyad") = ""
    Response.Cookies("kullanici")("durum") = ""
    Response.Cookies("kullanici")("login") = ""
    Response.Cookies("kullanici")("login_tarih") = ""
    Response.Cookies("kullanici")("remember") = ""
    Response.Cookies("kullanici")("Rolu") = ""
    Response.Cookies("kullanici").Expires = Date() -1

    Response.Redirect "/login.aspx"
    
    %>
