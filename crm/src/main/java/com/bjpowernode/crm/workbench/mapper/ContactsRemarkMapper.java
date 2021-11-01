package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.bean.ContactsRemark;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface ContactsRemarkMapper extends Mapper<ContactsRemark> {

    /*根据联系人id查询备注*/
    List<ContactsRemark> selectRemarkByContactsId(String id);
}
