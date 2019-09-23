<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001

    

    if trn(request("islem"))="bildirimleri_getir" then

        SQL="SELECT TOP 20 convert(datetime, bildirim.ekleme_tarihi) as ekleme_zamani, kullanici.personel_ad + ' ' + kullanici.personel_soyad AS personel_ad_soyad, kullanici.personel_resim, bildirim.* FROM ahtapot_bildirim_listesi bildirim JOIN dbo.ucgem_firma_kullanici_listesi kullanici ON kullanici.id = bildirim.ekleyen_id WHERE bildirim.user_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' ORDER BY bildirim.id desc"
        set bildirim = baglanti.execute(SQL)
%>

<style>
    .okunmadi {
        background-color: #edf6ff;
        cursor: pointer;
    }


    .show-notification::-webkit-scrollbar-track {
        -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
        background-color: #F5F5F5;
    }

    .show-notification::-webkit-scrollbar {
        width: 6px;
        background-color: #F5F5F5;
    }

    .show-notification::-webkit-scrollbar-thumb {
        background-color: #6cb0ff;
    }
</style>

<ul class="show-notification show-notification2" style="height: 375px; overflow-x: hidden; overflow-y: auto;">
    <li>
        <h6><%=LNG("Bildirimler") %></h6>
    </li>
    <%
        if bildirim.eof then
    %>
    <li>
        <div class="media">

            <div class="media-body">
                <p class="notification-msg"><%=LNG("Kayıt Yok") %></p>
            </div>
        </div>
    </li>
    <%
        end if

        bildirimler = ""

        do while not bildirim.eof
            if bildirim("okudumu")="False" then
        
                bildirimler = bildirimler & bildirim("id") & ","
            end if

    %>
    <li id="<%=bildirim("id") %>" onclick="<%=bildirim("click") %>" <% if bildirim("okudumu")="False" then %> class="okunmadi bildirim" <% else %> class="bildirim" <% end if %>>
        <div class="media">
            <img class="d-flex align-self-center img-radius" src="<%=bildirim("personel_resim") %>" alt="<%=bildirim("personel_ad_soyad") %>">
            <div class="media-body">
                <h5 class="notification-user"><%=bildirim("personel_ad_soyad") %></h5>
                <p class="notification-msg"><%=bildirim("bildirim") %></p>
                <span title="<%=cdate(bildirim("ekleme_tarihi")) & " " & left(bildirim("ekleme_saati"),5) %>" class="notification-time"><%=RelativeTime(bildirim("ekleme_zamani")) %></span>
            </div>
        </div>
    </li>
    <%
        bildirim.movenext
        loop
        bildirimler = bildirimler & "0"

        if  len(bildirimler)>1 then
            SQL="update ahtapot_bildirim_listesi set okudumu = 1 where id in ("& bildirimler &")"
            set guncelle = baglanti.execute(SQL)
        end if
    %>
    <li onclick="sayfagetir('/bildirim_merkezi/','jsid=4559');" style="cursor: pointer;">
        <div class="media">
            <div class="media-body">
                <p class="notification-msg"><%=LNG("Tümünü Gör") %></p>
            </div>
        </div>
    </li>
</ul>
<script>
    $(function (){
        $("#bildirim_var").html("0").hide();
    });
</script>
<% 
    elseif trn(request("islem"))="" then

        SQL="SELECT TOP 20 isnull(bildirim.bildirim_verdikmi,'False') as bildirim_verdikmi2, convert(datetime, bildirim.ekleme_tarihi) + convert(datetime, bildirim.ekleme_saati) as ekleme_zamani, kullanici.personel_ad + ' ' + kullanici.personel_soyad AS personel_ad_soyad, kullanici.personel_resim, bildirim.* FROM ahtapot_bildirim_listesi bildirim JOIN dbo.ucgem_firma_kullanici_listesi kullanici ON kullanici.id = bildirim.ekleyen_id WHERE bildirim.user_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' and bildirim.okudumu = 'false' ORDER BY bildirim.id desc"
        set bildirim = baglanti.execute(SQL)

%>
<script type="text/javascript">

    $(function () {

        var p = 0;
        if ($(".ui-pnotify").length > 1) {
            $(".ui-pnotify").each(function () {
                p++;
                if (p < 2) {
                    $(this).remove();
                }
            });
        }
    
    <%

            bildirimsay = 0
        varmi = false
        bildirimler = ""
        do while not bildirim.eof

            if bildirim("okudumu") = "False" then
        bildirimler = bildirimler & bildirim("id") & ","
        end if
            varmi = true

                if trim(bildirim("bildirim_verdikmi2")) = "False" then
                %>
    var notice = new PNotify({
            title: '<%=bildirim("personel_ad_soyad")%>',
            text: "<%=bildirim("bildirim")%><br><span style='float:right;'><%=cdate(bildirim("ekleme_tarihi")) & " " & left(bildirim("ekleme_saati"),5) %></span>",
            icon: 'icofont icofont-info-circle',
            type: 'info',
            addclass: 'bg-info',
            hide: false,
            buttons: {
                closer: true,
                sticker: true
            }
        });
        notice.get().click(function () {
            notice.remove();
            //<%=bildirim("click")%>
        });
    <%

            end if

            if trim(bildirim("bildirim_verdikmi2")) = "False" then
        bildirimler2 = bildirimler2 & bildirim("id") & ","
        end if

            bildirimsay = cdbl(bildirimsay) + 1

        bildirim.movenext
        loop

        bildirimler = bildirimler & "0"
        bildirimler2 = bildirimler2 & "0"

        if  len(bildirimler2) > 1 then
        SQL = "update ahtapot_bildirim_listesi set bildirim_verdikmi = 1 where id in (" & bildirimler2 & ")"
        set guncelle = baglanti.execute(SQL)
        end if
            %>

    <% if varmi = True then %>
                $("#bildirim_var").html("<%=bildirimsay%>").show();
    <% else %>
            $("#bildirim_var").html("<%=bildirimsay%>").hide();
    <% end if %>
        });

</script>
<% end if %>