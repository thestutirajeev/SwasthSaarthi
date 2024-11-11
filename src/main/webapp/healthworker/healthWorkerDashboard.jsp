<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    // Get user initials from session
    String userName = (String) session.getAttribute("healthWorkerName");
    String initials = "";

    if (userName != null && !userName.isEmpty()) {
        String[] nameParts = userName.split(" ");
        for (String part : nameParts) {
            initials += part.charAt(0); // Get first initials
        }
    } else {
        initials = "U"; // Default initials if no user is logged in
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Health Worker Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
    	    .flash-message {
            display: none;
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 10px;
            background-color: #28a745;
            color: white;
            border-radius: 5px;
            z-index: 1000;
        }
    </style>
    
    <style>
        .navbar {
            flex-wrap: wrap; /* Allow wrapping */
        }
        .navbar-nav {
            display: flex;
            justify-content: space-between; /* Equal space between nav items */
        }
        .dropdown-toggle::after { 
            content: none; 
        } 
        .profile-initials {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background-color: #007bff; /* Bootstrap primary color */
            color: white;
            text-align: center;
            line-height: 30px; /* Center initials vertically */
            font-weight: bold;
        }
        .oval-img {
            width: 100%;
            height: auto;
            border-radius: 50%;
        }
        .content-section {
            height: 85vh; /* Full height layout */
            display: flex;
            align-items: center;
        }
        .part1 p {
            margin-bottom: 1rem;
        }
        .part1 i {
            margin-right: 10px;
        }
        .btn-book {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<!-- Navbar Section -->
<nav class="navbar navbar-expand-lg bg-body-secondary">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <img src="${pageContext.request.contextPath}/resource/logo_swasth.jpg" alt="Logo" width="60" height="60" class="me-2">
            <span>Swasth Saarthi</span>
        </a>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/event/workerevent.jsp" class="nav-link">My Events</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/appointment/workerbookedAppointment.jsp" class="nav-link">My Slots</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/blog/workerblogList.jsp" class="nav-link">My Blogs</a>
                </li>
            </ul>
        </div>

        <!-- Profile Dropdown -->
        <div class="dropdown">
            <button class="btn profile-initials dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                <%= initials %>
            </button>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton">
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/home.jsp">Log Out</a></li>
            </ul>
        </div>
    </div>
</nav>
<!-- Flash Message Container -->
    <div class="flash-message" id="flashMessage">
        <%= request.getParameter("message") != null ? request.getParameter("message") : "" %>
    </div>
	
<!-- Content Section -->
<div class="container-fluid">
    <div class="row content-section d-flex justify-content-evenly">
        <!-- First Part: 30% with 3 paragraphs and Icons -->
        <div class="col-12 col-md-3 part1">
            <p><i class="bi bi-info-circle-fill text-primary fs-5"></i>The medical jargon and technical details? All simplified, so the entire process is easy to understand.</p><br>
            <p><i class="bi bi-search text-primaryfs-5"></i>We'll match you to trials and keep searching until we find the right one for you.</p><br>
            <p><i class="bi bi-globe text-primary fs-5"></i>See if you're eligible to join the latest publicly and privately funded clinical trials from around the world.</p>
        </div>

        <!-- Second Part: 30% with Oval Health Image -->
        <div class="col-12 col-md-3 text-center">
            <img src="${pageContext.request.contextPath}/resource/viewimg.jpg" alt="Health Image" class="oval-img img-fluid">
        </div>

        <!-- Third Part: 40% with Title, Description, and Appointment Button -->
        <div class="col-12 col-md-4">
            <h1>Healthcare Services</h1>
            <p>At our healthcare center, we provide comprehensive services to cater to your needs. Create your profile, let us do the searching, and then easily apply to the trials you're eligible for. We'll help you along your journey to accessing the right study for you.</p>
			<a href="${pageContext.request.contextPath}/blog/writeBlog.jsp" class="btn btn-primary btn-book">Write Blog</a>
        </div>
    </div>
</div>
<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.querySelector('.profile-initials').addEventListener('click', function() {
        var sidebar = document.getElementById('sidebar');
        if (sidebar.style.display === "none" || sidebar.style.display === "") {
            sidebar.style.display = "block"; 
        } else {
            sidebar.style.display = "none"; 
        }
    });

    document.addEventListener('click', function(event) {
        var sidebar = document.getElementById('sidebar');
        if (!sidebar.contains(event.target) && !event.target.classList.contains('profile-initials')) {
            sidebar.style.display = "none"; 
        }
    });
</script>
<script>
        window.onload = function() {
            const message = "<%= request.getParameter("message") != null ? request.getParameter("message") : "" %>";
            const flashMessageDiv = document.getElementById('flashMessage');

            if (message) {
                flashMessageDiv.style.display = 'block'; // Show flash message
                setTimeout(function() {
                    flashMessageDiv.style.display = 'none'; // Hide after 10 seconds
                }, 5000);
            }
        };
</script>
</body>
</html>