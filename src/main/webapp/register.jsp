<form action="register" method="post" style="max-width: 400px; margin: 50px auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); font-family: Arial, sans-serif; background-color: #ffffff;">
    <h2 style="text-align: center; color: #333; margin-bottom: 25px;">Register</h2>
    <p style="margin-bottom: 15px; color: #555;">Name: 
        <input type="text" name="name" required style="width: 100%; padding: 10px; margin-top: 5px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 5px;">
    </p>
    <p style="margin-bottom: 15px; color: #555;">Email: 
        <input type="email" name="email" required style="width: 100%; padding: 10px; margin-top: 5px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 5px;">
    </p>
    <p style="margin-bottom: 20px; color: #555;">Password: 
        <input type="password" name="password" required style="width: 100%; padding: 10px; margin-top: 5px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 5px;">
    </p>
    <p style="margin-bottom: 20px; color: #555;">Role:
        <select name="role" style="width: 100%; padding: 10px; margin-top: 5px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 5px;">
            <option value="attendee">Attendee</option>
            <option value="organizer">Organizer</option>
        </select>
    </p>
    <p>
        <input type="submit" value="Register" style="width: 100%; padding: 12px; background-color: #28a745; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px;">
    </p>
</form>