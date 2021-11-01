package com.bjpowernode.crm.base.service;

import com.bjpowernode.crm.base.bean.DicValue;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.github.pagehelper.PageInfo;

public interface DicValueService {

    //查询所有字典值带分页
    PageInfo<DicValue> queryType(Integer page, Integer pageSize);

    //保存字典值
    ResultVo saveValue(DicValue dicValue);

    //删除字典值
    ResultVo deleteValue(String id);

    //根据id查单条
    ResultVo selectValueById(String id);

    //更新字典值
    ResultVo updateValue(DicValue dicValue);
}
