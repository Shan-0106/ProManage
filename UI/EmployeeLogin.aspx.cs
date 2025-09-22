using System;
using System.Data.SqlClient;
using System.Web;
using ProManage.DAL; // Import your DAL namespace

namespace ProManageDB.UI
{
    public partial class EmployeeLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // 1. Get input from textboxes
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            // 2. Prepare SQL query to find the user
            string query = "SELECT EmployeeID, EmployeeName FROM Employees WHERE Email = @Email AND Password = @Password";

            // 3. Create and open a connection
            using (SqlConnection conn = DbHelper.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // 4. Add parameters to prevent SQL injection
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);

                    try
                    {
                        conn.Open();
                        // 5. Execute the query
                        SqlDataReader reader = cmd.ExecuteReader();

                        // 6. Check if a record was found
                        if (reader.Read())
                        {
                            // Login successful!
                            // Store user info in Session
                            Session["EmployeeID"] = reader["EmployeeID"];
                            Session["EmployeeName"] = reader["EmployeeName"];

                            // Redirect to the Employee Dashboard
                            Response.Redirect("EmployeeDashboard.aspx");
                        }
                        else
                        {
                            // Login failed
                            lblMsg.Text = "Invalid email or password. Please try again.";
                        }
                        reader.Close();
                    }
                    catch (Exception ex)
                    {
                        // Handle any errors (e.g., database connection issues)
                        lblMsg.Text = "An error occurred: " + ex.Message;
                    }
                }
            }
        }
    }
}