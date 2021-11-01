package com.bjpowernode.crm.settings.mapper;

import com.bjpowernode.crm.settings.bean.User;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * @author Dxt
 * @date 2021/7/3 - 14:49
 */
public interface UserMapper extends Mapper<User> {

    User selectOneByID(String id);

    int updatePwdAndImg(User user);

    //根据 owner 模糊查询 user的id
    List<String> selectUserLikeName(String owner);
}
