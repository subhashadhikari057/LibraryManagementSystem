<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - Library System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #002B36, #014421); /* deep green gradient */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px 30px;
            width: 100%;
            max-width: 400px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.25);
            color: #ffffff;
            animation: fadeIn 0.7s ease-in-out;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            font-size: 28px;
            color: #e8f5e9;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: 500;
            color: #dcedc8;
        }

        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-top: 6px;
            border: none;
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.95);
            font-size: 15px;
        }

        input:focus {
            outline: 2px solid #66bb6a; /* light green outline */
        }

        button {
            margin-top: 25px;
            width: 100%;
            background: #1b5e20; /* dark green */
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        button:hover {
            background: #2e7d32;
        }

        .error {
            color: #ffdddd;
            background-color: #d32f2f;
            border-radius: 6px;
            padding: 10px;
            text-align: center;
            margin-top: 20px;
        }

        p {
            margin-top: 20px;
            text-align: center;
            color: #c8e6c9;
        }

        a {
            color: #a5d6a7;
            text-decoration: underline;
            font-weight: 500;
        }

        a:hover {
            text-decoration: none;
            color: #81c784;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>Library Login</h2>
    <form action="../LoginServlet" method="post">
        <label for="email">Email:</label>
        <input type="email" name="email" required>

        <label for="password">Password:</label>
        <input type="password" name="password" required>

        <button type="submit">Login</button>
    </form>
    <p>Don't have an account? <a href="register.jsp">Register here</a></p>

    <%
        String error = request.getParameter("error");
        if (error != null) {
    %>
    <div class="error">Invalid email or password.</div>
    <%
        }
    %>
</div>
</body>
</html>
