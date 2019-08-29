using BioMetrixCore;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using zkemkeeper;


namespace ParmakİziServis
{
    class Program
    {

        static void Main(string[] args)
        {
            Console.WriteLine("   ***  HOŞGELDİNİZ  ***");
            Console.WriteLine("Bu program parmak izlerini her 5 dakikada bir sistemden alır.");

            string ipAddress = "192.168.1.201";
            int portNumber = 4370;
            int MachineNumber = 1;

            string dwEnrollNumber1 = "";
            int dwVerifyMode = 0;
            int dwInOutMode = 0;
            int dwYear = 0;
            int dwMonth = 0;
            int dwDay = 0;
            int dwHour = 0;
            int dwMinute = 0;
            int dwSecond = 0;
            int dwWorkCode = 0;

            Console.WriteLine("Baglaniyor");

            CZKEM objCZKEM = new CZKEM();

            if (objCZKEM.Connect_Net(ipAddress, portNumber))
            {

                Console.WriteLine("Baglandi");

                ICollection<MachineInfo> lstEnrollData = new List<MachineInfo>();

                Console.WriteLine("Datalar istendi");
                objCZKEM.ReadAllGLogData(MachineNumber);

                Console.WriteLine("Datalar Geliyor");

                while (objCZKEM.SSR_GetGeneralLogData(MachineNumber, out dwEnrollNumber1, out dwVerifyMode, out dwInOutMode, out dwYear, out dwMonth, out dwDay, out dwHour, out dwMinute, out dwSecond, ref dwWorkCode))
                {
                    string inputDate = new DateTime(dwYear, dwMonth, dwDay, dwHour, dwMinute, dwSecond).ToString();

                    MachineInfo objInfo = new MachineInfo();
                    objInfo.MachineNumber = MachineNumber;
                    objInfo.IndRegID = int.Parse(dwEnrollNumber1);
                    objInfo.dwVerifyMode = dwVerifyMode;
                    objInfo.dwInOutMode = dwInOutMode;
                    objInfo.DateTimeRecord = inputDate;

                    lstEnrollData.Add(objInfo);

                }
                string insertdata = "";
                Console.WriteLine("Datalar Alındı");

                if (lstEnrollData != null && lstEnrollData.Count > 0)
                {
                    foreach (MachineInfo item in lstEnrollData)
                    {
                        string g_kisi = item.IndRegID.ToString();
                        string g_cesit = item.dwInOutMode.ToString();
                        string g_yontem = item.dwVerifyMode.ToString();
                        string g_datetime = item.DateTimeRecord.ToString();


                        switch (g_cesit)
                        {
                            case "0": g_cesit = "Giriş"; break;
                            case "1": g_cesit = "Çıkış"; break;
                            case "4": g_cesit = "Fm_Giriş"; break;
                            case "5": g_cesit = "Fm_Çıkış"; break;
                            default: break;
                        }

                        switch (g_yontem)
                        {
                            case "0": g_yontem = "Şifre"; break;
                            case "1": g_yontem = "Parmak İzi"; break;
                            default: break;
                        }

                        Console.WriteLine(g_kisi + " - " + g_cesit + " - " + g_yontem + " - " + item.DateTimeRecord);
                        insertdata += "INSERT INTO [Parmak_izi_data] ([g_kisi], [g_cesit], [g_yontem], [g_datetime]) VALUES ('"+ g_kisi + "', '"+ g_cesit + "', '"+ g_yontem + "', '"+ g_datetime + "');";

                        Console.WriteLine(lstEnrollData.Count + " kayıt bulundu!");

                       
                    }
                }

                else
                    Console.WriteLine("Hiç kayıt bulunamadı");


                if (insertdata.Length>10)
                {

                    insertdata += "Exec [dbo].[ParmakEslestir];";

                    using (SqlConnection sqlCon = new SqlConnection("server=makrogem.com;UID=sa;PWD=Mn87rdr727*;DataBase=EsOtomasyon"))
                    {
                        using (SqlCommand sqlCmd1 = new SqlCommand { CommandText = insertdata, Connection = sqlCon })
                        {
                            sqlCon.Open();
                            {
                                sqlCmd1.ExecuteNonQuery();
                                sqlCon.Close();
                            }
                        }
                    }
                }
               



            }

           

        }

        
    }
}
