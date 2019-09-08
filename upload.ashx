<%@ WebHandler Language="C#" Class="upload" %>

using System;
using System.Web;
using System.IO;
using System.Configuration;
using System.Data.OleDb;
using System.Data.SqlClient;
using Newtonsoft.Json;

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

            if (fileExt == ".xls" || fileExt == ".xlsx")
                ExcellToDataBase(HttpContext.Current.Server.MapPath(filePath), firmaKodu, firmaID, userID, userIP);

            var responseData = new
            {
                status = true,
                statusText = "Dosya Yükleme İşlemi Başarılı"
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
        try
        {
            String excelConnString = String.Format("Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties=\"Excel 12.0\"", filePath);
            String strConnection = ConfigurationManager.ConnectionStrings["baglantim"].ToString();

            using (OleDbConnection excelConnection = new OleDbConnection(excelConnString))
            {

                using (OleDbCommand cmd = new OleDbCommand(@"Select 0, '',marka, parca_adi, 3, aciklama, birim_maliyet, birim_pb, miktar, minumum_miktar, barcode, 'true', 
                                                            'false', '" + firmaKodu + "', " + firmaID + ", " + userID + ", '" + userIP + "', '" + DateTime.Now.ToString() + "', '00:00:00.8466667' from [Sheet1$]", excelConnection))
                {
                    excelConnection.Open();
                    using (OleDbDataReader dReader = cmd.ExecuteReader())
                    {
                        using (SqlBulkCopy sqlBulk = new SqlBulkCopy(strConnection))
                        {
                            sqlBulk.DestinationTableName = "[dbo].[parca_listesi]";
                            sqlBulk.WriteToServer(dReader);
                        }
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