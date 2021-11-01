package com.bjpowernode.crm.workbench.service.impl;

import cn.hutool.core.date.DateTime;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.workbench.bean.Contacts;
import com.bjpowernode.crm.workbench.bean.Customer;
import com.bjpowernode.crm.workbench.bean.CustomerRemark;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.Tran;
import com.bjpowernode.crm.workbench.mapper.ContactsMapper;
import com.bjpowernode.crm.workbench.mapper.CustomerMapper;
import com.bjpowernode.crm.workbench.mapper.CustomerRemarkMapper;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.workbench.mapper.TranMapper;
import com.bjpowernode.crm.workbench.service.CustomerService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Dxt
 * @date 2021/7/10 - 9:07
 * 客户业务类
 */
@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerMapper customerMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private CustomerRemarkMapper customerRemarkMapper;

    @Autowired
    private ContactsMapper contactsMapper;

    @Autowired
    private TranMapper tranMapper;


    //查询 customer，带模糊查询带分页  <if test="page != null">
    //            limit #{page},#{pageSize};
    //        </if>
    @Override
    public PageInfo<Customer> queryAllCustomer(Integer page, Integer pageSize,Customer customer) {
        /*Example example = new Example(Customer.class);
        Example.Criteria criteria = example.createCriteria();
        PageHelper.startPage(page, pageSize);
        String name = customer.getName();
        if(!StrUtil.isEmpty(name)){
            criteria.andLike("name", name);
        }
        ArrayList<String> list1 = new ArrayList<>();
        String owner = customer.getOwner();
        if(!StrUtil.isEmpty(owner)){
            Example example1 = new Example(User.class);
            Example.Criteria criteria1 = example1.createCriteria();
            criteria1.andLike("name", owner);
            List<User> userList = userMapper.selectByExample(example1);
            for (User user : userList) {
                list1.add(user.getId());
            }
            criteria.andIn("owner", list1);
        }
        String phone = customer.getPhone();
        if(!StrUtil.isEmpty(phone)){
            criteria.andLike("phone", phone);
        }
        String website = customer.getWebsite();
        if (!StrUtil.isEmpty(website)){
            criteria.andLike("website", website);
        }
*/
        //List<Customer> list = customerMapper.selectByExample(example);
        PageHelper.startPage(page, pageSize);
        List<Customer> list = customerMapper.selectAllCustomerAndLike(customer,page,pageSize);

        PageInfo<Customer> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    //查询所有所有者
    @Override
    public List<User> queryAllOwner() {
        return userMapper.selectAll();
    }

    //添加customer
    @Override
    public ResultVo<Customer> addCustomer(Customer customer, User user) {
        ResultVo<Customer> resultVo = new ResultVo<>();
        customer.setCreateBy(user.getName());
        customer.setCreateTime(DateTime.now().toString());
        customer.setId(IdUtil.simpleUUID());
        int count = customerMapper.insertSelective(customer);
        if(count == 0){
            throw new CrmException(CrmEnum.CUSTOMER_ADD);
        }else {
            resultVo.setMessage("添加成功");
        }
        return resultVo;
    }

    //查询单个customer
    @Override
    public Customer queryCustomerById(String id, User user) {
        Customer customer = customerMapper.selectByPrimaryKey(id);
        return customer;
    }

    //修改customer
    @Override
    public void editCustomer(Customer customer, User user) {
        ResultVo<Customer> resultVo = new ResultVo<>();
        customer.setEditBy(user.getName());
        customer.setEditTime(DateTime.now().toString());
        int count = customerMapper.updateByPrimaryKeySelective(customer);
        if (count == 0){
            throw new CrmException(CrmEnum.CUSTOMER_EDIT);
        }
    }

    //删除customer
    @Override
    public void delCustomer(String ids) {
        if(ids.contains(",")){
            //批量删除
            String[] split = ids.split(",");
            List<String> strings = Arrays.asList(split);
            Example example = new Example(Customer.class);
            Example.Criteria criteria = example.createCriteria();
            criteria.andIn("id", strings);
            int count = customerMapper.deleteByExample(example);
            if(count == 0){
                throw new CrmException(CrmEnum.CUSTOMER_DEL);
            }
        }else {
            //单个删除
            int count = customerMapper.deleteByPrimaryKey(ids);
            if (count == 0){
                throw new CrmException(CrmEnum.CUSTOMER_DEL);
            }
        }
    }

    //查询customer与备注信息
    @Override
    public Map<String, Object> queryAllRemark(String id) {
        Customer customer = customerMapper.selectCustomerById(id);
        User user = userMapper.selectOneByID(customer.getOwner());
        customer.setOwner(user.getName());
        List<CustomerRemark> customerRemark = customerRemarkMapper.selectByCustomerKey(customer.getId());
        for (CustomerRemark remark : customerRemark) {
            remark.setCustomerId(customer.getName());
            Example example = new Example(User.class);
            Example.Criteria criteria = example.createCriteria();
            criteria.andEqualTo("name", remark.getCreateBy());
            List<User> userList = userMapper.selectByExample(example);
            for (User user1 : userList) {
                remark.setImag(user1.getImg());
            }
        }
        Map<String, Object> map = MapUtil.newConcurrentHashMap();
        map.put("customer", customer);
        map.put("customerRemark", customerRemark);
        return map;
    }

    //修改客户备注
    @Override
    public void editRemark(CustomerRemark customerRemark, User user) {
        customerRemark.setEditFlag("1");
        customerRemark.setEditBy(user.getName());
        customerRemark.setEditTime(DateTime.now().toString());
        int count = customerRemarkMapper.updateByPrimaryKeySelective(customerRemark);
        if (count == 0){
            throw new CrmException(CrmEnum.CUSTOMER_REMARK_EDIT);
        }
    }

    //新增客户备注
    @Override
    public ResultVo<CustomerRemark> addRemark(CustomerRemark customerRemark, User user) {
        ResultVo<CustomerRemark> resultVo = new ResultVo<>();
        customerRemark.setCreateBy(user.getName());
        String customerId = customerRemark.getId();
        customerRemark.setId(IdUtil.simpleUUID());
        customerRemark.setCustomerId(customerId);
        customerRemark.setCreateTime(DateTime.now().toString());
        int count = customerRemarkMapper.insertCustomerRemark(customerRemark);
        if(count == 0){
            throw new CrmException(CrmEnum.CUSTOMER_REMARK_ADD);
        }else {
            resultVo.setOk(true);
            resultVo.setMessage("新增备注成功");
        }
        Customer customer = customerMapper.selectByPrimaryKey(customerId);
        customerRemark.setCustomerId(customer.getName());
        customerRemark.setImag(user.getImg());
        resultVo.setT(customerRemark);
        return resultVo;
    }

    //删除客户备注
    @Override
    public ResultVo<CustomerRemark> delRemark(String id) {
        ResultVo<CustomerRemark> resultVo = new ResultVo<>();
        int count = customerRemarkMapper.deleteRemarkById(id);
        if(count == 0){
            throw new CrmException(CrmEnum.CUSTOMER_REMARK_DEL);
        }else {
            resultVo.setOk(true);
            resultVo.setMessage("删除成功");
        }
        return resultVo;
    }

    //创建联系人
    @Override
    public void addContacts(Contacts contacts, User user) {
        String customerId = contacts.getCustomerId();
        if(!StrUtil.isEmpty(customerId)){
            Customer customer = customerMapper.selectCustomerByName(customerId);
            contacts.setCustomerId(customer.getId());
        }
        contacts.setId(IdUtil.simpleUUID());
        contacts.setCreateBy(user.getName());
        contacts.setCreateTime(DateTime.now().toString());
        int count = contactsMapper.insertSelective(contacts);
        if(count == 0){
            throw new CrmException(CrmEnum.CONTACTS_ADD);
        }
    }

    //查询customer的交易信息
    @Override
    public Map<String, Object> queryAllTran(String id) {
        HashMap<String, Object> map = MapUtil.newHashMap(7);
        Customer customer = customerMapper.selectCustomerById(id);
        List<Tran> tranList = tranMapper.selectTranByCustomerId(id);
        map.put("customer", customer);
        map.put("tran", tranList);
        return map;
    }

    //删除交易
    @Override
    public void deleteTran(String id) {
        int count = tranMapper.deleteByPrimaryKey(id);
        if(count == 0){
            throw new CrmException(CrmEnum.TRAN_DEL);
        }
    }
}
