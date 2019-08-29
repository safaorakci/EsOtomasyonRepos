<% 
    Session.LCID = 1055 

    Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
    Response.CodePage = 65001

    Conn = "Provider=SQLOLEDB;User ID=sa;Password=Mn87rdr727*;Initial Catalog=EsOtomasyon;Data Source=makrogem.com;Network Library=DBMSSOCN;"
    set baglanti = server.CreateObject("Adodb.Connection")
    baglanti.Open conn


    if Request.ServerVariables("Remote_Addr")="127.0.0.1" then
        site_url = "http://127.0.0.1:92"
    else
        site_url = "http://www.esflw.com"
    end if

%>