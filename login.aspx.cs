using Ahtapot.App_Code.ayarlar;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

public partial class login : System.Web.UI.Page
{
    [WebMethod]
    public static string LoginControl(string email, string password, string dil_secenek, string remember)
    {
        string kontrol_donus = "false";




        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select isnull(gorev.yetkili_sayfalar,1) as yetkili_sayfalar , kullanici.*, firma.firma_hid, firma.id as firma_id from ucgem_firma_kullanici_listesi kullanici join ucgem_firma_listesi firma on firma.id = kullanici.firma_id join tanimlama_gorev_listesi gorev on gorev.id = kullanici.gorevler where kullanici.durum = 'true' and kullanici.cop = 'false' and kullanici.personel_eposta = @email and kullanici.personel_parola = @password;";
        ayarlar.cmd.Parameters.Add("email", email);
        ayarlar.cmd.Parameters.Add("password", password);
        SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
        DataSet ds = new DataSet();
        sda.Fill(ds);

        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow kayitlar = ds.Tables[0].Rows[0];


                ayarlar.baglan();
                ayarlar.cmd.Parameters.Clear();
                ayarlar.cmd.CommandText = "update ucgem_firma_kullanici_listesi set dil = @dil where id = @id";
                ayarlar.cmd.Parameters.Add("dil", dil_secenek);
                ayarlar.cmd.Parameters.Add("id", kayitlar["id"].ToString());
                ayarlar.cmd.ExecuteNonQuery();


                kontrol_donus = "true";

                Kullanici kullanici = new Kullanici();
                kullanici.default_pb = "Auto";
                kullanici.dil_secenek = kayitlar["dil"].ToString().Equals(null) ? "turkce" : dil_secenek;
                kullanici.yetki_kodu = kayitlar["yetki_kodu"].ToString();
                kullanici.firma_kodu = kayitlar["firma_kodu"].ToString();
                kullanici.firma_hid = kayitlar["firma_hid"].ToString();
                kullanici.kullanici_hid = kayitlar["kullanici_hid"].ToString();
                kullanici.resim = kayitlar["personel_resim"].ToString();
                kullanici.firma_id = Convert.ToInt32(kayitlar["firma_id"]);
                kullanici.kullanici_id = Convert.ToInt32(kayitlar["id"]);
                kullanici.ekleyen_id = Convert.ToInt32(kayitlar["id"]);
                kullanici.kullanici_adi = kayitlar["personel_eposta"].ToString();
                kullanici.departmanlar = kayitlar["departmanlar"].ToString();
                kullanici.yetkili_sayfalar = " ," + kayitlar["yetkili_sayfalar"].ToString();
                kullanici.kullanici_adsoyad = kayitlar["personel_ad"].ToString() + " " + kayitlar["personel_soyad"].ToString();
                kullanici.durum = kayitlar["durum"].ToString();
                kullanici.login = "true";
                kullanici.login_tarih = DateTime.Now;
                kullanici.remember = remember;
                kullanici.Rolu = KullaniciRolleri.Admin;
                SessionManager.CurrentUser = kullanici;
                SessionManager.CurrentAdminLanguage = "tr";


                ayarlar.cmd.Parameters.Clear();
                ayarlar.cmd.CommandText = "insert into ucgem_firma_kullanici_giris_listesi(user_id, islem_tipi, islem_tarihi, islem_saati, islem_ip, islemid) values(@user_id, @islem_tipi, @islem_tarihi, @islem_saati, @islem_ip, @islemid)";
                ayarlar.cmd.Parameters.Add("user_id", kayitlar["id"]);
                ayarlar.cmd.Parameters.Add("islem_tipi", "login");
                ayarlar.cmd.Parameters.Add("islem_tarihi", DateTime.Now.ToString("yyyy-MM-dd"));
                ayarlar.cmd.Parameters.Add("islem_saati", DateTime.Now.ToString("HH:mm:ss"));
                ayarlar.cmd.Parameters.Add("islem_ip", HttpContext.Current.Request.ServerVariables["Remote_Addr"]);
                ayarlar.cmd.Parameters.Add("islemid", Guid.NewGuid().ToString());
                ayarlar.cmd.ExecuteNonQuery();


                FormsAuthenticationTicket tkt;
                string cookiestr;
                HttpCookie ck;
                tkt = new FormsAuthenticationTicket(1, kayitlar["personel_eposta"].ToString(), DateTime.Now, DateTime.Now.AddMinutes(600), Convert.ToBoolean(remember), "my custom data");
                cookiestr = FormsAuthentication.Encrypt(tkt);
                ck = new HttpCookie(FormsAuthentication.FormsCookieName, cookiestr);
                if (Convert.ToBoolean(remember))
                    ck.Expires = tkt.Expiration;
                ck.Path = FormsAuthentication.FormsCookiePath;
                HttpContext.Current.Response.Cookies.Add(ck);

                if (Convert.ToBoolean(remember))
                {
                    HttpCookie cookieR = new HttpCookie("r");
                    cookieR["r"] = "r";
                    cookieR.Expires = DateTime.Now.AddDays(7);
                    HttpContext.Current.Response.Cookies.Add(cookieR);
                }

            }
        }

        ayarlar.cnn.Close();

        return kontrol_donus;
    }
    public void UserList()
    {
        ayarlar.baglan();
        ayarlar.cmd.Parameters.Clear();
        ayarlar.cmd.CommandText = "select * from ucgem_firma_kullanici_listesi where durum = 'true' and cop = 'false'";
    }
}