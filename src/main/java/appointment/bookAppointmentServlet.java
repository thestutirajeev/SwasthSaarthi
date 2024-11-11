package appointment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import database.AccessDatabase;

/**
 * Servlet implementation class bookAppointmentServlet
 */
public class bookAppointmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get appointment details from request parameters
		HttpSession session = request.getSession(false);
        int healthId = Integer.parseInt(request.getParameter("doctor"));
        int userId = Integer.parseInt((String)session.getAttribute("residentId"));
        java.sql.Date appointmentDate = java.sql.Date.valueOf(java.time.LocalDate.now().plusDays(7));
        String status = "Confirmed";
        
        // Convert appointmentDate to String in DD-MM-YYYY format
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
        String appointmentDateString = sdf.format(appointmentDate);

        // Create an Appointment object
        Appointment appointment = new Appointment();
        appointment.setHealthId(healthId);
        appointment.setUserId(userId);
        appointment.setAppointmentDate(appointmentDate);
        appointment.setStatus(status);

        // Get an instance of AccessDatabase
        AccessDatabase accessDatabase = null;
		try {
			accessDatabase = AccessDatabase.getInstance();
		} catch (ClassNotFoundException |SQLException e) {
			e.printStackTrace();
		}        
        // Call insertAppointment method to save the appointment
        boolean isInserted = accessDatabase.insertAppointment(appointment);

        String message = "";
		// Check the result and respond accordingly
        if (isInserted) {
            message  = "Appointment Booked for "+appointmentDateString;
        } else {
        	message = "Can't Book";
        }
        // Redirect back to appointmentList.jsp with the message
        response.sendRedirect("appointment/appointmentList.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
    }

}
