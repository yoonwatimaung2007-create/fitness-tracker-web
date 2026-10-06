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
            int calories = CalculateCaloriesForYoga(minutes);

            try
            {
                bool ok = ywmDBhandler.insertActivity("Yoga", details, calories, uid);
                if (ok)
                {
                    msg.Text = "Yoga saved.";
                    msg.CssClass = "field-success visible";
                    txtYogaMinutes.Text = "";
                    txtYogaPose.Text = "";
                    LoadActivityHistory();
                }
                else
                {
                    msg.Text = "Failed to save Yoga.";
                    msg.CssClass = "field-error visible";
                }
            }
            catch (Exception ex)
            {
                msg.Text = "Error: " + ex.Message;
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
            int calories = CalculateCaloriesForRun(distance, duration);
            try
            {
                bool ok = ywmDBhandler.insertActivity("Running", details, calories, uid);
                if (ok)
                {
                    msg.Text = "Running saved.";
                    msg.CssClass = "field-success visible";
                    txtRunDistance.Text = "";
                    txtRunDuration.Text = "";
                    LoadActivityHistory();
                }
                else
                {
                    msg.Text = "Failed to save Running.";
                    msg.CssClass = "field-error visible";
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
            int calories = CalculateCaloriesForCycle(distance, duration);
            try
            {
                bool ok = ywmDBhandler.insertActivity("Cycling", details, calories, uid);
                if (ok)
                {
                    msg.Text = "Cycling saved.";
                    msg.CssClass = "field-success visible";
                    txtCycleDistance.Text = "";
                    txtCycleDuration.Text = "";
                    LoadActivityHistory();
                }
                else
                {
                    msg.Text = "Failed to save Cycling.";
                    msg.CssClass = "field-error visible";
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
            int calories = CalculateCaloriesForTrek(distance, elevation);
            try
            {
                bool ok = ywmDBhandler.insertActivity("Trekking", details, calories, uid);
                if (ok)
                {
                    msg.Text = "Trekking saved.";
                    msg.CssClass = "field-success visible";
                    txtTrekDistance.Text = "";
                    txtTrekElevation.Text = "";
                    LoadActivityHistory();
                }
                else
                {
                    msg.Text = "Failed to save Trekking.";
                    msg.CssClass = "field-error visible";
                }
            }
            catch (Exception ex)
            {
                msg.Text = "Error: " + ex.Message;
                msg.CssClass = "field-error visible";
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

        // Simple calorie estimators (very rough)
        private int CalculateCaloriesForYoga(int minutes)
        {
            // average ~4 kcal per minute for moderate yoga
            return Math.Max(0, minutes * 4);
        }

        private int CalculateCaloriesForRun(double distanceKm, int durationMinutes)
        {
            // estimate: running burns ~100 kcal per km (rough)
            return Math.Max(0, (int)Math.Round(distanceKm * 100));
        }

        private int CalculateCaloriesForCycle(double distanceKm, int durationMinutes)
        {
            // estimate: cycling ~30 kcal per km
            return Math.Max(0, (int)Math.Round(distanceKm * 30));
        }

        private int CalculateCaloriesForTrek(double distanceKm, int elevation)
        {
            // estimate: trekking ~60 kcal per km plus elevation factor
            return Math.Max(0, (int)Math.Round(distanceKm * 60 + elevation * 0.1));
        }
    }
}
