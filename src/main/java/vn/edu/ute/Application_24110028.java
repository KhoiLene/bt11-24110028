package vn.edu.ute;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

/**
 * Lớp khởi chạy chính của ứng dụng Spring Boot - BTKTC4 Đề số 04
 * Sinh viên: Lê Nguyễn Minh Khôi - MSSV: 24110028 - Mã đề: 4
 */
@SpringBootApplication
public class Application_24110028 extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(Application_24110028.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(Application_24110028.class, args);
        System.out.println("==================================================================");
        System.out.println("  BTKTC4 - Spring Boot Web Application Started Successfully!");
        System.out.println("  Họ tên : Lê Nguyễn Minh Khôi | MSSV: 24110028 | Mã đề: 4");
        System.out.println("  Trang chủ: http://localhost:8080/");
        System.out.println("  Admin: http://localhost:8080/admin/users");
        System.out.println("==================================================================");
    }
}
