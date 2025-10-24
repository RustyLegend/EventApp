// In com/eventmanager/util/EmailService.java

package com.eventmanager.util;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailService {

    // IMPORTANT: Use an "App Password" from your Google Account, not your regular password.
    private static final String SENDER_EMAIL = "theeventhubmail@gmail.com";
    private static final String SENDER_PASSWORD = "fubhbeexpvbsznwh";

    public static void sendVerificationEmail(String name, String toEmail, String token) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Welcome to EventApp! Please Verify Your Email");

            String verificationLink = "https://overdefiant-somberly-izabella.ngrok-free.dev/EventApp/verify?token=" + token;
            
            String emailBody = "<html>" +
                               "<body style='font-family: Arial, sans-serif; line-height: 1.6; color: #333;'>" +
                               "<h2>Hi " + name + ",</h2>" +
                               "<p>Welcome to EventApp! We're excited to have you on board.</p>" +
                               "<p>To finish setting up your account, please click the big button below:</p>" +
                               
                               "" +
                               "<p style='margin: 25px 0;'>" +
                               "  <a href='" + verificationLink + "' " +
                               "     style='background-color: #007bff; color: white; padding: 12px 20px; text-decoration: none; border-radius: 5px; font-weight: bold;'>" +
                               "     Verify My Email Address" +
                               "  </a>" +
                               "</p>" +
                               
                               "<p>If you didn't create this account, you can safely ignore this email.</p>" +
                               "<br>" +
                               "<p>- The EventApp Team</p>" +
                               "</body>" +
                               "</html>";
            
            message.setContent(emailBody, "text/html; charset=utf-8");

            Transport.send(message);
            System.out.println("Verification email sent to " + toEmail);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    public static void sendEmail(String toEmail, String subject, String body) {
    // 1. Setup mail server properties (same as your other method)
    Properties props = new Properties();
    props.put("mail.smtp.host", "smtp.gmail.com");
    props.put("mail.smtp.port", "587");
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");

    // 2. Get the session (same as your other method)
    Session session = Session.getInstance(props, new Authenticator() {
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
        }
    });

    try {
        // 3. Create and send the message
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(SENDER_EMAIL));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(subject);
        message.setContent(body, "text/html; charset=utf-8");

        Transport.send(message);
        System.out.println("Email sent to " + toEmail);

    } catch (MessagingException e) {
        e.printStackTrace();
    }
}
}