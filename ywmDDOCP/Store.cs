using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ywmDDOCP
{
    public class Store
    {
        // Use Session to store per-user data instead of a static field
        public static void setUserId(int uid)
        {
            if (HttpContext.Current != null)
            {
                HttpContext.Current.Session["UserId"] = uid;
            }
        }

        public static int getUserId()
        {
            if (HttpContext.Current == null)
            {
                return -1;
            }

            var val = HttpContext.Current.Session["UserId"];
            if (val == null)
            {
                return -1;
            }

            try
            {
                return Convert.ToInt32(val);
            }
            catch
            {
                return -1;
            }
        }
    }
}