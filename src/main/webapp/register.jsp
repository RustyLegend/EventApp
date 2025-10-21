<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Register</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; background-color: #121212; color: #e0e0e0; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; padding: 40px 0;">

    <div style="max-width: 400px; width: 100%; padding: 0 20px; box-sizing: border-box;">
        <form action="register" method="post" style="background-color: #1e1e1e; border: 1px solid #333; border-radius: 12px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.3);">
            <h2 style="text-align: center; color: #ffffff; margin-top: 0; margin-bottom: 25px; font-size: 1.8em;">Create Account</h2>

            <div style="margin-bottom: 20px;">
                <label style="color: #aaa; font-size: 0.9em; margin-bottom: 8px; display: block;">Name</label>
                <input type="text" name="name" required style="width: 100%; padding: 12px; background-color: #2a2a2a; border: 1px solid #444; border-radius: 8px; color: #ffffff; font-size: 1em; box-sizing: border-box;">
            </div>

            <div style="margin-bottom: 20px;">
                <label style="color: #aaa; font-size: 0.9em; margin-bottom: 8px; display: block;">Email</label>
                <input type="email" name="email" value="${param.email}" required style="width: 100%; padding: 12px; background-color: #2a2a2a; border: 1px solid #444; border-radius: 8px; color: #ffffff; font-size: 1em; box-sizing: border-box;">
            </div>

            <div style="margin-bottom: 20px;">
                <label style="color: #aaa; font-size: 0.9em; margin-bottom: 8px; display: block;">Password</label>
                <input type="password" name="password" required style="width: 100%; padding: 12px; background-color: #2a2a2a; border: 1px solid #444; border-radius: 8px; color: #ffffff; font-size: 1em; box-sizing: border-box;">
            </div>

            <div style="margin-bottom: 25px;">
                <label style="color: #aaa; font-size: 0.9em; margin-bottom: 8px; display: block;">Role</label>
                <select name="role" style="width: 100%; padding: 12px; background-color: #2a2a2a; border: 1px solid #444; border-radius: 8px; color: #ffffff; font-size: 1em; box-sizing: border-box;">
                    <option value="attendee">Attendee</option>
                    <option value="organizer">Organizer</option>
                </select>
            </div>

            <input type="submit" value="Register" style="width: 100%; padding: 15px; background-color: #f0f0f0; color: #111; border: none; border-radius: 8px; font-size: 1.1em; font-weight: bold; cursor: pointer;">
        </form>

        <p style="text-align: center; margin-top: 20px; color: #aaa;">Already have an account?
            <a href="login.jsp" style="color: #bb86fc; text-decoration: none; font-weight: 500;">Login here</a>
        </p>
        </div>

</body>
</html>