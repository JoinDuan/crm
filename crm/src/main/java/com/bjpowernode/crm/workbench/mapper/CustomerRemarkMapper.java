package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.bean.CustomerRemark;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * @author Dxt
 * @date 2021/7/10 - 9:05
 * 客户备注mapper接口
 */
public interface CustomerRemarkMapper extends Mapper<CustomerRemark> {

    //查询备注信息，根据客户的主键
    List<CustomerRemark> selectByCustomerKey(String id);

    //新增客户备注
    int insertCustomerRemark(CustomerRemark customerRemark);

    //删除客户备注
    int deleteRemarkById(String id);
}
