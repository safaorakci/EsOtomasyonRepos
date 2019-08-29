<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

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
                    <div class="signin-card card-block auth-body mr-auto ml-auto">

                        <form method="post" onsubmit="login_kontrol(); return false;" id="login-form" class="smart-form client-form" novalidate="novalidate">
                            <div class="text-center">
                                <div class="row">
                                    <div class="col-md-12"><img src="/images/esotomasyon_logo.png" style="    height: 60px; margin-top: 15px;" /></div>
                                </div>
                                
                            </div>
                            <div class="auth-box" style="text-align: left;">
                                <p class="text-inverse b-b-default text-left p-b-5">Proskop'a hoş geldiniz, e-posta ve parolanız ile güvenli giriş yapabilirsiniz.</p>
                                <div class="input-group">
                                    <input type="email" id="email" name="email" class="form-control" placeholder="E-Posta Adresi">
                                </div>
                                <div class="input-group">
                                    <input type="password" name="password" id="password" class="form-control" placeholder="Parola">
                                </div>
                                <div class="input-group" style="display:none;">
                                    <select name="dil_secenek" class="form-control" id="dil_secenek">
                                        <option value="turkce">Türkçe</option>
                                        <option value="ingilizce">English</option>
                                        <option value="almanca">Deutsch</option>
                                    </select>
                                </div>
                                <div class="row m-t-25 text-left">
                                    <div class="col-12">
                                        <div class="checkbox-fade fade-in-primary">
                                            <label>
                                                <input type="checkbox" checked="checked" value="">
                                                <span class="cr"><i class="cr-icon icofont icofont-ui-check txt-primary"></i></span>
                                                <span class="text-inverse">Oturum açık kalsın</span>
                                            </label>
                                        </div>
                                        <div class="forgot-phone text-right f-right" style="display:none;">
                                            <a href="javascript:void(0);" class="text-right f-w-600 text-inverse">Parolanızı mı unuttunuz?</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="row m-t-30">
                                    <div class="col-md-12">
                                        <button type="submit" class="btn btn-primary btn-md btn-block waves-effect text-center m-b-20">GİRİŞ</button>
                                    </div>
                                </div>
                            </div>

                            <div class="text-center">
                                <div class="row">
                                    <div class="col-md-12"><img style="margin-left:15px;" src="/images/proskop_buyuk.png" alt="Proskop"></div>
                                </div>
                                
                            </div>
                        </form>
                        <div class="col-md-12" style="display:none;">
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
</body>
</html>
