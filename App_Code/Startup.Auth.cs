using Microsoft.AspNet.Identity;
using Microsoft.Owin;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.Google;
using Owin;

namespace Ahtapot
{
    public partial class Startup
    {

        // Kimlik doğrulamayı yapılandırma hakkında daha fazla bilgi için lütfen https://go.microsoft.com/fwlink/?LinkId=301883 adresini ziyaret edin.
        public void ConfigureAuth(IAppBuilder app)
        {
            // Uygulamanın oturum açan kullanıcıya ilişkin bilgileri depolaması için bir tanımlama bilgisi kullanmasına izin ver
            // ve ayrıca üçüncü taraf oturum açma sağlayıcısıyla oturum açan bir kullanıcıya ilişkin bilgileri depolar.
            // Uygulamanız kullanıcıların oturum açmasına izin veriyorsa bu özellik gereklidir
            app.UseCookieAuthentication(new CookieAuthenticationOptions
            {
                AuthenticationType = DefaultAuthenticationTypes.ApplicationCookie,
                LoginPath = new PathString("/Account/Login")
            });
            app.UseExternalSignInCookie(DefaultAuthenticationTypes.ExternalCookie);

            // Üçüncü taraf oturum açma sağlayıcılarıyla oturum açmayı etkinleştirmek için aşağıdaki satırlardaki yorumları kaldırın
            //app.UseMicrosoftAccountAuthentication(
            //    clientId: "",
            //    clientSecret: "");

            //app.UseTwitterAuthentication(
            //   consumerKey: "",
            //   consumerSecret: "");

            //app.UseFacebookAuthentication(
            //   appId: "",
            //   appSecret: "");

            //app.UseGoogleAuthentication(new GoogleOAuth2AuthenticationOptions()
            //{
            //    ClientId = "",
            //    ClientSecret = ""
            //});
        }
    }
}
