package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.bean.TranRemark;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface TranRemarkMapper extends Mapper<TranRemark> {

    List<TranRemark> selectRemarkByTranId(String id);

    int deleteRemarkByTranIds(List<String> tranIds);

    int deleteRemarkByTranId(String ids);
}
