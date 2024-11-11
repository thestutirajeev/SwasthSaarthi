package resident;
import java.net.URLEncoder;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import database.AccessDatabase;

/**
 * Servlet implementation class residentLoginServlet
 */
public class residentLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("userId"); // Registration ID
        String password = request.getParameter("password"); // Password
        String message = "";
        boolean isAuthenticated = false; // Variable to track if authentication is successful

        AccessDatabase accessDatabase = null;
        try {
            accessDatabase = AccessDatabase.getInstance();
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }

        // Fetch Resident Name - Resident_Name
        String residentName = accessDatabase.getResidentForLogin(userId, password); // Assuming you have this method
        if (residentName != null) {
            // Set session attribute
            HttpSession session = request.getSession();
            session.setAttribute("residentName", residentName); // Store resident name in session
            session.setAttribute("residentId", userId); // Store resident id in session
            isAuthenticated = true;
        } else {
            message = "Invalid Credentials. Please try again.";
        }

     // Redirect based on authentication status
        if (isAuthenticated) {
            response.sendRedirect(request.getContextPath() + "/resident/residentDashboard.jsp"); // Redirect to resident dashboard
        } else {
            response.sendRedirect("resident/residentLogin.jsp?message=" + URLEncoder.encode(message, "UTF-8")); // Redirect with message
        }
    }
}