package com.bjpowernode.crm.settings.service.impl;

import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.utils.DateTimeUtil;
import com.bjpowernode.crm.base.utils.MD5Util;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * @author Dxt
 * @date 2021/7/3 - 14:48
 * 用户业务类
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    /**
     * 测试获取所有用户
     *
     * @return
     */
    @Override
    public List<User> getAllUser() {
        return null;
    }

    /**
     * 验证登陆
     * @param user
     * @return
     */
    @Override
    public User login(User user) {

        String allowIps = user.getAllowIps();
        //对用户输入的密码进行加密
        user.setLoginPwd(MD5Util.getMD5(user.getLoginPwd()));
        user.setAllowIps(null);
        user = userMapper.selectOne(user);
        //检验账号是否存在
        if (user == null) {
            throw new CrmException(CrmEnum.USER_LOGIN_ACCOUNT);
        }
        //校验账号是否失效
        String expireTime = user.getExpireTime();
        String nowTime = DateTimeUtil.getSysTime();
        if (nowTime.compareTo(expireTime) > 0) {
            throw new CrmException(CrmEnum.USER_LOGIN_EXPIRE);
        }
        //校验账号是否被锁定
        if ("0".equals(user.getLockState())) {
            throw new CrmException(CrmEnum.USER_LOGIN_LOCKED);
        }
        //校验ip地址allowIps
        if (!user.getAllowIps().contains(allowIps)) {
            throw new CrmException(CrmEnum.USER_LOGIN_ALLOWIP);
        }
        return user;
    }

    /**
     * 更新密码与图片
     * @param user
     */
    @Override
    public void updatePwdAndImg(User user) {
        user.setLoginPwd(MD5Util.getMD5(user.getLoginPwd()));
        int count = 0;
        count = userMapper.updatePwdAndImg(user);
        if(count == 0){
            throw new CrmException(CrmEnum.USER_UPLOAD_UPDATEPWD);
        }

    }
}
