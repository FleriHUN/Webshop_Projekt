package config.email;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class EmailSender {

    public void sendVCodeForPasswordReset(String toEmail, String vCode) {

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
