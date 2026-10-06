using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ywmDDOCP
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            String name, password, email, cpassword;
            name = uname.Value;
            password = upass.Value;
            email = uemail.Value;
            cpassword = ucpass.Value;
            if(password!=cpassword)
            {
                msg.Text = "Passwords do not match!";
                msg.CssClass = "message error";
            }
            else
            {
                bool ans= ywmDBhandler.register(name, password,email);
                if(ans)
                {
                    // Registration successful; redirect to login page immediately
                    Response.Redirect("login.aspx");
                    return;
                }
                else 
                {
                    msg.Text = "Try Again!";
                    msg.ForeColor = System.Drawing.Color.Red;
                }
            }

        }
    }
}