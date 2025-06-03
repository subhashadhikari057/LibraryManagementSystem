<%@ page import="model.User" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>
<%
    User admin = (User) session.getAttribute("user");
    if (admin == null || !"admin".equals(admin.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    UserDAO userDAO = new UserDAO();
    List<User> users = userDAO.getAllUsers();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Users</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #002B36, #014421); /* dark green background */
            padding: 40px;
            min-height: 100vh;
        }

        h2 {
            text-align: center;
            font-size: 26px;
            margin-bottom: 30px;
            color: #b2dfdb;
        }

        table {
            width: 95%;
            margin: auto;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.97);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.25);
            border-radius: 12px;
            overflow: hidden;
            animation: fadeIn 0.7s ease-in-out;
        }

        th, td {
            padding: 14px;
            text-align: center;
            font-size: 14px;
            color: #333;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #00695c;
            color: white;
            font-weight: bold;
        }

        .btn {
            padding: 8px 14px;
            background: #388e3c;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            transition: background 0.3s ease;
        }

        .btn:hover {
            background: #2e7d32;
        }

        .btn-update {
            background: #00796b;
        }

        .btn-update:hover {
            background: #004d40;
        }

        select.dropdown {
            padding: 6px 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        .back-btn {
            text-align: center;
            margin-top: 30px;
        }

        .back-btn a {
            display: inline-block;
            padding: 12px 24px;
            background-color: rgba(255, 255, 255, 0.9);
            color: #002B36;
            text-decoration: none;
            font-weight: bold;
            border-radius: 8px;
            transition: background 0.3s ease;
        }

        .back-btn a:hover {
            background-color: #b2dfdb;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            th, td {
                font-size: 12px;
                padding: 10px;
            }

            .btn, .btn-update {
                padding: 6px 10px;
                font-size: 12px;
            }

            select.dropdown {
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
    <h2>Manage All Users</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Role</th>
            <th>Change Role</th>
            <th>Delete</th>
        </tr>
        <%
            for (User u : users) {
        %>
        <tr>
            <td><%= u.getId() %></td>
            <td><%= u.getFullName() %></td>
            <td><%= u.getEmail() %></td>
            <td><%= u.getRole() %></td>
            <td>
                <form action="../UpdateUserRoleServlet" method="post">
                    <input type="hidden" name="id" value="<%= u.getId() %>">
                    <select name="role" class="dropdown">
                        <option value="user" <%= u.getRole().equals("user") ? "selected" : "" %>>User</option>
                        <option value="admin" <%= u.getRole().equals("admin") ? "selected" : "" %>>Admin</option>
                    </select>
                    <button type="submit" class="btn btn-update">Update</button>
                </form>
            </td>
            <td>
                <form action="../DeleteUserServlet" method="post" onsubmit="return confirm('Are you sure?');">
                    <input type="hidden" name="id" value="<%= u.getId() %>">
                    <button type="submit" class="btn">Delete</button>
                </form>
            </td>
        </tr>
        <%
            }
        %>
    </table>

    <div class="back-btn">
        <a href="admin.jsp">Back to Dashboard</a>
    </div>
</body>
</html>
