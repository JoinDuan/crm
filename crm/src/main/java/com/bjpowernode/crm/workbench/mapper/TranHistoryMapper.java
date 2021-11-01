package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.bean.TranHistory;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface TranHistoryMapper extends Mapper<TranHistory> {
    List<TranHistory> selectHistoryByTranId(String id);

    int deleteTranHistoryByTranIds(List<String> tranIds);

    int deleteRemarkByTranId(String ids);
}
