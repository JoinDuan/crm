package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.bean.ActivityRemark;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * @author Dxt
 * @date 2021/7/9 - 14:06
 */
public interface ActivityRemarkMapper extends Mapper<ActivityRemark> {

    //根据市场活动的id，查询对应的备注信息
    List<ActivityRemark> selectOneByActivityId(String id);
    //删除市场活动备注信息
    int deleteRemarkById(String id);
}
