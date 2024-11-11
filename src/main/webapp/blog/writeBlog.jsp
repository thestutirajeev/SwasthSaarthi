<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Blog</title>
    <!-- Bootstrap CDN for styling -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h3 class="text-center mb-4"><b>Add New Blog</b></h3>
                
                <form action="${pageContext.request.contextPath}/WriteBlogServlet" method="post">
                    <!-- Blog Title Input -->
                    <div class="mb-3">
                        <label for="blogTitle" class="form-label"><b>Blog Title</b></label>
                        <input type="text" class="form-control" id="blogTitle" name="blogTitle" placeholder="Enter blog title" required>
                    </div>

                    <!-- Blog Description Textarea -->
                    <div class="mb-3">
                        <label for="blogDescription" class="form-label"><b>Blog Description</b></label>
                        <textarea class="form-control" id="blogDescription" name="blogDescription" rows="5" placeholder="Enter blog description" required></textarea>
                    </div>

                    <!-- Blog Date Input -->
                    <div class="mb-3">
                        <label for="blogDate" class="form-label"><b>Blog Date</b></label>
                        <input type="date" class="form-control" id="blogDate" name="blogDate" required>
                    </div>


                    <!-- Category Dropdown -->
                    <div class="mb-3">
                        <label for="category" class="form-label"><b>Category</b></label>
                        <select class="form-control" id="category" name="category" required>
                            <option value="" disabled selected>Select Category</option>
                            <option value="Nutrition">Nutrition</option>
                            <option value="Mental Health">Mental Health</option>
                            <option value="Child Health">Child Health</option>
                            <option value="Community Health">Community Health</option>
                        </select>
                    </div>

                    <!-- Submit Button -->
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">Add Blog</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS for responsive behavior -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>