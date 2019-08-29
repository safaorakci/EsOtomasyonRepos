using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Windows.Threading;

namespace EsOtomasyon
{
    /// <summary>
    /// Interaction logic for Window1.xaml
    /// </summary>
    public partial class Window1 : Window
    {
        SqlConnection connection = new SqlConnection("server=makrogem.com;UID=sa;PWD=Mn87rdr727*;DataBase=EsOtomasyon");
        public RepeatButton detaylarBtn;
        DispatcherTimer timer = new DispatcherTimer();
        ModelView view = new ModelView();
        public void ConnectionControl()
        {
            if (connection.State == ConnectionState.Closed)
                connection.Open();
            else
                connection.Close();
        }
        public Window1()
        {
            InitializeComponent();
            Sayfa_Yuklenince();
        }

        private void Sayfa_Yuklenince()
        {
            ViewModel.PageCall.AddPage(OrtaGrid, new Page.UserTabControl());
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            MainWindow main = new MainWindow();
            main.Show();
            Close();
        }

        private void BtnTalepEkle_Click(object sender, RoutedEventArgs e)
        {
            TalepEkle talepEkle = new TalepEkle();
            talepEkle.ShowDialog();
        }

        private void BtnPersonelİslemleri_Click(object sender, RoutedEventArgs e)
        {
            ViewModel.PageCall.AddPage(OrtaGrid, new Page.UserCefSharpBrowser());
        }

        private void BtnAnaSayfa_Click(object sender, RoutedEventArgs e)
        {
            ViewModel.PageCall.AddPage(OrtaGrid, new Page.UserTabControl());
        }

        private void Klavye_ac_Click(object sender, RoutedEventArgs e)
        {
            string touchKeyboardPath = @"C:\Program Files\Common Files\microsoft shared\ink\TabTip.exe";
            Process.Start(touchKeyboardPath);
        }
    }
}