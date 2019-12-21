using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Xml;
using System.Net;
using System.Text;
using System.Data;

namespace Ahtapot.App_Code.ayarlar
{

    public class ayarlar
    {
        /*public XmlDocument doc = new XmlDocument();

        private bool girdimi = false;
        public void yukle()
        {
            if (!girdimi)
            {
                girdimi = true;
                doc.Load(HttpContext.Current.Server.MapPath("/dil_cevirileri.xml"));
            }
        }

        public string LNG(string kelime)
        {
            yukle();
            string dil = HttpContext.Current.Request.Cookies["kullanici"]["dil_secenek"].ToString();
            XmlNodeList nodes = doc.DocumentElement.SelectNodes("/diller/dil");

            foreach (XmlNode node in nodes)
            {
                string EnglishText = node.SelectSingleNode("turkce").InnerText;
                if (kelime == EnglishText)
                {
                    kelime = node.SelectSingleNode(dil).InnerText;
                }
            }
            return kelime;
        }
        */


        public static SqlConnection cnn = new SqlConnection();
        public static SqlCommand cmd = new SqlCommand();

        public const string PushOverAppKey = "a11zsk3q4qbd68y4244hg63biae61i";
        public const string PushOverGroupKey = "gqnjg2j1nkug4ochygfs7veyq5akdc";

        public static void baglan()
        {
            if (cnn.State == System.Data.ConnectionState.Closed)
            {
                cnn.ConnectionString = WebConfigurationManager.ConnectionStrings["Baglantim"].ConnectionString;
                cnn.Open();
                cmd.Connection = cnn;
            }
        }
        public static bool IsNumeric(string s)
        {
            float output;
            return float.TryParse(s, out output);
        }


        private static string XMLPOST(string PostAddress, string xmlData)
        {
            try
            {
                System.Net.WebClient wUpload = new System.Net.WebClient();
                HttpWebRequest request = WebRequest.Create(PostAddress) as HttpWebRequest;
                request.Method = "POST";
                request.ContentType = "application/x-www-form-urlencoded";
                Byte[] bPostArray = Encoding.UTF8.GetBytes(xmlData);
                Byte[] bResponse = wUpload.UploadData(PostAddress, "POST", bPostArray);
                Char[] sReturnChars = Encoding.UTF8.GetChars(bResponse);
                string sWebPage = new string(sReturnChars);
                return sWebPage;
            }
            catch
            {
                return "-1";
            }
        }


        public static void NetGSM_SMS(string numara, string mesaj)
        {
            baglan();
            cmd.Parameters.Clear();
            cmd.CommandText = "select ISNULL(sms_entegrasyon, 0) as sms_entegrasyon from ucgem_firma_listesi where yetki_kodu = 'BOSS'";
            SqlDataAdapter sqlData = new SqlDataAdapter(cmd);
            DataTable dtSmsKontrol = new DataTable();
            sqlData.Fill(dtSmsKontrol);

            if (Convert.ToBoolean(dtSmsKontrol.Rows[0]["sms_entegrasyon"]))
            {
                string ss = "";
                ss += "<?xml version='1.0' encoding='UTF-8'?>";
                ss += "<mainbody>";
                ss += "<header>";
                ss += "<company>NETGSM</company>";
                ss += "<usercode>8508406149</usercode>";
                ss += "<password>W3KF5XRT</password>";
                ss += "<startdate></startdate>";
                ss += "<stopdate></stopdate>";
                ss += "<type>1:n</type>";
                ss += "<msgheader>ESOTOMASYON</msgheader>";
                ss += "</header>";
                ss += "<body>";
                ss += "<msg><![CDATA[" + mesaj + "]]></msg>";
                ss += "<no>" + numara + "</no>";
                ss += "</body>";
                ss += "</mainbody>";

                string donus = XMLPOST("http://api.netgsm.com.tr/xmlbulkhttppost.asp", ss);
            }

            //HttpContext.Current.Response.Write(donus);
        }


        public static string DakikSMSMesajGonder(string numaralar, string mesaj)
        {
            /*
            numaralar = numaralar.Replace(" ", string.Empty);
            numaralar = numaralar.Replace(' ', '(');
            numaralar = numaralar.Replace(' ', ')');
            numaralar = numaralar.Replace(' ', ' ');
            numaralar = numaralar.Trim();
            string ApiAdres = "http://www.dakiksms.com/api/tr/xml_api_ileri.php";
            string kullaniciAdi = "8506766646", sifre = "J206re15", baslik = "UCGEM";
            string xmlDesen = "<SMS><oturum><kullanici>" + kullaniciAdi + "</kullanici><sifre>" + sifre + "</sifre></oturum><mesaj><baslik>" + baslik + "</baslik><metin>" + mesaj + "</metin><alicilar>" + numaralar.ToString() + "</alicilar><tarih></tarih></mesaj></SMS>";
            WebRequest request = WebRequest.Create(ApiAdres);
            request.Method = "POST";
            byte[] byteArray = Encoding.UTF8.GetBytes(xmlDesen);
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = byteArray.Length;
            Stream dataStream = request.GetRequestStream();
            dataStream.Write(byteArray, 0, byteArray.Length);
            dataStream.Close();
            WebResponse response = request.GetResponse();
            Console.WriteLine(((HttpWebResponse)response).StatusDescription);
            dataStream = response.GetResponseStream();
            StreamReader reader = new StreamReader(dataStream);
            string responseFromServer = reader.ReadToEnd();
            reader.Close();
            dataStream.Close();
            response.Close();
            return responseFromServer;*/
            return "false";
        }
        /*
        Function dakik_postsms(sms_baslik, sms_metin, sms_telefon, referans_no, deparID)

        on error resume next

        if len(sms_telefon) = 12 then
            sms_telefon = sms_telefon
        elseif len(sms_telefon) = 11 then
            sms_telefon = "9" & sms_telefon
        elseif len(sms_telefon) = 10 then
            sms_telefon = "90" & sms_telefon
        end if

	    StrXML = "<SMS>"&_
	       "<oturum>"&_
		      "<kullanici>8506673757</kullanici>"&_
		      "<sifre>mesa2518mesa</sifre>"&_
	       "</oturum>"&_
	       "<mesaj>"&_
		      "<baslik>"& sms_baslik &"</baslik>"&_
		      "<metin>"& sms_metin &"</metin>"&_
		      "<alicilar>"& sms_telefon &"</alicilar>"&_
	       "</mesaj>"&_
	    "</SMS>"

	    donen_xml =  HTTPPoster("http://dakiksms.com/api/xml_api.php", strXML)
        giden_xml = StrXML

        durum = "true"
        cop = "false"
        firma_kodu = Request.Cookies("v1cnt")("firma_kodu")
        firma_id = Request.Cookies("v1cnt")("firma_id")
        ekleyen_id = Request.Cookies("v1cnt")("kullanici_id")
        ekleyen_ip = Request.ServerVariables("Remote_Addr")
        ekleme_tarihi = date
        ekleme_saati = time

        sql="insert into travboss_xml_dakiksms_gonderileri(sms_baslik, sms_metin, sms_telefon, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati, giden_xml, donen_xml, referans_no, deparID) values('"& sms_baslik &"', '"& sms_metin &"', '"& sms_telefon &"', '"& durum &"', '"& cop &"', '"& firma_kodu &"', '"& firma_id &"', '"& ekleyen_id &"', '"& ekleyen_ip &"', '"& ekleme_tarihi &"', '"& ekleme_saati &"', '"& giden_xml &"', '"& donen_xml &"', '"& referans_no &"', '"& deparID &"')"
        set ekle = baglanti.execute(SQL)

        dakik_postsms = donen_xml

    End Function

            */
        public static string nekadaronce(DateTime d)
        {
            // 1.
            // Get time span elapsed since the date.
            TimeSpan s = DateTime.Now.Subtract(d);

            // 2.
            // Get total number of days elapsed.
            int dayDiff = (int)s.TotalDays;

            // 3.
            // Get total number of seconds elapsed.
            int secDiff = (int)s.TotalSeconds;

            // 4.
            // Don't allow out of range values.
            if (dayDiff < 0 || dayDiff >= 31)
            {
                return null;
            }

            // 5.
            // Handle same-day times.
            if (dayDiff == 0)
            {
                // A.
                // Less than one minute ago.
                if (secDiff < 60)
                {
                    return "henüz";
                }
                // B.
                // Less than 2 minutes ago.
                if (secDiff < 120)
                {
                    return "1 dakika önce";
                }
                // C.
                // Less than one hour ago.
                if (secDiff < 3600)
                {
                    return string.Format("{0} dakika önce",
                        Math.Floor((double)secDiff / 60));
                }
                // D.
                // Less than 2 hours ago.
                if (secDiff < 7200)
                {
                    return "1 saat önce";
                }
                // E.
                // Less than one day ago.
                if (secDiff < 86400)
                {
                    return string.Format("{0} saat önce",
                        Math.Floor((double)secDiff / 3600));
                }
            }
            // 6.
            // Handle previous days.
            if (dayDiff == 1)
            {
                return "yesterday";
            }
            if (dayDiff < 7)
            {
                return string.Format("{0} gün önce",
                    dayDiff);
            }
            if (dayDiff < 31)
            {
                return string.Format("{0} hafta önce",
                    Math.Ceiling((double)dayDiff / 7));
            }
            return null;
        }

        public static string GetCookie(string cookieName)
        {
            try
            {
                cookieName = cookieName.Replace("_", "%5F");
                cookieName = HttpUtility.UrlDecode(HttpContext.Current.Request.Cookies["ucgem"][cookieName]);
            }
            catch (Exception)
            {
                cookieName = string.Empty;
            }
            return cookieName;
        }


    }
}