using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Ahtapot.App_Code.ayarlar;
using System.Globalization;

public partial class SiteMaster : MasterPage
{
    private const string AntiXsrfTokenKey = "__AntiXsrfToken";
    private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
    private string _antiXsrfTokenValue;
    public XmlDocument doc = new XmlDocument();
    

    protected void Page_Init(object sender, EventArgs e)
    {
        doc.Load(Server.MapPath("/dil_cevirileri.xml"));

        HttpCookie cookie2 = HttpContext.Current.Request.Cookies["kullanici"];



        string login = "";
        try
        {
            login = HttpUtility.UrlDecode(cookie2["login"].ToString());
        }
        catch (Exception)
        {
            Response.Redirect("/login.aspx");
            Response.End();
        }

        if (login != "true")
        {
            Response.Redirect("/login.aspx");
            Response.End();
        }

        // The code below helps to protect against XSRF attacks
        var requestCookie = Request.Cookies[AntiXsrfTokenKey];
        Guid requestCookieGuidValue;
        if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
        {
            // Use the Anti-XSRF token from the cookie
            _antiXsrfTokenValue = requestCookie.Value;
            Page.ViewStateUserKey = _antiXsrfTokenValue;
        }
        else
        {
            // Generate a new Anti-XSRF token and save to the cookie
            _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
            Page.ViewStateUserKey = _antiXsrfTokenValue;

            var responseCookie = new HttpCookie(AntiXsrfTokenKey)
            {
                HttpOnly = true,
                Value = _antiXsrfTokenValue
            };
            if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
            {
                responseCookie.Secure = true;
            }
            Response.Cookies.Set(responseCookie);
        }

        Page.PreLoad += master_Page_PreLoad;
    }

    protected void master_Page_PreLoad(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Set Anti-XSRF token
            ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
            ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
        }
        else
        {
            // Validate the Anti-XSRF token
            if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
            {
                throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
            }
        }
    }



    
    public string LNG(string kelime)
    {
        string dil = Request.Cookies["kullanici"]["dil_secenek"].ToString();
        XmlNodeList nodes = doc.DocumentElement.SelectNodes("/diller/dil");
        bool kelimevarmi = false;
        foreach (XmlNode node in nodes)
        {
            string EnglishText = node.SelectSingleNode("turkce").InnerText;
            if (kelime == EnglishText)
            {
                kelime = node.SelectSingleNode(dil).InnerText;
                kelimevarmi = true;
            }
        }
        if (!kelimevarmi && 1==2)
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "EXEC dbo.dilayikla @kelimeler =  @kelimeler , @cikisdili = 'ingilizce';";
            ayarlar.cmd.Parameters.Add("kelimeler", kelime);
            ayarlar.cmd.ExecuteNonQuery();
        }
        
        return kelime;
    }

    public class ModulYetkiler
    {
        public bool stok { get; set; }
        public bool satinalma { get; set; }
        public bool teknikServis { get; set; }
        public bool hatirlatici { get; set; }
        public bool yillikIzinMezvuat { get; set; }
        public bool urunAgaci { get; set; }
        public bool uretimSablonu { get; set; }
        public bool toplanti { get; set; }
        public bool cariFinansman { get; set; }
        public bool isEmriOtmBaslatBitir { get; set; }
        public bool personelDevamKayitSistemi { get; set; }
    }

    public ModulYetkiler modulYetkiler()
    {
        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select * from tbl_ModulYetkileri where FirmaId = @firmaId";
        ayarlar.cmd.Parameters.AddWithValue("@firmaId", SessionManager.CurrentUser.firma_id);
        ayarlar.cmd.ExecuteNonQuery();

        //SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(ayarlar.cmd);
        //DataTable dataTable = new DataTable();
        //sqlDataAdapter.Fill(dataTable);

        ModulYetkiler yetkiler = new ModulYetkiler();
        SqlDataReader dataReader = ayarlar.cmd.ExecuteReader();
        while (dataReader.Read())
        {
            if (Convert.ToInt32(dataReader["ModulId"]) == 26 && Convert.ToBoolean(dataReader["Status"]) == true)
                yetkiler.satinalma = true;
            if (Convert.ToInt32(dataReader["ModulId"]) == 27 && Convert.ToBoolean(dataReader["Status"]) == true)
                yetkiler.teknikServis = true;
            if (Convert.ToInt32(dataReader["ModulId"]) == 28 && Convert.ToBoolean(dataReader["Status"]) == true)
                yetkiler.hatirlatici = true;
            if (Convert.ToInt32(dataReader["ModulId"]) == 29 && Convert.ToBoolean(dataReader["Status"]) == true)
                yetkiler.yillikIzinMezvuat = true;
            if (Convert.ToInt32(dataReader["ModulId"]) == 30 && Convert.ToBoolean(dataReader["Status"]) == true)
                yetkiler.urunAgaci = true;
            if (Convert.ToInt32(dataReader["ModulId"]) == 31 && Convert.ToBoolean(dataReader["Status"]) == true)
                yetkiler.uretimSablonu = true;
            if (Convert.ToInt32(dataReader["ModulId"]) == 32 && Convert.ToBoolean(dataReader["Status"]) == true)
                yetkiler.stok = true;
            if (Convert.ToInt32(dataReader["ModulId"]) == 35 && Convert.ToBoolean(dataReader["Status"]) == true)
                yetkiler.toplanti = true;
            if (Convert.ToInt32(dataReader["ModulId"]) == 36 && Convert.ToBoolean(dataReader["Status"]) == true)
                yetkiler.cariFinansman = true;
            if (Convert.ToInt32(dataReader["ModulId"]) == 37 && Convert.ToBoolean(dataReader["Status"]) == true)
                yetkiler.isEmriOtmBaslatBitir = true;
            if (Convert.ToInt32(dataReader["ModulId"]) == 38 && Convert.ToBoolean(dataReader["Status"]) == true)
                yetkiler.personelDevamKayitSistemi = true;
        }
        ayarlar.cnn.Close();
        return yetkiler;
    }

    public class FirmaBilgileri
    {
        public string Title { get; set; }
        public string Logo { get; set; }
    }

    public FirmaBilgileri firmaBilgileri()
    {
        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select * from ucgem_firma_listesi where yetki_kodu = 'BOSS'";
        ayarlar.cmd.ExecuteNonQuery();

        FirmaBilgileri firma = new FirmaBilgileri();
        SqlDataReader dataReader = ayarlar.cmd.ExecuteReader();
        while (dataReader.Read())
        {
            if (dataReader["firma_kodu"].ToString() == "ESOTOMASYON")
                firma.Title = "ESFLW";
            else
                firma.Title = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(dataReader["firma_kodu"].ToString());

            firma.Logo = dataReader["firma_logo"].ToString();
        }
        ayarlar.cnn.Close();
        return firma;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void Unnamed_LoggingOut(object sender, LoginCancelEventArgs e)
    {
        Context.GetOwinContext().Authentication.SignOut();
    }
}