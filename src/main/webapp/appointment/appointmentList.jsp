<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="appointment.Appointment" %> <!-- Update with the actual package name -->
<%@ page import="database.AccessDatabase" %> <!-- Update with the actual package name -->
<%
    // Get user initials from session
    String userName = (String) session.getAttribute("residentName");
    String initials = "";

    if (userName != null && !userName.isEmpty()) {
        String[] nameParts = userName.split(" ");
        for (String part : nameParts) {
            initials += part.charAt(0); // Get first initials
        }
    } else {
        initials = "U"; // Default initials if no user is logged in
    }

    // Fetch upcoming appointments
    AccessDatabase db = AccessDatabase.getInstance();
    List<Appointment> appointmentList = db.getUpcomingAppointments(); // Fetch upcoming appointments
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Appointments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
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
        /* Basic Reset */
        body, h2, p {
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Arial', sans-serif; /* Clean and readable font */
            background-color: #f8f9fa; /* Light background color */
        }

        .container {
            max-width: 800px; /* Max width of the container */
            margin: auto; /* Center the container */
            padding: 20px; /* Padding around the container */
            background-color: white; /* White background for the container */
            border-radius: 8px; /* Rounded corners */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow effect */
        }

        h2 {
            color: #343a40; /* Dark color for the heading */
            margin-bottom: 20px; /* Space below the heading */
            text-align: center; /* Center align the heading */
        }

        .card {
            border: 1px solid #dee2e6; /* Light grey border */
            border-radius: 5px; /* Rounded corners for cards */
            transition: box-shadow 0.3s; /* Smooth transition for shadow */
        }

        .card:hover {
            box-shadow: 0 4px 20px rgba(0, 123, 255, 0.2); /* Shadow effect on hover */
        }

        .card-body {
            padding: 20px; /* Padding inside the card */
        }

        .card-title {
            font-size: 1.5rem; /* Font size for the appointment title */
            color: #007bff; /* Blue color for the title */
        }

        .card-text {
            font-size: 1rem; /* Font size for the text */
            color: #495057; /* Darker text color */
        }

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
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg bg-body-secondary">
        <div class="container-fluid">
            <a "${pageContext.request.contextPath}/resident/residentDashboard.jsp" class="navbar-brand d-flex align-items-center" href="#">
            <img src="${pageContext.request.contextPath}/resource/logo_swasth.jpg" alt="Logo" width="60" height="60" class="me-2">
                <span>Swasth Saarthi</span>
            </a>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/event/event.jsp" class="nav-link">Event</a>
	                </li>
	                <li class="nav-item">
	                    <a href="${pageContext.request.contextPath}/appointment/bookAppointment.jsp" class="nav-link">Appointment</a>
	                </li>
	                <li class="nav-item">
	                    <a href="${pageContext.request.contextPath}/blog/blogList.jsp" class="nav-link">Blog</a>
	                </li>
                </ul>
            </div>

            <!-- Profile Dropdown -->
            <div class="dropdown">
                <button class="btn profile-initials dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                    <%= initials %>
                </button>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/resident/residentProfile.jsp">User Details</a></li>
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/appointment/appointmentList.jsp">Appointment History</a></li>
                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/home.jsp">Log Out</a></li>
            </ul>
            </div>
        </div>
    </nav>
    <!-- Flash Message Container -->
    <div class="flash-message" id="flashMessage">
        <%= request.getParameter("message") != null ? request.getParameter("message") : "" %>
    </div>
	
    <div class="container mt-5">
        <h2 class="mb-4">Upcoming Appointments</h2>

        <%
            // Check if there are appointments to display
            if (appointmentList.isEmpty()) { // If no appointments found
        %>
            <p>No upcoming appointments found.</p>
        <%
            } else {
                // Looping through the appointment list to display each appointment
                for (Appointment appointment : appointmentList) {
                    int appointmentId = appointment.getAppointmentId();
                    int healthId = appointment.getHealthId();
                    int userId = appointment.getUserId();
                    java.sql.Date appointmentDate = appointment.getAppointmentDate();
                    String status = appointment.getStatus();

                    // Formatting date
                    String formattedDate = new SimpleDateFormat("d-MMM-yyyy").format(appointmentDate);
        %>
                <div class="card mb-4">
                    <div class="card-body">
                        <h5 class="card-title">Appointment ID: <%= appointmentId %></h5>
                        <p class="card-text"><strong>Health ID:</strong> <%= healthId %></p>
                        <p class="card-text"><strong>User ID:</strong> <%= userId %></p>
                        <p class="card-text"><strong>Appointment Date:</strong> <%= formattedDate %></p>
                        <p class="card-text"><strong>Status:</strong> <%= status %></p>
                    </div>
                </div>
        <%
                }
            }
        %>
    </div>

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
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
