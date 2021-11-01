package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.bean.Contacts;
import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Map;

//联系人业务接口
public interface ContactsService {

    //查询所有，带分页，带模糊查询
    PageInfo<Contacts> queryAllContacts(Integer page, Integer pageSize, Contacts customer);

    //单个删除与批量删除
    ResultVo delContacts(String ids);

    //根据客户id查询联系人
    List<Contacts> getContactsByCustomerId(String id);

    //根据id查询联系人
    Contacts queryContactsById(String id);

    //修改联系人
    ResultVo editContacts(Contacts contacts, User user);

    //客户名称自动补全
    List<String> queryContactsName(String contactsName);

    //添加联系人
    void addContacts(Contacts contacts, User user);

    //详情页
    Map<String, Object> detailAll(String id);

    //删除交易
    void deleteContactsTran(String id);

    void deleteContactsActivity(String activityId);

    List<Activity> searchContactsActivity(String activityName,String contactsId);

    //联系人关联市场活动
    ResultVo relationActivity(String activityIds, String contactsId);

    //添加备注
    ResultVo addRemark(String noteContent, String contactsId, User user);

    //删除
    void deleteRemark(String remarkId);
}
