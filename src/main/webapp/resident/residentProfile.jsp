<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="resident.Resident" %>
<%@ page import="database.AccessDatabase" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resident Profile</title>
    <link rel="stylesheet" href="styles.css">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    
    <style>
        /* Basic Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Arial', sans-serif;
    background-color: #f0f2f5; /* Light background */
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.profile-container {
    background-color: white;
    width: 400px;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* Soft shadow */
    text-align: center;
}

.profile-image{
	justify-content: center;
    align-items: center;
}

.img {
    width: 150px;
    height: 150px;
    border-radius: 50%; /* Circular shape */
    margin-bottom: 20px;
    border: 4px solid #007bff; /* Blue border around the icon */
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: #f0f2f5; /* Background color to simulate an image container */
    overflow: hidden; /* Ensures anything outside the circle is hidden */
}

.img i {
    font-size: 80px; /* Size of the FontAwesome icon */
    color: #007bff; /* Color of the icon */
}

.profile-details {
    color: #333;
}

.profile-details h2 {
    font-size: 1.8rem;
    color: #007bff; /* Blue text for the name */
    margin-bottom: 10px;
}

.profile-details p {
    font-size: 1.1rem;
    margin-bottom: 8px;
    color: #555;
}

.profile-details strong {
    color: #333;
}

.profile-container p {
    font-size: 1rem;
    margin-bottom: 10px;
}

    </style>
</head>
<body>
    <div class="profile-container">
<%
    String residentIdStr = (String) session.getAttribute("residentId");
    int residentId = 0; // Initialize with a default value

    if (residentIdStr != null) {
        try {
            residentId = Integer.parseInt(residentIdStr); // Convert to int
        } catch (NumberFormatException e) {
            e.printStackTrace();
            return; // Return early if parsing fails
        }
    }

    Resident rs = null;
    SimpleDateFormat sdf = new SimpleDateFormat("d-MMM-yyyy"); // Date format for displaying DOB

    try {
        // Get instance of AccessDatabase Singleton class
        AccessDatabase accessDatabase = null;
        try {
            accessDatabase = AccessDatabase.getInstance();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return;
        }

        if (residentId != 0) { // Ensure the ID is valid
            rs = accessDatabase.getResidentById(residentId); // Pass int residentId
        }

        if (rs != null) {
            String name = rs.getName();
            java.sql.Date dob = rs.getDob();
            String villageName = rs.getVillageName();
            String gender = rs.getGender();
            String phone = rs.getPhone();
            String email = rs.getEmail();

            // Formatting DOB
            String formattedDob = sdf.format(dob);
%>

        <!-- Profile Image -->
        <div class="profile-image">
        	<div class="img">
            	<i class="fa-solid fa-user-large" class="img-fluid rounded-circle me-3"></i> 
        	</div>
        </div>

        <!-- User Details -->
        <div class="profile-details">
            <h2><%= name %></h2>
            <p><strong>Date of Birth:</strong> <%= formattedDob %></p>
            <p><strong>Village Name:</strong> <%= villageName %></p>
            <p><strong>Gender:</strong> <%= gender %></p>
            <p><strong>Phone:</strong> <%= phone %></p>
            <p><strong>Email:</strong> <%= email %></p>
        </div>

        <%
                } else {
        %>
                <p>No resident found with the given user ID.</p>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>
</body>
</html>