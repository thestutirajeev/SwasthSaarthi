<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="resident.Resident" %>
<%@ page import="database.AccessDatabase" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Residents</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        /* Card container styling */
        .card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            margin-top: 30px;
        }
        
        /* Individual card styling */
        .card {
            margin: 15px;
            width: 300px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .card h5 {
            margin-top: 15px;
        }
        
        .card p {
            margin: 5px 0;
        }
    </style>
</head>
<body>

    <div class="container mt-5">
        <h2 class="text-center mb-4">List of Residents</h2>

        <div class="card-container">
            <%
                try {
                    // Get instance of AccessDatabase Singleton class
                    AccessDatabase db = null;
                    try{
                        db = AccessDatabase.getInstance();
                    }catch(ClassNotFoundException | SQLException e){
                        e.printStackTrace();
                        return;
                    }
                    
                    // Retrieve list of residents
                    List<Resident> residentsList = db.searchResidents(null, null, null, null);
                    
                    // Loop through the list and display each resident in a card
                    for (Resident resident : residentsList) {
            %>
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title"><%= resident.getName() %></h5>
                            <p class="card-text"><strong>User ID:</strong> <%= resident.getUserId() %></p>
                            <p class="card-text"><strong>Date of Birth:</strong> <%= resident.getDob() %></p>
                            <p class="card-text"><strong>Village:</strong> <%= resident.getVillageName() %></p>
                            <p class="card-text"><strong>Gender:</strong> <%= resident.getGender() %></p>
                            <p class="card-text"><strong>Phone:</strong> <%= resident.getPhone() %></p>
                            <p class="card-text"><strong>Email:</strong> <%= resident.getEmail() %></p>
                        </div>
                    </div>
            <%
                    }
                } catch (Exception e) {
                    out.println("Error retrieving residents: " + e.getMessage());
                }
            %>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>