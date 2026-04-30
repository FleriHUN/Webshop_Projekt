package com.example.furnitureStore.config.email;

import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class EmailSender {

    private final JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String fromEmail;
    
    public void sendVCodeForPasswordReset(String toEmail, String vCode) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom(fromEmail, "FormaLux");
            helper.setTo(toEmail);
            helper.setSubject("FormaLux - Jelszó visszaállítás");
            helper.setText(buildPasswordResetEmail(vCode), true);

            mailSender.send(message);
        } catch (Exception e) {
            throw new RuntimeException("Failed to send password reset email", e);
        }
    }

    private String buildPasswordResetEmail(String vCode) {
        return """
            <!DOCTYPE html>
            <html lang="hu">
            <head><meta charset="UTF-8"><title>Jelszó visszaállítás</title></head>
            <body style="font-family: Arial, sans-serif; background-color: #F7F2EE; padding: 30px; margin: 0;">
              <div style="max-width: 500px; margin: 0 auto; background-color: #B8A999; border-radius: 12px; padding: 30px;">
                <h1 style="color: #F7F2EE; text-align: center; margin: 0 0 10px 0;">FormaLux</h1>
                <h2 style="color: #F7F2EE; text-align: center; margin: 0 0 20px 0; font-weight: normal;">Jelszó visszaállítás</h2>
                <p style="color: #F7F2EE;">Kedves Felhasználó!</p>
                <p style="color: #F7F2EE;">A jelszó visszaállításához használd az alábbi ellenőrző kódot:</p>
                <div style="background-color: #8A6F58; color: #F7F2EE; padding: 20px; text-align: center; border-radius: 8px; font-size: 22px; font-weight: bold; letter-spacing: 2px; font-family: monospace; margin: 20px 0; word-break: break-all;">
                  %s
                </div>
                <p style="color: #F7F2EE; font-size: 14px;">Ha nem te kérted ezt a kódot, kérjük hagyd figyelmen kívül ezt az e-mailt.</p>
                <p style="color: #F7F2EE; font-size: 14px; margin-bottom: 0;">Üdvözlettel,<br>A FormaLux csapata</p>
              </div>
            </body>
            </html>
            """.formatted(vCode);
    }

    public void sendEmailAboutCancelledOrder(String toEmail) {
    }

    public void sendEmailAboutRegistration(String toEmail) {
    }

    public void sendEmailAboutOrder(String toEmail) {
    }

    public void sendEmailAboutOrderWithVCode(String toEmail, String vCode) {
    }
}
