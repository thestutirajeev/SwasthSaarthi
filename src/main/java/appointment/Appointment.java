package appointment;

import java.sql.Date;

public class Appointment {
    private int appointmentId;
    private int healthId;        // Foreign key reference to HealthWorker
    private int userId;          // Foreign key reference to Resident/User
    private Date appointmentDate;
    private String status;

    // Default constructor
    public Appointment() {}

    // Parameterized constructor
    public Appointment(int appointmentId, int healthId, int userId, Date appointmentDate, String status) {
        this.appointmentId = appointmentId;
        this.healthId = healthId;
        this.userId = userId;
        this.appointmentDate = appointmentDate;
        this.status = status;
    }

    // Getter and Setter methods
    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }

    public int getHealthId() {
        return healthId;
    }

    public void setHealthId(int healthId) {
        this.healthId = healthId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(Date appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
