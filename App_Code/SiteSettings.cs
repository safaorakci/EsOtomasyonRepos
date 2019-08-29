using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


public class SiteSettings
{

    public static string SIRKET_ADI = "Makrogem Bilişim Teknolojileri A.Ş.";
    public static string SIRKET_LOGO_IMAGE_NAME = "logo.png";
    public static string SIRKET_FAVICON = "favicon.png";
    public static string SIRKET_TELEFON_NO = "+90 224 502 10 26";
    public static string SIRKET_INFO_EPOSTA = "info@makrogem.com";
    public static string SIRKET_ADMIN_LOGO_IMAGE_NAME = "logo.png";

    public static string SITE_URL = "makrogem.com";
    public static string LOCALHOST_URL = "Makrogem/";

    public static string AnalyticsProfileID = "100845261";

    public static bool IsMultiLanguageSupported = true;
    public static string DefaultLanguage = "tr";
    public static string[] SupportedLanguages = { "tr", "en" };
    public static string[] SupportedLanguagesDesc = { "Türkçe", "English", "Deutsch", "Русский" }; // };
    public static int[] SupportedLanguagesMenuRootIDs = { 2, 3, 82, 96 };
    public static bool ReturnDefaultLanguageTranslationIfNotExists = true;


    public static string GetLanguageDescription(string langCode)
    {
        switch (langCode)
        {
            case "tr":
                return "Türkçe";
            case "en":
                return "English";
            case "de":
                return "Deutsch";
            case "ru":
                return "Русский";
            case "dk":
                return "Dansk";
            case "no":
                return "Norsk";
            case "se":
                return "Svensk";
            case "fi":
                return "Suomi";
            case "nl":
                return "Dutch";
            default:
                break;
        }
        return langCode;
    }


}