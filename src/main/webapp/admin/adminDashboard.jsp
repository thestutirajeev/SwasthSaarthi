<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    
    <!-- Bootstrap CSS for styling -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    
    <style>
        /* Styling for the page */
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f9fc;
        }

        /* Logout button styling */
        .logout-button {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .logout-button:hover {
            background-color: #c82333;
        }

        /* Flex container for the icons */
        .icon-container {
            display: flex;
            justify-content: space-around;
            align-items: center;
            margin-top: 100px; /* Adjust for top margin */
            padding: 20px;
        }

        .icon-box {
            text-align: center;
            padding: 30px;
            width: 150px;  /* Set a fixed width */
            height: 150px; /* Set a fixed height */
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            cursor: pointer;
            display: flex;  /* Use flex to center content */
            flex-direction: column;  /* Align items in a column */
            justify-content: center; /* Center vertically */
            align-items: center;  /* Center horizontally */
        }

        .icon-box i {
            font-size: 50px;
            color: #007BFF;
            transition: color 0.3s;
        }

        .icon-label {
            margin-top: 15px;
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }

        /* Hover effects */
        .icon-box:hover {
            transform: translateY(-10px);
            box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.2);
        }

        .icon-box:hover i {
            color: #0056b3;
        }

        /* Additional styling for responsiveness */
        @media (max-width: 768px) {
            .icon-container {
                flex-direction: column;
            }
            .icon-box {
                margin-bottom: 30px;
                width: 100%; /* Make it full-width on smaller screens */
            }
        }
    </style>
</head>
<body>
    <!-- Logout Button -->
    <button class="logout-button" onclick="location.href='${pageContext.request.contextPath}/home.jsp'">Logout</button>
    
    <!-- Icon container section -->
    <div class="container mt-5">
        <div class="icon-container">
            <!-- User Icon -->
            <div class="icon-box" onclick="location.href='residentList.jsp'">
                <i class="fas fa-user"></i>
                <div class="icon-label">Users</div>
            </div>

            <!-- Health Worker Icon -->
            <div class="icon-box" onclick="location.href='healthWorkerList.jsp'">
                <i class="fas fa-user-md"></i>
                <div class="icon-label">Health Workers</div>
            </div>

            <!-- Event Icon -->
            <div class="icon-box" onclick="location.href='eventList.jsp'">
                <i class="fas fa-calendar-alt"></i>
                <div class="icon-label">Events</div>
            </div>

            <!-- Blog Icon -->
            <div class="icon-box" onclick="location.href='${pageContext.request.contextPath}/blog/blogList.jsp'">
                <i class="fas fa-blog"></i>
                <div class="icon-label">Blogs</div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS for functionality -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>