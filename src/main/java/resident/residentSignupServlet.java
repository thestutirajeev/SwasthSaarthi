package resident;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import database.AccessDatabase;

/**
 * Servlet implementation class ResidentSignupServlet
 */
public class residentSignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Create a new Resident object
        Resident resident = new Resident();

        // Set the requested values to the resident object
        resident.setName(request.getParameter("name"));
        resident.setVillageName(request.getParameter("villageName"));
        resident.setGender(request.getParameter("gender"));
        resident.setPhone(request.getParameter("phone"));
        resident.setEmail(request.getParameter("email"));
        resident.setPassword(request.getParameter("password"));

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // Format for parsing date
        java.util.Date utilDate = null;

        // Parse the date of birth from the request
        try {
            utilDate = sdf.parse(request.getParameter("dob"));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        
        java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());  // Convert util.Date to sql.Date
        resident.setDob(sqlDate);  // Set the parsed date

        String message = "";
        AccessDatabase accessDatabase = null;

        try {
            accessDatabase = AccessDatabase.getInstance();  // Get the AccessDatabase instance
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return;
        }

        // Call insertResident method to insert the resident data
        Integer inserted = accessDatabase.insertResident(resident);

        // Handle the response based on insertion result
        if (inserted != -1) {
            message = inserted.toString();
        } else {
            message = "Registration failed. Please try again.";
        }

        // Redirect back to home.jsp with the message
        response.sendRedirect("resident/residentLogin.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
    }
}
