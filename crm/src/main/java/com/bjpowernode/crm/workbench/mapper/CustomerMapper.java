package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.bean.Customer;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * @author Dxt
 * @date 2021/7/10 - 9:05
 * 客户mapper接口
 */
public interface CustomerMapper extends Mapper<Customer> {

    //查询 customer，带模糊查询带分页 ,@Param("page") Integer page,@Param("pageSize") Integer pageSize
    List<Customer> selectAllCustomerAndLike(@Param("customer") Customer customer,@Param("page") Integer page,@Param("pageSize") Integer pageSize);
    //根据id查单条
    Customer selectCustomerById(String id);

    //查询 customer，带模糊查询
    List<Customer> selectAllCustomerLikeName(String customerName);

    //查询 customer，byName
    Customer selectCustomerByName(String contactsName);
}
