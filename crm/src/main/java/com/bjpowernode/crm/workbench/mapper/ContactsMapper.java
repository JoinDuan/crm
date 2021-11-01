package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.bean.Contacts;
import com.bjpowernode.crm.workbench.bean.Customer;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

//联系人dao接口
public interface ContactsMapper extends Mapper<Contacts> {

    //查询Contacts+模糊查询+分页
    List<Contacts> selectAllContactsAndLike(Contacts contacts);
    //根据客户id查询联系人
    List<Contacts> selectContactsByCustomerId(String id);

    //查找联系人-根据名称
    List<Contacts> selectLikeName(String name);

    Contacts selectByName(String contactsName);

    //根据联系人id查询详细信息
    Contacts selectOneContactsById(String id);

    //客户名称自动补全
    List<Customer> selectContactsAllName(String contactsName);
}
