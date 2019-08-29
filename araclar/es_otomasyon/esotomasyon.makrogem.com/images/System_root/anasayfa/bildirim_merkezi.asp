<!-- #include virtual="/data_root/conn.asp" -->
<!-- #include virtual="/data_root/functions.asp" -->
<% 
    Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
    Response.CodePage = 65001


    
%>
<style>
        .okunmadi {
        background-color: #edf6ff;
        cursor: pointer;
    }
</style>

<div class="page-body breadcrumb-page">
    <div class="card page-header p-0">
        <div class="card-block front-icon-breadcrumb row align-items-end">
            <div class="breadcrumb-header col">
                <div class="big-icon">
                    <div class="card-block user-info" style="bottom: -65px;">
                        <div class="media-left">
                            <a href="#" class="profile-image">
                                <img class="user-img img-radius" src="<%=Request.cookies("kullanici")("resim") %>" style="width: 140px;" alt="user-img">
                            </a>
                        </div>
                    </div>
                </div>
                <div class="d-inline-block" style="padding-left: 175px;">
                    <h5><%=Request.cookies("kullanici")("kullanici_adsoyad") %></h5>
                    <span><%=LNG("Bildirim Merkezi")%></span>
                </div>
            </div>
            <div class="col">
                <div class="page-header-breadcrumb">
                    <ul class="breadcrumb-title">
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-lg-12">
        <div class="card review-task">
            <div class="card-header">
                <div class="card-header-left">
                    <h5><%=LNG("Bildirimler")%></h5>
                </div>
                
            </div>
            <div class="card-block">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <tbody>
                            <%
                                SQL="SELECT TOP 20 convert(datetime, bildirim.ekleme_tarihi) as ekleme_zamani, kullanici.personel_ad + ' ' + kullanici.personel_soyad AS personel_ad_soyad, kullanici.personel_resim, bildirim.* FROM ahtapot_bildirim_listesi bildirim JOIN dbo.ucgem_firma_kullanici_listesi kullanici ON kullanici.id = bildirim.ekleyen_id WHERE bildirim.user_id = '"& Request.Cookies("kullanici")("kullanici_id") &"' ORDER BY bildirim.id desc"
                                set bildirim = baglanti.execute(SQL)
                                bildirimler = ""
                                do while not bildirim.eof

                                if bildirim("okudumu")="False" then
                                    bildirimler = bildirimler & bildirim("id") & ","
                                end if
                                %>
                            <tr  <% if bildirim("okudumu")="False" then %> class="okunmadi" <% end if %> onclick="<%=bildirim("click") %>">
                                <td style="width:60px;"><a href="#!">
                                    <img class="img-rounded" src="<%=bildirim("personel_resim") %>" style="width:43px; height:43px;" alt="chat-user"></a>
                                </td>
                                <td>
                                    <h6><%=bildirim("personel_ad_soyad") %></h6>
                                    <p class="text-muted"><%=bildirim("bildirim") %></p>
                                </td>
                                <td style="width:150px;"><span title=""><span><%=RelativeTime(bildirim("ekleme_zamani")) %></span><br /><%=cdate(bildirim("ekleme_tarihi")) & " " & left(bildirim("ekleme_saati"),5) %></span></td>
                            </tr>
                            <%
                                bildirim.movenext
                                loop

                                bildirimler = bildirimler & "0"

                                if  len(bildirimler)>1 then
                                    SQL="update ahtapot_bildirim_listesi set okudumu = 1 where id in ("& bildirimler &")"
                                    set guncelle = baglanti.execute(SQL)
                                end if

                                %>                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
