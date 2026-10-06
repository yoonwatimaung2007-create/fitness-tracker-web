<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="ywmDDOCP.dashboard" %>

<!DOCTYPE html>

<html lang="en">

<head runat="server">

<meta charset="UTF-8" />

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>Fitness Tracker | Dashboard</title>

<link rel="stylesheet" href="style.css" />
<link rel="stylesheet" runat="server" href="dstyle.css" />
<link rel="stylesheet" href="gstyle.css" />

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />
<!-- Bootstrap Icons (used by other pages) -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">

</head>

<body>

<form id="form1" runat="server">

<div class="container">


    <!-- =====================================
         SIDEBAR
    ====================================== -->

    <div class="left">

        <!-- Logo -->
        <h2 class="site-title">FitFlow</h2>


        <div class="menu">

            <a href="goal.aspx">
                <i class="bi bi-bullseye"></i>
                <span>Set Goal</span>
            </a>

            <a href="dashboard.aspx" class="active">
                <i class="bi bi-person-running"></i>
                <span>Dashboard</span>
            </a>

            <a href="progress.aspx">
                <i class="bi bi-graph-up"></i>
                <span>Progress</span>
            </a>

            <a href="goal.aspx#history">
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



    <!-- =====================================
         MAIN CONTENT
    ====================================== -->

    <div class="right">

        <!-- PAGE HEADER (use goal.aspx header structure for consistent layout) -->
        <div class="header">

            <h1>Activity Dashboard</h1>

            <p>Track your workouts and stay consistent with your fitness journey.</p>

        </div>

        <div class="status">
            <span class="status-dot"></span>
            <span>Active</span>
        </div>



        <!-- SERVER MESSAGE -->

        <asp:Label
            ID="msg"
            runat="server">
        </asp:Label>

        <!-- Inline field error above submit (reuses field-error UI) -->
        <div id="fieldError" class="field-error hidden" role="alert" aria-live="assertive">
            <div class="fe-left">
                <div class="fe-icon"><i class="fa-solid fa-triangle-exclamation"></i></div>
                <div class="fe-text"></div>
            </div>
            <button type="button" class="fe-close" aria-label="Close">✕</button>
        </div>



        <!-- DASHBOARD CONTENT -->

        <section class="dashboard-grid">


            <!-- =====================================
                 ACTIVITY CARD
            ====================================== -->

            <div class="dashboard-card activity-card">


                <div class="card-heading">

                    <div class="heading-icon">

                        <i class="fa-solid fa-person-running"></i>

                    </div>

                    <div>

                        <h2>Sports Activities</h2>

                        <p>Select an activity to record your workout.</p>

                    </div>

                </div>



                <!-- ACTIVITY LIST -->
                <asp:HiddenField ID="hfSelectedSport" runat="server" />

                <ul id="sportsList" class="sports-list">


                    <li data-target="panelYoga"
                        class="sport-item">

                        <div class="sport-icon">
                            <i class="fa-solid fa-spa"></i>
                        </div>

                        <div class="sport-info">

                            <strong>Yoga</strong>

                            <span>Flexibility & balance</span>

                        </div>

                        <i class="fa-solid fa-chevron-right sport-arrow"></i>

                    </li>



                    <li data-target="panelRunning"
                        class="sport-item">

                        <div class="sport-icon">
                            <i class="fa-solid fa-person-running"></i>
                        </div>

                        <div class="sport-info">

                            <strong>Running</strong>

                            <span>Distance & duration</span>

                        </div>

                        <i class="fa-solid fa-chevron-right sport-arrow"></i>

                    </li>



                    <li data-target="panelCycling"
                        class="sport-item">

                        <div class="sport-icon">
                            <i class="fa-solid fa-bicycle"></i>
                        </div>

                        <div class="sport-info">

                            <strong>Cycling</strong>

                            <span>Distance & duration</span>

                        </div>

                        <i class="fa-solid fa-chevron-right sport-arrow"></i>

                    </li>



                    <li data-target="panelTrekking"
                        class="sport-item">

                        <div class="sport-icon">
                            <i class="fa-solid fa-person-hiking"></i>
                        </div>

                        <div class="sport-info">

                            <strong>Trekking</strong>

                            <span>Distance & elevation</span>

                        </div>

                        <i class="fa-solid fa-chevron-right sport-arrow"></i>

                    </li>


                </ul>



                <!-- =====================================
                     YOGA PANEL
                ====================================== -->

                <div id="panelYoga"
                     class="sport-panel"
                     style="display:none;">

                    <div class="panel-heading">

                        <i class="fa-solid fa-spa"></i>

                        <span>Record Yoga</span>

                    </div>


                    <asp:TextBox
                        ID="txtYogaMinutes"
                        runat="server"
                        placeholder="Minutes"
                        CssClass="goal-input">
                    </asp:TextBox>


                    <asp:TextBox
                        ID="txtYogaPose"
                        runat="server"
                        placeholder="Pose / Notes"
                        CssClass="goal-input">
                    </asp:TextBox>


                    <asp:Button
                        ID="btnSaveYoga"
                        runat="server"
                        Text="Save Yoga Activity"
                        OnClick="btnSaveYoga_Click"
                        CssClass="goal-btn" />

                </div>



                <!-- =====================================
                     RUNNING PANEL
                ====================================== -->

                <div id="panelRunning"
                     class="sport-panel"
                     style="display:none;">

                    <div class="panel-heading">

                        <i class="fa-solid fa-person-running"></i>

                        <span>Record Running</span>

                    </div>


                    <asp:TextBox
                        ID="txtRunDistance"
                        runat="server"
                        placeholder="Distance (km)"
                        CssClass="goal-input">
                    </asp:TextBox>


                    <asp:TextBox
                        ID="txtRunDuration"
                        runat="server"
                        placeholder="Duration (minutes)"
                        CssClass="goal-input">
                    </asp:TextBox>


                    <asp:Button
                        ID="btnSaveRun"
                        runat="server"
                        Text="Save Running Activity"
                        OnClick="btnSaveRun_Click"
                        CssClass="goal-btn" />

                </div>



                <!-- =====================================
                     CYCLING PANEL
                ====================================== -->

                <div id="panelCycling"
                     class="sport-panel"
                     style="display:none;">

                    <div class="panel-heading">

                        <i class="fa-solid fa-bicycle"></i>

                        <span>Record Cycling</span>

                    </div>


                    <asp:TextBox
                        ID="txtCycleDistance"
                        runat="server"
                        placeholder="Distance (km)"
                        CssClass="goal-input">
                    </asp:TextBox>


                    <asp:TextBox
                        ID="txtCycleDuration"
                        runat="server"
                        placeholder="Duration (minutes)"
                        CssClass="goal-input">
                    </asp:TextBox>


                    <asp:Button
                        ID="btnSaveCycle"
                        runat="server"
                        Text="Save Cycling Activity"
                        OnClick="btnSaveCycle_Click"
                        CssClass="goal-btn" />

                </div>



                <!-- =====================================
                     TREKKING PANEL
                ====================================== -->

                <div id="panelTrekking"
                     class="sport-panel"
                     style="display:none;">

                    <div class="panel-heading">

                        <i class="fa-solid fa-person-hiking"></i>

                        <span>Record Trekking</span>

                    </div>


                    <asp:TextBox
                        ID="txtTrekDistance"
                        runat="server"
                        placeholder="Distance (km)"
                        CssClass="goal-input">
                    </asp:TextBox>


                    <asp:TextBox
                        ID="txtTrekElevation"
                        runat="server"
                        placeholder="Elevation (m)"
                        CssClass="goal-input">
                    </asp:TextBox>


                    <asp:Button
                        ID="btnSaveTrek"
                        runat="server"
                        Text="Save Trekking Activity"
                        OnClick="btnSaveTrek_Click"
                        CssClass="goal-btn" />

                </div>


            </div>



            <!-- =====================================
                 ACTIVITY HISTORY
            ====================================== -->

            <div class="dashboard-card history-card">


                <div class="card-heading">

                    <div class="heading-icon">

                        <i class="fa-solid fa-clock-rotate-left"></i>

                    </div>

                    <div>

                        <h2>Your Activity History</h2>

                        <p>Your recently recorded activities.</p>

                    </div>

                </div>



                <asp:Label
                    ID="lblNoActivityHistory"
                    runat="server"
                    CssClass="goal-message">
                </asp:Label>



                <div class="history-content">

                    <div class="history-table-wrapper">


                        <asp:Repeater
                            ID="rptActivityHistory"
                            runat="server">


                            <HeaderTemplate>

                                <table class="history-table">

                                    <thead>

                                        <tr>

                                            <th>No.</th>

                                            <th>Date</th>

                                            <th>Activity</th>

                                            <th>Details</th>

                                        </tr>

                                    </thead>

                                    <tbody>

                            </HeaderTemplate>


                            <ItemTemplate>

                                <tr>

                                    <td class="number-cell">

                                        <%# Container.ItemIndex + 1 %>

                                    </td>


                                    <td>

                                        <span class="date-text">

                                            <%# Eval("date", "{0:dd/MM/yyyy HH:mm}") %>

                                        </span>

                                    </td>


                                    <td>

                                        <span class="activity-badge">

                                            <%# Eval("activity_type") %>

                                        </span>

                                    </td>


                                    <td class="details-cell">

                                        <%# Eval("details") %>

                                    </td>

                                </tr>

                            </ItemTemplate>


                            <FooterTemplate>

                                    </tbody>

                                </table>

                            </FooterTemplate>


                        </asp:Repeater>


                    </div>

                </div>


            </div>


        </section>


    </main>

</div>

</form>



<script type="text/javascript">
    (function () {
        // fieldError helpers for dashboard page
        function showFieldError(message){
            var field = document.getElementById('fieldError');
            if(!field) return;
            var text = field.querySelector('.fe-text');
            if(text) text.textContent = message || '';
            field.classList.remove('hidden');
            setTimeout(function(){ if(field) field.classList.add('visible'); }, 10);
        }

        function hideFieldError(){
            var field = document.getElementById('fieldError');
            if(!field) return;
            field.classList.remove('visible');
            setTimeout(function(){ field.classList.add('hidden'); }, 240);
        }

        document.addEventListener('click', function(e){
            var t = e.target || e.srcElement;
            try {
                if(t && t.classList && t.classList.contains('fe-close')){
                    hideFieldError();
                }
            } catch (ex) { /* defensive: ignore host typing errors */ }
        });

        // hide when user focuses any input in main content
        document.addEventListener('focusin', function(e){
            var t = e.target || e.srcElement;
            if(t && (t.tagName === 'INPUT' || t.tagName === 'TEXTAREA' || t.tagName === 'SELECT')){
                hideFieldError();
            }
        });

        var lblMsg = document.getElementById('<%= msg.ClientID %>');
        if(lblMsg){
            var t = (lblMsg.innerText || lblMsg.textContent || '').trim();
            if(t){
                // If server produced a success message, keep it visible with success styling
                if(lblMsg.classList && lblMsg.classList.contains('field-success')){
                    lblMsg.classList.add('visible');
                } else {
                    // otherwise treat as error and show inline animation
                    lblMsg.style.display='none';
                    showFieldError(t);
                }
            }
        }

        var items = document.querySelectorAll('#sportsList .sport-item');
        var panels = document.querySelectorAll('.sport-panel');
        var hf = document.getElementById('<%= hfSelectedSport.ClientID %>');

        function hideAll() {
            panels.forEach(function (p) { p.style.display = 'none'; });
            items.forEach(function (i) { i.classList.remove('active'); });
        }

        // restore selected panel on load if hidden field has value
        document.addEventListener('DOMContentLoaded', function () {
            if (hf && hf.value) {
                hideAll();
                var el = document.getElementById(hf.value);
                if (el) el.style.display = 'block';
                var li = document.querySelector('[data-target="' + hf.value + '"]');
                if (li) li.classList.add('active');
            }
        });

        items.forEach(function (it) {
            it.addEventListener('click', function () {
                var target = this.getAttribute('data-target');
                hideAll();
                var panel = document.getElementById(target);
                if (panel) panel.style.display = 'block';
                this.classList.add('active');
                if (hf) hf.value = target; // persist selection for postback
            });
        });
    // Logout helper (submits to server logout handler)
    function logout(){
        var f = document.getElementById('logoutForm');
        if(!f){
            f = document.createElement('form');
            f.method = 'post';
            f.action = 'logout.aspx';
            f.style.display = 'none';
            document.body.appendChild(f);
            f.submit();
            return;
        }
        f.submit();
    }
    })();
</script>

</body>

</html>
<!-- EOF: dashboard.aspx - placeholder to ensure file end context -->
