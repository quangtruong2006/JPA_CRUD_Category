package vn.iotstar.dao;
import vn.iotstar.entity.User;

public interface IUserDao {
    User findById(int userid);
    void update(User user);
}