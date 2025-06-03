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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #002B36, #014421); /* dark green gradient */
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px;
        }

        .card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(12px);
            border-radius: 20px;
            padding: 40px;
            max-width: 600px;
            width: 100%;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.25);
            animation: fadeIn 0.7s ease-in-out;
            text-align: center;
            color: #ffffff;
        }

        h2 {
            font-size: 26px;
            margin-bottom: 10px;
            color: #e8f5e9;
        }

        p {
            font-size: 15px;
            color: #c8e6c9;
            margin-bottom: 20px;
        }

        .btn {
            display: block;
            background-color: #1b5e20;
            color: white;
            padding: 14px;
            margin: 12px auto;
            width: 85%;
            text-decoration: none;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: bold;
            transition: background 0.3s ease, transform 0.2s ease;
            box-shadow: 0 5px 12px rgba(27, 94, 32, 0.4);
        }

        .btn:hover {
            background-color: #2e7d32;
            transform: scale(1.03);
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            .card {
                padding: 30px 20px;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<div class="card">
    <h2>Welcome, <%= user.getFullName() %></h2>
    <p>Email: <%= user.getEmail() %></p>
    <p>You can view and reserve books below.</p>

    <a class="btn" href="view-available-books.jsp">View Available Books</a>
    <a class="btn" href="my-reservations.jsp">My Reservations</a>
    <a class="btn" href="about.jsp">About</a>
    <a class="btn" href="contact.jsp">Contact</a>
    <a class="btn" href="login.jsp">Logout</a>
</div>
</body>
</html>
