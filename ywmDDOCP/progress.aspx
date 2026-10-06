<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="progress.aspx.cs" Inherits="ywmDDOCP.progress" %>
<!-- Logo control removed: site title will be used instead -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>FitFlow - Progress</title>
    <link rel="stylesheet" href="style.css" />
    <link rel="stylesheet" runat="server" href="gstyle.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="left">
                <h2 class="site-title">FitFlow</h2>
                <div class="menu">
                    <a href="goal.aspx"> <i class="bi bi-bullseye"></i><span>Set Goal</span></a>
                    <a href="dashboard.aspx"> <i class="bi bi-person-running"></i><span>Dashboard</span></a>
                    <a href="progress.aspx" class="active"> <i class="bi bi-graph-up"></i><span>Progress</span></a>
                    <a href="goal.aspx#history"> <i class="bi bi-clock-history"></i><span>Goal History</span></a>
                </div>
                <div class="logout"><a href="javascript:logout();"><i class="bi bi-box-arrow-right"></i><span>Logout</span></a></div>
            </div>

            <div class="right">
                <div class="header">
                    <h1>Progress</h1>
                    <p>View your daily workout history and compare total calories burned against your goals.</p>
                </div>

                <!-- server message + fieldError placeholder -->
                <asp:Panel ID="msgPanel" runat="server" CssClass="field-success" Visible="false" role="alert">
                    <div class="fe-left">
                        <div class="fe-icon"><i class="fa-solid fa-circle-check"></i></div>
                        <div class="fe-text"><asp:Literal ID="msgText" runat="server" /></div>
                    </div>
                    <button type="button" class="fe-close" aria-label="Close">✕</button>
                </asp:Panel>
                <asp:Label ID="lblDebug" runat="server" CssClass="goal-message" />
                <div id="fieldError" class="field-error hidden" role="alert" aria-live="assertive">
                    <div class="fe-left">
                        <div class="fe-icon"><i class="fa-solid fa-triangle-exclamation"></i></div>
                        <div class="fe-text"></div>
                    </div>
                    <button type="button" class="fe-close" aria-label="Close">✕</button>
                </div>

                <div class="table-card">
                    <div class="card-title"><i class="bi bi-table"></i><h2>Workout History</h2></div>
                    <p class="description">Date | Total Calories Burned | Goal | Status</p>

                    <div class="table-responsive">
                        <table class="history-table">
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>Date</th>
                                    <th>Total Calories</th>
                                    <th>Goal</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptProgress" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%# Container.ItemIndex + 1 %></td>
                                            <td><%# Eval("date", "{0:dd/MM/yyyy}") %></td>
                                            <td><%# Eval("total_calories") %></td>
                                            <td><%# Eval("goal_calories") %></td>
                                            <td><span class='<%# Eval("statusClass") %>'><%# Eval("statusText") %></span></td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>

                </div>

            </div>
        </div>
    </form>

    <script>
        (function(){
            // populate inline fieldError or keep server success panel visible
            var lbl = document.getElementById('<%= msgPanel.ClientID %>');
            if(lbl){
                var text = (lbl.innerText || lbl.textContent || '').trim();
                if(text){
                    // If server rendered a success panel, keep it visible (green).
                    if(lbl.classList && lbl.classList.contains('field-success')){
                        // ensure visible class is applied for animation
                        lbl.classList.add('visible');
                    }
                    else {
                        // For errors, hide server panel and show inline field-error animation
                        lbl.style.display = 'none';
                        var f = document.getElementById('fieldError');
                    if(f){
                            var feText = f.querySelector('.fe-text'); if(feText) feText.textContent = text;
                            f.classList.remove('hidden');
                            setTimeout(function(){ f.classList.add('visible'); },10);
                        }
                    }
                }
            }
            document.addEventListener('click', function(e){
                var t = e.target || e.srcElement;
                if(t && t.classList && t.classList.contains('fe-close')){
                    var f = document.getElementById('fieldError');
                    if(f){ f.classList.remove('visible'); setTimeout(function(){ f.classList.add('hidden'); },240); }
                }
            });
        })();
    </script>
</body>
</html>