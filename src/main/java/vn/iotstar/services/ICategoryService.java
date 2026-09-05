package vn.iotstar.services; // Đã đổi package

import java.util.List;
import vn.iotstar.entity.Category; // Đã đổi sang package vn.iotstar của ông

public interface ICategoryService {
    void insert(Category category);
    void update(Category category);
    void edit(Category category);
    void delete(int id);
    Category get(int id);
    Category findById(int id);
    Category findByCategoryname(String name);
    List<Category> getAll();
    List<Category> findAll();
    List<Category> search(String keyword);
    List<Category> searchByName(String keyword);
    List<Category> findAll(int page, int pagesize);
    int count();
}