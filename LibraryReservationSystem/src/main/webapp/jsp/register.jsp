<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - Library System</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #002B36, #014421); /* dark green gradient */
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .register-container {
            width: 100%;
            max-width: 450px;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(15px);
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.25);
            color: #ffffff;
        }

        h2 {
            text-align: center;
            color: #e8f5e9;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
            color: #dcedc8;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: none;
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.25);
            color: #ffffff;
            font-size: 14px;
        }

        input::placeholder {
            color: #e0e0e0;
        }

        input:focus {
            outline: 2px solid #66bb6a;
        }

        button {
            margin-top: 25px;
            width: 100%;
            background-color: #1b5e20;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            font-weight: bold;
            transition: background 0.3s ease;
        }

        button:hover {
            background-color: #2e7d32;
        }

        .error, .success {
            margin-top: 15px;
            text-align: center;
            font-weight: bold;
        }

        .error {
            color: #ff6b6b;
        }

        .success {
            color: #a8ff60;
        }

        p {
            text-align: center;
            margin-top: 20px;
            color: #c8e6c9;
        }

        a {
            color: #a5d6a7;
            text-decoration: underline;
        }

        a:hover {
            color: #81c784;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <h2>Create Account</h2>
        <form action="../RegisterServlet" method="post">
            <label for="fullName">Full Name:</label>
            <input type="text" name="fullName" required placeholder="Enter your full name">

            <label for="email">Email:</label>
            <input type="email" name="email" required placeholder="Enter your email">

            <label for="password">Password:</label>
            <input type="password" name="password" required placeholder="Enter your password">

            <button type="submit">Register</button>
        </form>

        <p>
            Already registered?
            <a href="login.jsp">Login here</a>
        </p>

        <% String msg = request.getParameter("msg");
           if ("exists".equals(msg)) { %>
           <div class="error">User already exists!</div>
        <% } else if ("success".equals(msg)) { %>
           <div class="success">Registration successful! Please login.</div>
        <% } %>
    </div>
</body>
</html>
