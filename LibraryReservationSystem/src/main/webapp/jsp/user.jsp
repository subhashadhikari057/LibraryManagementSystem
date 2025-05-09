<%@ page import="model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"user".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <style>
        body {
            font-family: Arial;
            padding: 40px;
            background: #f4f7fa;
        }
        .card {
            max-width: 600px;
            margin: auto;
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h2 {
            color: #004aac;
        }
        p {
            margin: 8px 0;
        }
        .btn {
            display: block;
            background-color: #004aac;
            color: white;
            padding: 16px;
            margin: 14px auto;
            width: 85%;
            text-decoration: none;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .btn:hover {
            background-color: #003377;
            transform: translateY(-2px);
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.15);
        }
    </style>
</head>
<body>
<div class="card">
    <h2>Welcome, <%= user.getFullName() %></h2>
    <p>Email: <%= user.getEmail() %></p>
    <p>You can view and reserve books below.</p>

    <a class="btn" href="view-available-books.jsp"> View Available Books</a>
    <a class="btn" href="my-reservations.jsp"> My Reservations</a>
    <a class="btn" href="about.jsp"> About</a>
	<a class="btn" href="contact.jsp"> Contact</a>
    <a class="btn" href="login.jsp"> Logout</a>
</div>
</body>
</html>
