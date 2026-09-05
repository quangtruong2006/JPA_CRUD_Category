package vn.iotstar.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.dao.IProductDao;
import vn.iotstar.entity.Product;

public class ProductDaoImpl implements IProductDao {

    @Override
    public void insert(Product product) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(product);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void update(Product product) {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(product); // Merge dùng để update
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void delete(int productId) throws Exception {
        EntityManager enma = JpaConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            Product product = enma.find(Product.class, productId);
            if (product != null) {
                enma.remove(product);
            } else {
                throw new Exception("Không tìm thấy sản phẩm!");
            }
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public Product findById(int productId) {
        EntityManager enma = JpaConfig.getEntityManager();
        Product product = enma.find(Product.class, productId);
        enma.close();
        return product;
    }

    @Override
    public List<Product> findAll() {
        EntityManager enma = JpaConfig.getEntityManager();
        TypedQuery<Product> query = enma.createQuery("SELECT p FROM Product p", Product.class);
        List<Product> list = query.getResultList();
        enma.close();
        return list;
    }

    @Override
    public List<Product> findAll(int page, int pagesize) {
        EntityManager enma = JpaConfig.getEntityManager();
        TypedQuery<Product> query = enma.createQuery("SELECT p FROM Product p", Product.class);
        query.setFirstResult((page - 1) * pagesize);
        query.setMaxResults(pagesize);
        List<Product> list = query.getResultList();
        enma.close();
        return list;
    }

    @Override
    public int count() {
        EntityManager enma = JpaConfig.getEntityManager();
        String jpql = "SELECT count(p) FROM Product p";
        jakarta.persistence.Query query = enma.createQuery(jpql);
        int count = ((Long) query.getSingleResult()).intValue();
        enma.close();
        return count;
    }
    @Override
    public List<Product> findTop10() {
        EntityManager enma = JpaConfig.getEntityManager();
        // Câu lệnh lấy tất cả, sắp xếp giảm dần theo ID (ID to nhất là mới nhất)
        TypedQuery<Product> query = enma.createQuery("SELECT p FROM Product p ORDER BY p.productId DESC", Product.class);
        query.setMaxResults(10); // Chỉ lấy đúng 10 thằng
        List<Product> list = query.getResultList();
        enma.close();
        return list;
    }
}