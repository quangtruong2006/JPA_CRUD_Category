package vn.iotstar.service;
import vn.iotstar.entity.User;

public interface IUserService {
    User findById(int userid);
    void update(User user);
}