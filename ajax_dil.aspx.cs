using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ahtapot.App_Code.ayarlar;

public partial class ajax_dil : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string dil = Request.QueryString["dil"].ToString();
        HttpCookie userCookie = HttpContext.Current.Request.Cookies["kullanici"];
        userCookie["dil_secenek"] = HttpUtility.UrlEncode(dil);
        userCookie.Expires = DateTime.Now.AddDays(5);
        HttpContext.Current.Response.Cookies.Set(userCookie);

        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "update ucgem_firma_kullanici_listesi set dil = @dil where id = @id";
        ayarlar.cmd.Parameters.Add("dil", dil);
        ayarlar.cmd.Parameters.Add("id", SessionManager.CurrentUser.kullanici_id);
        ayarlar.cmd.ExecuteNonQuery();

        Response.Redirect("/default.aspx");
    }
}