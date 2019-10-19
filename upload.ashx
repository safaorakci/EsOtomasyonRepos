<%@ WebHandler Language="C#" Class="upload" %>

using System;
using System.Web;
using System.IO;
using System.Configuration;
using System.Data.OleDb;
using System.Data.SqlClient;
using Newtonsoft.Json;
using Ahtapot.App_Code.ayarlar;
using System.Data;

public class upload : IHttpHandler
{
    string fileExt = "";
    string filePath = "";
    string folderName = "";
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        try

        {
            string userID = "";
            string firmaKodu = "";
            string firmaID = "";
            string userIP = "";

            if (context.Request.Cookies["kullanici"] != null)
            {
                userID = context.Request.Cookies["kullanici"].Values["kullanici_id"].ToString();
                userIP = context.Request.ServerVariables["Remote_Addr"].ToString();
                firmaID = context.Request.Cookies["kullanici"].Values["firma_id"].ToString();
                firmaKodu = context.Request.Cookies["kullanici"].Values["firma_kodu"].ToString();
            }

            System.IO.Stream str = context.Request.Files["FileUpload"].InputStream;
            folderName = context.Request.Form["folderName"].ToString();

            using (System.IO.FileStream output = new System.IO.FileStream(HttpContext.Current.Server.MapPath("upload/" + folderName + "/" + GenerateFileName(context.Request.Files["FileUpload"].FileName)), FileMode.Create))
            {
                str.CopyTo(output);
            }

            if ((fileExt == ".xls" || fileExt == ".xlsx") && context.Request.Files["FileUpload"].FileName.Substring(0, 5) == "_Stok")
                ExcellToDataBase(HttpContext.Current.Server.MapPath(filePath), firmaKodu, firmaID, userID, userIP);

            var responseData = new
            {
                status = true,
                statusText = "Dosya Yükleme İşlemi Başarılı",
                fileFullPath = filePath
            };

            context.Response.Write(JsonConvert.SerializeObject(responseData));
        }
        catch (Exception ex)
        {

            var responseData = new
            {
                status = false,
                statusText = "Hata : " + ex.Message
            };

            context.Response.Write(JsonConvert.SerializeObject(responseData));
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }


    public string GenerateFileName(string fileName)
    {
        try
        {
            string FileName = "";

            int fileExtPos = fileName.LastIndexOf(".", StringComparison.Ordinal);
            if (fileExtPos >= 0)
                fileExt = fileName.Substring(fileExtPos, fileName.Length - fileExtPos);

            FileName = "Proskop_" + DateTime.Now.Ticks.ToString() + fileExt;
            filePath = "upload/" + folderName + "/" + FileName;
            return FileName;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public void ExcellToDataBase(string filePath, string firmaKodu, string firmaID, string userID, string userIP)
    {
        string[] createText= {0};
        try
        {
            String excelConnString = String.Format("Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties=\"Excel 12.0\"", filePath);
            String strConnection = ConfigurationManager.ConnectionStrings["baglantim"].ToString();

            using (OleDbConnection excelConnection = new OleDbConnection(excelConnString))
            {

                using (OleDbCommand cmd = new OleDbCommand(@"
                    Select 
                    IIF(kodu is null, '', kodu) as kodu,
                    IIF(marka is null, '', marka) as marka,
                    IIF(parca_adi is null, '', parca_adi) as parca_adi,
                    IIF(aciklama is null, '', aciklama) as aciklama,
                    IIF(birim is null, '', birim) as birim,
                    IIF(birim_maliyet is null, 0.00, birim_maliyet) as birim_maliyet,
                    IIF(birim_pb is null, '', birim_pb) as birim_pb,
                    IIF(miktar is null, 0, miktar) as miktar,
                    IIF(minumum_miktar is null, 0, minumum_miktar) as minumum_miktar,
                    IIF(kdv is null, 0, kdv) as kdv,
                    IIF(barcode is null, '', barcode) as barcode
                    from [Sheet1$]", excelConnection))
                {
                    excelConnection.Open();
                    ayarlar.baglan();
                    ayarlar.cmd.Parameters.Clear();
                    ayarlar.cmd.CommandText = "select id, miktar  from [dbo].[parca_listesi] where parca_kodu=@kodu";
                    SqlDataAdapter sda = new SqlDataAdapter(ayarlar.cmd);
                    DataTable dt = new DataTable();
                    string kodu = "";
                    using (OleDbDataReader dReader = cmd.ExecuteReader())
                    {
                        while (dReader.Read())
                        {
                            kodu = dReader["kodu"].ToString();
                            if (kodu == "")
                                continue;

                            ayarlar.cmd.CommandText = "select id, miktar  from [dbo].[parca_listesi] where parca_kodu=@kodu";
                            ayarlar.cmd.Parameters.Clear();
                            dt.Clear();
                            ayarlar.cmd.Parameters.Add("@kodu", SqlDbType.NVarChar).Value = kodu;
                            sda.Fill(dt);
                            if (dt.Rows.Count > 0)
                            {
                                ayarlar.baglan();
                                ayarlar.cmd.Parameters.Clear();
                                ayarlar.cmd.CommandText = "update [dbo].[parca_listesi] set miktar=@miktar, birim_maliyet=@birim_maliyet, minumum_miktar = @minumum_miktar  where id=@id";
                                ayarlar.cmd.Parameters.Add("@miktar", SqlDbType.Int).Value = Convert.ToInt32(dReader["miktar"]);
                                ayarlar.cmd.Parameters.Add("@birim_maliyet", SqlDbType.Int).Value = Convert.ToDecimal(dReader["birim_maliyet"]);
                                ayarlar.cmd.Parameters.Add("@minumum_miktar", SqlDbType.Int).Value = Convert.ToInt32(dReader["minumum_miktar"]);
                                ayarlar.cmd.Parameters.Add("@id", SqlDbType.Int).Value = Convert.ToInt32(dt.Rows[0]["id"]);
                                ayarlar.cmd.ExecuteNonQuery();
                            }
                            else
                            {
                                ayarlar.baglan();
                                ayarlar.cmd.Parameters.Clear();
                                ayarlar.cmd.CommandText = "insert into [dbo].[parca_listesi] " +
                                    "(parca_kodu, marka, parca_adi, kategori, aciklama, birim_maliyet, birim_pb, birim, miktar, kdv, minumum_miktar, barcode, " +
                                    "durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) " +
                                    "values " +
                                    "(@parca_kodu,@marka,@parca_adi,3,@aciklama,@birim_maliyet,@birim_pb,@birim,@miktar,@kdv,@minumum_miktar,@barcode,'true'," +
                                    "'false',@firma_kodu,@firma_id,@ekleyen_id,@ekleyen_ip,@ekleme_tarihi,@ekleme_saati)";
                                ayarlar.cmd.Parameters.Add("@parca_kodu", SqlDbType.NVarChar).Value = kodu;
                                ayarlar.cmd.Parameters.Add("@marka", SqlDbType.NVarChar).Value = dReader["marka"].ToString();
                                ayarlar.cmd.Parameters.Add("@parca_adi", SqlDbType.NVarChar).Value = dReader["parca_adi"].ToString();
                                ayarlar.cmd.Parameters.Add("@aciklama", SqlDbType.NVarChar).Value = dReader["aciklama"].ToString();
                                ayarlar.cmd.Parameters.Add("@birim_maliyet", SqlDbType.Decimal).Value = Convert.ToDecimal(dReader["birim_maliyet"]);
                                ayarlar.cmd.Parameters.Add("@birim_pb", SqlDbType.NVarChar).Value = dReader["birim_pb"].ToString();
                                ayarlar.cmd.Parameters.Add("@birim", SqlDbType.NVarChar).Value = dReader["birim"].ToString();
                                ayarlar.cmd.Parameters.Add("@miktar", SqlDbType.Int).Value = Convert.ToInt32(dReader["miktar"]);
                                ayarlar.cmd.Parameters.Add("@kdv", SqlDbType.NVarChar).Value = dReader["kdv"].ToString();
                                ayarlar.cmd.Parameters.Add("@minumum_miktar", SqlDbType.Int).Value = Convert.ToInt32(dReader["minumum_miktar"]);
                                ayarlar.cmd.Parameters.Add("@barcode", SqlDbType.NVarChar).Value = dReader["barcode"].ToString(); ;
                                ayarlar.cmd.Parameters.Add("@firma_kodu", SqlDbType.NVarChar).Value = firmaKodu;
                                ayarlar.cmd.Parameters.Add("@firma_id", SqlDbType.Int).Value = Convert.ToInt32(firmaID);
                                ayarlar.cmd.Parameters.Add("@ekleyen_id", SqlDbType.Int).Value = Convert.ToInt32(userID);
                                ayarlar.cmd.Parameters.Add("@ekleyen_ip", SqlDbType.NVarChar).Value = userIP;
                                ayarlar.cmd.Parameters.Add("@ekleme_tarihi", SqlDbType.DateTime).Value = DateTime.Now.ToString("yyyy-MM-dd");
                                ayarlar.cmd.Parameters.Add("@ekleme_saati", SqlDbType.Time).Value = DateTime.Now.ToString("HH:mm:ss");
                                createText[0] = dt.Rows.ToString();
                                ayarlar.cmd.ExecuteNonQuery();
                            }
                        }

                        string path = @"C:\Users\MAKROGEM\source\repos\safaorakci\EsOtomasyonRepos";

                        //createText = { "Hello" };
                        File.WriteAllLines(path, createText);


                        //using (SqlBulkCopy sqlBulk = new SqlBulkCopy(strConnection))
                        //{
                        //    sqlBulk.DestinationTableName = "[dbo].[parca_listesi]";
                        //    sqlBulk.WriteToServer(dReader);
                        //}
                    }
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

}