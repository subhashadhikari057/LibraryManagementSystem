<%@ page import="model.User" %>
<%@ page import="dao.BookDAO" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="dao.ReservationDAO" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>
<%
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"admin".equals(admin.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    BookDAO bookDAO = new BookDAO();
    UserDAO userDAO = new UserDAO();
    ReservationDAO reservationDAO = new ReservationDAO();

    int totalBooks = bookDAO.getTotalBooks();
    int availableBooks = bookDAO.getAvailableBooksCount();
    int unavailableBooks = bookDAO.getUnavailableBooksCount();
    int totalUsers = userDAO.getTotalUsers();
    int totalReservations = reservationDAO.getTotalReservations();

    String mostActiveUser = reservationDAO.getMostActiveUser();
    List<String[]> topBooks = reservationDAO.getTopReservedBooks(3);
    List<String[]> reservedUsers = reservationDAO.getReservationCountByUsers();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Reports</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #002B36, #014421); /* dark green */
            margin: 0;
            padding: 40px;
            min-height: 100vh;
            color: #fff;
        }

        h2 {
            text-align: center;
            color: #e8f5e9;
            margin-bottom: 30px;
        }

        .top-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            flex-wrap: wrap;
        }

        .top-header a {
            background: #1b5e20;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: background 0.3s ease;
        }

        .top-header a:hover {
            background-color: #2e7d32;
        }

        .report-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 25px;
            margin-bottom: 50px;
        }

        .card {
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(12px);
            padding: 30px;
            border-radius: 20px;
            text-align: center;
            width: 200px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card h3 {
            font-size: 16px;
            margin-bottom: 12px;
            color: #c8e6c9;
        }

        .card p {
            font-size: 28px;
            font-weight: bold;
            color: #ffffff;
            margin: 0;
        }

        .section-title {
            margin-top: 50px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 22px;
            color: #dcedc8;
        }

        table {
            width: 95%;
            margin: 0 auto 50px auto;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.97);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
            border-radius: 12px;
            overflow: hidden;
            color: #000;
        }

        th, td {
            padding: 14px;
            text-align: center;
            font-size: 15px;
            border-bottom: 1px solid #e0e0e0;
        }

        th {
            background-color: #2e7d32;
            color: white;
        }

        tr:hover {
            background-color: #f1f8f5;
        }

        .back {
            text-align: center;
            margin-top: 30px;
        }

        .back a {
            background: rgba(255, 255, 255, 0.9);
            padding: 12px 25px;
            text-decoration: none;
            border-radius: 8px;
            color: #1b5e20;
            font-weight: bold;
            transition: background 0.3s ease;
        }

        .back a:hover {
            background-color: #c8e6c9;
        }

        @media (max-width: 768px) {
            .report-container {
                flex-direction: column;
                align-items: center;
            }

            .top-header {
                flex-direction: column;
                gap: 20px;
            }
        }
    </style>
</head>
<body>

<div class="top-header">
    <h2>Admin Reports</h2>
    <a href="../ExportCSVServlet">Export All Reservations to CSV</a>
</div>

<div class="report-container">
    <div class="card">
        <h3>Total Books</h3>
        <p><%= totalBooks %></p>
    </div>
    <div class="card">
        <h3>Available Books</h3>
        <p><%= availableBooks %></p>
    </div>
    <div class="card">
        <h3>Unavailable Books</h3>
        <p><%= unavailableBooks %></p>
    </div>
    <div class="card">
        <h3>Total Users</h3>
        <p><%= totalUsers %></p>
    </div>
    <div class="card">
        <h3>Total Reservations</h3>
        <p><%= totalReservations %></p>
    </div>
</div>

<div class="section-title">Top 3 Reserved Books</div>
<table>
    <tr>
        <th>Book Title</th>
        <th>Reservation Count</th>
    </tr>
    <%
        for (String[] row : topBooks) {
    %>
    <tr>
        <td><%= row[0] %></td>
        <td><%= row[1] %></td>
    </tr>
    <%
        }
        if (topBooks.isEmpty()) {
    %>
    <tr>
        <td colspan="2">No reservations yet.</td>
    </tr>
    <%
        }
    %>
</table>

<div class="section-title">Users With Reservations</div>
<table>
    <tr>
        <th>User Name</th>
        <th>Reservation Count</th>
    </tr>
    <%
        for (String[] row : reservedUsers) {
    %>
    <tr>
        <td><%= row[0] %></td>
        <td><%= row[1] %></td>
    </tr>
    <%
        }
        if (reservedUsers.isEmpty()) {
    %>
    <tr>
        <td colspan="2">No user has made reservations yet.</td>
    </tr>
    <%
        }
    %>
</table>

<div class="back">
    <a href="admin.jsp">Back to Dashboard</a>
</div>

</body>
</html>
