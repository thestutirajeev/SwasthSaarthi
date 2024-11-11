package database;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import appointment.Appointment;
import blog.Blog;
import event.Event;
import healthworker.HealthWorker;
import resident.Resident;
public class AccessDatabase {
    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:xe";
    private static final String DB_USER = "system";
    private static final String DB_PASSWORD = "admin";

    // Singleton instance
    private static AccessDatabase instance = null;
    private Connection connection;

    // Private constructor to prevent instantiation from outside
    private AccessDatabase() throws ClassNotFoundException, SQLException {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        connection = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
    }

    // Public static method to get the single instance
    public static AccessDatabase getInstance() throws ClassNotFoundException, SQLException {
        if (instance == null) {
            synchronized (AccessDatabase.class) {
                if (instance == null) {
                    instance = new AccessDatabase();
                }
            }
        }
        return instance;
    }
    //fetch village by worker
    public String getVillageNameByHealthWorkerId(int healthWorkerId) throws SQLException {
        String sql = "SELECT villageName FROM HealthWorker WHERE healthId = ?";
        String villageName = null;

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, healthWorkerId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                villageName = rs.getString("villageName");
            }
        }
        return villageName;
    }
    
    // Insert the new appointment
    public boolean insertAppointment(Appointment appointment) {
        String idSql = "SELECT MAX(appointmentId) FROM Appointment"; // SQL to get the next appointmentId
        String sql = "INSERT INTO Appointment (appointmentId, healthId, userId, appointmentDate, status) VALUES (?, ?, ?, ?, ?)"; // SQL to insert a new appointment
        int nextId = 1; // Default value for nextId

        // Get the next appointmentId
        try (PreparedStatement idPstmt = connection.prepareStatement(idSql);
             ResultSet rs = idPstmt.executeQuery()) {
            if (rs.next()) {
                // If there's an existing appointmentId, increment it by 1
                nextId = rs.getInt(1) + 1; // Increment the max id by 1
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, nextId);
            pstmt.setInt(2, appointment.getHealthId());
            pstmt.setInt(3, appointment.getUserId());
            pstmt.setDate(4, appointment.getAppointmentDate());
            pstmt.setString(5, appointment.getStatus());

            int rows = pstmt.executeUpdate();
            return rows > 0; // Return true if the appointment was successfully added
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Return false if there was an error
    }

    // Method to get blogs for a specific HealthWorker by their healthId
    public List<Blog> getMyBlogs(int healthWorkerId) {
        List<Blog> blogList = new ArrayList<>();

        // SQL query to fetch blogs for the specific health worker
        String sql = "SELECT * FROM Blog WHERE healthId = ? ORDER BY blogDate DESC";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            // Set the healthWorkerId in the query
            pstmt.setInt(1, healthWorkerId);

            ResultSet rs = pstmt.executeQuery();
            
            // Loop through the result set and create Blog objects
            while (rs.next()) {
                Blog blog = new Blog();
                blog.setBlogId(rs.getInt("blogId"));
                blog.setBlogTitle(rs.getString("blogTitle"));
                blog.setBlogDescription(rs.getString("blogDescription"));
                blog.setBlogDate(rs.getDate("blogDate"));
                blog.setHealthId(rs.getInt("healthId"));
                blog.setCategory(rs.getString("category"));

                // Add each blog to the list
                blogList.add(blog);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        // Return the list of blogs for the health worker
        return blogList;
    }

    
	// Method to get events for a specific HealthWorker by their healthId
	public List<Event> getMyEvents(int healthWorkerId) {
	    List<Event> eventList = new ArrayList<>();

	    // SQL query to fetch events for the specific health worker
	    String sql = "SELECT * FROM Event WHERE healthId = ? ORDER BY eventStartDate ASC, eventStartTime ASC";
	    
	    try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
	        // Set the healthWorkerId in the query
	        pstmt.setInt(1, healthWorkerId);

	        ResultSet rs = pstmt.executeQuery();
	        
	        // Loop through the result set and create Event objects
	        while (rs.next()) {
	            Event event = new Event();
	            event.setEventId(rs.getInt("eventId"));
	            event.setEventName(rs.getString("eventName"));
	            event.setEventStartDate(rs.getDate("eventStartDate"));
	            event.setEventEndDate(rs.getDate("eventEndDate"));
	            event.setEventStartTime(rs.getString("eventStartTime"));
	            event.setEventEndTime(rs.getString("eventEndTime"));
	            event.setHealthId(rs.getInt("healthId"));
	            event.setVillageName(rs.getString("villageName"));
	            event.setEventDescription(rs.getString("eventDescription"));

	            // Add each event to the list
	            eventList.add(event);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    
	    // Return the list of events for the health worker
	    return eventList;
	}    
    // Method to get appointments for a specific HealthWorker by their healthId
    public List<Appointment> getMyAppointments(int healthWorkerId) {
        List<Appointment> appointmentList = new ArrayList<>();

        // SQL query to fetch appointments for the specific health worker
        String sql = "SELECT * FROM Appointment WHERE healthId = ? ORDER BY appointmentDate ASC";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            // Set the healthWorkerId in the query
            pstmt.setInt(1, healthWorkerId);

            ResultSet rs = pstmt.executeQuery();
            
            // Loop through the result set and create Appointment objects
            while (rs.next()) {
                Appointment appointment = new Appointment();
                appointment.setAppointmentId(rs.getInt("appointmentId"));
                appointment.setHealthId(rs.getInt("healthId"));
                appointment.setUserId(rs.getInt("userId"));
                appointment.setAppointmentDate(rs.getDate("appointmentDate"));
                appointment.setStatus(rs.getString("status"));

                // Add each appointment to the list
                appointmentList.add(appointment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        // Return the list of appointments for the health worker
        return appointmentList;
    }

    // Method to get all specializations
    public List<String> getAllSpecializations() {
        List<String> specializations = new ArrayList<>();
        String query = "SELECT DISTINCT SPECIALIZATION FROM Specialization"; // Use correct table and column names

        try (PreparedStatement pstmt = connection.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                specializations.add(rs.getString("SPECIALIZATION")); // Use the correct column name
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return specializations;
    }

 // Method to get health workers by specialization
    public List<HealthWorker> getHealthWorkersBySpecialization(String specialization) {
        List<HealthWorker> healthWorkers = new ArrayList<>();
        String query = "SELECT * FROM HealthWorker WHERE specialisation = ?"; // Adjust based on your schema

        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setString(1, specialization);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                HealthWorker worker = new HealthWorker();
                worker.setHealthId(rs.getInt("healthId")); // Adjust this based on your column names
                worker.setName(rs.getString("name"));
                worker.setGender(rs.getString("gender"));
                // Set other properties as needed
                healthWorkers.add(worker);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return healthWorkers;
    }
    
    //fetch and search Event
    public List<Event> searchEvents(String villageName, String eventName) {
        List<Event> eventList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Event WHERE 1=1"); // Always true condition

        // Add conditions based on inputs
        boolean hasVillageName = villageName != null && !villageName.isEmpty();
        boolean hasEventName = eventName != null && !eventName.isEmpty();

        if (hasVillageName) {
            sql.append(" AND villageName LIKE ?");
        }
        if (hasEventName) {
            sql.append(" AND eventName LIKE ?");
        }

        // If both are false, return all events by not adding any conditions
        try (PreparedStatement pstmt = connection.prepareStatement(sql.toString())) {
            int index = 1;

            // Set parameters based on provided conditions
            if (hasVillageName) {
                pstmt.setString(index++, "%" + villageName + "%"); // Use LIKE for villageName search
            }
            if (hasEventName) {
                pstmt.setString(index++, "%" + eventName + "%"); // Use LIKE for eventName search
            }

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Event event = new Event();
                event.setEventId(rs.getInt("eventId"));
                event.setEventName(rs.getString("eventName"));
                event.setEventStartDate(rs.getDate("eventStartDate"));
                event.setEventEndDate(rs.getDate("eventEndDate"));
                event.setEventStartTime(rs.getString("eventStartTime"));
                event.setEventEndTime(rs.getString("eventEndTime"));
                event.setHealthId(rs.getInt("healthId"));
                event.setVillageName(rs.getString("villageName"));
                event.setEventDescription(rs.getString("eventDescription"));
                eventList.add(event);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return eventList; // Return the list of found events
    }
    //District
    public List<String> getAllDistricts() {
        List<String> districts = new ArrayList<>();
        String sql = "SELECT districtName FROM District";

        try (PreparedStatement pstmt = connection.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                districts.add(rs.getString("districtName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return districts;
    }
    
    //Village by District
    public List<String> getVillagesByDistrict(String districtName) {
        List<String> villages = new ArrayList<>();
        String sql = "SELECT villageName FROM Village WHERE districtId = (SELECT districtId FROM District WHERE districtName = ?)";

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, districtName);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    villages.add(rs.getString("villageName"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return villages;
    }
    
    // Event Post
    public boolean insertEvent(Event event) {
        String sql = "INSERT INTO Event (eventId, eventName, eventStartDate, eventEndDate, eventStartTime, eventEndTime, healthId, villageName, eventDescription) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String idSql = "SELECT MAX(eventId) FROM Event"; // Query to get the max eventId
        int nextId = 100; // Start from 100 if no entries exist

        // Get the next eventId
        try (PreparedStatement idPstmt = connection.prepareStatement(idSql);
             ResultSet rs = idPstmt.executeQuery()) {
            if (rs.next()) {
                // If there's an existing eventId, increment it by 1
                nextId = rs.getInt(1) + 1; // Increment the max id by 1
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, nextId);
            pstmt.setString(2, event.getEventName());
            pstmt.setDate(3, event.getEventStartDate());
            pstmt.setDate(4, event.getEventEndDate());
            pstmt.setString(5, event.getEventStartTime());
            pstmt.setString(6, event.getEventEndTime());
            pstmt.setInt(7, event.getHealthId());
            pstmt.setString(8, event.getVillageName());
            pstmt.setString(9, event.getEventDescription());

            int rows = pstmt.executeUpdate();
            return rows > 0; // Return true if the event was successfully added
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // Return false if there was an error
    }

    public Blog getBlogById(int blogId) {
        Blog blog = null;
        String sql = "SELECT * FROM Blog WHERE blogId = ?"; // SQL query to fetch the blog by ID

        try (PreparedStatement pstmt = connection.prepareStatement(sql)){
            pstmt.setInt(1, blogId); // Set the blogId parameter
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                blog = new Blog(); // Create a new Blog object
                blog.setBlogId(rs.getInt("blogId"));
                blog.setBlogTitle(rs.getString("blogTitle"));
                blog.setBlogDescription(rs.getString("blogDescription"));
                blog.setBlogDate(rs.getDate("blogDate"));
                blog.setHealthId(rs.getInt("healthId"));
                blog.setCategory(rs.getString("category"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blog; // Return the found blog or null if not found
    }
    
    //
    public String getHealthWorkerNameByBlogId(int blogId) {
        String healthWorkerName = null;
        String sql = "SELECT healthId FROM Blog WHERE blogId = ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, blogId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                int healthId = rs.getInt("healthId");
                healthWorkerName = getHealthWorkerNameById(healthId); // Call the method to get the health worker's name
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return healthWorkerName; // Return the health worker's name or null if not found
    }
    
    //HealthWorker by id
    public String getHealthWorkerNameById(int healthId) {
        String sql = "SELECT name FROM HealthWorker WHERE healthId = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, healthId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString("name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // Return null if no health worker found with the given ID
    }

	 // Method to fetch upcoming appointments
	 public List<Appointment> getUpcomingAppointments() {
	        List<Appointment> appointmentList = new ArrayList<>();
	     // SQL query to fetch upcoming appointments
            String sql = "SELECT * FROM Appointment WHERE appointmentDate >= SYSDATE ORDER BY appointmentDate ASC";
	        try(PreparedStatement pstmt = connection.prepareStatement(sql)) {
	            ResultSet rs = pstmt.executeQuery();
	            // Loop through the result set and create Appointment objects
	            while (rs.next()) {
	                Appointment appointment = new Appointment();
	                appointment.setAppointmentId(rs.getInt("appointmentId"));
	                appointment.setHealthId(rs.getInt("healthId"));
	                appointment.setUserId(rs.getInt("userId"));
	                appointment.setAppointmentDate(rs.getDate("appointmentDate"));
	                appointment.setStatus(rs.getString("status"));
	
	                // Add each appointment to the list
	                appointmentList.add(appointment);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } 
	        return appointmentList; // Return the list of upcoming appointments
	    }
    
	//fetch and search Blog
    public List<Blog> searchBlog(String category, String title) {
        List<Blog> blogList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Blog WHERE 1=1"); // Always true condition

        // Add conditions based on inputs
        boolean hasCategory = category != null && !category.isEmpty();
        boolean hasTitle = title != null && !title.isEmpty();

        if (hasCategory) {
            sql.append(" AND category LIKE ?");
        }
        if (hasTitle) {
            sql.append(" AND blogTitle LIKE ?");
        }

        // If both are false, return all blogs by not adding any conditions
        try (PreparedStatement pstmt = connection.prepareStatement(sql.toString())) {
            int index = 1;

            // Set parameters based on provided conditions
            if (hasCategory) {
                pstmt.setString(index++, "%" + category + "%"); // Use LIKE for category search
            }
            if (hasTitle) {
                pstmt.setString(index++, "%" + title + "%"); // Use LIKE for title search
            }

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Blog blog = new Blog();
                blog.setBlogId(rs.getInt("blogId"));
                blog.setBlogTitle(rs.getString("blogTitle"));
                blog.setBlogDescription(rs.getString("blogDescription"));
                blog.setBlogDate(rs.getDate("blogDate"));
                blog.setHealthId(rs.getInt("healthId"));
                blog.setCategory(rs.getString("category"));
                blogList.add(blog);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogList; // Return the list of found blogs
    }
    
        // Blog Post
    public boolean insertBlog(Blog blog) {
        String sql = "INSERT INTO Blog (blogId, blogTitle, blogDescription, blogDate, healthId, category) VALUES (?, ?, ?, ?, ?, ?)";
        int nextId = 100; // Start from 100 if no entries exist

        // Fetch the next blogId
        String maxIdSql = "SELECT MAX(blogId) FROM Blog";
        try (PreparedStatement maxIdPstmt = connection.prepareStatement(maxIdSql);
             ResultSet rs = maxIdPstmt.executeQuery()) {
            if (rs.next() && rs.getInt(1) != 0) {
                nextId = rs.getInt(1) + 1; // Increment the max id by 1
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Insert the blog
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, nextId);
            pstmt.setString(2, blog.getBlogTitle());
            pstmt.setString(3, blog.getBlogDescription());
            pstmt.setDate(4, blog.getBlogDate());
            pstmt.setInt(5, blog.getHealthId());
            pstmt.setString(6, blog.getCategory());

            int rows = pstmt.executeUpdate();
            return rows > 0;  // Return true if the blog was successfully added
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;  // Return false if there was an error
    }

    //fetch and search Health Workers
    public List<HealthWorker> searchHealthWorkers(Integer healthId, String name, String gender, String villageName) {
        List<HealthWorker> healthWorkers = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM HealthWorker WHERE 1=1");

        // Adding conditions based on the parameters provided
        if (healthId != null) {
            sql.append(" AND healthId = ?");
        }
        if (name != null && !name.isEmpty()) {
            sql.append(" AND name LIKE ?");
        }
        if (gender != null && !gender.isEmpty()) {
            sql.append(" AND gender = ?");
        }
        if (villageName != null && !villageName.isEmpty()) {
            sql.append(" AND villageName = ?");
        }

        try (PreparedStatement pstmt = connection.prepareStatement(sql.toString())) {
            int index = 1;

            if (healthId != null) {
                pstmt.setInt(index++, healthId);
            }
            if (name != null && !name.isEmpty()) {
                pstmt.setString(index++, "%" + name + "%");  // Using LIKE for partial match
            }
            if (gender != null && !gender.isEmpty()) {
                pstmt.setString(index++, gender);
            }
            if (villageName != null && !villageName.isEmpty()) {
                pstmt.setString(index++, villageName);
            }

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                HealthWorker healthWorker = new HealthWorker();
                healthWorker.setHealthId(rs.getInt("healthId"));
                healthWorker.setName(rs.getString("name"));
                healthWorker.setGender(rs.getString("gender"));
                healthWorker.setAge(rs.getInt("age"));
                healthWorker.setSpecialisation(rs.getString("specialisation"));
                healthWorker.setVillageName(rs.getString("villageName"));
                healthWorker.setSlot(rs.getString("slot"));
                healthWorker.setDay(rs.getString("day"));
                healthWorkers.add(healthWorker);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return healthWorkers;
    }
    
    //fetch and search Residents
    public List<Resident> searchResidents(Integer userId, String name, String gender, String villageName) {
        List<Resident> residentList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT userId, name, dob, villageName, gender, phone, email FROM Resident WHERE 1=1");
        
        List<Object> params = new ArrayList<>(); // To store the parameters for the prepared statement

        // Check if each field is provided and append to the query
        if (userId != null) {
            sql.append(" AND userId = ?");
            params.add(userId);
        }
        if (name != null && !name.isEmpty()) {
            sql.append(" AND name LIKE ?");
            params.add("%" + name + "%"); // Use LIKE for partial matching
        }
        if (gender != null && !gender.isEmpty()) {
            sql.append(" AND gender = ?");
            params.add(gender);
        }
        if (villageName != null && !villageName.isEmpty()) {
            sql.append(" AND villageName = ?");
            params.add(villageName);
        }

        try (PreparedStatement pstmt = connection.prepareStatement(sql.toString())) {
            // Set the parameters dynamically based on the input fields
            for (int i = 0; i < params.size(); i++) {
                pstmt.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Resident resident = new Resident();
                    resident.setUserId(rs.getInt("userId"));
                    resident.setName(rs.getString("name"));
                    resident.setDob(rs.getDate("dob"));
                    resident.setVillageName(rs.getString("villageName"));
                    resident.setGender(rs.getString("gender"));
                    resident.setPhone(rs.getString("phone"));
                    resident.setEmail(rs.getString("email"));
                    
                    residentList.add(resident);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return residentList;
    }

    // Resident Login
    public String getResidentForLogin(String userId, String password) {
        String sql = "SELECT name FROM Resident WHERE userId = ? AND password = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            pstmt.setString(2, password);  // Password should ideally be hashed
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString("name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
	 // Resident by Id
	    public Resident getResidentById(int residentId) {
	        Resident resident = null;
	        String sql = "SELECT * FROM Resident WHERE userId = ?"; // SQL query to fetch the resident by ID
	
	        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
	            pstmt.setInt(1, residentId); // Set the residentId parameter
	            ResultSet rs = pstmt.executeQuery();
	
	            if (rs.next()) {
	                resident = new Resident(); // Create a new Resident object
	                resident.setUserId(rs.getInt("userId"));
	                resident.setPassword(rs.getString("password"));
	                resident.setName(rs.getString("name"));
	                resident.setDob(rs.getDate("dob"));
	                resident.setVillageName(rs.getString("villageName"));
	                resident.setGender(rs.getString("gender"));
	                resident.setPhone(rs.getString("phone"));
	                resident.setEmail(rs.getString("email"));
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return resident; // Return the found resident or null if not found
	    }
    
    // Resident Signup
    public int insertResident(Resident resident) {
        String fetchMaxIdSql = "SELECT COALESCE(MAX(userId), 0) FROM Resident";
        String insertSql = "INSERT INTO Resident (userId, password, name, dob, villageName, gender, phone, email) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        int newUserId = 0;

        try {
            // Fetch the maximum userId from the Resident table
            try (PreparedStatement fetchMaxStmt = connection.prepareStatement(fetchMaxIdSql);
                 ResultSet rs = fetchMaxStmt.executeQuery()) {
                if (rs.next()) {
                    // If max userId is 0 (no records), start from 1000, else increment by 1
                    int maxUserId = rs.getInt(1);
                    if (maxUserId == 0) {
                        newUserId = 1000;  // Start from 1000 if no resident exists
                    } else {
                        newUserId = maxUserId + 1;
                    }
                }
            }

            // Insert the new resident data with the generated userId
            try (PreparedStatement insertStmt = connection.prepareStatement(insertSql)) {
                insertStmt.setInt(1, newUserId);
                insertStmt.setString(2, resident.getPassword());
                insertStmt.setString(3, resident.getName());
                insertStmt.setDate(4, resident.getDob());  // Ensure proper date formatting
                insertStmt.setString(5, resident.getVillageName());
                insertStmt.setString(6, resident.getGender());
                insertStmt.setString(7, resident.getPhone());
                insertStmt.setString(8, resident.getEmail());

                int rows = insertStmt.executeUpdate();
                if (rows > 0) {
                    return newUserId;  // Return the new userId if insertion is successful
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;  // Return -1 if there was an error
    }

    // Health Worker Login
    public String getHealthWorkerForLogin(String healthId, String password) {
        String sql = "SELECT name FROM HealthWorker WHERE healthId = ? AND password = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setString(1, healthId);
            pstmt.setString(2, password);  // Password should ideally be hashed
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString("name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // HealthWorker Enroll
    public int insertHealthWorker(HealthWorker healthWorker) {
        String fetchMaxIdSql = "SELECT COALESCE(MAX(healthId), 0) FROM HealthWorker";
        String insertSql = "INSERT INTO HealthWorker (healthId, password, name, gender, age, specialisation, villageName, slot, day) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        int newHealthId = 0;

        try {
            // Fetch the maximum healthId from the HealthWorker table
            try (PreparedStatement fetchMaxStmt = connection.prepareStatement(fetchMaxIdSql);
                 ResultSet rs = fetchMaxStmt.executeQuery()) {
                if (rs.next()) {
                    // If max healthId is 0 (no records), start from 1000, else increment by 1
                    int maxHealthId = rs.getInt(1);
                    if (maxHealthId == 0) {
                        newHealthId = 1000;  // Start from 1000 if no health worker exists
                    } else {
                        newHealthId = maxHealthId + 1;
                    }
                }
            }

            // Insert the new health worker data with the generated healthId
            try (PreparedStatement insertStmt = connection.prepareStatement(insertSql)) {
                insertStmt.setInt(1, newHealthId);
                insertStmt.setString(2, healthWorker.getPassword());
                insertStmt.setString(3, healthWorker.getName());
                insertStmt.setString(4, healthWorker.getGender());
                insertStmt.setInt(5, healthWorker.getAge());
                insertStmt.setString(6, healthWorker.getSpecialisation());
                insertStmt.setString(7, healthWorker.getVillageName());
                insertStmt.setString(8, healthWorker.getSlot());
                insertStmt.setString(9, healthWorker.getDay());

                int rows = insertStmt.executeUpdate();
                if (rows > 0) {
                    return newHealthId;  // Return the new healthId if insertion is successful
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;  // Return -1 if there was an error
    }

    // Additional methods for updating, deleting, or querying data can be added here as per requirement
}
