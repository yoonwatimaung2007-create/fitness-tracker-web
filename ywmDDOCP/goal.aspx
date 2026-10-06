<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="goal.aspx.cs"
    Inherits="ywmDDOCP.goal" %>

<!DOCTYPE html>
<html lang="en">

<head>
     
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>FitFlow - Goal</title>

    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="dstyle.css">
    <link rel="stylesheet" href="gstyle.css">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

</head>


<body>

    <!-- ASP.NET FORM -->

    <form id="form1" runat="server">

        <div class="container">


            <!-- ================================= -->
            <!-- LEFT SIDEBAR -->
            <!-- ================================= -->

            <div class="left">

                <h2 class="site-title">FitFlow</h2>

                <div class="menu">

                    <a href="goal.aspx" class="active">
                        <i class="bi bi-bullseye"></i>
                        <span>Set Goal</span>
                    </a>

                    <a href="dashboard.aspx">
                        <i class="bi bi-person-running"></i>
                        <span>Dashboard</span>
                    </a>

                    <a href="progress.aspx">
                        <i class="bi bi-graph-up"></i>
                        <span>Progress</span>
                    </a>

                    <a href="#history">
                        <i class="bi bi-clock-history"></i>
                        <span>Goal History</span>
                    </a>

                </div>

                <div class="logout">
                    <a href="javascript:logout();">
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


                    <!-- make form horizontal on wider screens; CSS controls stacking on small screens -->
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
                    <asp:Panel ID="msgPanel" runat="server" CssClass="field-success" Visible="false" role="alert">
                        <div class="fe-left">
                            <div class="fe-icon"><i class="fa-solid fa-circle-check"></i></div>
                            <div class="fe-text"><asp:Literal ID="msgText" runat="server" /></div>
                        </div>
                        <button type="button" class="fe-close" aria-label="Close">✕</button>
                    </asp:Panel>

                    <!-- Inline field error above submit (matches login/register) -->
                    <div id="fieldError" class="field-error hidden" role="alert" aria-live="assertive">
                        <div class="fe-left">
                            <div class="fe-icon"><i class="fa-solid fa-triangle-exclamation"></i></div>
                            <div class="fe-text"></div>
                        </div>
                        <!-- placeholder: keep fieldError region for inline errors -->
                        <button type="button" class="fe-close" aria-label="Close">✕</button>
                    </div>


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
    <form id="logoutForm" method="post" action="logout.aspx" style="display:none"></form>
    <script>
        (function(){
            function showFieldError(message){
                var field = document.getElementById('fieldError');
                if(!field) return;
                var text = field.querySelector('.fe-text');
                if(text) text.textContent = message || '';
                field.classList.remove('hidden');
                setTimeout(function(){ field.classList.add('visible'); }, 10);
            }

            function hideFieldError(){
                var field = document.getElementById('fieldError');
                if(!field) return;
                field.classList.remove('visible');
                setTimeout(function(){ field.classList.add('hidden'); }, 240);
            }

            document.addEventListener('click', function(e){
                var target = e.target || e.srcElement;
                if(target && target.classList && target.classList.contains('fe-close')){
                    hideFieldError();
                }
            });

            // hide on input focus
            var focusables = document.querySelectorAll('.right input, .goal-input, textarea');
            Array.prototype.slice.call(focusables).forEach(function(inp){
                inp.addEventListener('focus', hideFieldError);
            });

            var lbl = document.getElementById('<%= msgPanel.ClientID %>');
            if(lbl){
                // message panel contains .fe-text with the visible message
                var textEl = lbl.querySelector('.fe-text');
                var text = textEl ? (textEl.innerText || textEl.textContent || '').trim() : (lbl.innerText || lbl.textContent || '').trim();
                if(text){
                    // If server rendered a success panel, keep it visible (green).
                    if(lbl.classList && lbl.classList.contains('field-success')){
                        // ensure visible class is applied for animation
                        lbl.classList.add('visible');
                    }
                    else {
                        // For errors, hide server panel and show inline field-error animation
                        lbl.style.display='none';
                        showFieldError(text);
                    }
                }
            }
        })();
    </script>

</body>

</html>