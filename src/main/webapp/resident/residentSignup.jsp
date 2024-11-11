<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="database.AccessDatabase" %>
<%@ page import="java.sql.*" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h3 class="text-center mb-4">Registration Form</h3>

                <form action="${pageContext.request.contextPath}/residentSignupServlet" method="post">
                    <!-- User Name -->
                    <div class="mb-3">
                        <label for="name" class="form-label">Name</label>
                        <input type="text" class="form-control" id="name" name="name" placeholder="Enter your name" required>
                    </div>

                    <!-- District Dropdown -->
                    <div class="mb-3">
                        <label for="district" class="form-label">District</label>
                        <select class="form-control" id="district" name="district" onchange="populateVillages(this.value)" required>
                            <option value="" disabled selected>Select your district</option>
                            <%
                                AccessDatabase accessDatabase = null;
                                List<String> districts = new ArrayList<>();
                                try {
                                    accessDatabase = AccessDatabase.getInstance();
                                    districts = accessDatabase.getAllDistricts(); // Fetch districts
                                    for (String district : districts) {
                            %>
                                <option value="<%= district %>"><%= district %></option>
                            <%
                                    }
                                } catch (ClassNotFoundException | SQLException e) {
                                    e.printStackTrace();
                                }
                            %>
                        </select>
                    </div>

                    <!-- Village Dropdown -->
                    <div class="mb-3">
                        <label for="villageName" class="form-label">Village</label>
                        <select class="form-control" id="villageName" name="villageName" required>
                            <option value="" disabled selected>Select your village</option>
                            <%
                                // Logic to fetch villages based on the first district selected
                                if (!districts.isEmpty()) {
                                    String firstDistrict = districts.get(0); // Get the first district
                                    List<String> villages = accessDatabase.getVillagesByDistrict(firstDistrict); // Fetch villages

                                    for (String village : villages) {
                            %>
                                <option value="<%= village %>"><%= village %></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <!-- Other Fields -->
                    <div class="mb-3">
                        <label for="dob" class="form-label">Date of Birth</label>
                        <input type="date" class="form-control" id="dob" name="dob" required>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                    </div>

                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
                    </div>

                    <div class="mb-3">
                        <label for="cpassword" class="form-label">Confirm Password</label>
                        <input type="password" class="form-control" id="cpassword" name="cpassword" placeholder="Confirm your password" required>
                    </div>

                    <div class="mb-3">
                        <label for="mobile" class="form-label">Mobile Number</label>
                        <input type="tel" class="form-control" id="mobile" name="mobile" placeholder="Enter your mobile number" required>
                    </div>

                    <!-- Submit Button -->
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">Register</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function populateVillages(districtName) {
            const villageSelect = document.getElementById("villageName");
            villageSelect.innerHTML = ""; // Clear existing options
            villageSelect.innerHTML += '<option value="" disabled selected>Select your village</option>'; // Add default option
            
            // Create a JSON object for all villages based on selected district
            <% 
                // Assuming we already have a method that gives us a mapping of district to villages
                for (String district : districts) {
                    List<String> villages = accessDatabase.getVillagesByDistrict(district);
                    StringBuilder villageOptions = new StringBuilder();
                    for (String village : villages) {
                        villageOptions.append("<option value='").append(village).append("'>").append(village).append("</option>");
                    }
            %>
            if (districtName === "<%= district %>") {
                villageSelect.innerHTML += "<%= villageOptions.toString() %>";
            }
            <% } %>
        }
    </script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
