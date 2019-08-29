using Ahtapot.App_Code.ayarlar;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

public partial class System_root_tanimlamalar_departman_ans : System.Web.UI.Page
{

    public XmlDocument doc = new XmlDocument();

    protected void Page_Load(object sender, EventArgs e)
    {
        doc.Load(Server.MapPath("/dil_cevirileri.xml"));
        if (SessionManager.CurrentUser == null)
        {
            Response.Redirect("/login.aspx");
            Response.End();
        }

        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select id, departman_adi from tanimlama_departman_listesi where firma_id = @firma_id and departman_tipi = 'santiye' and durum = 'true' and cop = 'false' order by sirano asc";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);



        ust_id.DataSource = ds.Tables[0];
        ust_id.DataValueField = "id";
        ust_id.DataTextField = "departman_adi";
        ust_id.DataBind();

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
        if (!kelimevarmi && 1 == 2)
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "EXEC dbo.dilayikla @kelimeler =  @kelimeler , @cikisdili = 'ingilizce';";
            ayarlar.cmd.Parameters.Add("kelimeler", kelime);
            ayarlar.cmd.ExecuteNonQuery();
        }

        return kelime;
    }
}