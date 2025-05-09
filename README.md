# 📚 Library Management System

A complete Java EE-based web application for managing a library's books, users, and reservations, developed using **JSP**, **Servlets**, and **MySQL**. This project includes full **Admin** and **User** roles, with features like book reservation, return tracking, stock updates, user role management, and dynamic reports.

---

## 🔧 Technologies Used

- Java EE (JSP + Servlets)
- Apache Tomcat
- MySQL Database
- JDBC
- HTML + CSS
- Git & GitHub

---

## 👤 Roles

### 🧑 User
- Register / Login
- View available books
- Reserve & unreserve books
- Track return deadline
- View personal reservations

### 🛠️ Admin
- Add/Edit/Delete books
- Manage users (delete, update roles)
- View all books
- View all users
- View dashboard metrics
- Export reports (coming soon)
- 📦 Export reports to CSV

---

## 📌 Features

- Session-based authentication
- Stock control on reservation/unreservation
- Book availability status
- 7-day auto-return deadline
- Real-time analytics on dashboard
- Search functionality
- Input validations
- MVC folder structure
- User-friendly UI

---

## 🗂️ Project Structure

LibraryReservationSystem/
├── src/
│ ├── controller/
│ ├── dao/
│ ├── model/
│ └── util/
├── webapp/
│ ├── jsp/
│ └── WEB-INF/web.xml
└── README.md


---

## 💻 Setup Instructions

1. Clone this repository:
   ```bash
   git clone https://github.com/subhashadhikari057/LibraryManagementSystem.git
2. Import into your IDE (e.g., Eclipse/IntelliJ)

3. Configure Tomcat (9+ recommended)

4. Import library.sql into MySQL

5. Update DB credentials in DBConnection.java

6. Run on http://localhost:8080/LibraryReservationSystem


   👨‍💻 Developed by
Subhash Adhikari

