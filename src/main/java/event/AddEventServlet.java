package event;

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

public class AddEventServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the form parameters from addEvent.jsp
        String eventName = request.getParameter("eventName");
        String eventStartDateStr = request.getParameter("eventStartDate");
        String eventEndDateStr = request.getParameter("eventEndDate");
        String eventStartTime = request.getParameter("eventStartTime");
        String eventEndTime = request.getParameter("eventEndTime");
        String eventDescription = request.getParameter("eventDescription");

        // Get the healthWorkerId from session
        HttpSession session = request.getSession();
        int healthWorkerId =  Integer.parseInt(session.getAttribute("healthWorkerId").toString());

        // Convert the date strings to java.sql.Date objects
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date eventStartDate = null;
        Date eventEndDate = null;
        try {
            eventStartDate = new Date(dateFormat.parse(eventStartDateStr).getTime());
            eventEndDate = new Date(dateFormat.parse(eventEndDateStr).getTime());
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

        // Create an Event object
        Event event = new Event();
        event.setEventName(eventName);
        event.setEventStartDate(eventStartDate);
        event.setEventEndDate(eventEndDate);
        event.setEventStartTime(eventStartTime);
        event.setEventEndTime(eventEndTime);
        event.setHealthId(healthWorkerId);
        event.setVillageName(villageName);
        event.setEventDescription(eventDescription);

        // Insert the event into the database
        boolean eventInserted = false;
        try {
            AccessDatabase db = AccessDatabase.getInstance();
            eventInserted = db.insertEvent(event);
        } catch (Exception e) {
            e.printStackTrace();
        }

        String message = "";
		// Check the result and respond accordingly
        if (eventInserted) {
            message  = "Event Published";
        } else {
        	message = "Can't Add";
        }
        // Redirect back to appointmentList.jsp with the message
        response.sendRedirect("event/workerevent.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
    }
}