<% 
    Session.LCID = 1055 

    Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
    Response.CodePage = 65001

    Conn = "Provider=SQLOLEDB;User ID=osman;Password=156901032**mamedov;Initial Catalog=ProskopV2Dev;Data Source=185.86.81.251,1453;Network Library=DBMSSOCN;"
    set baglanti = server.CreateObject("Adodb.Connection")
    baglanti.Open conn

    SQL = "select * from ucgem_firma_listesi where yetki_kodu = 'BOSS'"
    set firmaBilgileri = baglanti.execute(SQL)


    if Request.ServerVariables("Remote_Addr")="127.0.0.1" then
        site_url = "http://127.0.0.1:92"
    elseif Request.ServerVariables("Remote_Addr")="::1" then
        site_url = "http://localhost:52225"
    else
        site_url = firmaBilgileri("firma_http")
    end if

%>