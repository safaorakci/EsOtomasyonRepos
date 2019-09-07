<%@ WebHandler Language="C#" Class="upload" %>

using System;
using System.Web;
using System.IO;


public class upload : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        try
        {
            System.IO.Stream str = context.Request.Files["FileUpload"].InputStream;
            using (System.IO.FileStream output = new System.IO.FileStream(HttpContext.Current.Server.MapPath("upload/ExcellFile/" + GenerateFileName(context.Request.Files["FileUpload"].FileName)), FileMode.Create))
            {
                str.CopyTo(output);
            }


            context.Response.Write("Dosya Yükleme İşlemi Başarılı");
        }
        catch (Exception ex)
        {

            context.Response.Write("Hata : "+ ex.Message);
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
        string FileName = "";
        string fileExt = "";
            
        int fileExtPos = fileName.LastIndexOf(".", StringComparison.Ordinal);
        if (fileExtPos >= 0)
            fileExt = fileName.Substring(fileExtPos, fileName.Length - fileExtPos);

        FileName = "Proskop_" + DateTime.Now.Ticks.ToString() + fileExt;
        return FileName;

    }

}