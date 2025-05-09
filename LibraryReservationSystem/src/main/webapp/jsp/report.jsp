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

    String mostActiveUser = reservationDAO.getMostActiveUser(); // Optional now
    List<String[]> topBooks = reservationDAO.getTopReservedBooks(3);
    List<String[]> reservedUsers = reservationDAO.getReservationCountByUsers();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Reports</title>
    <style>
        <style>
    body {
        font-family: Arial;
        background: #f0f4f8;
        margin: 0;
        padding: 30px;
    }

    h2 {
        text-align: center;
        color: #004aac;
        margin-top: 10px;
        margin-bottom: 40px;
    }

    .report-container {
        display: flex;
        justify-content: center;
        flex-wrap: wrap;
        gap: 25px;
        margin-bottom: 30px;
    }

    .card {
        background: white;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
        text-align: center;
        width: 200px;
        transition: transform 0.2s ease;
    }

    .card:hover {
        transform: translateY(-5px);
    }

    .card h3 {
        margin-bottom: 12px;
        font-size: 16px;
        color: #004aac;
    }

    .card p {
        font-size: 26px;
        font-weight: bold;
        margin: 0;
        color: #333;
    }

    .card small {
        display: block;
        margin-top: 8px;
        font-size: 12px;
        color: #777;
    }

    table {
        width: 90%;
        margin: 0 auto 40px auto;
        border-collapse: collapse;
        background: white;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.07);
        border-radius: 8px;
        overflow: hidden;
    }

    th, td {
        padding: 14px;
        border-bottom: 1px solid #eee;
        text-align: center;
    }

    th {
        background: #004aac;
        color: white;
    }

    tr:hover {
        background-color: #f2f7ff;
    }

    .back {
        text-align: center;
        margin-top: 20px;
    }

    .back a {
        background: #ddd;
        padding: 10px 25px;
        text-decoration: none;
        border-radius: 8px;
        color: #333;
        font-weight: bold;
    }

    .section-title {
        margin-top: 50px;
        margin-bottom: 20px;
        text-align: center;
        color: #004aac;
        font-size: 22px;
    }
</style>
</head>
<body>
    <h2 style="text-align:center; color:#004aac;">Admin Reports</h2>

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

    <h2 style="text-align:center; color:#004aac; margin-top:40px;">Top 3 Reserved Books</h2>
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

    <h2 style="text-align:center; color:#004aac; margin-top:40px;">Users With Reservations</h2>
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
