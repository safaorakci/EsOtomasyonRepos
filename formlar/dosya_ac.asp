﻿<!--#include virtual="/data_root/conn.asp"-->
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
                Response.Write "" & LNG("Bu Dosyayı Görmeye Yetkili Değilsiniz !") & ""
            else

                ' ParcaParcaDosyaIndir server.MapPath(dosya("depo_dosya_yolu")), dosya("depo_dosya_adi") & "." & split(dosya("depo_dosya_yolu"), ".")(ubound(split(dosya("depo_dosya_yolu"), ".")))

                dosya_tipi = split(dosya("depo_dosya_yolu"), ".")(ubound(split(dosya("depo_dosya_yolu"), ".")))
                if trim(dosya_tipi)="doc" or trim(dosya_tipi)="docx" or trim(dosya_tipi)="xls" or trim(dosya_tipi)="xlsx" or trim(dosya_tipi)="ppt" or trim(dosya_tipi)="pptx" then
                    Response.redirect "https://view.officeapps.live.com/op/view.aspx?src=http%3A%2F%2Fhttp://esotomasyon.makrogem.com.tr"& replace(dosya("depo_dosya_yolu"), "/", "%2F")
                elseif trim(dosya_tipi)="pdf" then
                    Response.Redirect "http://esotomasyon.makrogem.com.tr" & dosya("depo_dosya_yolu")
                elseif trim(dosya_tipi)="jpg" or trim(dosya_tipi)="jpeg" or trim(dosya_tipi)="gif" or trim(dosya_tipi)="png" then
                    Response.Redirect "http://esotomasyon.makrogem.com.tr" & dosya("depo_dosya_yolu")
                else
                    ParcaParcaDosyaIndir server.MapPath(dosya("depo_dosya_yolu")), dosya("depo_dosya_adi") & "." & split(dosya("depo_dosya_yolu"), ".")(ubound(split(dosya("depo_dosya_yolu"), ".")))
                end if

            end if

        end if
    end if
%>