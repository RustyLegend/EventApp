<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; background-color: #121212; color: #e0e0e0; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0;">

    <div style="max-width: 400px; width: 100%; padding: 0 20px;">
        <form action="login" method="post" style="background-color: #1e1e1e; border: 1px solid #333; border-radius: 12px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.3);">
            <h2 style="text-align: center; color: #ffffff; margin-top: 0; margin-bottom: 25px; font-size: 1.8em;">Login</h2>

            <c:if test="${not empty errorMessage}">
                <p style="color: #ff8a80; text-align: center; background-color: rgba(255, 138, 128, 0.1); padding: 10px; border-radius: 8px; border: 1px solid #ff8a80; margin-bottom: 20px;">
                    ${errorMessage}
                </p>
            </c:if>

            <div style="margin-bottom: 20px;">
                <label style="color: #aaa; font-size: 0.9em; margin-bottom: 8px; display: block;">Email</label>
                <input type="email" name="email" required style="width: 100%; padding: 12px; background-color: #2a2a2a; border: 1px solid #444; border-radius: 8px; color: #ffffff; font-size: 1em; box-sizing: border-box;">
            </div>

            <div style="margin-bottom: 25px;">
                <label style="color: #aaa; font-size: 0.9em; margin-bottom: 8px; display: block;">Password</label>
                <input type="password" name="password" required style="width: 100%; padding: 12px; background-color: #2a2a2a; border: 1px solid #444; border-radius: 8px; color: #ffffff; font-size: 1em; box-sizing: border-box;">
            </div>

            <input type="submit" value="Login" style="width: 100%; padding: 15px; background-color: #f0f0f0; color: #111; border: none; border-radius: 8px; font-size: 1.1em; font-weight: bold; cursor: pointer;">
        </form>

        <p style="text-align: center; margin-top: 20px; color: #aaa;">Don't have an account?
            <a href="register.jsp" style="color: #bb86fc; text-decoration: none; font-weight: 500;">Register here</a>
        </p>
    </div>

</body>
</html>