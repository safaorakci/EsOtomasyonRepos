<%@ Page Language="C#" AutoEventWireup="true" CodeFile="montaj.aspx.cs" Inherits="login" %>

<!DOCTYPE html>

<html lang="tr-TR">

<head>
    <title>Proskop - Makrogem Bilişim Teknolojileri A.Ş.</title>
    <!--[if lt IE 10]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
      <![endif]-->
    <!-- Meta -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <meta name="author" content="Makrogem Bilişim Teknolojileri A.Ş." />
    <link rel="icon" href="/files/assets/images/favicon.ico" type="image/x-icon" />
    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/files/bower_components/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/files/assets/icon/themify-icons/themify-icons.css">
    <link rel="stylesheet" type="text/css" href="/files/assets/icon/icofont/css/icofont.css">
    <link rel="stylesheet" type="text/css" href="/files/assets/icon/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="/files/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="/files/bower_components/animate.css/css/animate.css">

        <link rel="stylesheet" type="text/css" href="/files/assets/css/keyboard.css">
    <link rel="stylesheet" type="text/css" href="/files/assets/css/jquery-ui.min.css">

    <style>
        input.error {
            border: #ff5370 1px solid;
        }

        .error {
            color: #ff5370;
        }
    </style>
</head>
<body class="fix-menu">
    <form id="form1" runat="server">
    </form>
    <div class="theme-loader">
        <div class="loader-track">
            <div class="loader-bar"></div>
        </div>
    </div>
    <section class="login p-fixed d-flex text-center bg-primary common-img-bg">
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12">
                    <div class="signin-card card-block auth-body mr-auto ml-auto" style="width:     1000px;">

                        <form method="post" onsubmit="login_kontrol(); return false;" id="login-form" class="smart-form client-form" novalidate="novalidate">
                            <div class="text-center">
                                <div class="row">
                                    <div class="col-md-12">
                                        <img src="/images/esotomasyon_logo.png" style="height: 60px; margin-top: 15px;" /></div>
                                </div>

                            </div>
                            <div id="loginBox" class="login-card card-block mr-auto ml-auto col-md-11">
                                <form class="md-float-material">
                                  
                                    <div class="auth-box">
                                        <div class="row" id="login1">
                                            <div class="col-md-6 col-xl-3 user">
                                                <div class="card bg-c-blue order-card user">
                                                    <img class="userImg" src="/files/assets/images/SalihŞahin.jpg" height="200" />
                                                    <p class="m-b-0 ">Salih Şahin</p>
                                                </div>

                                            </div>
                                            <div class="col-md-6 col-xl-3 user">
                                                <div class="card bg-c-green order-card user">
                                                    <img class="userImg" src="/files/assets/images/OsmanMamedov.jpg" height="200" />
                                                    <p class="m-b-0">Osman Mamedov</p>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-xl-3 user">
                                                <div class="card bg-c-yellow order-card user">
                                                    <img class="userImg" src="/files/assets/images/CemGaga.jpg" height="200" />
                                                    <p class="m-b-0">Cem Gaga</p>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-xl-3 user">
                                                <div class="card bg-c-pink order-card user">
                                                    <img class="userImg" src="/files/assets/images/User1.png" height="200" />
                                                    <p class="m-b-0">İsim Soyisi</p>
                                                </div>
                                            </div>
                                            <div class="col-md-12" style="padding: 0; margin: 0; margin-top: -30px;">

                                                <input id="num" class="alignRight ui-keyboard-input ui-widget-content ui-corner-all ui-keyboard-autoaccepted" type="password" aria-haspopup="true" role="textbox" style="width: 40px; color: white; background-color: white; border: white;">
                                            </div>
                                            <div class="col-md-6 col-xl-3 user">
                                                <div class="card bg-c-blue order-card user">
                                                    <img class="userImg" src="/files/assets/images/User2.png" height="200" />
                                                    <p class="m-b-0">İsim Soyisi</p>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-xl-3 user">
                                                <div class="card bg-c-green order-card user">
                                                    <img class="userImg" src="/files/assets/images/User4.png" height="200" />
                                                    <p class="m-b-0">İsim Soyisi</p>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-xl-3 user">
                                                <div class="card bg-c-yellow order-card user">
                                                    <img class="userImg" src="/files/assets/images/User3.png" height="200" />
                                                    <p class="m-b-0">İsim Soyisi</p>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-xl-3 user">
                                                <div class="card bg-c-pink order-card user">
                                                    <img class="userImg" src="/files/assets/images/User2.png" height="200" />
                                                    <p class="m-b-0">İsim Soyisi</p>
                                                </div>
                                            </div>
                                        </div>


                                        <div id="login2" class="col-md-6" style="display: none">
                                            <div class="row m-b-20">
                                                <div class="col-md-12">
                                                    <h3 class="text-left txt-primary">Sign In</h3>
                                                </div>
                                            </div>
                                            <hr>
                                            <div class="input-group">
                                                <input type="email" class="form-control" placeholder="Your Email Address">
                                                <span class="md-line"></span>
                                            </div>
                                            <div class="input-group">
                                                <input type="password" class="form-control" placeholder="Password">
                                                <span class="md-line"></span>
                                            </div>
                                            <div class="row m-t-25 text-left">
                                                <div class="col-12">
                                                    <div class="checkbox-fade fade-in-primary d-">
                                                        <label>
                                                            <input type="checkbox" value="">
                                                            <span class="cr"><i class="cr-icon icofont icofont-ui-check txt-primary"></i></span>
                                                            <span class="text-inverse">Remember me</span>
                                                        </label>
                                                    </div>
                                                    <div class="forgot-phone text-right f-right">
                                                        <a href="auth-reset-password.html" class="text-right f-w-600 text-inverse">Forgot Password?</a>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row m-t-30">
                                                <div class="col-md-12">
                                                    <button type="button" class="btn btn-primary btn-md btn-block waves-effect text-center m-b-20">Sign in</button>
                                                </div>
                                            </div>
                                            <hr>
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <p class="text-inverse text-left m-b-0">Thank you and enjoy our website.</p>
                                                    <p class="text-inverse text-left"><b>Your Authentication Team</b></p>
                                                </div>
                                                <div class="col-md-2">
                                                    <button class="btn btn-inverse" onclick="loginBirGoster(1);"><i class="icofont icofont-exchange"></i></button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <!-- end of form -->
                            </div>

                            <div class="text-center">
                                <div class="row">
                                    <div class="col-md-12">
                                        <img style="margin-left: 15px;" src="/images/proskop_buyuk.png" alt="Proskop"></div>
                                </div>

                            </div>
                        </form>
                        <div class="col-md-12" style="display: none;">
                            <p class="text-inverse m-t-25 text-center" style="color: white;">Yeni bir hesap mı açmak istiyorsunuz? <a href="javascript:void(0);">Buraya tıklayın!</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script src="/files/bower_components/jquery/js/jquery.min.js"></script>
    <script src="/files/bower_components/jquery-ui/js/jquery-ui.min.js"></script>
    <script src="/files/bower_components/popper.js/js/popper.min.js"></script>
    <script src="/files/bower_components/bootstrap/js/bootstrap.min.js"></script>
    <script src="/files/bower_components/jquery-slimscroll/js/jquery.slimscroll.js"></script>
    <script src="/files/bower_components/modernizr/js/modernizr.js"></script>
    <script src="/files/bower_components/modernizr/js/css-scrollbars.js"></script>
    <script src="/files/assets/js/common-pages.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore-min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.6/moment.min.js"></script>
    <script src="/js/plugin/jquery-validate/jquery.validate.min.js"></script>
    <script src="/js/plugin/bootstrapvalidator/bootstrapValidator.min.js"></script>
    <script src="/files/assets/js/bootstrap-growl.min.js"></script>
    <script src="/js/proskop.js"></script>
    <script src="/js/proskop_script.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#login-form").validate({
                rules: {
                    email: {
                        required: true,
                        email: true
                    },
                    password: {
                        required: true,
                        minlength: 3,
                        maxlength: 20
                    }
                },
                messages: {
                    email: {
                        required: 'Lütfen E-Posta Adresinizi Giriniz',
                        email: 'E-posta Adresinizi Yanlış Girdiniz.'
                    },
                    password: {
                        required: 'Lütfen Şifrenizi Giriniz'
                    }
                },

                errorPlacement: function (error, element) {
                    error.insertAfter(element.parent());
                }
            });
        });



        function login_kontrol() {

            if ($("#login-form input:not(input[type=button])").valid("valid")) {
                var remember = "false";
                if ($("#remember").attr("checked") == "checked") {
                    remember = "true";
                }
                $.ajax({
                    type: "POST",
                    url: "<%=ResolveUrl("login.aspx/LoginControl") %>",
                    data: "{'email':'" + $("#email").val() + "', 'password':'" + $("#password").val() + "', 'dil_secenek':'" + $("#dil_secenek").val() + "', 'remember':'" + remember + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == "true") {
                            window.location.href = "/default.aspx"
                        } else {
                            mesaj_ver("Uyarı", "E-posta adresinizi veya Şifrenizi Hatalı Girdiniz !", "danger");
                        }
                    }
                })
            }
        }
    </script>
    <link rel="stylesheet" type="text/css" href="/files/bower_components/sweetalert/css/sweetalert.css">
    <link rel="stylesheet" type="text/css" href="/files/bower_components/pnotify/css/pnotify.css">
    <link rel="stylesheet" type="text/css" href="/files/bower_components/pnotify/css/pnotify.brighttheme.css">
    <link rel="stylesheet" type="text/css" href="/files/bower_components/pnotify/css/pnotify.mobile.css">
    <link rel="stylesheet" type="text/css" href="/files/assets/pages/pnotify/notify.css">
    <script src="/files/bower_components/pnotify/js/pnotify.js"></script>
    <script src="/files/bower_components/pnotify/js/pnotify.mobile.js"></script>
    <script src="/files/bower_components/pnotify/js/pnotify.buttons.js"></script>


    <script src="/files/assets/css/jquery.keyboard.js"></script>
    <script>
        $(function () {
            $('#num').keyboard({
                layout: 'num',
                restrictInput: true, // Prevent keys not in the displayed keyboard from being typed in
                preventPaste: true,  // prevent ctrl-v and right click
                autoAccept: true
            });

            $(".userImg").click(function () {

                var kb = $('#num').getkeyboard();
                // change layout based on link ID

                kb.reveal();

            });

        });


    </script>

</body>
</html>
