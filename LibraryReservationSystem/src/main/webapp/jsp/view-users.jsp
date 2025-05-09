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
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Users</title>
    <style>
        body {
            font-family: Arial;
            background: #f4f7fa;
            padding: 30px;
        }
        table {
            width: 90%;
            margin: auto;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ccc;
        }
        th {
            background: #004aac;
            color: white;
        }
        h2 {
            text-align: center;
            color: #004aac;
        }
        .btn {
            padding: 6px 12px;
            background: #d9534f;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .dropdown {
            padding: 6px;
        }
        .back-btn {
            text-align: center;
            margin-top: 20px;
        }
        .back-btn a {
            background: #ccc;
            padding: 10px 20px;
            text-decoration: none;
            color: black;
            border-radius: 5px;
            font-weight: bold;
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
                    <button type="submit" class="btn" style="background: #5bc0de;">Update</button>
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
