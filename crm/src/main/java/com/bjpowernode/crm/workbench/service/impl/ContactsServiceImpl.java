package com.bjpowernode.crm.workbench.service.impl;

import cn.hutool.core.date.DateTime;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.*;
import com.bjpowernode.crm.workbench.mapper.*;
import com.bjpowernode.crm.workbench.service.ContactsService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author dxt
 * @date 2021年07月12日 8:43
 * 联系人业务实现类
 */
@Service
public class ContactsServiceImpl implements ContactsService {

    @Autowired
    private ContactsMapper contactsMapper;
    @Autowired
    private CustomerMapper customerMapper;
    @Autowired
    private ContactsRemarkMapper contactsRemarkMapper;
    @Autowired
    private TranMapper tranMapper;
    @Autowired
    private ActivityMapper activityMapper;
    @Autowired
    private ContactActivityRelationMapper contactActivityRelationMapper;
    //查询所有，带模糊查询带分页
    @Override
    public PageInfo<Contacts> queryAllContacts(Integer page, Integer pageSize, Contacts contacts) {

        PageHelper.startPage(page, pageSize);
        List<Contacts> contactsList = contactsMapper.selectAllContactsAndLike(contacts);
        PageInfo<Contacts> contactsPageInfo = new PageInfo<>(contactsList);
        return contactsPageInfo;
    }

    //单个删除与批量删除
    @Override
    public ResultVo delContacts(String ids) {
        ResultVo resultVo = new ResultVo();
        if (ids.contains(",")){
            //批量删除


        }else {
            //单个删除
            int count = contactsMapper.deleteByPrimaryKey(ids);
            if (count == 0){
                throw new CrmException(CrmEnum.CONTACTS_DEL);
            }else {
                resultVo.setMessage("删除联系人成功");
                resultVo.setOk(true);
            }
        }
        return resultVo;
    }

    //根据客户id查询联系人
    @Override
    public List<Contacts> getContactsByCustomerId(String id) {
        List<Contacts> list = contactsMapper.selectContactsByCustomerId(id);
        return list;
    }

    //根据联系人id查询详细信息
    @Override
    public Contacts queryContactsById(String id) {
        Contacts contacts = contactsMapper.selectOneContactsById(id);
        return contacts;
    }

    //修改联系人
    @Override
    public ResultVo editContacts(Contacts contacts, User user) {
        ResultVo resultVo = new ResultVo();
        contacts.setEditBy(user.getName());
        contacts.setEditTime(DateTime.now().toString());
        String customerId = contacts.getCustomerId();
        if(!StrUtil.isEmpty(customerId)){
            Customer customer = customerMapper.selectCustomerByName(customerId);
            contacts.setCustomerId(customer.getId());
        }
        int count = contactsMapper.updateByPrimaryKeySelective(contacts);
        if (count == 0){
            throw new CrmException(CrmEnum.CONTACTS_EDIT);
        }
        return resultVo;
    }

    //客户名称自动补全
    @Override
    public List<String> queryContactsName(String contactsName) {
        List<Customer> customerList = contactsMapper.selectContactsAllName(contactsName);
        ArrayList<String> list = new ArrayList<>();
        for (Customer c : customerList) {
            list.add(c.getName());
        }
        return list;
    }

    //添加联系人
    @Override
    public void addContacts(Contacts contacts, User user) {
        contacts.setId(IdUtil.simpleUUID());
        String customerName = contacts.getCustomerId();
        if (!StrUtil.isEmpty(customerName)){
            Customer customer = customerMapper.selectCustomerByName(customerName);
            contacts.setCustomerId(customer.getId());
        }
        contacts.setCreateBy(user.getName());
        contacts.setCreateTime(DateTime.now().toString());
        int count = contactsMapper.insertSelective(contacts);
        if(count == 0){
            throw new CrmException(CrmEnum.CONTACTS_ADD);
        }

    }

    //详情页
    @Override
    public Map<String, Object> detailAll(String id) {
        Contacts contacts = contactsMapper.selectOneContactsById(id);
        List<ContactsRemark> remarkList = contactsRemarkMapper.selectRemarkByContactsId(id);
        List<Tran> tranList = tranMapper.selectTranByContactsId(id);
        List<Activity> activityList = activityMapper.selectContactsActivityWhereIdIn(id);
        HashMap<String, Object> map = MapUtil.newHashMap(7);
        map.put("contacts", contacts);
        map.put("remarkList", remarkList);
        map.put("tranList", tranList);
        map.put("activityList", activityList);
        return map;
    }

    //删除联系人关联交易
    @Override
    public void deleteContactsTran(String id) {
        int count = tranMapper.deleteByPrimaryKey(id);
        if(count == 0){
            throw new CrmException(CrmEnum.TRAN_DEL);
        }
    }

    //解除与联系人关联的市场活动
    @Override
    public void deleteContactsActivity(String activityId) {
        int count = contactActivityRelationMapper.deleteByActivityId(activityId);
        if(count == 0){
            throw new CrmException(CrmEnum.CONTACTS_ACTIVITY_DEL);
        }
    }

    //查询市场活动，排除已经关联的
    @Override
    public List<Activity> searchContactsActivity(String activityName,String contactsId) {
        List<Activity> activityList = activityMapper.selectContactsActivityIdNotInAndNameLike(activityName, contactsId);
        return activityList;
    }

    //联系人关联市场活动
    @Override
    public ResultVo relationActivity(String activityIds, String contactsId) {
        ResultVo resultVo = new ResultVo();
        if (activityIds.contains(",")){
            //批量关联
            String[] arrId = activityIds.split(",");
            ContactActivityRelation relation = new ContactActivityRelation();
            int count = 0;
            for (int i = 0; i < arrId.length; i++) {
                relation.setId(IdUtil.simpleUUID());
                relation.setContactsId(contactsId);
                relation.setActivityId(arrId[i]);
                count = contactActivityRelationMapper.insert(relation);
            }
            if(count == 0){
                throw new CrmException(CrmEnum.CONTACTS_ACTIVITY_ADD);
            }

        }else {
            //单个关联
            ContactActivityRelation relation = new ContactActivityRelation();
            relation.setId(IdUtil.simpleUUID());
            relation.setContactsId(contactsId);
            relation.setActivityId(activityIds);
            int count = contactActivityRelationMapper.insert(relation);
            if(count == 0){
                throw new CrmException(CrmEnum.CONTACTS_ACTIVITY_ADD);
            }
        }
        List<Activity> activityList = activityMapper.selectContactsActivityWhereIdIn(contactsId);
        resultVo.setT(activityList);
        return resultVo;
    }

    //联系人添加备注
    @Override
    public ResultVo addRemark(String noteContent, String contactsId, User user) {
        ContactsRemark contactsRemark = new ContactsRemark();
        contactsRemark.setId(IdUtil.simpleUUID());
        contactsRemark.setNoteContent(noteContent);
        contactsRemark.setCreateBy(user.getName());
        contactsRemark.setCreateTime(DateTime.now().toString());
        contactsRemark.setContactsId(contactsId);
        int count = contactsRemarkMapper.insertSelective(contactsRemark);
        if(count == 0){
            throw new CrmException(CrmEnum.CONTACTS_REMARK_ADD);
        }
        ResultVo resultVo = new ResultVo();
        resultVo.setT(contactsRemark);
        return resultVo;
    }

    //删除备注
    @Override
    public void deleteRemark(String remarkId) {
        int count = contactsRemarkMapper.deleteByPrimaryKey(remarkId);
        if(count == 0){
            throw new CrmException(CrmEnum.CONTACTS_REMARK_DEL);
        }
    }
}
