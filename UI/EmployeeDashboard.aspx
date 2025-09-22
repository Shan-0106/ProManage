<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployeeDashboard.aspx.cs" Inherits="ProManageDB.UI.EmployeeDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Dashboard - ProManage</title>
    <link href="../Style.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server"> <!-- ADD THIS FORM TAG -->
        <div class="dashboard-container">
            <div class="dashboard-content">
                <!-- Header -->
                <div class="dashboard-header">
                    <div>
                        <h1 class="dashboard-title">Employee Dashboard</h1>
                        <div class="user-welcome">
                            <div class="user-avatar">
                                <i class="fas fa-user"></i>
                            </div>
                            <asp:Label ID="lblWelcome" runat="server" CssClass="welcome-text"></asp:Label>
                        </div>
                    </div>
                    
                    <div class="nav-buttons">
                        <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" 
                            CssClass="btn btn-logout" OnClientClick="return confirm('Are you sure you want to logout?');" />
                    </div>
                </div>

                <!-- Main Content -->
                <div class="dashboard-main">
                    <!-- Stats Overview -->
                    <div class="stats-grid">
                        <div class="stat-card">
                            <span class="stat-number" id="statTasks">0</span>
                            <span class="stat-label">Total Tasks</span>
                        </div>
                        <div class="stat-card" style="background: linear-gradient(135deg, #4cc9f0, #4895ef);">
                            <span class="stat-number" id="statCompleted">0</span>
                            <span class="stat-label">Completed</span>
                        </div>
                        <div class="stat-card" style="background: linear-gradient(135deg, #f72585, #b5179e);">
                            <span class="stat-number" id="statPending">0</span>
                            <span class="stat-label">Pending</span>
                        </div>
                    </div>

                    <!-- Task List Section -->
                    <div class="section">
                        <h2><i class="fas fa-tasks"></i> Your Assigned Tasks</h2>
                        <asp:GridView ID="gvTasks" runat="server" CssClass="grid-view" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="TaskName" HeaderText="Task Name" />
                                <asp:BoundField DataField="TaskDescription" HeaderText="Description" />
                                <asp:BoundField DataField="AssignedDate" HeaderText="Assigned On" DataFormatString="{0:dd-MMM-yyyy}" />
                                <asp:BoundField DataField="Deadline" HeaderText="Deadline" DataFormatString="{0:dd-MMM-yyyy}" />
                                <asp:BoundField DataField="Status" HeaderText="Status" />
                            </Columns>
                        </asp:GridView>
                    </div>

                    <!-- EOD Report Section -->
                    <div class="section">
                        <h2><i class="fas fa-report"></i> Submit End of Day Report</h2>
                        <div class="form-grid">
                            <div class="form-group">
                                <label for="ddlTasks"><i class="fas fa-tasks"></i> Select Task</label>
                                <asp:DropDownList ID="ddlTasks" runat="server" DataTextField="TaskName" 
                                    DataValueField="TaskID" CssClass="form-control"></asp:DropDownList>
                            </div>

                            <div class="form-group">
                                <label for="txtHoursWorked"><i class="fas fa-clock"></i> Hours Worked</label>
                                <asp:TextBox ID="txtHoursWorked" runat="server" TextMode="Number" 
                                    CssClass="form-control" placeholder="Enter hours"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqHours" runat="server" ControlToValidate="txtHoursWorked" 
                                    ErrorMessage="Hours worked are required" CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="txtWorkDetails"><i class="fas fa-file-alt"></i> Work Details</label>
                            <asp:TextBox ID="txtWorkDetails" runat="server" TextMode="MultiLine" Rows="4" 
                                CssClass="form-control" placeholder="Describe what you worked on today..."></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqWorkDetails" runat="server" ControlToValidate="txtWorkDetails" 
                                ErrorMessage="Work details are required" CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="action-buttons">
                            <asp:Button ID="btnSubmitEOD" runat="server" Text="Submit Report" 
                                OnClick="btnSubmitEOD_Click" CssClass="btn btn-primary" 
                                OnClientClick="return validateEODForm();" />
                        </div>

                        <asp:Label ID="lblEodMessage" runat="server" CssClass="message" Visible="false"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </form> <!-- CLOSE THE FORM TAG -->

    <script src="../script.js"></script>
</body>
</html>

