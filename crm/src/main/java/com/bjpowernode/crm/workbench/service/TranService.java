package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.bean.Contacts;
import com.bjpowernode.crm.workbench.bean.Tran;
import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Map;

public interface TranService {

    //查询交易列表，带分页带模糊查询
    PageInfo queryAllTransaction(Integer page, Integer pageSize, Tran tran);

    //查找市场活动源
    List<Activity> queryAllActivity(String name);

    //查找联系人
    List<Contacts> queryContacts(String name);

    //查找客户,名称与id
    Map<String,List<String>> queryCustomerName(String customerName);

    //保存交易
    ResultVo saveTran(Tran tran, User user);

    //删除交易
    ResultVo deleteTran(String ids);

    //交易详情页
    Tran queryTransactionDetail(String id);

    //根据id查单条
    Tran selectTranById(String id);

    //修改交易
    ResultVo editTran(Tran tran, User user, String activityName, String contactsName);


    //获取当前阶段的所有图标,点击图标修改交易阶段图标
    Map<String,Object> queryStages(String id, Map<String, String> stage2Possibility, Integer index, User user);

}
