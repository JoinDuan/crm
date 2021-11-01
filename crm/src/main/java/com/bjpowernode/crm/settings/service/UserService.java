package com.bjpowernode.crm.settings.service;

import com.bjpowernode.crm.settings.bean.User;

import java.util.List;

/**
 * @author Dxt
 * @date 2021/7/3 - 14:47
 */
public interface UserService {
    List<User> getAllUser();

    //验证登录
    User login(User user);

    /**
     * 更新密码 与 图片
     * @param user
     */
    void updatePwdAndImg(User user);
}
