package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.bean.ClueActivityRemark;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface ClueActivityRemarkMapper extends Mapper<ClueActivityRemark> {

    int deleteClueRelationActivity(@Param("clueId") String clueId, @Param("activityId") String activityId);

    //根据线索的id，查询与之对应的线索与市场活动的id对应的关系
    List<ClueActivityRemark> selectActivityIdByClueId(String id);

    //根据线索的id，删除线索和市场活动的关联关系
    int deleteClueRelationActivityByClueId(String id);
}
