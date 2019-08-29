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

public partial class System_root_santiyeler_santiye_detay_tab : System.Web.UI.Page
{

    public XmlDocument doc = new XmlDocument();
    
    protected void Page_Load(object sender, EventArgs e)
    {doc.Load(Server.MapPath("/dil_cevirileri.xml"));
        string proje_id = Request.Form["proje_id"].ToString();
        string departman_id = Request.Form["departman_id"].ToString();
        string tab_id = Request.Form["tab_id"].ToString();


        hproje_id.Value = proje_id;
        hdepartman_id.Value = departman_id;
        htab_id.Value = tab_id;

        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        //ayarlar.cmd.CommandText = "SELECT id, DATEADD(WEEK, DATEPART(week, olay_tarihi) - 1, CONVERT(date, '01.01.' + CONVERT(nvarchar(4), year(olay_tarihi)))) hafta_baslangic, DATEADD(DAY, -1, DATEADD(WEEK, DATEPART(WEEK, olay_tarihi), CONVERT(DATE, CONVERT(nvarchar(4), year(olay_tarihi))))) hafta_bitis, olay_tarihi, left(olay_saati,5) as olay_saati, olay, datename(dw, olay_tarihi) as gun_adi, datepart(week, olay_tarihi) as hafta from ucgem_proje_olay_listesi where proje_id = @proje_id and departman_id = @departman_id order by CONVERT(datetime, olay_tarihi) + CONVERT(datetime, olay_saati) ASC";
        ayarlar.cmd.CommandText = "SELECT datename(month, olay.olay_tarihi) + ' ' +  CONVERT(nvarchar(4), YEAR(olay.olay_tarihi)) as ay, olay.ekleyen_id, olay.id, DATEADD(WEEK, DATEPART(week, olay.olay_tarihi) - 1, CONVERT(date, '01.01.' + CONVERT(nvarchar(4), year(olay.olay_tarihi)))) hafta_baslangic, DATEADD(DAY, -1, DATEADD(WEEK, DATEPART(WEEK, olay.olay_tarihi), CONVERT(DATE, CONVERT(nvarchar(4), year(olay.olay_tarihi))))) hafta_bitis, olay.olay_tarihi, left(olay.olay_saati,5) as olay_saati, olay.olay, datename(dw, olay.olay_tarihi) as gun_adi, datepart(week, olay.olay_tarihi) as hafta, kullanici.personel_ad + ' ' + kullanici.personel_soyad as personel_ad_soyad, kullanici.personel_resim from ucgem_proje_olay_listesi olay join ucgem_firma_kullanici_listesi kullanici on kullanici.id = olay.ekleyen_id where proje_id = @proje_id and departman_id = @departman_id order by CONVERT(datetime, olay.olay_tarihi) + CONVERT(datetime, olay.olay_saati) ASC";
        ayarlar.cmd.Parameters.Add("proje_id", proje_id);
        ayarlar.cmd.Parameters.Add("departman_id", departman_id);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);


        olay_yok_panel.Visible = true;


        List<cizelge> cizelgeler = new List<cizelge>();
        string son_hafta = "";
        string son_gun = "";
        string durum = "";
        string son_ay = "";

        List<aylik_cizelge> aylik_cizelgeler = new List<aylik_cizelge>();
        aylik_cizelge aylik_cizelge = new aylik_cizelge();
        cizelge cizelge = new cizelge();
        List<gun> gunler = new List<gun>();
        gun gun = new gun();
        List<olay> olaylar = new List<olay>();
        olay olay = new olay();

        int x = 0;
        int haftasay = 1;
        int aysay = 0;

        foreach (DataRow drow in ds.Tables[0].Rows)
        {
            x++;
            olay_yok_panel.Visible = false;


            if (son_ay != drow["ay"].ToString())
            {
                son_ay = drow["ay"].ToString();
                son_hafta = "";
                son_gun = "";
                durum = "yeni_ay";
            }

            if (durum == "yeni_ay")
            {
                durum = "";
                haftasay = 0;
                aysay++;

                if (x > 1)
                {
                    if (olaylar.Count > 0)
                    {
                        gun.olaylar = olaylar;
                        gunler.Add(gun);
                    }

                    if (gunler.Count > 0)
                    {
                        cizelge.gunler = gunler;
                        cizelgeler.Add(cizelge);
                    }

                    if (cizelgeler.Count > 0)
                    {
                        aylik_cizelge.cizelgeler = cizelgeler;
                        aylik_cizelgeler.Add(aylik_cizelge);
                    }



                }

                aylik_cizelge = new aylik_cizelge();
                cizelgeler = new List<cizelge>();
                cizelge = new cizelge();
                gunler = new List<gun>();
                gun = new gun();
                olaylar = new List<olay>();

                aylik_cizelge.ay_baslik = drow["ay"].ToString() + " - " + aysay.ToString() + ". Ay";
                //cizelge.baslik = Convert.ToDateTime(drow["hafta_baslangic"]).ToShortDateString() + " - " + Convert.ToDateTime(drow["hafta_bitis"]).ToShortDateString() + " | " + aysay.ToString() + ". Ay - " + haftasay + ". Hafta";
            }



            if (son_hafta != drow["hafta"].ToString())
            {
                son_hafta = drow["hafta"].ToString();
                son_gun = "";
                durum = "yeni_hafta";

            }

            if (durum == "yeni_hafta")
            {
                durum = "";
                haftasay++;
                if (x > 1)
                {
                    //olaylar.Add(olay);
                    if (olaylar.Count > 0)
                    {
                        gun.olaylar = olaylar;
                        gunler.Add(gun);
                    }

                    if (gunler.Count > 0)
                    {
                        cizelge.gunler = gunler;
                        cizelgeler.Add(cizelge);
                    }

                    cizelge = new cizelge();
                    gunler = new List<gun>();
                    gun = new gun();
                    olaylar = new List<olay>();
                }
                cizelge.baslik = Convert.ToDateTime(drow["hafta_baslangic"]).ToShortDateString() + " - " + Convert.ToDateTime(drow["hafta_bitis"]).ToShortDateString() + " | " + drow["ay"].ToString() + " | " + aysay.ToString() + ". Ay - " + haftasay + ". Hafta";
            }



            if (son_gun != drow["gun_adi"].ToString())
            {
                son_gun = drow["gun_adi"].ToString();
                durum = "yeni_gun";
            }

            if (durum == "yeni_gun")
            {
                durum = "";
                if (x > 1)
                {
                    if (olaylar.Count > 0)
                    {
                        gun.olaylar = olaylar;
                        gunler.Add(gun);
                    }

                    gun = new gun();
                    olaylar = new List<olay>();
                }
            }


            gun.gun_adi = Convert.ToDateTime(drow["olay_tarihi"]).ToShortDateString() + " - " + drow["gun_adi"].ToString();
            gun.gun_renk = "primary";

            olay = new olay();
            olay.olay_id = drow["id"].ToString();
            olay.saat = drow["olay_saati"].ToString();
            olay.olaystr = drow["olay"].ToString();
            olay.proje_id = proje_id;
            olay.departman_id = departman_id;
            olay.tab_id = tab_id;
            olay.ekleyen = drow["personel_ad_soyad"].ToString();
            olay.resim = drow["personel_resim"].ToString();
            olay.ekleyen_id = Convert.ToInt32(drow["ekleyen_id"]).Equals(SessionManager.CurrentUser.kullanici_id) ? 0 : 1;
            olaylar.Add(olay);


        }

        if (x > 0)
        {
            if (olaylar.Count > 0)
            {
                gun.olaylar = olaylar;
                gunler.Add(gun);
            }
            if (gunler.Count > 0)
            {
                cizelge.gunler = gunler;
                cizelgeler.Add(cizelge);
            }

            if (cizelgeler.Count > 0)
            {
                aylik_cizelge.cizelgeler = cizelgeler;
                aylik_cizelgeler.Add(aylik_cizelge);
            }

        }

        ay_repeater.DataSource = aylik_cizelgeler;
        ay_repeater.ItemCreated += Ay_repeater_ItemCreated;
        ay_repeater.DataBind();

    }

    private void Ay_repeater_ItemCreated(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            aylik_cizelge cizelge = (aylik_cizelge)e.Item.DataItem;

            Repeater hafta_repeater = (Repeater)e.Item.FindControl("hafta_repeater");

            List<cizelge> cizelgeler = cizelge.cizelgeler;

            hafta_repeater.DataSource = cizelgeler;
            hafta_repeater.ItemCreated += Hafta_repeater_ItemCreated;
            hafta_repeater.DataBind();

        }
    }

    private void Hafta_repeater_ItemCreated(object sender, RepeaterItemEventArgs e)
    {

        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            cizelge cizelge = (cizelge)e.Item.DataItem;

            Repeater gun_repeater = (Repeater)e.Item.FindControl("gun_repeater");
            gun_repeater.DataSource = cizelge.gunler;
            gun_repeater.ItemCreated += Gun_repeater_ItemCreated;
            gun_repeater.DataBind();

        }
    }

    private void Gun_repeater_ItemCreated(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            gun gun = (gun)e.Item.DataItem;

            Repeater olay_repeater = (Repeater)e.Item.FindControl("olay_repeater");
            olay_repeater.DataSource = gun.olaylar;
            olay_repeater.DataBind();
        }
    }

    public class aylik_cizelge
    {
        public string ay_baslik { get; set; }
        public List<cizelge> cizelgeler { get; set; }

    }

    public class cizelge
    {

        public string baslik { get; set; }

        public List<gun> gunler { get; set; }




    }

    public class gun
    {
        public string gun_adi { get; set; }
        public string gun_renk { get; set; }

        public List<olay> olaylar { get; set; }

    }

    public class olay
    {
        public string olay_id { get; set; }
        public string saat { get; set; }
        public string olaystr { get; set; }

        public string proje_id { get; set; }
        public string departman_id { get; set; }
        public string tab_id { get; set; }
        public string resim { get; set; }
        public string ekleyen { get; set; }
        public int ekleyen_id { get; set; }
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