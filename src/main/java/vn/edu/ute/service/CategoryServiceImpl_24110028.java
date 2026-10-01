package vn.edu.ute.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.edu.ute.dao.ICategoryDAO_24110028;
import vn.edu.ute.model.Category_24110028;
import vn.edu.ute.model.CategoryDTO_24110028;

import java.util.List;

@Service
public class CategoryServiceImpl_24110028 implements ICategoryService_24110028 {

    private final ICategoryDAO_24110028 categoryDAO;

    @Autowired
    public CategoryServiceImpl_24110028(ICategoryDAO_24110028 categoryDAO) {
        this.categoryDAO = categoryDAO;
    }

    @Override
    public List<Category_24110028> findAll() {
        return categoryDAO.findAll();
    }

    @Override
    public Category_24110028 findById(int id) {
        return categoryDAO.findById(id);
    }

    @Override
    public List<CategoryDTO_24110028> findAllWithVideoCount() {
        return categoryDAO.findAllWithVideoCount();
    }

    @Override
    public int countVideosByCategoryId(int categoryId) {
        return categoryDAO.countVideosByCategoryId(categoryId);
    }
}
