package com.bjpowernode.crm.cache;

import com.bjpowernode.crm.base.bean.DicType;
import com.bjpowernode.crm.base.bean.DicValue;
import com.bjpowernode.crm.base.mapper.DicTypeMapper;
import com.bjpowernode.crm.base.mapper.DicValueMapper;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import tk.mybatis.mapper.entity.Example;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import java.util.*;

/**
 * @author dxt
 * @date 2021年07月13日 14:08
 */
@Component
public class CrmCache {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ServletContext servletContext;

    @Autowired
    private DicTypeMapper dicTypeMapper;

    @Autowired
    private DicValueMapper dicValueMapper;

    @PostConstruct
    public void init(){
        //所有者查询出来
        List<User> userList = userMapper.selectAll();
        servletContext.setAttribute("users", userList);
        //查询所有字典类型
        HashMap<String, List<DicValue>> map = new HashMap<>();
        List<DicType> dicTypes = dicTypeMapper.selectAll();
        for (DicType dicType : dicTypes) {
            DicValue dicValue = new DicValue();
            String typeCode = dicType.getCode();
            dicValue.setTypeCode(typeCode);
            Example example = new Example(DicValue.class);
            example.setOrderByClause("orderNo");
            example.createCriteria().andEqualTo("typeCode", typeCode);
            List<DicValue> dicValueList = dicValueMapper.selectByExample(example);
            map.put(typeCode, dicValueList);
        }

        //加载属性配置文件到缓存
        ResourceBundle bundle = ResourceBundle.getBundle("mybatis.Stage2Possibility");
        Enumeration<String> keys = bundle.getKeys();
        Map<String,String> stage2Possibility = new TreeMap<>();
        while (keys.hasMoreElements()){
            String key = keys.nextElement();
            String value = bundle.getString(key);
            stage2Possibility.put(key, value);
        }

        servletContext.setAttribute("stage2Possibility",stage2Possibility);
        servletContext.setAttribute("map",map);
        servletContext.setAttribute("dictype",dicTypes);


    }

}
