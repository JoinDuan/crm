package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.utils.CommonUtil;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.bean.Contacts;
import com.bjpowernode.crm.workbench.service.ContactsService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * @author dxt
 * @date 2021年07月12日 8:42
 * 联系人控制器
 */
@RestController
public class ContactsController {

    @Autowired
    private ContactsService contactsService;

    /**
     * 查询 contacts，带模糊查询带分页
     *
     * @param page     页码
     * @param pageSize 每页显示的数量
     * @return 查询结果集
     */
    @GetMapping(value = "/workbench/contacts/queryAllContacts")
    public PageInfo<Contacts> queryAllContacts(Integer page, Integer pageSize, Contacts contacts) {
        PageInfo<Contacts> pageInfo = contactsService.queryAllContacts(page, pageSize,contacts);
        return pageInfo;
    }

    //单个删除contacts与批量删除
    @PostMapping(value = "/workbench/contacts/delContacts")
    public ResultVo delContacts(String ids) {
        ResultVo resultVo = null;
        try
        {
            resultVo = contactsService.delContacts(ids);
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //根据客户id查询联系人
    @GetMapping(value = "/workbench/contacts/getContactsByCustomerId/{id}")
    public List<Contacts> getContactsByCustomerId(@PathVariable("id") String id) {
        List<Contacts> list = contactsService.getContactsByCustomerId(id);
        return list;
    }

    //根据id查询联系人
    @GetMapping(value = "/workbench/contacts/queryContactsById")
    public Contacts queryContactsById(String id) {
        Contacts contacts = contactsService.queryContactsById(id);
        return contacts;
    }
    //修改联系人
    @PostMapping(value = "/workbench/contacts/editContacts")
    public ResultVo editContacts(Contacts contacts, HttpSession session) {
        ResultVo resultVo = null;
        User user = CommonUtil.getCurrentUser(session);
        try
        {
            resultVo = contactsService.editContacts(contacts,user);
            resultVo.setMessage("修改成功");
            resultVo.setOk(true);
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //自动补全
    @PostMapping(value = "/workbench/contacts/queryContactsName")
    public List<String> queryContactsName(String customerName) {
        List<String> list = contactsService.queryContactsName(customerName);
        return list;
    }

    //添加联系人
    @PostMapping(value = "/workbench/contacts/addContacts")
    public ResultVo addContacts(Contacts contacts, HttpSession session) {
        ResultVo resultVo = new ResultVo();
        User user = CommonUtil.getCurrentUser(session);
        try
        {
            contactsService.addContacts(contacts,user);
            resultVo.setMessage("添加成功");
            resultVo.setOk(true);
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //详情页
    @GetMapping(value = "/workbench/contacts/detailAll/{id}")
    public Map<String, Object> detailAll(@PathVariable("id") String id) {
        Map<String, Object> map = contactsService.detailAll(id);
        return map;
    }

    //删除交易
    @DeleteMapping(value = "/workbench/contacts/deleteContactsTran/{id}")
    public ResultVo deleteContactsTran(@PathVariable("id") String id) {
        ResultVo resultVo = new ResultVo();
        try
        {
            contactsService.deleteContactsTran(id);
            resultVo.setOk(true);
            resultVo.setMessage("删除成功");
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //删除关联市场活动
    @DeleteMapping(value = "/workbench/contacts/deleteContactsActivity/{id}")
    public ResultVo deleteContactsActivity(@PathVariable("id") String activityId) {
        ResultVo resultVo = new ResultVo();
        try
        {
            contactsService.deleteContactsActivity(activityId);
            resultVo.setOk(true);
            resultVo.setMessage("解除关联成功");
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //模糊查询没有关联的市场活动，排除已经关联的
    @GetMapping(value = "/workbench/contacts/searchContactsActivity")
    public List<Activity> searchContactsActivity(String activityName,String contactsId) {
        List<Activity> list = contactsService.searchContactsActivity(activityName,contactsId);
        return list;
    }

    //联系人关联市场活动
    @PostMapping(value = "/workbench/contacts/relationActivity")
    public ResultVo relationActivity(String activityIds,String contactsId) {
        ResultVo resultVo = null;
        try
        {
            resultVo = contactsService.relationActivity(activityIds,contactsId);
            resultVo.setMessage("关联成功");
            resultVo.setOk(true);
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //联系人添加备注
    @PostMapping(value = "/workbench/contacts/addRemark")
    public ResultVo addRemark(String noteContent,String contactsId,HttpSession session) {
        ResultVo resultVo = null;
        User user = CommonUtil.getCurrentUser(session);
        try
        {
            resultVo = contactsService.addRemark(noteContent,contactsId,user);
            resultVo.setMessage("添加成功");
            resultVo.setOk(true);
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //联系人删除备注
    @DeleteMapping(value = "/workbench/contacts/deleteRemark")
    public ResultVo deleteRemark(String remarkId) {
        ResultVo resultVo = new ResultVo();
        try
        {
            contactsService.deleteRemark(remarkId);
            resultVo.setMessage("删除成功");
            resultVo.setOk(true);
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }


}
