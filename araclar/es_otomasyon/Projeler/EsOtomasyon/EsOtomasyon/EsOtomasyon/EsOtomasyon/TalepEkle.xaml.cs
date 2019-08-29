using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using EsOtomasyon;

namespace EsOtomasyon
{
    /// <summary>
    /// Interaction logic for BrowserWindow.xaml
    /// </summary>
    public partial class TalepEkle : Window
    {
        SqlConnection connection = new SqlConnection("server=makrogem.com;UID=sa;PWD=Mn87rdr727*;DataBase=EsOtomasyon");
        public void ConnectionControl()
        {
            if (connection.State == ConnectionState.Closed)
                connection.Open();
            else
                connection.Close();
        }
        public TalepEkle()
        {
            InitializeComponent();
        }

        public void ClearValue()
        {
            txtBaslik.Text = string.Empty;
            txtOncelik.SelectedIndex = 0;
            txtAciklama.Document.Blocks.Clear();
        }

        private void BtnTalepEkle_Click(object sender, RoutedEventArgs e)
        {
            var value = new TextRange(txtAciklama.Document.ContentStart, txtAciklama.Document.ContentEnd).Text;

            ConnectionControl();

            if (txtBaslik.Text != string.Empty && txtOncelik.SelectedIndex != -1 && value.ToString() != "")
            {
                SqlCommand command = new SqlCommand("insert into talep_fisleri(baslik, oncelik, aciklama, durum, cop, firma_kodu, firma_id, ekleyen_id, ekleyen_ip, ekleme_tarihi, ekleme_saati) " +
                    "values(@baslik, @oncelik, @aciklama, @durum, @cop, @firma_kodu, @firma_id, @ekleyen_id, @ekleyen_ip, @ekleme_tarihi, @ekleme_saati)", connection);
                command.Parameters.AddWithValue("@baslik", txtBaslik.Text);
                command.Parameters.AddWithValue("@oncelik", txtOncelik.Text);
                command.Parameters.AddWithValue("@aciklama", value);
                command.Parameters.AddWithValue("@durum", "Onay Bekliyor");
                command.Parameters.AddWithValue("@cop", "false");
                command.Parameters.AddWithValue("@firma_kodu", ModelView.firma_Kodu);
                command.Parameters.AddWithValue("@firma_id", ModelView.firma_Id);
                command.Parameters.AddWithValue("@ekleyen_id", ModelView.ekleyen_Id);
                command.Parameters.AddWithValue("@ekleyen_ip", "127.0.0.1");
                command.Parameters.AddWithValue("@ekleme_tarihi", DateTime.Now.Date);
                command.Parameters.AddWithValue("@ekleme_saati", DateTime.Now.TimeOfDay);
                command.ExecuteNonQuery();

                MessageBox.Show("Ekleme işlemi başarılı bir şekilde tamamlandı...", "Info");
                ClearValue();
                ConnectionControl();
            }
            else
                MessageBox.Show("Litfen tüm alanları doldurunuz...", "Uyarı");
        }
    }
}
