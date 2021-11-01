package com.bjpowernode.crm.workbench.controller;

import cn.hutool.core.map.MapUtil;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.utils.CommonUtil;
import com.bjpowernode.crm.workbench.bean.Contacts;
import com.bjpowernode.crm.workbench.bean.Customer;
import com.bjpowernode.crm.workbench.bean.CustomerRemark;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.service.CustomerService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;

/**
 * @author Dxt
 * @date 2021/7/10 - 9:06
 * 客户控制器类
 */
@RestController
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    /**
     * 查询 customer，带模糊查询带分页
     *
     * @param page     页码
     * @param pageSize 每页显示的数量
     * @return 查询结果集
     */
    @GetMapping(value = "/workbench/customer/queryAllCustomer")
    public PageInfo<Customer> queryAllCustomer(Integer page,Integer pageSize,Customer customer) {
        PageInfo<Customer> pageInfo = customerService.queryAllCustomer(page, pageSize,customer);
        return pageInfo;
    }

    //查询所有所有者
    @GetMapping(value = "/workbench/consumer/queryAllOwner")
    public List<User> queryAllOwner() {
        List<User> users = new CopyOnWriteArrayList<>();
        users = customerService.queryAllOwner();
        return users;
    }

    //新增customer
    @PostMapping(value = "/workbench/consumer/addCustomer")
    public ResultVo<Customer> addCustomer(Customer customer, HttpSession session) {
        ResultVo<Customer> resultVo = new ResultVo<>();
        try {
            User user = CommonUtil.getCurrentUser(session);
            resultVo = customerService.addCustomer(customer, user);
            resultVo.setOk(true);
        } catch (CrmException c) {
            resultVo.setMessage(c.getMessage());
        }
        return resultVo;
    }

    //查询单个customer
    @GetMapping(value = "/workbench/consumer/queryCustomerById")
    public Customer queryCustomerById(String id, HttpSession session) {
        Customer customer = new Customer();
        User user = CommonUtil.getCurrentUser(session);
        customer = customerService.queryCustomerById(id, user);
        return customer;
    }

    //修改customer workbench/customer/editRemark
    @PostMapping(value = "/workbench/consumer/editCustomer")
    public ResultVo<Customer> editCustomer(Customer customer, HttpSession session) {
        ResultVo<Customer> resultVo = new ResultVo<>();
        try {
            User user = CommonUtil.getCurrentUser(session);
            customerService.editCustomer(customer, user);
            resultVo.setOk(true);
        } catch (CrmException c) {
            resultVo.setMessage(c.getMessage());
        }
        return resultVo;
    }

    //删除customer
    @PostMapping(value = "/workbench/consumer/delCustomer")
    public ResultVo<Customer> delCustomer(String ids) {
        ResultVo<Customer> resultVo = new ResultVo<>();
        try {
            customerService.delCustomer(ids);
            resultVo.setOk(true);
        } catch (CrmException c) {
            resultVo.setMessage(c.getMessage());
        }
        return resultVo;
    }

    //查询customer与备注信息
    @GetMapping(value = "/workbench/customer/queryAllRemark/{id}")
    public Map<String,Object> queryAllRemark(@PathVariable("id") String id) {
        Map<String, Object> map = MapUtil.newConcurrentHashMap();
        map = customerService.queryAllRemark(id);
        return map;
    }

    //修改customerRemark
    @PostMapping(value = "/workbench/customer/editRemark")
    public ResultVo<CustomerRemark> editRemark(CustomerRemark customerRemark, HttpSession session) {
        ResultVo<CustomerRemark> resultVo = new ResultVo<>();
        try {
            User user = CommonUtil.getCurrentUser(session);
            customerService.editRemark(customerRemark, user);
            resultVo.setOk(true);
        } catch (CrmException c) {
            resultVo.setMessage(c.getMessage());
        }
        return resultVo;
    }

    //新增customer备注
    @PostMapping(value = "/workbench/customer/addRemark")
    public ResultVo<CustomerRemark> addRemark(CustomerRemark customerRemark, HttpSession session) {
        ResultVo<CustomerRemark> resultVo = null;
        try {
            User user = CommonUtil.getCurrentUser(session);
            resultVo = customerService.addRemark(customerRemark, user);
        } catch (CrmException c) {
            resultVo.setMessage(c.getMessage());
        }
        return resultVo;
    }

    //删除customer备注
    @PostMapping(value = "/workbench/customer/delRemark")
    public ResultVo<CustomerRemark> delRemark(String id) {
        ResultVo<CustomerRemark> resultVo = null;
        try
        {
            resultVo  = customerService.delRemark(id);
            resultVo.setOk(true);
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //添加联系人
    @PostMapping(value = "/workbench/consumer/addContacts")
    public ResultVo addContacts(Contacts contacts,HttpSession session) {
        ResultVo resultVo = new ResultVo();
        User user = CommonUtil.getCurrentUser(session);
        try
        {
            customerService.addContacts(contacts,user);
            resultVo.setOk(true);
            resultVo.setMessage("添加成功");
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //查询customer的交易信息
    @GetMapping(value = "/workbench/customer/queryAllTran/{id}")
    public Map<String,Object> queryAllTran(@PathVariable("id") String id) {
        Map<String, Object> map = null;
        map = customerService.queryAllTran(id);
        return map;
    }

    //删除交易
    @DeleteMapping(value = "/workbench/customer/deleteTran/{id}")
    public ResultVo deleteTran(@PathVariable("id") String id) {
        ResultVo resultVo = new ResultVo();
        try
        {
            customerService.deleteTran(id);
            resultVo.setOk(true);
            resultVo.setMessage("删除成功");
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

}
