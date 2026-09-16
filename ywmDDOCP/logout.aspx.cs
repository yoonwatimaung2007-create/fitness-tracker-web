using System;
using System.Web;
using System.Web.UI;

namespace ywmDDOCP
{
    public partial class logout : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // Clear session and abandon
                if (HttpContext.Current != null)
                {
                    HttpContext.Current.Session.Clear();
                    HttpContext.Current.Session.Abandon();
                }
            }
            catch
            {
                // ignore
            }

            Response.Redirect("login.aspx");
        }
    }
}
