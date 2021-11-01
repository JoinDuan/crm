package com.bjpowernode.crm.base.service;

import com.bjpowernode.crm.base.bean.DicType;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.github.pagehelper.PageInfo;

public interface DicTypeService {
    //查询字典类型列表
    PageInfo<DicType> queryType(Integer page, Integer pageSize);
    //保存字典类型
    ResultVo saveType(DicType dicType);

    //删除字典类型
    ResultVo deleteType(String id);

    ResultVo selectTypeById(String id);

    //更新字典类型
    ResultVo updateType(DicType dicType);
}
