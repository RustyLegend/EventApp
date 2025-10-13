<form action="register" method="post">
    <h2>Register</h2>
    <p>Name: <input type="text" name="name" required></p>
    <p>Email: <input type="email" name="email" required></p>
    <p>Password: <input type="password" name="password" required></p>
    <p>Role:
        <select name="role">
            <option value="attendee">Attendee</option>
            <option value="organizer">Organizer</option>
        </select>
    </p>
    <p><input type="submit" value="Register"></p>
</form>