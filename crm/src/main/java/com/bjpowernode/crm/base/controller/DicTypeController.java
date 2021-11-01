package com.bjpowernode.crm.base.controller;

import com.bjpowernode.crm.base.bean.DicType;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.service.DicTypeService;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.annotations.Delete;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @author dxt
 * @date 2021年07月14日 10:51
 */
@RestController
public class DicTypeController {

    @Autowired
    private DicTypeService dicTypeService;

    //查询字典类型列表
    @GetMapping("/settings/dictionary/queryType")
    public PageInfo queryType(@RequestParam(value = "page",defaultValue = "1") Integer page,
                              @RequestParam(value = "pageSize",defaultValue = "3") Integer pageSize){

        PageInfo<DicType> pageInfo = dicTypeService.queryType(page,pageSize);

        return pageInfo;
    }

    //保存字典类型
    @PostMapping("/settings/dictionary/saveType")
    public ResultVo saveType(DicType dicType){
        ResultVo resultVo = null;
        try
        {
            resultVo = dicTypeService.saveType(dicType);
            resultVo.setOk(true);
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }
    //删除字典类型
    @DeleteMapping("/settings/dictionary/deleteType")
    public ResultVo deleteType(String id){
        ResultVo resultVo = null;
        try
        {
            resultVo = dicTypeService.deleteType(id);
            resultVo.setOk(true);
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //根据id查单条
    @GetMapping("/settings/dictionary/selectTypeById/{id}")
    public ResultVo selectTypeById(@PathVariable String id){
        ResultVo resultVo = null;
        try
        {
            resultVo = dicTypeService.selectTypeById(id);
            resultVo.setOk(true);
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //更新字典类型
    @PutMapping("/settings/dictionary/updateType")
    public ResultVo updateType(DicType dicType){
        ResultVo resultVo = null;
        try
        {
            resultVo = dicTypeService.updateType(dicType);
            resultVo.setOk(true);
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

}
