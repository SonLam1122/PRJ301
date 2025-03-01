<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- basic -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- mobile metas -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="viewport" content="initial-scale=1, maximum-scale=1">
        <!-- site metas -->
        <title>Movies</title>
        <meta name="keywords" content="">
        <meta name="description" content="">
        <meta name="author" content="">
        <!-- bootstrap css -->
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <!-- style css -->
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <!-- Responsive-->
        <link rel="stylesheet" href="css/responsive.css">
        <!-- fevicon -->
        <link rel="icon" href="images/fevicon.png" type="image/gif" />
        <!-- Scrollbar Custom CSS -->
        <link rel="stylesheet" href="css/jquery.mCustomScrollbar.min.css">
        <!-- Tweaks for older IEs-->
        <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
        <!-- owl stylesheets --> 
        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css" media="screen">
        <link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <!-- header section start -->
        <div class="header_section">
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <a class="logo" href="home"><img src="images/iconbook.png"></a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="home.jsp">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="library">Library</a>
                        </li>
                    </ul>
                    <form id="f1" action="search">
                        <input type="text" name="key" placeholder="Nhập tên, miêu tả"/><br/>
                        <input type="submit" value="Search"/>
                    </form>

                 

                    <c:if test="${not empty sessionScope.account}">
                        <div class="search_icon"><a href="changepassword.jsp"><img src="images/notification-icon.png"><span class="padding_left_15">Change Password</span></a></div>
                        <div class="search_icon"><a href="logout"><img src="images/eye-icon.png"><span class="padding_left_15">Logout</span></a></div>
                        <div class="search_icon"><a href="#" onclick="show()"><img src="images/eye-icon.png"><span class="padding_left_15">Profile</span></a></div>
                            </c:if> 
                    <div id="profile" style="display: none">
                        Username:${sessionScope.account.username}
                        <br/>
                        Name:${sessionScope.account.name}
                        <br/>
                        Amount:${sessionScope.account.amount}
                    </div>
                    <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" style="margin-left: 30px" fill="currentColor" class="bi bi-cart" viewBox="0 0 16 16">                    
                    <a href="show">
                        <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5M3.102 4l1.313 7h8.17l1.313-7zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4m7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4m-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2m7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2"/>
                    </a>
                    </svg>
                </div>
            </nav>
        </div>
        <!-- header section end -->
        <!-- movies section start -->
        <div class="movies_section layout_padding">
            <div class="container">                      
                <div class="movies_section_2 layout_padding">
                    <div class="movies_main">
                        <div class="iamge_movies_main " >

                            <c:forEach items="${requestScope.library}" var="p" >
                                <div class="iamge_movies col-2" >
                                    <div class="image_3">
                                        <img src="${p.image}" class="image" style="width:100%">
                                        <div class="middle">
                                            <div class="playnow_bt"><a href="detailproduct?pid=${p.bookId}">Borrow</a></div>
                                        </div>
                                    </div>
                                    <h1 class="code_text">${p.title}</h1>
                                    <div class="star_icon">
                                        <ul>
                                            <li><a href="#"><img src="images/star-icon.png"></a></li>
                                            <li><a href="#"><img src="images/star-icon.png"></a></li>
                                            <li><a href="#"><img src="images/star-icon.png"></a></li>
                                            <li><a href="#"><img src="images/star-icon.png"></a></li>
                                            <li><a href="#"><img src="images/star-icon.png"></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </c:forEach>

                        </div>
                    </div>
                </div>
                <div class="clearfix">
                    <ul class="pagination">                          
                        <c:forEach begin="1" end="${totalPages}" var="pageNumber">
                            <li class="page-item"><a class="page-link" href="library?page=${pageNumber}">${pageNumber}</a></li>
                        </c:forEach>   
                    </ul>
                </div>
                <script>
                    $('#datepicker').datepicker({
                        uiLibrary: 'bootstrap4'
                    });
                    //                            function change() {
                    //                                document.getElementById("f1").submit();
                    //                            }

                    function show() {
                        var x = document.getElementById("profile");
                        if (x.style.display == "none") {
                            x.style.display = "block";
                        } else {
                            x.style.display = "none";
                        }
                    }
                </script>
                </body>
                </html>

                <style>
                    .iamge_movies_main {
                        display: flex;
                        flex-wrap: wrap;
                    }
                </style>
