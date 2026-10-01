package vn.edu.ute.dao;

import vn.edu.ute.model.User_24110028;
import java.util.List;

public interface IUserDAO_24110028 {
    User_24110028 findByUsername(String username);
    User_24110028 findByUsernameAndPassword(String username, String password);
    boolean insert(User_24110028 user);
    boolean update(User_24110028 user);
    boolean delete(String username);
    boolean activateUser(String username);
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);
    
    // Câu 3: CRUD và phân trang 6 users / trang
    List<User_24110028> findAll();
    List<User_24110028> findWithPagination(int page, int pageSize);
    int countTotalUsers();
}
