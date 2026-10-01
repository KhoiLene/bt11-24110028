package vn.edu.ute.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.edu.ute.dao.IUserDAO_24110028;
import vn.edu.ute.model.User_24110028;

import java.util.List;

@Service
public class UserServiceImpl_24110028 implements IUserService_24110028 {

    private final IUserDAO_24110028 userDAO;

    @Autowired
    public UserServiceImpl_24110028(IUserDAO_24110028 userDAO) {
        this.userDAO = userDAO;
    }

    @Override
    public User_24110028 login(String username, String password) {
        User_24110028 user = userDAO.findByUsernameAndPassword(username, password);
        if (user != null && user.isActive()) {
            return user;
        }
        return null;
    }

    @Override
    public boolean register(User_24110028 user) {
        user.setActive(false);
        user.setAdmin(false);
        if (user.getImages() == null || user.getImages().trim().isEmpty()) {
            user.setImages("https://i.pravatar.cc/150?u=" + user.getUsername());
        }
        return userDAO.insert(user);
    }

    @Override
    public boolean activateUser(String username) {
        return userDAO.activateUser(username);
    }

    @Override
    public boolean existsByUsername(String username) {
        return userDAO.existsByUsername(username);
    }

    @Override
    public boolean existsByEmail(String email) {
        return userDAO.existsByEmail(email);
    }

    @Override
    public List<User_24110028> findWithPagination(int page, int pageSize) {
        if (page < 1) page = 1;
        return userDAO.findWithPagination(page, pageSize);
    }

    @Override
    public int countTotalUsers() {
        return userDAO.countTotalUsers();
    }

    @Override
    public int getTotalPages(int pageSize) {
        int total = userDAO.countTotalUsers();
        return (int) Math.ceil((double) total / pageSize);
    }

    @Override
    public User_24110028 findByUsername(String username) {
        return userDAO.findByUsername(username);
    }

    @Override
    public boolean create(User_24110028 user) {
        if (userDAO.existsByUsername(user.getUsername())) {
            return false;
        }
        if (user.getImages() == null || user.getImages().trim().isEmpty()) {
            user.setImages("https://i.pravatar.cc/150?u=" + user.getUsername());
        }
        return userDAO.insert(user);
    }

    @Override
    public boolean update(User_24110028 user) {
        return userDAO.update(user);
    }

    @Override
    public boolean delete(String username) {
        return userDAO.delete(username);
    }
}
