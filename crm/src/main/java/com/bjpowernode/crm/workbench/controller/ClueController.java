package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.utils.CommonUtil;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.*;
import com.bjpowernode.crm.workbench.service.ClueService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * @author dxt
 * @date 2021年07月13日 14:39
 * 线索控制器
 */
@RestController
public class ClueController {

    @Autowired
    private ClueService clueService;

    /**
     * 线索分页+模糊查询
     * @param page
     * @param pageSize
     * @return
     */
    @RequestMapping("/workbench/clue/queryAllClue")
    public PageInfo queryAllClue(Integer page, Integer pageSize, Clue clue){
        PageInfo pageInfo = null;
        pageInfo = clueService.queryAllClue(page,pageSize,clue);
        return pageInfo;
    }

    //新增线索
    @PostMapping(value = "/workbench/clue/addClue")
    public ResultVo addClue(Clue clue, HttpSession session) {
        ResultVo resultVo = null;
        try {
            User user = CommonUtil.getCurrentUser(session);
            resultVo = clueService.addClue(clue, user);
            resultVo.setOk(true);
        } catch (CrmException c) {
            resultVo.setMessage(c.getMessage());
        }
        return resultVo;
    }

    //新增线索-查询
    @GetMapping(value = "/workbench/clue/queryCustomerById/{id}")
    public Clue queryCustomerById(@PathVariable("id") String id) {
        Clue clue = null;
        clue = clueService.queryCustomerById(id);
        return clue;
    }
    //修改线索
    @PostMapping(value = "/workbench/clue/editClue")
    public ResultVo editClue(Clue clue, HttpSession session) {
        ResultVo resultVo = null;
        try {
            User user = CommonUtil.getCurrentUser(session);
            resultVo = clueService.editClue(clue, user);
            resultVo.setOk(true);
        } catch (CrmException c) {
            resultVo.setMessage(c.getMessage());
        }
        return resultVo;
    }

    //删除线索
    @DeleteMapping(value = "/workbench/clue/deleteClue/{ids}")
    public ResultVo deleteClue(@PathVariable String ids) {
        ResultVo resultVo = null;
        try {
            resultVo = clueService.deleteClue(ids);
            resultVo.setOk(true);
        } catch (CrmException c) {
            resultVo.setMessage(c.getMessage());
        }
        return resultVo;
    }

    //查询clue+备注+关联的市场活动
    @GetMapping(value = "/workbench/clue/queryCustomerAndRemarkAndActivity/{id}")
    public Map<String,Object> queryCustomerAndRemarkAndActivity(@PathVariable("id") String id) {
        Map<String,Object> map = null;
        map = clueService.queryCustomerAndRemarkAndActivity(id);
        return map;
    }

    //查询市场活动排除已经关联的
    @GetMapping(value = "/workbench/clue/queryActivityLike")
    public List<Activity> queryActivityLike(String id,String name) {
        List<Activity> list = null;
        list = clueService.queryActivityLike(id,name);
        return list;
    }

    //关联市场活动
    @PostMapping(value = "/workbench/clue/relationActivity")
    public ResultVo<List> relationActivity(String clueId,String activityIds) {
        ResultVo<List> resultVo = null;
        try
        {
            resultVo = clueService.relationActivity(clueId,activityIds);
            resultVo.setOk(true);
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //删除关联市场活动
    @DeleteMapping(value = "/workbench/clue/relationActivityDelete")
    public ResultVo relationActivityDelete(String clueId,String activityId) {
        ResultVo resultVo = null;
        try
        {
            resultVo = clueService.relationActivityDelete(clueId,activityId);
            resultVo.setOk(true);
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //新增clue备注
    @PostMapping(value = "/workbench/clue/addRemark")
    public ResultVo addRemark(ClueRemark clueRemark, HttpSession session) {
        ResultVo<ClueRemark> resultVo = null;
        try {
            User user = CommonUtil.getCurrentUser(session);
            resultVo = clueService.addRemark(clueRemark, user);
        } catch (CrmException c) {
            resultVo.setMessage(c.getMessage());
        }
        return resultVo;
    }

    //删除clue备注
    @DeleteMapping(value = "/workbench/clue/deleteRemark")
    public ResultVo deleteRemark(String id) {
        ResultVo resultVo = null;
        try
        {
            resultVo  = clueService.delRemark(id);
            resultVo.setOk(true);
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }
    //修改customerRemark
    @PutMapping(value = "/workbench/clue/updateRemark")
    public ResultVo updateRemark(ClueRemark clueRemark, HttpSession session) {
        ResultVo resultVo = null;
        try {
            User user = CommonUtil.getCurrentUser(session);
            resultVo = clueService.updateRemark(clueRemark, user);
            resultVo.setOk(true);
        } catch (CrmException c) {
            resultVo.setMessage(c.getMessage());
        }
        return resultVo;
    }

    //查询线索 根据id
    @GetMapping(value = "/workbench/clue/queryClueById/{id}")
    public Clue queryClueById(@PathVariable("id") String id) {
        return clueService.queryClueById(id);
    }

    //查询当前线索关联的市场活动 根据id,也只支持模糊查询
    @GetMapping(value = "/workbench/clue/queryClueRelationActivity")
    public List<Activity> queryClueRelationActivity(String id,String name) {
        List<Activity> list = null;
        list = clueService.queryClueRelationActivity(id,name);
        return list;
    }

    //线索转换
    @PostMapping(value = "/workbench/clue/clueTransForm")
    public ResultVo clueTransForm(String id,String isTran,HttpSession session,Tran tran) {
        ResultVo resultVo = null;
        User user = CommonUtil.getCurrentUser(session);
        try
        {
            resultVo = clueService.clueTransForm(id,isTran,user,tran);
            resultVo.setOk(true);
        }catch (CrmException c){
            resultVo.setMessage(c.getMessage());
        }
        return resultVo;
    }


}
