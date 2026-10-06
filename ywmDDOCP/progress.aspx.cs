using System;
using System.Data;
using System.Linq;
using System.Web.UI;

namespace ywmDDOCP
{
    public partial class progress : Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProgress();
            }
        }

        private void LoadProgress()
        {
            try
            {
                int uid = Store.getUserId();
                if (uid <= 0)
                {
                    msgText.Text = "You must be logged in to view progress.";
                    msgPanel.CssClass = "field-error visible";
                    msgPanel.Visible = true;
                    return;
                }

                // We'll compute total calories per date by parsing activity details
                // Load all activities for the user and group by calendar date
                var activities = ywmDBhandler.getActivityHistory(uid); // activity_type, details, date
                DataTable progressTable = new DataTable();
                progressTable.Columns.Add("date", typeof(DateTime));
                progressTable.Columns.Add("total_calories", typeof(int));
                progressTable.Columns.Add("goal_calories", typeof(int));
                progressTable.Columns.Add("statusText", typeof(string));
                progressTable.Columns.Add("statusClass", typeof(string));
                // Use a fixed calorie target for status determination
                const int FixedCalorieTarget = 2000;

                // Group activities by date and sum calories. Prefer persisted 'calories' column when available;
                // fall back to parsing details for older records.
                var caloriesByDate = new System.Collections.Generic.Dictionary<DateTime, int>();
                foreach (DataRow a in activities.Rows)
                {
                    DateTime d = Convert.ToDateTime(a["date"]);
                    var key = d.Date;

                    int calories = 0;
                    // Use persisted calories column when present
                    if (activities.Columns.Contains("calories"))
                    {
                        if (a["calories"] != DBNull.Value)
                        {
                            int.TryParse(a["calories"].ToString(), out calories);
                        }
                    }
                    else
                    {
                        // Backward compatibility: parse from details text
                        string det = a["details"] == DBNull.Value ? string.Empty : a["details"].ToString();
                        calories = ywmDBhandler.parseCaloriesFromText(det);
                    }

                    if (!caloriesByDate.ContainsKey(key)) caloriesByDate[key] = calories;
                    else caloriesByDate[key] += calories;
                }

                // Debug: report counts
                try
                {
                    int actCount = activities.Rows.Count;
                    int datesCount = caloriesByDate.Count;
                    lblDebug.Text = $"Activities={actCount} DatesWithCalories={datesCount}";
                }
                catch { }

                // Create a progress row for each activity date (sorted desc)
                foreach (var kv in caloriesByDate.OrderByDescending(k => k.Key))
                {
                    DateTime date = kv.Key;
                    int total = kv.Value;
                    int goalCal = FixedCalorieTarget;
                    string statusText = total >= goalCal ? "Achieved" : "Not Achieved";
                    string statusClass = total >= goalCal ? "status-achieved" : "status-notachieved";

                    var row = progressTable.NewRow();
                    row["date"] = date;
                    row["total_calories"] = total;
                    row["goal_calories"] = goalCal;
                    row["statusText"] = statusText;
                    row["statusClass"] = statusClass;
                    progressTable.Rows.Add(row);
                }
                // If no progress rows found, show a helpful message
                if (progressTable.Rows.Count == 0)
                {
                    msgText.Text = "No progress records found. Make sure you have recorded activities.";
                    msgPanel.CssClass = "field-error visible";
                    msgPanel.Visible = true;
                    return;
                }

                // Bind to repeater
                rptProgress.DataSource = progressTable;
                rptProgress.DataBind();
            }
            catch (Exception ex)
            {
                msgText.Text = "Unable to load progress: " + ex.Message;
                msgPanel.CssClass = "field-error visible";
                msgPanel.Visible = true;
            }
        }
    }
}
