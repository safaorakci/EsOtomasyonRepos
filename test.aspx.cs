using Ahtapot.App_Code.ayarlar;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

public partial class System_root_test : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {


        string touchKeyboardPath = @"C:\dll\TabTip.exe";
        Process.Start(touchKeyboardPath);


    }
}