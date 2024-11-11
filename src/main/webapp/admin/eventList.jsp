<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException"%>
<%@ page import="event.Event" %>
<%@ page import="database.AccessDatabase" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Events</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        /* Card container style */
        .card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }

        /* Individual card style */
        .card {
            width: 300px;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            margin: 10px;
            padding: 20px;
            text-align: left;
            background-color: #fff;
        }

        .card h3 {
            margin: 0 0 15px 0;
            font-size: 22px;
            color: #007bff;
        }

        .card p {
            margin: 5px 0;
        }

        .card span {
            font-weight: bold;
        }

        .container {
            margin-top: 50px;
        }

        .heading {
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="heading">List of Events</h2>
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

                    // Retrieve list of events
                    List<Event> eventsList = db.searchEvents(null, null);

                    // Loop through the list and display each event in a card
                    for (Event event : eventsList) {
            %>
                <div class="card">
                    <h3><%= event.getEventName() %></h3>
                    <p><span>Event ID:</span> <%= event.getEventId() %></p>
                    <p><span>Start Date:</span> <%= event.getEventStartDate() %></p>
                    <p><span>End Date:</span> <%= event.getEventEndDate() %></p>
                    <p><span>Start Time:</span> <%= event.getEventStartTime() %></p>
                    <p><span>End Time:</span> <%= event.getEventEndTime() %></p>
                    <p><span>Village:</span> <%= event.getVillageName() %></p>
                    <p><span>Description:</span> <%= event.getEventDescription() %></p>
                </div>
            <%
                    }
                } catch (Exception e) {
                    out.println("Error retrieving events: " + e.getMessage());
                }
            %>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>