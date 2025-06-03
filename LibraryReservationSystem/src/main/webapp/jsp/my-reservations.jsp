<%@ page import="model.User" %>
<%@ page import="model.Reservation" %>
<%@ page import="dao.ReservationDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"user".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    ReservationDAO resDAO = new ReservationDAO();
    List<Reservation> reservations = resDAO.getReservationsByUserId(user.getId());
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Reservations</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #002B36, #014421); /* dark green background */
            min-height: 100vh;
            padding: 40px;
            color: #ffffff;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
            color: #e8f5e9;
        }

        table {
            width: 95%;
            margin: auto;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.97);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            border-radius: 12px;
            overflow: hidden;
            color: #000;
        }

        th, td {
            padding: 14px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #2e7d32;
            color: white;
        }

        tr:hover {
            background-color: #f1f8f5;
        }

        .btn {
            padding: 8px 16px;
            background: #c62828;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .btn:hover {
            background-color: #b71c1c;
        }

        .no-data {
            text-align: center;
            color: #c8e6c9;
            font-size: 18px;
            margin-top: 40px;
        }

        .back {
            text-align: center;
            margin-top: 30px;
        }

        .back a {
            display: inline-block;
            padding: 12px 24px;
            background: rgba(255, 255, 255, 0.9);
            color: #1b5e20;
            text-decoration: none;
            font-weight: bold;
            border-radius: 8px;
            transition: background 0.3s ease;
        }

        .back a:hover {
            background-color: #c8e6c9;
        }

        @media (max-width: 768px) {
            table {
                font-size: 13px;
            }

            .btn {
                padding: 6px 12px;
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
    <h2>My Reservations</h2>

    <% if (reservations.isEmpty()) { %>
        <p class="no-data">You haven't reserved any books yet.</p>
    <% } else { %>
    <table>
        <tr>
            <th>Book Title</th>
            <th>Author</th>
            <th>Category</th>
            <th>Reserved On</th>
            <th>Return Due</th>
            <th>Action</th>
        </tr>
        <% for (Reservation r : reservations) { %>
        <tr>
            <td><%= r.getTitle() %></td>
            <td><%= r.getAuthor() %></td>
            <td><%= r.getCategory() %></td>
            <td><%= sdf.format(r.getReservedOn()) %></td>
            <td><%= sdf.format(r.getReturnDue()) %></td>
            <td>
                <form action="../UnreserveServlet" method="post">
                    <input type="hidden" name="reservationId" value="<%= r.getId() %>">
                    <input type="hidden" name="bookId" value="<%= r.getBookId() %>">
                    <button class="btn" type="submit">Unreserve</button>
                </form>
            </td>
        </tr>
        <% } %>
    </table>
    <% } %>

    <div class="back">
        <a href="user.jsp">Back to Dashboard</a>
    </div>
</body>
</html>
