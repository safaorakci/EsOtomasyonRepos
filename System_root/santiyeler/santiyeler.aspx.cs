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

public partial class System_root_santiyeler_santiyeler : System.Web.UI.Page
{

    public XmlDocument doc = new XmlDocument();

    protected void Page_Load(object sender, EventArgs e)
    {
        doc.Load(Server.MapPath("/dil_cevirileri.xml"));


        ListItem litem = new ListItem();
        litem.Text = "Hızlı Proje Ara...";
        litem.Value = "0";
        litem.Selected = true;
        hizli_proje_arama.Items.Add(litem);

        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select ROW_NUMBER() OVER(ORDER BY durum.sirano ASC) as yeni_sira, durum.id, durum.durum_adi, (select count(proje.id) from ucgem_proje_listesi proje where santiye_durum_id = durum.id and proje.durum = 'true' and proje.cop = 'false' and proje.firma_id = durum.firma_id) as santiye_sayisi from tanimlama_santiye_durum_listesi durum where durum.firma_id = @firma_id and durum.durum = 'true' and durum.cop = 'false' order by convert(int, durum.sirano) asc; SELECT santiye_durum_id, proje.id AS idd, UPPER(proje_adi) AS proje_adi,proje_kodu, durum.durum_adi FROM ucgem_proje_listesi proje JOIN tanimlama_santiye_durum_listesi durum ON durum.id = proje.santiye_durum_id AND durum.durum = 'true' AND durum.cop = 'false' WHERE proje.firma_id = @firma_id and proje.durum = 'true' AND proje.cop = 'false' ORDER BY durum.durum_adi, convert(int, durum.sirano) ASC, proje.id DESC; ";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        santiyeler_repeater.DataSource = ds.Tables[0];
        //santiyeler_repeater.ItemCreated += Santiyeler_repeater_ItemCreated;
        santiyeler_repeater.DataBind();



        foreach (DataRow item in ds.Tables[1].Rows)
        {
            ListItem litem2 = new ListItem();
            litem2.Text = item["proje_adi"].ToString() + "-" + item["proje_kodu"].ToString();
            litem2.Value = item["idd"].ToString();
            litem2.Attributes.Add("santiye_durum_id", item["santiye_durum_id"].ToString());
            litem2.Attributes.Add("optiongroup", item["durum_adi"].ToString());
            hizli_proje_arama.Items.Add(litem2);
        }

    }

    private void Santiyeler_repeater_ItemCreated(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView drow = (DataRowView)e.Item.DataItem;

            string durum = drow["durum_adi"].ToString();

            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = " select santiye_durum_id as id, id as idd, UPPER(proje_adi) as proje_adi,( SELECT COUNT(id) FROM ucgem_is_listesi WHERE durum = 'true' AND cop = 'false' AND (ISNULL(tamamlanma_orani, 0) != 100) AND dbo.iceriyormu(departmanlar, 'proje-' + CONVERT(NVARCHAR(50), proje.id)) = 1 ) + ( SELECT COUNT(id) FROM ucgem_proje_olay_listesi olay WHERE olay.proje_id = proje.id AND olay.durum = 'true' AND olay.cop = 'false' ) AS gosterge_sayisi from ucgem_proje_listesi proje WHERE proje.santiye_durum_id = @santiye_durum_id and proje.durum = 'true' and proje.cop = 'false' order by proje.id desc";
            ayarlar.cmd.Parameters.Add("santiye_durum_id", drow["id"].ToString());
            SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);

            Repeater santiye_repeater = (Repeater)e.Item.FindControl("santiye_repeater");

            santiye_repeater.DataSource = ds.Tables[0];
            santiye_repeater.DataBind();

            foreach (DataRow item in ds.Tables[0].Rows)
            {
                ListItem litem = new ListItem();
                litem.Text = item["proje_adi"].ToString();
                litem.Value = item["idd"].ToString();
                litem.Attributes.Add("santiye_durum_id", drow["id"].ToString());
                litem.Attributes.Add("optiongroup", drow["durum_adi"].ToString());
                hizli_proje_arama.Items.Add(litem);
            }

            Panel kategori_yok = (Panel)e.Item.FindControl("kategori_yok");
            kategori_yok.Visible = false;
            if (ds.Tables[0].Rows.Count == 0)
            {
                kategori_yok.Visible = true;
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