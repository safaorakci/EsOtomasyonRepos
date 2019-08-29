<%@ Application Language="C#" %>

<%@ Import Namespace="System.Web.Routing" %>

<script runat="server">


    private int VisitorCount
    {
        get
        {
            return Application["VisitorCount"] != null ? (int)Application["VisitorCount"] : 0;
        }
        set
        {
            Application.Lock();
            Application["VisitorCount"] = value;
            Application.UnLock();
        }
    }

    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup
        RegisterRoutes(RouteTable.Routes);
    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown
    }

    void Application_Error(object sender, EventArgs e)
    {
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e)
    {
        VisitorCount += 1;
    }

    void Session_End(object sender, EventArgs e)
    {
        VisitorCount -= 1;
    }

    public static void RegisterRoutes(RouteCollection routes)
    {
        routes.Clear();
        
        routes.Add("yonetimRoute", new Route("login", new SimpleRouteHandler("~/Login.aspx")));
        routes.Add("systemdefaultRoote", new Route("home", new SimpleRouteHandler("~/default.aspx")));
        routes.Add("systemislem1Roote", new Route("islem1", new SimpleRouteHandler("~/System_Root/ajax/islem1.aspx")));
        routes.Add("departmanlarRoote", new Route("departmanlar", new SimpleRouteHandler("~/system_root/tanimlamalar/departman/ans.aspx")));
        routes.Add("gorevlerRoote", new Route("gorevler", new SimpleRouteHandler("~/System_Root/tanimlamalar/gorev/gorev_ans.aspx")));
        routes.Add("personelyonetimiRoote", new Route("personel_yonetimi", new SimpleRouteHandler("~/System_Root/personel_yonetimi/personel_yonetimi.aspx")));
        routes.Add("firmayonetimiRoote", new Route("firma_yonetimi", new SimpleRouteHandler("~/System_Root/firma_yonetimi/firma_yonetimi.aspx")));
        routes.Add("taseron_yonetimiRoote", new Route("taseron_yonetimi", new SimpleRouteHandler("~/System_Root/taseron_yonetimi/taseron_yonetimi.aspx")));
        routes.Add("islistesiRoote", new Route("is_listesi", new SimpleRouteHandler("~/System_Root/is_listesi/is_listesi.aspx")));
        routes.Add("islistesiRoote2", new Route("is_listesi2", new SimpleRouteHandler("~/System_Root/is_listesi/is_listesi2.aspx")));
        routes.Add("projelerRoote", new Route("projeler", new SimpleRouteHandler("~/System_Root/projeler/projeler.aspx")));
        routes.Add("santiyelerRoote", new Route("santiyeler", new SimpleRouteHandler("~/System_Root/santiyeler/santiyeler.aspx")));
        routes.Add("santiyelerRoote2", new Route("santiyeler_ic_detay", new SimpleRouteHandler("~/System_Root/santiyeler/santiye_detay.aspx")));
        routes.Add("santiye_durumRoote", new Route("santiye_durum", new SimpleRouteHandler("~/System_Root/tanimlamalar/santiye_durum/santiye_durum.aspx")));
        routes.Add("yonetim_firma_listesi", new Route("yonetim_firma_listesi", new SimpleRouteHandler("~/System_Root/yonetim/firma_yonetimi.aspx")));
        

        for (int i = 0; i < SiteSettings.SupportedLanguages.Length; i++)
        {
            routes.Add("languageRoute" + i, new Route("" + SiteSettings.SupportedLanguages[i], new SimpleRouteHandler("~/Default.aspx")));
        }

    }

</script>
