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
    public partial class EmployerDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if EMPLOYER is logged in
            if (Session["EmployerID"] == null)
            {
                Response.Redirect("EmployerLogin.aspx");
            }

            if (!IsPostBack)
            {
                // Display welcome message
                lblWelcome.Text = "Welcome, " + Session["EmployerName"] + "! (Employer)";

                // Load all data
                LoadAllEmployees();
                LoadAllTasks();
                LoadAllEodReports();
            }
        }
        private void LoadAllEmployees()
        {
            string query = "SELECT EmployeeID, EmployeeName, Email, Department FROM Employees";

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvEmployees.DataSource = dt;
                    gvEmployees.DataBind();
                }
            }
        }

        private void LoadAllTasks()
        {
            string query = @"SELECT T.TaskID, E.EmployeeName, T.TaskName, T.TaskDescription, 
                            T.AssignedDate, T.Deadline, T.Status 
                            FROM Tasks T INNER JOIN Employees E ON T.EmployeeID = E.EmployeeID";

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvAllTasks.DataSource = dt;
                    gvAllTasks.DataBind();
                }
            }
        }

        private void LoadAllEodReports()
        {
            string query = @"SELECT EOD.ReportID, Emp.EmployeeName, EOD.ReportDate, 
                            EOD.WorkDetails, EOD.HoursWorked 
                            FROM EODReports EOD INNER JOIN Employees Emp 
                            ON EOD.EmployeeID = Emp.EmployeeID 
                            ORDER BY EOD.ReportDate DESC";

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvEodReports.DataSource = dt;
                    gvEodReports.DataBind();
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear all session variables
            Session.Clear();
            Session.Abandon();

            // Redirect to employer login page
            Response.Redirect("EmployerLogin.aspx");
        }

    }
}