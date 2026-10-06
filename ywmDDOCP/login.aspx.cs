using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ywmDDOCP
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string name = (uname.Value ?? string.Empty).Trim();
            string password = (upass.Value ?? string.Empty);

            if (string.IsNullOrEmpty(name))
            {
                msg.Text = "Please enter username.";
                return;
            }

            // Keys are per-username so different accounts are tracked independently
            string userKey = name.ToLowerInvariant();
            string countKey = $"LoginAttempts_{userKey}";
            string lockKey = $"LoginLockout_{userKey}";

            // Check lockout
            object lockObj = Session[lockKey];
            if (lockObj != null && lockObj is DateTime)
            {
                DateTime until = (DateTime)lockObj;
                if (until > DateTime.Now)
                {
                    TimeSpan left = until - DateTime.Now;
                    if (left.TotalSeconds < 60)
                    {
                        msg.Text = $"Too many failed attempts. Try again in {Math.Ceiling(left.TotalSeconds)} seconds.";
                    }
                    else
                    {
                        msg.Text = $"Too many failed attempts. Try again in {Math.Ceiling(left.TotalMinutes)} minute(s).";
                    }
                    return;
                }
                else
                {
                    // lock expired - clear it
                    Session.Remove(lockKey);
                }
            }

            int uid = ywmDBhandler.Login(name, password);
            if (uid == -1)
            {
                // Failed attempt handling
                int attempts = 0;
                if (Session[countKey] != null)
                {
                    attempts = (int)Session[countKey];
                }
                attempts++;
                Session[countKey] = attempts;

                // If attempts is a multiple of 3, apply lockout; otherwise report remaining attempts
                if (attempts % 3 == 0)
                {
                    int stage = (attempts / 3); // 1 -> first lock, 2 -> second, etc.
                    int minutes = 5;
                    if (stage == 1) minutes = 1;
                    else if (stage == 2) minutes = 3;
                    else minutes = 5;

                    DateTime until = DateTime.Now.AddMinutes(minutes);
                    Session[lockKey] = until;
                    msg.Text = $"Too many failed attempts. Account locked for {minutes} minute(s).";
                }
                else
                {
                    int mod = attempts % 3;
                    if (mod == 1)
                    {
                        // First failed attempt in the cycle
                        msg.Text = "Login failed. First attempt failed. 2 attempts remaining before temporary lock.";
                    }
                    else if (mod == 2)
                    {
                        // Second failed attempt in the cycle
                        msg.Text = "Login failed. Second attempt failed. 1 attempt remaining before temporary lock.";
                    }
                    else
                    {
                        // Fallback (shouldn't occur) - preserve previous behavior
                        int remaining = 3 - mod;
                        msg.Text = $"Login failed. {remaining} attempt(s) remaining before temporary lock.";
                    }
                }
            }
            else
            {
                // Successful login - clear tracking and proceed
                Session.Remove(countKey);
                Session.Remove(lockKey);
                Store.setUserId(uid);
                Response.Redirect("goal.aspx");
            }
        }
    }
}