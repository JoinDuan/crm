package com.bjpowernode.crm.base.mapper;

import com.bjpowernode.crm.base.bean.DicValue;
import tk.mybatis.mapper.common.Mapper;

import java.util.ArrayList;

public interface DicValueMapper extends Mapper<DicValue> {
    int deleteDicTypes(ArrayList<String> list);
}
