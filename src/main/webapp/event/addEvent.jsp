<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get user initials from session
    String userName = (String) session.getAttribute("userName");
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
    <title>Add Event</title>
       <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
 
<style>
   body {
    background-color: #f8f9fa; /* Light background for the whole page */
    font-family: 'Arial', sans-serif; /* Modern sans-serif font */
}

.container {
    background-color: white; /* White background for form container */
    padding: 40px;
    border-radius: 10px; /* Rounded corners */
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* Soft shadow effect */
    margin-top: 50px; /* Space above the container */
}

h2 {
    color: #343a40; /* Dark color for the heading */
    margin-bottom: 30px; /* Space below the heading */
    text-align: center; /* Center align heading */
    font-size: 2rem; /* Larger font size */
}

label {
    font-weight: bold; /* Bold labels */
    color: #495057; /* Darker color for labels */
}

.form-control {
    border: 1px solid #ced4da; /* Light grey border */
    border-radius: 5px; /* Rounded corners */
    transition: border-color 0.3s; /* Smooth transition for border color */
}

.form-control:focus {
    border-color: #007bff; /* Blue border on focus */
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* Shadow effect on focus */
}

.btn-primary {
    background-color: #28a745; /* Green color for primary button */
    border-color: #28a745; /* Matching button border color */
    padding: 10px 20px; /* Padding around the button */
    border-radius: 5px; /* Rounded corners for button */
    font-weight: bold; /* Bold text in button */
    transition: background-color 0.3s, border-color 0.3s; /* Smooth transition for hover effect */
}

.btn-primary:hover {
    background-color: #218838; /* Darker green on hover */
    border-color: #1e7e34; /* Darker border on hover */
}

.alert {
    margin-top: 20px; /* Space above alert messages */
}

.list-group-item {
    background-color: #e9ecef; /* Light grey background for list items */
    border: 1px solid #dee2e6; /* Light border for list items */
    border-radius: 5px; /* Rounded corners for list items */
    margin-bottom: 10px; /* Space below list items */
}

.list-group-item h5 {
    color: #007bff; /* Blue color for event name */
}

.list-group-item p {
    color: #6c757d; /* Grey color for event details */
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


@media (max-width: 576px) {
    .container {
        margin: 20px; /* Less margin on smaller screens */
        padding: 20px; /* Less padding on smaller screens */
    }
}

</style>
</head>
<body>

    
<div class="container mt-5">
    <h2 class="mb-4">Add Event</h2>


    <!-- Form for adding an event -->
    <form action="${pageContext.request.contextPath}/AddEventServlet" method="post" class="form-group">
        <div class="mb-3">
            <label for="eventName">Event Name</label>
            <input type="text" class="form-control" id="eventName" name="eventName" required>
        </div>

        <div class="mb-3">
            <label for="eventStartDate">Event Start Date</label>
            <input type="date" class="form-control" id="eventStartDate" name="eventStartDate" required>
        </div>

        <div class="mb-3">
            <label for="eventStartTime">Event Start Time</label>
            <input type="text" class="form-control" id="eventStartTime" name="eventStartTime" required placeholder="HH:mm">
        </div>

		<div class="mb-3">
            <label for="eventEndDate">Event End Date</label>
            <input type="date" class="form-control" id="eventEndDate" name="eventEndDate" required>
        </div>

        <div class="mb-3">
            <label for="eventEndTime">Event End Time</label>
            <input type="text" class="form-control" id="eventEndTime" name="eventEndTime" required placeholder="HH:mm">
        </div>

        <div class="mb-3">
            <label for="eventDescription">Event Description</label>
            <textarea class="form-control" id="eventDescription" name="eventDescription" rows="3" required></textarea>
        </div>

        <button type="submit" class="btn btn-secondary">Add Event</button>
    </form>

    
 
</div>
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
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>