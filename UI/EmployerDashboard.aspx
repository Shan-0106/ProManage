<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployerDashboard.aspx.cs" Inherits="ProManageDB.UI.EmployerDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employer Dashboard - ProManage</title>
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
                        <h1 class="dashboard-title">Employer Dashboard</h1>
                        <div class="user-welcome">
                            <div class="user-avatar">
                                <i class="fas fa-briefcase"></i>
                            </div>
                            <asp:Label ID="lblWelcome" runat="server" CssClass="welcome-text"></asp:Label>
                        </div>
                    </div>
                    
                    <div class="nav-buttons">
                        <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" 
                            CssClass="btn btn-logout" OnClientClick="return confirm('Are you sure you want to logout?');" />
                        <asp:HyperLink ID="hypAssignTasks" runat="server" NavigateUrl="~/UI/AssignTasks.aspx" 
                            CssClass="btn btn-primary">
                            <i class="fas fa-plus"></i> Assign New Task
                        </asp:HyperLink>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="dashboard-main">
                    <!-- Section 1: All Employees -->
                    <div class="section">
                        <h2><i class="fas fa-users"></i> All Employees</h2>
                        <asp:GridView ID="gvEmployees" runat="server" CssClass="grid-view" AutoGenerateColumns="True">
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        </asp:GridView>
                    </div>

                    <!-- Section 2: All Tasks -->
                    <div class="section">
                        <h2><i class="fas fa-tasks"></i> All Tasks</h2>
                        <asp:GridView ID="gvAllTasks" runat="server" CssClass="grid-view" AutoGenerateColumns="True">
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        </asp:GridView>
                    </div>

                    <!-- Section 3: All EOD Reports -->
                    <div class="section">
                        <h2><i class="fas fa-file-alt"></i> All EOD Reports</h2>
                        <asp:GridView ID="gvEodReports" runat="server" CssClass="grid-view" AutoGenerateColumns="True">
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </form> <!-- CLOSE THE FORM TAG -->

    <script src="../script.js"></script>
</body>
</html>