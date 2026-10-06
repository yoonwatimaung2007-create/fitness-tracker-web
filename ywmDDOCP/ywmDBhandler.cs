using System;
using System.Data;
using System.Data.SqlClient;

namespace ywmDDOCP
{
    public class ywmDBhandler
    {
        private static SqlConnection con;

        public static bool openConnection()
        {
            try
            {
                con = new SqlConnection(
                    "Data Source=(LocalDB)\\v11.0;" +
                    "AttachDbFilename=C:\\Users\\Lenovo\\Desktop\\DDOCPASSIGNMENT\\ywmDDOCP\\ywmDDOCP\\App_Data\\ywm.mdf;" +
                    "Integrated Security=True"
                );

                con.Open();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public static bool closeConnection()
        {
            try
            {
                if (con != null && con.State != ConnectionState.Closed)
                    con.Close();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public static bool register(String name, String password, String email)
        {
            try
            {
                openConnection();

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                cmd.CommandText =
                    "INSERT INTO users(name, password, email) " +
                    "VALUES(@n, @p, @e)";

                cmd.Parameters.AddWithValue("@n", name);
                cmd.Parameters.AddWithValue("@p", password);
                cmd.Parameters.AddWithValue("@e", email);

                int line = cmd.ExecuteNonQuery();

                closeConnection();

                return line > 0;
            }
            catch
            {
                return false;
            }
        }

        public static int Login(String name, String password)
        {
            int id = -1;
            try
            {
                openConnection();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "select Id from users where name=@n and password=@p";
                cmd.Parameters.AddWithValue("@n", name);
                cmd.Parameters.AddWithValue("@p", password);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    id = Convert.ToInt16(reader["ID"].ToString());
                }
                reader.Close();
                closeConnection();

            }
            catch
            {
                return id;

            }
            return id;
        }

        public static bool insertGoal(int calories, int uid)
        {
            try
            {
                if (!openConnection())
                {
                    return false;
                }

                // Ensure goals table exists in the database
                EnsureGoalsTableExists();

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                cmd.CommandText =
                    "INSERT INTO dbo.goals(calories, user_id, date) " +
                    "VALUES(@c, @u, GETDATE())";

                cmd.Parameters.AddWithValue("@c", calories);
                cmd.Parameters.AddWithValue("@u", uid);

                int line = cmd.ExecuteNonQuery();

                closeConnection();

                return line > 0;
            }
            catch (Exception)
            {
                // Close connection then rethrow so callers can see the real error
                closeConnection();
                throw;
            }
        }

        public static DataTable getGoalHistory(int uid)
        {
            DataTable dt = new DataTable();
            try
            {
                if (!openConnection())
                {
                    return dt;
                }

                // Ensure goals table exists before querying
                EnsureGoalsTableExists();

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                cmd.CommandText =
                    "SELECT calories, [date] " +
                    "FROM dbo.goals " +
                    "WHERE user_id = @u " +
                    "ORDER BY [date] DESC";

                cmd.Parameters.AddWithValue("@u", uid);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                adapter.Fill(dt);
            }
            catch (Exception ex)
            {
                // Optional: log ex.Message for debugging
            }
            finally
            {
                closeConnection();
            }

            return dt;
        }

        private static void EnsureGoalsTableExists()
        {
            try
            {
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                cmd.CommandText =
                    "IF OBJECT_ID('dbo.goals','U') IS NULL " +
                    "BEGIN " +
                    "CREATE TABLE dbo.goals (" +
                    "Id INT IDENTITY(1,1) PRIMARY KEY, " +
                    "calories INT NULL, " +
                    "user_id INT NULL, " +
                    "[date] DATETIME NULL); " +
                    "END";

                cmd.ExecuteNonQuery();
            }
            catch
            {
                // If creation fails, ignore here; the calling code will surface errors.
            }
        }

        public static bool insertActivity(string activityType, string details, int uid)
        {
            try
            {
                if (!openConnection())
                {
                    return false;
                }

                // Ensure activities table exists (with calories column)
                EnsureActivitiesTableExists();

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                // Backwards-compatible overload: if this method is called (3 params), insert with NULL calories
                cmd.CommandText =
                    "INSERT INTO dbo.activities(activity_type, details, calories, user_id, date) " +
                    "VALUES(@t, @d, @c, @u, GETDATE())";

                cmd.Parameters.AddWithValue("@t", activityType);
                cmd.Parameters.AddWithValue("@d", details ?? string.Empty);
                cmd.Parameters.AddWithValue("@c", DBNull.Value);
                cmd.Parameters.AddWithValue("@u", uid);

                int line = cmd.ExecuteNonQuery();

                closeConnection();

                return line > 0;
            }
            catch (Exception)
            {
                closeConnection();
                throw;
            }
        }

        // New overload: insert activity with explicit calories value
        public static bool insertActivity(string activityType, string details, int calories, int uid)
        {
            try
            {
                if (!openConnection())
                {
                    return false;
                }

                EnsureActivitiesTableExists();

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                cmd.CommandText =
                    "INSERT INTO dbo.activities(activity_type, details, calories, user_id, date) " +
                    "VALUES(@t, @d, @c, @u, GETDATE())";

                cmd.Parameters.AddWithValue("@t", activityType);
                cmd.Parameters.AddWithValue("@d", details ?? string.Empty);
                cmd.Parameters.AddWithValue("@c", calories);
                cmd.Parameters.AddWithValue("@u", uid);

                int line = cmd.ExecuteNonQuery();

                closeConnection();

                return line > 0;
            }
            catch (Exception)
            {
                closeConnection();
                throw;
            }
        }

        private static void EnsureActivitiesTableExists()
        {
            try
            {
                // Ensure the connection is open so that DDL (CREATE TABLE) can be executed.
                if (con == null || con.State != ConnectionState.Open)
                {
                    openConnection();
                }

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                // Create table if missing, and ensure 'calories' column exists.
                cmd.CommandText =
                    "IF OBJECT_ID('dbo.activities','U') IS NULL " +
                    "BEGIN " +
                    "CREATE TABLE dbo.activities (" +
                    "Id INT IDENTITY(1,1) PRIMARY KEY, " +
                    "activity_type NVARCHAR(100) NULL, " +
                    "details NVARCHAR(400) NULL, " +
                    "calories INT NULL, " +
                    "user_id INT NULL, " +
                    "[date] DATETIME NULL); " +
                    "END; " +
                    "IF OBJECT_ID('dbo.activities','U') IS NOT NULL AND COL_LENGTH('dbo.activities','calories') IS NULL " +
                    "BEGIN ALTER TABLE dbo.activities ADD calories INT NULL; END";

                // Execute the DDL to create the table if it does not exist or add missing column.
                cmd.ExecuteNonQuery();
            }
            catch
            {
                // ignore; caller will see errors
            }
        }

        public static DataTable getActivityHistory(int uid)
        {
            DataTable dt = new DataTable();
            try
            {
                if (!openConnection())
                {
                    return dt;
                }

                // Ensure activities table exists before querying
                EnsureActivitiesTableExists();

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                cmd.CommandText =
                    "SELECT activity_type, details, ISNULL(calories, 0) AS calories, [date] " +
                    "FROM dbo.activities " +
                    "WHERE user_id = @u " +
                    "ORDER BY [date] DESC";

                cmd.Parameters.AddWithValue("@u", uid);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                adapter.Fill(dt);
            }
            catch (Exception)
            {
                // optional: log
            }
            finally
            {
                closeConnection();
            }

            return dt;
        }

        // Return estimated total calories burned for a specific user on a specific date.
        // This attempts to parse integer calorie values from the activity details text.
        public static int getTotalCaloriesForDate(int uid, DateTime date)
        {
            int total = 0;
            try
            {
                if (!openConnection()) return total;

                EnsureActivitiesTableExists();

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;

                cmd.CommandText =
                    "SELECT details FROM dbo.activities WHERE user_id = @u AND CONVERT(date, [date]) = @d";

                cmd.Parameters.AddWithValue("@u", uid);
                cmd.Parameters.AddWithValue("@d", date.Date);

                SqlDataReader reader = cmd.ExecuteReader();
                System.Text.RegularExpressions.Regex rx = new System.Text.RegularExpressions.Regex("(\\d+)", System.Text.RegularExpressions.RegexOptions.Compiled);
                while (reader.Read())
                {
                    var det = reader["details"] == DBNull.Value ? string.Empty : reader["details"].ToString();
                    if (string.IsNullOrWhiteSpace(det)) continue;

                    // find all integer tokens and sum them as calories (best-effort)
                    var m = rx.Matches(det);
                    foreach (System.Text.RegularExpressions.Match mm in m)
                    {
                        int v;
                        if (int.TryParse(mm.Value, out v))
                        {
                            total += v;
                        }
                    }
                }
                reader.Close();
            }
            catch
            {
                // ignore parse errors; return what we have
            }
            finally
            {
                closeConnection();
            }

            return total;
        }

        // Parse integer tokens from a details string and sum them as calories (best-effort)
        public static int parseCaloriesFromText(string details)
        {
            if (string.IsNullOrWhiteSpace(details)) return 0;
            int total = 0;
            try
            {
                System.Text.RegularExpressions.Regex rx = new System.Text.RegularExpressions.Regex("(\\d+)", System.Text.RegularExpressions.RegexOptions.Compiled);
                var m = rx.Matches(details);
                foreach (System.Text.RegularExpressions.Match mm in m)
                {
                    int v;
                    if (int.TryParse(mm.Value, out v)) total += v;
                }
            }
            catch
            {
                // ignore
            }
            return total;
        }

    }
}
