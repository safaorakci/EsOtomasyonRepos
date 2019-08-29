using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Ahtapot.Startup))]
namespace Ahtapot
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
