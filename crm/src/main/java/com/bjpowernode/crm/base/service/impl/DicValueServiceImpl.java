package com.bjpowernode.crm.base.service.impl;

import cn.hutool.core.collection.ListUtil;
import cn.hutool.core.util.IdUtil;
import com.bjpowernode.crm.base.bean.DicValue;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.mapper.DicValueMapper;
import com.bjpowernode.crm.base.service.DicValueService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @author dxt
 * @date 2021年07月14日 11:32
 */
@Service
public class DicValueServiceImpl implements DicValueService {

    @Autowired
    private DicValueMapper dicValueMapper;

    //查询所有带分页
    @Override
    public PageInfo<DicValue> queryType(Integer page, Integer pageSize) {
        PageHelper.startPage(page, pageSize);
        List<DicValue> dicValues = dicValueMapper.selectAll();
        PageInfo<DicValue> dicValuePageInfo = new PageInfo<>(dicValues);
        return dicValuePageInfo;
    }

    //保存字典值
    @Override
    public ResultVo saveValue(DicValue dicValue) {
        ResultVo resultVo = new ResultVo();
        dicValue.setId(IdUtil.simpleUUID());
        int count = dicValueMapper.insertSelective(dicValue);
        if (count != 0){
            resultVo.setMessage("新增字典值成功");
        }else {
            throw new CrmException(CrmEnum.DICVALUE_ADD);
        }
        return resultVo;
    }

    //删除字典值
    @Override
    public ResultVo deleteValue(String id) {
        ResultVo resultVo = new ResultVo();
        if(id.contains(",")){
            String[] split = id.split(",");
            ArrayList<String> list = ListUtil.toList(split);
            int count = dicValueMapper.deleteDicTypes(list);
            if(count != 0){
                resultVo.setMessage("删除字典值成功");
            }else {
                throw new CrmException(CrmEnum.DICVALUE_DEL);
            }
        }else {
            int count = dicValueMapper.deleteByPrimaryKey(id);
            if(count != 0){
                resultVo.setMessage("删除字典值成功");
            }else {
                throw new CrmException(CrmEnum.DICVALUE_DEL);
            }
        }
        return resultVo;
    }

    //根据id查单条
    @Override
    public ResultVo selectValueById(String id) {
        DicValue dicValue = dicValueMapper.selectByPrimaryKey(id);
        ResultVo resultVo = new ResultVo();
        resultVo.setT(dicValue);
        return resultVo;
    }

    //更新字典值
    @Override
    public ResultVo updateValue(DicValue dicValue) {
        ResultVo resultVo = new ResultVo();
        int count = dicValueMapper.updateByPrimaryKeySelective(dicValue);
        if (count != 0){
            resultVo.setMessage("更新字典值成功");
        }else {
            throw new CrmException(CrmEnum.DICVALUE_EDIT);
        }
        return resultVo;
    }
}
