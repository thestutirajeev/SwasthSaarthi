<%@ page import="java.util.List" %>
<%@ page import="blog.Blog" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="database.AccessDatabase" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog Cards</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        .card-img-top {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .blog-date {
            color: #aaa;
            font-size: 0.8rem;
        }
        /* Search bar styling */
        .search-container {
            display: flex;
            justify-content: space-between;
            margin: 20px 0;
        }
        .search-bar {
            width: 48%; /* Adjust width of search bars */
        }
    </style>
</head>
<body>
<!-- 
<div class="container">
  <div class="search-container">
      
        <input type="text" id="categorySearch" class="form-control search-bar" placeholder="Search by Category">
        
      
        <input type="text" id="titleSearch" class="form-control search-bar" placeholder="Search by Title">
    </div>
</div>
 -->
 <h3 align="center">My Blogs List</h3>
<div class="container mt-5">
    <div class="row">
        <%
      		//Get HealthWorkerId from session
	        String healthWorkerIdStr = (String) session.getAttribute("healthWorkerId");
	        int healthWorkerId = Integer.parseInt(healthWorkerIdStr); // Convert to int
	         
            // Date format for displaying blog dates
            SimpleDateFormat sdf = new SimpleDateFormat("d-MMM-yyyy");

            // Initialize the AccessDatabase instance and fetch blogs
            AccessDatabase accessDatabase = null;
            List<Blog> blogs = null;
            try {
                // Call the method to fetch blogs from the database
                accessDatabase = AccessDatabase.getInstance();
                blogs = accessDatabase.getMyBlogs(healthWorkerId); // Getting Blogs
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (blogs != null && !blogs.isEmpty()) {
                int imgIndex = 1; // Loop through images (img1.jpg, img2.jpg, etc.)
                for (Blog blog : blogs) {
                    String blogTitle = blog.getBlogTitle();
                    java.sql.Date blogDate = blog.getBlogDate();
                    String formattedDate = sdf.format(blogDate);
                    int blogId = blog.getBlogId();
        %>
                    <div class="col-md-4 mb-4">
                        <div class="card">
                            <!-- Blog Image -->
                            <img src="<%=request.getContextPath()%>/resource/img<%= imgIndex %>.jpg" class="card-img-top" alt="Blog Image">
                            <div class="card-body">
                                <!-- Blog Date -->
                                <p class="card-text text-muted small"><%= formattedDate %></p>
                                <!-- Blog Title -->
                                <h5 class="card-title">
                           			<a href="blog.jsp?blogId=<%= blogId %>&img=<%= request.getContextPath() %>/resource/img<%= imgIndex %>.jpg" class="text-decoration-none">
									    <%= blogTitle %>
									</a>
                                </h5>
                            </div>
                        </div>
                    </div>
        <%
                    imgIndex++;
                    if (imgIndex > 3) { // Reset image index if it exceeds number of available images
                        imgIndex = 1;
                    }
                }
            } else {
        %>
                <div class="col-12">
                    <p>No blogs found.</p>
                </div>
        <%
            }
        %>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>