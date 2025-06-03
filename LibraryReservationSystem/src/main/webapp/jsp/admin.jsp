<%@ page import="model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #002B36, #014421); /* dark green background */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .dashboard {
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(12px);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 600px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.25);
            text-align: center;
            color: #ffffff;
            animation: fadeIn 0.7s ease-in-out;
        }

        h2 {
            font-size: 26px;
            color: #e8f5e9;
            margin-bottom: 20px;
        }

        p {
            font-size: 16px;
            color: #c8e6c9;
            margin-bottom: 30px;
        }

        .btn {
            display: block;
            width: 90%;
            margin: 12px auto;
            background-color: #1b5e20;
            color: white;
            padding: 14px;
            border: none;
            border-radius: 10px;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
            box-shadow: 0 5px 12px rgba(27, 94, 32, 0.3);
        }

        .btn:hover {
            background-color: #2e7d32;
            transform: scale(1.03);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
<div class="dashboard">
    <h2>Welcome, <%= user.getFullName() %> (Admin)</h2>
    <p>Select an action below:</p>

    <a class="btn" href="add-book.jsp">Add Book</a>
    <a class="btn" href="view-books.jsp">View / Edit / Delete Books</a>
    <a class="btn" href="report.jsp">View Reports</a>
    <a class="btn" href="view-users.jsp">Manage Users</a>
    <a class="btn" href="about.jsp">About</a>
    <a class="btn" href="contact.jsp">Contact</a>
    <a class="btn" href="login.jsp">Logout</a>
</div>
</body>
</html>
