--DROP
DROP table Resident;
DROP table HealthWorker;
DROP table Event;
DROP table Appointment;
DROP table District;
DROP table Village;
DROP table Blog;
DROP table Specialization;
-------------------------

CREATE TABLE Resident (
    userId number(8), 
    password VARCHAR(20) ,
    name VARCHAR(20) ,         
    dob DATE ,                      
    villageName VARCHAR(20),              
    gender varchar(8), 
    phone varchar(10),
    email varchar(40)
);
-----------
CREATE TABLE HealthWorker (
    healthId number(8),
    password VARCHAR(8),
    name VARCHAR(50),
    gender varchar(8),
    age number(3),
    specialisation VARCHAR(50),
    villageName VARCHAR(50),
    slot VARCHAR(50),
    day varchar(20)
);
--------------

CREATE TABLE Event (
    eventId NUMBER(8),
    eventName VARCHAR(50),
    eventStartDate DATE,
    eventEndDate DATE,
    eventStartTime VARCHAR(20),  -- Use VARCHAR2 for time, or use TIMESTAMP if you want both date and time
    eventEndTime VARCHAR(20),
    healthId NUMBER(8),              -- Foreign key reference for healthcare worker (assuming it's linked to health worker table)
    villageName VARCHAR(50),
    eventDescription VARCHAR(150)
);
---------------------------
CREATE TABLE Appointment(
    appointmentId NUMBER(8),
    healthId NUMBER(8),
    userId NUMBER(8),
    appointmentDate DATE,
    status VARCHAR(20)
);

-----------------------------
CREATE TABLE District(
    districtId NUMBER(8),
    districtName varchar(30)
);

CREATE TABLE Village(
    districtId NUMBER(8),
    villageName varchar(30)
);

--------
CREATE TABLE Blog (
    blogId NUMBER(8),
    blogTitle VARCHAR(100),
    blogDescription varchar(1000),
    blogDate DATE,
    healthId NUMBER(8),
    category VARCHAR(50)
);

--------------
CREATE TABLE Specialization(Specialization varchar(50));


------------------
--HEALTHWORKER
INSERT INTO HealthWorker VALUES (1001, '123', 'John Doe', 'Male', 35, 'Nutrition', 'Village A', 'Morning', 'Monday');
INSERT INTO HealthWorker VALUES (1002, '123', 'Jane Smith', 'Female', 40, 'Mental Health', 'Village B', 'Afternoon', 'Wednesday');
INSERT INTO HealthWorker VALUES (1003, '123', 'Samuel Green', 'Male', 30, 'Child Health', 'Village C', 'Evening', 'Friday');
INSERT INTO HealthWorker VALUES (1004, '123', 'Emily White', 'Female', 45, 'Community Health', 'Village D', 'Morning', 'Tuesday');

--Appointment
INSERT INTO Appointment VALUES (3001, 1001, 2001, TO_DATE('2024-12-12', 'YYYY-MM-DD'), 'Scheduled');
INSERT INTO Appointment VALUES (3002, 1001, 2002, TO_DATE('2024-12-13', 'YYYY-MM-DD'), 'Completed');
INSERT INTO Appointment VALUES (3003, 1002, 2003, TO_DATE('2024-12-14', 'YYYY-MM-DD'), 'Scheduled');
INSERT INTO Appointment VALUES (3004, 1002, 2004, TO_DATE('2024-12-15', 'YYYY-MM-DD'), 'Cancelled');
INSERT INTO Appointment VALUES (3005, 1003, 2005, TO_DATE('2024-12-16', 'YYYY-MM-DD'), 'Completed');
INSERT INTO Appointment VALUES (3006, 1003, 2006, TO_DATE('2024-12-17', 'YYYY-MM-DD'), 'Scheduled');
INSERT INTO Appointment VALUES (3007, 1004, 2007, TO_DATE('2024-12-18', 'YYYY-MM-DD'), 'Scheduled');
INSERT INTO Appointment VALUES (3008, 1004, 2008, TO_DATE('2024-12-19', 'YYYY-MM-DD'), 'Completed');

--Event
INSERT INTO Event VALUES (4001, 'Health Awareness', TO_DATE('2024-11-20', 'YYYY-MM-DD'), TO_DATE('2024-11-20', 'YYYY-MM-DD'), '10:00 AM', '12:00 PM', 1001, 'Village A', 'Nutrition counseling and health awareness.');
INSERT INTO Event VALUES (4002, 'Mental Health Camp', TO_DATE('2024-11-22', 'YYYY-MM-DD'), TO_DATE('2024-11-22', 'YYYY-MM-DD'), '1:00 PM', '3:00 PM', 1002, 'Village B', 'Mental health screening and consultations.');
INSERT INTO Event VALUES (4003, 'Child Health Fair', TO_DATE('2024-11-23', 'YYYY-MM-DD'), TO_DATE('2024-11-23', 'YYYY-MM-DD'), '9:00 AM', '12:00 PM', 1003, 'Village C', 'Health checkups for children.');
INSERT INTO Event VALUES (4004, 'Community Health Day', TO_DATE('2024-11-25', 'YYYY-MM-DD'), TO_DATE('2024-11-25', 'YYYY-MM-DD'), '10:00 AM', '2:00 PM', 1004, 'Village D', 'Health education for community.');
INSERT INTO Event VALUES (4005, 'Nutrition Workshop', TO_DATE('2024-11-26', 'YYYY-MM-DD'), TO_DATE('2024-11-26', 'YYYY-MM-DD'), '2:00 PM', '4:00 PM', 1001, 'Village A', 'Nutrition tips and healthy living.');
INSERT INTO Event VALUES (4006, 'Mental Health Talk', TO_DATE('2024-11-27', 'YYYY-MM-DD'), TO_DATE('2024-11-27', 'YYYY-MM-DD'), '3:00 PM', '5:00 PM', 1002, 'Village B', 'Mental health awareness talk.');

--blog
INSERT INTO Blog VALUES (5001, 'Nutrition and Well-being', 'Tips In today s fast-paced world, maintaining a healthy lifestyle is crucial for physical and mental well-being. A balanced diet, regular exercise, and mental health awareness are essential components of overall health. Nutrition plays a vital role in providing the body with the necessary nutrients to function properly, while physical activity helps to improve cardiovascular health and reduce the risk of chronic diseases. Equally important is mental health, which can be strengthened by mindfulness, meditation, and open conversations. Together, these aspects create a foundation for a fulfilling, healthy life in any community.for maintaining a balanced diet and healthy lifestyle.', TO_DATE('2024-10-11', 'YYYY-MM-DD'), 1001, 'Nutrition');
INSERT INTO Blog VALUES (5002, 'Mental Health Awareness', 'Understanding mental health and In today s fast-paced world, maintaining a healthy lifestyle is crucial for physical and mental well-being. A balanced diet, regular exercise, and mental health awareness are essential components of overall health. Nutrition plays a vital role in providing the body with the necessary nutrients to function properly, while physical activity helps to improve cardiovascular health and reduce the risk of chronic diseases. Equally important is mental health, which can be strengthened by mindfulness, meditation, and open conversations. Together, these aspects create a foundation for a fulfilling, healthy life in any community. breaking stigmas.', TO_DATE('2024-10-05', 'YYYY-MM-DD'), 1002, 'Mental Health');
INSERT INTO Blog VALUES (5003, 'Child Health Essentials', 'Key tips for ensuring child In today s fast-paced world, maintaining a healthy lifestyle is crucial for physical and mental well-being. A balanced diet, regular exercise, and mental health awareness are essential components of overall health. Nutrition plays a vital role in providing the body with the necessary nutrients to function properly, while physical activity helps to improve cardiovascular health and reduce the risk of chronic diseases. Equally important is mental health, which can be strengthened by mindfulness, meditation, and open conversations. Together, these aspects create a foundation for a fulfilling, healthy life in any community. well-being and growth.', TO_DATE('2024-10-10', 'YYYY-MM-DD'), 1003, 'Child Health');
INSERT INTO Blog VALUES (5004, 'Community Health Matters', 'Building strong, healthy communities In today s fast-paced world, maintaining a healthy lifestyle is crucial for physical and mental well-being. A balanced diet, regular exercise, and mental health awareness are essential components of overall health. Nutrition plays a vital role in providing the body with the necessary nutrients to function properly, while physical activity helps to improve cardiovascular health and reduce the risk of chronic diseases. Equally important is mental health, which can be strengthened by mindfulness, meditation, and open conversations. Together, these aspects create a foundation for a fulfilling, healthy life in any community..', TO_DATE('2024-10-12', 'YYYY-MM-DD'), 1004, 'Community Health');
INSERT INTO Blog VALUES (5005, 'Healthy Eating Habits', 'Simple steps In today s fast-paced world, maintaining a healthy lifestyle is crucial for physical and mental well-being. A balanced diet, regular exercise, and mental health awareness are essential components of overall health. Nutrition plays a vital role in providing the body with the necessary nutrients to function properly, while physical activity helps to improve cardiovascular health and reduce the risk of chronic diseases. Equally important is mental health, which can be strengthened by mindfulness, meditation, and open conversations. Together, these aspects create a foundation for a fulfilling, healthy life in any community. for maintaining proper nutrition.', TO_DATE('2024-10-15', 'YYYY-MM-DD'), 1001, 'Nutrition');
INSERT INTO Blog VALUES (5006, 'Mental Wellness Strategies', 'Daily habits for maintaining mental well-being.', TO_DATE('2024-10-20', 'YYYY-MM-DD'), 1002, 'Mental Health');
INSERT INTO Blog VALUES (5007, 'Well-being', 'Tips for maintaining a balanced diet In today s fast-paced world, maintaining a healthy lifestyle is crucial for physical and mental well-being. A balanced diet, regular exercise, and mental health awareness are essential components of overall health. Nutrition plays a vital role in providing the body with the necessary nutrients to function properly, while physical activity helps to improve cardiovascular health and reduce the risk of chronic diseases. Equally important is mental health, which can be strengthened by mindfulness, meditation, and open conversations. Together, these aspects create a foundation for a fulfilling, healthy life in any community.and healthy lifestyle.', TO_DATE('2024-10-12', 'YYYY-MM-DD'), 1001, 'Nutrition');


--Specialization
INSERT INTO Specialization VALUES ('Nutrition');
INSERT INTO Specialization VALUES ('Mental Health');
INSERT INTO Specialization VALUES ('Child Health');
INSERT INTO Specialization VALUES ('Community Health');


--RESIDENT
INSERT INTO Resident VALUES (1001, '123', 'Alice Johnson', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 'Village A1', 'Female', '1234567890', 'alice@example.com');
INSERT INTO Resident VALUES (1002, '123', 'Bob Smith', TO_DATE('1985-08-20', 'YYYY-MM-DD'), 'Village A2', 'Male', '0987654321', 'bob@example.com');
INSERT INTO Resident VALUES (1003, '123', 'Charlie Brown', TO_DATE('1992-03-30', 'YYYY-MM-DD'), 'Village B1', 'Male', '1231231234', 'charlie@example.com');
INSERT INTO Resident VALUES (1004, '123', 'Diana Prince', TO_DATE('1988-11-10', 'YYYY-MM-DD'), 'Village B2', 'Female', '4564564567', 'diana@example.com');
INSERT INTO Resident VALUES (1005, '123', 'Ethan Hunt', TO_DATE('1995-12-05', 'YYYY-MM-DD'), 'Village C1', 'Male', '7897897890', 'ethan@example.com');

--DISTRICT
INSERT INTO District VALUES (1, 'District A');
INSERT INTO District VALUES (2, 'District B');
INSERT INTO District VALUES (3, 'District C');

--Village
INSERT INTO Village VALUES (1, 'Village A1');
INSERT INTO Village VALUES (1, 'Village A2');
INSERT INTO Village VALUES (2, 'Village B1');
INSERT INTO Village VALUES (2, 'Village B2');
INSERT INTO Village VALUES (3, 'Village C1');

-----------------------
