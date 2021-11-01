package com.bjpowernode.crm.base.service.impl;

import cn.hutool.core.collection.ListUtil;
import com.bjpowernode.crm.base.bean.DicType;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.mapper.DicTypeMapper;
import com.bjpowernode.crm.base.service.DicTypeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @author dxt
 * @date 2021年07月14日 10:52
 */
@Service
public class DicTypeServiceImpl implements DicTypeService {

    @Autowired
    private DicTypeMapper dicTypeMapper;

    //查询字典类型列表
    @Override
    public PageInfo<DicType> queryType(Integer page, Integer pageSize) {
        PageHelper.startPage(page, pageSize);
        List<DicType> dicTypes = dicTypeMapper.selectAll();
        PageInfo<DicType> dicTypePageInfo = new PageInfo<>(dicTypes);
        return dicTypePageInfo;
    }

    //保存字典类型
    @Override
    public ResultVo saveType(DicType dicType) {
        ResultVo resultVo = new ResultVo();
        int count = dicTypeMapper.insertSelective(dicType);
        if (count == 0){
            throw new CrmException(CrmEnum.DICTYPE_ADD);
        }
        resultVo.setMessage("保存字典类型成功");
        return resultVo;
    }

    //删除字典类型
    @Override
    public ResultVo deleteType(String id) {
        ResultVo resultVo = new ResultVo();
        if(id.contains(",")){
            String[] split = id.split(",");
            ArrayList<String> list = ListUtil.toList(split);
            int count = dicTypeMapper.deleteDicTypes(list);
            if(count != 0){
                resultVo.setMessage("删除字典类型成功");
            }else {
                throw new CrmException(CrmEnum.DICTYPE_DEL);
            }
        }else {
            int count = dicTypeMapper.deleteByPrimaryKey(id);
            if(count != 0){
                resultVo.setMessage("删除字典类型成功");
            }else {
                throw new CrmException(CrmEnum.DICTYPE_DEL);
            }
        }
        return resultVo;
    }

    //根据id查单条
    @Override
    public ResultVo selectTypeById(String id) {
        ResultVo resultVo = new ResultVo();
        DicType dicType = dicTypeMapper.selectByPrimaryKey(id);
        resultVo.setT(dicType);
        return resultVo;
    }

    //更新字典类型
    @Override
    public ResultVo updateType(DicType dicType) {
        ResultVo resultVo = new ResultVo();
        int count = dicTypeMapper.updateByPrimaryKeySelective(dicType);
        if(count != 0){
            resultVo.setMessage("更新字典类型成功");
        }else {
            throw new CrmException(CrmEnum.DICTYPE_EDIT);
        }
        return resultVo;
    }
}
