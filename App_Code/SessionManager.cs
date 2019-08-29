using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// SessionManager için özet açıklama
/// </summary>
public class SessionManager
{
    public SessionManager() { }

    public static Kullanici CurrentUser
    {
        get
        {
            //try
            //{
            //    return (Kullanici)HttpContext.Current.Session["crntUsr"];
            //}
            //catch(Exception ex) { }

            HttpCookie cookie = HttpContext.Current.Request.Cookies["kullanici"];

            if (cookie == null) return null;

            Kullanici kullanici = new Kullanici();
            kullanici.default_pb = HttpUtility.UrlDecode(cookie["default_pb"].ToString());
            kullanici.dil_secenek =
                HttpUtility.UrlDecode(cookie["dil_secenek"].Equals(null) ? "turkce" : cookie["dil_secenek"].ToString());
            kullanici.yetki_kodu = HttpUtility.UrlDecode(cookie["yetki_kodu"].ToString());
            kullanici.firma_hid = HttpUtility.UrlDecode(cookie["firma_hid"].ToString());
            kullanici.firma_kodu = HttpUtility.UrlDecode(cookie["firma_kodu"].ToString());
            kullanici.kullanici_hid = HttpUtility.UrlDecode(cookie["kullanici_hid"].ToString());
            kullanici.firma_id = Convert.ToInt32(cookie["firma_id"]);
            kullanici.kullanici_id = Convert.ToInt32(cookie["kullanici_id"]);
            kullanici.ekleyen_id = Convert.ToInt32(cookie["ekleyen_id"]);
            kullanici.departmanlar = HttpUtility.UrlDecode(cookie["departmanlar"].ToString());
            kullanici.resim = HttpUtility.UrlDecode(cookie["resim"].ToString());
            kullanici.kullanici_adi = HttpUtility.UrlDecode(cookie["kullanici_adi"].ToString());
            kullanici.kullanici_adsoyad = HttpUtility.UrlDecode(cookie["kullanici_adsoyad"].ToString());
            kullanici.durum = HttpUtility.UrlDecode(cookie["durum"].ToString());
            kullanici.login = HttpUtility.UrlDecode(cookie["login"].ToString());
            kullanici.login_tarih = Convert.ToDateTime(cookie["login_tarih"]);
            kullanici.remember = HttpUtility.UrlDecode(cookie["remember"].ToString());
            kullanici.yetkili_sayfalar = HttpUtility.UrlDecode(cookie["yetkili_sayfalar"].ToString());
            kullanici.Rolu = KullaniciRolleri.Admin;

            /*
            if (HttpContext.Current.Session["RolKontrol"] == null)
            {
                SqlDataAccess acc = new SqlDataAccess();
                DataTable dtk = acc.Execute("select kullanici.id from ucgem_firma_kullanici_listesi kullanici where id = '" + kullanici.kullanici_id + "' and kullanici.personel_eposta = '"+ UIHelper.ReplaceAndClear(kullanici.kullanici_adi) + "'");
                if (dtk.Rows.Count > 0)
                {
                    HttpContext.Current.Session["RolKontrol"] = "OK";
                    return kullanici;
                }
                else return null;
            }
            else*/
            return kullanici;

            //return (Kullanici)HttpContext.Current.Session["crntUsr"];
        }
        set
        {
            Kullanici kullanici = (Kullanici)value;
            HttpCookie userCookie = new HttpCookie("kullanici");
            userCookie["default_pb"] = HttpUtility.UrlEncode(kullanici.default_pb);
            userCookie["dil_secenek"] = HttpUtility.UrlEncode(kullanici.dil_secenek);
            userCookie["yetki_kodu"] = HttpUtility.UrlEncode(kullanici.yetki_kodu);
            userCookie["firma_kodu"] = HttpUtility.UrlEncode(kullanici.firma_kodu);
            userCookie["firma_hid"] = HttpUtility.UrlEncode(kullanici.firma_hid);
            userCookie["kullanici_hid"] = HttpUtility.UrlEncode(kullanici.kullanici_hid);
            userCookie["firma_id"] = "" + HttpUtility.UrlEncode(kullanici.firma_id.ToString());
            userCookie["kullanici_id"] = "" + HttpUtility.UrlEncode(kullanici.kullanici_id.ToString());
            userCookie["ekleyen_id"] = "" + HttpUtility.UrlEncode(kullanici.ekleyen_id.ToString());
            userCookie["departmanlar"] = "" + HttpUtility.UrlEncode(HttpUtility.UrlEncode(kullanici.departmanlar.ToString()));
            userCookie["kullanici_adi"] = HttpUtility.UrlEncode(kullanici.kullanici_adi);
            userCookie["kullanici_adsoyad"] = HttpUtility.UrlEncode(kullanici.kullanici_adsoyad);
            userCookie["resim"] = HttpUtility.UrlEncode(kullanici.resim);
            userCookie["durum"] = HttpUtility.UrlEncode(kullanici.durum);
            userCookie["login"] = HttpUtility.UrlEncode(kullanici.login);
            userCookie["login_tarih"] = "" + HttpUtility.UrlEncode(kullanici.login_tarih.ToShortDateString());
            userCookie["remember"] = HttpUtility.UrlEncode(kullanici.remember);
            userCookie["yetkili_sayfalar"] = HttpUtility.UrlEncode(kullanici.yetkili_sayfalar);
            userCookie["rolu"] = "" + HttpUtility.UrlEncode(kullanici.Rolu.ToString());
            userCookie.Expires = DateTime.Now.AddDays(5);
            HttpContext.Current.Response.Cookies.Add(userCookie);

            //HttpContext.Current.Session["crntUsr"] = value;
        }
    }

    public static void LogOut()
    {
        HttpCookie cookie = HttpContext.Current.Request.Cookies["kullanici"];
        if (cookie != null)
        {
            cookie.Expires = DateTime.Now.AddMinutes(-100);
            HttpContext.Current.Response.Cookies.Add(cookie);
        }
        HttpCookie cookieR = HttpContext.Current.Request.Cookies["r"];
        if (cookieR != null)
        {
            cookieR.Expires = DateTime.Now.AddMinutes(-100);
            HttpContext.Current.Response.Cookies.Add(cookieR);
        }
    }

    public static string CurrentLanguage
    {
        get
        {
            if (HttpContext.Current.Request.QueryString["lang"] != null)
            {
                string lang = HttpContext.Current.Request.QueryString["lang"];
                foreach (string str in SiteSettings.SupportedLanguages)
                {
                    if (str == lang) { return lang; }
                }
                return SiteSettings.DefaultLanguage;
            }
            return SiteSettings.DefaultLanguage;
        }
    }

    public static string CurrentAdminLanguage
    {
        get
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies["lang"];

            if (cookie == null) return "en";
            return cookie["lang"].ToString();
        }
        set
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies["lang"];
            if (cookie != null) cookie["lang"] = value;

            HttpCookie userCookie = new HttpCookie("lang");
            userCookie["lang"] = value;
            userCookie.Expires = DateTime.Now.AddDays(5);
            HttpContext.Current.Response.Cookies.Add(userCookie);
        }
    }
}
