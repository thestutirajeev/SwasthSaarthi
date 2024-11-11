package healthworker;

public class HealthWorker {
    private int healthId;
    private String password;
    private String name;
    private String gender;
    private int age;
    private String specialisation;
    private String villageName;
    private String slot;
    private String day;

    // Constructor
    public HealthWorker() {}

    public HealthWorker(int healthId, String password, String name, String gender, int age, String specialisation, String villageName, String slot, String day) {
        this.healthId = healthId;
        this.password = password;
        this.name = name;
        this.gender = gender;
        this.age = age;
        this.specialisation = specialisation;
        this.villageName = villageName;
        this.slot = slot;
        this.day = day;
    }

    // Getters and Setters
    public int getHealthId() {
        return healthId;
    }

    public void setHealthId(int healthId) {
        this.healthId = healthId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getSpecialisation() {
        return specialisation;
    }

    public void setSpecialisation(String specialisation) {
        this.specialisation = specialisation;
    }

    public String getVillageName() {
        return villageName;
    }

    public void setVillageName(String villageName) {
        this.villageName = villageName;
    }

    public String getSlot() {
        return slot;
    }

    public void setSlot(String slot) {
        this.slot = slot;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    @Override
    public String toString() {
        return "HealthWorker{" +
                "healthId=" + healthId +
                ", password='" + password + '\'' +
                ", name='" + name + '\'' +
                ", gender='" + gender + '\'' +
                ", age=" + age +
                ", specialisation='" + specialisation + '\'' +
                ", villageName='" + villageName + '\'' +
                ", slot='" + slot + '\'' +
                ", day='" + day + '\'' +
                '}';
    }
}
