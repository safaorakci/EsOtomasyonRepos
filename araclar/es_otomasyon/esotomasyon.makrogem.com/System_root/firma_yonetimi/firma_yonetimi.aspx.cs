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

public partial class System_root_firma_yonetimi_firma_yonetimi : System.Web.UI.Page
{

    public ayarlar ayarlar = new ayarlar();
    public Kullanici kullanici = SessionManager.CurrentUser;
    public XmlDocument doc = new XmlDocument();

    protected void Page_Load(object sender, EventArgs e)
    {
        doc.Load(Server.MapPath("/dil_cevirileri.xml"));

        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select id, personel_ad + ' ' + personel_soyad as personel_ad_soyad from ucgem_firma_kullanici_listesi where durum = 'true' and cop = 'false' and firma_id = @firma_id order by id asc";
        ayarlar.cmd.Parameters.Add("firma_id", kullanici.firma_id);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        firma_supervisor_id.DataSource = ds.Tables[0];
        firma_supervisor_id.DataTextField = "personel_ad_soyad";
        firma_supervisor_id.DataValueField = "id";
        firma_supervisor_id.DataBind();
        firma_supervisor_id.CssClass = "select2";
        firma_supervisor_id.Style.Add("width", "100%");

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