<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException"%>
<%@ page import="healthworker.HealthWorker" %>
<%@ page import="database.AccessDatabase" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Health Workers</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <style>
        /* Container for the cards */
        .card-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            margin-top: 40px;
        }

        /* Individual card styling */
        .card {
            width: 300px;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: left;
        }

        .card h3 {
            margin-bottom: 15px;
        }

        .card p {
            margin: 5px 0;
        }

        /* Add Health Worker Button */
        .add-button {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 50%;
            width: 60px;
            height: 60px;
            text-align: center;
            font-size: 24px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s;
            cursor: pointer;
        }

        .add-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

    <!-- Page Title -->
    <div class="container mt-5">
        <h2 class="text-center">List of Health Workers</h2>
    </div>

    <!-- Health Workers Cards -->
    <div class="container card-container">
        <%
            try {
                // Get instance of AccessDatabase Singleton class
                AccessDatabase db = null;
                try {
                    db = AccessDatabase.getInstance();
                } catch (ClassNotFoundException | SQLException e) {
                    e.printStackTrace();
                    return;
                }

                // Retrieve list of health workers
                List<HealthWorker> healthWorkerList = db.searchHealthWorkers(null, null, null, null);

                // Loop through the list and display each health worker in a card
                for (HealthWorker worker : healthWorkerList) {
        %>
                    <div class="card">
                        <h3><%= worker.getName() %></h3>
                        <p><strong>Health ID:</strong> <%= worker.getHealthId() %></p>
                        <p><strong>Gender:</strong> <%= worker.getGender() %></p>
                        <p><strong>Age:</strong> <%= worker.getAge() %></p>
                        <p><strong>Specialization:</strong> <%= worker.getSpecialisation() %></p>
                        <p><strong>Village:</strong> <%= worker.getVillageName() %></p>
                        <p><strong>Slot:</strong> <%= worker.getSlot() %></p>
                        <p><strong>Day:</strong> <%= worker.getDay() %></p>
                    </div>
        <%
                }
            } catch (Exception e) {
                out.println("Error retrieving health workers: " + e.getMessage());
            }
        %>
    </div>

    <!-- Add Health Worker Button -->
    <a href="addHealthWorker.jsp" class="add-button" title="Add Health Worker">
        <i class="fas fa-plus"></i>
    </a>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>