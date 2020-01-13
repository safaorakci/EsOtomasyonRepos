using Ahtapot.App_Code.ayarlar;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using static pushover;

public partial class System_root_ajax_islem1 : System.Web.UI.Page
{
    private string islem
    {
        get
        {
            string _islem = "";
            try
            {
                _islem = Request.Form["islem"].ToString();
            }
            catch (Exception)
            {
                _islem = "";
            }

            return _islem;
        }
    }

    public XmlDocument doc = new XmlDocument();

    public string Start_date = "";
    public string End_date = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        doc.Load(Server.MapPath("/dil_cevirileri.xml"));

        if (SessionManager.CurrentUser == null)
        {
            Response.Write("<script> window.location.href = '/Login.aspx'; </script>");
            //Response.Redirect("/login.aspx");
            Response.End();
        }

        departmanlar_panel.Visible = false;
        departman_duzenle_panel.Visible = false;
        yeni_olay_ekle_panel.Visible = false;
        yeni_olay_duzenle_panel.Visible = false;
        gorevler_panel.Visible = false;
        santiye_durum_panel.Visible = false;
        gorev_duzenle_panel.Visible = false;
        santiye_durum_duzenle_panel.Visible = false;
        personeller_panel.Visible = false;
        firmalar_panel.Visible = false;
        projeler_panel.Visible = false;
        yeni_is_ekle_panel.Visible = false;
        is_ara_panel.Visible = false;
        is_kaydini_duzenle_panel.Visible = false;
        is_listesi_panel.Visible = false;
        is_detay_panel.Visible = false;
        departman_gosterge_panel.Visible = false;
        is_yazisma_panel.Visible = false;
        kurlar_panel.Visible = false;
        dosya_listesi_panel.Visible = false;
        tablo_customize_panel.Visible = false;
        yeni_santiye_ekle_panel.Visible = false;
        modal_yonetici_ekle_panel.Visible = false;

        switch (islem)
        {
            case "departmanlar":
                departmanlar_panel.Visible = true;
                departmanlar();
                break;
            case "departman_duzenle":
                departman_duzenle_panel.Visible = true;
                departman_duzenle();
                break;
            case "yeni_olay_ekle":
                yeni_olay_ekle_panel.Visible = true;
                yeni_olay_ekle();
                break;
            case "yeni_olay_duzenle":
                yeni_olay_duzenle_panel.Visible = true;
                yeni_olay_duzenle();
                break;
            case "gorevler":
                gorevler_panel.Visible = true;
                gorevler();
                break;
            case "santiye_durum":
                santiye_durum_panel.Visible = true;
                santiye_durum();
                break;
            case "gorev_duzenle":
                gorev_duzenle_panel.Visible = true;
                gorev_duzenle();
                break;
            case "santiye_durum_duzenle":
                santiye_durum_duzenle_panel.Visible = true;
                santiye_durum_duzenle();
                break;
            case "personeller":
                personeller_panel.Visible = true;
                personeller();
                break;
            case "firmalar":
                firmalar_panel.Visible = true;
                firmalar();
                break;
            case "projeler":
                projeler_panel.Visible = true;
                projeler();
                break;
            case "yeni_is_ekle":
                yeni_is_ekle_panel.Visible = true;
                yeni_is_ekle();
                break;
            case "personel_izin_kontrol":
                yeni_is_ekle_panel.Visible = true;
                //personel_izin_kontrol();
                break;
            case "is_aramasi_yap":
                is_ara_panel.Visible = true;
                is_aramasi_yap();
                break;
            case "is_listesi":
                is_listesi_panel.Visible = true;
                is_listesi();
                break;
            case "is_detay_goster":
                is_detay_panel.Visible = true;
                is_detay_goster();
                break;
            case "departman_degistim_sayac_getir":
                departman_gosterge_panel.Visible = true;
                departman_gosterge_getir();
                break;
            case "is_yazisma_yeni_gonder":
                is_yazisma_panel.Visible = true;
                is_yazisma_yeni_gonder();
                break;
            case "is_kaydini_duzenle":
                is_kaydini_duzenle_panel.Visible = true;
                is_kaydini_duzenle();
                break;
            case "kurlari_getir":
                kurlar_panel.Visible = true;
                kurlari_getir();
                break;
            case "tablo_customize":
                tablo_customize_panel.Visible = true;
                tablo_customize_getir();
                break;
            case "yeni_santiye_ekle":
                yeni_santiye_ekle_panel.Visible = true;
                yeni_santiye_ekle_getir();
                break;
            case "dosya_listesi_getir":
                dosya_listesi_panel.Visible = true;
                dosya_listesi_getir();
                break;
            case "musteribilgilerial":
                //musteribilgilerial();
                break;

            case "ModalYetkiliEkle":
                modal_yonetici_ekle_panel.Visible = true;
                break;
        }
    }



    public void yeni_santiye_ekle_getir()
    {
        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select id, personel_ad + ' ' + personel_soyad as personel_ad_soyad from ucgem_firma_kullanici_listesi where durum = 'true' and cop = 'false' and firma_id = @firma_id order by personel_ad + ' ' + personel_soyad asc";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        firma_supervisor_id.DataSource = ds.Tables[0];
        firma_supervisor_id.DataTextField = "personel_ad_soyad";
        firma_supervisor_id.DataValueField = "id";
        firma_supervisor_id.SelectedValue = SessionManager.CurrentUser.kullanici_id.ToString();
        firma_supervisor_id.DataBind();
        firma_supervisor_id.CssClass = "select2";
        firma_supervisor_id.Style.Add("width", "100%");



        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "SELECT id, sablon_adi FROM uretim_sablonlari WHERE firma_id = @firma_id AND cop = 'false';";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda9 = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds9 = new DataSet();
        sda9.Fill(ds9);

        uretim_sablon_id.DataSource = ds9.Tables[0];
        uretim_sablon_id.DataTextField = "sablon_adi";
        uretim_sablon_id.DataValueField = "id";
        uretim_sablon_id.DataBind();
        uretim_sablon_id.CssClass = "select2";
        uretim_sablon_id.Style.Add("width", "100%");

        uretim_sablon_id.Items.Add(new ListItem() { Text = "Şablon Yok", Value = "0", Selected = true });


        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "SELECT id, dbo.IlkHarfBuyutme(firma.firma_adi) as firma_adi from ucgem_firma_listesi firma where firma.ekleyen_firma_id = @firma_id and firma.durum = 'true' and firma.cop = 'false' order by firma.firma_adi asc";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda2 = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds2 = new DataSet();
        sda2.Fill(ds2);


        firma_id.DataSource = ds2.Tables[0];
        firma_id.DataTextField = "firma_adi";
        firma_id.DataValueField = "id";
        firma_id.DataBind();
        firma_id.CssClass = "select2";
        firma_id.Style.Add("width", "100%");


        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select id, durum_adi from tanimlama_santiye_durum_listesi where firma_id = @firma_id and durum = 'true' and cop = 'false' order by sirano asc;";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda3 = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds3 = new DataSet();
        sda2.Fill(ds3);


        santiye_durum_id.DataSource = ds3.Tables[0];
        santiye_durum_id.DataTextField = "durum_adi";
        santiye_durum_id.DataValueField = "id";
        santiye_durum_id.DataBind();
        santiye_durum_id.CssClass = "select2";
        santiye_durum_id.Style.Add("width", "100%");



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
            litem.Selected = true;

            proje_departmanlari.Items.Add(litem);
        }


        ayarlar.cnn.Close();


    }
    public void tablo_customize_getir()
    {

        string is_tablo_gorunum = UIHelper.trn(Request.Form["is_tablo_gorunum"]);
        is_tablo_gorunum = is_tablo_gorunum.Replace("[\"", "");
        is_tablo_gorunum = is_tablo_gorunum.Replace("\"]", "");
        is_tablo_gorunum = is_tablo_gorunum.Replace("\"", " ");

        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "update ucgem_firma_kullanici_listesi set is_tablo_gorunum = @is_tablo_gorunum where id = @kullanici_id;";
        ayarlar.cmd.Parameters.Add("is_tablo_gorunum", is_tablo_gorunum);
        ayarlar.cmd.Parameters.Add("kullanici_id", SessionManager.CurrentUser.kullanici_id);
        ayarlar.cmd.ExecuteNonQuery();

        string style_class = tablo_style_cek();

        Response.Write("<div id='yeni_style_yeri'><style> .tablo_gorevliler , .tablo_etiketler , .tablo_baslangic , .tablo_bitis , .tablo_tamamlanma , .tablo_guncelleme , .tablo_ekleyen , .tablo_durum , .tablo_oncelik{ display:none; } " + style_class + "{ display:table-cell!important; } </style><div class='clear'></div></div>");

        ayarlar.cnn.Close();
    }

    public void dosya_listesi_getir()
    {

        int IsID = Convert.ToInt32(Request.Form["IsID"]);

        string islem2 = "";
        try
        {
            islem2 = Request.Form["islem2"].ToString();
        }
        catch (Exception)
        {

        }

        if (islem2 == "ekle")
        {

            string dosya_yolu = Request.Form["dosya_yolu"].ToString();
            string dosya_adi = Request.Form["dosya_adi"].ToString();

            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "insert into ucgem_is_dosya_listesi(is_id, dosya_adi, dosya_yolu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values(@is_id, @dosya_adi, @dosya_yolu, @durum, @cop, @firma_kodu, @firma_id, @ekleyen_id, @ekleyen_ip, getdate(), getdate());";
            ayarlar.cmd.Parameters.Add("is_id", IsID);
            ayarlar.cmd.Parameters.Add("dosya_adi", dosya_adi);
            ayarlar.cmd.Parameters.Add("dosya_yolu", dosya_yolu);
            ayarlar.cmd.Parameters.Add("durum", "true");
            ayarlar.cmd.Parameters.Add("cop", "false");
            ayarlar.cmd.Parameters.Add("firma_kodu", SessionManager.CurrentUser.firma_kodu);
            ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
            ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.kullanici_id);
            ayarlar.cmd.Parameters.Add("ekleyen_ip", HttpContext.Current.Request.ServerVariables["Remote_Addr"]);
            ayarlar.cmd.ExecuteNonQuery();


            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "update ucgem_is_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen = @guncelleyen where id = @IsID;";
            ayarlar.cmd.Parameters.Add("guncelleyen", SessionManager.CurrentUser.kullanici_adsoyad);
            ayarlar.cmd.Parameters.Add("IsID", IsID);
            ayarlar.cmd.ExecuteNonQuery();
            ayarlar.cnn.Close();

        }
        else if (islem2 == "sil")
        {
            string dosya_id = Request.Form["dosya_id"].ToString();

            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "delete from ucgem_is_dosya_listesi where is_id = @is_id and id = @dosya_id;";
            ayarlar.cmd.Parameters.Add("is_id", IsID);
            ayarlar.cmd.Parameters.Add("dosya_id", dosya_id);
            ayarlar.cmd.ExecuteNonQuery();

            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "update ucgem_is_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen = @guncelleyen where id = @IsID;";
            ayarlar.cmd.Parameters.Add("guncelleyen", SessionManager.CurrentUser.kullanici_adsoyad);
            ayarlar.cmd.Parameters.Add("IsID", IsID);
            ayarlar.cmd.ExecuteNonQuery();
            ayarlar.cnn.Close();

        }

        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select dosya.is_id, kullanici.personel_ad + ' ' + kullanici.personel_soyad as personel_adsoyad, dosya.id, dosya.dosya_adi, CONVERT(date, dosya.ekleme_tarihi, 104) as ekleme_tarihi, left(dosya.ekleme_saati,5) as ekleme_saati from ucgem_is_dosya_listesi dosya join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = dosya.ekleyen_id  where dosya.is_id = @is_id;";
        ayarlar.cmd.Parameters.Add("is_id", IsID);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        dosya_yok_panel.Visible = false;
        dosya_var_panel.Visible = false;

        if (ds.Tables[0].Rows.Count == 0)
        {
            dosya_yok_panel.Visible = true;
        }
        else
        {
            dosya_var_panel.Visible = true;
        }


        dosya_repeater.DataSource = ds.Tables[0];
        dosya_repeater.DataBind();

        ayarlar.cnn.Close();

    }

    public void kurlari_getir()
    {


        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select top 1 USD_SATIS, EUR_SATIS from DOVIZKURLARI order by KURID desc;";
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        DataRow drow = ds.Tables[0].Rows[0];

        dolar_gelen.Value = drow["USD_SATIS"].ToString();
        euro_gelen.Value = drow["EUR_SATIS"].ToString();

        ayarlar.cnn.Close();
    }

    public void is_kaydini_duzenle()
    {

        int IsID = Convert.ToInt32(Request.Form["IsID"]);


        DataRow iss = IsiGetir(IsID);

        dyeni_is_adi.Text = iss["adi"].ToString();
        dyeni_is_adi.TextMode = TextBoxMode.MultiLine;
        renk.Text = iss["renk"].ToString().Equals("") ? "rgb(52, 152, 219)" : iss["renk"].ToString();

        ListItem l1 = new ListItem();
        l1.Text = "Rutin";
        l1.Value = "Rutin";
        if (iss["is_tipi"].ToString() == "Rutin" || iss["is_tipi"].ToString() == "")
        {
            l1.Selected = true;
        }

        ListItem l2 = new ListItem();
        l2.Text = "Servis";
        l2.Value = "Servis";
        if (iss["is_tipi"].ToString() == "Servis")
        {
            l2.Selected = true;
        }


        dis_tipi.Items.Add(l1);
        dis_tipi.Items.Add(l2);
        dis_tipi.DataBind();

        DateTime basTarih = Convert.ToDateTime(iss["baslangic_tarihi"]);
        DateTime bitTarih = Convert.ToDateTime(iss["bitis_tarihi"]);

        string basday = Convert.ToDateTime(iss["baslangic_tarihi"]).Day.ToString();
        string basmonth = Convert.ToDateTime(iss["baslangic_tarihi"]).Month.ToString();
        string bitday = Convert.ToDateTime(iss["bitis_tarihi"]).Day.ToString();
        string bitmonth = Convert.ToDateTime(iss["bitis_tarihi"]).Month.ToString();
        if (Convert.ToDateTime(iss["baslangic_tarihi"]).Day < 10)
        {
            basday = "0" + Convert.ToDateTime(iss["baslangic_tarihi"]).Day.ToString();
        }
        if (Convert.ToDateTime(iss["baslangic_tarihi"]).Month < 10)
        {
            basmonth = "0" + Convert.ToDateTime(iss["baslangic_tarihi"]).Month.ToString();
        }
        if (Convert.ToDateTime(iss["bitis_tarihi"]).Day < 10)
        {
            bitday = "0" + Convert.ToDateTime(iss["bitis_tarihi"]).Day.ToString();
        }
        if (Convert.ToDateTime(iss["bitis_tarihi"]).Month < 10)
        {
            bitmonth = "0" + Convert.ToDateTime(iss["bitis_tarihi"]).Month.ToString();
        }

        dyeni_is_aciklama.Text = iss["aciklama"].ToString();
        dyeni_is_baslangic_tarihi.Text = basday + "-" + basmonth + "-" + Convert.ToDateTime(iss["baslangic_tarihi"]).Year;
        dyeni_is_baslangic_saati.Text = iss["baslangic_saati"].ToString().Trim().Substring(0, 5);
        dyeni_is_bitis_tarihi.Text = bitday + "-" + bitmonth + "-" + Convert.ToDateTime(iss["bitis_tarihi"]).Year;
        dyeni_is_bitis_saati.Text = iss["bitis_saati"].ToString().Trim().Substring(0, 5);

        dgun_gosterim.Text = ((Convert.ToDateTime(iss["bitis_tarihi"]) - Convert.ToDateTime(iss["baslangic_tarihi"])).TotalDays + 1).ToString();
        dyeni_is_toplam_calisma.Text = iss["toplam_sure"].ToString();
        dyeni_is_gunluk_ortalama_calisma.Text = iss["gunluk_sure"].ToString();


        /*
        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select * from (select id, departman_adi as adi, 'departman' as tip, 'Departmanlar' as grup from tanimlama_departman_listesi where firma_id = @firma_id and durum = 'true' and cop = 'false' UNION select id, firma_adi, 'firma', 'Firmalar' from ucgem_firma_listesi where ekleyen_firma_id = @firma_id and durum = 'true' and cop = 'false' UNION select id, proje_adi, 'proje', 'Projeler' from ucgem_proje_listesi where firma_id = @firma_id and durum = 'true' and cop = 'false') etiketler order by adi asc";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda2 = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds2 = new DataSet();
        sda2.Fill(ds2);

        foreach (DataRow item in ds2.Tables[0].Rows)
        {
            ListItem items = new ListItem();
            items.Text = item["adi"].ToString();
            items.Value = item["tip"].ToString() + "-" + item["id"].ToString();
            items.Attributes.Add("tip", item["tip"].ToString());
            items.Attributes.Add("optiongroup", item["grup"].ToString());
            yeni_is_etiketler.Items.Add(items);
        }

        yeni_is_etiketler.DataBind();
        yeni_is_etiketler.CssClass = "select2";
        yeni_is_etiketler.Attributes.Add("multiple", "multiple");

        */


        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select id, personel_ad + ' ' + personel_soyad as personel_ad_soyad from ucgem_firma_kullanici_listesi where firma_id = @firma_id and durum = 'true' and cop = 'false';";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);


        dyeni_is_ekle_button.Text = LNG("İş Kaydını Güncelle");

        dyeni_is_gorevliler.CssClass = "select2";
        dyeni_is_gorevliler.SelectionMode = ListSelectionMode.Multiple;

        foreach (DataRow item in ds.Tables[0].Rows)
        {
            ListItem litem = new ListItem();
            litem.Text = item["personel_ad_soyad"].ToString();
            litem.Value = item["id"].ToString();
            if (("asd," + iss["gorevliler"].ToString() + ",asd").IndexOf("," + item["id"] + ",") > 0)
            {
                litem.Selected = true;
                gorevlilerId.Value = iss["gorevliler"].ToString();
            }
            else
            {
                litem.Selected = false;
            }

            dyeni_is_gorevliler.Items.Add(litem);
        }


        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select case when (SELECT COUNT(value) FROM STRING_SPLIT(@etiketler, ',') WHERE value = etiket.sorgu ) > 0 then 'true' else 'false' end as varmi, (select proje_kodu from ucgem_proje_listesi where id = SUBSTRING(etiket.sorgu, CHARINDEX('-', etiket.sorgu) + 1, 10)) as proje_kodu, * from etiketler etiket where etiket.firma_id = @firma_id";


        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        ayarlar.cmd.Parameters.Add("etiketler", iss["departmanlar"].ToString());
        SqlDataAdapter sda2 = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds2 = new DataSet();
        sda2.Fill(ds2);

        if (iss["ajanda_gosterim"].ToString() == "True")
        {
            is_ajandada_goster2.Checked = true;
            is_ajandada_goster2.InputAttributes.Add("checkeds", "checkeds");
        }
        else
        {
            is_ajandada_goster2.Checked = false;
        }

        is_ajandada_goster2.InputAttributes.Add("class", "js-switch");


        if (iss["sinirlama_varmi"].ToString() == "1")
        {
            dsinirlama_varmi.Checked = true;
            dsinirlama_varmi.InputAttributes.Add("checkeds", "checkeds");
        }
        else
        {
            dsinirlama_varmi.Checked = false;

            Response.Write("<script> $(function (){ $('.dortlu').attr('class', 'col-sm-6 dortlu');$('.uclu').attr('class', 'col-sm-6 uclu');$('.takvimyap_yeni').css('max-width', '');$('.timepicker').css('max-width', '');$('.sinirlama_yeri').hide();$('#sinirlama_varmi').removeAttr('checkeds'); })</script>");

        }
        dsinirlama_varmi.InputAttributes.Add("class", "js-switch");


        dyeni_is_departmanlar.CssClass = "select2";
        dyeni_is_departmanlar.Attributes.Add("multiple", "multiple");
        dyeni_is_departmanlar.SelectionMode = ListSelectionMode.Multiple;
        foreach (DataRow item in ds2.Tables[0].Rows)
        {
            ListItem litem = new ListItem();
            if (item["tip"].ToString() == "proje")
                litem.Text = item["adi"].ToString() + " - " + item["proje_kodu"].ToString();
            else
                litem.Text = item["adi"].ToString();
            litem.Value = item["tip"].ToString() + "-" + item["id"].ToString();
            litem.Attributes.Add("tip", item["tip"].ToString());
            litem.Attributes.Add("optiongroup", item["grup"].ToString());
            if (item["varmi"].ToString() == "true")
            {
                litem.Selected = true;
            }
            else
            {
                litem.Selected = false;
            }

            dyeni_is_departmanlar.Items.Add(litem);
        }


        dyeni_is_oncelik.Items.Add("Düşük");
        dyeni_is_oncelik.Items.Add("Normal");
        dyeni_is_oncelik.Items.Add("Yüksek");



        dyeni_is_oncelik.SelectedValue = iss["oncelik"].ToString();


        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select id, adi from ucgem_bildirim_cesitleri";
        SqlDataAdapter sda_bildirim = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds_bildirim = new DataSet();
        sda_bildirim.Fill(ds_bildirim);


        dyeni_is_kontrol_bildirim.CssClass = "select2";
        dyeni_is_kontrol_bildirim.Attributes.Add("multiple", "multiple");
        dyeni_is_kontrol_bildirim.SelectionMode = ListSelectionMode.Multiple;
        foreach (DataRow item in ds_bildirim.Tables[0].Rows)
        {
            ListItem litem = new ListItem();
            litem.Text = item["adi"].ToString();
            litem.Value = item["id"].ToString();
            if (("asd," + iss["kontrol_bildirim"].ToString() + ",asd").IndexOf("," + item["id"] + ",") > 0)
            {
                litem.Selected = true;
            }
            else
            {
                litem.Selected = false;
            }

            dyeni_is_kontrol_bildirim.Items.Add(litem);
        }

        dyeni_is_ekle_button.UseSubmitBehavior = false;
        dyeni_is_ekle_button.OnClientClick = "is_kaydini_guncelle('" + IsID + "', this); return false;";

        ayarlar.cnn.Close();
    }

    public string metin_kisaltma(string metin)
    {
        if (metin.Length > 100)
        {
            metin.ToString().Substring(0, 100);
        }
        return metin;
    }
    public void is_yazisma_yeni_gonder()
    {

        int IsID = Convert.ToInt32(Request.Form["IsID"]);
        string islem2 = "";
        try
        {
            islem2 = Request.Form["islem2"].ToString();
        }
        catch (Exception)
        {

        }

        if (islem2 == "yeni")
        {
            string chat_yazi = UIHelper.trn(Request.Form["chat_yazi"]);


            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "update ucgem_is_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen = @guncelleyen where id = @IsID;";
            ayarlar.cmd.Parameters.Add("guncelleyen", SessionManager.CurrentUser.kullanici_adsoyad);
            ayarlar.cmd.Parameters.Add("IsID", IsID);
            ayarlar.cmd.ExecuteNonQuery();



            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "insert into ucgem_is_yazismalari(IsID, metin, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values(@IsID, @metin, @durum, @cop, @firma_kodu, @firma_id, @ekleyen_id, @ekleyen_ip, getdate(), getdate());";
            ayarlar.cmd.Parameters.Add("IsID", IsID);
            ayarlar.cmd.Parameters.Add("metin", chat_yazi);
            ayarlar.cmd.Parameters.Add("durum", "true");
            ayarlar.cmd.Parameters.Add("cop", "false");
            ayarlar.cmd.Parameters.Add("firma_kodu", SessionManager.CurrentUser.firma_kodu);
            ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
            ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.kullanici_id);
            ayarlar.cmd.Parameters.Add("ekleyen_ip", HttpContext.Current.Request.ServerVariables["Remote_Addr"]);
            ayarlar.cmd.ExecuteNonQuery();
            DataRow iss = IsiGetir(IsID);

            if (Convert.ToInt32(iss["ekleyen_id"]) != SessionManager.CurrentUser.kullanici_id)
            {


                string yeni_adi = metin_kisaltma(iss["adi"].ToString());


                DataRow Personel = PersonelBilgileriGetir(iss["ekleyen_id"].ToString());

                //string donen = ayarlar.DakikSMSMesajGonder(Personel["personel_telefon"].ToString(), SessionManager.CurrentUser.kullanici_adsoyad + " '" + iss["adi"] + "' adlı iş için mesaj gönderdi :" + chat_yazi);



                ayarlar.baglan();
                ayarlar.cmd.Parameters.Clear();
                ayarlar.cmd.CommandText = "insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values(@bildirim, @tip, @click, @user_id, @okudumu, @durum, @cop, @firma_kodu, @firma_id, @ekleyen_id, @ekleyen_ip, getdate(), getdate()); SET NOCOUNT ON;";
                ayarlar.cmd.Parameters.Add("bildirim", SessionManager.CurrentUser.kullanici_adsoyad + " " + yeni_adi + "... adlı iş için mesaj gönderdi :" + chat_yazi);
                ayarlar.cmd.Parameters.Add("tip", "is_listesi");
                ayarlar.cmd.Parameters.Add("click", "sayfagetir('/is_listesi/','jsid=4559&bildirim=true&bildirim_id=" + iss["id"] + "');");
                ayarlar.cmd.Parameters.Add("user_id", iss["ekleyen_id"].ToString());
                ayarlar.cmd.Parameters.Add("okudumu", "False");
                ayarlar.cmd.Parameters.Add("durum", "true");
                ayarlar.cmd.Parameters.Add("cop", "false");
                ayarlar.cmd.Parameters.Add("firma_kodu", SessionManager.CurrentUser.firma_kodu);
                ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
                ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.ekleyen_id);
                ayarlar.cmd.Parameters.Add("ekleyen_ip", HttpContext.Current.Request.ServerVariables["Remote_Addr"]);
                ayarlar.cmd.ExecuteNonQuery();

                if (Personel["personel_telefon"].ToString().Length > 5)
                {
                    ayarlar.NetGSM_SMS(Personel["personel_telefon"].ToString(), SessionManager.CurrentUser.kullanici_adsoyad + " '" + yeni_adi + "...' adlı iş için mesaj gönderdi :" + chat_yazi);
                }


                if (Personel["PushUserKey"].ToString().Length > 10)
                {
                    Exception except;

                    bool result = Pushover.SendNotification(ayarlar.PushOverAppKey, Personel["PushUserKey"].ToString(), "ÜÇGEM MEKANİK A.Ş ERP SYSTEM", SessionManager.CurrentUser.kullanici_adsoyad + " '" + yeni_adi + "...' adlı iş için mesaj gönderdi :" + chat_yazi, Priority.Normal, PushoverSound.DeviceDefault, String.Empty, "http://erp.ucgem.com", "http://erp.ucgem.com", 60, 3600, out except);
                }

                foreach (string gorevli in iss["gorevliler"].ToString().Split(','))
                {
                    if (iss["ekleyen_id"].ToString() != gorevli && SessionManager.CurrentUser.kullanici_id.ToString() != gorevli)
                    {

                        Personel = PersonelBilgileriGetir(gorevli.ToString());

                        //string donen = ayarlar.DakikSMSMesajGonder(Personel["personel_telefon"].ToString(), SessionManager.CurrentUser.kullanici_adsoyad + " '" + iss["adi"] + "' adlı iş için mesaj gönderdi :" + chat_yazi);



                        ayarlar.baglan();
                        ayarlar.cmd.Parameters.Clear();
                        ayarlar.cmd.CommandText = "insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values(@bildirim, @tip, @click, @user_id, @okudumu, @durum, @cop, @firma_kodu, @firma_id, @ekleyen_id, @ekleyen_ip, getdate(), getdate()); SET NOCOUNT ON;";
                        ayarlar.cmd.Parameters.Add("bildirim", SessionManager.CurrentUser.kullanici_adsoyad + " '" + yeni_adi + "...' adlı iş için mesaj gönderdi :" + chat_yazi);
                        ayarlar.cmd.Parameters.Add("tip", "is_listesi");
                        ayarlar.cmd.Parameters.Add("click", "sayfagetir('/is_listesi/','jsid=4559&bildirim=true&bildirim_id=" + iss["id"] + "');");
                        ayarlar.cmd.Parameters.Add("user_id", gorevli.ToString());
                        ayarlar.cmd.Parameters.Add("okudumu", "False");
                        ayarlar.cmd.Parameters.Add("durum", "true");
                        ayarlar.cmd.Parameters.Add("cop", "false");
                        ayarlar.cmd.Parameters.Add("firma_kodu", SessionManager.CurrentUser.firma_kodu);
                        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
                        ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.ekleyen_id);
                        ayarlar.cmd.Parameters.Add("ekleyen_ip", HttpContext.Current.Request.ServerVariables["Remote_Addr"]);
                        ayarlar.cmd.ExecuteNonQuery();


                        if (Personel["personel_telefon"].ToString().Length > 5)
                        {
                            ayarlar.NetGSM_SMS(Personel["personel_telefon"].ToString(), SessionManager.CurrentUser.kullanici_adsoyad + " '" + yeni_adi + "...' adlı iş için mesaj gönderdi :" + chat_yazi);
                        }



                        if (Personel["PushUserKey"].ToString().Length > 10)
                        {
                            Exception except;

                            bool result = Pushover.SendNotification(ayarlar.PushOverAppKey, Personel["PushUserKey"].ToString(), "ÜÇGEM MEKANİK A.Ş ERP SYTEM", SessionManager.CurrentUser.kullanici_adsoyad + " '" + yeni_adi + "...' adlı iş için mesaj gönderdi :" + chat_yazi, Priority.Normal, PushoverSound.DeviceDefault, String.Empty, "http://erp.ucgem.com", "http://erp.ucgem.com", 60, 3600, out except);
                        }


                    }


                }



            }
            else
            {
                foreach (string gorevli in iss["gorevliler"].ToString().Split(','))
                {
                    if (iss["ekleyen_id"].ToString() != gorevli && SessionManager.CurrentUser.kullanici_id.ToString() != gorevli)
                    {
                        string yeni_adi = metin_kisaltma(iss["adi"].ToString());

                        DataRow Personel = PersonelBilgileriGetir(gorevli.ToString());

                        Personel = PersonelBilgileriGetir(gorevli.ToString());

                        //string donen = ayarlar.DakikSMSMesajGonder(Personel["personel_telefon"].ToString(), SessionManager.CurrentUser.kullanici_adsoyad + " '" + iss["adi"] + "' adlı iş için mesaj gönderdi :" + chat_yazi);

                        ayarlar.baglan();
                        ayarlar.cmd.Parameters.Clear();
                        ayarlar.cmd.CommandText = "insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values(@bildirim, @tip, @click, @user_id, @okudumu, @durum, @cop, @firma_kodu, @firma_id, @ekleyen_id, @ekleyen_ip, getdate(), getdate()); SET NOCOUNT ON;";
                        ayarlar.cmd.Parameters.Add("bildirim", SessionManager.CurrentUser.kullanici_adsoyad + " '" + yeni_adi + "...' adlı iş için mesaj gönderdi :" + chat_yazi);
                        ayarlar.cmd.Parameters.Add("tip", "is_listesi");
                        ayarlar.cmd.Parameters.Add("click", "sayfagetir('/is_listesi/','jsid=4559&bildirim=true&bildirim_id=" + iss["id"] + "');");
                        ayarlar.cmd.Parameters.Add("user_id", gorevli.ToString());
                        ayarlar.cmd.Parameters.Add("okudumu", "False");
                        ayarlar.cmd.Parameters.Add("durum", "true");
                        ayarlar.cmd.Parameters.Add("cop", "false");
                        ayarlar.cmd.Parameters.Add("firma_kodu", SessionManager.CurrentUser.firma_kodu);
                        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
                        ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.ekleyen_id);
                        ayarlar.cmd.Parameters.Add("ekleyen_ip", HttpContext.Current.Request.ServerVariables["Remote_Addr"]);
                        ayarlar.cmd.ExecuteNonQuery();
                    }
                }
            }
        }


        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select kullanici.personel_ad + ' ' + kullanici.personel_soyad as personel_adsoyad, kullanici.personel_resim, iss.ekleme_tarihi, iss.ekleme_saati, iss.metin, convert(datetime, iss.ekleme_tarihi) + convert(datetime, iss.ekleme_saati) as ekleme_zamani from ucgem_is_yazismalari iss join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = iss.ekleyen_id where iss.IsID = @is_id order by iss.id asc";
        ayarlar.cmd.Parameters.Add("is_id", IsID);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        List<yazisma> yazismalar = new List<yazisma>();

        yazisma_kayit_yok_panel.Visible = false;
        if (ds.Tables[0].Rows.Count == 0)
        {
            yazisma_kayit_yok_panel.Visible = true;
        }

        foreach (DataRow item in ds.Tables[0].Rows)
        {
            yazisma yazisma = new yazisma();
            yazisma.resim = item["personel_resim"].ToString();
            yazisma.yazan = item["personel_adsoyad"].ToString();
            yazisma.ekleme_zamani = Convert.ToDateTime(item["ekleme_tarihi"]).ToShortDateString() + " " + item["ekleme_saati"].ToString().Substring(0, 5);
            yazisma.ekleme_zaman2 = ayarlar.nekadaronce(Convert.ToDateTime(item["ekleme_zamani"]));
            yazisma.metin = item["metin"].ToString();
            yazismalar.Add(yazisma);
        }

        yazismaRepeater.DataSource = yazismalar;
        yazismaRepeater.DataBind();

        ayarlar.cnn.Close();
    }

    private static DataRow IsiGetir(int IsID)
    {
        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select * from ucgem_is_listesi where id = @IsID;";
        ayarlar.cmd.Parameters.Add("IsID", IsID);
        SqlDataAdapter sdas = new SqlDataAdapter(ayarlar.cmd);
        DataSet dss = new DataSet();
        sdas.Fill(dss);

        DataRow iss = dss.Tables[0].Rows[0];

        ayarlar.cnn.Close();

        return iss;
    }


    class yazisma
    {
        public string yazan { get; set; }
        public string resim { get; set; }
        public string ekleme_zamani { get; set; }
        public string ekleme_zaman2 { get; set; }
        public string metin { get; set; }
    }

    public void departman_gosterge_getir()
    {
        string departman_id = Request.Form["tip"].ToString() + "-" + Request.Form["departman_id"].ToString();

        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        if (Request.Form["tip"] == "firma")
        {
            ayarlar.cmd.CommandText = "select *, count(*) as sayi from (select case when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR'  end as is_durum from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id left join ucgem_proje_listesi proje on proje.proje_firma_id = @proje_firma_id where isler.durum = 'true' and isler.firma_id = @firma_id and((SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  @departman_id ) > 0 or (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  'proje-' + CONVERT(NVARCHAR(50), departman2.id) ) > 0) and isler.cop = 'false') as tablo group by tablo.is_durum";
            ayarlar.cmd.Parameters.Add("proje_firma_id", Request.Form["departman_id"].ToString());
        }
        else
        {
            ayarlar.cmd.CommandText = "select *, count(*) as sayi from (select case when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR'  end as is_durum from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id where isler.durum = 'true' and isler.firma_id = @firma_id and (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  @departman_id ) > 0 and isler.cop = 'false') as tablo group by tablo.is_durum";
        }

        ayarlar.cmd.Parameters.Add("departman_id", departman_id);
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda_departmanlar = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds_departmanlar = new DataSet();
        sda_departmanlar.Fill(ds_departmanlar);

        int departmanlar_geciken_int = 0;
        int departmanlar_baslanmamis_int = 0;
        int departmanlar_devameden_int = 0;
        int departmanlar_tamamlanan_int = 0;

        foreach (DataRow item in ds_departmanlar.Tables[0].Rows)
        {
            if (item["is_durum"].ToString() == "GECİKTİ")
            {
                departmanlar_geciken_int = Convert.ToInt32(item["sayi"]);
            }
            else if (item["is_durum"].ToString() == "BEKLİYOR")
            {
                departmanlar_baslanmamis_int = Convert.ToInt32(item["sayi"]);
            }
            else if (item["is_durum"].ToString() == "DEVAM EDİYOR")
            {
                departmanlar_devameden_int = Convert.ToInt32(item["sayi"]);
            }
            else if (item["is_durum"].ToString() == "BİTTİ")
            {
                departmanlar_tamamlanan_int = Convert.ToInt32(item["sayi"]);
            }
        }

        departman_baslanmamis.Text = departmanlar_baslanmamis_int.ToString();
        departman_devameden.Text = departmanlar_devameden_int.ToString();
        departman_gecikmis.Text = departmanlar_geciken_int.ToString();
        departman_tamamlanan.Text = departmanlar_tamamlanan_int.ToString();


        ayarlar.cnn.Close();
    }

    public void is_detay_goster()
    {

        int is_id = Convert.ToInt32(Request.Form["is_id"]);
        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select ISNULL(isler.GantAdimID,0) AS GantAdimID, (select isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + ', ' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select ',' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ISNULL(STUFF(((select ',' + bildirim.adi from ucgem_bildirim_cesitleri bildirim where (SELECT COUNT(value) FROM STRING_SPLIT(isler.kontrol_bildirim, ',') WHERE value =  bildirim.id ) > 0 for xml path(''))), 1, 1, ''), 'Yok') as kontrol_bildirim2, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id where isler.id = @is_id";
        ayarlar.cmd.Parameters.Add("is_id", is_id);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        DataRow detay = ds.Tables[0].Rows[0];
        is_detay_adi.Text = detay["adi"].ToString();
        is_detay_aciklama.Text = detay["aciklama"].ToString();
        is_detay_gorevliler.Text = detay["gorevli_personeller"].ToString();
        is_detay_depatmanlar.Text = detay["departman_isimleri"].ToString();
        is_detay_oncelik.Text = detay["oncelik"].ToString();
        is_detay_baslangic.Text = Convert.ToDateTime(detay["baslangic_tarihi"]).ToShortDateString() + " " + detay["baslangic_saati"].ToString().Substring(0, 5);
        is_detay_bitis.Text = Convert.ToDateTime(detay["bitis_tarihi"]).ToShortDateString() + " " + detay["bitis_saati"].ToString().Substring(0, 5);
        is_detay_bildirim.Text = detay["kontrol_bildirim2"].ToString();

        kaydi_duzenle_buton.CssClass = "btn btn-labeled btn-info btn-mini";
        kaydi_duzenle_buton.NavigateUrl = "javascript:void(0);";
        kaydi_duzenle_buton.Attributes.Add("onclick", "is_kaydini_duzenle('" + detay["id"].ToString() + "'); return false;");





        kayit_edit_butonlar.Visible = false;
        if (detay["ekleyen_id"].ToString() == SessionManager.CurrentUser.kullanici_id.ToString() && Convert.ToInt32(detay["GantAdimID"]) == 0)
        {
            kayit_edit_butonlar.Visible = true;
        }


        is_iptal_buton.CssClass = "btn btn-labeled btn-danger btn-mini";
        is_iptal_buton.NavigateUrl = "javascript:void(0);";

        if (detay["durum"].ToString() == "false")
        {
            is_iptal_buton.Text = "<span class='btn-label'><i class='fa fa-times'></i></span>İşi Aktif Et";
        }

        is_iptal_buton.Attributes.Add("onclick", "isi_iptal_et('" + detay["id"].ToString() + "'); return false;");


        // < guncel_lineer renk = "<%# DataBinder.Eval(Container.DataItem, "renk") %>" baslangic_tarihi = "<%# DataBinder.Eval(Container.DataItem, "baslangic_tarihi") %>" baslangic_saati = "<%# DataBinder.Eval(Container.DataItem, "baslangic_saati") %>" bitis_tarihi = "<%# DataBinder.Eval(Container.DataItem, "bitis_tarihi") %>" bitis_saati = "<%# DataBinder.Eval(Container.DataItem, "bitis_saati") %>" id = "<%# DataBinder.Eval(Container.DataItem, "id") %>" adi = "<%# DataBinder.Eval(Container.DataItem, "adi") %>" etiketler = "<%# DataBinder.Eval(Container.DataItem, "departman_isimleri") %>" ekleyen = "<%# DataBinder.Eval(Container.DataItem, "ekleyen_adsoyad") %>" ></ guncel_lineer >

        guncel_lineer.Attributes.Add("renk", detay["renk"].ToString());
        guncel_lineer.Attributes.Add("baslangic_tarihi", Convert.ToDateTime(detay["baslangic_tarihi"]).ToShortDateString());
        guncel_lineer.Attributes.Add("baslangic_saati", detay["baslangic_saati"].ToString().Substring(0, 5));
        guncel_lineer.Attributes.Add("bitis_tarihi", Convert.ToDateTime(detay["bitis_tarihi"]).ToShortDateString());
        guncel_lineer.Attributes.Add("bitis_saati", detay["bitis_saati"].ToString().Substring(0, 5));
        guncel_lineer.Attributes.Add("Idd", is_id.ToString());
        guncel_lineer.Attributes.Add("adi", detay["adi"].ToString());
        guncel_lineer.Attributes.Add("etiketler", detay["departman_isimleri"].ToString());
        guncel_lineer.Attributes.Add("ekleyen", detay["ekleyen_adsoyad"].ToString());
        guncel_lineer.Attributes.Add("class", "guncel_lineer");


        ayarlar.cmd.Parameters.Clear();

        // ayarlar.cmd.CommandText = "SELECT dbo.DakikadanSaatYap( (SELECT ISNULL(SUM((DATEDIFF(n, CONVERT(DATETIME, olay.baslangic) + CONVERT(DATETIME, olay.baslangic_saati), CONVERT(DATETIME, olay.bitis) + CONVERT(DATETIME, olay.bitis_saati)))),0) FROM dbo.ahtapot_ajanda_olay_listesi olay WITH(NOLOCK) WHERE olay.IsID = gorevli.is_id AND olay.durum = 'true' AND olay.cop = 'false' )) as harcanan, ISNULL(kaynak.toplam_sure,'0:00') AS toplam_sure, ISNULL(kaynak.gunluk_sure,'0:00') AS gunluk_sure, ISNULL(kaynak.toplam_gun, '0:00') AS toplam_gun, isnull(iss.GantAdimID, 0) as GantAdimID, convert(datetime,gorevli.ekleme_tarihi) + convert(datetime, gorevli.ekleme_saati) as tamamlanma_zamani, kullanici.personel_resim, kullanici.personel_ad + ' ' + kullanici.personel_soyad as personel_adsoyad,gorevli.gorevli_id, gorevli.id, gorevli.tamamlanma_orani from ucgem_is_gorevli_durumlari gorevli with(nolock) join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = gorevli.gorevli_id join ucgem_is_listesi iss on iss.id = gorevli.is_id LEFT JOIN dbo.ahtapot_gantt_adim_kaynaklari kaynak with(nolock) ON kaynak.adimID = iss.GantAdimID WHERE gorevli.is_id = @is_id GROUP BY kaynak.toplam_sure, kaynak.gunluk_sure, kaynak.toplam_gun, isnull(iss.GantAdimID, 0), convert(datetime,gorevli.ekleme_tarihi) + convert(datetime, gorevli.ekleme_saati), kullanici.personel_resim, kullanici.personel_ad + ' ' + kullanici.personel_soyad, gorevli.gorevli_id, gorevli.id, gorevli.tamamlanma_orani, gorevli.is_id;";

        ayarlar.cmd.CommandText = "SELECT dbo.DakikadanSaatYap( ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT(DATETIME, olay.baslangic) + CONVERT(DATETIME, olay.baslangic_saati), CONVERT(DATETIME, olay.bitis) + CONVERT(DATETIME, olay.bitis_saati) ) ) ), 0 ) FROM dbo.ahtapot_ajanda_olay_listesi olay WITH (NOLOCK) WHERE olay.IsID = gorevli.is_id and olay.etiket = 'personel' and olay.etiket_id = @kullanici_id AND olay.durum = 'true' AND olay.cop = 'false' ) ) AS harcanan, CASE WHEN (DATEDIFF( n, DATEADD( n, ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT(DATETIME, olay.baslangic) + CONVERT(DATETIME, olay.baslangic_saati), CONVERT(DATETIME, olay.bitis) + CONVERT(DATETIME, olay.bitis_saati) ) ) ), 0 ) FROM dbo.ahtapot_ajanda_olay_listesi olay WITH (NOLOCK) WHERE olay.IsID = gorevli.is_id AND olay.durum = 'true' AND olay.cop = 'false' ), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ), DATEADD( n, dbo.SaattenDakikaYap(ISNULL(gorevli.toplam_sure, '00:00')), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ) ) ) < 0 THEN '-' ELSE '' END + dbo.DakikadanSaatYap( CASE WHEN (DATEDIFF( n, DATEADD( n, ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT( DATETIME, olay.baslangic ) + CONVERT( DATETIME, olay.baslangic_saati ), CONVERT( DATETIME, olay.bitis ) + CONVERT( DATETIME, olay.bitis_saati ) ) ) ), 0 ) FROM dbo.ahtapot_ajanda_olay_listesi olay WITH (NOLOCK) WHERE olay.IsID = gorevli.is_id AND olay.durum = 'true' AND olay.cop = 'false' ), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ), DATEADD( n, dbo.SaattenDakikaYap(ISNULL( gorevli.toplam_sure, '00:00' ) ), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ) ) ) < 0 THEN -1 * DATEDIFF( n, DATEADD( n, ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT( DATETIME, olay.baslangic ) + CONVERT( DATETIME, olay.baslangic_saati ), CONVERT( DATETIME, olay.bitis ) + CONVERT( DATETIME, olay.bitis_saati ) ) ) ), 0 ) FROM dbo.ahtapot_ajanda_olay_listesi olay WITH (NOLOCK) WHERE olay.IsID = gorevli.is_id AND olay.durum = 'true' AND olay.cop = 'false' ), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ), DATEADD( n, dbo.SaattenDakikaYap(ISNULL( gorevli.toplam_sure, '00:00' ) ), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ) ) ELSE DATEDIFF( n, DATEADD( n, ( SELECT ISNULL( SUM((DATEDIFF( n, CONVERT( DATETIME, olay.baslangic ) + CONVERT( DATETIME, olay.baslangic_saati ), CONVERT(DATETIME, olay.bitis) + CONVERT( DATETIME, olay.bitis_saati ) ) ) ), 0 ) FROM dbo.ahtapot_ajanda_olay_listesi olay WITH (NOLOCK) WHERE olay.IsID = gorevli.is_id AND olay.durum = 'true' AND olay.cop = 'false' ), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ), DATEADD( n, dbo.SaattenDakikaYap(ISNULL(gorevli.toplam_sure, '00:00')), CONVERT(DATETIME, iss.baslangic_tarihi) + CONVERT(DATETIME, '00:00') ) ) END ) AS kalan, ISNULL(gorevli.toplam_sure, '0:00') AS toplam_sure, ISNULL(gorevli.gunluk_sure, '0:00') AS gunluk_sure, ISNULL(gorevli.toplam_gun, '0:00') AS toplam_gun, CASE WHEN ISNULL(gorevli.toplam_sure, '0:00') = '0:00' THEN 0 ELSE 1 end AS GantAdimID, ISNULL(sinirlama_varmi, 0) as sinirlama_varmi, CONVERT(DATETIME, gorevli.ekleme_tarihi) + CONVERT(DATETIME, gorevli.ekleme_saati) AS tamamlanma_zamani, kullanici.personel_resim, kullanici.personel_ad + ' ' + kullanici.personel_soyad AS personel_adsoyad, gorevli.gorevli_id, gorevli.id, gorevli.tamamlanma_orani FROM ucgem_is_gorevli_durumlari gorevli WITH (NOLOCK) JOIN ucgem_firma_kullanici_listesi kullanici WITH (NOLOCK) ON kullanici.id = gorevli.gorevli_id JOIN ucgem_is_listesi iss ON iss.id = gorevli.is_id WHERE gorevli.is_id = @is_id GROUP BY gorevli.toplam_sure, gorevli.gunluk_sure, gorevli.toplam_gun, ISNULL(iss.GantAdimID, 0), CONVERT(DATETIME, gorevli.ekleme_tarihi) + CONVERT(DATETIME, gorevli.ekleme_saati), kullanici.personel_resim, kullanici.personel_ad + ' ' + kullanici.personel_soyad, gorevli.gorevli_id, gorevli.id, gorevli.tamamlanma_orani, gorevli.is_id, iss.baslangic_tarihi, iss.sinirlama_varmi;";
        ayarlar.cmd.Parameters.Add("is_id", is_id);
        ayarlar.cmd.Parameters.Add("kullanici_id", SessionManager.CurrentUser.kullanici_id);
        SqlDataAdapter sda_durum = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds_durum = new DataSet();
        sda_durum.Fill(ds_durum);

        List<gorevli_durum> durumlar = new List<gorevli_durum>();

        foreach (DataRow durum in ds_durum.Tables[0].Rows)
        {
            gorevli_durum gorevli_durum = new gorevli_durum();
            gorevli_durum.IsID = is_id;
            gorevli_durum.PersonelID = Convert.ToInt32(durum["gorevli_id"]);
            gorevli_durum.Personel_adi = durum["personel_adsoyad"].ToString();
            gorevli_durum.Personel_resim = durum["personel_resim"].ToString();
            gorevli_durum.TamamlanmaID = Convert.ToInt32(durum["id"]);
            gorevli_durum.tamamlanma_zamani = Convert.ToDateTime(durum["tamamlanma_zamani"]);
            gorevli_durum.tamamlanma_durum = Convert.ToInt32(durum["tamamlanma_orani"]);

            if (Convert.ToInt32(durum["sinirlama_varmi"]) == 0)
                gorevli_durum.planlama_varmi = false;
            else
                gorevli_durum.planlama_varmi = true;

            gorevli_durum.planlanan_calisma = durum["gunluk_sure"].ToString() + " X " + durum["toplam_gun"].ToString() + " gün = " + durum["toplam_sure"].ToString();
            gorevli_durum.kalan_sure = durum["toplam_sure"].ToString();
            gorevli_durum.harcanan_sure = durum["harcanan"].ToString();

            durumlar.Add(gorevli_durum);
        }

        gorevli_durumlari.DataSource = durumlar;
        gorevli_durumlari.ItemCreated += Gorevli_durumlari_ItemCreated;
        gorevli_durumlari.DataBind();

        is_yazisma_tab_buton.Attributes.Add("onclick", "is_yazisma_yeni_goster('" + is_id + "');");

        dosya_listesi_tab_buton.Attributes.Add("onclick", "dosya_listesi_getir('" + is_id + "');");

        yazisma_gonder_button.CssClass = "btn btn-primary";
        yazisma_gonder_button.Attributes.Add("onclick", "is_yazisma_yeni_gonder('" + is_id + "');");

        string kontrol_bildirim = detay["kontrol_bildirim"].ToString();

        dosya_listesi.ClientIDMode = ClientIDMode.Static;
        dosya_listesi.ID = "dosya_listesi" + is_id.ToString();

        dosya_ekleme.Attributes.Add("value", "/img/kucukboy.png");
        dosya_ekleme.Attributes.Add("tip", "kucuk");
        dosya_ekleme.Attributes.Add("yol", "dosya_deposu/");
        dosya_ekleme.Attributes.Add("style", "height:31px!important;");
        dosya_ekleme.ClientIDMode = ClientIDMode.Static;
        dosya_ekleme.ID = "dosya_yolu" + is_id.ToString();

        dosya_adi.ClientIDMode = ClientIDMode.Static;
        dosya_adi.ID = "dosya_adi" + is_id.ToString();

        dosya_kaydet_buton.CssClass = "btn btn-success";
        dosya_kaydet_buton.Text = "Kaydet";
        dosya_kaydet_buton.OnClientClick = "yeni_is_dosya_ekle('" + is_id.ToString() + "'); return false;";

        chatBody.CssClass = "chat-body no-padding profile-message";
        chatBody.Attributes.Add("style", "overflow-y:auto; height:400px!important; padding-bottom:30px!important;");
        chatBody.Visible = true;
        chatBody.ClientIDMode = ClientIDMode.Static;
        chatBody.ID = "ChatBody" + is_id.ToString();

        chat_yazi.ID = "chat_yazi" + is_id.ToString();
        chat_yazi.ClientIDMode = ClientIDMode.Static;
        chat_yazi.CssClass = "form-control chat_yazi";
        chat_yazi.Attributes.Add("placeholder", "Bir mesaj yaz...");




        is_detay_kontrol_bildirim.SelectionMode = ListSelectionMode.Multiple;
        is_detay_kontrol_bildirim.CssClass = "select2";
        is_detay_kontrol_bildirim.Style.Add("widh", "100%;");
        is_detay_kontrol_bildirim.Attributes.Add("multiple", "multiple");


        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select id, adi from ucgem_bildirim_cesitleri";
        SqlDataAdapter sda_bildirim = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds_bildirim = new DataSet();
        sda_bildirim.Fill(ds_bildirim);

        foreach (DataRow item in ds_bildirim.Tables[0].Rows)
        {
            ListItem litem = new ListItem();
            litem.Text = item["adi"].ToString();
            litem.Value = item["id"].ToString();
            if (("asd," + kontrol_bildirim.ToString() + ",asd").IndexOf("," + item["id"] + ",") > 0)
            {
                litem.Selected = true;
            }
            else
            {
                litem.Selected = false;
            }

            is_detay_kontrol_bildirim.Items.Add(litem);
        }



        is_detay_kontrol_bildirim.ClientIDMode = ClientIDMode.Static;
        is_detay_kontrol_bildirim.ID = "is_detay_kontrol_bildirim" + detay["id"].ToString();

        is_kontrol_bildirim_guncelle_button.CssClass = "btn btn-primary";

        is_kontrol_bildirim_guncelle_button.OnClientClick = "is_kontrol_bildirim_guncelle('" + detay["id"].ToString() + "'); return false;";
        is_kontrol_bildirim_guncelle_button.UseSubmitBehavior = false;
        ayarlar.cnn.Close();

    }

    private void Gorevli_durumlari_ItemCreated(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            gorevli_durum gorevli = (gorevli_durum)e.Item.DataItem;
            Panel is_yetkili_durum = e.Item.FindControl("is_yetkili_durum") as Panel;
            Panel is_yetkisiz_durum = e.Item.FindControl("is_yetkisiz_durum") as Panel;
            is_yetkisiz_durum.Visible = false;
            is_yetkili_durum.Visible = false;

            Panel planlama_yetkili_panel = e.Item.FindControl("planlama_yetkili_panel") as Panel;
            planlama_yetkili_panel.Visible = false;

            Panel planlama_yetkisiz_panel = e.Item.FindControl("planlama_yetkisiz_panel") as Panel;
            planlama_yetkisiz_panel.Visible = false;

            Panel planlama_yetkili_panel_plansiz = e.Item.FindControl("planlama_yetkili_panel_plansiz") as Panel;
            planlama_yetkili_panel_plansiz.Visible = false;

            Panel planlama_yetkisiz_panel_plansiz = e.Item.FindControl("planlama_yetkisiz_panel_plansiz") as Panel;
            planlama_yetkisiz_panel_plansiz.Visible = false;


            if (gorevli.PersonelID == SessionManager.CurrentUser.kullanici_id)
            {
                is_yetkili_durum.Visible = true;
                if (gorevli.planlama_varmi)
                    planlama_yetkili_panel.Visible = true;
                else
                    planlama_yetkili_panel_plansiz.Visible = true;

            }
            else
            {
                is_yetkisiz_durum.Visible = true;
                if (gorevli.planlama_varmi)
                    planlama_yetkisiz_panel.Visible = true;
                else
                    planlama_yetkisiz_panel_plansiz.Visible = false;

            }

        }
    }

    class gorevli_durum
    {

        public int IsID { get; set; }
        public int TamamlanmaID { get; set; }
        public int PersonelID { get; set; }
        public string Personel_adi { get; set; }
        public string Personel_resim { get; set; }
        public int tamamlanma_durum { get; set; }
        public DateTime tamamlanma_zamani { get; set; }
        public bool planlama_varmi { get; set; }
        public string planlanan_calisma { get; set; }
        public string harcanan_sure { get; set; }
        public string kalan_sure { get; set; }

    }

    public void is_listesi()
    {
        try
        {
            string stok = "";
            string yer = "";
            int parcaId;
            int personelId = 0;
            string durum = Request.Form["durum"].ToString();
            if (Request.Form["stok"] != null)
                stok = Request.Form["stok"].ToString();
            parcaId = Convert.ToInt32(Request.Form["parcaId"]);
            if (Request.Form["yer"] != null)
            {
                yer = Request.Form["yer"].ToString();
                personelId = Convert.ToInt32(Request.Form["personelId"].ToString());
            }
            int projeId = Convert.ToInt32(Request.Form["projeId"]);

            string sql_str = "";
            string sql_string = "";
            bool control = false;
            string tum_sql_str = "";
            string gdurum_str = "";
            string iptal_str = "";
            string yer_str = "";

            if (yer.ToString() == "proje")
            {
                yer_str = " and SUBSTRING((select value from string_split(isler.departmanlar, ',') where value like '%proje%'), CHARINDEX('-', (select value from string_split(isler.departmanlar, ',') where value like '%proje%')) + 1, 10) = " + projeId + " and isler.departmanlar != ''";
            }

            if (durum == "iptal")
            {
                sql_str = " and case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end = 'İPTAL'";
            }
            else if (durum == "geciken")
            {
                sql_str = " and isler.durum = 'true' and case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end = 'GECİKTİ'";
            }
            else if (durum == "bekleyen")
            {
                sql_str = " and isler.durum = 'true' and case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end = 'BEKLİYOR'";
            }
            else if (durum == "devameden")
            {
                sql_str = @" and isler.durum = 'true' and 
                        case 
                        when ISNULL(isler.tamamlanma_orani,0) < 100 and ISNULL(isler.tamamlanma_orani,0) > 1
                            then 'DEVAM EDİYOR'
                        end = 'DEVAM EDİYOR'";
            }
            else if (durum == "biten")
            {
                control = true;

                sql_string = " case when (CONVERT(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati)) < convert(datetime, isler.tamamlanma_tarihi) + CONVERT(datetime, isler.tamamlanma_saati) then 'GECİKTİ' else 'ZAMANINDA' end as geciktimi,";

                sql_str = " and isler.durum = 'true' and case when isler.durum = 'false' then 'İPTAL' " +
                    "when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' " +
                    "when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' " +
                    "when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' " +
                    "when ISNULL(isler.tamamlanma_orani,0) < 100 then 'DEVAM EDİYOR' " +
                    "end = 'BİTTİ'";
            }
            else if (durum == "tum")
            {
                sql_str = " and ISNULL(isler.tamamlanma_orani,0) < 100 ";
                tum_sql_str = "left JOIN ucgem_is_gorevli_durumlari gdurum with(nolock) ON gdurum.is_id = isler.id AND gdurum.gorevli_id = @kullanici_id";
                gdurum_str = " AND ISNULL( gdurum.tamamlanma_orani,0) < CASE WHEN ISNULL(gdurum.id,0) != 0 THEN 100 ELSE 101 end";
                iptal_str = "AND ( case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end )  != 'İPTAL'";
            }


            //Response.Write(sql_str);

            isler_is_yok_panel.Visible = false;
            isler_isvar_panel.Visible = false;

            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();

            ayarlar.cmd.CommandText = "SELECT * FROM ucgem_firma_kullanici_listesi WHERE id = '" + SessionManager.CurrentUser.kullanici_id + "' AND yonetici_yetkisi = 'true'";
            SqlDataAdapter sda1 = new SqlDataAdapter(ayarlar.cmd);
            DataSet ds1 = new DataSet();
            sda1.Fill(ds1);
            DataTable dt = new DataTable();
            dt = ds1.Tables[0];

            int UserID = 0;
            foreach (DataRow dr in dt.Rows)
            {
                UserID = Convert.ToInt32(dr[0]);
            }

            if (SessionManager.CurrentUser.kullanici_id == UserID)
            {

                if (yer.ToString() == "personelIsleri")
                {
                    yer_str = " and ((SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value =  CONVERT(NVARCHAR(50), " + personelId + ") ) > 0) or isler.ekleyen_id = " + personelId + " ";
                }

                if (stok != "Stok")
                {
                    ayarlar.cmd.CommandText = "   select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,4), 4 )  AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler, case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, " + sql_string + " (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id where isler.firma_id = @firma_id " + sql_str + " and isler.cop = 'false' " + yer_str + " " + iptal_str + " order by (convert(datetime, isler.guncelleme_tarihi) + convert(datetime, isler.guncelleme_saati)) desc;";
                }
                else
                {
                    ayarlar.cmd.CommandText = @"select 
    ISNULL((SELECT TOP 1 SUBSTRING(f.firma_adi, 1, 3)FROM ucgem_firma_listesi f),'') +SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)), 3, 2) + RIGHT('0' + CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id), 1, 4), 4)  AS is_kodu, isnull(isler.renk, '') as renk, 
	Replace(Replace(STUFF((("
                            + "select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')', '') + '</span>'"
                            + "from etiketler etiket with(nolock)"
                            + "where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',') > 0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler, case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, "
                                + "(select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim, '') + '~' + isnull(kullanici.personel_ad, '') + ' ' + isnull(kullanici.personel_soyad, '') + '|'"
                                + "from ucgem_firma_kullanici_listesi kullanici with(nolock)"
                                + "where ("
                                    + "SELECT COUNT(value)"
                                    + "FROM STRING_SPLIT(isler.gorevliler, ',') "
                                    + "WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller,"
                                        + "STUFF(((select '~' + etiket.adi "
                                                + "from etiketler etiket with(nolock)"
                                                + "where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',') > 0 for xml path            (''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad,				isler.*"
      + "from ucgem_is_listesi isler with(nolock)"
      + "join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id " +
      "left join is_parca_listesi isparca on isparca.IsID = isler.id "
      + "where isler.firma_id = @firma_id  and isler.cop = 'false' and isparca.ParcaId = " + parcaId + " "
    + "order by(convert(datetime, isler.guncelleme_tarihi) +convert(datetime, isler.guncelleme_saati)) desc ";
                }
            }
            else
            {
                if (stok != "Stok")
                {
                    ayarlar.cmd.CommandText = "select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,4), 4 )  AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,  case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, " + sql_string + " (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler  etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id " + tum_sql_str + " join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = @kullanici_id left join tanimlama_departman_listesi departman2 with(nolock) on (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  'departman-' + CONVERT(NVARCHAR(50), departman2.id) ) > 0 where  isler.firma_id = @firma_id " + sql_str + " and ( ((SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value =  CONVERT(NVARCHAR(50),@kullanici_id) ) > 0) or isler.ekleyen_id = @kullanici_id or ((SELECT COUNT(value) FROM STRING_SPLIT(kullanici.departmanlar, ',') WHERE value =  CONVERT(NVARCHAR(50),departman2.id) ) > 0) ) " + gdurum_str + " and isler.cop = 'false' " + yer_str + " " + iptal_str + " GROUP BY isler.id, isler.renk, isler.departmanlar, isler.durum,isler.tamamlanma_orani,isler.bitis_tarihi,isler.bitis_saati,isler.gorevliler, ekleyen.personel_ad, ekleyen.personel_soyad, isler.adi, isler.aciklama, isler.oncelik, isler.kontrol_bildirim, isler.baslangic_tarihi, isler.baslangic_saati, isler.cop, isler.firma_kodu, isler.firma_id, isler.ekleyen_id, isler.ekleyen_ip, isler.ekleme_tarihi, isler.ekleme_saati, isler.silen_id, isler.silen_ip, isler.silme_tarihi, isler.silme_saati, isler.tamamlanma_tarihi, isler.tamamlanma_saati, isler.guncelleme_tarihi, isler.guncelleme_saati, isler.guncelleyen, isler.ajanda_gosterim, isler.GantAdimID, isler.toplam_sure, isler.gunluk_sure, isler.toplam_gun, isler.sinirlama_varmi, isler.is_tipi order by (convert(datetime, isler.guncelleme_tarihi) + convert(datetime, isler.guncelleme_saati)) desc;";
                }
                else
                {
                    ayarlar.cmd.CommandText = @"select 
    ISNULL((SELECT TOP 1 SUBSTRING(f.firma_adi, 1, 3)FROM ucgem_firma_listesi f),'') +SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)), 3, 2) + RIGHT('0' + CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id), 1, 4), 4)  AS is_kodu, isnull(isler.renk, '') as renk, 
	Replace(Replace(STUFF((("
                            + "select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')', '') + '</span>'"
                            + "from etiketler etiket with(nolock)"
                            + "where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',') > 0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler, case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, "
                                + "(select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim, '') + '~' + isnull(kullanici.personel_ad, '') + ' ' + isnull(kullanici.personel_soyad, '') + '|'"
                                + "from ucgem_firma_kullanici_listesi kullanici with(nolock)"
                                + "where ("
                                    + "SELECT COUNT(value)"
                                    + "FROM STRING_SPLIT(isler.gorevliler, ',') "
                                    + "WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller,"
                                        + "STUFF(((select '~' + etiket.adi "
                                                + "from etiketler etiket with(nolock)"
                                                + "where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',') > 0 for xml path            (''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad,				isler.*"
      + "from ucgem_is_listesi isler with(nolock)"
      + "join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id " +
      "left join is_parca_listesi isparca on isparca.IsID = isler.id "
      + "where isler.firma_id = @firma_id  and isler.cop = 'false' and isparca.ParcaId = " + parcaId + " "
    + "order by(convert(datetime, isler.guncelleme_tarihi) +convert(datetime, isler.guncelleme_saati)) desc ";
                }
                // ayarlar.cmd.CommandText = "select * from deneme_tablo";

            }

            string tip = "";
            try
            {
                tip = Request.Form["tip"].ToString();
            }
            catch (Exception)
            {

            }

            if (tip == "departman_tumu")
            {
                tip = "";
            }

            if (tip != "")
            {
                if (tip == "benim_tum")
                {
                    ayarlar.cmd.CommandText = "select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,4), 4 )  AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,  case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id where isler.durum = 'true' and isler.firma_id = @firma_id and ((SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), @kullanici_id) ) > 0) and isler.cop = 'false' order by (convert(datetime, isler.guncelleme_tarihi) + convert(datetime, isler.guncelleme_saati)) desc;";
                }
                else if (tip == "benim_baslanmamis")
                {
                    ayarlar.cmd.CommandText = "select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,4), 4 )  AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,  case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id where isler.durum = 'true' and isler.firma_id = @firma_id and ((SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), @kullanici_id) ) > 0) and case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end = 'BEKLİYOR' and isler.cop = 'false' order by (convert(datetime, isler.guncelleme_tarihi) + convert(datetime, isler.guncelleme_saati)) desc;";

                }
                else if (tip == "benim_devameden")
                {
                    ayarlar.cmd.CommandText = "select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,4), 4 )  AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,  case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when ISNULL(isler.tamamlanma_orani,0) > 0 and ISNULL(isler.tamamlanma_orani,0) < 100 then 'DEVAM EDİYOR' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' end as is_durum, (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id where isler.durum = 'true' and isler.firma_id = @firma_id and ((SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), @kullanici_id) ) > 0) and case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when ISNULL(isler.tamamlanma_orani,0) > 0 and ISNULL(isler.tamamlanma_orani,0) < 100 then 'DEVAM EDİYOR'  when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' end = 'DEVAM EDİYOR' and isler.cop = 'false' order by (convert(datetime, isler.guncelleme_tarihi) + convert(datetime, isler.guncelleme_saati)) desc;";

                }
                else if (tip == "benim_gecikmis")
                {
                    ayarlar.cmd.CommandText = "select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,4), 4 )  AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,  case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id where isler.durum = 'true' and isler.firma_id = @firma_id and ((SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), @kullanici_id) ) > 0) and case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end = 'GECİKTİ' and isler.cop = 'false' order by (convert(datetime, isler.guncelleme_tarihi) + convert(datetime, isler.guncelleme_saati)) desc;";

                }
                else if (tip == "benim_tamamlanan")
                {
                    ayarlar.cmd.CommandText = "select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,4), 4 )  AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,  case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id where isler.durum = 'true' and isler.firma_id = @firma_id and ((SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), @kullanici_id) ) > 0) and case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end = 'BİTTİ' and isler.cop = 'false' order by (convert(datetime, isler.guncelleme_tarihi) + convert(datetime, isler.guncelleme_saati)) desc;";
                }
                else if (tip == "baskasi_tumu")
                {
                    ayarlar.cmd.CommandText = "select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,4), 4 ) AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,  case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id where isler.durum = 'true' and isler.firma_id = @firma_id and isler.ekleyen_id = @kullanici_id and isnull((select top 1 isnull(Replace(metin, 'null', '0'),'0') from dbo.Split(Replace(isler.gorevliler, 'null', '0'), ',') where ISNULL(Metin,'0')!='' + @kullanici_id + ''), '0')>0 and isler.ekleyen_id = @kullanici_id and isler.cop = 'false' order by (convert(datetime, isler.guncelleme_tarihi) + convert(datetime, isler.guncelleme_saati)) desc;";
                }
                else if (tip == "baskasi_baslanmamis")
                {
                    ayarlar.cmd.CommandText = "select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,4), 4 ) AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,  case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id where  isler.durum = 'true' and isler.firma_id = @firma_id and isler.ekleyen_id = @kullanici_id and isnull((select top 1 isnull(Replace(metin, 'null', '0'),'0') from dbo.Split(Replace(isler.gorevliler, 'null', '0'), ',') where ISNULL(Metin,'0')!='' + @kullanici_id + ''), '0')>0 and isler.ekleyen_id = @kullanici_id and isler.cop = 'false' and case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end = 'BEKLİYOR' order by (convert(datetime, isler.guncelleme_tarihi) + convert(datetime, isler.guncelleme_saati)) desc;";
                }
                else if (tip == "baskasi_devameden")
                {
                    ayarlar.cmd.CommandText = "select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,4), 4 ) AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,  case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id where  isler.durum = 'true' and isler.firma_id = @firma_id and isler.ekleyen_id = @kullanici_id and isnull((select top 1 isnull(Replace(metin, 'null', '0'),'0') from dbo.Split(Replace(isler.gorevliler, 'null', '0'), ',') where ISNULL(Metin,'0')!='' + @kullanici_id + ''), '0')>0 and isler.ekleyen_id = @kullanici_id and isler.cop = 'false' and case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end = 'DEVAM EDİYOR' order by (convert(datetime, isler.guncelleme_tarihi) + convert(datetime, isler.guncelleme_saati)) desc;";
                }
                else if (tip == "baskasi_gecikmis")
                {
                    ayarlar.cmd.CommandText = "select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,4), 4 ) AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,  case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id where isler.durum = 'true' and isler.firma_id = @firma_id and isler.ekleyen_id = @kullanici_id and isnull((select top 1 isnull(Replace(metin, 'null', '0'),'0') from dbo.Split(Replace(isler.gorevliler, 'null', '0'), ',') where ISNULL(Metin,'0')!='' + @kullanici_id + ''), '0')>0 and isler.ekleyen_id = @kullanici_id and isler.cop = 'false' and case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end = 'GECİKTİ' order by (convert(datetime, isler.guncelleme_tarihi) + convert(datetime, isler.guncelleme_saati)) desc;";
                }
                else if (tip == "baskasi_biten")
                {
                    ayarlar.cmd.CommandText = "select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,4), 4 ) AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,  case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id where isler.durum = 'true' and isler.firma_id = @firma_id and isler.ekleyen_id = @kullanici_id and isnull((select top 1 isnull(Replace(metin, 'null', '0'),'0') from dbo.Split(Replace(isler.gorevliler, 'null', '0'), ',') where ISNULL(Metin,'0')!='' + @kullanici_id + ''), '0')>0 and isler.ekleyen_id = @kullanici_id and isler.cop = 'false' and case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end = 'BİTTİ' order by (convert(datetime, isler.guncelleme_tarihi) + convert(datetime, isler.guncelleme_saati)) desc;";
                }
                else if (tip == "departman_baslanmamis")
                {
                    string etiket = Request.Form["etiket_tip"].ToString() + "-" + Request.Form["etiket"].ToString();

                    if (Request.Form["etiket_tip"].ToString() == "firma")
                    {
                        ayarlar.cmd.CommandText = "select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,4), 4 ) AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,  case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = @kullanici_id left join tanimlama_departman_listesi departman2 with(nolock) on (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  'departman-' + CONVERT(NVARCHAR(50), departman2.id) ) > 0 left join ucgem_proje_listesi proje on proje.proje_firma_id = @proje_firma_id where isler.durum = 'true' and isler.firma_id = @firma_id and((SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  @etiket ) > 0 or (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  'proje-' + CONVERT(NVARCHAR(50), departman2.id) ) > 0) and isler.cop = 'false' and case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end = 'BEKLİYOR' order by(convert(datetime, isler.guncelleme_tarihi) +convert(datetime, isler.guncelleme_saati)) desc;";

                        ayarlar.cmd.Parameters.Add("proje_firma_id", Request.Form["etiket"].ToString());
                    }
                    else
                    {
                        ayarlar.cmd.CommandText = "select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,4), 4 ) AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,  case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = @kullanici_id left join tanimlama_departman_listesi departman2 with(nolock) on (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  'departman-' + CONVERT(NVARCHAR(50), departman2.id) ) > 0 where isler.durum = 'true' and isler.firma_id = @firma_id and (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  @etiket ) > 0 and isler.cop = 'false' and case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end = 'BEKLİYOR' order by (convert(datetime, isler.guncelleme_tarihi) + convert(datetime, isler.guncelleme_saati)) desc;";
                    }



                    ayarlar.cmd.Parameters.Add("etiket", etiket);
                }
                else if (tip == "departman_gecikmis")
                {
                    string etiket = Request.Form["etiket_tip"] + "-" + Request.Form["etiket"];

                    if (Request.Form["etiket_tip"].ToString() == "firma")
                    {
                        ayarlar.cmd.CommandText = "select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,4), 4 ) AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,  case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = @kullanici_id left join tanimlama_departman_listesi departman2 with(nolock) on (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  'departman-' + CONVERT(NVARCHAR(50), departman2.id) ) > 0 left join ucgem_proje_listesi proje on proje.proje_firma_id = @proje_firma_id where isler.durum = 'true' and isler.firma_id = @firma_id and((SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  @etiket ) > 0 or (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  'proje-' + CONVERT(NVARCHAR(50), departman2.id) ) > 0) and isler.cop = 'false' and case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end = 'GECİKTİ' order by(convert(datetime, isler.guncelleme_tarihi) +convert(datetime, isler.guncelleme_saati)) desc;";

                        ayarlar.cmd.Parameters.Add("proje_firma_id", Request.Form["etiket"].ToString());
                    }
                    else
                    {
                        ayarlar.cmd.CommandText = "select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,4), 4 ) AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,  case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = @kullanici_id left join tanimlama_departman_listesi departman2 with(nolock) on (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  'departman-' + CONVERT(NVARCHAR(50), departman2.id) ) > 0 where  isler.durum = 'true' and isler.firma_id = @firma_id and (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  @etiket ) > 0 and isler.cop = 'false' and case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end = 'GECİKTİ' order by (convert(datetime, isler.guncelleme_tarihi) + convert(datetime, isler.guncelleme_saati)) desc;";
                    }

                    ayarlar.cmd.Parameters.Add("etiket", etiket);


                }
                else if (tip == "departman_devameden")
                {
                    string etiket = Request.Form["etiket_tip"].ToString() + "-" + Request.Form["etiket"].ToString();
                    if (Request.Form["etiket_tip"].ToString() == "firma")
                    {
                        ayarlar.cmd.CommandText = "select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,2), 4 ) AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,  case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = @kullanici_id left join tanimlama_departman_listesi departman2 with(nolock) on (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  'departman-' + CONVERT(NVARCHAR(50), departman2.id) ) > 0 left join ucgem_proje_listesi proje on proje.proje_firma_id = @proje_firma_id where isler.durum = 'true' and isler.firma_id = @firma_id and((SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  @etiket ) > 0 or (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  'proje-' + CONVERT(NVARCHAR(50), departman2.id) ) > 0) and isler.cop = 'false' and case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end = 'DEVAM EDİYOR' order by(convert(datetime, isler.guncelleme_tarihi) +convert(datetime, isler.guncelleme_saati)) desc;";

                        ayarlar.cmd.Parameters.Add("proje_firma_id", Request.Form["etiket"].ToString());
                    }
                    else
                    {

                        ayarlar.cmd.CommandText = "select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,2), 4 ) AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,  case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = @kullanici_id left join tanimlama_departman_listesi departman2 with(nolock) on (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  'departman-' + CONVERT(NVARCHAR(50), departman2.id) ) > 0 where isler.durum = 'true' and isler.firma_id = @firma_id and (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  @etiket ) > 0 and isler.cop = 'false' and case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end = 'DEVAM EDİYOR' order by (convert(datetime, isler.guncelleme_tarihi) + convert(datetime, isler.guncelleme_saati)) desc;";
                    }

                    ayarlar.cmd.Parameters.Add("etiket", etiket);
                }
                else if (tip == "departman_tamamlanan")
                {
                    string etiket = Request.Form["etiket_tip"].ToString() + "-" + Request.Form["etiket"].ToString();

                    if (Request.Form["etiket_tip"].ToString() == "firma")
                    {
                        ayarlar.cmd.CommandText = "select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,2), 4 ) AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,  case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = @kullanici_id left join tanimlama_departman_listesi departman2 with(nolock) on (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  'departman-' + CONVERT(NVARCHAR(50), departman2.id) ) > 0 left join ucgem_proje_listesi proje on proje.proje_firma_id = @proje_firma_id where isler.durum = 'true' and isler.firma_id = @firma_id and((SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  @etiket ) > 0 or (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  'proje-' + CONVERT(NVARCHAR(50), departman2.id) ) > 0) and isler.cop = 'false' and case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end = 'BİTTİ' order by(convert(datetime, isler.guncelleme_tarihi) +convert(datetime, isler.guncelleme_saati)) desc;";

                        ayarlar.cmd.Parameters.Add("proje_firma_id", Request.Form["etiket"].ToString());
                    }
                    else
                    {

                        ayarlar.cmd.CommandText = "select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,2), 4 ) AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,  case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = @kullanici_id left join tanimlama_departman_listesi departman2 with(nolock) on (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  'departman-' + CONVERT(NVARCHAR(50), departman2.id) ) > 0 where isler.durum = 'true' and isler.firma_id = @firma_id and (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  @etiket ) > 0 and isler.cop = 'false' and case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end = 'BİTTİ' order by (convert(datetime, isler.guncelleme_tarihi) + convert(datetime, isler.guncelleme_saati)) desc;";
                    }

                    ayarlar.cmd.Parameters.Add("etiket", etiket);
                }
                else if (tip == "santiye")
                {
                    string proje_id = "proje" + "-" + Request.Form["proje_id"].ToString();
                    string departman_id = "departman" + "-" + Request.Form["departman_id"].ToString();

                    ayarlar.cmd.CommandText = "select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,2), 4 ) AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,  case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = isler.ekleyen_id  where isler.durum = 'true' and isler.firma_id = @firma_id and ((SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =   @proje_id ) > 0 and (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =   @departman_id ) > 0)  and isler.cop = 'false' and (case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end != 'BİTTİ' and case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end ! = 'İPTAL') order by (convert(datetime, isler.guncelleme_tarihi) + convert(datetime, isler.guncelleme_saati)) desc;";

                    ayarlar.cmd.Parameters.Add("proje_id", proje_id);
                    ayarlar.cmd.Parameters.Add("departman_id", departman_id);
                }
                else if (tip == "arama")
                {
                    string adi = UIHelper.trn(Request.Form["adi"].ToString());
                    string is_durum = UIHelper.trn(Request.Form["is_durum"].ToString());
                    string gorevliler = UIHelper.trn(Request.Form["gorevliler"].ToString());
                    string firmalar = UIHelper.trn(Request.Form["firmalar"].ToString());
                    string santiyeler = UIHelper.trn(Request.Form["santiyeler"].ToString());
                    string departmanlar = UIHelper.trn(Request.Form["departmanlar"].ToString());
                    string baslangic_tarihi = UIHelper.trn(Request.Form["baslangic_tarihi"].ToString());
                    string bitis_tarihi = UIHelper.trn(Request.Form["bitis_tarihi"].ToString());
                    string is_baslangic_tarihi = UIHelper.trn(Request.Form["is_baslangic_tarihi"].ToString());
                    string is_bitis_tarihi = UIHelper.trn(Request.Form["is_bitis_tarihi"].ToString());
                    string toplantilar = "";
                    string parcalar = "";

                    try
                    {
                        parcalar = UIHelper.trn(Request.Form["parcalar"].ToString());
                    }
                    catch (Exception)
                    {

                    }

                    try
                    {
                        toplantilar = UIHelper.trn(Request.Form["toplantilar"].ToString());
                    }
                    catch (Exception)
                    {

                    }

                    string sql_str1 = "";
                    string sql_str2 = "";

                    if (adi != "")
                    {
                        sql_str2 = " and isler.adi like '%" + adi + "%'";
                    }


                    // burda yapılacak
                    if (is_baslangic_tarihi.Length > 0 && is_bitis_tarihi.Length > 0)
                    {
                        sql_str2 += " and isler.baslangic_tarihi between '" + is_baslangic_tarihi + "' and '" + is_bitis_tarihi + "' and isler.bitis_tarihi between '" + is_baslangic_tarihi + "' and '" + is_bitis_tarihi + "'";
                    }
                    else if (is_baslangic_tarihi.Length > 0)
                    {
                        sql_str2 += " and '" + is_baslangic_tarihi + "' between isler.baslangic_tarihi and isler.bitis_tarihi";
                    }
                    else if (is_bitis_tarihi.Length > 0)
                    {
                        sql_str2 += " and '" + is_bitis_tarihi + "' between isler.baslangic_tarihi and isler.bitis_tarihi";
                    }



                    if (baslangic_tarihi.Length > 0 && bitis_tarihi.Length > 0)
                    {
                        sql_str2 += " and isler.ekleme_tarihi between '" + baslangic_tarihi + "' and '" + bitis_tarihi + "'";
                    }
                    else if (baslangic_tarihi.Length > 0)
                    {
                        sql_str2 += " and isler.ekleme_tarihi >= '" + baslangic_tarihi + "'";
                    }
                    else if (bitis_tarihi.Length > 0)
                    {
                        sql_str2 += " and isler.ekleme_tarihi <= '" + bitis_tarihi + "'";
                    }
                    if (parcalar.Length > 0)
                    {
                        sql_str2 += " and isler.id in (select IsID from is_parca_listesi where ParcaId = '" + parcalar + "' and cop = 'false')";
                    }
                    if (departmanlar != "0")
                    {
                        sql_str2 += " and (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value = 'departman-" + departmanlar + "') > 0";
                    }
                    if (santiyeler != "0")
                    {
                        sql_str2 += " and (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value = 'proje-" + santiyeler + "') > 0";
                    }
                    if (toplantilar != "")
                    {
                        sql_str2 += " and (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value = 'toplanti-" + toplantilar + "') > 0";
                    }
                    if (gorevliler != "0")
                    {
                        sql_str2 += " and (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = '" + gorevliler + "') > 0";
                    }
                    if (firmalar != "0")
                    {
                        sql_str1 = "left join ucgem_proje_listesi proje on proje.proje_firma_id = '" + firmalar + "'";

                        sql_str2 += " and((SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  'firma-" + firmalar + "') > 0 or (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  'proje-' + CONVERT(NVARCHAR(50), departman2.id) ) > 0)";
                    }
                    if (is_durum == "0")
                    {
                        sql_str2 += " and isler.durum = 'true'";
                    }
                    else
                    {
                        sql_str2 += " and case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end = '" + is_durum + "'";
                    }

                    if (stok != "Stok")
                    {
                        ayarlar.cmd.CommandText = "select ISNULL((SELECT TOP 1 SUBSTRING( f.firma_adi, 1, 3)FROM ucgem_firma_listesi f ),'') + SUBSTRING(CONVERT(NVARCHAR(10), DATEPART(year, isler.ekleme_tarihi)),3,2) + RIGHT('0'+CONVERT(NVARCHAR(10), DATEPART(MONTH, isler.ekleme_tarihi)), 2) + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), isler.id),1,2), 4 )  AS is_kodu, isnull(isler.renk, '') as renk, Replace(Replace( STUFF(((select '~<span class=\"hiddenspan\">' + replace(replace(etiket.adi, '(', ''), ')','') + '</span>' from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, ''), '&lt;', '<'), '&gt;', '>') hidden_etiketler,  case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum, (select CONVERT(nvarchar(50), kullanici.id) + '~' + isnull(kullanici.personel_resim,'') + '~' + isnull(kullanici.personel_ad,'') + ' ' + isnull(kullanici.personel_soyad,'') + '|' from ucgem_firma_kullanici_listesi kullanici with(nolock) where (SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50), kullanici.id) ) > 0 for xml path('')) as gorevli_personeller, STUFF(((select '~' + etiket.adi from etiketler etiket with(nolock) where CHARINDEX(',' + isnull(etiket.sorgu, '') + ',', ',' + isnull(isler.departmanlar, '') + ',')>0 for xml path(''))), 1, 1, '') as departman_isimleri, ekleyen.personel_ad + ' ' + ekleyen.personel_soyad as ekleyen_adsoyad, isler.* from ucgem_is_listesi isler with(nolock) join ucgem_firma_kullanici_listesi ekleyen with(nolock) on ekleyen.id = isler.ekleyen_id join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = @kullanici_id " + sql_str1 + " left join tanimlama_departman_listesi departman2 with(nolock) on (SELECT COUNT(value) FROM STRING_SPLIT(isler.departmanlar, ',') WHERE value =  'departman-' + CONVERT(NVARCHAR(50), departman2.id) ) > 0 where isler.firma_id = @firma_id " + sql_str2 + " and isler.cop = 'false' and ( ((SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = CONVERT(NVARCHAR(50),@kullanici_id) ) > 0) or isler.ekleyen_id = @kullanici_id or ((SELECT COUNT(value) FROM STRING_SPLIT(kullanici.departmanlar, ',') WHERE value = CONVERT(NVARCHAR(50),departman2.id) ) > 0) ) order by (convert(datetime, isler.guncelleme_tarihi) +convert(datetime, isler.guncelleme_saati)) desc;";
                    }
                }
            }
            else
            {
                //ayarlar.cmd.Parameters.Add("departmanlar", SessionManager.CurrentUser.departmanlar);
            }

            ayarlar.cmd.CommandText += "; select '.tablo_' + REPLACE(is_tablo_gorunum, ', ', ', .tablo_') as is_tablo_gorunum, isnull(is_tablo_sayi,10) as is_tablo_sayi from ucgem_firma_kullanici_listesi where id = @kullanici_id;";
            ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
            ayarlar.cmd.Parameters.Add("kullanici_id", SessionManager.CurrentUser.kullanici_id);
            SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);


            DataRow drow_tablo = ds.Tables[1].Rows[0];
            string style_class = drow_tablo["is_tablo_gorunum"].ToString();
            string is_tablo_sayi = drow_tablo["is_tablo_sayi"].ToString();

            /*
            string style_class = ".tablo_gorevliler , .tablo_etiketler , .tablo_baslangic , .tablo_bitis , .tablo_tamamlanma , .tablo_guncelleme , .tablo_ekleyen , .tablo_durum , .tablo_oncelik";
            string is_tablo_sayi = "100";*/


            Response.Write("<div id='yeni_style_yeri'><style> .tablo_gorevliler , .tablo_etiketler, .tablo_baslangic , .tablo_bitis , .tablo_tamamlanma , .tablo_guncelleme , .tablo_ekleyen , .tablo_durum , .tablo_oncelik{ display:none; } " + style_class + "{ display:table-cell!important; } </style><div class='clear'></div></div>");

            tablo_customize.SelectionMode = ListSelectionMode.Multiple;
            tablo_customize.Attributes.Add("is_tablo_sayi", is_tablo_sayi);

            gorunum gorunum = new gorunum();
            gorunum.tablo_gorevliler = false;
            gorunum.tablo_etiketler = false;
            gorunum.tablo_baslangic = false;
            gorunum.tablo_bitis = false;
            gorunum.tablo_tamamlanma = false;
            gorunum.tablo_guncelleme = false;
            gorunum.tablo_ekleyen = false;
            gorunum.tablo_durum = false;
            gorunum.tablo_oncelik = false;



            bool selected_durum = false;
            if (style_class.IndexOf("gorevliler") > 0)
            {
                selected_durum = true;
                gorunum.tablo_gorevliler = true;
            }
            tablo_customize.Items.Add(new ListItem() { Text = "Görevliler", Value = "gorevliler", Selected = selected_durum });
            selected_durum = false;
            if (style_class.IndexOf("etiketler") > 0)
            {
                selected_durum = true;
                gorunum.tablo_etiketler = true;
            }
            tablo_customize.Items.Add(new ListItem() { Text = "Etiketler", Value = "etiketler", Selected = selected_durum });
            selected_durum = false;
            if (style_class.IndexOf("baslangic") > 0)
            {
                selected_durum = true;
                gorunum.tablo_baslangic = true;
            }
            tablo_customize.Items.Add(new ListItem() { Text = "İş Başlangıç", Value = "baslangic", Selected = selected_durum });
            selected_durum = false;
            if (style_class.IndexOf("bitis") > 0)
            {
                selected_durum = true;
                gorunum.tablo_bitis = true;
            }
            tablo_customize.Items.Add(new ListItem() { Text = "Planlanan Bitiş", Value = "bitis", Selected = selected_durum });
            selected_durum = false;
            if (style_class.IndexOf("tamamlanma") > 0)
            {
                selected_durum = true;
                gorunum.tablo_tamamlanma = true;
            }
            tablo_customize.Items.Add(new ListItem() { Text = "Tamamlanma Durumu", Value = "tamamlanma", Selected = selected_durum });
            selected_durum = false;
            if (style_class.IndexOf("guncelleme") > 0)
            {
                selected_durum = true;
                gorunum.tablo_guncelleme = true;
            }
            tablo_customize.Items.Add(new ListItem() { Text = "Güncelleme", Value = "guncelleme", Selected = selected_durum });
            selected_durum = false;
            if (style_class.IndexOf("ekleyen") > 0)
            {
                selected_durum = true;
                gorunum.tablo_ekleyen = true;
            }
            tablo_customize.Items.Add(new ListItem() { Text = "Ekleyen", Value = "ekleyen", Selected = selected_durum });
            selected_durum = false;
            if (style_class.IndexOf("durum") > 0)
            {
                selected_durum = true;
                gorunum.tablo_durum = true;
            }
            tablo_customize.Items.Add(new ListItem() { Text = "Durum", Value = "durum", Selected = selected_durum });
            selected_durum = false;
            if (style_class.IndexOf("oncelik") > 0)
            {
                selected_durum = true;
                gorunum.tablo_oncelik = true;
            }
            tablo_customize.Items.Add(new ListItem() { Text = "Öncelik", Value = "oncelik", Selected = selected_durum });
            tablo_customize.CssClass = "yapilan";


            List<is_gorunum> isler = new List<is_gorunum>();
            if (ds.Tables[0].Rows.Count == 0)
                isler_is_yok_panel.Visible = true;
            else
                isler_isvar_panel.Visible = true;




            foreach (DataRow item in ds.Tables[0].Rows)
            {

                is_gorunum yeniis = new is_gorunum();
                yeniis.id = Convert.ToInt32(item["id"]);
                ayarlar.cmd.CommandText = "with cte as ( SELECT case when(select COUNT(id) from ucgem_is_calisma_listesi WHERE is_id = " + yeniis.id + " and ekleyen_id = gorevli.gorevli_id ) = 0 then '00:00' else dbo.DakikadanSaatYap((SELECT ISNULL(SUM((DATEDIFF(n, CONVERT(DATETIME, calisma.baslangic), CONVERT(DATETIME, calisma.bitis)))), 0) FROM dbo.ucgem_is_calisma_listesi calisma WITH(NOLOCK) WHERE calisma.is_id = gorevli.is_id and calisma.ekleyen_id = gorevli.gorevli_id AND calisma.durum = 'true' AND calisma.cop = 'false')) end AS harcanan, gorevli.toplam_sure, gorevli.tamamlanma_orani, gorevli.id FROM ucgem_is_gorevli_durumlari gorevli WITH(NOLOCK) JOIN ucgem_firma_kullanici_listesi kullanici WITH(NOLOCK) ON kullanici.id = gorevli.gorevli_id JOIN ucgem_is_listesi iss ON iss.id = gorevli.is_id WHERE gorevli.is_id = " + yeniis.id + " ) SELECT CASE WHEN(SUM(tamamlanma_orani) / COUNT(id)) = 100 THEN 100 WHEN CONVERT(decimal(15,2), (CONVERT(int, SUM(CONVERT(int, LEFT(harcanan, CHARINDEX(':', harcanan) - 1)) * 60 + CONVERT(int, RIGHT(harcanan, 2))))), 114) = 0 THEN 0 WHEN CONVERT(decimal(15,2), CONVERT(int, SUM(CONVERT(int, LEFT(toplam_sure, CHARINDEX(':', toplam_sure) - 1)) * 60 + CONVERT(int, RIGHT(toplam_sure, 2)))), 114) = 0 THEN 0 WHEN CONVERT(decimal(15,2), (CONVERT(int, SUM(CONVERT(int, LEFT(harcanan, CHARINDEX(':', harcanan) - 1)) * 60 + CONVERT(int, RIGHT(harcanan, 2))))), 114) > CONVERT(decimal(15, 2), SUM(CONVERT(int, LEFT(toplam_sure, CHARINDEX(':', toplam_sure) - 1)) * 60 + CONVERT(int, RIGHT(toplam_sure, 2))), 114) THEN 90 WHEN CONVERT(int, (SUM(tamamlanma_orani) / COUNT(id))) > 50 AND CONVERT(int, (SUM(tamamlanma_orani) / COUNT(id))) < 100 THEN CONVERT(decimal(15,2), (CONVERT(int, SUM(CONVERT(int, LEFT(harcanan, CHARINDEX(':', harcanan) - 1)) * 60 + CONVERT(int, RIGHT(harcanan, 2))), 114)) / CONVERT(decimal(15, 2), SUM(CONVERT(int, LEFT(toplam_sure, CHARINDEX(':', toplam_sure) - 1)) * 60 + CONVERT(int, RIGHT(toplam_sure, 2))), 114)) * 100 ELSE CONVERT(decimal(15,2), (CONVERT(int, SUM(CONVERT(int, LEFT(harcanan, CHARINDEX(':', harcanan) - 1)) * 60 + CONVERT(int, RIGHT(harcanan, 2))), 114) / CONVERT(decimal(15, 2), SUM(CONVERT(int, LEFT(toplam_sure, CHARINDEX(':', toplam_sure) - 1)) * 60 + CONVERT(int, RIGHT(toplam_sure, 2))), 114)) * 100) END as ortalama from cte";
                SqlDataAdapter dataReader = new SqlDataAdapter(ayarlar.cmd);
                DataSet dataSet = new DataSet();
                dataReader.Fill(dataSet);

                foreach (DataRow oran in dataSet.Tables[0].Rows)
                {
                    yeniis.tamamlanma_orani = Convert.ToInt32(oran["ortalama"]);
                }

                yeniis.is_kodu = item["is_kodu"].ToString();
                yeniis.adi = item["adi"].ToString();
                if (item["aciklama"].ToString().Length > 150)
                    yeniis.aciklama = item["aciklama"].ToString().Substring(0, 150) + "...";
                else
                    yeniis.aciklama = item["aciklama"].ToString();
                string hidden_etiketler = item["hidden_etiketler"].ToString().Replace("~", "");
                yeniis.hidden_etiketler = hidden_etiketler;
                yeniis.departman_isimleri = item["departman_isimleri"].ToString().Replace("~", "<br>");

                yeniis.baslangic_tarihi = Convert.ToDateTime(item["baslangic_tarihi"]).ToShortDateString();
                yeniis.baslangic_tarihi_order = DateTime.Parse(Convert.ToDateTime(item["baslangic_tarihi"]).ToShortDateString() + " " + item["baslangic_saati"].ToString()).Ticks;
                yeniis.baslangic_saati = item["baslangic_saati"].ToString().Substring(0, 5);
                yeniis.bitis_tarihi = Convert.ToDateTime(item["bitis_tarihi"]).ToShortDateString();
                yeniis.bitis_tarihi_order = DateTime.Parse(Convert.ToDateTime(item["bitis_tarihi"]).ToShortDateString() + " " + item["bitis_saati"].ToString()).Ticks;
                yeniis.bitis_saati = item["bitis_saati"].ToString().Substring(0, 5);
                yeniis.oncelik = item["oncelik"].ToString().ToUpper();
                yeniis.ekleyen_adsoyad = item["ekleyen_adsoyad"].ToString();
                yeniis.ekleme_tarihi = Convert.ToDateTime(item["ekleme_tarihi"]).ToShortDateString();
                yeniis.ekleme_tarihi_order = DateTime.Parse(Convert.ToDateTime(item["ekleme_tarihi"]).ToShortDateString() + " " + item["ekleme_saati"].ToString()).Ticks;
                yeniis.ekleme_saati = item["ekleme_saati"].ToString().Substring(0, 5);
                yeniis.guncelleme_tarihi = Convert.ToDateTime(item["guncelleme_tarihi"]).ToShortDateString();
                yeniis.guncelleme_tarihi_order = 999925216000000000 - DateTime.Parse(Convert.ToDateTime(item["guncelleme_tarihi"]).ToShortDateString() + " " + item["guncelleme_saati"].ToString()).Ticks; ;
                yeniis.guncelleme_saati = item["guncelleme_saati"].ToString().Substring(0, 5);
                yeniis.guncelleyen = item["guncelleyen"].ToString();
                yeniis.renk = item["renk"].ToString();


                if (item["oncelik"].ToString() == "Normal")
                {
                    yeniis.oncelik_class = "info";
                }
                else if (item["oncelik"].ToString() == "Yüksek")
                {
                    yeniis.oncelik_class = "danger";
                }
                else
                {
                    yeniis.oncelik_class = "warning";
                }


                if (item["is_durum"].ToString() == "IPTAL")
                {
                    yeniis.is_durum = "İPTAL";
                    yeniis.is_durum_class = "inverse";
                }
                else if (item["is_durum"].ToString() == "GECIKTI")
                {
                    yeniis.is_durum = "GECİKTİ";
                    yeniis.is_durum_class = "danger";
                }
                else if (item["is_durum"].ToString() == "BEKLIYOR")
                {
                    yeniis.is_durum = "BEKLİYOR";
                    yeniis.is_durum_class = "warning";
                }
                else if (item["is_durum"].ToString() == "DEVAM EDIYOR")
                {
                    yeniis.is_durum = "DEVAM EDİYOR";
                    yeniis.is_durum_class = "info";
                }
                else if (item["is_durum"].ToString() == "BITTI")
                {
                    string gecikme = "";
                    if (control == true)
                    {
                        if (item["geciktimi"].ToString() == "GECIKTI")
                        {
                            gecikme = " <i class='fa fa-warning faa-flash animated text-danger' title='GECİKTİRİLMİŞ' style='font-size:20px; margin-left:5px; margin-right:-40px; margin-bottom: 5px;'></i>";
                        }
                    }
                    else { }
                    yeniis.is_durum = "BİTTİ" + gecikme;
                    yeniis.is_durum_class = "success";

                    if (item["tamamlanma_tarihi"].ToString() != "" && item["tamamlanma_saati"].ToString() != "")
                    {
                        yeniis.tamamlanma_tarihi = Convert.ToDateTime(item["tamamlanma_tarihi"]).ToShortDateString();
                        yeniis.tamamlanma_saati = item["tamamlanma_saati"].ToString().Substring(0, 5);
                    }
                }

                List<gorevli> gorevliler = new List<gorevli>();

                foreach (string gorevli in item["gorevli_personeller"].ToString().Split('|'))
                {
                    if (gorevli.Length > 5)
                    {
                        gorevli gorev = new gorevli();
                        gorev.id = Convert.ToInt32(gorevli.Split('~')[0]);
                        gorev.adi = gorevli.Split('~')[2];
                        gorev.resim = gorevli.Split('~')[1];
                        gorevliler.Add(gorev);
                    }
                }
                yeniis.gorevliler = gorevliler;
                yeniis.tablo_baslangic = gorunum.tablo_baslangic.Equals(false) ? " gosterme " : "";
                yeniis.tablo_bitis = gorunum.tablo_bitis.Equals(false) ? " gosterme " : "";
                yeniis.tablo_durum = gorunum.tablo_durum.Equals(false) ? " gosterme " : "";
                yeniis.tablo_ekleyen = gorunum.tablo_ekleyen.Equals(false) ? " gosterme " : "";
                yeniis.tablo_etiketler = gorunum.tablo_etiketler.Equals(false) ? " gosterme " : "";
                yeniis.tablo_gorevliler = gorunum.tablo_gorevliler.Equals(false) ? " gosterme " : "";
                yeniis.tablo_guncelleme = gorunum.tablo_guncelleme.Equals(false) ? " gosterme " : "";
                yeniis.tablo_oncelik = gorunum.tablo_oncelik.Equals(false) ? " gosterme " : "";
                yeniis.tablo_tamamlanma = gorunum.tablo_tamamlanma.Equals(false) ? " gosterme " : "";
                isler.Add(yeniis);
            }

            isler_repeater.DataSource = isler;
            isler_repeater.ItemCreated += isler_repeater_ItemCreated;
            isler_repeater.DataBind();

            ayarlar.cnn.Close();
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }

    public class gorunum
    {
        public bool tablo_gorevliler { get; set; }
        public bool tablo_etiketler { get; set; }
        public bool tablo_baslangic { get; set; }
        public bool tablo_bitis { get; set; }
        public bool tablo_tamamlanma { get; set; }
        public bool tablo_guncelleme { get; set; }
        public bool tablo_ekleyen { get; set; }
        public bool tablo_durum { get; set; }
        public bool tablo_oncelik { get; set; }
    }

    public gorunum gorunum_al()
    {
        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select 'tablo_' + REPLACE(is_tablo_gorunum, ', ', ', .tablo_') as is_tablo_gorunum from ucgem_firma_kullanici_listesi where id = @kullanici_id;";
        ayarlar.cmd.Parameters.Add("kullanici_id", SessionManager.CurrentUser.kullanici_id);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        gorunum gorunum = new gorunum();
        gorunum.tablo_gorevliler = false;
        gorunum.tablo_etiketler = false;
        gorunum.tablo_baslangic = false;
        gorunum.tablo_bitis = false;
        gorunum.tablo_tamamlanma = false;
        gorunum.tablo_guncelleme = false;
        gorunum.tablo_ekleyen = false;
        gorunum.tablo_durum = false;
        gorunum.tablo_oncelik = false;

        DataRow drow_tablo = ds.Tables[0].Rows[0];
        string style_class = drow_tablo["is_tablo_gorunum"].ToString();

        bool selected_durum = false;

        if (style_class.IndexOf("gorevliler") > 0)
        {
            gorunum.tablo_gorevliler = true;
        }
        if (style_class.IndexOf("etiketler") > 0)
        {
            gorunum.tablo_etiketler = true;
        }
        if (style_class.IndexOf("baslangic") > 0)
        {
            gorunum.tablo_baslangic = true;
        }
        if (style_class.IndexOf("bitis") > 0)
        {
            gorunum.tablo_bitis = true;
        }
        if (style_class.IndexOf("tamamlanma") > 0)
        {
            gorunum.tablo_tamamlanma = true;
        }
        if (style_class.IndexOf("guncelleme") > 0)
        {
            gorunum.tablo_guncelleme = true;
        }
        if (style_class.IndexOf("ekleyen") > 0)
        {
            gorunum.tablo_ekleyen = true;
        }
        if (style_class.IndexOf("durum") > 0)
        {
            gorunum.tablo_durum = true;
        }
        if (style_class.IndexOf("oncelik") > 0)
        {
            gorunum.tablo_oncelik = true;
        }
        return gorunum;
    }

    private static string tablo_style_cek()
    {
        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select '.tablo_' + REPLACE(is_tablo_gorunum, ', ', ', .tablo_') as is_tablo_gorunum from ucgem_firma_kullanici_listesi where id = @kullanici_id;";
        ayarlar.cmd.Parameters.Add("kullanici_id", SessionManager.CurrentUser.kullanici_id);
        string style_class = ayarlar.cmd.ExecuteScalar().ToString();

        ayarlar.cnn.Close();

        return style_class;
    }

    private void isler_repeater_ItemCreated(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            is_gorunum gorevli = (is_gorunum)e.Item.DataItem;

            Panel bitis_tarih_yeri = e.Item.FindControl("bitis_tarih_yeri") as Panel;
            //bitis_tarih_yeri.Visible = gorevli.is_durum.Equals("Bitti") ? true : false;

            Repeater gorevli_repeater = e.Item.FindControl("gorevli_repeater") as Repeater;
            gorevli_repeater.DataSource = gorevli.gorevliler;
            gorevli_repeater.DataBind();
        }
    }

    public class is_gorunum
    {
        public int id { get; set; }
        public string hidden_etiketler { get; set; }
        public string adi { get; set; }
        public string aciklama { get; set; }
        public string departman_isimleri { get; set; }
        public int tamamlanma_orani { get; set; }
        public string baslangic_tarihi { get; set; }

        public long baslangic_tarihi_order { get; set; }
        public string bitis_tarihi { get; set; }
        public long bitis_tarihi_order { get; set; }
        public string baslangic_saati { get; set; }
        public string bitis_saati { get; set; }
        public string oncelik { get; set; }
        public string oncelik_class { get; set; }
        public string ekleyen_adsoyad { get; set; }
        public string ekleme_tarihi { get; set; }
        public long ekleme_tarihi_order { get; set; }
        public string ekleme_saati { get; set; }
        public string is_durum { get; set; }
        public string is_durum_class { get; set; }
        public string tamamlanma_tarihi { get; set; }
        public string tamamlanma_saati { get; set; }
        public string guncelleme_tarihi { get; set; }
        public long guncelleme_tarihi_order { get; set; }
        public string guncelleme_saati { get; set; }
        public string guncelleyen { get; set; }
        public List<gorevli> gorevliler { get; set; }
        public string renk { get; set; }
        public string tablo_gorevliler { get; set; }
        public string tablo_etiketler { get; set; }
        public string tablo_baslangic { get; set; }
        public string tablo_bitis { get; set; }
        public string tablo_tamamlanma { get; set; }
        public string tablo_guncelleme { get; set; }
        public string tablo_ekleyen { get; set; }
        public string tablo_durum { get; set; }
        public string tablo_oncelik { get; set; }
        public string is_kodu { get; set; }
    }

    public class gorevli
    {
        public int id { get; set; }
        public string resim { get; set; }
        public string adi { get; set; }
    }


    [WebMethod(EnableSession = true)]
    public static string is_tablo_sayi_guncelle(int is_tablo_sayi)
    {
        string durum = "true";
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "update ucgem_firma_kullanici_listesi set is_tablo_sayi = @is_tablo_sayi where id = @kullanici_id;";
            ayarlar.cmd.Parameters.Add("is_tablo_sayi", is_tablo_sayi);
            ayarlar.cmd.Parameters.Add("kullanici_id", SessionManager.CurrentUser.kullanici_id);
            ayarlar.cmd.ExecuteNonQuery();
        }
        catch (Exception e)
        {
            durum = "false";
            HataLogTut(e);
        }
        ayarlar.cnn.Close();
        return durum;
    }

    [WebMethod(EnableSession = true)]
    public static string OlayEkle(int proje_id, int departman_id, string olay, string olay_tarihi, string olay_saati)
    {
        if (olay_tarihi.Length != 10)
        {
            olay_tarihi = DateTime.Today.ToShortDateString();
        }

        if (olay_saati.Length != 5)
        {
            olay_saati = DateTime.Now.ToShortTimeString() + ":00";
        }

        string durum = "true";
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "insert into ucgem_proje_olay_listesi(proje_id, olay, olay_tarihi, olay_saati, departman_id, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values(@proje_id, @olay, CONVERT(date, @olay_tarihi,103), @olay_saati, @departman_id, @durum, @cop, @firma_kodu, @firma_id, @ekleyen_id, @ekleyen_ip, @ekleme_tarihi, @ekleme_saati); update ucgem_proje_listesi set guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen_id = @guncelleyen_id where id = @proje_id;";
            ayarlar.cmd.Parameters.Add("guncelleyen_id", SessionManager.CurrentUser.ekleyen_id);
            ayarlar.cmd.Parameters.Add("proje_id", proje_id);
            ayarlar.cmd.Parameters.Add("olay", UIHelper.trn(olay));
            ayarlar.cmd.Parameters.Add("olay_tarihi", olay_tarihi);
            ayarlar.cmd.Parameters.Add("olay_saati", olay_saati);
            ayarlar.cmd.Parameters.Add("departman_id", departman_id);
            ayarlar.cmd.Parameters.Add("durum", "true");
            ayarlar.cmd.Parameters.Add("cop", "false");
            ayarlar.cmd.Parameters.Add("firma_kodu", SessionManager.CurrentUser.firma_kodu);
            ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
            ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.ekleyen_id);
            ayarlar.cmd.Parameters.Add("ekleyen_ip", HttpContext.Current.Request.ServerVariables["Remote_Addr"]);
            ayarlar.cmd.Parameters.Add("ekleme_tarihi", DateTime.Now);
            ayarlar.cmd.Parameters.Add("ekleme_saati", DateTime.Now);
            ayarlar.cmd.ExecuteNonQuery();
        }
        catch (Exception e)
        {
            durum = "false";

            HataLogTut(e);
        }
        ayarlar.cnn.Close();
        return durum;
    }

    [WebMethod(EnableSession = true)]
    public static string OlaySil(int olay_id)
    {
        string durum = "true";
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "delete from ucgem_proje_olay_listesi where id = @olay_id;";
            ayarlar.cmd.Parameters.Add("olay_id", olay_id);
            ayarlar.cmd.ExecuteNonQuery();

        }
        catch (Exception e)
        {
            durum = "false";
            HataLogTut(e);
        }

        ayarlar.cnn.Close();

        return durum;
    }

    [WebMethod(EnableSession = true)]
    public static string OlayGuncelle(int olay_id, string olay, string olay_tarihi, string olay_saati)
    {

        if (olay_tarihi.Length != 10)
        {
            olay_tarihi = DateTime.Today.ToShortDateString();
        }

        if (olay_saati.Length != 5)
        {
            olay_saati = DateTime.Now.ToShortTimeString();
        }



        string durum = "true";
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "update ucgem_proje_olay_listesi set olay = @olay, olay_tarihi = @olay_tarihi, olay_saati = @olay_saati where id = @olay_id;";
            ayarlar.cmd.Parameters.Add("olay", UIHelper.trn(olay));
            ayarlar.cmd.Parameters.Add("olay_tarihi", olay_tarihi);
            ayarlar.cmd.Parameters.Add("olay_saati", olay_saati);
            ayarlar.cmd.Parameters.Add("olay_id", olay_id);
            ayarlar.cmd.ExecuteNonQuery();

        }
        catch (Exception e)
        {
            durum = "false";
            HataLogTut(e);
        }

        ayarlar.cnn.Close();

        return durum;
    }

    [WebMethod(EnableSession = true)]
    public static string ProjeGuncelle(int proje_id, int firma_id, int santiye_durum_id, string proje_adi, string enlem, string boylam, int firma_supervisor_id, string proje_departmanlari)
    {
        string durum = "true";
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "select (select top 1 id from tanimlama_departman_listesi departman where (SELECT COUNT(value) FROM STRING_SPLIT((select proje_departmanlari from ucgem_proje_listesi proje where id = 16), ',') WHERE value = CONVERT(NVARCHAR(50),departman.id) ) > 0 and departman.durum = 'true' and departman.cop = 'false' order by departman.sirano asc) as departman_id, durum.durum_adi, durum2.durum_adi as durum_adi2, santiye_durum_id from ucgem_proje_listesi proje join tanimlama_santiye_durum_listesi durum on durum.id = proje.santiye_durum_id join tanimlama_santiye_durum_listesi durum2 on durum2.id = @santiye_durum_id where proje.id = @proje_id;";
            ayarlar.cmd.Parameters.Add("proje_id", proje_id);
            ayarlar.cmd.Parameters.Add("santiye_durum_id", santiye_durum_id);
            SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow drow = ds.Tables[0].Rows[0];
                if (Convert.ToInt32(drow["santiye_durum_id"]) != santiye_durum_id)
                {
                    ayarlar.baglan();
                    ayarlar.cmd.Parameters.Clear();
                    ayarlar.cmd.CommandText = "insert into ucgem_proje_olay_listesi(proje_id, olay, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, departman_id, olay_saati, olay_tarihi) values(@proje_id, @olay, @durum, @cop, @firma_kodu, @firma_id, @ekleyen_id, @ekleyen_ip, getdate(), getdate(), @departman_id, getdate(), getdate())";
                    ayarlar.cmd.Parameters.Add("proje_id", proje_id);
                    ayarlar.cmd.Parameters.Add("olay", "'" + drow["durum_adi"].ToString() + "' kategorisinde olan proje '" + drow["durum_adi2"].ToString() + "' kategorisine alındı.");
                    ayarlar.cmd.Parameters.Add("durum", "true");
                    ayarlar.cmd.Parameters.Add("cop", "false");
                    ayarlar.cmd.Parameters.Add("firma_kodu", SessionManager.CurrentUser.firma_kodu);
                    ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
                    ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.kullanici_id);
                    ayarlar.cmd.Parameters.Add("ekleyen_ip", HttpContext.Current.Request.ServerVariables["Remote_Addr"].ToString());
                    ayarlar.cmd.Parameters.Add("departman_id", drow["departman_id"]);
                    ayarlar.cmd.ExecuteNonQuery();
                }
            }

            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "select proje_kodu from tanimlama_santiye_durum_listesi where cop = 'false' and id = @id";
            ayarlar.cmd.Parameters.AddWithValue("id", santiye_durum_id);
            bool proje_kodu_durum = Convert.ToBoolean(ayarlar.cmd.ExecuteScalar());

            string proje_kodu = "-";
            if (proje_kodu_durum == true)
            {
                ayarlar.baglan();
                ayarlar.cmd.Parameters.Clear();
                ayarlar.cmd.CommandText = "select proje_kodu from ucgem_proje_listesi where cop = 'false' and durum = 'true' and id = @id order by id desc";
                ayarlar.cmd.Parameters.AddWithValue("id", proje_id);
                proje_kodu = Convert.ToString(ayarlar.cmd.ExecuteScalar());

                if (proje_kodu == "-")
                {
                    ayarlar.baglan();
                    ayarlar.cmd.CommandText = "SELECT CASE WHEN ISNULL((select top 1 SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3) + '' + FORMAT(getdate(), 'MM') + '' + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), (select Count(*) from ucgem_proje_listesi where cop = 'false' and not proje_kodu = '-' and SUBSTRING(CONVERT(varchar(15), datepart(yy, ekleme_tarihi)), 3, 3) = SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3)) + 1), 1, 4), 4) from ucgem_proje_listesi proje where SUBSTRING(CONVERT(varchar(15), datepart(yy, ekleme_tarihi)), 3, 3) = SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3) and proje.durum = 'true' and proje.cop = 'false' and not proje.proje_kodu = '-' order by id desc), 0) = 0 THEN(select SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3) + '' + FORMAT(getdate(), 'MM') + '' + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), 0 + 1), 1, 4), 4)) WHEN ISNULL((select top 1 SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3) + '' + FORMAT(getdate(), 'MM') + '' + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), (select Count(*) from ucgem_proje_listesi where cop = 'false' and not proje_kodu = '-' and SUBSTRING(CONVERT(varchar(15), datepart(yy, ekleme_tarihi)), 3, 3) = SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3)) + 1), 1, 4), 4) from ucgem_proje_listesi proje where SUBSTRING(CONVERT(varchar(15), datepart(yy, ekleme_tarihi)), 3, 3) = SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3) and proje.durum = 'true' and proje.cop = 'false' and not proje.proje_kodu = '-' order by id desc), 0) != 0 THEN(select top 1 SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3) + '' + FORMAT(getdate(), 'MM') + '' + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), (select Count(*) from ucgem_proje_listesi where cop = 'false' and not proje_kodu = '-' and SUBSTRING(CONVERT(varchar(15), datepart(yy, ekleme_tarihi)), 3, 3) = SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3)) + 1), 1, 4), 4) from ucgem_proje_listesi proje where SUBSTRING(CONVERT(varchar(15), datepart(yy, ekleme_tarihi)), 3, 3) = SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3) and proje.durum = 'true' and proje.cop = 'false' and not proje.proje_kodu = '-' order by id desc) ELSE(select top 1 SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3) + '' + FORMAT(getdate(), 'MM') + '' + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), 0 + 1), 1, 4), 4) from ucgem_proje_listesi proje where SUBSTRING(CONVERT(varchar(15), datepart(yy, ekleme_tarihi)), 3, 3) = SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3) and proje.durum = 'true' and proje.cop = 'false' and not proje.proje_kodu = '-' order by id desc) END";
                    proje_kodu = Convert.ToString(ayarlar.cmd.ExecuteScalar()); 
                }
            }
            else
            {
                ayarlar.baglan();
                ayarlar.cmd.Parameters.Clear();
                ayarlar.cmd.CommandText = "select proje_kodu from ucgem_proje_listesi where cop = 'false' and durum = 'true' and id = @id order by id desc";
                ayarlar.cmd.Parameters.AddWithValue("id", proje_id);
                proje_kodu = Convert.ToString(ayarlar.cmd.ExecuteScalar());
            }

            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "update ucgem_proje_listesi set proje_firma_id = @proje_firma_id, santiye_durum_id = @santiye_durum_id, proje_adi = @proje_adi, enlem = @enlem, boylam = @boylam, supervisor_id = @supervisor_id, proje_departmanlari = @proje_departmanlari, proje_kodu = @proje_kodu where id = @proje_id;";
            ayarlar.cmd.Parameters.Add("proje_firma_id", firma_id);
            ayarlar.cmd.Parameters.Add("santiye_durum_id", santiye_durum_id);
            ayarlar.cmd.Parameters.Add("proje_adi", UIHelper.trn(proje_adi));
            ayarlar.cmd.Parameters.Add("enlem", enlem);
            ayarlar.cmd.Parameters.Add("boylam", boylam);
            ayarlar.cmd.Parameters.Add("supervisor_id", firma_supervisor_id);
            ayarlar.cmd.Parameters.Add("proje_id", proje_id);
            ayarlar.cmd.Parameters.Add("proje_departmanlari", proje_departmanlari);
            ayarlar.cmd.Parameters.Add("proje_kodu", proje_kodu);
            ayarlar.cmd.ExecuteNonQuery();

        }
        catch (Exception e)
        {
            durum = "false";
            HataLogTut(e);
        }
        ayarlar.cnn.Close();

        return durum;
    }

    [WebMethod(EnableSession = true)]
    public static string IsBildirimGuncelle(int IsID, string is_detay_kontrol_bildirim)
    {
        string durum = "true";
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "update ucgem_is_listesi set kontrol_bildirim = @is_detay_kontrol_bildirim, guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen = @guncelleyen where id = @IsID;";
            ayarlar.cmd.Parameters.Add("guncelleyen", SessionManager.CurrentUser.kullanici_adsoyad);
            ayarlar.cmd.Parameters.Add("IsID", IsID);
            ayarlar.cmd.Parameters.Add("is_detay_kontrol_bildirim", is_detay_kontrol_bildirim);
            ayarlar.cmd.ExecuteNonQuery();

        }
        catch (Exception e)
        {
            durum = "false";
            HataLogTut(e);
        }

        ayarlar.cnn.Close();

        return durum;
    }

    [WebMethod(EnableSession = true)]
    public static string IsPersonelDurt(int IsID, int PersonelID)
    {
        string durum = "true";

        try
        {
            string gorevliler = PersonelID.ToString();

            foreach (string gorevliID in UIHelper.trn(gorevliler).Split(','))
            {
                if (gorevliID.Length > 0)
                {
                    if (ayarlar.IsNumeric(gorevliID))
                    {
                        if (Convert.ToInt32(gorevliID) > 0)
                        {

                            ayarlar.baglan();


                            DataRow Personel = PersonelBilgileriGetir(gorevliID);

                            ayarlar.baglan();
                            ayarlar.cmd.Parameters.Clear();
                            ayarlar.cmd.CommandText = "select adi from ucgem_is_listesi where id = @IsID;";
                            ayarlar.cmd.Parameters.Add("IsID", IsID);
                            string yeni_adi = ayarlar.cmd.ExecuteScalar().ToString();

                            string adi = Personel["personel_adsoyad"].ToString();

                            if (Personel["PushUserKey"].ToString() != null)
                            {

                                if (yeni_adi.Length > 100)
                                {
                                    yeni_adi.ToString().Substring(0, 100);
                                }

                                ayarlar.baglan();
                                ayarlar.cmd.Parameters.Clear();
                                ayarlar.cmd.CommandText = "insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values(@bildirim, @tip, @click, @user_id, @okudumu, @durum, @cop, @firma_kodu, @firma_id, @ekleyen_id, @ekleyen_ip, getdate(), getdate())";
                                ayarlar.cmd.Parameters.Add("bildirim", SessionManager.CurrentUser.kullanici_adsoyad + " sizi '" + yeni_adi + "' adlı iş için Uyardı !.");
                                ayarlar.cmd.Parameters.Add("tip", "is_listesi");
                                ayarlar.cmd.Parameters.Add("click", "sayfagetir('/is_listesi/','jsid=4559&bildirim=true&bildirim_id=" + IsID + "');");
                                ayarlar.cmd.Parameters.Add("user_id", gorevliID);
                                ayarlar.cmd.Parameters.Add("okudumu", "False");
                                ayarlar.cmd.Parameters.Add("durum", "true");
                                ayarlar.cmd.Parameters.Add("cop", "false");
                                ayarlar.cmd.Parameters.Add("firma_kodu", SessionManager.CurrentUser.firma_kodu);
                                ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
                                ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.ekleyen_id);
                                ayarlar.cmd.Parameters.Add("ekleyen_ip", HttpContext.Current.Request.ServerVariables["Remote_Addr"]);
                                ayarlar.cmd.ExecuteNonQuery();

                                if (Personel["personel_telefon"].ToString().Length > 5)
                                {
                                    ayarlar.NetGSM_SMS(Personel["personel_telefon"].ToString(), SessionManager.CurrentUser.kullanici_adsoyad + " sizi '" + yeni_adi + "' adlı iş için Uyardı !.");
                                }

                                Exception except;
                                bool result = Pushover.SendNotification(ayarlar.PushOverAppKey, Personel["PushUserKey"].ToString(), "ÜÇGEM MEKANİK A.Ş ERP SYTEM", SessionManager.CurrentUser.kullanici_adsoyad + " sizi '" + yeni_adi + "' adlı iş için Uyardı !.", Priority.Normal, PushoverSound.DeviceDefault, String.Empty, "http://erp.ucgem.com", "http://erp.ucgem.com", 60, 3600, out except);
                            }

                        }
                    }
                }
            }
        }
        catch (Exception e)
        {
            durum = "false";
            HataLogTut(e);
        }
        return durum;
    }

    [WebMethod(EnableSession = true)]
    public static string IsiIptalEt(int IsID)
    {
        string durum = "true";
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            // ayarlar.cmd.CommandText = "update ucgem_is_listesi set durum = case when durum = 'true' then 'false' else 'true' end, guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen = @guncelleyen where id = @IsID; update ahtapot_ajanda_olay_listesi set cop = case when cop = 'true' then 'false' else 'true' end where IsID = @IsID";
            ayarlar.cmd.CommandText = "Exec dbo.IsiIptalEt @guncelleyen = @guncelleyen, @IsID = @IsID;";
            ayarlar.cmd.Parameters.Add("guncelleyen", SessionManager.CurrentUser.kullanici_adsoyad);
            ayarlar.cmd.Parameters.Add("IsID", IsID);
            ayarlar.cmd.ExecuteNonQuery();

            //ayarlar.baglan();
            //ayarlar.cmd.Parameters.Clear();
            //ayarlar.cmd.CommandText = "update satinalma_listesi set cop = 'true' where IsId = " + IsID + "";
            //ayarlar.cmd.ExecuteNonQuery();
        }
        catch (Exception e)
        {
            durum = "false";
            HataLogTut(e);
        }

        ayarlar.cnn.Close();

        return durum;
    }

    private static Int64 GetTime(DateTime st)
    {
        Int64 retval = 0;
        TimeSpan t = (DateTime.Now.ToUniversalTime() - st);
        retval = (Int64)(t.TotalMilliseconds + 0.5);
        return retval;
    }


    [WebMethod(EnableSession = true)]
    public static int IsDurumGuncelle(int TamamlanmaID, int tamamlanma_orani, int IsID)
    {
        int durum = 0;
        int count = 0;
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "update ucgem_is_gorevli_durumlari set tamamlanma_orani = @tamamlanma_orani, tamamlanma_tarihi = getdate(), tamamlanma_saati = getdate() where id = @ID";
            ayarlar.cmd.Parameters.Add("tamamlanma_orani", tamamlanma_orani);
            ayarlar.cmd.Parameters.Add("ID", TamamlanmaID);
            ayarlar.cmd.ExecuteNonQuery();


            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "select case when sum(tamamlanma_orani) = 0 then 0 else convert(int, sum(tamamlanma_orani) / count(id)) end as genel_durum from ucgem_is_gorevli_durumlari where is_id = @IsID;";
            ayarlar.cmd.Parameters.Add("IsID", IsID);
            int genel_durum = Convert.ToInt32(ayarlar.cmd.ExecuteScalar());

            DateTime simdi = DateTime.Today;
            string simdistring = Convert.ToString(GetTime(simdi));

            string iend_uygulama = simdistring;
            string end_tarih_uygulama = DateTime.Today.ToString("yyyy-MM-dd");
            string duration_uygulama = simdistring;

            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "update ucgem_is_listesi set tamamlanma_orani = @tamamlanma_orani, tamamlanma_tarihi = getdate(), tamamlanma_saati = getdate(), guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen = @guncelleyen where id = @IsID" +
                ";update ahtapot_proje_gantt_adimlari set progress = @tamamlanma_orani, iend_uygulama = @iend_uygulama, end_tarih_uygulama = @end_tarih_uygulama, duration_uygulama = DATEDIFF(day, start_tarih_uygulama, @end_tarih_uygulama)-1  where id = (select top 1 isnull(GantAdimID,0) from ucgem_is_listesi where id = @IsID);";
            ayarlar.cmd.Parameters.Add("guncelleyen", SessionManager.CurrentUser.kullanici_adsoyad);
            ayarlar.cmd.Parameters.Add("tamamlanma_orani", genel_durum);
            ayarlar.cmd.Parameters.Add("IsID", IsID);
            ayarlar.cmd.Parameters.Add("iend_uygulama", iend_uygulama);
            ayarlar.cmd.Parameters.Add("end_tarih_uygulama", end_tarih_uygulama);
            // ayarlar.cmd.Parameters.Add("duration_uygulama", duration_uygulama);
            ayarlar.cmd.ExecuteNonQuery();


            /*
                ayarlar.cmd.Parameters.Clear();
                ayarlar.cmd.CommandText = "update ahtapot_proje_gantt_adimlari set progress = @tamamlanma_orani where id = (select top 1 isnull(GantAdimID,0) from ucgem_is_listesi where id = @IsID);";
                ayarlar.cmd.Parameters.Add("tamamlanma_orani", genel_durum);
                ayarlar.cmd.Parameters.Add("IsID", IsID);
                ayarlar.cmd.ExecuteNonQuery();
            */


            if (genel_durum == 0)
            {
                durum = 1;
            }
            else
            {
                durum = genel_durum;
            }

            if (tamamlanma_orani == 100)
            {
                ayarlar.baglan();
                count += 1;
                ayarlar.cmd.Parameters.Clear();
                ayarlar.cmd.CommandText = "select * from ucgem_is_listesi where id = @IsID;";
                ayarlar.cmd.Parameters.Add("IsID", IsID);
                SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
                DataSet ds = new DataSet();
                sda.Fill(ds);

                DataRow iss = ds.Tables[0].Rows[0];

                if (Convert.ToInt32(iss["ekleyen_id"]) != SessionManager.CurrentUser.kullanici_id
                    //&& ("asd" + iss["kontrol_bildirim"].ToString() + "asd").ToString().IndexOf("SMS") > 0
                    )
                {
                    DataRow Personel = PersonelBilgileriGetir(iss["ekleyen_id"].ToString());

                    //string donen = ayarlar.DakikSMSMesajGonder(Personel["personel_telefon"].ToString(), SessionManager.CurrentUser.kullanici_adsoyad + " '" + iss["adi"] + "' adlı işi bitirdi.");


                    if (Personel["PushUserKey"].ToString() != null)
                    {
                        Exception except;
                        string yeni_adi = iss["adi"].ToString();

                        if (yeni_adi.Length > 100)
                        {
                            yeni_adi.ToString().Substring(0, 100);
                        }

                        if (count == 1)
                        {
                            ayarlar.baglan();
                            ayarlar.cmd.Parameters.Clear();
                            ayarlar.cmd.CommandText = "SELECT TOP 1 bildirim FROM ahtapot_bildirim_listesi ORDER BY ekleme_tarihi DESC; SET NOCOUNT ON;";
                            SqlDataAdapter sda_personel = new SqlDataAdapter(ayarlar.cmd);
                            DataSet ds_personel = new DataSet();
                            sda_personel.Fill(ds_personel);

                            DataRow data = ds_personel.Tables[0].Rows[0];
                            if (!string.Equals(data.ItemArray[0].ToString(), SessionManager.CurrentUser.kullanici_adsoyad + " '" + yeni_adi + "' adlı işi bitirdi."))
                            {
                                ayarlar.cmd.Parameters.Clear();
                                ayarlar.cmd.CommandText = "insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values(@bildirim, @tip, @click, @user_id, @okudumu, @durum, @cop, @firma_kodu, @firma_id, @ekleyen_id, @ekleyen_ip, getdate(), getdate()); SET NOCOUNT ON;";
                                ayarlar.cmd.Parameters.Add("bildirim", SessionManager.CurrentUser.kullanici_adsoyad + " '" + yeni_adi + "' adlı işi bitirdi.");
                                ayarlar.cmd.Parameters.Add("tip", "is_listesi");
                                //ayarlar.cmd.Parameters.Add("click", "sayfagetir('/is_listesi/','jsid=4559&bildirim=true&bildirim_id=" + IsID + "');");
                                ayarlar.cmd.Parameters.Add("click", "CokluIsYap('is_listesi', '0', 'biten', " + IsID + ");");
                                ayarlar.cmd.Parameters.Add("user_id", iss["ekleyen_id"].ToString());
                                ayarlar.cmd.Parameters.Add("okudumu", "False");
                                ayarlar.cmd.Parameters.Add("durum", "true");
                                ayarlar.cmd.Parameters.Add("cop", "false");
                                ayarlar.cmd.Parameters.Add("firma_kodu", SessionManager.CurrentUser.firma_kodu);
                                ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
                                ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.ekleyen_id);
                                ayarlar.cmd.Parameters.Add("ekleyen_ip", HttpContext.Current.Request.ServerVariables["Remote_Addr"]);
                                ayarlar.cmd.ExecuteNonQuery();
                            }

                        }

                        if (Personel["personel_telefon"].ToString().Length > 5)
                        {
                            ayarlar.NetGSM_SMS(Personel["personel_telefon"].ToString(), SessionManager.CurrentUser.kullanici_adsoyad + " '" + yeni_adi + "' adlı işi bitirdi.");
                        }

                        bool result = Pushover.SendNotification(ayarlar.PushOverAppKey, Personel["PushUserKey"].ToString(), "ÜÇGEM MEKANİK A.Ş ERP SYTEM", SessionManager.CurrentUser.kullanici_adsoyad + " '" + yeni_adi + "' adlı işi bitirdi.", Priority.Normal, PushoverSound.DeviceDefault, String.Empty, "http://erp.ucgem.com", "http://erp.ucgem.com", 60, 3600, out except);
                    }

                }

            }

        }
        catch (Exception e)
        {
            durum = 0;
            HataLogTut(e);
        }

        ayarlar.cnn.Close();
        return durum;
    }



    [WebMethod(EnableSession = true)]
    public static string IsGuncelle(int IsID, string adi, string aciklama, string gorevliler, string gorevliId, string departmanlar, string oncelik, string kontrol_bildirim, string baslangic_tarihi, string baslangic_saati, string bitis_tarihi, string bitis_saati, string renk, string ajanda_gosterim, string gunluk_sure, string toplam_sure, string toplam_gun, int sinirlama_varmi, string is_tipi)
    {
        string[] id = new string[gorevliId.Split(',').Length];
        for (int i = 0; i < gorevliId.Split(',').Length; i++)
        {
            foreach (var item in UIHelper.trn(gorevliId).Split(','))
            {
                id[i] = item;
            }
        }
        bool state = false;
        bool bildirim = false;
        string durum = "true";
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "update ucgem_is_listesi set is_tipi = @is_tipi, renk = @renk, ajanda_gosterim = @ajanda_gosterim, guncelleme_tarihi = getdate(), guncelleme_saati = getdate(), guncelleyen = @guncelleyen, adi = @adi, aciklama = @aciklama, gorevliler = @gorevliler, departmanlar = @departmanlar, oncelik = @oncelik, kontrol_bildirim = @kontrol_bildirim, baslangic_tarihi = @baslangic_tarihi, baslangic_saati = @baslangic_saati, bitis_tarihi = @bitis_tarihi, bitis_saati = @bitis_saati, gunluk_sure = @gunluk_sure, toplam_sure = @toplam_sure, toplam_gun = @toplam_gun where id = @IsID;";
            ayarlar.cmd.Parameters.Add("guncelleyen", SessionManager.CurrentUser.kullanici_adsoyad);
            ayarlar.cmd.Parameters.Add("IsID", UIHelper.trn(IsID.ToString()));
            ayarlar.cmd.Parameters.Add("adi", CultureInfo.CurrentCulture.TextInfo.ToTitleCase(UIHelper.trn(adi.ToLower())));
            ayarlar.cmd.Parameters.Add("aciklama", CultureInfo.CurrentCulture.TextInfo.ToTitleCase(UIHelper.trn(aciklama.ToLower())));
            ayarlar.cmd.Parameters.Add("gorevliler", UIHelper.trn(gorevliler));
            ayarlar.cmd.Parameters.Add("renk", UIHelper.trn(renk));
            ayarlar.cmd.Parameters.Add("ajanda_gosterim", UIHelper.trn(ajanda_gosterim));
            ayarlar.cmd.Parameters.Add("departmanlar", UIHelper.trn(departmanlar));
            ayarlar.cmd.Parameters.Add("oncelik", UIHelper.trn(oncelik));
            ayarlar.cmd.Parameters.Add("kontrol_bildirim", UIHelper.trn(kontrol_bildirim));
            ayarlar.cmd.Parameters.Add("baslangic_tarihi", Convert.ToDateTime(UIHelper.trn(baslangic_tarihi)));
            ayarlar.cmd.Parameters.Add("baslangic_saati", UIHelper.trn(baslangic_saati));
            ayarlar.cmd.Parameters.Add("bitis_tarihi", Convert.ToDateTime(UIHelper.trn(bitis_tarihi)));
            ayarlar.cmd.Parameters.Add("bitis_saati", UIHelper.trn(bitis_saati));
            ayarlar.cmd.Parameters.Add("gunluk_sure", gunluk_sure);
            ayarlar.cmd.Parameters.Add("toplam_sure", toplam_sure);
            ayarlar.cmd.Parameters.Add("toplam_gun", toplam_gun);
            ayarlar.cmd.Parameters.Add("sinirlama_varmi", sinirlama_varmi);
            ayarlar.cmd.Parameters.Add("is_tipi", is_tipi);
            ayarlar.cmd.ExecuteNonQuery();

            //ayarlar.baglan();
            //ayarlar.cmd.Parameters.Clear();
            //ayarlar.cmd.CommandText = "delete from ahtapot_ajanda_olay_listesi where IsID = @IsID;";
            //ayarlar.cmd.Parameters.Add("IsID", IsID);
            //ayarlar.cmd.ExecuteNonQuery();


            foreach (string gorevliID in UIHelper.trn(gorevliler).Split(','))
            {
                if (gorevliID.Length > 0)
                {
                    if (ayarlar.IsNumeric(gorevliID))
                    {
                        if (Convert.ToInt32(gorevliID) > 0)
                        {
                            ayarlar.baglan();
                            ayarlar.cmd.Parameters.Clear();
                            ayarlar.cmd.CommandText = "select isnull(count(id),0) as varmi from ucgem_is_gorevli_durumlari where is_id = @is_id and gorevli_id = @gorevli_id";
                            ayarlar.cmd.Parameters.Add("is_id", IsID);
                            ayarlar.cmd.Parameters.Add("gorevli_id", gorevliID);
                            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(ayarlar.cmd);
                            DataSet dataSet = new DataSet();
                            sqlDataAdapter.Fill(dataSet);

                            DataRow dataRow = dataSet.Tables[0].Rows[0];
                            int varmi = Convert.ToInt32(dataRow["varmi"].ToString());

                            if (varmi == 0)
                            {
                                if (id.Length == 1)
                                {
                                    ayarlar.baglan();
                                    ayarlar.cmd.Parameters.Clear();
                                    ayarlar.cmd.CommandText = "delete from ucgem_is_gorevli_durumlari where is_id = @is_id and gorevli_id = @gorevli_id";
                                    ayarlar.cmd.Parameters.Add("is_id", IsID);
                                    ayarlar.cmd.Parameters.Add("gorevli_id", gorevliId);
                                    ayarlar.cmd.ExecuteNonQuery();
                                }

                                state = true;
                                ayarlar.baglan();
                                ayarlar.cmd.Parameters.Clear();
                                ayarlar.cmd.CommandText = "insert into ucgem_is_gorevli_durumlari(is_id, gorevli_id, tamamlanma_orani, tamamlanma_tarihi, tamamlanma_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, gunluk_sure, toplam_sure, toplam_gun) values(@is_id, @gorevli_id, @tamamlanma_orani, getdate(), getdate(), @durum, @cop, @firma_kodu, @firma_id, @ekleyen_id, @ekleyen_ip, getdate(), getdate(), @gunluk_sure, @toplam_sure, @toplam_gun);";
                                ayarlar.cmd.Parameters.Add("is_id", IsID);
                                ayarlar.cmd.Parameters.Add("gunluk_sure", gunluk_sure);
                                ayarlar.cmd.Parameters.Add("toplam_sure", toplam_sure);
                                ayarlar.cmd.Parameters.Add("toplam_gun", toplam_gun);
                                ayarlar.cmd.Parameters.Add("gorevli_id", gorevliID);
                                ayarlar.cmd.Parameters.Add("tamamlanma_orani", "0");
                                ayarlar.cmd.Parameters.Add("durum", "true");
                                ayarlar.cmd.Parameters.Add("cop", "false");
                                ayarlar.cmd.Parameters.Add("firma_kodu", SessionManager.CurrentUser.firma_kodu);
                                ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
                                ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.ekleyen_id);
                                ayarlar.cmd.Parameters.Add("ekleyen_ip", HttpContext.Current.Request.ServerVariables["Remote_Addr"]);
                                ayarlar.cmd.Parameters.Add("ekleme_tarihi", DateTime.Now);
                                ayarlar.cmd.Parameters.Add("ekleme_saati", DateTime.Now);
                                ayarlar.cmd.ExecuteNonQuery();
                            }
                            else
                            {
                                foreach (var gorevId in UIHelper.trn(gorevliId).Split(','))
                                {
                                    if (gorevId.Length > 0)
                                    {
                                        if (ayarlar.IsNumeric(gorevId))
                                        {
                                            if (Convert.ToInt32(gorevId) > 0)
                                            {
                                                if (gorevliID != gorevId)
                                                {
                                                    if (state != true)
                                                    {
                                                        ayarlar.baglan();
                                                        ayarlar.cmd.Parameters.Clear();
                                                        ayarlar.cmd.CommandText = "delete from ucgem_is_gorevli_durumlari where is_id = @is_id and gorevli_id = @gorevli_id";
                                                        ayarlar.cmd.Parameters.Add("is_id", IsID);
                                                        ayarlar.cmd.Parameters.Add("gorevli_id", gorevId);
                                                        ayarlar.cmd.ExecuteNonQuery();
                                                        bildirim = true;
                                                    }
                                                    else
                                                        bildirim = false;
                                                }
                                                else
                                                {
                                                    ayarlar.baglan();
                                                    ayarlar.cmd.Parameters.Clear();
                                                    ayarlar.cmd.CommandText = "update ucgem_is_gorevli_durumlari set gorevli_id = @gorevli_id, gunluk_sure = @gunluk_sure, toplam_sure = @toplam_sure, toplam_gun = @toplam_gun where is_id = @is_id and gorevli_id = @gorevli_id";
                                                    ayarlar.cmd.Parameters.Add("is_id", IsID);
                                                    ayarlar.cmd.Parameters.Add("gunluk_sure", gunluk_sure);
                                                    ayarlar.cmd.Parameters.Add("toplam_sure", toplam_sure);
                                                    ayarlar.cmd.Parameters.Add("toplam_gun", toplam_gun);
                                                    ayarlar.cmd.Parameters.Add("gorevli_id", gorevId);
                                                    ayarlar.cmd.ExecuteNonQuery();
                                                }
                                            }
                                        }
                                    }
                                }
                            }




                            kontrol_bildirim = "asd" + UIHelper.trn(kontrol_bildirim) + "asd";

                            if (ajanda_gosterim == "1")
                            {
                                ayarlar.baglan();
                                ayarlar.cmd.Parameters.Clear();
                                ayarlar.cmd.CommandText = "insert into ahtapot_ajanda_olay_listesi(IsID, etiket, etiket_id, title, allDay, baslangic, bitis, baslangic_saati, bitis_saati, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, kisiler, ana_kayit_id, tamamlandi) values(@IsID, @etiket, @etiket_id, @title, @allDay, @baslangic, @bitis, @baslangic_saati, @bitis_saati, @url, @color, @description, @etiketler, @durum, @cop, @firma_id, @ekleyen_id, @ekleyen_ip, @ekleme_tarihi, @ekleme_saati, '', @ana_kayit_id, @tamamlandi)";
                                ayarlar.cmd.Parameters.Add("IsID", IsID);
                                ayarlar.cmd.Parameters.Add("etiket", "personel");
                                ayarlar.cmd.Parameters.Add("etiket_id", gorevliID);
                                ayarlar.cmd.Parameters.Add("title", CultureInfo.CurrentCulture.TextInfo.ToTitleCase(UIHelper.trn(adi.ToLower())));
                                ayarlar.cmd.Parameters.Add("allDay", "0");
                                ayarlar.cmd.Parameters.Add("baslangic", Convert.ToDateTime(UIHelper.trn(baslangic_tarihi)));
                                ayarlar.cmd.Parameters.Add("baslangic_saati", UIHelper.trn(baslangic_saati));
                                ayarlar.cmd.Parameters.Add("bitis", Convert.ToDateTime(UIHelper.trn(bitis_tarihi)));
                                ayarlar.cmd.Parameters.Add("bitis_saati", UIHelper.trn(bitis_saati));
                                ayarlar.cmd.Parameters.Add("url", "");
                                ayarlar.cmd.Parameters.Add("color", UIHelper.trn(renk));
                                ayarlar.cmd.Parameters.Add("description", CultureInfo.CurrentCulture.TextInfo.ToTitleCase(UIHelper.trn(aciklama.ToLower())));
                                ayarlar.cmd.Parameters.Add("etiketler", UIHelper.trn(departmanlar));
                                ayarlar.cmd.Parameters.Add("durum", "true");
                                ayarlar.cmd.Parameters.Add("cop", "false");
                                ayarlar.cmd.Parameters.Add("firma_kodu", SessionManager.CurrentUser.firma_kodu);
                                ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
                                ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.ekleyen_id);
                                ayarlar.cmd.Parameters.Add("ekleyen_ip", HttpContext.Current.Request.ServerVariables["Remote_Addr"]);
                                ayarlar.cmd.Parameters.Add("ekleme_tarihi", DateTime.Now);
                                ayarlar.cmd.Parameters.Add("ekleme_saati", DateTime.Now);
                                ayarlar.cmd.Parameters.Add("ana_kayit_id", "0"); ;
                                ayarlar.cmd.Parameters.Add("tamamlandi", "0");
                                ayarlar.cmd.ExecuteNonQuery();
                            }

                            /*
                            if (kontrol_bildirim.IndexOf("SMS") > 0)
                            {
                                string donen = ayarlar.DakikSMSMesajGonder(Personel["personel_telefon"].ToString(), SessionManager.CurrentUser.kullanici_adsoyad + " sizi '" + adi + "' adlı işte görevlendirdi.");
                            }
                            */

                            DataRow Personel = PersonelBilgileriGetir(gorevliID);
                            adi = UIHelper.trn(adi);

                            if (Personel["PushUserKey"].ToString() != null)
                            {
                                string yeni_adi = adi.ToString();

                                if (yeni_adi.Length > 100)
                                {
                                    yeni_adi.ToString().Substring(0, 100);
                                }

                                //if (bildirim == false)
                                //{
                                    ayarlar.baglan();
                                    ayarlar.cmd.Parameters.Clear();
                                    ayarlar.cmd.CommandText = "insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values(@bildirim, @tip, @click, @user_id, @okudumu, @durum, @cop, @firma_kodu, @firma_id, @ekleyen_id, @ekleyen_ip, getdate(), getdate());";
                                    ayarlar.cmd.Parameters.Add("bildirim", SessionManager.CurrentUser.kullanici_adsoyad + "'" + yeni_adi + "' adlı işi düzenledi.");
                                    ayarlar.cmd.Parameters.Add("tip", "is_listesi");
                                    ayarlar.cmd.Parameters.Add("click", "sayfagetir('/is_listesi/','jsid=4559&bildirim=true&bildirim_id=" + IsID + "');");
                                    ayarlar.cmd.Parameters.Add("user_id", gorevliID);
                                    ayarlar.cmd.Parameters.Add("okudumu", "False");
                                    ayarlar.cmd.Parameters.Add("durum", "true");
                                    ayarlar.cmd.Parameters.Add("cop", "false");
                                    ayarlar.cmd.Parameters.Add("firma_kodu", SessionManager.CurrentUser.firma_kodu);
                                    ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
                                    ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.ekleyen_id);
                                    ayarlar.cmd.Parameters.Add("ekleyen_ip", HttpContext.Current.Request.ServerVariables["Remote_Addr"]);
                                    ayarlar.cmd.ExecuteNonQuery();
                                //}

                                if (Personel["personel_telefon"].ToString().Length > 5)
                                {
                                    ayarlar.NetGSM_SMS(Personel["personel_telefon"].ToString(), SessionManager.CurrentUser.kullanici_adsoyad + " " + yeni_adi + "' adlı işte düzenleme yaptı.");
                                }

                                Exception except;
                                bool result = Pushover.SendNotification(ayarlar.PushOverAppKey, Personel["PushUserKey"].ToString(), "ÜÇGEM MEKANİK A.Ş ERP SYSTEM", SessionManager.CurrentUser.kullanici_adsoyad + " sizi '" + yeni_adi + "' adlı işte görevlendirdi.", Priority.Normal, PushoverSound.DeviceDefault, String.Empty, "http://erp.ucgem.com", "http://erp.ucgem.com", 60, 3600, out except);
                            }

                        }
                        else
                        {
                            ayarlar.baglan();
                            ayarlar.cmd.Parameters.Clear();
                            ayarlar.cmd.CommandText = "update ucgem_is_gorevli_durumlari set gunluk_sure = @gunluk_sure, toplam_sure = @toplam_sure, toplam_gun = @toplam_gun where is_id = @is_id and gorevli_id = @gorevli_id;";
                            ayarlar.cmd.Parameters.Add("gorevli_id", gorevliID);
                            ayarlar.cmd.Parameters.Add("is_id", IsID);
                            ayarlar.cmd.Parameters.Add("gunluk_sure", gunluk_sure);
                            ayarlar.cmd.Parameters.Add("toplam_sure", toplam_sure);
                            ayarlar.cmd.Parameters.Add("toplam_gun", toplam_gun);
                            ayarlar.cmd.ExecuteNonQuery();
                        }
                    }
                }
            }
        }
        catch (Exception e)
        {
            durum = "false";
            HataLogTut(e);

        }


        ayarlar.cnn.Close();

        return durum;
    }

    private static void HataLogTut(Exception e)
    {
        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "insert into yazilim_hata_listesi(hata_mesaji, ekleme_tarihi, ekleme_saati, firma_id, kullanici_id) values(@hata_mesaji, getdate(), getdate(), @firma_id, @kullanici_id);";
        ayarlar.cmd.Parameters.Add("hata_mesaji", e.Message.ToString());
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        ayarlar.cmd.Parameters.Add("kullanici_id", SessionManager.CurrentUser.kullanici_id);
        ayarlar.cmd.ExecuteNonQuery();


        Exception except;
        bool result = Pushover.SendNotification(ayarlar.PushOverAppKey, "uo353d6ofdbm8fcmr4sc76yerv2978", "ÜÇGEM MEKANİK A.Ş ERP SYTEM HATA", "Hatayı Alan Kullanıcı : " + SessionManager.CurrentUser.kullanici_adsoyad + ", Hata Mesajı : " + e.Message, Priority.Normal, PushoverSound.DeviceDefault, String.Empty, "http://erp.ucgem.com", "http://erp.ucgem.com", 60, 3600, out except);



    }

    [WebMethod(EnableSession = true)]

    public static string YeniIsEkle(string adi, string aciklama, string gorevliler, string departmanlar, string oncelik, string kontrol_bildirim, string baslangic_tarihi, string baslangic_saati, string bitis_tarihi, string bitis_saati, string renk, string ajanda_gosterim, string gunluk_sure, string toplam_sure, string toplam_gun, int sinirlama_varmi, string is_tipi)
    {
        //Start_date = baslangic_tarihi;
        //End_date = bitis_tarihi;

        string durum = "true";
        try
        {
            gorevliler = UIHelper.trn(gorevliler);
            if (gorevliler == "" || gorevliler == "null")
            {
                gorevliler = SessionManager.CurrentUser.kullanici_id.ToString();
            }

            if (baslangic_saati == "00:00")
            {
                baslangic_saati = "08:00";
            }

            if (bitis_saati == "00:00")
            {
                bitis_saati = "18:00";
            }

            string is_kodu = "";




            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "set nocount on; insert into ucgem_is_listesi(is_tipi, renk, ajanda_gosterim, adi, aciklama, gorevliler, departmanlar, oncelik, kontrol_bildirim, baslangic_tarihi, baslangic_saati, bitis_tarihi, bitis_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, guncelleme_tarihi, guncelleme_saati, guncelleyen, gunluk_sure, toplam_sure, toplam_gun, sinirlama_varmi) values(@is_tipi, @renk, @ajanda_gosterim, @adi, @aciklama, @gorevliler, @departmanlar, @oncelik, @kontrol_bildirim, @baslangic_tarihi, @baslangic_saati, @bitis_tarihi, @bitis_saati, @durum, @cop, @firma_kodu, @firma_id, @ekleyen_id, @ekleyen_ip, getdate(), getdate(), getdate(), getdate(), @guncelleyen, @gunluk_sure, @toplam_sure, @toplam_gun, @sinirlama_varmi); SELECT SCOPE_IDENTITY() id;";
            //ayarlar.cmd.Parameters.Add("is_kodu", is_kodu);
            ayarlar.cmd.Parameters.Add("is_tipi", is_tipi);
            ayarlar.cmd.Parameters.Add("adi", CultureInfo.CurrentCulture.TextInfo.ToTitleCase(UIHelper.trn(adi.ToLower())));
            ayarlar.cmd.Parameters.Add("aciklama", CultureInfo.CurrentCulture.TextInfo.ToTitleCase(UIHelper.trn(aciklama.ToLower())));
            ayarlar.cmd.Parameters.Add("gorevliler", gorevliler);
            ayarlar.cmd.Parameters.Add("guncelleyen", SessionManager.CurrentUser.kullanici_adsoyad);
            ayarlar.cmd.Parameters.Add("departmanlar", UIHelper.trn(departmanlar));
            ayarlar.cmd.Parameters.Add("renk", UIHelper.trn(renk));
            ayarlar.cmd.Parameters.Add("ajanda_gosterim", UIHelper.trn(ajanda_gosterim));
            ayarlar.cmd.Parameters.Add("gunluk_sure", UIHelper.trn(gunluk_sure));
            ayarlar.cmd.Parameters.Add("toplam_sure", UIHelper.trn(toplam_sure));
            ayarlar.cmd.Parameters.Add("toplam_gun", UIHelper.trn(toplam_gun));
            ayarlar.cmd.Parameters.Add("oncelik", UIHelper.trn(oncelik));
            ayarlar.cmd.Parameters.Add("kontrol_bildirim", UIHelper.trn(kontrol_bildirim));
            ayarlar.cmd.Parameters.Add("baslangic_tarihi", Convert.ToDateTime(UIHelper.trn(baslangic_tarihi)));
            ayarlar.cmd.Parameters.Add("baslangic_saati", UIHelper.trn(baslangic_saati));
            ayarlar.cmd.Parameters.Add("bitis_tarihi", Convert.ToDateTime(UIHelper.trn(bitis_tarihi)));
            ayarlar.cmd.Parameters.Add("bitis_saati", UIHelper.trn(bitis_saati));
            ayarlar.cmd.Parameters.Add("durum", "true");
            ayarlar.cmd.Parameters.Add("cop", "false");
            ayarlar.cmd.Parameters.Add("firma_kodu", SessionManager.CurrentUser.firma_kodu);
            ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
            ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.kullanici_id);
            ayarlar.cmd.Parameters.Add("ekleyen_ip", HttpContext.Current.Request.ServerVariables["Remote_Addr"]);
            ayarlar.cmd.Parameters.Add("sinirlama_varmi", sinirlama_varmi.ToString());
            int is_id = Convert.ToInt32(ayarlar.cmd.ExecuteScalar());

            foreach (string gorevliID in UIHelper.trn(gorevliler).Split(','))
            {
                if (gorevliID.Length > 0)
                {
                    if (ayarlar.IsNumeric(gorevliID))
                    {
                        if (Convert.ToInt32(gorevliID) > 0)
                        {
                            ayarlar.baglan();
                            ayarlar.cmd.Parameters.Clear();
                            ayarlar.cmd.CommandText = "insert into ucgem_is_gorevli_durumlari(is_id, gorevli_id, tamamlanma_orani, tamamlanma_tarihi, tamamlanma_saati, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, gunluk_sure, toplam_sure, toplam_gun) values(@is_id, @gorevli_id, @tamamlanma_orani, getdate(), getdate(), @durum, @cop, @firma_kodu, @firma_id, @ekleyen_id, @ekleyen_ip, getdate(), getdate(), @gunluk_sure, @toplam_sure, @toplam_gun);";
                            ayarlar.cmd.Parameters.Add("is_id", is_id);
                            ayarlar.cmd.Parameters.Add("gorevli_id", gorevliID);
                            ayarlar.cmd.Parameters.Add("tamamlanma_orani", "0");
                            ayarlar.cmd.Parameters.Add("durum", "true");
                            ayarlar.cmd.Parameters.Add("cop", "false");
                            ayarlar.cmd.Parameters.Add("firma_kodu", SessionManager.CurrentUser.firma_kodu);
                            ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
                            ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.ekleyen_id);
                            ayarlar.cmd.Parameters.Add("ekleyen_ip", HttpContext.Current.Request.ServerVariables["Remote_Addr"]);
                            ayarlar.cmd.Parameters.Add("ekleme_tarihi", DateTime.Now);
                            ayarlar.cmd.Parameters.Add("ekleme_saati", DateTime.Now);
                            ayarlar.cmd.Parameters.Add("gunluk_sure", UIHelper.trn(gunluk_sure));
                            ayarlar.cmd.Parameters.Add("toplam_sure", UIHelper.trn(toplam_sure));
                            ayarlar.cmd.Parameters.Add("toplam_gun", UIHelper.trn(toplam_gun));
                            ayarlar.cmd.ExecuteNonQuery();

                            if (ajanda_gosterim == "1")
                            {
                                ayarlar.baglan();
                                ayarlar.cmd.Parameters.Clear();
                                ayarlar.cmd.CommandText = "insert into ahtapot_ajanda_olay_listesi(IsID, etiket, etiket_id, title, allDay, baslangic, bitis, baslangic_saati, bitis_saati, url, color, description, etiketler, durum, cop, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, kisiler, ana_kayit_id, tamamlandi) values(@IsID, @etiket, @etiket_id, @title, @allDay, @baslangic, @bitis, @baslangic_saati, @bitis_saati, @url, @color, @description, @etiketler, @durum, @cop, @firma_id, @ekleyen_id, @ekleyen_ip, @ekleme_tarihi, @ekleme_saati, '', @ana_kayit_id, @tamamlandi)";
                                ayarlar.cmd.Parameters.Add("IsID", is_id);
                                ayarlar.cmd.Parameters.Add("etiket", "personel");
                                ayarlar.cmd.Parameters.Add("etiket_id", gorevliID);
                                ayarlar.cmd.Parameters.Add("title", CultureInfo.CurrentCulture.TextInfo.ToTitleCase(UIHelper.trn(adi.ToLower())));
                                ayarlar.cmd.Parameters.Add("allDay", "0");
                                ayarlar.cmd.Parameters.Add("baslangic", Convert.ToDateTime(UIHelper.trn(baslangic_tarihi)));
                                ayarlar.cmd.Parameters.Add("baslangic_saati", UIHelper.trn(baslangic_saati));
                                ayarlar.cmd.Parameters.Add("bitis", Convert.ToDateTime(UIHelper.trn(bitis_tarihi)));
                                ayarlar.cmd.Parameters.Add("bitis_saati", UIHelper.trn(bitis_saati));
                                ayarlar.cmd.Parameters.Add("url", "");
                                ayarlar.cmd.Parameters.Add("color", UIHelper.trn(renk));
                                ayarlar.cmd.Parameters.Add("description", CultureInfo.CurrentCulture.TextInfo.ToTitleCase(UIHelper.trn(aciklama.ToLower())));
                                ayarlar.cmd.Parameters.Add("etiketler", UIHelper.trn(departmanlar));
                                ayarlar.cmd.Parameters.Add("durum", "true");
                                ayarlar.cmd.Parameters.Add("cop", "false");
                                ayarlar.cmd.Parameters.Add("firma_kodu", SessionManager.CurrentUser.firma_kodu);
                                ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
                                ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.ekleyen_id);
                                ayarlar.cmd.Parameters.Add("ekleyen_ip", HttpContext.Current.Request.ServerVariables["Remote_Addr"]);
                                ayarlar.cmd.Parameters.Add("ekleme_tarihi", DateTime.Now);
                                ayarlar.cmd.Parameters.Add("ekleme_saati", DateTime.Now);
                                ayarlar.cmd.Parameters.Add("ana_kayit_id", "0"); ;
                                ayarlar.cmd.Parameters.Add("tamamlandi", "0");
                                ayarlar.cmd.ExecuteNonQuery();
                            }

                            kontrol_bildirim = "asd" + UIHelper.trn(kontrol_bildirim) + "asd";

                            /*
                            if (kontrol_bildirim.IndexOf("SMS") > 0)
                            {
                                DataRow Personel = PersonelBilgileriGetir(gorevliID);
                                adi = UIHelper.trn(adi);
                                string donen = ayarlar.DakikSMSMesajGonder(Personel["personel_telefon"].ToString(), SessionManager.CurrentUser.kullanici_adsoyad + " sizi '" + adi + "' adlı işte görevlendirdi.");
                            }*/


                            DataRow Personel = PersonelBilgileriGetir(gorevliID);
                            adi = UIHelper.trn(adi);
                            if (true) //Personel["PushUserKey"].ToString().Length > 10
                            {

                                string yeni_adi = adi.ToString();

                                if (yeni_adi.Length > 100)
                                {
                                    yeni_adi.ToString().Substring(0, 100);
                                }

                                Exception except;


                                ayarlar.baglan();
                                ayarlar.cmd.Parameters.Clear();
                                ayarlar.cmd.CommandText = "insert into ahtapot_bildirim_listesi(bildirim, tip, click, user_id, okudumu, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values(@bildirim, @tip, @click, @user_id, @okudumu, @durum, @cop, @firma_kodu, @firma_id, @ekleyen_id, @ekleyen_ip, getdate(), getdate());";
                                ayarlar.cmd.Parameters.Add("bildirim", SessionManager.CurrentUser.kullanici_adsoyad + " sizi '" + yeni_adi + "' adlı işte görevlendirdi.");
                                ayarlar.cmd.Parameters.Add("tip", "is_listesi");
                                ayarlar.cmd.Parameters.Add("click", "sayfagetir('/is_listesi/','jsid=4559&bildirim=true&bildirim_id=" + is_id + "');");
                                ayarlar.cmd.Parameters.Add("user_id", gorevliID);
                                ayarlar.cmd.Parameters.Add("okudumu", "False");
                                ayarlar.cmd.Parameters.Add("durum", "true");
                                ayarlar.cmd.Parameters.Add("cop", "false");
                                ayarlar.cmd.Parameters.Add("firma_kodu", SessionManager.CurrentUser.firma_kodu);
                                ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
                                ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.ekleyen_id);
                                ayarlar.cmd.Parameters.Add("ekleyen_ip", HttpContext.Current.Request.ServerVariables["Remote_Addr"]);
                                ayarlar.cmd.ExecuteNonQuery();


                                if (Personel["personel_telefon"].ToString().Length > 5)
                                {
                                    ayarlar.NetGSM_SMS(Personel["personel_telefon"].ToString(), SessionManager.CurrentUser.kullanici_adsoyad + " sizi '" + yeni_adi + "' adlı işte görevlendirdi.");
                                }

                                bool result = Pushover.SendNotification(ayarlar.PushOverAppKey, Personel["PushUserKey"].ToString(), "ÜÇGEM MEKANİK A.Ş ERP SYTEM", SessionManager.CurrentUser.kullanici_adsoyad + " sizi '" + yeni_adi + "' adlı işte görevlendirdi.", Priority.Normal, PushoverSound.DeviceDefault, String.Empty, "http://erp.ucgem.com", "http://erp.ucgem.com", 60, 3600, out except);
                            }
                        }
                    }
                }
            }
        }
        catch (Exception e)
        {
            durum = "false";
            HataLogTut(e);
        }

        ayarlar.cnn.Close();

        return durum;
    }

    private static DataRow PersonelBilgileriGetir(string gorevliID)
    {
        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select personel_ad + ' ' + personel_soyad as personel_adsoyad, * from ucgem_firma_kullanici_listesi where id = @personel_id;";
        ayarlar.cmd.Parameters.Add("personel_id", gorevliID);
        SqlDataAdapter sda_personel = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds_personel = new DataSet();
        sda_personel.Fill(ds_personel);

        DataRow Personel = ds_personel.Tables[0].Rows[0];

        ayarlar.cnn.Close();

        return Personel;
    }


    [WebMethod(EnableSession = true)]
    public static string DepartmanGuncelle(string departman_id, string departman_adi, string departman_tipi)
    {
        string durum = "true";
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "update tanimlama_departman_listesi set departman_adi = @departman_adi, departman_tipi = @departman_tipi where id = @departman_id;";
            ayarlar.cmd.Parameters.Add("departman_adi", UIHelper.trn(departman_adi));
            ayarlar.cmd.Parameters.Add("departman_tipi", UIHelper.trn(departman_tipi));
            ayarlar.cmd.Parameters.Add("departman_id", departman_id);
            ayarlar.cmd.ExecuteNonQuery();

        }
        catch (Exception e)
        {
            durum = "false";
            HataLogTut(e);
        }

        ayarlar.cnn.Close();

        return durum;
    }



    [WebMethod(EnableSession = true)]
    public static string PersonelGuncelle(int personel_id, string personel_resim, string personel_ad, string personel_soyad, string personel_dtarih, string personel_cinsiyet, string personel_eposta, string personel_telefon, string departmanlar, string gorevler, string personel_parola)
    {
        string durum = "true";
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "update ucgem_firma_kullanici_listesi set personel_resim = @personel_resim, personel_ad = @personel_ad, personel_soyad = @personel_soyad, personel_dtarih = @personel_dtarih, personel_cinsiyet = @personel_cinsiyet, personel_eposta = @personel_eposta, personel_telefon = @personel_telefon, departmanlar = @departmanlar, gorevler = @gorevler, personel_parola = @personel_parola where id = @personel_id;";
            ayarlar.cmd.Parameters.Add("personel_resim", UIHelper.trn(personel_resim));
            ayarlar.cmd.Parameters.Add("personel_ad", UIHelper.trn(personel_ad));
            ayarlar.cmd.Parameters.Add("personel_soyad", UIHelper.trn(personel_soyad));
            ayarlar.cmd.Parameters.Add("personel_dtarih", UIHelper.trn(personel_dtarih));
            ayarlar.cmd.Parameters.Add("personel_cinsiyet", UIHelper.trn(personel_cinsiyet));
            ayarlar.cmd.Parameters.Add("personel_eposta", UIHelper.trn(personel_eposta));
            ayarlar.cmd.Parameters.Add("personel_telefon", UIHelper.trn(personel_telefon));
            ayarlar.cmd.Parameters.Add("departmanlar", UIHelper.trn(departmanlar));
            ayarlar.cmd.Parameters.Add("gorevler", UIHelper.trn(gorevler));
            ayarlar.cmd.Parameters.Add("personel_parola", UIHelper.trn(personel_parola));
            ayarlar.cmd.Parameters.Add("personel_id", personel_id);
            ayarlar.cmd.ExecuteNonQuery();

        }
        catch (Exception e)
        {
            durum = "false";
            HataLogTut(e);
        }

        ayarlar.cnn.Close();

        return durum;
    }


    [WebMethod(EnableSession = true)]
    public static string SantiyeSil(int santiye_id)
    {
        string durum = "true";
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "update ucgem_proje_listesi set cop = 'true' where id = @santiye_id;";
            ayarlar.cmd.Parameters.Add("santiye_id", santiye_id);
            ayarlar.cmd.ExecuteNonQuery();

        }
        catch (Exception e)
        {
            durum = "false";
            HataLogTut(e);
        }

        ayarlar.cnn.Close();

        return durum;
    }


    [WebMethod(EnableSession = true)]
    public static string FirmaGuncelle(int firma_id, string firma_logo, string firma_adi, string firma_yetkili, string firma_telefon, string firma_mail, string firma_supervisor_id, string firma_vergi_daire, string firma_vergi_no, string firma_adres)
    {
        string durum = "true";
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "update ucgem_firma_listesi set firma_logo = @firma_logo, firma_adi = @firma_adi, firma_yetkili = @firma_yetkili, firma_telefon = @firma_telefon, firma_mail = @firma_mail, firma_supervisor_id = firma_supervisor_id, firma_vergi_daire = @firma_vergi_daire, firma_vergi_no = @firma_vergi_no, firma_adres = @firma_adres where id = @firma_id;";
            ayarlar.cmd.Parameters.Add("firma_logo", UIHelper.trn(firma_logo));
            ayarlar.cmd.Parameters.Add("firma_adi", UIHelper.trn(firma_adi));
            ayarlar.cmd.Parameters.Add("firma_yetkili", UIHelper.trn(firma_yetkili));
            ayarlar.cmd.Parameters.Add("firma_telefon", UIHelper.trn(firma_telefon));
            ayarlar.cmd.Parameters.Add("firma_mail", UIHelper.trn(firma_mail));
            ayarlar.cmd.Parameters.Add("firma_supervisor_id", UIHelper.trn(firma_supervisor_id));
            ayarlar.cmd.Parameters.Add("firma_vergi_daire", UIHelper.trn(firma_vergi_daire));
            ayarlar.cmd.Parameters.Add("firma_vergi_no", UIHelper.trn(firma_vergi_no));
            ayarlar.cmd.Parameters.Add("firma_adres", UIHelper.trn(firma_adres));
            ayarlar.cmd.Parameters.Add("firma_id", firma_id);
            ayarlar.cmd.ExecuteNonQuery();

        }
        catch (Exception e)
        {
            durum = "false";
            HataLogTut(e);
        }

        ayarlar.cnn.Close();

        return durum;
    }


    [WebMethod(EnableSession = true)]
    public static string GorevGuncelle(string gorev_id, string gorev_adi, string yetkili_sayfalar)
    {
        string durum = "true";
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "update tanimlama_gorev_listesi set gorev_adi = @gorev_adi, yetkili_sayfalar = @yetkili_sayfalar  where id = @gorev_id;";
            ayarlar.cmd.Parameters.Add("gorev_adi", UIHelper.trn(gorev_adi));
            ayarlar.cmd.Parameters.Add("yetkili_sayfalar", UIHelper.trn(yetkili_sayfalar));
            ayarlar.cmd.Parameters.Add("gorev_id", gorev_id);
            ayarlar.cmd.ExecuteNonQuery();

            SessionManager.CurrentUser.yetkili_sayfalar = yetkili_sayfalar;

        }
        catch (Exception e)
        {
            HataLogTut(e);
            durum = "false";
        }

        ayarlar.cnn.Close();

        return durum;
    }



    [WebMethod(EnableSession = true)]
    public static string SantiyeDurumGuncelle(string durum_id, string durum_adi)
    {
        string durum = "true";
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "update tanimlama_santiye_durum_listesi set durum_adi = @durum_adi where id = @durum_id;";
            ayarlar.cmd.Parameters.Add("durum_adi", UIHelper.trn(durum_adi));
            ayarlar.cmd.Parameters.Add("durum_id", durum_id);
            ayarlar.cmd.ExecuteNonQuery();

        }
        catch (Exception e)
        {
            HataLogTut(e);
            durum = "false";
        }

        ayarlar.cnn.Close();

        return durum;
    }

    [WebMethod]
    public static string KayitSil(string tablo, int id)
    {
        string donus = "true";
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.CommandText = "update " + tablo + " set cop = 'true' where id = '" + id + "'";
            ayarlar.cmd.ExecuteNonQuery();
        }
        catch (Exception e)
        {
            HataLogTut(e);
            donus = "false";
        }

        ayarlar.cnn.Close();

        return donus;
    }

    [WebMethod]
    public static string DurumGuncelle(string tablo, int id)
    {
        string donus = "true";
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.CommandText = "update " + tablo + " set durum = case when durum = 'true' then 'false' else 'true' end where id = '" + id + "';";
            ayarlar.cmd.ExecuteNonQuery();
        }
        catch (Exception e)
        {
            HataLogTut(e);
            donus = "false";
        }

        ayarlar.cnn.Close();

        return donus;
    }

    [WebMethod]
    public static string ProjeKoduDurumGuncelle(string tablo, int id)
    {
        string ret = "true";
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.CommandText = "update " + tablo + " set proje_kodu = case when proje_kodu = 'true' then 'false' else 'true' end where id = @Id";
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.Parameters.AddWithValue("@Id", id);
            ayarlar.cmd.ExecuteNonQuery();
        }
        catch (Exception e)
        {
            HataLogTut(e);
            ret = "false";
        }
        ayarlar.cnn.Close();

        return ret;
    }


    public void yeni_olay_duzenle()
    {

        int proje_id = Convert.ToInt32(HttpContext.Current.Request.Form["proje_id"]);
        int departman_id = Convert.ToInt32(HttpContext.Current.Request.Form["departman_id"]);
        int tab_id = Convert.ToInt32(HttpContext.Current.Request.Form["tab_id"]);
        int olay_id = Convert.ToInt32(HttpContext.Current.Request.Form["olay_id"]);


        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select olay, olay_tarihi, left(olay_saati,5) olay_saati from ucgem_proje_olay_listesi where id = @olay_id;";
        ayarlar.cmd.Parameters.Add("olay_id", olay_id);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        DataRow drow = ds.Tables[0].Rows[0];

        dolay.Text = drow["olay"].ToString();
        dolay_tarihi.Text = Convert.ToDateTime(drow["olay_tarihi"]).ToShortDateString();
        dolay_saati.Text = drow["olay_saati"].ToString();


        olay_guncelle_buton.OnClientClick = "olay_guncelle('" + proje_id.ToString() + "', '" + departman_id.ToString() + "', '" + tab_id.ToString() + "', '" + olay_id.ToString() + "', this); return false;";


        olay_sil_buton.OnClientClick = "olay_sil('" + proje_id.ToString() + "', '" + departman_id.ToString() + "', '" + tab_id.ToString() + "', '" + olay_id.ToString() + "'); return false;";
        dolay.Attributes.Add("data-msg", LNG("Olay Giriniz"));
        dolay_tarihi.Attributes.Add("data-msg", LNG("Olay Tarihi"));
        olay_guncelle_buton.Text = LNG("Olay Güncelle");
        olay_sil_buton.Text = LNG("Sil");



        ayarlar.cnn.Close();
    }

    public void yeni_olay_ekle()
    {

        int proje_id = Convert.ToInt32(HttpContext.Current.Request.Form["proje_id"]);
        int departman_id = Convert.ToInt32(HttpContext.Current.Request.Form["departman_id"]);
        int tab_id = Convert.ToInt32(HttpContext.Current.Request.Form["tab_id"]);


        olay.TextMode = TextBoxMode.MultiLine;

        olay_kayit_buton.OnClientClick = "olay_kayit('" + proje_id.ToString() + "', '" + departman_id.ToString() + "', '" + tab_id.ToString() + "', this); return false;";
        olay_kayit_buton.Text = LNG("Olay Ekle");
        olay.Attributes.Add("data-msg", LNG("Olay Giriniz"));
        olay_tarihi.Attributes.Add("data-msg", LNG("Olay Tarihi"));
        olay_saati.Attributes.Add("data-msg", LNG("Olay Saati"));

    }

    public void departman_duzenle()
    {

        int departman_id = Convert.ToInt32(HttpContext.Current.Request.Form["departman_id"]);

        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select id, departman_adi, departman_tipi from tanimlama_departman_listesi where id = @departman_id;";
        ayarlar.cmd.Parameters.Add("departman_id", departman_id);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        DataRow drow = ds.Tables[0].Rows[0];
        ddepartman_adi.Text = drow["departman_adi"].ToString();

        ListItem item = new ListItem();
        item.Text = "Genel Departman";
        item.Value = "genel";
        if (drow["departman_tipi"].ToString() == "genel")
        {
            item.Selected = true;
        }
        ddepartman_tipi.Items.Add(item);



        ListItem item2 = new ListItem();
        item2.Text = "Şantiye Departman";
        item2.Value = "santiye";
        if (drow["departman_tipi"].ToString() == "santiye")
        {
            item2.Selected = true;
        }
        ddepartman_tipi.Items.Add(item2);
        ddepartman_tipi.Attributes.Add("style", "width:100%");
        ddepartman_tipi.CssClass = "select2";
        ddepartman_tipi.SelectionMode = ListSelectionMode.Single;



        departman_guncelle_buton.OnClientClick = "departman_guncelle(" + drow["id"].ToString() + "); return false;";
        ddepartman_adi.Attributes.Add("data-msg", LNG("Departman Giriniz"));
        departman_guncelle_buton.Text = LNG("Departman Güncelle");



        ayarlar.cnn.Close();
    }


    public void is_aramasi_yap()
    {
        is_ara_adi.TextMode = TextBoxMode.SingleLine;


        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select 0 as id, 'Tümü' as personel_ad_soyad UNION select id, personel_ad + ' ' + personel_soyad as personel_ad_soyad from ucgem_firma_kullanici_listesi where firma_id = @firma_id and durum = 'true' and cop = 'false';";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);


        is_ara_gorevliler.DataSource = ds.Tables[0];
        is_ara_gorevliler.DataTextField = "personel_ad_soyad";
        is_ara_gorevliler.DataValueField = "id";
        //yeni_is_gorevliler.SelectedValue = SessionManager.CurrentUser.kullanici_id.ToString();
        is_ara_gorevliler.DataBind();

        is_ara_gorevliler.CssClass = "select2";

        // UNION  UNION select id, proje_adi, 'proje', 'Projeler' from ucgem_proje_listesi where firma_id = @firma_id and durum = 'true' and cop = 'false') etiketler order by adi asc


        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select id, departman_adi as adi, 'departman' as tip, 'Departmanlar' as grup from tanimlama_departman_listesi where firma_id = @firma_id and durum = 'true' and cop = 'false'";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda2 = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds2 = new DataSet();
        sda2.Fill(ds2);

        ListItem itemss = new ListItem();
        itemss.Selected = true;
        itemss.Text = "Tümü";
        itemss.Value = "0";
        is_ara_departmanlar.Items.Add(itemss);

        foreach (DataRow item in ds2.Tables[0].Rows)
        {
            ListItem items = new ListItem();
            items.Text = item["adi"].ToString();
            items.Value = item["id"].ToString();

            is_ara_departmanlar.Items.Add(items);
        }

        is_ara_departmanlar.DataBind();
        is_ara_departmanlar.CssClass = "select2";


        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select id, UPPER(left(firma_adi, 1)) + LOWER(right(firma_adi, len(firma_adi) -1)) as adi, 'firma', 'Firmalar' from ucgem_firma_listesi where ekleyen_firma_id = @firma_id and durum = 'true' and cop = 'false'";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda22 = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds22 = new DataSet();
        sda22.Fill(ds22);

        ListItem itemss2 = new ListItem();
        itemss2.Selected = true;
        itemss2.Text = "Tümü";
        itemss2.Value = "0";
        is_ara_firmalar.Items.Add(itemss2);

        foreach (DataRow item in ds22.Tables[0].Rows)
        {
            ListItem items2 = new ListItem();
            items2.Text = item["adi"].ToString();
            items2.Value = item["id"].ToString();

            is_ara_firmalar.Items.Add(items2);
        }

        is_ara_firmalar.DataBind();
        is_ara_firmalar.CssClass = "select2";

        //


        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select id, UPPER(proje_adi) as adi, 'proje', 'Projeler' from ucgem_proje_listesi where firma_id = @firma_id and durum = 'true' and cop = 'false'";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda222 = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds222 = new DataSet();
        sda222.Fill(ds222);

        ListItem itemss22 = new ListItem();
        itemss22.Selected = true;
        itemss22.Text = "Tümü";
        itemss22.Value = "0";
        is_ara_santiyeler.Items.Add(itemss22);

        foreach (DataRow item in ds222.Tables[0].Rows)
        {
            ListItem items22 = new ListItem();
            items22.Text = item["adi"].ToString();
            items22.Value = item["id"].ToString();

            is_ara_santiyeler.Items.Add(items22);
        }

        is_ara_santiyeler.DataBind();
        is_ara_santiyeler.CssClass = "select2";



        is_ara_button.UseSubmitBehavior = false;
        is_ara_button.OnClientClick = "is_arama_yap_getir(); return false;";
        is_ara_button.Text = LNG("Arama Yap");
        ayarlar.cnn.Close();
    }

    [WebMethod]
    public static string musteribilgilerial(string Id)
    {
        ayarlar.baglan();
        ayarlar.cmd.CommandText = @"select * from ucgem_firma_listesi where id = " + Id + "";
        ayarlar.cmd.ExecuteNonQuery();
        ayarlar.cnn.Close();

        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        ayarlar.cnn.Close();

        return JsonConvert.SerializeObject(dt);
    }

    //[WebMethod]
    //public static string yetkilibilgilerial(string Ad)
    //{
    //    ayarlar.baglan();
    //    ayarlar.cmd.CommandText = @"select * from ucgem_firma_listesi where id = " + Ad + "";
    //    ayarlar.cmd.ExecuteNonQuery();
    //    ayarlar.cnn.Close();

    //    SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
    //    DataTable dt = new DataTable();
    //    sda.Fill(dt);
    //    ayarlar.cnn.Close();

    //    return JsonConvert.SerializeObject(dt);
    //}

    public void yeni_is_ekle()
    {
        string baslangic_tarihi = "";
        string bitis_tarihi = "";

        string etiket = "";
        string etiket_id = "";

        bool bakimvarmi = false;


        baslangic_tarihi = Request.Form["yeni_is_baslangic_tarihi"];
        bitis_tarihi = Request.Form["yeni_is_bitis_tarihi"];
        bakimvarmi = Convert.ToBoolean(Request.Form["bakimvarmi"]);






        //yeni_is_baslangic_tarihi.Attributes.Add();

        yeni_is_adi.TextMode = TextBoxMode.MultiLine;
        yeni_is_adi.Focus();

        is_ekle_baslik.Visible = true;
        is_ara_baslik.Visible = false;

        string proje_id = "";
        string departman_id = "";

        string bakimId = "";
        string Tum = "";

        string TalepId = "";
        string TalepVarmi = "";

        try
        {
            TalepId = Request.Form["TalepId"].ToString();
            TalepVarmi = Request.Form["TalepVarmi"].ToString();
        }
        catch (Exception)
        {

        }

        try
        {
            proje_id = Request.Form["proje_id"].ToString();
            departman_id = Request.Form["departman_id"].ToString();
        }
        catch (Exception)
        {

        }

        try
        {
            Tum = Request.Form["Tum"].ToString();
        }
        catch (Exception)
        {

        }
        try
        {
            bakimvarmi = Convert.ToBoolean(Request.Form["bakimvarmi"]);
            bakimId = Request.Form["bakimId"].ToString();

        }
        catch (Exception)
        {

        }

        try
        {
            etiket = Request.Form["etiket"].ToString();
            etiket_id = Request.Form["etiket_id"].ToString();
        }
        catch (Exception ex)
        {

        }

        if (etiket == "personel")
        {
            yeni_is_gorevliler.SelectedValue = etiket_id;
        }

        try
        {
            etiket = Request.Form["etiket"].ToString();
            etiket_id = Request.Form["etiket_id"].ToString();
        }
        catch (Exception)
        {

        }

        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();


        ayarlar.cmd.CommandText = @"SELECT DISTINCT(kul.id), kul.personel_ad + ' ' + kul.personel_soyad as personel_ad_soyad FROM ucgem_firma_kullanici_listesi kul WHERE kul.durum = 'true' and kul.cop='false' and kul.id NOT IN(SELECT personel_id FROM ucgem_personel_izin_talepleri izin WHERE izin.durum = 'Onaylandi' AND izin.cop='false' AND (izin.baslangic_tarihi <= CONVERT(date, '" + baslangic_tarihi + "', 103) AND izin.bitis_tarihi >= CONVERT(date, '" + bitis_tarihi + "', 103) OR (izin.baslangic_tarihi >= CONVERT(date, '" + baslangic_tarihi + "', 103) AND  izin.bitis_tarihi <= CONVERT(date, '" + bitis_tarihi + "', 103)))) ";

        /*ayarlar.cmd.CommandText = "SELECT DISTINCT( kul.id), kul.personel_ad + ' ' + kul.personel_soyad as personel_ad_soyad FROM ucgem_firma_kullanici_listesi kul INNER JOIN ucgem_personel_mesai_girisleri mesai ON mesai.personel_id= kul.id WHERE NOT EXISTS( SELECT personel_id FROM ucgem_personel_izin_talepleri izin WHERE kul.id = izin.personel_id AND izin.durum= 'Onaylandi' AND (izin.baslangic_tarihi <= CONVERT(date,'" + baslangic_tarihi + "', 103) AND izin.bitis_tarihi >= CONVERT(date, '" + bitis_tarihi + "', 103) OR(izin.baslangic_tarihi >= CONVERT(date, '" + baslangic_tarihi + "', 103) AND  izin.bitis_tarihi <= CONVERT(date,'" + bitis_tarihi + "', 103)))) AND mesai.personel_id IN(SELECT DISTINCT(personel_id) from ucgem_personel_mesai_girisleri mesai WHERE  mesai.personel_id NOT IN (Select DISTINCT(personel_id) from ucgem_personel_mesai_girisleri mesai_giris WHERE giris_tipi = 2 AND tarih >= CONVERT(date, '" + baslangic_tarihi + "', 103) AND tarih <= CONVERT(date,'" + bitis_tarihi + "', 103))) AND kul.firma_id = 1 and kul.durum = 'true' and kul.cop = 'false'";
        */
        ayarlar.cmd.Parameters.Add("@firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        yeni_is_gorevliler.DataSource = ds.Tables[0];
        yeni_is_gorevliler.DataTextField = "personel_ad_soyad";
        yeni_is_gorevliler.DataValueField = "id";
        if (etiket == "personel")
        {
            yeni_is_gorevliler.SelectedValue = etiket_id;
        }
        yeni_is_gorevliler.DataBind();

        yeni_is_gorevliler.CssClass = "select2";
        yeni_is_gorevliler.Attributes.Add("multiple", "multiple");

        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select id, proje_adi, proje_kodu, firma_id from ucgem_proje_listesi where cop = 'false' order by id desc";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(ayarlar.cmd);
        DataSet dataSet = new DataSet();
        sqlDataAdapter.Fill(dataSet);

        foreach (DataRow dataRow in dataSet.Tables[0].Rows)
        {
            ListItem items = new ListItem();
            items.Text = dataRow["proje_adi"].ToString() + "-" + dataRow["proje_kodu"].ToString();
            items.Value = "proje" + "-" + dataRow["id"].ToString();
            items.Attributes.Add("tip", "proje");
            items.Attributes.Add("optiongroup", "Projeler");

            if (proje_id != "")
            {
                if (dataRow["id"].ToString() == proje_id)
                {
                    items.Selected = true;
                }
            }

            yeni_is_etiketler.Items.Add(items);
        }

        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select id, adi, tip, grup from etiketler where firma_id = @firma_id and tip != 'proje' order by adi asc";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda2 = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds2 = new DataSet();
        sda2.Fill(ds2);

        yeni_is_etiketler.SelectionMode = ListSelectionMode.Multiple;

        foreach (DataRow item in ds2.Tables[0].Rows)
        {
            ListItem items = new ListItem();
            items.Text = item["adi"].ToString();
            items.Value = item["tip"].ToString() + "-" + item["id"].ToString();
            items.Attributes.Add("tip", item["tip"].ToString());
            items.Attributes.Add("optiongroup", item["grup"].ToString());


            if (departman_id != "")
            {
                if (item["tip"].ToString() == "departman" && item["id"].ToString() == departman_id)
                {
                    items.Selected = true;
                }
            }

            if (etiket == "toplanti")
            {
                if (item["tip"].ToString() == "toplanti" && item["id"].ToString() == etiket_id)
                {
                    items.Selected = true;
                }
            }


            if (etiket == "firma")
            {
                if (item["tip"].ToString() == "firma" && item["id"].ToString() == etiket_id)
                {
                    items.Selected = true;
                }
            }

            if (etiket == "proje")
            {
                if (item["tip"].ToString() == "proje" && item["id"].ToString() == etiket_id)
                {
                    items.Selected = true;
                }
            }



            yeni_is_etiketler.Items.Add(items);
        }

        yeni_is_etiketler.DataBind();
        yeni_is_etiketler.CssClass = "select2";
        yeni_is_etiketler.Attributes.Add("multiple", "multiple");

        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select id, adi from ucgem_bildirim_cesitleri";
        SqlDataAdapter sda_bildirim = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds_bildirim = new DataSet();
        sda_bildirim.Fill(ds_bildirim);

        yeni_is_kontrol_bildirim.DataSource = ds_bildirim.Tables[0];
        yeni_is_kontrol_bildirim.DataTextField = "adi";
        yeni_is_kontrol_bildirim.DataValueField = "id";
        yeni_is_kontrol_bildirim.DataBind();


        yeni_is_ekle_button.UseSubmitBehavior = false;

        if (bakimvarmi == true)
        {
            yeni_is_baslangic_tarihi.Attributes.Remove("class");
            yeni_is_baslangic_tarihi.Attributes.Add("value", baslangic_tarihi.ToString());
            yeni_is_baslangic_tarihi.Attributes.Add("class", "takvimyap_yeni hasDatepicker");
            yeni_is_baslangic_tarihi.Attributes.Add("disabled", "disabled");

            yeni_is_bitis_tarihi.Attributes.Remove("class");
            yeni_is_bitis_tarihi.Attributes.Add("value", bitis_tarihi.ToString());
            yeni_is_bitis_tarihi.Attributes.Add("class", "takvimyap_yeni hasDatepicker");
            yeni_is_bitis_tarihi.Attributes.Add("disabled", "disabled");

            yeni_is_ekle_button.OnClientClick = "yeni_is_kaydet(this); bakim_kaydini_onayla('" + etiket_id + "', '" + bakimId + "', '" + Tum + "'); return false;";
        }
        else if (TalepVarmi == "true")
        {
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "select baslik + ' ' + aciklama as talep from talep_fisleri where id = @Id;";
            ayarlar.cmd.Parameters.Add("Id", TalepId);

            yeni_is_adi.Text = ayarlar.cmd.ExecuteScalar().ToString();

            yeni_is_ekle_button.OnClientClick = "yeni_is_kaydet(this); talep_fisi_onay('" + TalepId + "', 'Onaylandı'); return false;";
        }
        else
        {
            yeni_is_ekle_button.OnClientClick = "yeni_is_kaydet(this); return false;";
        }

        yeni_is_ekle_button.Text = LNG("Yeni İş Emri Ekle");
        ayarlar.cnn.Close();
    }

    [WebMethod]
    public static string personel_izin_kontrol(string baslangicTarihi, string bitisTarihi)
    {
        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();

        ayarlar.cmd.CommandText =
            @"select personel_id 
            from ucgem_personel_izin_talepleri
            where baslangic_tarihi <= CONVERT(date, '" + baslangicTarihi + "', 103) and bitis_tarihi >= CONVERT(date, '" + baslangicTarihi + "', 103) and bitis_tarihi >= CONVERT(date, '" + bitisTarihi + "', 103)";

        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        ayarlar.cnn.Close();

        return JsonConvert.SerializeObject(dt);
    }

    public void gorev_duzenle()
    {

        int gorev_id = Convert.ToInt32(HttpContext.Current.Request.Form["gorev_id"]);

        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select id, gorev_adi from tanimlama_gorev_listesi where id = @gorev_id;";
        ayarlar.cmd.Parameters.Add("gorev_id", gorev_id);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        DataRow drow = ds.Tables[0].Rows[0];
        dgorev_adi.Text = drow["gorev_adi"].ToString();
        gorev_guncelle_buton.OnClientClick = "gorev_guncelle(" + drow["id"].ToString() + "); return false;";
        dgorev_adi.Attributes.Add("data-msg", LNG("Görev Giriniz"));


        ayarlar.cnn.Close();
    }


    public void santiye_durum_duzenle()
    {

        int durum_id = Convert.ToInt32(HttpContext.Current.Request.Form["durum_id"]);

        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select id, durum_adi from tanimlama_santiye_durum_listesi where id = @durum_id;";
        ayarlar.cmd.Parameters.Add("durum_id", durum_id);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        DataRow drow = ds.Tables[0].Rows[0];
        ddurum_adi.Text = drow["durum_adi"].ToString();
        santiye_durum_guncelle_buton.OnClientClick = "santiye_durum_guncelle(" + drow["id"].ToString() + "); return false;";
        ddurum_adi.Attributes.Add("data-msg", LNG("Proje Durumu Giriniz"));
        santiye_durum_guncelle_buton.Text = LNG("Proje Durum Güncelle");


        ayarlar.cnn.Close();
    }


    public void departmanlar()
    {
        string islem2 = "";
        try
        {
            islem2 = Request.Form["islem2"].ToString();
        }
        catch (Exception)
        {

        }
        if (islem2 == "ekle")
        {
            string departman_adi = Request.Form["departman_adi"].ToString();
            string departman_tipi = Request.Form["departman_tipi"].ToString();
            string ust_id = Request.Form["ust_id"].ToString();

            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "insert into tanimlama_departman_listesi(ust_id, departman_tipi, departman_adi, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values(@ust_id, @departman_tipi, @departman_adi, @durum, @cop, @firma_kodu, @firma_id, @ekleyen_id, @ekleyen_ip, @ekleme_tarihi, @ekleme_saati);";
            ayarlar.cmd.Parameters.Add("ust_id", UIHelper.trn(ust_id));
            ayarlar.cmd.Parameters.Add("departman_adi", UIHelper.trn(departman_adi));
            ayarlar.cmd.Parameters.Add("departman_tipi", UIHelper.trn(departman_tipi));
            ayarlar.cmd.Parameters.Add("durum", "true");
            ayarlar.cmd.Parameters.Add("cop", "false");
            ayarlar.cmd.Parameters.Add("firma_kodu", SessionManager.CurrentUser.firma_kodu);
            ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
            ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.ekleyen_id);
            ayarlar.cmd.Parameters.Add("ekleyen_ip", Request.ServerVariables["Remote_Addr"]);
            ayarlar.cmd.Parameters.Add("ekleme_tarihi", DateTime.Now);
            ayarlar.cmd.Parameters.Add("ekleme_saati", DateTime.Now);
            ayarlar.cmd.ExecuteNonQuery();
        }



        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select  ROW_NUMBER() OVER(ORDER BY departman.id desc) AS sira, STUFF(((SELECT personel_ad + ' ' + personel_soyad + ', ' FROM dbo.ucgem_firma_kullanici_listesi kullanici WHERE (SELECT COUNT(value) FROM STRING_SPLIT(kullanici.departmanlar, ',') WHERE value =  departman.id ) > 0 AND kullanici.durum = 'true' AND kullanici.cop = 'false' AND kullanici.firma_id = departman.firma_id for xml path(''))), 1, 0, '') AS yetkili_personeller, CASE when departman_tipi = 'santiye' then 'Proje Departman' else 'Genel Departman' end as departman_tipi2, * FROM tanimlama_departman_listesi departman where firma_id = @firma_id and cop = 'false' order by sirano ASC";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        departmanlar_kayityok_panel.Visible = true;
        departmanlar_kayitvar_panel.Visible = false;

        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                departmanlar_kayityok_panel.Visible = false;
                departmanlar_kayitvar_panel.Visible = true;

                departmanlar_repeater.DataSource = ds.Tables[0];
                departmanlar_repeater.ItemCreated += Departmanlar_repeater_ItemCreated;
                departmanlar_repeater.DataBind();
            }
        }

        ayarlar.cnn.Close();
    }



    public void gorevler()
    {
        string islem2 = "";
        try
        {
            islem2 = Request.Form["islem2"].ToString();
        }
        catch (Exception)
        {

        }
        if (islem2 == "ekle")
        {
            string gorev_adi = Request.Form["gorev_adi"].ToString();

            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "insert into tanimlama_gorev_listesi(gorev_adi, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) values(@gorev_adi, @durum, @cop, @firma_kodu, @firma_id, @ekleyen_id, @ekleyen_ip, @ekleme_tarihi, @ekleme_saati);";
            ayarlar.cmd.Parameters.Add("gorev_adi", UIHelper.trn(gorev_adi));
            ayarlar.cmd.Parameters.Add("durum", "true");
            ayarlar.cmd.Parameters.Add("cop", "false");
            ayarlar.cmd.Parameters.Add("firma_kodu", SessionManager.CurrentUser.firma_kodu);
            ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
            ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.ekleyen_id);
            ayarlar.cmd.Parameters.Add("ekleyen_ip", Request.ServerVariables["Remote_Addr"]);
            ayarlar.cmd.Parameters.Add("ekleme_tarihi", DateTime.Now);
            ayarlar.cmd.Parameters.Add("ekleme_saati", DateTime.Now);
            ayarlar.cmd.ExecuteNonQuery();

        }


        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select  ROW_NUMBER() OVER(ORDER BY id desc) AS sira, * from tanimlama_gorev_listesi where firma_id = @firma_id and cop = 'false'";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        gorevler_kayityok_panel.Visible = true;
        gorevler_kayitvar_panel.Visible = false;

        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                gorevler_kayityok_panel.Visible = false;
                gorevler_kayitvar_panel.Visible = true;

                gorevler_repeater.DataSource = ds.Tables[0];
                gorevler_repeater.ItemCreated += gorevler_repeater_ItemCreated;
                gorevler_repeater.DataBind();

            }
        }

        ayarlar.cnn.Close();
    }


    public void santiye_durum()
    {
        string islem2 = "";
        try
        {
            islem2 = Request.Form["islem2"].ToString();
        }
        catch (Exception)
        {

        }
        if (islem2 == "ekle")
        {
            string durum_adi = Request.Form["durum_adi"].ToString();
            //string selectValue = Request.Form["selectValue"].ToString();
            //hideValue.Text = selectValue;

            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "insert into tanimlama_santiye_durum_listesi(durum_adi, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, proje_kodu) values(@durum_adi, @durum, @cop, @firma_kodu, @firma_id, @ekleyen_id, @ekleyen_ip, @ekleme_tarihi, @ekleme_saati, @proje_kodu);";
            ayarlar.cmd.Parameters.Add("durum_adi", UIHelper.trn(durum_adi));
            ayarlar.cmd.Parameters.Add("durum", "true");
            ayarlar.cmd.Parameters.Add("cop", "false");
            ayarlar.cmd.Parameters.Add("firma_kodu", SessionManager.CurrentUser.firma_kodu);
            ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
            ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.ekleyen_id);
            ayarlar.cmd.Parameters.Add("ekleyen_ip", Request.ServerVariables["Remote_Addr"]);
            ayarlar.cmd.Parameters.Add("ekleme_tarihi", DateTime.Now);
            ayarlar.cmd.Parameters.Add("ekleme_saati", DateTime.Now);
            ayarlar.cmd.Parameters.Add("proje_kodu", true);
            ayarlar.cmd.ExecuteNonQuery();
        }


        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select * from (select ROW_NUMBER() OVER(ORDER BY id DESC) AS sira, * from tanimlama_santiye_durum_listesi where firma_id = @firma_id and cop = 'false') as t";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        santiye_durum_kayityok_panel.Visible = true;
        santiye_durum_kayitvar_panel.Visible = false;

        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                santiye_durum_kayityok_panel.Visible = false;
                santiye_durum_kayitvar_panel.Visible = true;

                santiye_durum_repeater.DataSource = ds.Tables[0];
                santiye_durum_repeater.ItemCreated += santiye_durum_repeater_ItemCreated;
                santiye_durum_repeater.DataBind();

            }
        }

        ayarlar.cnn.Close();
    }


    public void personeller()
    {

        // ayarlar.NetGSM_SMS("05076465695", "Proskop Hesap Bilgileriniz; \n Sistem Giriş Url : http://www.esflw.com \n E-Posta : " + "salihsahin@makrogem.com" + "\n Parola : " + "778899");


        string islem2 = "";
        try
        {
            islem2 = Request.Form["islem2"].ToString();
        }
        catch (Exception)
        {

        }
        if (islem2 == "ekle")
        {
            string personel_resim = UIHelper.trn(Request.Form["personel_resim"].ToString());
            string personel_ad = UIHelper.trn(Request.Form["personel_ad"].ToString());
            string personel_soyad = UIHelper.trn(Request.Form["personel_soyad"].ToString());
            DateTime date = Convert.ToDateTime(UIHelper.trn(Request.Form["personel_dtarih"]));
            DateTime personel_dtarih = Convert.ToDateTime(date.ToLongDateString());
            string personel_cinsiyet = UIHelper.trn(Request.Form["personel_cinsiyet"].ToString());
            string personel_eposta = UIHelper.trn(Request.Form["personel_eposta"].ToString());
            string personel_telefon = UIHelper.trn(Request.Form["personel_telefon"].ToString());
            string departmanlar = UIHelper.trn(Request.Form["departmanlar"].ToString());
            string gorevler = UIHelper.trn(Request.Form["gorevler"].ToString());
            string personel_parola = UIHelper.trn(Request.Form["personel_parola"].ToString());
            string personel_tcno = UIHelper.trn(Request.Form["personel_tcno"].ToString());
            try
            {
                ayarlar.baglan();
                ayarlar.cmd.Parameters.Clear();
                ayarlar.cmd.CommandText = "SET NOCOUNT ON;  insert into ucgem_firma_kullanici_listesi(yetki_kodu, firma_kodu, firma_id, firma_hid, personel_eposta, personel_parola, maili_varmi, personel_cinsiyet, personel_ad, personel_soyad, personel_telefon, personel_dtarih, personel_resim, ekleyen_yetki_kodu, ekleyen_firma_kodu, ekleyen_firma_id, departmanlar, gorevler, durum, cop, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, tcno, personel_yillik_izin_hakedis, personel_yillik_izin) values(@yetki_kodu, @firma_kodu, @firma_id, @firma_hid, @personel_eposta, @personel_parola, @maili_varmi, @personel_cinsiyet, @personel_ad, @personel_soyad, @personel_telefon, CONVERT(date, '" + personel_dtarih + "', 103), @personel_resim, @ekleyen_yetki_kodu, @ekleyen_firma_kodu, @ekleyen_firma_id, @departmanlar, @gorevler, @durum, @cop, @ekleyen_id, @ekleyen_ip, CONVERT(date, '" + DateTime.Now + "', 103), CONVERT(time, '" + DateTime.Now.TimeOfDay + "', 103), @tcno, CONVERT(date, '" + DateTime.Now + "', 103),0); SELECT SCOPE_IDENTITY() id; ";
                ayarlar.cmd.Parameters.Add("tcno", personel_tcno);
                ayarlar.cmd.Parameters.Add("yetki_kodu", "ALL");
                ayarlar.cmd.Parameters.Add("firma_hid", SessionManager.CurrentUser.firma_hid);
                ayarlar.cmd.Parameters.Add("personel_eposta", personel_eposta);
                ayarlar.cmd.Parameters.Add("personel_parola", personel_parola);
                ayarlar.cmd.Parameters.Add("maili_varmi", "false");
                ayarlar.cmd.Parameters.Add("personel_cinsiyet", personel_cinsiyet);
                ayarlar.cmd.Parameters.Add("personel_ad", personel_ad);
                ayarlar.cmd.Parameters.Add("personel_soyad", personel_soyad);
                ayarlar.cmd.Parameters.Add("personel_telefon", personel_telefon);
                ayarlar.cmd.Parameters.Add("personel_dtarih", personel_dtarih);
                ayarlar.cmd.Parameters.Add("personel_resim", personel_resim);
                ayarlar.cmd.Parameters.Add("ekleyen_yetki_kodu", "ALL");
                ayarlar.cmd.Parameters.Add("ekleyen_firma_kodu", SessionManager.CurrentUser.firma_kodu);
                ayarlar.cmd.Parameters.Add("ekleyen_firma_id", SessionManager.CurrentUser.firma_id);
                ayarlar.cmd.Parameters.Add("departmanlar", departmanlar);
                ayarlar.cmd.Parameters.Add("gorevler", gorevler);
                ayarlar.cmd.Parameters.Add("durum", "true");
                ayarlar.cmd.Parameters.Add("cop", "false");
                ayarlar.cmd.Parameters.Add("firma_kodu", SessionManager.CurrentUser.firma_kodu);
                ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
                ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.ekleyen_id);
                ayarlar.cmd.Parameters.Add("ekleyen_ip", Request.ServerVariables["Remote_Addr"]);
                ayarlar.cmd.Parameters.Add("ekleme_tarihi", DateTime.UtcNow);
                ayarlar.cmd.Parameters.Add("ekleme_saati", DateTime.Now.TimeOfDay);
                int kull_id = Convert.ToInt32(ayarlar.cmd.ExecuteScalar());
                //int kull_id = 30;


                string kullanici_hid = SessionManager.CurrentUser.firma_hid + "." + kull_id;

                ayarlar.cmd.Parameters.Clear();
                ayarlar.cmd.CommandText = "update ucgem_firma_kullanici_listesi set kullanici_hid = @kullanici_hid where id = @kullanici_id";
                ayarlar.cmd.Parameters.Add("kullanici_hid", kullanici_hid);
                ayarlar.cmd.Parameters.Add("kullanici_id", kull_id);
                ayarlar.cmd.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                throw (e);
            }


            if (personel_telefon.Length > 5)
            {
                ayarlar.NetGSM_SMS(personel_telefon, "Esflw Hesap Bilgileriniz; \n Sistem Giriş Url : http://otomasyon.esflw.com \n E-Posta : " + personel_eposta + "\n Parola : " + personel_parola);
            }

        }


        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select  ROW_NUMBER() OVER(ORDER BY kullanici.id asc) AS sira, kullanici.durum, kullanici.id, kullanici.personel_ad, kullanici.personel_soyad, kullanici.personel_telefon, kullanici.personel_eposta, left(left(ISNULL((select departman_adi + ', ' from tanimlama_departman_listesi where (SELECT COUNT(value) FROM STRING_SPLIT(kullanici.departmanlar, ',') WHERE value =  id ) > 0 and cop = 'false' for xml path('')), '----'), len(ISNULL((select departman_adi + ', ' from tanimlama_departman_listesi where (SELECT COUNT(value) FROM STRING_SPLIT(kullanici.departmanlar, ',') where value =  id ) > 0 and cop = 'false' for xml path('')), '----'))-1) ,20) + '...' as departmanlar, left(ISNULL((select gorev_adi + ', ' from tanimlama_gorev_listesi where (SELECT COUNT(value) FROM STRING_SPLIT(kullanici.gorevler, ',') WHERE value =  id ) > 0 and cop = 'false' for xml path('')), '----'), len(ISNULL((select gorev_adi + ', ' from tanimlama_gorev_listesi where (SELECT COUNT(value) FROM STRING_SPLIT(kullanici.gorevler, ',') WHERE value =  id ) > 0 and cop = 'false' for xml path('')), '----'))-1) as gorevler from ucgem_firma_kullanici_listesi kullanici with(nolock) where kullanici.firma_id = @firma_id and kullanici.cop = 'false' order by kullanici.id asc";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        personeller_kayityok_panel.Visible = true;
        personeller_kayitvar_panel.Visible = false;

        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                personeller_kayityok_panel.Visible = false;
                personeller_kayitvar_panel.Visible = true;

                personeller_repeater.DataSource = ds.Tables[0];
                personeller_repeater.ItemCreated += personeller_repeater_ItemCreated;
                personeller_repeater.DataBind();

            }
        }
        ayarlar.cnn.Close();
    }


    public void projeler()
    {
        string islem2 = "";
        try
        {
            islem2 = Request.Form["islem2"].ToString();
        }
        catch (Exception)
        {

        }

        if (islem2 == "ekle")
        {
            string proje_firma_id = UIHelper.trn(Request.Form["proje_firma_id"].ToString());
            string proje_adi = UIHelper.trn(Request.Form["proje_adi"].ToString());
            string enlem = UIHelper.trn(Request.Form["enlem"].ToString());
            string boylam = UIHelper.trn(Request.Form["boylam"].ToString());
            string supervisor_id = UIHelper.trn(Request.Form["supervisor_id"].ToString());
            string santiye_durum_id = UIHelper.trn(Request.Form["santiye_durum_id"].ToString());
            string proje_departmanlari = UIHelper.trn(Request.Form["proje_departmanlari"].ToString());
            int uretim_sablon_id = Convert.ToInt32(UIHelper.trn(Request.Form["uretim_sablon_id"].ToString()));
            string proje_Id = "-";

            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "select proje_kodu from tanimlama_santiye_durum_listesi where cop = 'false' and id = @Id";
            ayarlar.cmd.Parameters.AddWithValue("Id", santiye_durum_id);
            bool proje_kodu = Convert.ToBoolean(ayarlar.cmd.ExecuteScalar());

            if (proje_kodu == true)
            {
                ayarlar.baglan();
                ayarlar.cmd.Parameters.Clear();
                ayarlar.cmd.CommandText = "SELECT CASE WHEN ISNULL((select top 1 SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3) + '' + FORMAT(getdate(), 'MM') + '' + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), (select Count(*) from ucgem_proje_listesi where cop = 'false' and not proje_kodu = '-' and SUBSTRING(CONVERT(varchar(15), datepart(yy, ekleme_tarihi)), 3, 3) = SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3)) + 1), 1, 4), 4) from ucgem_proje_listesi proje where SUBSTRING(CONVERT(varchar(15), datepart(yy, ekleme_tarihi)), 3, 3) = SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3) and proje.durum = 'true' and proje.cop = 'false' and not proje.proje_kodu = '-' order by id desc), 0) = 0 THEN(select SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3) + '' + FORMAT(getdate(), 'MM') + '' + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), 0 + 1), 1, 4), 4)) WHEN ISNULL((select top 1 SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3) + '' + FORMAT(getdate(), 'MM') + '' + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), (select Count(*) from ucgem_proje_listesi where cop = 'false' and not proje_kodu = '-' and SUBSTRING(CONVERT(varchar(15), datepart(yy, ekleme_tarihi)), 3, 3) = SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3)) + 1), 1, 4), 4) from ucgem_proje_listesi proje where SUBSTRING(CONVERT(varchar(15), datepart(yy, ekleme_tarihi)), 3, 3) = SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3) and proje.durum = 'true' and proje.cop = 'false' and not proje.proje_kodu = '-' order by id desc), 0) != 0 THEN(select top 1 SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3) + '' + FORMAT(getdate(), 'MM') + '' + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), (select Count(*) from ucgem_proje_listesi where cop = 'false' and not proje_kodu = '-' and SUBSTRING(CONVERT(varchar(15), datepart(yy, ekleme_tarihi)), 3, 3) = SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3)) + 1), 1, 4), 4) from ucgem_proje_listesi proje where SUBSTRING(CONVERT(varchar(15), datepart(yy, ekleme_tarihi)), 3, 3) = SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3) and proje.durum = 'true' and proje.cop = 'false' and not proje.proje_kodu = '-' order by id desc) ELSE(select top 1 SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3) + '' + FORMAT(getdate(), 'MM') + '' + RIGHT('000' + SUBSTRING(CONVERT(NVARCHAR(10), 0 + 1), 1, 4), 4) from ucgem_proje_listesi proje where SUBSTRING(CONVERT(varchar(15), datepart(yy, ekleme_tarihi)), 3, 3) = SUBSTRING(CONVERT(varchar(50), datepart(yy, getdate())), 3, 3) and proje.durum = 'true' and proje.cop = 'false' and not proje.proje_kodu = '-' order by id desc) END";
                proje_Id = Convert.ToString(ayarlar.cmd.ExecuteScalar()); 
            }

            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "SET NOCOUNT ON; insert into ucgem_proje_listesi(guncelleme_tarihi, guncelleme_saati, guncelleyen_id, proje_departmanlari, santiye_durum_id, proje_adi, proje_firma_id, enlem, boylam, supervisor_id, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, proje_kodu) values(getdate(), getdate(), @ekleyen_id, @proje_departmanlari, @santiye_durum_id, @proje_adi, @proje_firma_id, @enlem, @boylam, @supervisor_id, @durum, @cop, @firma_kodu, @firma_id, @ekleyen_id, @ekleyen_ip, getdate(), getdate(), @proje_Id); SELECT SCOPE_IDENTITY() id;";
            ayarlar.cmd.Parameters.Add("proje_departmanlari", proje_departmanlari);
            ayarlar.cmd.Parameters.Add("santiye_durum_id", santiye_durum_id);
            ayarlar.cmd.Parameters.Add("proje_adi", proje_adi);
            ayarlar.cmd.Parameters.Add("proje_firma_id", proje_firma_id);
            ayarlar.cmd.Parameters.Add("enlem", enlem);
            ayarlar.cmd.Parameters.Add("boylam", boylam);
            ayarlar.cmd.Parameters.Add("supervisor_id", supervisor_id);
            ayarlar.cmd.Parameters.Add("durum", "true");
            ayarlar.cmd.Parameters.Add("cop", "false");
            ayarlar.cmd.Parameters.Add("firma_kodu", SessionManager.CurrentUser.firma_kodu);
            ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
            ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.ekleyen_id);
            ayarlar.cmd.Parameters.Add("ekleyen_ip", Request.ServerVariables["Remote_Addr"]);
            ayarlar.cmd.Parameters.Add("proje_Id", proje_Id);
            int proje_id = Convert.ToInt32(ayarlar.cmd.ExecuteScalar());

            //string proje_kodu = "ESP" + DateTime.Now.Year.ToString().Substring(0, 2) + DateTime.Now.Month.ToString() + DateTime.Now.Day.ToString() + "000" + proje_id.ToString();

            //ayarlar.cmd.Parameters.Clear();
            //ayarlar.cmd.CommandText = "update ucgem_proje_listesi set proje_kodu = @proje_kodu where id = @proje_id;";
            //ayarlar.cmd.Parameters.Add("proje_kodu", proje_kodu);
            //ayarlar.cmd.Parameters.Add("proje_id", proje_id);
            //ayarlar.cmd.ExecuteNonQuery();


            if (uretim_sablon_id != 0)
            {
                ayarlar.cmd.Parameters.Clear();
                ayarlar.cmd.CommandText = "Exec [dbo].[ProjeSablonluEkle] @ProjeId = @ProjeId, @SablonId = @SablonId;";
                ayarlar.cmd.Parameters.Add("ProjeId", proje_id);
                ayarlar.cmd.Parameters.Add("SablonId", uretim_sablon_id);
                ayarlar.cmd.ExecuteNonQuery();
            }

            Response.End();

        }

        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select UPPER(left(firma.firma_adi, 1)) + LOWER(right(firma.firma_adi, len(firma.firma_adi) -1)) as firma_adi, kullanici.personel_ad + ' ' + kullanici.personel_soyad as supervisor, * from ucgem_proje_listesi proje join ucgem_firma_listesi firma on firma.id = proje.proje_firma_id join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = proje.supervisor_id where proje.firma_id = @firma_id and proje.durum = 'true' and proje.cop = 'false';";
        ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        projeler_kayityok_panel.Visible = true;
        projeler_kayitvar_panel.Visible = false;

        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                projeler_kayityok_panel.Visible = false;
                projeler_kayitvar_panel.Visible = true;

                projeler_repeater.DataSource = ds.Tables[0];
                projeler_repeater.ItemCreated += projeler_repeater_ItemCreated;
                projeler_repeater.DataBind();

            }
        }
        ayarlar.cnn.Close();
    }


    public void firmalar()
    {
        string islem2 = "";
        string yetki_kodu = Request.Form["yetki_kodu"].ToString();

        try
        {
            islem2 = Request.Form["islem2"].ToString();
        }
        catch (Exception)
        {

        }
        if (islem2 == "ekle")
        {
            string firma_logo = UIHelper.trn(Request.Form["firma_logo"].ToString());
            string firma_adi = UIHelper.trn(Request.Form["firma_adi"].ToString());
            string firma_yetkili = UIHelper.trn(Request.Form["firma_yetkili"].ToString());
            string firma_telefon = UIHelper.trn(Request.Form["firma_telefon"].ToString());
            string firma_mail = UIHelper.trn(Request.Form["firma_mail"].ToString());
            string firma_supervisor_id = UIHelper.trn(Request.Form["firma_supervisor_id"].ToString());
            string yetkili1_telefon = UIHelper.trn(Request.Form["yetkili1_telefon"].ToString());
            string yetkili1_mail = UIHelper.trn(Request.Form["yetkili1_mail"].ToString());


            //string yetkili2_telefon = UIHelper.trn(Request.Form["yetkili2_telefon"].ToString());
            //string yetkili2_mail = UIHelper.trn(Request.Form["yetkili2_mail"].ToString());

            //string yetkili3_adi = UIHelper.trn(Request.Form["yetkili3_adi"].ToString());
            //string yetkili3_telefon = UIHelper.trn(Request.Form["yetkili3_telefon"].ToString());
            //string yetkili3_mail = UIHelper.trn(Request.Form["yetkili3_mail"].ToString());

            //string yetkili4_adi = UIHelper.trn(Request.Form["yetkili4_adi"].ToString());
            //string yetkili4_telefon = UIHelper.trn(Request.Form["yetkili4_telefon"].ToString());
            //string yetkili4_mail = UIHelper.trn(Request.Form["yetkili4_mail"].ToString());

            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "SET NOCOUNT ON; insert into ucgem_firma_listesi(yetki_kodu, firma_logo, firma_adi, firma_yetkili, firma_telefon, firma_mail, firma_supervisor_id, default_parabirimi, cari_calisma_izni, genel_kar_tipi, genel_kar, genel_kar_pb, firma_gsm, kur_secimi, durum, cop, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, ekleyen_firma_id, ekleyen_firma_kodu, yetkili1_telefon, yetkili1_mail, yetkili2_adi, yetkili2_telefon, yetkili2_mail, yetkili3_adi, yetkili3_telefon, yetkili3_mail, yetkili4_adi, yetkili4_telefon, yetkili4_mail) values(@yetki_kodu, @firma_logo, @firma_adi, @firma_yetkili, @firma_telefon, @firma_mail, @firma_supervisor_id, @default_parabirimi, @cari_calisma_izni, @genel_kar_tipi, @genel_kar, @genel_kar_pb, @firma_gsm, @kur_secimi, @durum, @cop, @ekleyen_id, @ekleyen_ip, @ekleme_tarihi, @ekleme_saati, @ekleyen_firma_id, @ekleyen_firma_kodu, @yetkili1_telefon, @yetkili1_mail, @yetkili2_adi, @yetkili2_telefon, @yetkili2_mail, @yetkili3_adi, @yetkili3_telefon, @yetkili3_mail, @yetkili4_adi, @yetkili4_telefon, @yetkili4_mail); SELECT SCOPE_IDENTITY() id;";
            ayarlar.cmd.Parameters.Add("yetki_kodu", yetki_kodu);
            ayarlar.cmd.Parameters.Add("firma_logo", firma_logo);
            ayarlar.cmd.Parameters.Add("firma_adi", firma_adi);
            ayarlar.cmd.Parameters.Add("firma_yetkili", firma_yetkili);
            ayarlar.cmd.Parameters.Add("firma_telefon", firma_telefon);
            ayarlar.cmd.Parameters.Add("yetkili1_telefon", yetkili1_telefon);
            ayarlar.cmd.Parameters.Add("yetkili1_mail", yetkili1_mail);
            ayarlar.cmd.Parameters.Add("firma_mail", firma_mail);
            ayarlar.cmd.Parameters.Add("firma_supervisor_id", firma_supervisor_id);
            ayarlar.cmd.Parameters.Add("default_parabirimi", "TL");
            ayarlar.cmd.Parameters.Add("cari_calisma_izni", "true");
            ayarlar.cmd.Parameters.Add("genel_kar_tipi", "Oran");
            ayarlar.cmd.Parameters.Add("genel_kar", "20");
            ayarlar.cmd.Parameters.Add("genel_kar_pb", "TL");
            ayarlar.cmd.Parameters.Add("firma_gsm", firma_telefon);
            ayarlar.cmd.Parameters.Add("kur_secimi", "TL");
            ayarlar.cmd.Parameters.Add("durum", "true");
            ayarlar.cmd.Parameters.Add("cop", "false");
            ayarlar.cmd.Parameters.Add("ekleyen_id", SessionManager.CurrentUser.ekleyen_id);
            ayarlar.cmd.Parameters.Add("ekleyen_ip", Request.ServerVariables["Remote_Addr"]);
            ayarlar.cmd.Parameters.Add("ekleme_tarihi", DateTime.Now);
            ayarlar.cmd.Parameters.Add("ekleme_saati", DateTime.Now);
            ayarlar.cmd.Parameters.Add("ekleyen_firma_kodu", SessionManager.CurrentUser.firma_kodu);
            ayarlar.cmd.Parameters.Add("ekleyen_firma_id", SessionManager.CurrentUser.firma_id);



            if (Request.Form["yetkili2_adi"].ToString() == "undefined")
            {
                ayarlar.cmd.Parameters.Add("yetkili2_adi", DBNull.Value);
            }
            else
            {
                string yetkili2_adi = UIHelper.trn(Request.Form["yetkili2_adi"].ToString());
                ayarlar.cmd.Parameters.Add("yetkili2_adi", yetkili2_adi);
            }

            if (Request.Form["yetkili2_telefon"].ToString() == "undefined")
            {
                ayarlar.cmd.Parameters.Add("yetkili2_telefon", DBNull.Value);
            }
            else
            {
                string yetkili2_telefon = UIHelper.trn(Request.Form["yetkili2_telefon"].ToString());
                ayarlar.cmd.Parameters.Add("yetkili2_telefon", yetkili2_telefon);
            }

            if (Request.Form["yetkili2_mail"].ToString() == "undefined")
            {
                ayarlar.cmd.Parameters.Add("yetkili2_mail", DBNull.Value);
            }
            else
            {
                string yetkili2_mail = UIHelper.trn(Request.Form["yetkili2_mail"].ToString());
                ayarlar.cmd.Parameters.Add("yetkili2_mail", yetkili2_mail);
            }

            if (Request.Form["yetkili3_adi"].ToString() == "undefined")
            {
                ayarlar.cmd.Parameters.Add("yetkili3_adi", DBNull.Value);
            }
            else
            {
                string yetkili3_adi = UIHelper.trn(Request.Form["yetkili3_adi"].ToString());
                ayarlar.cmd.Parameters.Add("yetkili3_adi", yetkili3_adi);
            }

            if (Request.Form["yetkili3_telefon"].ToString() == "undefined")
            {
                ayarlar.cmd.Parameters.Add("yetkili3_telefon", DBNull.Value);
            }
            else
            {
                string yetkili3_telefon = UIHelper.trn(Request.Form["yetkili3_telefon"].ToString());
                ayarlar.cmd.Parameters.Add("yetkili3_telefon", yetkili3_telefon);
            }

            if (Request.Form["yetkili3_mail"].ToString() == "undefined")
            {
                ayarlar.cmd.Parameters.Add("yetkili3_mail", DBNull.Value);
            }
            else
            {
                string yetkili3_mail = UIHelper.trn(Request.Form["yetkili3_mail"].ToString());
                ayarlar.cmd.Parameters.Add("yetkili3_mail", yetkili3_mail);
            }


            if (Request.Form["yetkili4_adi"].ToString() == "undefined")
            {
                ayarlar.cmd.Parameters.Add("yetkili4_adi", DBNull.Value);
            }
            else
            {
                string yetkili4_adi = UIHelper.trn(Request.Form["yetkili4_adi"].ToString());
                ayarlar.cmd.Parameters.Add("yetkili4_adi", yetkili4_adi);
            }

            if (Request.Form["yetkili4_telefon"].ToString() == "undefined")
            {
                ayarlar.cmd.Parameters.Add("yetkili4_telefon", DBNull.Value);
            }
            else
            {
                string yetkili4_telefon = UIHelper.trn(Request.Form["yetkili4_telefon"].ToString());
                ayarlar.cmd.Parameters.Add("yetkili4_telefon", yetkili4_telefon);
            }

            if (Request.Form["yetkili4_mail"].ToString() == "undefined")
            {
                ayarlar.cmd.Parameters.Add("yetkili4_mail", DBNull.Value);
            }
            else
            {
                string yetkili4_mail = UIHelper.trn(Request.Form["yetkili4_mail"].ToString());
                ayarlar.cmd.Parameters.Add("yetkili4_mail", yetkili4_mail);
            }

            int firma_id = Convert.ToInt32(ayarlar.cmd.ExecuteScalar());
            string firma_hid = SessionManager.CurrentUser.firma_hid + "." + firma_id;
            string musteri_kodu = "000" + firma_id.ToString();

            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "update ucgem_firma_listesi set firma_hid = @firma_hid, musteri_kodu = @musteri_kodu where id = @firma_id;";
            ayarlar.cmd.Parameters.Add("firma_hid", firma_hid);
            ayarlar.cmd.Parameters.Add("firma_id", firma_id);
            ayarlar.cmd.Parameters.Add("musteri_kodu", musteri_kodu);
            ayarlar.cmd.ExecuteNonQuery();
        }
        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();

        if (yetki_kodu == "BOSS")
        {
            ayarlar.cmd.CommandText = "select isnull(kullanici.personel_ad ,'')+ ' ' + isnull(kullanici.personel_soyad,'') supervisor, firma.* from ucgem_firma_listesi firma left join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = firma.firma_supervisor_id where firma.cop = 'false' and firma.yetki_kodu = @yetki_kodu and firma.id != 1 and firma.id != 156;";
        }
        else
        {
            ayarlar.cmd.CommandText = "select ROW_NUMBER() OVER(ORDER BY firma.id asc) AS sira, kullanici.personel_ad + ' ' + kullanici.personel_soyad supervisor, firma.* from ucgem_firma_listesi firma join ucgem_firma_kullanici_listesi kullanici with(nolock) on kullanici.id = firma.firma_supervisor_id where firma.cop = 'false' and firma.yetki_kodu = @yetki_kodu and firma.firma_hid like '" + SessionManager.CurrentUser.firma_hid + ".%';";
        }

        ayarlar.cmd.Parameters.Add("yetki_kodu", yetki_kodu);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        firmalar_kayityok_panel.Visible = true;
        firmalar_kayitvar_panel.Visible = false;

        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                firmalar_kayityok_panel.Visible = false;
                firmalar_kayitvar_panel.Visible = true;

                firmalar_repeater.DataSource = ds.Tables[0];
                firmalar_repeater.ItemCreated += firmalar_repeater_ItemCreated;
                firmalar_repeater.DataBind();

            }
        }
        ayarlar.cnn.Close();
    }
    private void firmalar_repeater_ItemCreated(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView drow = (DataRowView)e.Item.DataItem;
            CheckBox checkbox = (CheckBox)e.Item.FindControl("st4");
            checkbox.InputAttributes.Add("class", "js-switch");

            if (drow["durum"].ToString() == "true")
            {
                checkbox.Checked = true;
            }
            checkbox.ClientIDMode = ClientIDMode.Predictable;
            Label str1_label = (Label)e.Item.FindControl("st4_label");
            //str1_label.AssociatedControlID = "st4";
            str1_label.Attributes.Add("onclick", "durum_guncelleme_calistir('ucgem_firma_listesi', '" + drow["id"].ToString() + "');");
        }
    }
    private void projeler_repeater_ItemCreated(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView drow = (DataRowView)e.Item.DataItem;
            CheckBox checkbox = (CheckBox)e.Item.FindControl("st5");
            checkbox.InputAttributes.Add("class", "js-switch");

            if (drow["durum"].ToString() == "true")
            {
                checkbox.Checked = true;
            }


            checkbox.ClientIDMode = ClientIDMode.Predictable;
            Label str5_label = (Label)e.Item.FindControl("st5_label");
            //str5_label.AssociatedControlID = "st5";
            str5_label.Attributes.Add("onclick", "durum_guncelleme_calistir('ucgem_proje_listesi', '" + drow["id"].ToString() + "');");
        }
    }

    private void personeller_repeater_ItemCreated(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView drow = (DataRowView)e.Item.DataItem;
            CheckBox checkbox = (CheckBox)e.Item.FindControl("st3");
            checkbox.InputAttributes.Add("class", "js-switch");

            if (drow["durum"].ToString() == "true")
            {
                checkbox.Checked = true;
            }

            //checkbox.ClientIDMode = ClientIDMode.Predictable;


            Label str1_label = (Label)e.Item.FindControl("st3_label");
            //str1_label.AssociatedControlID = "st3";
            str1_label.Attributes.Add("onclick", "durum_guncelleme_calistir('ucgem_firma_kullanici_listesi', '" + drow["id"].ToString() + "');");
        }
    }

    private void gorevler_repeater_ItemCreated(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView drow = (DataRowView)e.Item.DataItem;
            CheckBox checkbox = (CheckBox)e.Item.FindControl("st2");
            checkbox.InputAttributes.Add("class", "js-switch");

            if (drow["durum"].ToString() == "true")
            {
                checkbox.Checked = true;
            }

            checkbox.ClientIDMode = ClientIDMode.Predictable;


            Label str1_label = (Label)e.Item.FindControl("str2_label");
            //str1_label.AssociatedControlID = "st2";
            //str1_label.Attributes.Add("for", checkbox.ClientID.ToString());
            str1_label.Attributes.Add("onclick", "durum_guncelleme_calistir('tanimlama_gorev_listesi', '" + drow["id"].ToString() + "');");


        }
    }
    private void santiye_durum_repeater_ItemCreated(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView drow = (DataRowView)e.Item.DataItem;
            CheckBox checkbox = (CheckBox)e.Item.FindControl("st2_santiye");
            checkbox.InputAttributes.Add("class", "js-switch");

            if (drow["durum"].ToString() == "true")
            {
                checkbox.Checked = true;
            }


            checkbox.ClientIDMode = ClientIDMode.Predictable;


            Label str1_label = (Label)e.Item.FindControl("str2santiye_label");
            //str1_label.AssociatedControlID = "st2_santiye";
            str1_label.Attributes.Add("onclick", "durum_guncelleme_calistir('tanimlama_santiye_durum_listesi', '" + drow["id"].ToString() + "');");
            //str1_label.Attributes.Add("for", checkbox.ClientID.ToString());
        }

        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView drow = (DataRowView)e.Item.DataItem;
            CheckBox checkbox = (CheckBox)e.Item.FindControl("proje_kodu");
            checkbox.InputAttributes.Add("class", "js-switch");

            if (Convert.ToBoolean(drow["proje_kodu"]) == true)
            {
                checkbox.Checked = true;
            }
            checkbox.ClientIDMode = ClientIDMode.Predictable;
            Label str1_label = (Label)e.Item.FindControl("proje_kodu_label");
            str1_label.Attributes.Add("onclick", "proje_kodu_durum('tanimlama_santiye_durum_listesi', '" + drow["id"].ToString() + "');");
        }
    }

    private void Departmanlar_repeater_ItemCreated(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView drow = (DataRowView)e.Item.DataItem;
            CheckBox checkbox = (CheckBox)e.Item.FindControl("st1");
            checkbox.InputAttributes.Add("class", "js-switch");
            if (drow["durum"].ToString() == "true")
            {
                checkbox.Checked = true;
            }

            checkbox.ClientIDMode = ClientIDMode.Predictable;
            Label str1_label = (Label)e.Item.FindControl("str1_label");
            //str1_label.AssociatedControlID = "st1";

            str1_label.Attributes.Add("onclick", "durum_guncelleme_calistir('tanimlama_departman_listesi', '" + drow["id"].ToString() + "');");

        }
    }

    public class CalculateResult
    {
        public string Parca { get; set; }
        public string Sayi { get; set; }
        public int Durum { get; set; }
    }


    [WebMethod]
    public static string CalculateParca(int ParcaID, int GirilenMiktar, int parcaDurum)
    {
        if (parcaDurum == 1)
        {
            ayarlar.baglan();
            ayarlar.cmd.CommandText = @"SELECT c.[Value] AS id, a.[Value] AS adet FROM parca_grup_listesi grup CROSS APPLY (SELECT Pos, Value FROM [dbo].[SplitString](grup.parcalar,',')) c CROSS APPLY (SELECT Pos, Value FROM [dbo].[SplitString](grup.adet,',')) a WHERE c.Pos = a.Pos and grup.id = " + ParcaID + "";
            ayarlar.cmd.ExecuteNonQuery();

            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(ayarlar.cmd);
            DataTable dataTable = new DataTable();
            sqlDataAdapter.Fill(dataTable);

            CalculateResult result = new CalculateResult();
            for (int i = 0; i < dataTable.Rows.Count; i++)
            {
                int id = Convert.ToInt32(dataTable.Rows[i].ItemArray[0].ToString());
                ayarlar.baglan();
                int Fark = 0;
                ayarlar.cmd.CommandText = @"select * from parca_listesi where id = " + id + "";
                ayarlar.cmd.ExecuteNonQuery();

                SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                string parca = dt.Rows[0].ItemArray[1].ToString();
                int agacParcaAdet = Convert.ToInt32(dataTable.Rows[i].ItemArray[1].ToString());
                int miktar = Convert.ToInt32(dt.Rows[0].ItemArray[10]);
                int minimummiktar = Convert.ToInt32(dt.Rows[0].ItemArray[12]);
                Fark = miktar - minimummiktar;
                ayarlar.cnn.Close();
                if ((agacParcaAdet + minimummiktar) > miktar)
                {
                    if (result.Parca == null && result.Sayi == null)
                    {
                        result.Parca = parca;
                        result.Sayi = Convert.ToString((agacParcaAdet + minimummiktar) - miktar);
                        result.Durum = 1;
                    }
                    else
                    {
                        result.Parca += "," + parca;
                        result.Sayi += "," + Convert.ToString((agacParcaAdet + minimummiktar) - miktar);
                        result.Durum = 1;
                    }
                }
                else
                {
                    if (result.Parca == null && result.Sayi == null)
                    {
                        result.Parca = parca;
                        result.Sayi = Convert.ToString(agacParcaAdet);
                        result.Durum = 0;
                    }
                    else
                    {
                        result.Parca += "," + parca;
                        result.Sayi += "," + Convert.ToString(agacParcaAdet);
                        result.Durum = 0;
                    }
                }
            }
            return JsonConvert.SerializeObject(result);
        }
        else
        {
            ayarlar.baglan();
            int Fark = 0;
            ayarlar.cmd.CommandText = @"select * from parca_listesi where id = " + ParcaID + "";
            ayarlar.cmd.ExecuteNonQuery();

            SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            string parca = dt.Rows[0].ItemArray[1].ToString();
            int miktar = Convert.ToInt32(dt.Rows[0].ItemArray[10]);
            int minimummiktar = Convert.ToInt32(dt.Rows[0].ItemArray[12]);
            Fark = miktar - minimummiktar;
            ayarlar.cnn.Close();
            CalculateResult result = new CalculateResult();
            if ((GirilenMiktar + minimummiktar) > miktar)
            {
                result.Parca = parca;
                result.Sayi = Convert.ToString((GirilenMiktar + minimummiktar) - miktar);
                result.Durum = 1;
            }
            else
            {
                result.Parca = parca;
                result.Sayi = Convert.ToString(GirilenMiktar);
                result.Durum = 0;
            }
            return JsonConvert.SerializeObject(result);
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
            ayarlar.cmd.Parameters.AddWithValue("kelimeler", kelime);
            ayarlar.cmd.ExecuteNonQuery();
        }

        return kelime;
    }

    public class GrupResult
    {
        public int grupId { get; set; }
        public string grupAdi { get; set; }
    }

    [WebMethod]
    public static string GrupTanimi(string grupAdi)
    {
        GrupResult grupResult = new GrupResult();
        int GrupId;
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "set nocount on; insert into Hatirlatici.Grup(GrupAdi, OlusturanID, OlusturmaTarihi, Silindi) values(@grupAdi, @olusturanId, @olusturmaTarihi, @silindi); SELECT SCOPE_IDENTITY();";
            ayarlar.cmd.Parameters.AddWithValue("grupAdi", grupAdi);
            ayarlar.cmd.Parameters.AddWithValue("olusturanId", SessionManager.CurrentUser.kullanici_id);
            ayarlar.cmd.Parameters.AddWithValue("olusturmaTarihi", DateTime.Now.ToString());
            ayarlar.cmd.Parameters.AddWithValue("silindi", false);
            GrupId = Convert.ToInt32(ayarlar.cmd.ExecuteScalar());

            if (GrupId != 0)
            {
                ayarlar.baglan();
                ayarlar.cmd.Parameters.Clear();
                ayarlar.cmd.CommandText = "select * from Hatirlatici.Grup where Silindi = 'false' and HatirlaticiGrupID = @grupID";
                ayarlar.cmd.Parameters.AddWithValue("grupID", GrupId);
                ayarlar.cmd.ExecuteNonQuery();

                SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                grupResult.grupId = Convert.ToInt32(dt.Rows[0].ItemArray[0]);
                grupResult.grupAdi = dt.Rows[0].ItemArray[1].ToString();
            }
        }
        catch (Exception e)
        {
            HataLogTut(e);
        }
        return JsonConvert.SerializeObject(grupResult);
    }

    public class ParametreResult
    {
        public string durum { get; set; }
    }

    [WebMethod]
    public static string ParametreTanimi(int grupId, string parametreAdi, string parametreTipi)
    {
        string state = "true";
        ParametreResult result = new ParametreResult();
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "IF NOT EXISTS(SELECT * FROM Hatirlatici.GrupParametreleri WHERE GrupParametre = @parametreadi and HatirlaticiGrupId = @grupID) insert into Hatirlatici.GrupParametreleri(HatirlaticiGrupID, Tip, GrupParametre, OlusturanID, OlusturmaTarihi, Silindi) values(@grupID, @tip, @parametreadi, @olusturanId, @olusturmaTarihi, @silindi) ELSE SELECT 'false'";
            ayarlar.cmd.Parameters.AddWithValue("grupID", grupId);
            ayarlar.cmd.Parameters.AddWithValue("tip", parametreTipi);
            ayarlar.cmd.Parameters.AddWithValue("parametreadi", parametreAdi);
            ayarlar.cmd.Parameters.AddWithValue("olusturanId", SessionManager.CurrentUser.kullanici_id);
            ayarlar.cmd.Parameters.AddWithValue("olusturmaTarihi", DateTime.Now.ToString());
            ayarlar.cmd.Parameters.AddWithValue("silindi", false);
            //ayarlar.cmd.ExecuteNonQuery();
            string durum = Convert.ToString(ayarlar.cmd.ExecuteScalar());

            if (durum == "false")
            {
                //result.durum = "false";
                state = "false";
            }
        }
        catch (Exception e)
        {
            HataLogTut(e);
            state = "false";
        }
        //return JsonConvert.SerializeObject(result);
        return state;
    }

    public class ParametreDegerAlResult
    {
        public int HatirlaticiGrupID { get; set; }
        public string Tip { get; set; }
        public string GrupParametre { get; set; }
    }

    [WebMethod]
    public static string ParametreDegerAl(int GrupId)
    {
        DataTable dt = new DataTable();
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "select * from Hatirlatici.GrupParametreleri where HatirlaticiGrupID = @grupID and Silindi = 'false'";
            ayarlar.cmd.Parameters.AddWithValue("grupID", GrupId);
            ayarlar.cmd.ExecuteNonQuery();

            SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
            sda.Fill(dt);
            ayarlar.cnn.Close();
        }
        catch (Exception e)
        {
            HataLogTut(e);
        }
        return JsonConvert.SerializeObject(dt);
    }
}