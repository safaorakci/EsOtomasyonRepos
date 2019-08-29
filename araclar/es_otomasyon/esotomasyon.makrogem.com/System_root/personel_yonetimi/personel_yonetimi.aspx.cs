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

public partial class System_root_personel_yonetimi_personel_yonetimi : System.Web.UI.Page
{
    public ayarlar ayarlar = new ayarlar();
    public Kullanici kullanici = SessionManager.CurrentUser;

    public XmlDocument doc = new XmlDocument();


    protected void Page_Load(object sender, EventArgs e)
    {
        doc.Load(Server.MapPath("/dil_cevirileri.xml"));
        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select id, departman_adi from tanimlama_departman_listesi where durum = 'true' and cop = 'false' and firma_id = @firma_id order by departman_adi asc";
        ayarlar.cmd.Parameters.Add("firma_id", kullanici.firma_id.ToString());
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        departmanlar.DataSource = ds.Tables[0];
        departmanlar.DataTextField = "departman_adi";
        departmanlar.DataValueField = "id";
        departmanlar.DataBind();
        departmanlar.CssClass = "select2";
        departmanlar.Style.Add("width", "100%");
        departmanlar.CssClass = "select2";
        departmanlar.Attributes.Add("multiple", "multiple");

        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select id, gorev_adi from tanimlama_gorev_listesi where durum = 'true' and cop = 'false' and firma_id = @firma_id;";
        ayarlar.cmd.Parameters.Add("firma_id", kullanici.firma_id);
        SqlDataAdapter sda2 = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds2 = new DataSet();
        sda2.Fill(ds2);

        gorevler.DataSource = ds2.Tables[0];
        gorevler.DataTextField = "gorev_adi";
        gorevler.DataValueField = "id";
        gorevler.DataBind();
        gorevler.CssClass = "select2";
        gorevler.Style.Add("width", "100%");

        ayarlar.cnn.Close();
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