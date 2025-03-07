<!--<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Bootstrap Simple Login Form</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <style>
            .login-form {
                width: 340px;
                margin: 50px auto;
                font-size: 15px;
            }
            .login-form form {
                margin-bottom: 15px;
                background: #f7f7f7;
                box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
                padding: 30px;
            }
            .login-form h2 {
                margin: 0 0 15px;
            }
            .form-control, .btn {
                min-height: 38px;
                border-radius: 2px;
            }
            .btn {
                font-size: 15px;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="login-form">
            <h5 style="color: red">${requestScope.error}</h5>
            <form name="changeForm" action="register" onsubmit="return validateForm()>
                <h2 class="text-center">Register</h2>       
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Username" required="required" name="user">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="Password" required="required" name="pass">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="ConfirmPassword" required="required" name="rpass">
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary btn-block">Register</button>
                </div>       
            </form>

        </div>
    </body>
    <script type="text/javascript">
        function validateForm() {
            var newPassword = document.forms["changeForm"]["pass"].value;
            var confirmPassword = document.forms["changeForm"]["rpass"].value;

            if (newPassword != confirmPassword) {
                alert("New password and Confirm password do not match!");
                return false;
            }
        }
    </script>
</html>-->
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
    <head>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <style>
            * {
                font-family: 'Roboto', sans-serif !important;
                font-weight: 400;
            }

            h1, h2, h3, h4, h5, h6 {
                font-family: 'Roboto', sans-serif;
                font-weight: 700;
            }
            body, p, span, a, li, label, button {
                font-family: 'Roboto', sans-serif;
                font-weight: 400;
            }
        </style>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/snow/snow.css">
        <script src="${pageContext.request.contextPath}/snow/snow.js" defer></script>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Bootstrap Simple Login Form</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <style>
            .login-form {
                width: 340px;
                margin: 50px auto;
                font-size: 15px;
            }
            .login-form form {
                margin-bottom: 15px;
                background: #f7f7f7;
                box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
                padding: 30px;
            }
            .login-form h2 {
                margin: 0 0 15px;
            }
            .form-control, .btn {
                min-height: 38px;
                border-radius: 2px;
            }
            .btn {
                font-size: 15px;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="login-form">
            <h5 style="color: red">${requestScope.error}</h5>
            <form action="register" name="changeForm" onsubmit="return validateForm()">
                <h2 class="text-center">Register</h2>   
                <input type="hidden" class="form-control" required name="id">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Yourname" required="required" name="name">
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Email" required="required" name="email">
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Username" required="required" name="user">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="Password" required="required" name="pass">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="ConfirmPassword" required="required" name="rpass">
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-primary btn-block">Register</button>
                </div>      
            </form>
        </div>
    </body>
    <script type="text/javascript">
        function validateForm() {
            var newPassword = document.forms["changeForm"]["pass"].value;
            var confirmPassword = document.forms["changeForm"]["rpass"].value;

            if (newPassword != confirmPassword) {
                alert("New password and Confirm password do not match!");
                return false;
            }
        }
    </script>
</html>