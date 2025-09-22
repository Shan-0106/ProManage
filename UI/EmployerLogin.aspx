<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployerLogin.aspx.cs" Inherits="ProManageDB.UI.EmployerLogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employer Login - ProManage</title>
    <link href="Style.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
</head>
<body class="employer-login">
    <div class="login-container">
        <div class="login-left">
            <!-- Professional management background image will appear here -->
        </div>
        
        <div class="login-right">
            <div class="login-box">
                <div class="login-icon">
                    <i class="fas fa-briefcase"></i>
                </div>
                
                <div class="login-header">
                    <h2>Employer Login</h2>
                    <p>Access your management dashboard</p>
                </div>

                <form id="form1" runat="server">
                    <div class="login-form">
                        <div class="form-group">
                            <label for="txtEmail">
                                <i class="fas fa-envelope"></i>Email Address
                            </label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" 
                                placeholder="Enter your email" TextMode="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqEmail" runat="server" 
                                ControlToValidate="txtEmail" ErrorMessage="Email is required"
                                CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group">
                            <label for="txtPassword">
                                <i class="fas fa-lock"></i>Password
                            </label>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" 
                                placeholder="Enter your password" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqPassword" runat="server" 
                                ControlToValidate="txtPassword" ErrorMessage="Password is required"
                                CssClass="validator" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <asp:Button ID="btnLogin" runat="server" Text="Sign In" 
                            OnClick="btnLogin_Click" CssClass="login-btn" />
                        
                        <asp:Label ID="lblMessage" runat="server" CssClass="message message-error" 
                            Visible="false"></asp:Label>
                    </div>
                </form>

                <div class="login-links">
                    <p style="margin: 20px 0; color: #666;">Are you an employee?</p>
                    <asp:HyperLink ID="hypEmployeeLogin" runat="server" 
                        NavigateUrl="~/UI/EmployeeLogin.aspx" CssClass="switch-login">
                        <i class="fas fa-user-tie"></i> Employee Login
                    </asp:HyperLink>
                </div>
            </div>
        </div>
    </div>
</body>
</html>