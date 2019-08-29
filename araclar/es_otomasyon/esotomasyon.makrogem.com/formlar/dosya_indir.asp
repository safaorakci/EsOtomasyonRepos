<!--#include virtual="/data_root/conn.asp"-->
<!--#include virtual="/data_root/functions.asp"-->
<%
    Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
    Response.CodePage = 65001

    if ubound(gp)<4 then
        Response.End
    end if

    if isnumeric(gp(4))=true then
        if cdbl(gp(4))>0 then
        
            dosya_id = gp(4)

            SQL="select * from ahtapot_dosya_deposu where id = '"& dosya_id &"' and firma_id = '"& Request.Cookies("kullanici")("firma_id") &"'"
            set dosya = baglanti.execute(SQL)
            if dosya.eof then
                Response.Write "Bu Dosyayı Görmeye Yetkili Değilsiniz !"
            else
                ParcaParcaDosyaIndir server.MapPath(dosya("depo_dosya_yolu")), dosya("depo_dosya_adi") & "." & split(dosya("depo_dosya_yolu"), ".")(ubound(split(dosya("depo_dosya_yolu"), ".")))
            end if

        end if
    end if
%>