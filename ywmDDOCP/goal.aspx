<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="goal.aspx.cs"
    Inherits="ywmDDOCP.goal" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Fitness Tracker - Goal</title>

    <link rel="stylesheet" href="gstyle.css">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

</head>


<body>

    <!-- ASP.NET FORM -->

    <form id="form1" runat="server">

        <div class="container">


            <!-- ================================= -->
            <!-- LEFT SIDEBAR -->
            <!-- ================================= -->

            <div class="left">


                <!-- Logo -->

                <div class="logo">

                    <i class="bi bi-heart-pulse-fill"></i>

                    <h2>
                        FITNESS<br>
                        TRACKER
                    </h2>

                </div>


                <!-- Navigation Menu -->

                <div class="menu">


                    <!-- Set Goal -->

                    <a href="goal.aspx" class="active">

                        <i class="bi bi-bullseye"></i>

                        <span>Set Goal</span>

                    </a>


                    <!-- Set Activity -->

                    <a href="dashboard.aspx">

                        <i class="bi bi-person-running"></i>

                        <span>Dashboard</span>

                    </a>


                    <!-- Progress -->

                    <a href="progress.aspx">

                        <i class="bi bi-graph-up"></i>

                        <span>Progress</span>

                    </a>


                    <!-- Goal History -->

                    <a href="#history">

                        <i class="bi bi-clock-history"></i>

                        <span>Goal History</span>

                    </a>


                </div>


                <!-- Logout -->

                <div class="logout">

                    <a href="logout.aspx">

                        <i class="bi bi-box-arrow-right"></i>

                        <span>Logout</span>

                    </a>

                </div>


            </div>



            <!-- ================================= -->
            <!-- RIGHT MAIN CONTENT -->
            <!-- ================================= -->

            <div class="right">


                <!-- PAGE HEADER -->

                <div class="header">

                    <h1>Set Your Daily Goal</h1>

                    <p>
                        Set your calorie target and stay motivated
                        on your fitness journey.
                    </p>

                </div>



                <!-- ================================= -->
                <!-- DAILY CALORIE GOAL -->
                <!-- ================================= -->

                <div class="goal-card">


                    <!-- Card Title -->

                    <div class="card-title">

                        <i class="bi bi-fire"></i>

                        <h2>Daily Calorie Goal</h2>

                    </div>


                    <!-- Description -->

                    <p class="description">

                        Enter the number of calories you want
                        to burn today.

                    </p>


                    <!-- Goal Form -->

                    <div class="goal-form">


                        <!-- Calories Input -->

                        <div class="input-group">

                            <label for="txtCalories">

                                Calories to Burn

                            </label>


                            <asp:TextBox
                                ID="txtCalories"
                                runat="server"
                                CssClass="goal-input"
                                TextMode="Number"
                                placeholder="Example: 300">
                            </asp:TextBox>

                        </div>


                        <!-- Set Goal Button -->

                        <asp:Button
                            ID="btnSetGoal"
                            runat="server"
                            Text="Set Goal"
                            CssClass="goal-btn"
                            OnClick="btnSetGoal_Click" />


                    </div>


                    <!-- Success / Error Message -->

                    <asp:Label
                        ID="msg"
                        runat="server"
                        CssClass="goal-message">
                    </asp:Label>


                </div>



                <!-- ================================= -->
                <!-- GOAL HISTORY -->
                <!-- ================================= -->

                <div class="table-card" id="history">


                    <!-- History Title -->

                    <div class="card-title">

                        <i class="bi bi-clock-history"></i>

                        <h2>Goal History</h2>

                    </div>


                    <!-- History Description -->

                    <p class="description">

                        View your previous daily calorie goals.

                    </p>


                    <!-- Table -->

                    <div class="table-responsive">


                        <table>


                            <!-- Table Header -->

                            <thead>

                                <tr>

                                    <th>No.</th>

                                    <th>Date</th>

                                    <th>Calories Goal</th>

                                </tr>

                            </thead>


                            <!-- Table Body -->

                            <tbody>


                                <asp:Repeater
                                    ID="rptGoalHistory"
                                    runat="server">


                                    <ItemTemplate>


                                        <tr>


                                            <!-- Number -->

                                            <td>

                                                <%# Container.ItemIndex + 1 %>

                                            </td>


                                            <!-- Date -->

                                            <td>

                                                <%# Eval("date", "{0:dd/MM/yyyy}") %>

                                            </td>


                                            <!-- Calories -->

                                            <td>

                                                <%# Eval("calories") %>
                                                Calories

                                            </td>


                                        </tr>


                                    </ItemTemplate>


                                </asp:Repeater>


                            </tbody>


                        </table>


                    </div>


                    <!-- No History Message -->

                    <asp:Label
                        ID="lblNoHistory"
                        runat="server"
                        CssClass="goal-message">
                    </asp:Label>


                </div>


            </div>


        </div>

    </form>

</body>

</html>