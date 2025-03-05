<%-- 
    Document   : adminpage
    Created on : Mar 5, 2025, 1:26:30 PM
    Author     : MSI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>


        <!-- GOOGLE FONTS -->
        <link rel="preconnect" href="https://fonts.googleapis.com/">
        <link rel="preconnect" href="https://fonts.gstatic.com/" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@200;300;400;500;600;700;800&amp;family=Poppins:wght@300;400;500;600;700;800;900&amp;family=Roboto:wght@400;500;700;900&amp;display=swap" rel="stylesheet"> 


        <!--<link href="../../../../../cdn.jsdelivr.net/npm/%40mdi/font%404.4.95/css/materialdesignicons.min.css" rel="stylesheet" />-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/stylesheets/materialdesignicons.min.css">

        <!-- PLUGINS CSS STYLE -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/stylesheets/daterangepicker.css">

        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/stylesheets/simplebar.css">

        <!-- Ekka CSS -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/stylesheets/ekka.css">
        <!-- FAVICON -->
        <link rel="images" href="${pageContext.request.contextPath}/images/icons/favicon.png">

    </head>
    <body class="ec-header-fixed ec-sidebar-fixed ec-sidebar-light ec-header-light" id="body">
        <div class="wrapper">

            <div class="ec-page-wrapper">
                <jsp:include page="./navbaradmin.jsp"></jsp:include>
                    <!-- Header -->
                <jsp:include page="./headeradmin.jsp"></jsp:include>


                <jsp:include page="./footeradmin.jsp"/>

            </div> <!-- End Page Wrapper -->
        </div>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/jquery-3.5.1.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/bootstrap.bundle.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/simplebar.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/jquery.zoom.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/slick.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/Chart.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/chart.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/google-map-loader.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/google-map.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/ekka.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/optionswitcher.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/moment.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/daterangepicker.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/date-range.js"></script>
    </body>
</html>
