using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ProManage.DAL;

namespace ProManageDB.UI
{
    public partial class EmployeeDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is logged in (Session exists)
            if (Session["EmployeeID"] == null)
            {
                Response.Redirect("EmployeeLogin.aspx"); // Redirect to login if not authenticated
            }

            if (!IsPostBack) // Only load data on the first page load
            {
                // Display welcome message
                lblWelcome.Text = "Welcome, " + Session["EmployeeName"] + "!";

                // Load tasks for the GridView and DropDownList
                LoadEmployeeTasks();
            }
        }

        private void LoadEmployeeTasks()
        {
            int employeeId = Convert.ToInt32(Session["EmployeeID"]);

            string query = "SELECT TaskID, TaskName, TaskDescription, AssignedDate, Deadline, Status FROM Tasks WHERE EmployeeID = @EmployeeID";

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@EmployeeID", employeeId);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Bind data to GridView
                    gvTasks.DataSource = dt;
                    gvTasks.DataBind();

                    // Bind data to DropDownList
                    ddlTasks.DataSource = dt;
                    ddlTasks.DataBind();
                }
            }
        }

        protected void btnSubmitEOD_Click(object sender, EventArgs e)
        {
            int employeeId = Convert.ToInt32(Session["EmployeeID"]);
            int taskId = Convert.ToInt32(ddlTasks.SelectedValue);
            string workDetails = txtWorkDetails.Text.Trim();
            int hoursWorked = Convert.ToInt32(txtHoursWorked.Text.Trim());

            string query = @"INSERT INTO EODReports (EmployeeID, TaskID, ReportDate, WorkDetails, HoursWorked) 
                 VALUES (@EmployeeID, @TaskID, GETDATE(), @WorkDetails, @HoursWorked)";

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@EmployeeID", employeeId);
                    cmd.Parameters.AddWithValue("@TaskID", taskId);   // Include TaskID
                    cmd.Parameters.AddWithValue("@WorkDetails", workDetails);
                    cmd.Parameters.AddWithValue("@HoursWorked", hoursWorked);


                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        lblEodMessage.Text = "EOD Report submitted successfully!";

                        // Clear the form
                        txtWorkDetails.Text = "";
                        txtHoursWorked.Text = "";
                    }
                    catch (Exception ex)
                    {
                        lblEodMessage.Text = "Error submitting report: " + ex.Message;
                        lblEodMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear all session variables
            Session.Clear();
            Session.Abandon();

            // Redirect to login page
            Response.Redirect("EmployeeLogin.aspx");
        }
    
    }
}