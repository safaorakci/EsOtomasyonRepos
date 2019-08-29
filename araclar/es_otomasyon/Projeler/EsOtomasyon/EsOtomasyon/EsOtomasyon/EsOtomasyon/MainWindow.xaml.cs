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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace EsOtomasyon
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        ModelView view = new ModelView();
        public Button GirisButton;
        SqlConnection connection = new SqlConnection("server=makrogem.com;UID=sa;PWD=Mn87rdr727*;DataBase=EsOtomasyon");
        public int Mail;
        public void ConnectionControl()
        {
            if (connection.State == ConnectionState.Closed)
                connection.Open();
            else
                connection.Close();
        }
        public MainWindow()
        {
            InitializeComponent();
            KullanicilariGetir();
        }

        private void KullanicilariGetir()
        {
            ConnectionControl();

            SqlCommand command = new SqlCommand("select * from ucgem_firma_kullanici_listesi where durum = 'true' and cop = 'false'", connection);
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                var kullaniciId = reader["id"].ToString();
                var kullaniciAdi = reader["personel_ad"].ToString();
                var kullaniciSoyad = reader["personel_soyad"].ToString();
                var kullaniciResim = reader["personel_resim"].ToString();

                Button btnUser = new Button();
                btnUser.Uid = kullaniciId;
                btnUser.Click += btnGirisYap_Click;
                btnUser.Style = TryFindResource("userCardButton") as Style;

                Grid grid = new Grid();

                Rectangle rectangle = new Rectangle();
                rectangle.RadiusX = 5;
                rectangle.RadiusY = 5;

                ImageBrush brushUserPhoto = new ImageBrush();

                if(kullaniciResim.ToString() == "/img/buyukboy.png")
                {
                    var img = "http://esflw.com/UserImg/User4.png";

                    BitmapImage logo = new BitmapImage();
                    logo.BeginInit();
                    logo.UriSource = new Uri(img);
                    logo.EndInit();
                    brushUserPhoto.ImageSource = logo;
                }
                else
                {
                    BitmapImage logo = new BitmapImage();
                    logo.BeginInit();
                    logo.UriSource = new Uri("http://esflw.com" + kullaniciResim.ToString());
                    logo.EndInit();
                    brushUserPhoto.ImageSource = logo;
                }
                TextBlock txtEposta = new TextBlock();
                txtEposta.Visibility = Visibility.Collapsed;

                TextBlock txtUserName = new TextBlock();
                txtUserName.Style = TryFindResource("loginText") as Style;
                txtUserName.Text = kullaniciAdi + " " + kullaniciSoyad;

                btnUser.Content = grid;
                grid.Children.Add(rectangle);
                rectangle.Fill = brushUserPhoto;
                grid.Children.Add(txtUserName);

                userCard.Children.Add(btnUser);
            }
            ConnectionControl();
        }

        private void btnGirisYap_Click(object sender, RoutedEventArgs e)
        {
            GirisButton = (Button)sender;

            loginGrid.Visibility = Visibility.Collapsed;
            userGiris.Visibility = Visibility.Visible;
            userbtn.Visibility = Visibility.Visible;
            txtUserPassword.Focus();
            txtUserId.Text = GirisButton.Uid;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }


        private void btnKullanicilar_Click(object sender, RoutedEventArgs e)
        {
            userGiris.Visibility = Visibility.Collapsed;
            loginGrid.Visibility = Visibility.Visible;
            userbtn.Visibility = Visibility.Collapsed;
        }

        private void BtnUserGiris_Click(object sender, RoutedEventArgs e)
        {
            ConnectionControl();

            SqlCommand command = new SqlCommand("select * from ucgem_firma_kullanici_listesi where durum='true' and cop='false' and personel_parola=@parola and id=@id ", connection);
            command.Parameters.AddWithValue("@parola", txtUserPassword.Password.ToString());
            command.Parameters.AddWithValue("@id", txtUserId.Text);

            SqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                ModelView.firma_Kodu = reader["firma_kodu"].ToString();
                ModelView.firma_Id = Convert.ToInt32(reader["firma_id"]);
                ModelView.ekleyen_Id = Convert.ToInt32(reader["id"]);

                Window1 window = new Window1();
                window.Show();
                Close();
            }
            else
            {
                MessageBox.Show("Hatalı Şifre !.", "Hata");
                txtUserPassword.Password = string.Empty;
            }
            ConnectionControl();
        }
    }
}
