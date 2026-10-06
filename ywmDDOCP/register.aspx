<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="ywmDDOCP.register" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>FitFlow</title>

    <link rel="stylesheet" runat="server" href="style.css" />

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

</head>


<body>

    <div class="container">

        <div class="content">

            <div class="left">
                <!-- Logo removed -->
                <h2 class="site-title">FitFlow</h2>

                <p>
                    Start your fitness journey today and achieve
                    your health goals.
                </p>

            </div>

            <div class="right">

                <h2>REGISTER</h2>
                <form id="form1" runat="server">
               <asp:Label ID="successMsg" runat="server" CssClass="success-message" Visible="false"></asp:Label>
                <p class="welcome"> 
                    Join us and start tracking your fitness journey.
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
                               pattern="^[a-zA-Z0-9]+$" 
                               runat="server">
                        <asp:Label ID="usernameError"
                        runat="server"
                            CssClass="error-message"
                            Text="Use letters and numbers only"
                            Visible="false">

                        </asp:Label>

                    </div>

                    <!-- Email -->
                    <div class="row">

                        <label for="uemail">

                            <i class="fa-regular fa-envelope"></i>
                        Email
                        </label>

                        <input type="email"
                               id="uemail"
                               required
                               placeholder="Email" runat="server">
                            
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
                               pattern="^(?=.*[A-Z])(?=.*[a-z])[A-Za-z0-9]{12}$" runat="server">

                    </div>

                    <!-- Confirm Password -->
                    <div class="row">

                        <label for="ucpass">

                            <i class="fa-solid fa-key"></i>
                        Confirm Password
                        </label>

                        <input type="password"
                               id="ucpass"
                               required
                               placeholder="Confirm Password" runat="server">

                    </div>
                    <!-- I agree to the Terms and Privacy Policy-->
                    <div class="agree">
                        <input type="checkbox" id="Terms" required>
                        <label for="Terms">
                            I agree to the 
                            <a href="#">Terms</a>
                            and 
                            <a href="#">Privacy Policy</a>
                        </label>
                    </div>

                    <!-- Error field above submit -->
                    <div id="fieldError" class="field-error hidden" role="alert" aria-live="assertive">
                        <div class="fe-left">
                            <div class="fe-icon"><i class="fa-solid fa-triangle-exclamation"></i></div>
                            <div class="fe-text"></div>
                        </div>
                        <button type="button" class="fe-close" aria-label="Close">✕</button>
                    </div>

                    <!-- Success field (used after successful registration) -->
                    <div id="fieldSuccess" class="field-success hidden" role="status" aria-live="polite">
                        <div class="fe-left">
                            <div class="fe-icon"><i class="fa-solid fa-circle-check"></i></div>
                            <div class="fe-text"></div>
                        </div>
                    <!-- no immediate action button - only show success message -->
                    </div>

                    <!-- Create Account -->
                    <!-- Server message shown here, above the submit button -->
                    <asp:Label ID="msg" runat="server" CssClass="message" />
                    <div class="btnrow">
                        <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="btn" OnClick="btnRegister_Click" />

                    </div>
                </form>

                <p class="login">
                    Already have an account?
                    <a href="login.aspx">
                        Login
                    </a>
                </p>
            </div>
        </div>
    </div>

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
                if(e.target && e.target.classList && e.target.classList.contains('fe-close')){
                    hideFieldError();
                }
            });

            var hideTimer = null;
            function scheduleAutoHide(){
                if(hideTimer) clearTimeout(hideTimer);
                // auto-hide disabled — keep error visible until user closes
            }

            var lbl = document.getElementById('<%= msg.ClientID %>');
            if(lbl){
                var text = (lbl.innerText || lbl.textContent || '').trim();
                if(text){
                    lbl.style.display='none';
                    showFieldError(text);
                    scheduleAutoHide();
                }
            }

            Array.prototype.slice.call(document.querySelectorAll('.right input')).forEach(function(inp){
                inp.addEventListener('focus', hideFieldError);
            });
        })();
    </script>

</body>

</html>