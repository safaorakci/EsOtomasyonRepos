<% 
    Session.LCID = 1055 

    Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
    Response.CodePage = 65001

    Conn = "Provider=SQLOLEDB;User ID=sa;Password=Makro1234.;Initial Catalog=ProskopV2Dev;Data Source=185.86.81.251;Network Library=DBMSSOCN;"
    set baglanti = server.CreateObject("Adodb.Connection")
    baglanti.Open conn

    


    'if Request.ServerVariables("Remote_Addr")="127.0.0.1" then
        'site_url = "http://127.0.0.1:92"
    'elseif Request.ServerVariables("Remote_Addr")="::1" then
        site_url = "http://localhost:52225"
    'else
        'site_url = "http://proskopv2dev.makrogem.com.tr"
    'end if

%>