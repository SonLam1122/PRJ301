<%-- 
    Document   : headeradmin
    Created on : Mar 5, 2025, 1:22:43 PM
    Author     : MSI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body class="ec-header-fixed ec-sidebar-fixed ec-sidebar-light ec-header-light sidebar-minified" id="body">
       	<header class="ec-main-header" id="header">
            <nav class="navbar navbar-static-top navbar-expand-lg">
                <!-- Sidebar toggle button -->
                <button id="sidebar-toggler" class="sidebar-toggle"></button>
                <!-- search form -->
                <div class="search-form d-lg-inline-block">

                </div>

                <!-- navbar right -->
                <div class="navbar-right">
                    <ul class="nav navbar-nav">
                        <!-- User Account -->
                        <li class="dropdown user-menu">
                            <button class="dropdown-toggle nav-link ec-drop" data-bs-toggle="dropdown"
                                    aria-expanded="false">
                                <img src="assets/img/user/user.png" class="user-image" alt="User Image" />
                            </button>
                            <ul class="dropdown-menu dropdown-menu-right ec-dropdown-menu">
                                <!-- User image -->
                                <li class="dropdown-header">
                                    <img src="assets/img/user/user.png" class="img-circle" alt="User Image" />
                                    <div class="d-inline-block">
                                        John Deo <small class="pt-1">john.example@gmail.com</small>
                                    </div>
                                </li>
                                <li>
                                    <a href="user-profile.html">
                                        <i class="mdi mdi-account"></i> My Profile
                                    </a>
                                </li>
                                <li class="dropdown-footer">
                                    <a href="index.html"> <i class="mdi mdi-logout"></i> Log Out </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
    </body>
</html>
