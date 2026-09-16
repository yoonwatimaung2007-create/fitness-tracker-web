using System;
using System.Web.UI;

namespace ywmDDOCP
{
    public partial class dashboard : Page
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
                LoadActivityHistory();
            }
        }

        protected void btnSaveYoga_Click(object sender, EventArgs e)
        {
            int uid = Store.getUserId();
            if (uid == -1) { msg.Text = "Please log in."; return; }

            int minutes;
            if (!int.TryParse(txtYogaMinutes.Text, out minutes) || minutes <= 0)
            {
                msg.Text = "Enter valid minutes for Yoga.";
                return;
            }

            string pose = txtYogaPose.Text ?? string.Empty;
            string details = $"minutes={minutes}; pose={pose}";

            try
            {
                bool ok = ywmDBhandler.insertActivity("Yoga", details, uid);
                if (ok)
                {
                    msg.Text = "Yoga saved.";
                    txtYogaMinutes.Text = "";
                    txtYogaPose.Text = "";
                    LoadActivityHistory();
                }
                else
                {
                    msg.Text = "Failed to save Yoga.";
                }
            }
            catch (Exception ex)
            {
                msg.Text = "Error: " + ex.Message;
            }
        }

        private void LoadActivityHistory()
        {
            int uid = Store.getUserId();
            if (uid == -1) return;

            var dt = ywmDBhandler.getActivityHistory(uid);
            rptActivityHistory.DataSource = dt;
            rptActivityHistory.DataBind();

            if (dt.Rows.Count == 0)
            {
                lblNoActivityHistory.Text = "No activity history available.";
            }
            else
            {
                lblNoActivityHistory.Text = "";
            }
        }

        protected void btnSaveRun_Click(object sender, EventArgs e)
        {
            int uid = Store.getUserId();
            if (uid == -1) { msg.Text = "Please log in."; return; }

            double distance;
            int duration;
            if (!double.TryParse(txtRunDistance.Text, out distance) || distance <= 0)
            {
                msg.Text = "Enter valid distance for Running.";
                return;
            }
            if (!int.TryParse(txtRunDuration.Text, out duration) || duration <= 0)
            {
                msg.Text = "Enter valid duration for Running.";
                return;
            }

            string details = $"distance={distance}; duration={duration}";
            try
            {
                bool ok = ywmDBhandler.insertActivity("Running", details, uid);
                if (ok)
                {
                    msg.Text = "Running saved.";
                    txtRunDistance.Text = "";
                    txtRunDuration.Text = "";
                    LoadActivityHistory();
                }
                else
                {
                    msg.Text = "Failed to save Running.";
                }
            }
            catch (Exception ex)
            {
                msg.Text = "Error: " + ex.Message;
            }
        }

        protected void btnSaveCycle_Click(object sender, EventArgs e)
        {
            int uid = Store.getUserId();
            if (uid == -1) { msg.Text = "Please log in."; return; }

            double distance;
            int duration;
            if (!double.TryParse(txtCycleDistance.Text, out distance) || distance <= 0)
            {
                msg.Text = "Enter valid distance for Cycling.";
                return;
            }
            if (!int.TryParse(txtCycleDuration.Text, out duration) || duration <= 0)
            {
                msg.Text = "Enter valid duration for Cycling.";
                return;
            }

            string details = $"distance={distance}; duration={duration}";
            try
            {
                bool ok = ywmDBhandler.insertActivity("Cycling", details, uid);
                if (ok)
                {
                    msg.Text = "Cycling saved.";
                    txtCycleDistance.Text = "";
                    txtCycleDuration.Text = "";
                    LoadActivityHistory();
                }
                else
                {
                    msg.Text = "Failed to save Cycling.";
                }
            }
            catch (Exception ex)
            {
                msg.Text = "Error: " + ex.Message;
            }
        }

        protected void btnSaveTrek_Click(object sender, EventArgs e)
        {
            int uid = Store.getUserId();
            if (uid == -1) { msg.Text = "Please log in."; return; }

            double distance;
            int elevation;
            if (!double.TryParse(txtTrekDistance.Text, out distance) || distance <= 0)
            {
                msg.Text = "Enter valid distance for Trekking.";
                return;
            }
            if (!int.TryParse(txtTrekElevation.Text, out elevation))
            {
                msg.Text = "Enter valid elevation for Trekking.";
                return;
            }

            string details = $"distance={distance}; elevation={elevation}";
            try
            {
                bool ok = ywmDBhandler.insertActivity("Trekking", details, uid);
                if (ok)
                {
                    msg.Text = "Trekking saved.";
                    txtTrekDistance.Text = "";
                    txtTrekElevation.Text = "";
                    LoadActivityHistory();
                }
                else
                {
                    msg.Text = "Failed to save Trekking.";
                }
            }
            catch (Exception ex)
            {
                msg.Text = "Error: " + ex.Message;
            }
        }
    }
}
