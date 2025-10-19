<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Login</title>
</head>
<body style="font-family: Arial, sans-serif; background-color: #f4f4f9;">

<form action="login" method="post" style="max-width: 400px; margin: 50px auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); font-family: Arial, sans-serif; background-color: #ffffff;">
    <h2 style="text-align: center; color: #333; margin-bottom: 15px;">Login</h2>

    <c:if test="${not empty errorMessage}">
        <p style="color: red; text-align: center; background-color: #ffebee; padding: 10px; border-radius: 5px; border: 1px solid #e57373;">
            ${errorMessage}
        </p>
    </c:if>
    <p style="margin-bottom: 15px; color: #555;">Email:
        <input type="email" name="email" style="width: 100%; padding: 10px; margin-top: 5px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 5px;">
    </p>
    <p style="margin-bottom: 20px; color: #555;">Password:
        <input type="password" name="password" style="width: 100%; padding: 10px; margin-top: 5px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 5px;">
    </p>
    <p>
        <input type="submit" value="Login" style="width: 100%; padding: 12px; background-color: #007BFF; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px;">
    </p>
</form>
<p style="text-align: center; font-family: Arial, sans-serif; color: #555;">Don't have an account?
    <a href="register.jsp" style="color: #007BFF; text-decoration: none;">Register here</a>
</p>

</body>
</html>