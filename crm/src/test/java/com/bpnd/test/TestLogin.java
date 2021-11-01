package com.bpnd.test;

import cn.hutool.core.date.DateTime;
import com.bjpowernode.crm.base.utils.DateTimeUtil;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

/**
 * @author Dxt
 * @date 2021/7/3 - 14:53
 */
public class TestLogin {

    ApplicationContext beanFactory = new ClassPathXmlApplicationContext("spring/applicationContext.xml");
    UserMapper userMapper = (UserMapper) beanFactory.getBean("userMapper");

    @Test
    public void test01(){
        List<User> users = userMapper.selectAll();
        System.out.println(users);
    }

    @Test
    public void test02(){
        String sysTime = DateTimeUtil.getSysTime();
        String noldtime = "1973-04-25 00:00:00";
        System.out.println(sysTime.compareTo(noldtime));

    }
    @Test
    public void test03(){
        System.out.println(DateTime.now().toString());
    }


}
