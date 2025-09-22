using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using ProManage.DAL;

namespace ProManageDB.UI
{
    public partial class AssignTasks : System.Web.UI.Page
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
                LoadEmployees(); // Load employees into dropdown
            }
        }

        private void LoadEmployees()
        {
            string query = "SELECT EmployeeID, EmployeeName FROM Employees";

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Bind data to DropDownList
                    ddlEmployees.DataSource = dt;
                    ddlEmployees.DataTextField = "EmployeeName";
                    ddlEmployees.DataValueField = "EmployeeID";
                    ddlEmployees.DataBind();
                }
            }
        }

        protected void btnAssignTask_Click(object sender, EventArgs e)
        {
            int employeeId = Convert.ToInt32(ddlEmployees.SelectedValue);
            string taskName = txtTaskName.Text.Trim();
            string taskDescription = txtTaskDescription.Text.Trim();
            DateTime deadline = DateTime.Parse(txtDeadline.Text);
            string status = ddlStatus.SelectedValue;

            string query = @"INSERT INTO Tasks (EmployeeID, TaskName, TaskDescription, AssignedDate, Deadline, Status) 
                             VALUES (@EmployeeID, @TaskName, @TaskDescription, GETDATE(), @Deadline, @Status)";

            using (SqlConnection conn = DbHelper.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@EmployeeID", employeeId);
                    cmd.Parameters.AddWithValue("@TaskName", taskName);
                    cmd.Parameters.AddWithValue("@TaskDescription", taskDescription);
                    cmd.Parameters.AddWithValue("@Deadline", deadline);
                    cmd.Parameters.AddWithValue("@Status", status);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        lblMessage.Text = "Task assigned successfully!";

                        // Clear the form
                        txtTaskName.Text = "";
                        txtTaskDescription.Text = "";
                        txtDeadline.Text = "";
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Error assigning task: " + ex.Message;
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
        }
    }
}