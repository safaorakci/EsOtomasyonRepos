using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Linq;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Xml;

public class UIHelper
{

    public static string trn(string url)
    {
        string newUrl;
        while ((newUrl = Uri.UnescapeDataString(url)) != url)
            url = newUrl;
        return newUrl;
    }
    public static string HashPassword(string password)
    {
        //return password;
        return FormsAuthentication.HashPasswordForStoringInConfigFile(password, "md5");
    }

    #region Client Information

    public static string GetClientIP()
    {
        string ip;

        ip = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (ip == string.Empty || ip == null)
        {
            ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }
        return ip;
    }

    #endregion

    #region String Operations

    /// <summary>
    /// Metin içerisinden Html etiketklerini temizler.
    /// </summary>
    /// <param name="htmlText"></param>
    /// <returns></returns>
    public static string ClearHtmlTags(string htmlText)
    {
        // return Regex.Replace(htmlText, "<[^>]*(>|$)", string.Empty);

        int index = 0;
        int indexEnd = 0;

        while (htmlText.IndexOf('<') > -1)
        {
            index = htmlText.IndexOf('<');
            if (htmlText.IndexOf('<') + 6 < htmlText.Length && htmlText.Substring(index + 1, 6) == "script") // script temizleme için özel kısım.
            {
                indexEnd = htmlText.IndexOf("</script>", index);
                if (indexEnd > -1)
                    htmlText = htmlText.Substring(0, index) + htmlText.Substring(indexEnd + 9);
                else
                    htmlText = htmlText.Substring(0, index);
            }
            else
            {
                indexEnd = htmlText.IndexOf('>', index);
                if (indexEnd > -1)
                    htmlText = htmlText.Substring(0, index) + htmlText.Substring(indexEnd + 1);
                else
                    htmlText = htmlText.Substring(0, index);
            }
        }

        return htmlText.Trim();
    }

    /// <summary>
    /// Metin boyutunu kısaltır. Cümleyi yarıda kesmez.
    /// </summary>
    /// <param name="text"></param>
    /// <param name="maxLength"></param>
    /// <returns></returns>
    public static string TrimSentences(string text, int maxLength)
    {
        if (text.Length > 300)
        {
            int lastindex = text.LastIndexOf('.', maxLength);
            if (lastindex > 0) text = text.Substring(0, lastindex);
        }
        else
        {
            int lastindex = text.LastIndexOf('.');
            if (lastindex > 0) text = text.Substring(0, lastindex);
        }
        return text;
    }

    public static string ReplaceWhiteSpace(string text)
    {
        return text.Replace("\r\n", "<br/>");
    }
    public static string ReplaceBreakRow(string text)
    {
        return text.Replace("<br/>", "\r\n");
    }


    public static string FillEmptySpace(string str, int count, char charToFillWith)
    {
        int length = str.Length;
        for (int i = 0; i < count - length; i++)
        {
            str = "" + charToFillWith + str;
        }
        return str;
    }
    public static string FormatMoney(decimal money)
    {
        return String.Format("{0:###,###,##0.00} TL", money);
    }

    public static string CurrencyLetter(string currency)
    {
        if (currency == "TL")
            return "TL";
        if (currency == "USD")
            return "$";
        if (currency == "EUR")
            return "€";
        else
            return "TL";
    }

    public static string CheckString(object obj)
    {
        if (obj != null)
            if (!Convert.IsDBNull(obj))
                return (string)obj;
            else
                return "";
        else
            return "";
    }
    public static bool CheckBool(object obj)
    {
        return ((Convert.ToInt16(obj)) == 1) ? true : false;
    }
    public static string ReplaceAll(string text)
    {
        text = text.Replace("'", "''");
        text = text.Replace("\"", "&quot;");
        text = text.Replace(">", "&gt;");
        text = text.Replace("<", "&lt;");
        text = text.Replace("--", "");
        return text;
    }
    public static string ReplaceAndClear(string text)
    {
        text = text.Replace("'", "");
        text = text.Replace("#", "");
        text = text.Replace("$", "");
        text = text.Replace(";", "");
        text = text.Replace("%", "");
        text = text.Replace("\"", "");
        text = text.Replace(">", "");
        text = text.Replace("<", "");
        text = text.Replace("-", "");
        if (text.ToLower().IndexOf("indert") >= 0) return "";
        if (text.ToLower().IndexOf("select") >= 0) return "";
        if (text.ToLower().IndexOf("update") >= 0) return "";
        if (text.ToLower().IndexOf("delete") >= 0) return "";
        if (text.ToLower().IndexOf("script") >= 0) return "";
        return text;
    }

    public static string Replace(string text)
    {
        text = text.Replace("'", "''");

        return text;
    }

    public static string ReplaceTurkishCharacters(string text)
    {
        text = text.Replace("ç", "c").Replace("ı", "i").Replace("ğ", "g").Replace("ö", "o").Replace("ş", "s").Replace("ü", "u");
        text = text.Replace("Ç", "C").Replace("İ", "I").Replace("Ğ", "G").Replace("Ö", "O").Replace("Ş", "S").Replace("Ü", "U");
        return text;
    }

    public static string GenerateURL(string text)
    {
        text = UIHelper.ReplaceTurkishCharacters(text.ToLower().Trim());
        text = text.Replace("&", "");
        text = text.Replace("$", "");
        text = text.Replace("!", "");
        text = text.Replace(" ", "-");
        text = text.Replace("'", "");
        text = text.Replace("\"", "");
        text = text.Replace("/", "");
        text = text.Replace("@", "");
        text = text.Replace("?", "");
        text = text.Replace("---", "-");
        text = text.Replace("---", "-");
        text = text.Replace("--", "-");
        return text;
    }

    #endregion

    #region Date Operations

    public static string GetMonthName(int month)
    {
        return GetMonthName(month, "tr");
    }
    public static string GetMonthName(int month, string languageCode)
    {
        if (languageCode == "tr")
        {
            switch (month)
            {
                case 1:
                    return "Ocak";
                case 2:
                    return "Şubat";
                case 3:
                    return "Mart";
                case 4:
                    return "Nisan";
                case 5:
                    return "Mayıs";
                case 6:
                    return "Haziran";
                case 7:
                    return "Temmuz";
                case 8:
                    return "Ağustos";
                case 9:
                    return "Eylül";
                case 10:
                    return "Ekim";
                case 11:
                    return "Kasım";
                case 12:
                    return "Aralık";
                default:
                    return "Ocak";
            }
        }
        else if (languageCode == "en")
        {
            switch (month)
            {
                case 1:
                    return "January";
                case 2:
                    return "February";
                case 3:
                    return "March";
                case 4:
                    return "April";
                case 5:
                    return "May";
                case 6:
                    return "June";
                case 7:
                    return "July";
                case 8:
                    return "August";
                case 9:
                    return "September";
                case 10:
                    return "October";
                case 11:
                    return "November";
                case 12:
                    return "December";
                default:
                    return "January";
            }
        }
        return "";
    }
    public static string GetDayName(DayOfWeek dayOfWeek)
    {
        switch (dayOfWeek)
        {
            case DayOfWeek.Friday:
                return "Cuma";
            case DayOfWeek.Monday:
                return "Pazartesi";
            case DayOfWeek.Saturday:
                return "Cumartesi";
            case DayOfWeek.Sunday:
                return "Pazar";
            case DayOfWeek.Thursday:
                return "Perşembe";
            case DayOfWeek.Tuesday:
                return "Salı";
            case DayOfWeek.Wednesday:
                return "Çarşamba";
            default:
                return "";
        }
    }
    public static string GetDayAbbrevation(DayOfWeek dayOfWeek)
    {
        return GetDayAbbrevation(dayOfWeek, "tr");
    }
    public static string GetDayAbbrevation(DayOfWeek dayOfWeek, string languageCode)
    {
        if (languageCode == "tr")
        {
            switch (dayOfWeek)
            {
                case DayOfWeek.Friday:
                    return "Cma";
                case DayOfWeek.Monday:
                    return "Pzt";
                case DayOfWeek.Saturday:
                    return "Cmt";
                case DayOfWeek.Sunday:
                    return "Paz";
                case DayOfWeek.Thursday:
                    return "Per";
                case DayOfWeek.Tuesday:
                    return "Sal";
                case DayOfWeek.Wednesday:
                    return "Çar";
                default:
                    return "";
            }
        }
        else if (languageCode == "en")
        {
            switch (dayOfWeek)
            {
                case DayOfWeek.Friday:
                    return "Fri";
                case DayOfWeek.Monday:
                    return "Mon";
                case DayOfWeek.Saturday:
                    return "Sat";
                case DayOfWeek.Sunday:
                    return "Sun";
                case DayOfWeek.Thursday:
                    return "Thu";
                case DayOfWeek.Tuesday:
                    return "Tue";
                case DayOfWeek.Wednesday:
                    return "Wed";
                default:
                    return "";
            }
        }
        else return "";
    }

    #endregion

    #region Mail

    public static void SendMail(string from, string fromDisplayName, string to, string subject, string bodyHtml, string hostName, string username, string password)
    {
        MailMessage mail = new MailMessage();
        MailAddress adr = new MailAddress(from, fromDisplayName);
        mail.From = adr;
        mail.To.Add(to);
        mail.Subject = subject;

        mail.IsBodyHtml = true;
        mail.Body = bodyHtml;

        SmtpClient client = new SmtpClient();
        //client.Port = 465;
        client.Host = hostName;
        client.Credentials = new System.Net.NetworkCredential(username, password);
        client.Send(mail);
    }

    #endregion

    #region Validation

    /// <summary>
    /// T.C. kimlik numarasının doğru olup olmamasını
    /// algoritma kontrolü ile kontrol eder.
    /// 
    /// Kural şu şekildedir.
    /// --------------------
    /// TC Kimlik numaraları 11 basamaktan oluşmaktadır. İlk 9 basamak arasında kurulan bir algoritma bize 10. basmağı, ilk 10 basamak arasında kurulan algoritma ise bize 11. basamağı verir.
    /// * 11 hanelidir.
    /// * Her hanesi rakamsal değer içerir.
    /// * İlk hane 0 olamaz. 
    /// * 1. 3. 5. 7. ve 9. hanelerin toplamının 7 katından, 2. 4. 6. ve 8. hanelerin toplamı çıkartıldığında, elde edilen sonucun 10'a bölümünden kalan, yani Mod10'u bize 10. haneyi verir.
    /// * 1. 2. 3. 4. 5. 6. 7. 8. 9. ve 10. hanelerin toplamından elde edilen sonucun 10'a bölümünden kalan, yani Mod10'u bize 11. haneyi verir.
    /// </summary>
    /// <param name="tck"></param>
    /// <returns></returns>
    public static bool CheckNationatilyNumber(string tcKimlikNo)
    {
        if (tcKimlikNo.Length != 11) return false;

        long tck = 0;
        try
        {
            tck = long.Parse(tcKimlikNo);
        }
        catch (Exception ex)
        {
            return false;
        }

        char[] c = tcKimlikNo.ToCharArray();

        short c1 = Convert.ToInt16("" + c[0]);
        short c2 = Convert.ToInt16("" + c[1]);
        short c3 = Convert.ToInt16("" + c[2]);
        short c4 = Convert.ToInt16("" + c[3]);
        short c5 = Convert.ToInt16("" + c[4]);
        short c6 = Convert.ToInt16("" + c[5]);
        short c7 = Convert.ToInt16("" + c[6]);
        short c8 = Convert.ToInt16("" + c[7]);
        short c9 = Convert.ToInt16("" + c[8]);
        short c10 = Convert.ToInt16("" + c[9]);
        short c11 = Convert.ToInt16("" + c[10]);

        if (c1 == 0) return false;

        int total_1_9 = c1 + c3 + c5 + c7 + c9;
        int total_2_8 = c2 + c4 + c6 + c8;
        int total_1_10 = total_1_9 + total_2_8 + c10;

        int check10 = ((total_1_9 * 7) - total_2_8) % 10;
        if ("" + check10 != "" + c10) return false;

        int check11 = total_1_10 % 10;
        if ("" + check11 != "" + c11) return false;

        return true;

    }

    public const string _MatchNamePattern = @"[a-zA-Z]{3,24}";
    public const string _MatchEmailPattern = @"^(([\w-]+\.)+[\w-]+|([a-zA-Z]{1}|[\w-]{2,}))@"
                                               + @"((([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\."
                                               + @"([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])){1}|"
                                               + @"([a-zA-Z]+[\w-]+\.)+[a-zA-Z]{2,4})$";
    public const string _MatchPhonePattern = @"0\([1-9]{1}\)\([0-9]{9}\)";

    public static bool ValidateName(string text)
    {
        return Regex.IsMatch(text, _MatchNamePattern);
    }

    public static bool ValidateEmail(string text)
    {
        return Regex.IsMatch(text, _MatchEmailPattern);
    }

    public static bool ValidatePhoneNumber(string text)
    {
        // telefon 20 karakter string olacak.
        return Regex.IsMatch(text, _MatchPhonePattern);
    }


    #endregion

    #region Password & Encryption

    /// <summary>
    /// SHA algoritması kullanılarak şifreleme yapar.
    /// </summary>
    /// <param name="strPlain"></param>
    /// <returns></returns>
    public static string GetSHA256(string strPlain)
    {
        SHA256 sha = new SHA256Managed();
        byte[] hash = sha.ComputeHash(Encoding.ASCII.GetBytes(strPlain));
        StringBuilder stringBuilder = new StringBuilder();
        foreach (byte b in hash)
        {
            stringBuilder.AppendFormat("{0:x2}", b);
        }
        return stringBuilder.ToString();
    }

    /// <summary>
    /// Rasgele şifre üretir.
    /// Varsayılan uzunluk 8 karakter.
    /// </summary>
    /// <returns></returns>
    public static string GeneratePassword()
    {
        return GeneratePassword(8);
    }

    /// <summary>
    /// Rasgele şifre üretir.
    /// Varsayılan uzunluk 8 karakter.
    /// </summary>
    /// <returns></returns>
    public static string GeneratePassword(int length)
    {
        string sifre = "";
        string letters = "0123456789abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

        char[] lttrs = letters.ToCharArray();

        int number = 0;
        byte[] RandPass = new byte[1];
        RandomNumberGenerator rng = RandomNumberGenerator.Create();
        rng.GetBytes(RandPass);

        for (int i = 0; i < length; i++)
        {
            rng.GetBytes(RandPass);
            number = Convert.ToInt32(RandPass[0]);
            number = number % letters.Length;
            sifre += "" + lttrs[number];
        }

        return sifre;
    }

    /// <summary>
    /// Rasgele şifre üretir.
    /// Varsayılan uzunluk 8 karakter.
    /// </summary>
    /// <returns></returns>
    public static string GeneratePasswordNumbers(int length)
    {
        string sifre = "";
        string letters = "01234567890123456789";

        char[] lttrs = letters.ToCharArray();

        int number = 0;
        byte[] RandPass = new byte[1];
        RandomNumberGenerator rng = RandomNumberGenerator.Create();
        rng.GetBytes(RandPass);

        for (int i = 0; i < length; i++)
        {
            rng.GetBytes(RandPass);
            number = Convert.ToInt32(RandPass[0]);
            number = number % letters.Length;
            sifre += "" + lttrs[number];
        }

        return sifre;
    }


    /// <summary>
    /// Kullanıcılar üye olduktan sonra aktivasyon işlemi için aktivasyon kodu üretir.
    /// </summary>
    /// <returns></returns>
    public static string GenerateActivationCode()
    {
        return Guid.NewGuid().ToString("N");
    }

    #endregion

    #region Components Styling & Functionality

    /// <summary>
    /// Verilen textbox için default stilini, onfocus ve onblur stillerini ve javascriptini ekler.
    /// Sayfada Txt, TxtFocus ve TxtFilled stilleri bulunmalıdır.
    /// </summary>
    /// <param name="txt"></param>
    public static void ConfigureTextBox(TextBox txt)
    {
        txt.CssClass = "Txt";
        if (txt.Text != "") txt.CssClass = "TxtFilled";
        txt.Attributes["onfocus"] += "this.className='TxtFocus'; ";
        txt.Attributes["onblur"] += "this.className='Txt'; if(this.value != '') this.className='TxtFilled';  ";
    }

    /// <summary>
    /// Verilen textbox için default stilini, onfocus ve onblur stillerini ve javascriptini ekler.
    /// Zorunlu alanlar için kullanılır.
    /// Sayfada TxtReq, TxtFocus ve TxtFilled stilleri bulunmalıdır.
    /// </summary>
    /// <param name="txt"></param>
    /// <param name="IsRequiredField"></param>
    /// <param name="IDnumber"></param>
    /// <returns></returns>
    public static string ConfigureTextBox(TextBox txt, bool IsRequiredField, int IDnumber)
    {
        string scriptofReqTextboxes = "";

        txt.CssClass = ((txt.Text != "")) ? "TxtFilled" : "TxtReq";
        txt.Attributes["onfocus"] = "this.className='TxtFocus';";
        txt.Attributes["onblur"] = "this.className='TxtReq'; if(this.value != '') this.className='TxtFilled';  ";

        //scriptofReqTextboxes += " var txtReq" + IDnumber + " = document.getElementById('" + txt.ClientID + "'); ";
        //scriptofReqTextboxes += " if (txtReq" + IDnumber + ".value != '') txtReq" + IDnumber + ".className = 'TxtFilled'; ";

        return scriptofReqTextboxes;
    }


    /// <summary>
    /// Verilen checkboxListte seçili değerleri virgül ile ayırarak getirir.
    /// </summary>
    /// <param name="chk"></param>
    /// <returns></returns>
    public static string GetSelectedValues(CheckBoxList chk)
    {
        string IDs = "";
        foreach (ListItem item in chk.Items)
        {
            if (item.Selected) IDs += "," + item.Value;
        }
        if (IDs != "")
            return IDs.Substring(1);
        else
            return IDs;
    }

    public static void SetSelectedValues(CheckBoxList chk, string IDList)
    {
        string[] IDs = IDList.Split(',');
        foreach (string id in IDs)
        {
            foreach (ListItem item in chk.Items)
            {
                if (item.Value == id) { item.Selected = true; break; }
            }
        }
    }

    #endregion

    public static System.Xml.XmlDocument XmlParse(string xmlText)
    {
        XmlDocument xdoc = new XmlDocument();
        xdoc.LoadXml(xmlText);
        return xdoc;
    }

    #region Image Operations

    public static System.Drawing.Image FixedSize(string tempPath, int Width, int Height)
    {
        System.Drawing.Image imgPhoto = System.Drawing.Image.FromFile(tempPath);
        if (Width == 0 || Height == 0)
        {
            Width = imgPhoto.Width;
            Height = imgPhoto.Height;
        }
        int sourceWidth = imgPhoto.Width;
        int sourceHeight = imgPhoto.Height;
        int sourceX = 0;
        int sourceY = 0;
        int destX = 0;
        int destY = 0;

        float nPercent = 0;
        float nPercentW = 0;
        float nPercentH = 0;

        nPercentW = ((float)Width / (float)sourceWidth);
        nPercentH = ((float)Height / (float)sourceHeight);
        if (nPercentH < nPercentW)
        {
            nPercent = nPercentH;
            destX = System.Convert.ToInt16((Width - (sourceWidth * nPercent)) / 2);
        }
        else
        {
            nPercent = nPercentW;
            destY = System.Convert.ToInt16((Height - (sourceHeight * nPercent)) / 2);
        }

        int destWidth = (int)(sourceWidth * nPercent);
        int destHeight = (int)(sourceHeight * nPercent);

        System.Drawing.Bitmap bmPhoto = new System.Drawing.Bitmap(Width, Height, PixelFormat.Format24bppRgb);
        bmPhoto.SetResolution(imgPhoto.HorizontalResolution, imgPhoto.VerticalResolution);

        System.Drawing.Graphics grPhoto = System.Drawing.Graphics.FromImage(bmPhoto);
        grPhoto.Clear(System.Drawing.Color.Gray);
        grPhoto.InterpolationMode = InterpolationMode.HighQualityBicubic;

        grPhoto.DrawImage(imgPhoto, new System.Drawing.Rectangle(destX, destY, destWidth, destHeight), new System.Drawing.Rectangle(sourceX, sourceY, sourceWidth, sourceHeight), System.Drawing.GraphicsUnit.Pixel);
        grPhoto.Dispose();
        imgPhoto.Dispose();
        return bmPhoto;
    }
    public static System.Drawing.Image ScaleByPercent(System.Drawing.Image imgPhoto, int Percent)
    {
        float nPercent = ((float)Percent / 100);

        int sourceWidth = imgPhoto.Width;
        int sourceHeight = imgPhoto.Height;
        int sourceX = 0;
        int sourceY = 0;

        int destX = 0;
        int destY = 0;
        int destWidth = (int)(sourceWidth * nPercent);
        int destHeight = (int)(sourceHeight * nPercent);

        Bitmap bmPhoto = new Bitmap(destWidth, destHeight,
                                 PixelFormat.Format24bppRgb);
        bmPhoto.SetResolution(imgPhoto.HorizontalResolution,
                                imgPhoto.VerticalResolution);

        Graphics grPhoto = Graphics.FromImage(bmPhoto);
        grPhoto.InterpolationMode = InterpolationMode.HighQualityBicubic;

        grPhoto.DrawImage(imgPhoto,
            new Rectangle(destX, destY, destWidth, destHeight),
            new Rectangle(sourceX, sourceY, sourceWidth, sourceHeight),
            GraphicsUnit.Pixel);

        grPhoto.Dispose();
        return bmPhoto;
    }

    public static System.Drawing.Image FixedSize(string drawString, bool over)
    {

        int Width = 20 + (int)(drawString.Length * 7.8);
        int Height = 30;
        Font drawFont = new Font("Tahoma", 6);
        SolidBrush drawBrush = new SolidBrush(Color.Gray);
        PointF drawPoint = new PointF(8, 3);
        System.Drawing.Bitmap bmPhoto = new System.Drawing.Bitmap(Width, Height, System.Drawing.Imaging.PixelFormat.Format24bppRgb);
        bmPhoto.SetResolution(200, 200);
        System.Drawing.Graphics grPhoto = System.Drawing.Graphics.FromImage(bmPhoto);
        grPhoto.Clear(System.Drawing.Color.White);
        grPhoto.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
        grPhoto.DrawString(drawString, drawFont, drawBrush, drawPoint);
        grPhoto.Dispose();

        Color col = new Color();
        if (over)
        {
            col = Color.Turquoise;
        }
        else
        {
            col = Color.Gray;
        }
        for (int i = 5; i <= bmPhoto.Height - 7; i++)
        {
            bmPhoto.SetPixel(5, i - 1, col);
            bmPhoto.SetPixel(6, i - 1, col);
            bmPhoto.SetPixel(7, i - 1, col);
        }
        col = Color.Gray;
        for (int i = 10; i <= bmPhoto.Width - 5; i++)
        {
            bmPhoto.SetPixel(i, 24, col);
            bmPhoto.SetPixel(i, 25, col);
        }
        return bmPhoto;
    }
    public static System.Drawing.Image CropImageFile(System.Drawing.Image imgPhoto, int targetW, int targetH, int sourceX, int sourceY, int sourceW, int sourceH)
    {
        //System.Drawing.Image imgPhoto = System.Drawing.Image.FromStream(new MemoryStream(imageFile));
        System.Drawing.Bitmap bmPhoto = new System.Drawing.Bitmap(targetW, targetH, System.Drawing.Imaging.PixelFormat.Format24bppRgb);
        bmPhoto.SetResolution(72, 72);
        System.Drawing.Graphics grPhoto = System.Drawing.Graphics.FromImage(bmPhoto);
        grPhoto.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
        grPhoto.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
        grPhoto.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;
        grPhoto.DrawImage(imgPhoto, new System.Drawing.Rectangle(0, 0, targetW, targetH), sourceX, sourceY, sourceW, sourceH, System.Drawing.GraphicsUnit.Pixel);
        // Save out to memory and then to a file.  We dispose of all objects to make sure the files don't stay locked.
        System.IO.MemoryStream mm = new System.IO.MemoryStream();
        bmPhoto.Save(mm, System.Drawing.Imaging.ImageFormat.Jpeg);
        imgPhoto.Dispose();
        bmPhoto.Dispose();
        grPhoto.Dispose();

        System.Drawing.Image imgThumb = System.Drawing.Image.FromStream(mm);

        return imgThumb;
    }

    public static Bitmap ChangeOpacity(System.Drawing.Image img, float opacityvalue)
    {
        Bitmap bmp = new Bitmap(img.Width, img.Height); // Determining Width and Height of Source Image
        Graphics graphics = Graphics.FromImage(bmp);
        ColorMatrix colormatrix = new ColorMatrix();
        colormatrix.Matrix33 = opacityvalue;
        ImageAttributes imgAttribute = new ImageAttributes();
        imgAttribute.SetColorMatrix(colormatrix, ColorMatrixFlag.Default, ColorAdjustType.Bitmap);
        graphics.DrawImage(img, new Rectangle(0, 0, bmp.Width, bmp.Height), 0, 0, img.Width, img.Height, GraphicsUnit.Pixel, imgAttribute);
        graphics.Dispose();   // Releasing all resource used by graphics 
        return bmp;
    }

    public static System.Drawing.Image ResizeImage(System.Drawing.Image image, Size size, bool preserveAspectRatio = true)
    {
        int newWidth;
        int newHeight;
        if (preserveAspectRatio)
        {
            int originalWidth = image.Width;
            int originalHeight = image.Height;
            float percentWidth = (float)size.Width / (float)originalWidth;
            float percentHeight = (float)size.Height / (float)originalHeight;
            float percent = percentHeight < percentWidth ? percentHeight : percentWidth;
            newWidth = (int)(originalWidth * percent);
            newHeight = (int)(originalHeight * percent);
        }
        else
        {
            newWidth = size.Width;
            newHeight = size.Height;
        }
        System.Drawing.Image newImage = new Bitmap(newWidth, newHeight);
        using (Graphics graphicsHandle = Graphics.FromImage(newImage))
        {
            graphicsHandle.InterpolationMode = InterpolationMode.HighQualityBicubic;
            graphicsHandle.DrawImage(image, 0, 0, newWidth, newHeight);
        }
        return newImage;
    }
    #endregion

    #region MetaTag
    public static void AddMetaTag_Keywords(Page page, string keywords)
    {
        UIHelper.AddMetaTag(page, "keywords", keywords);
    }

    public static void AddMetaTag(Page page, string name, string value)
    {
        HtmlMeta meta = new HtmlMeta();
        meta.Name = name;
        meta.Content = value;
        page.Header.Controls.Add(meta);
    }
    #endregion

    #region Localization

    public static string GetCountryISOCode(string name)
    {
        switch (name)
        {
            case "Andorra": return "AD";
            case "United Arab Emirates": return "AE";
            case "Afghanistan": return "AF";
            case "Antigua and Barbuda": return "AG";
            case "Anguilla": return "AI";
            case "Albania": return "AL";
            case "Armenia": return "AM";
            case "Angola": return "AO";
            case "Antarctica": return "AQ";
            case "Argentina": return "AR";
            case "American Samoa": return "AS";
            case "Austria": return "AT";
            case "Australia": return "AU";
            case "Aruba": return "AW";
            case "Åland Islands": return "AX";
            case "Azerbaijan": return "AZ";
            case "Bosnia and Herzegovina": return "BA";
            case "Barbados": return "BB";
            case "Bangladesh": return "BD";
            case "Belgium": return "BE";
            case "Burkina Faso": return "BF";
            case "Bulgaria": return "BG";
            case "Bahrain": return "BH";
            case "Burundi": return "BI";
            case "Benin": return "BJ";
            case "Saint Barthélemy": return "BL";
            case "Bermuda": return "BM";
            case "Brunei Darussalam": return "BN";
            case "Bolivia, Plurinational State of": return "BO";
            case "Bonaire, Sint Eustatius and Saba": return "BQ";
            case "Brazil": return "BR";
            case "Bahamas": return "BS";
            case "Bhutan": return "BT";
            case "Bouvet Island": return "BV";
            case "Botswana": return "BW";
            case "Belarus": return "BY";
            case "Belize": return "BZ";
            case "Canada": return "CA";
            case "Cocos (Keeling) Islands": return "CC";
            case "Congo, the Democratic Republic of the": return "CD";
            case "Central African Republic": return "CF";
            case "Congo": return "CG";
            case "Switzerland": return "CH";
            case "Côte d'Ivoire": return "CI";
            case "Cook Islands": return "CK";
            case "Chile": return "CL";
            case "Cameroon": return "CM";
            case "China": return "CN";
            case "Colombia": return "CO";
            case "Costa Rica": return "CR";
            case "Cuba": return "CU";
            case "Cabo Verde": return "CV";
            case "Curaçao": return "CW";
            case "Christmas Island": return "CX";
            case "Cyprus": return "CY";
            case "Czech Republic": return "CZ";
            case "Germany": return "DE";
            case "Djibouti": return "DJ";
            case "Denmark": return "DK";
            case "Dominica": return "DM";
            case "Dominican Republic": return "DO";
            case "Algeria": return "DZ";
            case "Ecuador": return "EC";
            case "Estonia": return "EE";
            case "Egypt": return "EG";
            case "Western Sahara": return "EH";
            case "Eritrea": return "ER";
            case "Spain": return "ES";
            case "Ethiopia": return "ET";
            case "Finland": return "FI";
            case "Fiji": return "FJ";
            case "Falkland Islands (Malvinas)": return "FK";
            case "Micronesia, Federated States of": return "FM";
            case "Faroe Islands": return "FO";
            case "France": return "FR";
            case "Gabon": return "GA";
            case "United Kingdom": return "GB";
            case "Grenada": return "GD";
            case "Georgia": return "GE";
            case "French Guiana": return "GF";
            case "Guernsey": return "GG";
            case "Ghana": return "GH";
            case "Gibraltar": return "GI";
            case "Greenland": return "GL";
            case "Gambia": return "GM";
            case "Guinea": return "GN";
            case "Guadeloupe": return "GP";
            case "Equatorial Guinea": return "GQ";
            case "Greece": return "GR";
            case "South Georgia and the South Sandwich Islands": return "GS";
            case "Guatemala": return "GT";
            case "Guam": return "GU";
            case "Guinea-Bissau": return "GW";
            case "Guyana": return "GY";
            case "Hong Kong": return "HK";
            case "Heard Island and McDonald Islands": return "HM";
            case "Honduras": return "HN";
            case "Croatia": return "HR";
            case "Haiti": return "HT";
            case "Hungary": return "HU";
            case "Indonesia": return "ID";
            case "Ireland": return "IE";
            case "Israel": return "IL";
            case "Isle of Man": return "IM";
            case "India": return "IN";
            case "British Indian Ocean Territory": return "IO";
            case "Iraq": return "IQ";
            case "Iran, Islamic Republic of": return "IR";
            case "Iceland": return "IS";
            case "Italy": return "IT";
            case "Jersey": return "JE";
            case "Jamaica": return "JM";
            case "Jordan": return "JO";
            case "Japan": return "JP";
            case "Kenya": return "KE";
            case "Kyrgyzstan": return "KG";
            case "Cambodia": return "KH";
            case "Kiribati": return "KI";
            case "Comoros": return "KM";
            case "Saint Kitts and Nevis": return "KN";
            case "Korea, Democratic People's Republic of": return "KP";
            case "Korea, Republic of": return "KR";
            case "Kuwait": return "KW";
            case "Cayman Islands": return "KY";
            case "Kazakhstan": return "KZ";
            case "Lao People's Democratic Republic": return "LA";
            case "Lebanon": return "LB";
            case "Saint Lucia": return "LC";
            case "Liechtenstein": return "LI";
            case "Sri Lanka": return "LK";
            case "Liberia": return "LR";
            case "Lesotho": return "LS";
            case "Lithuania": return "LT";
            case "Luxembourg": return "LU";
            case "Latvia": return "LV";
            case "Libya": return "LY";
            case "Morocco": return "MA";
            case "Monaco": return "MC";
            case "Moldova, Republic of": return "MD";
            case "Montenegro": return "ME";
            case "Saint Martin (French part)": return "MF";
            case "Madagascar": return "MG";
            case "Marshall Islands": return "MH";
            case "Macedonia, the former Yugoslav Republic of": return "MK";
            case "Mali": return "ML";
            case "Myanmar": return "MM";
            case "Mongolia": return "MN";
            case "Macao": return "MO";
            case "Northern Mariana Islands": return "MP";
            case "Martinique": return "MQ";
            case "Mauritania": return "MR";
            case "Montserrat": return "MS";
            case "Malta": return "MT";
            case "Mauritius": return "MU";
            case "Maldives": return "MV";
            case "Malawi": return "MW";
            case "Mexico": return "MX";
            case "Malaysia": return "MY";
            case "Mozambique": return "MZ";
            case "Namibia": return "NA";
            case "New Caledonia": return "NC";
            case "Niger": return "NE";
            case "Norfolk Island": return "NF";
            case "Nigeria": return "NG";
            case "Nicaragua": return "NI";
            case "Netherlands": return "NL";
            case "Norway": return "NO";
            case "Nepal": return "NP";
            case "Nauru": return "NR";
            case "Niue": return "NU";
            case "New Zealand": return "NZ";
            case "Oman": return "OM";
            case "Panama": return "PA";
            case "Peru": return "PE";
            case "French Polynesia": return "PF";
            case "Papua New Guinea": return "PG";
            case "Philippines": return "PH";
            case "Pakistan": return "PK";
            case "Poland": return "PL";
            case "Saint Pierre and Miquelon": return "PM";
            case "Pitcairn": return "PN";
            case "Puerto Rico": return "PR";
            case "Palestine, State of": return "PS";
            case "Portugal": return "PT";
            case "Palau": return "PW";
            case "Paraguay": return "PY";
            case "Qatar": return "QA";
            case "Réunion": return "RE";
            case "Romania": return "RO";
            case "Serbia": return "RS";
            case "Russia": return "RU";
            case "Rwanda": return "RW";
            case "Saudi Arabia": return "SA";
            case "Solomon Islands": return "SB";
            case "Seychelles": return "SC";
            case "Sudan": return "SD";
            case "Sweden": return "SE";
            case "Singapore": return "SG";
            case "Saint Helena, Ascension and Tristan da Cunha": return "SH";
            case "Slovenia": return "SI";
            case "Svalbard and Jan Mayen": return "SJ";
            case "Slovakia": return "SK";
            case "Sierra Leone": return "SL";
            case "San Marino": return "SM";
            case "Senegal": return "SN";
            case "Somalia": return "SO";
            case "Suriname": return "SR";
            case "South Sudan": return "SS";
            case "Sao Tome and Principe": return "ST";
            case "El Salvador": return "SV";
            case "Sint Maarten (Dutch part)": return "SX";
            case "Syrian Arab Republic": return "SY";
            case "Swaziland": return "SZ";
            case "Turks and Caicos Islands": return "TC";
            case "Chad": return "TD";
            case "French Southern Territories": return "TF";
            case "Togo": return "TG";
            case "Thailand": return "TH";
            case "Tajikistan": return "TJ";
            case "Tokelau": return "TK";
            case "Timor-Leste": return "TL";
            case "Turkmenistan": return "TM";
            case "Tunisia": return "TN";
            case "Tonga": return "TO";
            case "Turkey": return "TR";
            case "Trinidad and Tobago": return "TT";
            case "Tuvalu": return "TV";
            case "Taiwan, Province of China": return "TW";
            case "Tanzania, United Republic of": return "TZ";
            case "Ukraine": return "UA";
            case "Uganda": return "UG";
            case "United States Minor Outlying Islands": return "UM";
            case "United States": return "US";
            case "Uruguay": return "UY";
            case "Uzbekistan": return "UZ";
            case "Holy See (Vatican City State)": return "VA";
            case "Saint Vincent and the Grenadines": return "VC";
            case "Venezuela, Bolivarian Republic of": return "VE";
            case "Virgin Islands, British": return "VG";
            case "Virgin Islands, U.S.": return "VI";
            case "Viet Nam": return "VN";
            case "Vanuatu": return "VU";
            case "Wallis and Futuna": return "WF";
            case "Samoa": return "WS";
            case "Yemen": return "YE";
            case "Mayotte": return "YT";
            case "South Africa": return "ZA";
            case "Zambia": return "ZM";
            case "Zimbabwe": return "ZW";

            default: return "";
        }
    }

    #endregion
}
