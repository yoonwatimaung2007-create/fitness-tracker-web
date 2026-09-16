<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="ywmDDOCP.login" %>



<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Fitness Tracker</title>

    <link rel="stylesheet" runat="server" href="style.css" />

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

</head>

<body>

    <div class="container">

        <div class="content">

            <!-- Left Side -->
            <div class="left">

                <h1>
                    FITNESS<br>
                    TRACKER
                </h1>

                <p>
                    Start your fitness journey today and achieve
                    your health goals.
                </p>

            </div>


            <!-- Right Side -->
            <div class="right">

                <h2>LOGIN</h2>

                <form id="form1" runat="server">

                    <!-- Message -->
                    <asp:Label ID="msg" runat="server" CssClass="message"></asp:Label>

                    <p class="welcome">
                        Welcome back! Continue your fitness journey.
                    </p>


                    <!-- Username -->
                    <div class="row">

                        <label for="uname">

                            <i class="fa-regular fa-user"></i>
                            Username

                        </label>

                        <input type="text"
                               id="uname"
                               required
                               placeholder="User Name"
                               runat="server">

                    </div>


                    <!-- Password -->
                    <div class="row">

                        <label for="upass">

                            <i class="fa-solid fa-key"></i>
                            Password

                        </label>

                        <input type="password"
                               id="upass"
                               required
                               placeholder="Password"
                               runat="server">

                    </div>
                    <div class="forgot-password">
                        <a href="forgotpassword.aspx">Forgot Password?</a>
                    </div>


                    <!-- Login Button -->
                    <div class="btnrow">

                        <asp:Button ID="btnLogin"
                                    runat="server"
                                    Text="Login"
                                    CssClass="btn"
                                    OnClick="btnLogin_Click" />

                    </div>

                </form>


                <!-- Register Link -->
                <p class="login">

                    Don't have an account?

                    <a href="register.aspx">
                        Register
                    </a>
                    first.
                </p>

            </div>

        </div>

    </div>

</body>

</html>