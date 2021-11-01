package com.bjpowernode.crm.base.controller;

import com.bjpowernode.crm.base.bean.DicType;
import com.bjpowernode.crm.base.bean.DicValue;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.service.DicValueService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * @author dxt
 * @date 2021年07月14日 10:51
 */
@RestController
public class DicValueController {

    @Autowired
    private DicValueService dicValueService;

    //查询字典类型列表
    @GetMapping("/settings/dictionary/queryValue")
    public PageInfo queryType(@RequestParam(value = "page",defaultValue = "1") Integer page,
                              @RequestParam(value = "pageSize",defaultValue = "5") Integer pageSize){

        PageInfo<DicValue> pageInfo = dicValueService.queryType(page,pageSize);

        return pageInfo;
    }

    //保存字典值
    @PostMapping("/settings/dictionary/saveValue")
    public ResultVo saveValue(DicValue dicValue){
        ResultVo resultVo = null;
        try
        {
            resultVo = dicValueService.saveValue(dicValue);
            resultVo.setOk(true);
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //删除字典类型
    @DeleteMapping("/settings/dictionary/deleteValue")
    public ResultVo deleteValue(String id){
        ResultVo resultVo = null;
        try
        {
            resultVo = dicValueService.deleteValue(id);
            resultVo.setOk(true);
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //根据id查单条
    @GetMapping("/settings/dictionary/selectValueById/{id}")
    public ResultVo selectValueById(@PathVariable String id){
        ResultVo resultVo = null;
        try
        {
            resultVo = dicValueService.selectValueById(id);
            resultVo.setOk(true);
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //更新字典值
    @PutMapping("/settings/dictionary/updateValue")
    public ResultVo updateValue(DicValue dicValue){
        ResultVo resultVo = null;
        try
        {
            resultVo = dicValueService.updateValue(dicValue);
            resultVo.setOk(true);
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

}
