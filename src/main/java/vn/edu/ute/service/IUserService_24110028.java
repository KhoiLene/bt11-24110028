package vn.edu.ute.service;

import vn.edu.ute.model.User_24110028;
import java.util.List;

public interface IUserService_24110028 {
    User_24110028 login(String username, String password);
    boolean register(User_24110028 user);
    boolean activateUser(String username);
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);

    // Câu 3: CRUD và phân trang 6 users / trang
    List<User_24110028> findWithPagination(int page, int pageSize);
    int countTotalUsers();
    int getTotalPages(int pageSize);
    User_24110028 findByUsername(String username);
    boolean create(User_24110028 user);
    boolean update(User_24110028 user);
    boolean delete(String username);
}
