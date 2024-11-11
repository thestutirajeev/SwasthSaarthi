package blog;

import database.AccessDatabase;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class WriteBlogServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the form parameters from writeBlog.jsp
        String blogTitle = request.getParameter("blogTitle");
        String blogDescription = request.getParameter("blogDescription");
        String blogDateStr = request.getParameter("blogDate");
        String category = request.getParameter("category");

        // Get the healthWorkerId from session
        HttpSession session = request.getSession();
        int healthWorkerId = Integer.parseInt((String)session.getAttribute("healthWorkerId"));

        // Convert the blog date string to java.sql.Date object
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date blogDate = null;
        try {
            blogDate = new Date(dateFormat.parse(blogDateStr).getTime());
        } catch (ParseException e) {
            e.printStackTrace();
        }

        // Get the village name from the AccessDatabase using healthWorkerId
        String villageName = null;
        try {
            AccessDatabase db = AccessDatabase.getInstance();
            villageName = db.getVillageNameByHealthWorkerId(healthWorkerId);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Create a Blog object
        Blog blog = new Blog();
        blog.setBlogTitle(blogTitle);
        blog.setBlogDescription(blogDescription);
        blog.setBlogDate(blogDate);
        blog.setHealthId(healthWorkerId);
        blog.setCategory(category);

        // Insert the blog into the database
        boolean blogInserted = false;
        try {
            AccessDatabase db = AccessDatabase.getInstance();
            blogInserted = db.insertBlog(blog);
        } catch (Exception e) {
            e.printStackTrace();
        }
        String message = "";
		// Check the result and respond accordingly
        if (blogInserted) {
            message  = "Blog added successfully";
        } else {
        	message = "Can't Add";
        }
        // Redirect back to healthworkerdashboard.jsp with the message
        response.sendRedirect("healthworker/healthWorkerDashboard.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
    }
}