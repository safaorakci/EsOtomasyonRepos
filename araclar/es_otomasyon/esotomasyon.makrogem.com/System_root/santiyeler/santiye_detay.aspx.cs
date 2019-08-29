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

public partial class System_root_santiyeler_santiye_detay : System.Web.UI.Page
{

    public XmlDocument doc = new XmlDocument();
    
    protected void Page_Load(object sender, EventArgs e)
    {doc.Load(Server.MapPath("/dil_cevirileri.xml"));
        string id = Request.Form["id"].ToString();

        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select santiye_durum.durum_adi, firma.firma_adi, proje.* from ucgem_proje_listesi proje join tanimlama_santiye_durum_listesi santiye_durum on santiye_durum.id = proje.santiye_durum_id join ucgem_firma_listesi firma on firma.id = proje.proje_firma_id where proje.id = @proje_id;";
        ayarlar.cmd.Parameters.Add("proje_id", id);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        DataRow drow = ds.Tables[0].Rows[0];

        santiye_adi_label.Text = drow["proje_adi"].ToString();
        firma_adi_label.Text = drow["firma_adi"].ToString();

        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select ROW_NUMBER() OVER(ORDER BY departman.id ASC) AS rowid, 0 as santiye_sayi, departman.id, departman.departman_adi, departman.departman_tipi, departman.sirano, (select count(id) from ucgem_is_listesi where durum = 'true' and cop = 'false' and (isnull(tamamlanma_orani,0) != 100) and dbo.iceriyormu(departmanlar, 'departman-' + CONVERT(nvarchar(10), departman.id)) = 1 and dbo.iceriyormu(departmanlar, 'proje-' + @proje_id) = 1) as is_sayisi, (select count(id) from ucgem_proje_olay_listesi olay where olay.proje_id = @proje_id and olay.departman_id = departman.id and olay.durum = 'true' and olay.cop = 'false') as gosterge_sayisi, (select count(id) from ucgem_proje_olay_listesi olay where olay.proje_id = @proje_id and olay.durum = 'true' and olay.cop = 'false') as tum_sayi from tanimlama_departman_listesi departman left join ucgem_firma_kullanici_listesi kullanici on dbo.iceriyormu(kullanici.departmanlar, departman.id)=1 and kullanici.id = @kullanici_id where dbo.iceriyormu(@proje_departmanlari, departman.id)=1 and departman.firma_id = @firma_id and departman.durum = 'true' and departman.cop = 'false' and departman.departman_tipi = 'santiye' group by departman.id, departman.departman_adi,  departman.departman_tipi, departman.sirano order by departman.sirano asc";
        ayarlar.cmd.Parameters.Add("proje_departmanlari", drow["proje_departmanlari"].ToString());
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        ayarlar.cmd.Parameters.Add("kullanici_id", SessionManager.CurrentUser.kullanici_id);
        ayarlar.cmd.Parameters.Add("proje_id", id);
        SqlDataAdapter sda2 = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds2 = new DataSet();
        sda2.Fill(ds2);

        if (ds2.Tables[0].Rows.Count>0)
        {
            DataRow drow_santiye = ds2.Tables[0].Rows[0];
            santiye_genel_span.Text = drow_santiye["tum_sayi"].ToString();
        }

        int olcu = 100 / (Convert.ToInt32(ds2.Tables[0].Rows.Count) + 1);


        Response.Write("<style>.bootstrapWizard li {width:" + olcu + "%!important}</style>");

        santiye_durum_repater.DataSource = ds2.Tables[0];
        santiye_durum_repater.DataBind();

        santiye_tab_repeater.DataSource = ds2.Tables[0];
        santiye_tab_repeater.DataBind();

        FormDoldur();

        olay_cizelgesi_doldur();



        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "SELECT id, departman_adi FROM dbo.tanimlama_departman_listesi WHERE firma_id = @firma_id AND departman_tipi = 'santiye' AND durum = 'true' AND cop = 'false' ORDER BY sirano asc;";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda5 = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds5 = new DataSet();
        sda5.Fill(ds5);


        proje_departmanlari.CssClass = "select2";
        proje_departmanlari.Attributes.Add("multiple", "multiple");
        proje_departmanlari.SelectionMode = ListSelectionMode.Multiple;
        foreach (DataRow item in ds5.Tables[0].Rows)
        {
            ListItem litem = new ListItem();
            litem.Text = item["departman_adi"].ToString();
            litem.Value = item["id"].ToString();

            if ((" ," + drow["proje_departmanlari"].ToString() + ",").IndexOf("," + item["id"].ToString() + ",") > 0)
            {
                litem.Selected = true;
            }
            else
            {
                litem.Selected = false;
            }


            proje_departmanlari.Items.Add(litem);
        }


    }

    public void olay_cizelgesi_doldur()
    {

        string proje_id = Request.Form["id"].ToString();
        string departman_id = "0";
        string tab_id = "0";

        /*
        hproje_id.Value = proje_id;
        hdepartman_id.Value = departman_id;
        htab_id.Value = tab_id;*/

        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "SELECT datename(month, olay.olay_tarihi) + ' ' +  CONVERT(nvarchar(4), YEAR(olay.olay_tarihi)) as ay, olay.ekleyen_id, olay.id, DATEADD(WEEK, DATEPART(week, olay.olay_tarihi) - 1, CONVERT(date, '01.01.' + CONVERT(nvarchar(4), year(olay.olay_tarihi)))) hafta_baslangic, DATEADD(DAY, -1, DATEADD(WEEK, DATEPART(WEEK, olay.olay_tarihi), CONVERT(DATE, CONVERT(nvarchar(4), year(olay.olay_tarihi))))) hafta_bitis, olay.olay_tarihi, left(olay.olay_saati,5) as olay_saati, olay.olay, datename(dw, olay.olay_tarihi) as gun_adi, datepart(week, olay.olay_tarihi) as hafta, kullanici.personel_ad + ' ' + kullanici.personel_soyad as personel_ad_soyad, kullanici.personel_resim from ucgem_proje_olay_listesi olay join ucgem_firma_kullanici_listesi kullanici on kullanici.id = olay.ekleyen_id where proje_id = @proje_id order by CONVERT(datetime, olay.olay_tarihi) + CONVERT(datetime, olay.olay_saati) ASC";
        ayarlar.cmd.Parameters.Add("proje_id", proje_id);
        //ayarlar.cmd.Parameters.Add("departman_id", departman_id);
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

    private void FormDoldur()
    {
        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select * from ucgem_proje_listesi where id = @proje_id;";
        ayarlar.cmd.Parameters.Add("proje_id", Request.Form["id"].ToString());
        SqlDataAdapter sda_proje = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds_proje = new DataSet();
        sda_proje.Fill(ds_proje);

        DataRow proje = ds_proje.Tables[0].Rows[0];

        proje_adi.Text = proje["proje_adi"].ToString();
        enlem.Text = proje["enlem"].ToString();
        boylam.Text = proje["boylam"].ToString();



        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select id, personel_ad + ' ' + personel_soyad as personel_ad_soyad from ucgem_firma_kullanici_listesi where cop = 'false' and firma_id = @firma_id order by personel_ad + ' ' + personel_soyad asc";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        firma_supervisor_id.DataSource = ds.Tables[0];
        firma_supervisor_id.DataTextField = "personel_ad_soyad";
        firma_supervisor_id.DataValueField = "id";
        firma_supervisor_id.SelectedValue = proje["supervisor_id"].ToString();
        firma_supervisor_id.DataBind();
        firma_supervisor_id.CssClass = "select2";
        firma_supervisor_id.Style.Add("width", "100%");


        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select id, firma_adi from ucgem_firma_listesi where ekleyen_firma_id = @firma_id and durum = 'true' and cop = 'false' order by firma_adi asc;";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda2 = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds2 = new DataSet();
        sda2.Fill(ds2);


        firma_id.DataSource = ds2.Tables[0];
        firma_id.DataTextField = "firma_adi";
        firma_id.DataValueField = "id";
        firma_id.SelectedValue = proje["proje_firma_id"].ToString();
        firma_id.DataBind();
        firma_id.CssClass = "select2";
        firma_id.Style.Add("width", "100%");



        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select id, durum_adi from tanimlama_santiye_durum_listesi where firma_id = @firma_id and durum = 'true' and cop = 'false' order by sirano;";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda3 = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds3 = new DataSet();
        sda2.Fill(ds3);


        santiye_durum_id.DataSource = ds3.Tables[0];
        santiye_durum_id.DataTextField = "durum_adi";
        santiye_durum_id.DataValueField = "id";
        santiye_durum_id.SelectedValue = proje["santiye_durum_id"].ToString();
        santiye_durum_id.DataBind();
        santiye_durum_id.CssClass = "select2";
        santiye_durum_id.Style.Add("width", "100%");

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
        if (!kelimevarmi)
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