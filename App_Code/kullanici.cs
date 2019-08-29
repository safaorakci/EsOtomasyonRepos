using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;

[Serializable]
public class Kullanici
{
    #region Private Properties




    private string _default_pb = string.Empty;
    private string _dil_secenek = string.Empty;
    private string _yetki_kodu = string.Empty;
    private string _firma_hid = string.Empty;
    private string _firma_kodu = string.Empty;
    private string _kullanici_hid = string.Empty;
    private int _firma_id = 0;
    private int _kullanici_id = 0;
    private int _ekleyen_id = 0;
    private string _departmanlar = "0";
    private string _kullanici_adi = string.Empty;
    private string _resim = string.Empty;
    private string _kullanici_adsoyad = string.Empty;
    private string _durum = string.Empty;
    private string _login = string.Empty;
    private DateTime _login_tarih = DateTime.Now;
    private string _remember = string.Empty;
    private string _yetkili_sayfalar = string.Empty;
    private KullaniciRolleri _rolu = KullaniciRolleri.None;


    #endregion

    #region Public Properties
    
    public string yetkili_sayfalar
    {
        get { return _yetkili_sayfalar; }
        set { _yetkili_sayfalar = value; }
    }


    public string remember
    {
        get { return _remember; }
        set { _remember = value; }
    }

    public string default_pb
    {
        get { return _default_pb; }
        set { _default_pb = value; }
    }

    public string dil_secenek
    {
        get { return _dil_secenek; }
        set { _dil_secenek = value; }
    }

    public string firma_kodu
    {
        get { return _firma_kodu; }
        set { _firma_kodu = value; }
    }
    public string yetki_kodu
    {
        get { return _yetki_kodu; }
        set { _yetki_kodu = value; }
    }
    public string firma_hid
    {
        get { return _firma_hid; }
        set { _firma_hid = value; }
    }
    public string kullanici_hid
    {
        get { return _kullanici_hid; }
        set { _kullanici_hid = value; }
    }
    public string kullanici_adi
    {
        get { return _kullanici_adi; }
        set { _kullanici_adi = value; }
    }
    public string resim
    {
        get { return _resim; }
        set { _resim = value; }
    }

    public string kullanici_adsoyad
    {
        get { return _kullanici_adsoyad; }
        set { _kullanici_adsoyad = value; }
    }

    public string durum
    {
        get { return _durum; }
        set { _durum = value; }
    }
    public string login
    {
        get { return _login; }
        set { _login = value; }
    }

    public DateTime login_tarih
    {
        get { return _login_tarih; }
        set { _login_tarih = value; }
    }


    public int firma_id
    {
        get { return _firma_id; }
        set { _firma_id = value; }
    }



    public int kullanici_id
    {
        get { return _kullanici_id; }
        set { _kullanici_id = value; }
    }


    public int ekleyen_id
    {
        get { return _ekleyen_id; }
        set { _ekleyen_id = value; }
    }

    public string departmanlar
    {
        get { return _departmanlar; }
        set { _departmanlar = value; }
    }

    public KullaniciRolleri Rolu
    {
        get { return _rolu; }
        set { _rolu = value; }
    }
    #endregion

}


public enum KullaniciRolleri
{
    [Description("Seçiniz")]
    None = 0,
    [Description("Yönetici")]
    Admin = 1,
    [Description("Personel")]
    Ofis = 2
}