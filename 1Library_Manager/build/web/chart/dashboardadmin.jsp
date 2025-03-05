
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>


        <!-- GOOGLE FONTS -->
        <link rel="preconnect" href="https://fonts.googleapis.com/">
        <link rel="preconnect" href="https://fonts.gstatic.com/" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@200;300;400;500;600;700;800&amp;family=Poppins:wght@300;400;500;600;700;800;900&amp;family=Roboto:wght@400;500;700;900&amp;display=swap" rel="stylesheet"> 
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


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

            <jsp:include page="./navbaradmin.jsp"></jsp:include>
                <!-- Header -->

            <jsp:include page="./headeradmin.jsp"></jsp:include>

                <div class="ec-page-wrapper">
                    <div class="content">

                        <div class="row">
                            <div class="col-xl-3 col-sm-6 p-b-15 lbl-card">
                                <div class="card card-mini dash-card card-1">
                                    <div class="card-body">
                                        <h2 class="mb-1">${totalnumberbook}</h2>
                                    <p>Book Borrowed</p>
                                    <span class="mdi mdi-book"></span> <!-- Updated to book icon -->
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-3 col-sm-6 p-b-15 lbl-card">
                            <div class="card card-mini dash-card card-2">
                                <div class="card-body">
                                    <h2 class="mb-1">${totalPeople}</h2>
                                    <p>Total People Borrowed</p>
                                    <span class="mdi mdi-account-clock"></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-sm-6 p-b-15 lbl-card">
                            <div class="card card-mini dash-card card-3">
                                <div class="card-body">
                                    <h2 class="mb-1">${totalUsers}</h2>
                                    <p>Toatal Uers</p>
                                    <span class="mdi mdi-package-variant"></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-sm-6 p-b-15 lbl-card">
                            <div class="card card-mini dash-card card-4">
                                <div class="card-body">
                                    <h2 class="mb-1">${totalFines}</h2>
                                    <p>Total Fines</p>
                                    <span class="mdi mdi-currency-usd"></span>
                                </div>
                            </div>
                        </div>
                    </div>



                    <div class="row">
                        <div class="col-xl-8 col-md-12 p-b-15">
                            <!-- User activity statistics -->
                            <div class="card card-default" id="user-activity">
                                <div class="no-gutters">
                                    <div>
                                        <div class="card-header justify-content-between">
                                            <h2>User Activity</h2>
                                            <div class="date-range-report">
                                                <form id="dateRangeForm" method="get" action="${pageContext.request.contextPath}/admin" class="form-inline mb-3">
                                                    <div class="form-group d-flex">
                                                        <label for="dateRange" class="mr-2">Select Date Range:</label>
                                                        <select name="dateRange" id="dateRange" class="form-control mr-2" onchange="toggleCustomDateRange()">
                                                            <option value="yesterday" ${param.dateRange == 'yesterday' ? 'selected' : ''}>Yesterday</option>
                                                            <option value="last7days" ${param.dateRange == 'last7days' ? 'selected' : ''}>Last 7 Days</option>
                                                            <option value="last30days" ${param.dateRange == 'last30days' ? 'selected' : ''}>Last 30 Days</option>
                                                            <option value="custom" ${param.dateRange == 'custom' ? 'selected' : ''}>From-To</option>
                                                        </select>

                                                        <!-- Custom Date Range Inputs -->
                                                        <div id="customDateRange" style="display: none;">
                                                            <input type="date" name="startDate" id="startDate" class="form-control mr-2" value="${param.startDate}">
                                                            <input type="date" name="endDate" id="endDate" class="form-control mr-2" value="${param.endDate}">
                                                        </div>

                                                        <button type="submit" class="btn btn-primary">Apply</button>
                                                    </div>
                                                </form>
                                            </div>

                                            <script>
                                                function toggleCustomDateRange() {
                                                var dateRange = document.getElementById('dateRange').value;
                                                var customDateRange = document.getElementById('customDateRange');
                                                if (dateRange === 'custom') {
                                                customDateRange.style.display = 'block';
                                                } else {
                                                customDateRange.style.display = 'none';
                                                }
                                                }
                                            </script>

                                        </div>
                                        <div class="card-body">
                                            <div class="tab-content" id="userActivityContent">
                                                <div class="tab-pane fade show active" id="user" role="tabpanel">
                                                    <canvas id="activity" class="chartjs"></canvas>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-footer d-flex flex-wrap bg-white border-top">
                                            <a href="#" class="text-uppercase py-3">In-Detail Overview</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

            </div>








        </div>
        <jsp:include page="./footeradmin.jsp"/>

        <script>
            var activityData = [
            {
            first: [<c:forEach var="map" items="${dataChart1}" varStatus="loop">
                ${map.borrowedCount}
                <c:if test="${!loop.last}">,</c:if>
            </c:forEach>],
                    second: [<c:forEach var="map" items="${dataChart1}" varStatus="loop">
                ${map.returnedCount}<c:if test="${!loop.last}">,</c:if>
            </c:forEach>]
            }
            ];
            var labels = [<c:forEach var="map" items="${dataChart1}" varStatus="loop">
            "${map.date}"<c:if test="${!loop.last}">,</c:if>
            </c:forEach>];
            console.log("borrowedCount:", activityData[0].first); // Kiểm tra giá trị borrowedCount
            console.log("returnedCount:", activityData[0].second); // Kiểm tra giá trị returnedCount

            var activity = document.getElementById("activity");
            if (activity !== null) {
            var config = {
            type: "line",
                    data: {
                    labels: labels, // Dữ liệu labels từ ngày của bạn
                            datasets: [
                            {
                            label: "Người mượn",
                                    backgroundColor: "transparent",
                                    borderColor: "rgba(82, 136, 255, .8)",
                                    data: activityData[0].first, // Dữ liệu mượn
                                    lineTension: 0,
                                    pointRadius: 5,
                                    pointBackgroundColor: "rgba(255,255,255,1)",
                                    pointHoverBackgroundColor: "rgba(255,255,255,1)",
                                    pointBorderWidth: 2,
                                    pointHoverRadius: 7,
                                    pointHoverBorderWidth: 1
                            },
                            {
                            label: "Người trả",
                                    backgroundColor: "transparent",
                                    borderColor: "rgba(255, 199, 15, .8)",
                                    data: activityData[0].second, // Dữ liệu trả
                                    lineTension: 0,
                                    borderDash: [10, 5],
                                    borderWidth: 1,
                                    pointRadius: 5,
                                    pointBackgroundColor: "rgba(255,255,255,1)",
                                    pointHoverBackgroundColor: "rgba(255,255,255,1)",
                                    pointBorderWidth: 2,
                                    pointHoverRadius: 7,
                                    pointHoverBorderWidth: 1
                            }
                            ]
                    },
                    options: {
                    responsive: true,
                            maintainAspectRatio: false,
                            legend: { display: false },
                            scales: {
                            xAxes: [{
                            gridLines: { display: false },
                                    ticks: { fontColor: "#8a909d" }
                            }],
                                    yAxes: [{
                                    gridLines: { fontColor: "#8a909d", color: "#eee", zeroLineColor: "#eee" },
                                            ticks: { stepSize: 50, fontColor: "#8a909d" }
                                    }]
                            },
                            tooltips: {
                            mode: "index",
                                    intersect: false,
                                    backgroundColor: "rgba(256,256,256,0.95)",
                                    borderColor: "rgba(220, 220, 220, 0.9)",
                                    borderWidth: 2
                            }
                    }
            };
            var ctx = activity.getContext("2d");
            var myLine = new Chart(ctx, config);
            }
        </script>

        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/jquery-3.5.1.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/bootstrap.bundle.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/simplebar.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/jquery.zoom.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/slick.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/Chart.min.js"></script>
        <!--<script type="text/javascript" src="${pageContext.request.contextPath}/javascript/chart.js"></script>-->
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/google-map-loader.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/google-map.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/ekka.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/optionswitcher.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/moment.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/daterangepicker.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/javascript/date-range.js"></script>
    </body>
</html>
