<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>About Us</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #002B36, #014421); /* dark green theme */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 30px;
        }

        .container {
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(12px);
            padding: 40px;
            border-radius: 20px;
            max-width: 800px;
            width: 100%;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.25);
            animation: fadeIn 0.6s ease-in-out;
            color: #e8f5e9;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            font-size: 2rem;
            color: #c8e6c9;
        }

        p {
            font-size: 1.1rem;
            line-height: 1.8;
            margin-bottom: 20px;
            color: #dcedc8;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
            }

            h2 {
                font-size: 1.7rem;
            }

            p {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>About Our Library System</h2>
    <p>
        This Library Management System is designed to streamline the process of reserving and managing books 
        for both students and administrators. Developed as part of an academic coursework project, it demonstrates
        a complete Java EE-based web application with authentication, role-based access, reporting, and more.
    </p>
    <p>
        The system is built using JSP, Servlets, JDBC, and MySQL, following the MVC architecture pattern. 
        It reflects real-world practices for handling library operations in an educational institution.
    </p>
</div>
</body>
</html>
