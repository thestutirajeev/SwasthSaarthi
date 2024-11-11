<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User login Form</title>
    
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
</head>
<body>
	<!-- Flash Message Container -->
    <div class="flash-message" id="flashMessage">
        <%= request.getParameter("message") != null ? request.getParameter("message") : "" %>
    </div>
	
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                
                <h3 class="text-center mb-4">Login Form</h3>
                
                <form action="${pageContext.request.contextPath}/residentLoginServlet" method="post">
                    <!-- User Name -->
                    <div class="mb-3">
                        <label for="userName" class="form-label">User Id</label>
                        <input type="text" class="form-control" id="userId" name="userId" placeholder="Enter your name" required>
                    </div>

                     <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
                    </div>

                    <!-- Submit Button -->
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">Login</button>
                    </div>
                </form>
                
                <div class="mt-3 text-center">
                    <p>Don't have an account? <a href="residentSignup.jsp">Register here</a></p>
                </div>

            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
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