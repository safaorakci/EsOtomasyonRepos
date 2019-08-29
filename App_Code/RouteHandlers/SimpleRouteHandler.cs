using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Compilation;
using System.Web.Routing;
using System.Web.UI;

public class SimpleRouteHandler : IRouteHandler
{
    public SimpleRouteHandler(string virtualPath)
    {
        this.VirtualPath = virtualPath;
    }

    public string VirtualPath { get; private set; }

    public IHttpHandler GetHttpHandler(RequestContext requestContext)
    {
        //if (VirtualPath.Substring(0,5) == "image")
        //{
        //    try
        //    {
        //        var queryString = new StringBuilder("");
        //        foreach (var aux in requestContext.RouteData.Values)
        //        {
        //            queryString.Append(requestContext.HttpContext.Server.UrlEncode(aux.Value.ToString()));
        //            queryString.Append("/");
        //        }
        //        queryString.Remove(queryString.Length - 1, 1);

        //        HttpContext.Current.RewritePath(string.Concat("~/", queryString));

        //        var image = BuildManager.CreateInstanceFromVirtualPath("~/" + VirtualPath.Substring(6) + "/" + queryString, typeof(Image)) as IHttpHandler;

        //        return image;

        //    }
        //    catch (System.Exception ex)
        //    {
        //        return null; // BuildManager.CreateInstanceFromVirtualPath("~/images/ajaxloading.gif", typeof(Image)) as IHttpHandler;
        //    }
        //}
        if (VirtualPath == "~/Default.aspx")
        {
            string url = HttpContext.Current.Request.RawUrl;
            HttpContext.Current.RewritePath(string.Concat(VirtualPath, "?lang=" + url.Substring(url.Length - 2)));
            var page = BuildManager.CreateInstanceFromVirtualPath(VirtualPath, typeof(Page)) as IHttpHandler;
            return page;
        }
        else
        {
            var queryString = new StringBuilder("?");
            foreach (var aux in requestContext.RouteData.Values)
            {
                queryString.Append(requestContext.HttpContext.Server.UrlEncode(aux.Key));
                queryString.Append("=");
                queryString.Append(requestContext.HttpContext.Server.UrlEncode(aux.Value.ToString()));
                queryString.Append("&");
            }
            queryString.Remove(queryString.Length - 1, 1);

            HttpContext.Current.RewritePath(string.Concat(VirtualPath, queryString));

            //string language = requestContext.RouteData.Values["lang"] as string;

            //HttpContext context = HttpContext.Current;
            //context.Items.Add("lang", language);

            //foreach (var value in requestContext.RouteData.Values)
            //{
            //    requestContext.HttpContext.Items[value.Key] = value.Value;
            //}
            var page = BuildManager.CreateInstanceFromVirtualPath(VirtualPath, typeof(Page)) as IHttpHandler;
            return page;
        }
    }
}