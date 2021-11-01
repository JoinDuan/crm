package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.utils.CommonUtil;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.*;
import com.bjpowernode.crm.workbench.service.TranService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * @author dxt
 * @date 2021年07月16日 14:48
 * 交易 tran的 控制器
 */
@Controller
public class TranController {

    @Autowired
    private TranService tranService;

    /**
     * 交易分页+模糊查询
     * @param page
     * @param pageSize
     * @return
     */
    @ResponseBody
    @RequestMapping("/workbench/transaction/queryAllTransaction")
    public PageInfo queryAllTransaction(Integer page, Integer pageSize,Tran tran){
        PageInfo pageInfo = null;
        pageInfo = tranService.queryAllTransaction(page,pageSize,tran);
        return pageInfo;
    }

    //查找市场活动源
    @ResponseBody
    @GetMapping("/workbench/transaction/queryAllActivity")
    public List<Activity> queryAllActivity(String name){
        List<Activity> activityList = tranService.queryAllActivity(name);
        return activityList;
    }
    //查找联系人
    @ResponseBody
    @GetMapping("/workbench/transaction/queryContacts")
    public List<Contacts> queryContacts(String name){
        List<Contacts> contactsList = tranService.queryContacts(name);
        return contactsList;
    }
    //查找客户
    @ResponseBody
    @PostMapping("/workbench/transaction/queryCustomerName")
    public Map<String,List<String>> queryCustomerName(String customerName){
        Map<String,List<String>> customerNames = tranService.queryCustomerName(customerName);
        return customerNames;
    }

    //阶段对应可能性
    @ResponseBody
    @PostMapping("/workbench/transaction/stagePossibility")
    public String stagePossibility(String stage, HttpSession session){
        Map<String,String> stage2Possibility = (Map<String, String>) session.getServletContext().getAttribute("stage2Possibility");
        String possibility = stage2Possibility.get(stage);
        return possibility;
    }

    //保存交易
    @ResponseBody
    @PostMapping("/workbench/transaction/saveTran")
    public ResultVo saveTran(Tran tran,HttpSession session){
        ResultVo resultVo = null;
        User user = CommonUtil.getCurrentUser(session);
        try
        {
            resultVo = tranService.saveTran(tran,user);
            resultVo.setOk(true);

        }catch (CrmException e){ resultVo.setMessage(e.getMessage()); }
        return resultVo;
    }

    //删除交易
    @ResponseBody
    @DeleteMapping("/workbench/tran/deleteTran/{ids}")
    public ResultVo saveTran(@PathVariable String ids){
        ResultVo resultVo = null;
        try
        {
            resultVo = tranService.deleteTran(ids);
            resultVo.setOk(true);

        }catch (CrmException e){ resultVo.setMessage(e.getMessage()); }
        return resultVo;
    }

    //详情页
    @ResponseBody
    @GetMapping("/workbench/transaction/queryTransactionDetail/{id}")
    public Tran queryTransactionDetail(@PathVariable String id){
        Tran tran  = tranService.queryTransactionDetail(id);
        return tran;
    }
    //查单条
    @ResponseBody
    @GetMapping("/workbench/transaction/selectTranById/{id}")
    public Tran selectTranById(@PathVariable String id){
        Tran tran  = tranService.selectTranById(id);
        return tran;
    }

    //修改交易
    @ResponseBody
    @PutMapping("/workbench/transaction/editTran/{activityName}/{contactsName}")
    public ResultVo editTran(Tran tran,HttpSession session,
                             @PathVariable("activityName")String activityName,
                             @PathVariable("contactsName") String contactsName){
        ResultVo resultVo = null;
        User user = CommonUtil.getCurrentUser(session);
        try
        {
            resultVo = tranService.editTran(tran,user,activityName,contactsName);
            resultVo.setOk(true);

        }catch (CrmException e){ resultVo.setMessage(e.getMessage()); }
        return resultVo;
    }

    //获取当前阶段的所有图标,点击图标修改交易阶段图标
    @RequestMapping("/workbench/transaction/queryStages")
    @ResponseBody
    public Map<String,Object> queryStages(String id,HttpSession session,Integer index){
        //获取所有阶段和可能性
        User user = CommonUtil.getCurrentUser(session);
        Map<String,String> stage2Possibility = (Map<String, String>) session.getServletContext().getAttribute("stage2Possibility");
        Map<String,Object> map = tranService.queryStages(id,stage2Possibility,index,user);
        return map;
    }

}
