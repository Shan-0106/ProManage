using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ProManage.DAL;

namespace ProManageDB.UI
{
    public partial class EmployerLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Query the Employers table
            string query = "SELECT EmployerID, EmployerName FROM Employers WHERE Email = @Email AND Password = @Password";

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);

                    try
                    {
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            // Login successful for Employer
                            Session["EmployerID"] = reader["EmployerID"];
                            Session["EmployerName"] = reader["EmployerName"];
                            Session["Role"] = "Employer"; // Store role in session

                            Response.Redirect("EmployerDashboard.aspx");
                        }
                        else
                        {
                            lblMessage.Text = "Invalid employer email or password.";
                        }
                        reader.Close();
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Error: " + ex.Message;
                    }
                }
            }
        }
    }
}