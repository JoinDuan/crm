package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.bean.ClueRemark;
import tk.mybatis.mapper.common.Mapper;

public interface ClueRemarkMapper extends Mapper<ClueRemark> {

    //删除线索备注信息
    int deleteClueRemarkByClueId(String id);
}
