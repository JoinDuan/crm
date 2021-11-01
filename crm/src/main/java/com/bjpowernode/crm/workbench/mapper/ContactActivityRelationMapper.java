package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.bean.ContactActivityRelation;
import tk.mybatis.mapper.common.Mapper;

public interface ContactActivityRelationMapper extends Mapper<ContactActivityRelation> {
    //解除联系人与市场活动的关联
    int deleteByActivityId(String activityId);
}
