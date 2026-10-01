package vn.edu.ute.dao;

import vn.edu.ute.model.Category_24110028;
import vn.edu.ute.model.CategoryDTO_24110028;
import java.util.List;

public interface ICategoryDAO_24110028 {
    List<Category_24110028> findAll();
    Category_24110028 findById(int id);
    List<CategoryDTO_24110028> findAllWithVideoCount();
    int countVideosByCategoryId(int categoryId);
    boolean insert(Category_24110028 category);
    boolean update(Category_24110028 category);
    boolean delete(int id);
}
