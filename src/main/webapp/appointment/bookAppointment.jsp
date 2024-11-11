<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="healthworker.HealthWorker" %>
<%@ page import="database.AccessDatabase" %>

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
    AccessDatabase accessDatabase = AccessDatabase.getInstance();
 // Get all specializations
    List<String> specializations = accessDatabase.getAllSpecializations(); // Method to fetch all specializations

    // Fetch health workers from JSP scriptlet
    for (String specialization : specializations) {
        List<HealthWorker> healthWorkers = accessDatabase.getHealthWorkersBySpecialization(specialization); // Fetch workers based on specialization
        StringBuilder doctorOptions = new StringBuilder();
        for (HealthWorker worker : healthWorkers) {
            doctorOptions.append("<option value='").append(worker.getHealthId()).append("'>")
                         .append(worker.getName()).append("</option>");
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Appointment</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"> 
    
</head>
<style>
    body {
    font-family: Arial, sans-serif; /* Set a clean font style */
    background-color: #f8f9fa; /* Light background color for the body */
}

.container {
    margin-top: 30px; /* Space above the container */
    background-color: #ffffff; /* White background for the form */
    padding: 20px; /* Padding inside the container */
    border-radius: 8px; /* Rounded corners for the container */
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Light shadow for depth */
}

h1 {
    color: #007bff; /* Primary color for the heading */
    margin-bottom: 20px; /* Space below the heading */
}

.form-group {
    margin-bottom: 20px; /* Space below each form group */
}

label {
    font-weight: bold; /* Bold labels */
    color: #333; /* Dark color for labels */
}

input[type="text"],
input[type="number"],
select,
textarea {
    border: 1px solid #ced4da; /* Light border color for inputs */
    border-radius: 4px; /* Rounded corners for inputs */
    transition: border-color 0.2s; /* Transition effect for border color */
}

input[type="text"]:focus,
input[type="number"]:focus,
select:focus,
textarea:focus {
    border-color: #007bff; /* Change border color on focus */
    outline: none; /* Remove default outline */
}

button {
    background-color: #007bff; /* Primary color for buttons */
    color: white; /* White text color for buttons */
    border: none; /* Remove border */
    border-radius: 4px; /* Rounded corners for buttons */
    padding: 10px 15px; /* Padding inside the button */
    font-size: 16px; /* Font size for the button text */
    cursor: pointer; /* Pointer cursor on hover */
    transition: background-color 0.2s; /* Transition effect for button */
}

button:hover {
    background-color: #0056b3; /* Darker shade on hover */
}

.alert {
    margin-top: 20px; /* Space above alerts */
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
<body>
<nav class="navbar navbar-expand-lg bg-body-secondary">
    <div class="container-fluid">
        <a class="navbar-brand d-flex align-items-center" href="#">
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
                <li><a class="dropdown-item" href="">Log Out</a></li>
            </ul>
        </div>
    </div>
</nav>

    <div class="container"> 
        <header class="my-4 text-center">
            <h1>Book Your Appointment</h1>
        </header>

        <form action="${pageContext.request.contextPath}/bookAppointmentServlet" method="post" class="form-group">
            <div class="form-row">
                <!-- Specialization Dropdown -->
                <div class="col-md-6 mb-3">
                    <label for="specialization">Select Specialization</label>
                    <select class="form-control" id="specialization" name="specialization" onchange="fetchHealthWorkers(this.value)" required>
                        <option value="" disabled selected>Select your specialization</option>
                        <% 
                            // Populate specialization options from the database
                            for (String specialization : specializations) {
                        %>
                        <option value="<%= specialization %>"><%= specialization %></option>
                        <% } %>
                    </select>
                </div>

                <!-- Health Worker Dropdown -->
                <div class="col-md-6 mb-3">
                    <label for="doctor">Select Doctor</label>
                    <select class="form-control" id="doctor" name="doctor" required>
                        <option value="" disabled selected>Select a doctor</option>
                    </select>
                </div>
            </div>
            
            <!-- Other form fields like appointment date, symptoms, etc. -->

            <button type="submit" class="btn btn-primary">Book Appointment</button>
        </form>
    </div>

    <script>
    
 // Function to fetch health workers for the selected specialization
    function fetchHealthWorkers(specialization) {
        const doctorSelect = document.getElementById("doctor");
        doctorSelect.innerHTML = ""; // Clear existing options
        doctorSelect.innerHTML += '<option value="" disabled selected>Select a doctor</option>'; // Add default option

        // Fetch health workers from JSP scriptlet
        <% 
            for (String specialization : specializations) {
                List<HealthWorker> healthWorkers = accessDatabase.getHealthWorkersBySpecialization(specialization); // Fetch workers based on specialization
                StringBuilder doctorOptions = new StringBuilder();
                for (HealthWorker worker : healthWorkers) {
                    doctorOptions.append("<option value='").append(worker.getHealthId()).append("'>")
                                 .append(worker.getName()).append("</option>");
                }
        %>
        if (specialization === "<%= specialization %>") {
            doctorSelect.innerHTML += "<%= doctorOptions.toString() %>";
        }
        <% } %>
    }    </script>
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
    $(function() {
        $("#appointmentDate").datepicker({
            dateFormat: "yy-mm-dd",
            minDate: 0 // Disable past dates
        });
    });
</script>

</body>
</html>
