package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.bean.Tran;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface TranMapper extends Mapper<Tran> {
    //查询交易列表，带分页带模糊查询
    List<Tran> selectAllClueAndLike(Tran tran);

    //批量删除交易
    int deleteTranByIds(List<String> tranIds);

    //单个交易
    Tran selectOneClueById(String id);

    //根据联系人id查询交易
    List<Tran> selectTranByContactsId(String id);

    //根据客户id查询对应的交易
    List<Tran> selectTranByCustomerId(String id);
}
