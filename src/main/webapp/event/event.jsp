<%@ page import="java.util.List" %>
<%@ page import="event.Event" %>
<%@ page import="database.AccessDatabase" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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

    // Fetch events using searchEvents method
    AccessDatabase db = AccessDatabase.getInstance();
    List<Event> eventList = db.searchEvents(null, null); // Fetch all events
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Events</title>
    <style>
        /* Your existing styles */
    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg bg-body-secondary">
        <div class="container-fluid">
            <a href="${pageContext.request.contextPath}/resident/residentDashboard.jsp" class="navbar-brand d-flex align-items-center" href="#">
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

    <div class="container mt-5">
        <h2 class="mb-4">Upcoming Events</h2>

        <% 
            // Check if the event list is not empty
            if (eventList.isEmpty()) {
        %>
            <p>No events found.</p>
        <% 
            } else { 
                for (Event event : eventList) {
                    String eventName = event.getEventName();
                    String villageName = event.getVillageName();
                    java.sql.Date eventStartDate = event.getEventStartDate();
                    java.sql.Date eventEndDate = event.getEventEndDate();
                    String eventDescription = event.getEventDescription();
        %>
            <div class="card mb-4">
                <div class="card-body">
                    <!-- Event Title -->
                    <h5 class="card-title"><%= eventName %></h5>

                    <!-- Event Dates -->
                    <p class="card-text text-muted small">
                        <%= eventStartDate %> - <%= eventEndDate %>
                    </p>

                    <!-- Village Name -->
                    <p class="card-text text-muted">
                        Village: <%= villageName %>
                    </p>

                    <!-- Event Description -->
                    <p class="card-text">
                        <%= eventDescription.length() > 150 ? eventDescription.substring(0, 150) + "..." : eventDescription %>
                    </p>
                </div>
            </div>
        <%
                }
            }
        %>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <h5>For Patients</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-decoration-none">Why Clinical Trials?</a></li>
                        <li><a href="#" class="text-decoration-none">Guides</a></li>
                        <li><a href="#" class="text-decoration-none">Patients</a></li>
                        <li><a href="blog.jsp" class="text-decoration-none">Blog</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h5>For Sponsors</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-decoration-none">Overview</a></li>
                        <li><a href="#" class="text-decoration-none">Recruitment</a></li>
                        <li><a href="#" class="text-decoration-none">Patient Insights</a></li>
                        <li><a href="#" class="text-decoration-none">Pricing</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h5>For Sites</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-decoration-none">Overview</a></li>
                        <li><a href="#" class="text-decoration-none">Pricing</a></li>
                        <li><a href="#" class="text-decoration-none">Trial Site Portal</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h5>Company</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-decoration-none">About HealthMatch</a></li>
                        <li><a href="#" class="text-decoration-none">Careers</a></li>
                        <li><a href="#" class="text-decoration-none">Support</a></li>
                    </ul>
                </div>
            </div>
            
            <div class="row mt-4">
                <div class="col-12">
                    <h5>Contact</h5>
                    <p>Help Centre | General Contact: <a href="mailto:hello@SwasthSarthi.io" class="text-decoration-none">hello@SwasthSarthi.io</a> | Media Contact: <a href="mailto:media@SwasthSarthi.io" class="text-decoration-none">media@SwasthSarthi.io</a></p>
                </div>
            </div>

            <div class="row mt-4">
                <div class="col-12 social-icons">
                    <a href="https://facebook.com" target="_blank"><i class="fab fa-facebook-f"></i></a>
                    <a href="https://twitter.com" target="_blank"><i class="fab fa-twitter"></i></a>
                    <a href="https://instagram.com" target="_blank"><i class="fab fa-instagram"></i></a>
                    <a href="https://linkedin.com" target="_blank"><i class="fab fa-linkedin-in"></i></a>
                    <a href="https://youtube.com" target="_blank"><i class="fab fa-youtube"></i></a>
                    <a href="https://github.com" target="_blank"><i class="fab fa-github"></i></a>
                </div>
            </div>
        </div>
    </footer>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
