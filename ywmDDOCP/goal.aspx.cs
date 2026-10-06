using System;
using System.Data;
using System.Web.UI;

namespace ywmDDOCP
{
    public partial class goal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Require login
            if (Store.getUserId() == -1)
            {
                Response.Redirect("login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadGoalHistory();
            }
        }


        protected void btnSetGoal_Click(object sender, EventArgs e)
        {
            // Ensure user is logged in
            int uid = Store.getUserId();
            if (uid == -1)
            {
                msgText.Text = "You must be logged in to set a goal.";
                msgPanel.CssClass = "field-error visible";
                msgPanel.Visible = true;
                return;
            }

            // Validate input safely
            int cal;
            if (!int.TryParse(txtCalories.Text, out cal) || cal <= 0)
            {
                msgText.Text = "Please enter a valid positive number for calories.";
                msgPanel.CssClass = "field-error visible";
                msgPanel.Visible = true;
                return;
            }

            bool ans = false;
            try
            {
                ans = ywmDBhandler.insertGoal(cal, uid);
            }
            catch (Exception ex)
            {
                // Surface a helpful message for debugging; in production log this instead
                msgText.Text = "Error setting goal: " + ex.Message;
                msgPanel.CssClass = "field-error visible";
                msgPanel.Visible = true;
                return;
            }

            if (ans)
            {
                // Show success panel
                msgText.Text = "Goal Successfully Set!";
                msgPanel.CssClass = "field-success visible";
                msgPanel.Visible = true;
                txtCalories.Text = "";
                LoadGoalHistory();
            }
            else
            {
                // Show error using same panel style but swapped classes
                msgText.Text = "Try Again!";
                msgPanel.CssClass = "field-error visible";
                msgPanel.Visible = true;
            }
        }


        private void LoadGoalHistory()
        {
            DataTable dt =
                ywmDBhandler.getGoalHistory(
                    Store.getUserId()
                );


            rptGoalHistory.DataSource = dt;

            rptGoalHistory.DataBind();


            if (dt.Rows.Count == 0)
            {
                lblNoHistory.Text =
                    "No goal history available.";
            }
            else
            {
                lblNoHistory.Text = "";
            }
        }
    }
}