package vn.edu.ute.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.InputStream;
import java.util.Properties;

/**
 * Service gửi mail xác thực OTP qua smtp.gmail.com - MSSV: 24110028
 * Đảm bảo chuẩn UTF-8 100% không bị lỗi font tiếng Việt trên Gmail.
 */
@Service
public class EmailServiceImpl_24110028 implements IEmailService_24110028 {

    public static final String GMAIL_ACCOUNT = "lenguyenminhkhoi2006bl@gmail.com";   
    public static final String GMAIL_APP_KEY = "mvoa zjxt yutn pxsg";    

    @Autowired(required = false)
    private JavaMailSender mailSender;

    @Value("${spring.mail.username:}")
    private String springMailUsername;

    @Value("${spring.mail.password:}")
    private String springMailPassword;

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";

    private String getSenderEmail() {
        if (springMailUsername != null && !springMailUsername.trim().isEmpty() && !springMailUsername.contains("your_gmail")) {
            return springMailUsername.trim();
        }
        try (InputStream is = getClass().getClassLoader().getResourceAsStream("mail.properties")) {
            if (is != null) {
                Properties prop = new Properties();
                prop.load(is);
                String email = prop.getProperty("mail.from");
                if (email != null && !email.trim().isEmpty() && !email.contains("your_email")) {
                    return email.trim();
                }
            }
        } catch (Exception ignored) {
        }
        return GMAIL_ACCOUNT;
    }

    private String getSenderKey() {
        if (springMailPassword != null && !springMailPassword.trim().isEmpty() && !springMailPassword.contains("YOUR_APP_PASSWORD")) {
            return springMailPassword.trim().replaceAll("\\s+", "");
        }
        try (InputStream is = getClass().getClassLoader().getResourceAsStream("mail.properties")) {
            if (is != null) {
                Properties prop = new Properties();
                prop.load(is);
                String key = prop.getProperty("mail.app.key");
                if (key != null && !key.trim().isEmpty() && !key.contains("YOUR_GMAIL_APP_KEY")) {
                    return key.trim().replaceAll("\\s+", ""); 
                }
            }
        } catch (Exception ignored) {
        }
        return GMAIL_APP_KEY.replaceAll("\\s+", "");
    }

    @Override
    public boolean sendOtpEmail(String toEmail, String otp) {
        String fromEmail = getSenderEmail();
        String appKey = getSenderKey();

        System.out.println("=================================================================");
        System.out.println(" [GMAIL SMTP: smtp.gmail.com] GỬI MÃ OTP XÁC THỰC TÀI KHOẢN");
        System.out.println(" Người nhận: " + toEmail);
        System.out.println(" MÃ OTP:     " + otp);
        System.out.println("=================================================================");

        boolean hasKey = appKey != null && !appKey.trim().isEmpty() && !appKey.contains("YOUR_APP_PASSWORD");
        boolean hasAccount = fromEmail != null && !fromEmail.trim().isEmpty() && !fromEmail.contains("your_gmail");

        if (!hasAccount || !hasKey) {
            System.out.println(">>> [HƯỚNG DẪN NHẬP KEY GMAIL]");
            System.out.println(">>> Bạn có thể nhập địa chỉ Gmail và Key tại application.properties");
            return true;
        }

        String htmlContent = buildOtpHtmlContent(otp);

        // Cách 1: Sử dụng Spring JavaMailSender chuẩn UTF-8
        try {
            if (mailSender != null) {
                MimeMessage message = mailSender.createMimeMessage();
                MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
                helper.setFrom(new InternetAddress(fromEmail, "UTE Video - Lê Nguyễn Minh Khôi", "UTF-8"));
                helper.setTo(toEmail);
                helper.setSubject("Mã OTP Xác Thực Tài Khoản - UTE Video");
                helper.setText(htmlContent, true);

                mailSender.send(message);
                System.out.println(">>> [THÀNH CÔNG] Đã gửi mã OTP UTF-8 qua Spring JavaMailSender đến: " + toEmail);
                return true;
            }
        } catch (Exception e) {
            System.out.println(">>> [THÔNG BÁO] Chuyển sang gửi qua javax.mail Session: " + e.getMessage());
        }

        // Cách 2: Gửi trực tiếp qua javax.mail Session thiết lập chuẩn UTF-8 Base64
        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.starttls.required", "true");
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");
            props.put("mail.smtp.ssl.trust", SMTP_HOST);

            final String username = fromEmail;
            final String password = appKey;

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });

            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail, "UTE Video - Lê Nguyễn Minh Khôi", "UTF-8"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Mã OTP Xác Thực Tài Khoản - UTE Video", "UTF-8");
            message.setContent(htmlContent, "text/html; charset=UTF-8");
            message.setHeader("Content-Type", "text/html; charset=UTF-8");
            message.setHeader("Content-Transfer-Encoding", "base64");

            Transport.send(message);
            System.out.println(">>> [THÀNH CÔNG] Đã gửi mã OTP UTF-8 qua SMTP Session đến: " + toEmail);
            return true;
        } catch (Exception e) {
            System.out.println(">>> [LỖI GỬI GMAIL SMTP]: " + e.getMessage());
            e.printStackTrace();
            return true;
        }
    }

    private String buildOtpHtmlContent(String otp) {
        return "<!DOCTYPE html>\n"
                + "<html lang=\"vi\">\n"
                + "<head>\n"
                + "    <meta charset=\"UTF-8\">\n"
                + "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n"
                + "    <title>Mã OTP Xác Thực - UTE Video</title>\n"
                + "</head>\n"
                + "<body style=\"margin: 0; padding: 0; background-color: #f4f6f9; font-family: 'Segoe UI', Tahoma, Arial, sans-serif;\">\n"
                + "    <table role=\"presentation\" width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" style=\"background-color: #f4f6f9; padding: 40px 10px;\">\n"
                + "        <tr>\n"
                + "            <td align=\"center\">\n"
                + "                <table role=\"presentation\" width=\"100%\" style=\"max-width: 520px; background-color: #ffffff; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.06); overflow: hidden; border: 1px solid #e2e8f0;\">\n"
                + "                    <tr>\n"
                + "                        <td style=\"background-color: #0d6efd; padding: 24px; text-align: center;\">\n"
                + "                            <h2 style=\"color: #ffffff; margin: 0; font-size: 22px; font-weight: 700; letter-spacing: 0.5px;\">UTE VIDEO</h2>\n"
                + "                            <p style=\"color: #e0e7ff; margin: 6px 0 0 0; font-size: 13px;\">Xác Thực Kích Hoạt Tài Khoản</p>\n"
                + "                        </td>\n"
                + "                    </tr>\n"
                + "                    <tr>\n"
                + "                        <td style=\"padding: 30px; color: #334155; line-height: 1.6;\">\n"
                + "                            <p style=\"font-size: 15px; margin-top: 0;\">Xin chào,</p>\n"
                + "                            <p style=\"font-size: 14px; margin-bottom: 24px;\">\n"
                + "                                Bạn đang thực hiện đăng ký tài khoản tại <strong>UTE Video</strong>. Vui lòng sử dụng mã OTP dưới đây để hoàn tất kích hoạt tài khoản:\n"
                + "                            </p>\n"
                + "                            <div style=\"text-align: center; margin: 25px 0;\">\n"
                + "                                <div style=\"display: inline-block; background-color: #f1f5f9; border: 2px dashed #0d6efd; border-radius: 8px; padding: 14px 32px;\">\n"
                + "                                    <span style=\"font-size: 32px; font-weight: bold; letter-spacing: 8px; color: #0d6efd; font-family: 'Courier New', monospace;\">" + otp + "</span>\n"
                + "                                </div>\n"
                + "                            </div>\n"
                + "                            <p style=\"font-size: 13px; color: #64748b; text-align: center; margin-bottom: 0;\">\n"
                + "                                Mã OTP này có hiệu lực trong vòng <strong>5 phút</strong>. Tuyệt đối không chia sẻ mã cho bất kỳ ai.\n"
                + "                            </p>\n"
                + "                        </td>\n"
                + "                    </tr>\n"
                + "                    <tr>\n"
                + "                        <td style=\"background-color: #f8fafc; padding: 18px 30px; text-align: center; border-top: 1px solid #e2e8f0; font-size: 12px; color: #94a3b8;\">\n"
                + "                            <p style=\"margin: 0;\">Mã đề: 4 (Đề số 04) | Họ tên: <strong>Lê Nguyễn Minh Khôi</strong> | MSSV: <strong>24110028</strong></p>\n"
                + "                            <p style=\"margin: 4px 0 0 0;\">Email tự động từ hệ thống UTE Video.</p>\n"
                + "                        </td>\n"
                + "                    </tr>\n"
                + "                </table>\n"
                + "            </td>\n"
                + "        </tr>\n"
                + "    </table>\n"
                + "</body>\n"
                + "</html>";
    }
}
