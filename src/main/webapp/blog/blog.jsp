<%@page import="blog.Blog" %>
<%@page import="database.AccessDatabase" %>
<%@page import="java.sql.Date" %>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <%
                    // Get blogId and img parameters from the URL
                    String blogIdParam = request.getParameter("blogId");
                    String img = request.getParameter("img");

                    // Initialize AccessDatabase and Blog object
                    AccessDatabase accessDatabase = null;
                    Blog blog = null;

                    try {
                        if (blogIdParam != null && !blogIdParam.isEmpty()) {
                            int blogId = Integer.parseInt(blogIdParam);

                            // Fetch blog from the database using AccessDatabase class
                            try{
                                accessDatabase = AccessDatabase.getInstance();
                            }catch(Exception e){
                                e.printStackTrace();
                                return;
                            }
                            blog = accessDatabase.getBlogById(blogId);  // Assuming the method getBlogById exists

                            if (blog != null) {
                                // Fetch the actual name of the health worker using the blogId
                                String healthWorkerName = accessDatabase.getHealthWorkerNameByBlogId(blogId);
                %>
                                <!-- Blog Title -->
                                <h1 class="mb-3"><%= blog.getBlogTitle() %></h1>

                                <!-- Blog Date and Writer -->
                                <p class="text-muted">
                                    📅 <%= blog.getBlogDate() %> | Written by <strong><%= healthWorkerName != null ? healthWorkerName : "Unknown" %></strong>
                                </p>

                                <!-- Blog Image -->
                                <img src="<%= img %>" class="img-fluid mb-4" alt="Blog Image">

                                <!-- Blog Description -->
                                <p class="lead">
                                    <%= blog.getBlogDescription() %>
                                </p>
                <%
                            } else {
                                out.println("<p>No blog found with the given ID.</p>");
                            }
                        } else {
                            out.println("<p>Invalid Blog ID.</p>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>