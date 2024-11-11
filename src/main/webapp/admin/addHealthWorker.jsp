<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Health Worker</title>
    <!-- Bootstrap CDN for styling -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h3 class="text-center mb-4">Add New Health Worker</h3>
                
                <form action="processAddHealthWorker.java" method="post">
                    <!-- Name Input -->
                    <div class="mb-3">
                        <label for="name" class="form-label">Name</label>
                        <input type="text" class="form-control" id="name" name="name" placeholder="Enter name" required>
                    </div>

                    <!-- Gender Dropdown -->
                    <div class="mb-3">
                        <label for="gender" class="form-label">Gender</label>
                        <select class="form-control" id="gender" name="gender" required>
                            <option value="" disabled selected>Select Gender</option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>

                    <!-- Age Input -->
                    <div class="mb-3">
                        <label for="age" class="form-label">Age</label>
                        <input type="number" class="form-control" id="age" name="age" placeholder="Enter age" required>
                    </div>

                    <!-- Specialisation Dropdown -->
                    <div class="mb-3">
                        <label for="specialisation" class="form-label">Specialisation</label>
                        <select class="form-control" id="specialisation" name="specialisation" required>
                            <option value="" disabled selected>Select Specialisation</option>
                            <option value="Community Health Worker">Community Health Worker</option>
                            <option value="Nutritionist">Nutritionist</option>
                            <option value="Mental Health Worker">Mental Health Worker</option>
                            <option value="Child Health Specialist">Child Health Specialist</option>
                        </select>
                    </div>

                    <!-- Village Input -->
                    <div class="mb-3">
                        <label for="villageName" class="form-label">Village</label>
                        <input type="text" class="form-control" id="villageName" name="villageName" placeholder="Enter village" required>
                    </div>

                    <!-- Slot Input -->
                    <div class="mb-3">
                        <label for="slot" class="form-label">Slot</label>
                        <input type="text" class="form-control" id="slot" name="slot" placeholder="Enter slot" required>
                    </div>

                    <!-- Day Input -->
                    <div class="mb-3">
                        <label for="day" class="form-label">Day</label>
                        <input type="text" class="form-control" id="day" name="day" placeholder="Enter day" required>
                    </div>

                    <!-- Submit Button -->
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">Add Health Worker</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS for responsive behavior -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>