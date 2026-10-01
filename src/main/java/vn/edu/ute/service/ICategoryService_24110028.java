package vn.edu.ute.service;

import vn.edu.ute.model.Category_24110028;
import vn.edu.ute.model.CategoryDTO_24110028;
import java.util.List;

public interface ICategoryService_24110028 {
    List<Category_24110028> findAll();
    Category_24110028 findById(int id);
    List<CategoryDTO_24110028> findAllWithVideoCount(); // Câu 6
    int countVideosByCategoryId(int categoryId);
}
