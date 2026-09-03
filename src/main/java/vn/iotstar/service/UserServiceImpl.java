package vn.iotstar.service;

import vn.iotstar.dao.IUserDao;
import vn.iotstar.dao.UserDao;
import vn.iotstar.entity.User;

public class UserServiceImpl implements IUserService {
    public IUserDao userDao = new UserDao();

    @Override
    public User findById(int userid) {
        return userDao.findById(userid);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }
}