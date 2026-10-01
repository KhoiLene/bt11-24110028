package vn.edu.ute.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Quản lý kết nối Cơ sở dữ liệu SQL Server - MSSV: 24110028
 * Hỗ trợ cả Spring DataSource tự động và JDBC Driver trực tiếp.
 */
@Component
public class DBContext_24110028 {

    private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static final String HOST = "localhost";
    private static final int PORT = 1433;
    private static final String DATABASE_NAME = "WebDB";

    // URL cho Windows Authentication
    private static final String WIN_AUTH_URL = "jdbc:sqlserver://" + HOST + ":" + PORT 
            + ";databaseName=" + DATABASE_NAME 
            + ";integratedSecurity=true;trustServerCertificate=true;";

    // URL và tài khoản dự phòng cho SQL Authentication
    private static final String SQL_AUTH_URL = "jdbc:sqlserver://" + HOST + ":" + PORT 
            + ";databaseName=" + DATABASE_NAME 
            + ";trustServerCertificate=true;";
    private static final String USER = "sa";
    private static final String PASS = "123";

    private static DataSource staticDataSource;

    @Autowired(required = false)
    private DataSource dataSource;

    @PostConstruct
    public void init() {
        if (dataSource != null) {
            staticDataSource = dataSource;
        }
    }

    public static Connection getConnection() throws SQLException {
        if (staticDataSource != null) {
            try {
                return staticDataSource.getConnection();
            } catch (SQLException e) {
                // Fallback to direct driver if DataSource fails
            }
        }

        // Ưu tiên Windows Authentication
        try {
            Class.forName(DRIVER);
            return DriverManager.getConnection(WIN_AUTH_URL);
        } catch (Exception e) {
            // Nếu dùng SQL Server Authentication
            return DriverManager.getConnection(SQL_AUTH_URL, USER, PASS);
        }
    }

    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
