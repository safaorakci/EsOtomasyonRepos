﻿using Ahtapot.App_Code.ayarlar;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

public partial class System_root_is_listesi_is_listesi : System.Web.UI.Page
{

    public XmlDocument doc = new XmlDocument();

    protected void Page_Load(object sender, EventArgs e)
    {
        doc.Load(Server.MapPath("/dil_cevirileri.xml"));
        //try
        //{
        //    
        //    ayarlar.baglan();
        //    ayarlar.cmd.Parameters.Clear();
        //    ayarlar.cmd.CommandText = "select *, count(*) as sayi from (select case when ISNULL(isler.tamamlanma_orani, 0) = 100 then 'BİTTİ' when ISNULL(isler.tamamlanma_orani, 0) = 0 then 'BEKLİYOR' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) and ISNULL(isler.tamamlanma_orani, 0) != 100 then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani, 0) > 0 and ISNULL(isler.tamamlanma_orani, 0) < 100 then 'DEVAM EDİYOR' else 'N' end as is_durum from ucgem_is_listesi isler where isler.durum = 'true' and isler.cop = 'false' and isler.firma_id = @firma_id and(SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = @kullanici_id) > 0) as tablo group by tablo.is_durum; select *, count(*) as sayi from (select case when ISNULL(isler.tamamlanma_orani, 0) = 100 then 'BİTTİ' when ISNULL(isler.tamamlanma_orani, 0) = 0 then 'BEKLİYOR' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) and ISNULL(isler.tamamlanma_orani, 0) != 100 then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani, 0) > 0 and ISNULL(isler.tamamlanma_orani, 0) < 100 then 'DEVAM EDİYOR' else 'N' end as is_durum from ucgem_is_listesi isler where isler.durum = 'true' and isler.firma_id = @firma_id and isler.ekleyen_id = @kullanici_id and isler.cop = 'false') as tablo group by tablo.is_durum; select * from(select id, departman_adi as adi, 'departman' as tip, 'Departmanlar' as grup from tanimlama_departman_listesi where firma_id = @firma_id and durum = 'true' and cop = 'false' and(SELECT COUNT(value) FROM STRING_SPLIT('72', ',') WHERE value = id) > 0 UNION select id, firma_adi, 'firma', 'Firmalar' from ucgem_firma_listesi where ekleyen_firma_id = @firma_id and durum = 'true' and cop = 'false' UNION select id, proje_adi, 'proje', 'Projeler' from ucgem_proje_listesi where firma_id = @firma_id and durum = 'true' and cop = 'false') etiketler order by adi asc";
        //    ayarlar.cmd.Parameters.Add("kullanici_id", SessionManager.CurrentUser.kullanici_id);
        //    ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        //    ayarlar.cmd.Parameters.Add("departmanlar", HttpUtility.UrlDecode(SessionManager.CurrentUser.departmanlar));
        //    SqlDataAdapter sda_benler = new SqlDataAdapter(ayarlar.cmd);
        //    DataSet ds_benler = new DataSet();
        //    sda_benler.Fill(ds_benler);

        //    int bana_verilen_baslanmamis_int = 0;
        //    int bana_verilen_devameden_int = 0;
        //    int bana_verilen_geciken_int = 0;
        //    int bana_verilen_tamamlanan_int = 0;

        //    int baskasina_baslanmamis_int = 0;
        //    int baskasina_devameden_int = 0;
        //    int baskasina_geciken_int = 0;
        //    int baskasina_tamamlanan_int = 0;

        //    int departman_baslanmamis_int = 0;
        //    int departman_devameden_int = 0;
        //    int departman_gecikmis_int = 0;
        //    int departman_tamamlanan_int = 0;


        //    foreach (DataRow item in ds_benler.Tables[0].Rows)
        //    {
        //        if (item["is_durum"].ToString() == "GECIKTI")
        //        {
        //            bana_verilen_geciken_int = Convert.ToInt32(item["sayi"]);
        //        }
        //        else if (item["is_durum"].ToString() == "BEKLIYOR")
        //        {
        //            bana_verilen_baslanmamis_int = Convert.ToInt32(item["sayi"]);
        //        }
        //        else if (item["is_durum"].ToString() == "DEVAM EDIYOR")
        //        {
        //            bana_verilen_devameden_int = Convert.ToInt32(item["sayi"]);
        //        }
        //        else if (item["is_durum"].ToString() == "BITTI")
        //        {
        //            bana_verilen_tamamlanan_int = Convert.ToInt32(item["sayi"]);
        //        }

        //    }

        //    /*
        //    ayarlar.baglan();
        //    ayarlar.cmd.Parameters.Clear();
        //    ayarlar.cmd.CommandText = "select *, count(*) as sayi from (select case when isler.durum = 'false' then 'İPTAL' when ISNULL(isler.tamamlanma_orani,0)= 100 then 'BİTTİ' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani,0)= 0 then 'BEKLİYOR' when ISNULL(isler.tamamlanma_orani,0)< 100 then 'DEVAM EDİYOR' end as is_durum from ucgem_is_listesi isler join ucgem_firma_kullanici_listesi ekleyen on ekleyen.id = isler.ekleyen_id where isler.durum = 'true' and isler.firma_id = @firma_id and (select top 1 metin from dbo.Split(replace(isler.gorevliler,'null','0'), ',') where metin != '' + @kullanici_id + '' and dbo.isReallyNumeric(metin)=1)>0 and isler.ekleyen_id = @kullanici_id and isler.cop = 'false') as tablo group by tablo.is_durum";
        //    ayarlar.cmd.Parameters.Add("kullanici_id", SessionManager.CurrentUser.kullanici_id);
        //    ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        //    SqlDataAdapter sda_baskalari = new SqlDataAdapter(ayarlar.cmd);
        //    DataSet ds_baskalari = new DataSet();
        //    sda_baskalari.Fill(ds_baskalari);*/


        //    foreach (DataRow item in ds_benler.Tables[1].Rows)
        //    {
        //        if (item["is_durum"].ToString() == "GECIKTI")
        //        {
        //            baskasina_geciken_int = Convert.ToInt32(item["sayi"]);
        //        }
        //        else if (item["is_durum"].ToString() == "BEKLIYOR")
        //        {
        //            baskasina_baslanmamis_int = Convert.ToInt32(item["sayi"]);
        //        }
        //        else if (item["is_durum"].ToString() == "DEVAM EDIYOR")
        //        {
        //            baskasina_devameden_int = Convert.ToInt32(item["sayi"]);
        //        }
        //        else if (item["is_durum"].ToString() == "BITTI")
        //        {
        //            baskasina_tamamlanan_int = Convert.ToInt32(item["sayi"]);
        //        }
        //    }


        //    sayac_departman.CssClass = "select2";

        //    /*
        //   ayarlar.baglan();
        //   ayarlar.cmd.Parameters.Clear();
        //   ayarlar.cmd.CommandText = "select * from (select id, departman_adi as adi, 'departman' as tip, 'Departmanlar' as grup from tanimlama_departman_listesi where firma_id = @firma_id and durum = 'true' and cop = 'false' and (SELECT COUNT(value) FROM STRING_SPLIT(@departmanlar, ',') WHERE value = id) > 0 UNION select id, firma_adi, 'firma', 'Firmalar' from ucgem_firma_listesi where ekleyen_firma_id = @firma_id and durum = 'true' and cop = 'false' UNION select id, proje_adi, 'proje', 'Projeler' from ucgem_proje_listesi where firma_id = @firma_id and durum = 'true' and cop = 'false') etiketler order by adi asc";
        //   ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
        //   ayarlar.cmd.Parameters.Add("departmanlar", HttpUtility.UrlDecode(SessionManager.CurrentUser.departmanlar));
        //   SqlDataAdapter sda_departman = new SqlDataAdapter(ayarlar.cmd);
        //   DataSet ds_departman = new DataSet();
        //   sda_departman.Fill(ds_departman);*/


        //    ListItem itemss = new ListItem();
        //    itemss.Text = "Seçiniz";
        //    itemss.Value = "0";
        //    itemss.Selected = true;
        //    sayac_departman.Items.Add(itemss);

        //    foreach (DataRow drow in ds_benler.Tables[2].Rows)
        //    {
        //        ListItem item = new ListItem();
        //        item.Text = drow["adi"].ToString();
        //        item.Value = drow["tip"].ToString() + drow["id"].ToString();
        //        item.Attributes.Add("OptionGroup", drow["grup"].ToString());
        //        item.Attributes.Add("tip", drow["tip"].ToString());
        //        sayac_departman.Items.Add(item);
        //    }


        //    sayac_departman.Attributes.Add("onchange", "departman_degistim_sayac_getir();");

        //    bana_verilen_baslanmamis.Text = bana_verilen_baslanmamis_int.ToString();
        //    bana_verilen_devameden.Text = bana_verilen_devameden_int.ToString();
        //    bana_verilen_geciken.Text = bana_verilen_geciken_int.ToString();
        //    bana_verilen_tamamlanan.Text = bana_verilen_tamamlanan_int.ToString();
        //    baskasina_baslanmamis.Text = baskasina_baslanmamis_int.ToString();
        //    baskasina_devameden.Text = baskasina_devameden_int.ToString();
        //    baskasina_geciken.Text = baskasina_geciken_int.ToString();
        //    baskasina_tamamlanan.Text = baskasina_tamamlanan_int.ToString();


        //    ayarlar.cnn.Close();
        //}
        //catch (Exception ex)
        //{
        //    Response.Write(ex.Message);
        //}
    }


    public class TaskState
    {
       public int bana_verilen_baslanmamis_int { get; set; }
       public int bana_verilen_devameden_int { get; set; }
        public int bana_verilen_geciken_int { get; set; }
        public int bana_verilen_tamamlanan_int { get; set; }

        public int baskasina_baslanmamis_int { get; set; }
        public int baskasina_devameden_int { get; set; }
        public int baskasina_geciken_int { get; set; }
        public int baskasina_tamamlanan_int { get; set; }
    }


    [WebMethod]
    public static string TasksCounter()
    {
        TaskState taskState = new TaskState();

        try
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "select *, count(*) as sayi from (select case when ISNULL(isler.tamamlanma_orani, 0) = 100 then 'BİTTİ' when ISNULL(isler.tamamlanma_orani, 0) = 0 then 'BEKLİYOR' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) and ISNULL(isler.tamamlanma_orani, 0) != 100 then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani, 0) > 0 and ISNULL(isler.tamamlanma_orani, 0) < 100 then 'DEVAM EDİYOR' else 'N' end as is_durum from ucgem_is_listesi isler where isler.durum = 'true' and isler.cop = 'false' and isler.firma_id = @firma_id and(SELECT COUNT(value) FROM STRING_SPLIT(isler.gorevliler, ',') WHERE value = @kullanici_id) > 0) as tablo group by tablo.is_durum; select *, count(*) as sayi from (select case when ISNULL(isler.tamamlanma_orani, 0) = 100 then 'BİTTİ' when ISNULL(isler.tamamlanma_orani, 0) = 0 then 'BEKLİYOR' when getdate() > convert(datetime, isler.bitis_tarihi) + CONVERT(datetime, isler.bitis_saati) and ISNULL(isler.tamamlanma_orani, 0) != 100 then 'GECİKTİ' when ISNULL(isler.tamamlanma_orani, 0) > 0 and ISNULL(isler.tamamlanma_orani, 0) < 100 then 'DEVAM EDİYOR' else 'N' end as is_durum from ucgem_is_listesi isler where isler.durum = 'true' and isler.firma_id = @firma_id and isler.ekleyen_id = @kullanici_id and isler.cop = 'false') as tablo group by tablo.is_durum; select * from(select id, departman_adi as adi, 'departman' as tip, 'Departmanlar' as grup from tanimlama_departman_listesi where firma_id = @firma_id and durum = 'true' and cop = 'false' and(SELECT COUNT(value) FROM STRING_SPLIT('72', ',') WHERE value = id) > 0 UNION select id, firma_adi, 'firma', 'Firmalar' from ucgem_firma_listesi where ekleyen_firma_id = @firma_id and durum = 'true' and cop = 'false' UNION select id, proje_adi, 'proje', 'Projeler' from ucgem_proje_listesi where firma_id = @firma_id and durum = 'true' and cop = 'false') etiketler order by adi asc";
            ayarlar.cmd.Parameters.Add("kullanici_id", SessionManager.CurrentUser.kullanici_id);
            ayarlar.cmd.Parameters.Add("firma_id", SessionManager.CurrentUser.firma_id);
            ayarlar.cmd.Parameters.Add("departmanlar", HttpUtility.UrlDecode(SessionManager.CurrentUser.departmanlar));
            SqlDataAdapter sda_benler = new SqlDataAdapter(ayarlar.cmd);
            DataSet ds_benler = new DataSet();
            sda_benler.Fill(ds_benler);

            foreach (DataRow item in ds_benler.Tables[0].Rows)
            {
                if (item["is_durum"].ToString() == "GECIKTI")
                {
                    taskState.bana_verilen_geciken_int = Convert.ToInt32(item["sayi"]);
                }
                else if (item["is_durum"].ToString() == "BEKLIYOR")
                {
                    taskState.bana_verilen_baslanmamis_int = Convert.ToInt32(item["sayi"]);
                }
                else if (item["is_durum"].ToString() == "DEVAM EDIYOR")
                {
                    taskState.bana_verilen_devameden_int = Convert.ToInt32(item["sayi"]);
                }
                else if (item["is_durum"].ToString() == "BITTI")
                {
                    taskState.bana_verilen_tamamlanan_int = Convert.ToInt32(item["sayi"]);
                }

            }

            foreach (DataRow item in ds_benler.Tables[1].Rows)
            {
                if (item["is_durum"].ToString() == "GECIKTI")
                {
                    taskState.baskasina_geciken_int = Convert.ToInt32(item["sayi"]);
                }
                else if (item["is_durum"].ToString() == "BEKLIYOR")
                {
                    taskState.baskasina_baslanmamis_int = Convert.ToInt32(item["sayi"]);
                }
                else if (item["is_durum"].ToString() == "DEVAM EDIYOR")
                {
                    taskState.baskasina_devameden_int = Convert.ToInt32(item["sayi"]);
                }
                else if (item["is_durum"].ToString() == "BITTI")
                {
                    taskState.baskasina_tamamlanan_int = Convert.ToInt32(item["sayi"]);
                }
            }

            ayarlar.cnn.Close();

            return JsonConvert.SerializeObject(taskState);
        }
        catch (Exception e)
        {
            throw e;
        }
    }

    [WebMethod]
    public static string TaskFilter()
    {
        int UserID = SessionManager.CurrentUser.kullanici_id;
        DataTable dt = new DataTable();
        try
        {
            ayarlar.baglan();
            ayarlar.cmd.Parameters.Clear();
            ayarlar.cmd.CommandText = "select is_tablo_gorunum as is_tablo_gorunum, isnull(is_tablo_sayi,10) as is_tablo_sayi from ucgem_firma_kullanici_listesi where id = @userID";
            ayarlar.cmd.Parameters.AddWithValue("@userID", UserID);
            ayarlar.cmd.ExecuteNonQuery();

            SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
            sda.Fill(dt);
            ayarlar.cnn.Close();
        }
        catch (Exception e)
        {
            throw e;
        }

        return JsonConvert.SerializeObject(dt);
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