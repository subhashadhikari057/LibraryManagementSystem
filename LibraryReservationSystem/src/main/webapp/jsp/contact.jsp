<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact Us - Library System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #002B36, #014421); /* dark green theme */
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px;
        }

        .container {
            max-width: 900px;
            width: 100%;
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(12px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.25);
            animation: fadeIn 0.7s ease-in-out;
            color: #e8f5e9;
        }

        h2 {
            text-align: center;
            font-size: 28px;
            margin-bottom: 30px;
            color: #c8e6c9;
        }

        .section {
            margin-bottom: 30px;
        }

        .section h3 {
            font-size: 20px;
            margin-bottom: 10px;
            color: #a5d6a7;
        }

        .section p {
            line-height: 1.8;
            font-size: 15px;
            color: #dcedc8;
        }

        .faq {
            margin-top: 20px;
        }

        .faq h4 {
            margin-bottom: 5px;
            font-size: 16px;
            color: #b2fab4;
        }

        .faq p {
            margin-bottom: 15px;
            font-size: 14px;
            color: #e0f2f1;
        }

        .highlight {
            font-weight: bold;
            color: #ffffff;
        }

        a {
            color: #c5e1a5;
            text-decoration: underline;
        }

        a:hover {
            color: #ffffff;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Contact Information</h2>

    <div class="section">
        <h3>Main Department</h3>
        <p>
            <span class="highlight">Library & Information Services</span><br>
            Islington College<br>
            Kamal Pokhari, Kathmandu, Nepal<br>
            P.O. Box 12345
        </p>
    </div>

    <div class="section">
        <h3>Support & Helpline</h3>
        <p>
            Email: <a href="mailto:support@librarysystem.com">support@librarysystem.com</a><br>
            Helpline: +977-1-5551234<br>
            WhatsApp: +977-9812345678
        </p>
    </div>

    <div class="section">
        <h3>Office Hours</h3>
        <p>
            Sunday – Friday: 9:00 AM – 5:00 PM<br>
            Saturday: Closed
        </p>
    </div>

    <div class="section">
        <h3>Frequently Asked Questions (FAQ)</h3>
        <div class="faq">
            <h4>How long can I keep a reserved book?</h4>
            <p>All reserved books must be returned within 7 days. Overdue books may lead to penalties.</p>

            <h4>Is there any fine for late returns?</h4>
            <p>Yes, failure to return books on time may result in a temporary suspension of your borrowing privileges.</p>

            <h4>Can I reserve multiple books at once?</h4>
            <p>Yes, you can reserve multiple books if they are in stock. However, you cannot reserve the same book twice without returning the first copy.</p>

            <h4>Where can I return books?</h4>
            <p>Books must be returned to the main library desk during working hours.</p>
        </div>
    </div>
</div>
</body>
</html>
