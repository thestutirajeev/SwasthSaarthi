package healthworker;
import java.net.URLEncoder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import database.AccessDatabase;

/**
 * Servlet implementation class healthWorkerServlet
 */
public class healthWorkerLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String healthId = request.getParameter("healthId"); // Health Worker ID
        String password = request.getParameter("password"); // Password
     
        String message = "";
        boolean isAuthenticated = false; // Variable to track if authentication is successful


        // Admin login (hardcoded id-pass)
        if(healthId.equals("!@#$%^&*") && password.equals("*&^%$#@!")) {
            // Admin authenticated
            HttpSession session = request.getSession();
            session.setAttribute("admin", true); // Set admin session attribute
            response.sendRedirect(request.getContextPath() + "/admin/adminDashboard.jsp"); // Redirect to admin dashboard
            return; // Exit after admin authentication
        }
        
        AccessDatabase accessDatabase = null;
        try {
            accessDatabase = AccessDatabase.getInstance();
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }

        // Fetch Health Worker Name - Health_Worker_Name
        String healthWorkerName = accessDatabase.getHealthWorkerForLogin(healthId, password); // Assuming you have this method
        if (healthWorkerName != null) {
            // Set session attribute
            HttpSession session = request.getSession();
            session.setAttribute("healthWorkerId", healthId);
            session.setAttribute("healthWorkerName", healthWorkerName); // Store health worker name in session
            isAuthenticated = true;
        } else {
            message = "Invalid Credentials. Please try again.";
        }

        // Redirect based on authentication status
        if (isAuthenticated) {
            response.sendRedirect(request.getContextPath() + "/healthworker/healthWorkerDashboard.jsp"); // Redirect to health worker dashboard
        } else {
            response.sendRedirect("healthworker/healthWorkerLogin.jsp?message=" + URLEncoder.encode(message, "UTF-8")); // Redirect with message
        }
    }
}
