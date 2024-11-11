package blog;

import java.sql.Date;

public class Blog {
    private int blogId;
    private String blogTitle;
    private String blogDescription;
    private Date blogDate;
    private int healthId;        // Foreign key reference to HealthWorker
    private String category;

    // Default constructor
    public Blog() {}

    // Parameterized constructor
    public Blog(int blogId, String blogTitle, String blogDescription, Date blogDate, int healthId, String category) {
        this.blogId = blogId;
        this.blogTitle = blogTitle;
        this.blogDescription = blogDescription;
        this.blogDate = blogDate;
        this.healthId = healthId;
        this.category = category;
    }

    // Getter and Setter methods
    public int getBlogId() {
        return blogId;
    }

    public void setBlogId(int blogId) {
        this.blogId = blogId;
    }

    public String getBlogTitle() {
        return blogTitle;
    }

    public void setBlogTitle(String blogTitle) {
        this.blogTitle = blogTitle;
    }

    public String getBlogDescription() {
        return blogDescription;
    }

    public void setBlogDescription(String blogDescription) {
        this.blogDescription = blogDescription;
    }

    public Date getBlogDate() {
        return blogDate;
    }

    public void setBlogDate(Date blogDate) {
        this.blogDate = blogDate;
    }

    public int getHealthId() {
        return healthId;
    }

    public void setHealthId(int healthId) {
        this.healthId = healthId;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}
