package com.bjpowernode.crm.base.mapper;

import com.bjpowernode.crm.base.bean.DicType;
import tk.mybatis.mapper.common.Mapper;

import java.util.ArrayList;

public interface DicTypeMapper extends Mapper<DicType> {

    //批量删除线索类型
    int deleteDicTypes(ArrayList<String> list);
}
