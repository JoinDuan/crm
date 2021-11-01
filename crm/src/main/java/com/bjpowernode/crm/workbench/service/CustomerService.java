package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.workbench.bean.Contacts;
import com.bjpowernode.crm.workbench.bean.Customer;
import com.bjpowernode.crm.workbench.bean.CustomerRemark;
import com.bjpowernode.crm.settings.bean.User;
import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Map;

/**
 * @author Dxt
 * @date 2021/7/10 - 9:06
 * 客户业务类接口
 */
public interface CustomerService {

    //查询 customer，带模糊查询带分页
    PageInfo<Customer> queryAllCustomer(Integer page, Integer pageSize,Customer customer);

    //查询所有所有者
    List<User> queryAllOwner();

    //添加customer
    ResultVo<Customer> addCustomer(Customer customer, User user);

    //查询单个customer
    Customer queryCustomerById(String id, User user);

    //修改customer
    void editCustomer(Customer customer, User user);
    //删除customer
    void delCustomer(String ids);

    //查询customer与备注
    Map<String, Object> queryAllRemark(String id);

    //修改客户备注
    void editRemark(CustomerRemark customerRemark, User user);

    //新增客户备注
    ResultVo<CustomerRemark> addRemark(CustomerRemark customerRemark, User user);

    //删除客户备注
    ResultVo<CustomerRemark> delRemark(String id);

    //添加联系人
    void addContacts(Contacts contacts, User user);

    //查询customer的交易信息
    Map<String, Object> queryAllTran(String id);

    //删除交易
    void deleteTran(String id);
}
