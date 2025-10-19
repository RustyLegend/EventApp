# Event Management Web Application

A full-featured, modern event management platform built with Java Servlets, JSP, and MySQL. This application allows users to discover, create, and manage events through a sleek, dark-themed user interface inspired by modern web platforms like Luma.

---

## ✨ Features

### General Features
* **Modern UI/UX:** A responsive, dark, and glossy theme applied consistently across all pages.
* **User Authentication:** Secure user registration and login system.
* **Role-Based Access:** Clear distinction between "Attendee" and "Organizer" roles with different permissions.
* **Dynamic Event Discovery:** A visually rich homepage displaying upcoming events with square banner images, dates, categories, and organizer details.

### Organizer Features
* **Create Events:** A sophisticated event creation form with a two-column layout.
* **Live Image Preview:** The banner image is instantly shown on a preview card when selected, before uploading.
* **Live Map Preview:** The event location is shown on an interactive Google Map as the organizer types the address.
* **Event Management:** Organizers can edit and delete the events they have created.
* **Error Handling:** Users are prompted with clear error messages, such as when they forget to upload an image.

### Attendee Features
* **Event Registration:** Attendees can register and unregister for events with a single click.
* **View Attendees:** See a list of all users registered for a specific event.

---

## 🛠️ Technologies Used

* **Backend:** Java, Java Servlets, JSP, JSTL
* **Frontend:** HTML, Inline CSS, JavaScript
* **Database:** MySQL
* **Web Server:** Apache Tomcat
* **Build Tool:** Apache Maven
* **APIs:** Google Maps Platform (JavaScript API, Geocoding API)

---

## 🚀 Setup and Installation

Follow these steps to get the project running on your local machine.

### Prerequisites
* Java Development Kit (JDK) 8 or higher
* Apache Maven
* Apache Tomcat 9 or higher
* MySQL Server

### 1. Clone the Repository
```bash
git clone [https://github.com/your-username/your-repo-name.git](https://github.com/your-username/your-repo-name.git)
cd your-repo-name
```

### 2. Database Setup
1.  Open MySQL Workbench or your preferred SQL client.
2.  Create a new database (schema).
    ```sql
    CREATE DATABASE event_app;
    ```
3.  Run the SQL scripts below to create the necessary tables.

    ```sql
    -- Create the 'users' table
    CREATE TABLE users (
        user_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) NOT NULL,
        email VARCHAR(255) NOT NULL UNIQUE,
        password VARCHAR(255) NOT NULL,
        role ENUM('attendee', 'organizer') NOT NULL
    );

    -- Create the 'categories' table
    CREATE TABLE categories (
        category_id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255) NOT NULL UNIQUE
    );

    -- Create the 'events' table
    CREATE TABLE events (
        event_id INT AUTO_INCREMENT PRIMARY KEY,
        title VARCHAR(255) NOT NULL,
        description TEXT,
        event_datetime DATETIME NOT NULL,
        venue VARCHAR(255),
        image_url VARCHAR(255),
        organizer_id INT,
        category_id INT,
        FOREIGN KEY (organizer_id) REFERENCES users(user_id),
        FOREIGN KEY (category_id) REFERENCES categories(category_id)
    );
    ```

### 3. Configuration
1.  **Database Connection:** Open `src/main/java/com/eventmanager/util/DBUtil.java` and update the database URL, username, and password to match your local MySQL setup.
2.  **Google Maps API Key:** Open `src/main/webapp/create-event.jsp`, find the `<script>` tag at the bottom that loads the Google Maps API, and replace `YOUR_API_KEY` with your actual key.
3.  **Image Upload Path:** The application saves uploaded images to `System.getProperty("user.home")/event-images`. Ensure this directory is writable.

### 4. Build and Deploy
1.  Build the project using Maven:
    ```bash
    mvn clean install
    ```
2.  This will generate a `EventApp.war` file in the `target/` directory.
3.  Deploy the `.war` file to your Apache Tomcat server.

You can now access the application at `http://localhost:8080/EventApp/`.
