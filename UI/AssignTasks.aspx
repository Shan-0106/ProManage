<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssignTasks.aspx.cs" Inherits="ProManageDB.UI.AssignTasks" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Assign Tasks</title>
    <link href="../Style.css" rel="stylesheet" />
    <script src="../script.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="dashboard-container">
            <div class="dashboard-content">
                <!-- Header -->
                <div class="dashboard-header">
                    <h1 class="dashboard-title">Assign Tasks</h1>
                    <div class="nav-buttons">
                        <asp:HyperLink ID="hypDashboard" runat="server" NavigateUrl="~/UI/EmployerDashboard.aspx" CssClass="btn btn-primary">
                            <i class="fas fa-arrow-left"></i> Back to Dashboard
                        </asp:HyperLink>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="dashboard-main">
                    <!-- Task Assignment Form -->
                    <div class="section">
                        <h2><i class="fas fa-tasks"></i> Assign New Task</h2>
                        
                        <div class="form-grid">
                            <div class="form-group">
                                <label for="ddlEmployees"><i class="fas fa-user"></i> Select Employee</label>
                                <asp:DropDownList ID="ddlEmployees" runat="server" DataTextField="EmployeeName" 
                                    DataValueField="EmployeeID" CssClass="form-control"></asp:DropDownList>
                            </div>

                            <div class="form-group">
                                <label for="txtTaskName"><i class="fas fa-heading"></i> Task Name</label>
                                <asp:TextBox ID="txtTaskName" runat="server" CssClass="form-control" placeholder="Enter task name"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqTaskName" runat="server" ControlToValidate="txtTaskName" 
                                    ErrorMessage="Task name is required" CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="txtTaskDescription"><i class="fas fa-file-alt"></i> Task Description</label>
                            <asp:TextBox ID="txtTaskDescription" runat="server" TextMode="MultiLine" Rows="4" 
                                CssClass="form-control" placeholder="Describe the task..."></asp:TextBox>
                        </div>

                        <div class="form-grid">
                            <div class="form-group">
                                <label for="txtDeadline"><i class="fas fa-calendar"></i> Deadline</label>
                                <asp:TextBox ID="txtDeadline" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <label for="ddlStatus"><i class="fas fa-status"></i> Status</label>
                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                    <asp:ListItem Value="In Progress">In Progress</asp:ListItem>
                                    <asp:ListItem Value="Completed">Completed</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="action-buttons">
                            <asp:Button ID="btnAssignTask" runat="server" Text="Assign Task" 
                                OnClick="btnAssignTask_Click" CssClass="btn btn-primary" />
                        </div>

                        <asp:Label ID="lblMessage" runat="server" CssClass="message" Visible="false"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>