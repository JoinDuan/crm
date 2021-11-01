package com.bjpowernode.crm.workbench.service.impl;

import cn.hutool.core.date.DateTime;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.*;
import com.bjpowernode.crm.workbench.mapper.*;
import com.bjpowernode.crm.workbench.service.TranService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * @author dxt
 * @date 2021年07月16日 14:49
 * 交易的 业务实现类
 */
@Service
public class TranServiceImpl implements TranService {

    @Autowired
    private TranMapper tranMapper;

    @Autowired
    private ActivityMapper activityMapper;
    @Autowired
    private ContactsMapper contactsMapper;
    @Autowired
    private CustomerMapper customerMapper;
    @Autowired
    private TranRemarkMapper tranRemarkMapper;
    @Autowired
    private TranHistoryMapper tranHistoryMapper;

    //查询交易列表，带分页带模糊查询
    @Override
    public PageInfo queryAllTransaction(Integer page, Integer pageSize, Tran tran) {
        PageHelper.startPage(page, pageSize);
        List<Tran> tranList = tranMapper.selectAllClueAndLike(tran);
        PageInfo pageInfo = new PageInfo(tranList);
        return pageInfo;
    }

    //查找市场活动源
    @Override
    public List<Activity> queryAllActivity(String name) {
        ArrayList<Activity> activities = activityMapper.selectLikeName(name);
        return activities;
    }

    //查找联系人
    @Override
    public List<Contacts> queryContacts(String name) {
        List<Contacts> contactsList = contactsMapper.selectLikeName(name);
        return contactsList;
    }

    //查找客户
    @Override
    public Map<String,List<String>> queryCustomerName(String customerName) {
        Map<String,List<String>> map = new HashMap<>();
        ArrayList<String> idList = new ArrayList<>();
        ArrayList<String> nameList = new ArrayList<>();
        List<Customer> customerList = customerMapper.selectAllCustomerLikeName(customerName);
        for (Customer customer : customerList) {
            idList.add(customer.getId());
            nameList.add(customer.getName());
        }
        map.put("idList",idList);
        map.put("nameList",nameList);
        return map;
    }

    //添加交易
    @Override
    public ResultVo saveTran(Tran tran, User user) {
        ResultVo resultVo = new ResultVo();
        tran.setCreateBy(user.getName());
        tran.setCreateTime(DateTime.now().toString());
        tran.setId(IdUtil.simpleUUID());

        //取出tran中customerId，如果没有，需要创建新客户
        String customerName = tran.getCustomerId();
        Customer customerByName = customerMapper.selectCustomerByName(customerName);
        if (customerByName == null){
            //没有客户，新建
            //创建新客户
            Customer customer = new Customer();
            customer.setId(IdUtil.simpleUUID());
            customer.setName(customerName);
            customer.setOwner(tran.getOwner());
            customer.setNextContactTime(tran.getNextContactTime());
            customer.setCreateBy(tran.getCreateBy());
            customer.setContactSummary(tran.getContactSummary());
            customer.setCreateTime(DateTime.now().toString());
            customer.setDescription(tran.getDescription());
            int count = customerMapper.insertSelective(customer);
            if(count == 0){
                throw new CrmException(CrmEnum.CUSTOMER_ADD);
            }
            //插入客户成功后，把客户的主键放在交易对象中
            tran.setCustomerId(customer.getId());
        }else {
            //有客户，取出客户的id
            tran.setCustomerId(customerByName.getId());
        }
        //添加交易
        int count = tranMapper.insertSelective(tran);

        //添加交易历史
        TranHistory tranHistory = new TranHistory();
        tranHistory.setId(IdUtil.simpleUUID());
        tranHistory.setStage(tran.getStage());
        tranHistory.setMoney(tran.getMoney());
        tranHistory.setExpectedDate(tran.getExpectedDate());
        tranHistory.setCreateTime(tran.getCreateTime());
        tranHistory.setCreateBy(user.getName());
        tranHistory.setTranId(tran.getId());
        tranHistory.setPossibility(tran.getPossibility());
        int historyCount = tranHistoryMapper.insertSelective(tranHistory);
        if (count == 0 || historyCount == 0 ){
            throw new CrmException(CrmEnum.TRAN_ADD);
        }
        resultVo.setMessage("交易添加成功");
        return resultVo;
    }

    //删除交易
    @Override
    public ResultVo deleteTran(String ids) {
        ResultVo resultVo = new ResultVo();
        if (ids.contains(",")){
            //批量删除
            String[] idArr = ids.split(",");
            List<String> tranIds = Arrays.asList(idArr);
            int count = tranMapper.deleteTranByIds(tranIds);
            if(count == 0){
                throw new CrmException(CrmEnum.TRAN_DEL);
            }
            //删除交易对应的交易历史
            int historyCount = tranHistoryMapper.deleteTranHistoryByTranIds(tranIds);
            if(historyCount == 0){
                throw new CrmException(CrmEnum.TRAN_DEL);
            }
            //删除交易对应的交易备注
            int remarkCount = tranRemarkMapper.deleteRemarkByTranIds(tranIds);
            if(remarkCount == 0){
                throw new CrmException(CrmEnum.TRAN_DEL);
            }

        }else{
            //单个删除
            int count = tranMapper.deleteByPrimaryKey(ids);
            if(count == 0){
                throw new CrmException(CrmEnum.TRAN_DEL);
            }
            //删除交易对应的交易历史
            int historyCount = tranHistoryMapper.deleteRemarkByTranId(ids);
            if(historyCount == 0){
                throw new CrmException(CrmEnum.TRAN_DEL);
            }
            //删除交易对应的交易备注
            int remarkCount = tranRemarkMapper.deleteRemarkByTranId(ids);
            if(remarkCount == 0){
                throw new CrmException(CrmEnum.TRAN_DEL);
            }
        }
        resultVo.setMessage("删除交易成功");
        return resultVo;
    }

    //交易详情页
    @Override
    public Tran queryTransactionDetail(String id) {
        Tran tran = tranMapper.selectOneClueById(id);
        List<TranRemark> tranRemark = tranRemarkMapper.selectRemarkByTranId(id);
        List<TranHistory> tranHistory = tranHistoryMapper.selectHistoryByTranId(id);
        if (tranRemark != null){
            tran.setTranRemark(tranRemark);
        }
        if (tranHistory != null){
            tran.setTranHistory(tranHistory);
        }
        return tran;
    }

    //根据id查单条
    @Override
    public Tran selectTranById(String id) {
        Tran tran = tranMapper.selectOneClueById(id);
        return tran;
    }

    //修改交易
    @Override
    public ResultVo editTran(Tran tran, User user, String activityName, String contactsName) {
        String nowTime = DateTime.now().toString();
        tran.setEditBy(user.getName());
        tran.setEditTime(nowTime);
        ResultVo resultVo = new ResultVo();
        //取出tran中customerId，如果没有，需要创建新客户
        String customerName = tran.getCustomerId();
        Customer customerByName = customerMapper.selectCustomerByName(customerName);
        if (customerByName == null){
            //没有客户，新建
            //创建新客户
            Customer customer = new Customer();
            customer.setId(IdUtil.simpleUUID());
            customer.setName(customerName);
            customer.setOwner(tran.getOwner());
            customer.setNextContactTime(tran.getNextContactTime());
            customer.setCreateBy(tran.getCreateBy());
            customer.setContactSummary(tran.getContactSummary());
            customer.setCreateTime(nowTime);
            customer.setDescription(tran.getDescription());
            int count = customerMapper.insertSelective(customer);
            if(count == 0){
                throw new CrmException(CrmEnum.TRAN_EDIT);
            }
            //插入客户成功后，把客户的主键放在交易对象中
            tran.setCustomerId(customer.getId());
        }else {
            //有客户，取出客户的id，设置为交易的客户id
            tran.setCustomerId(customerByName.getId());
        }

        //取出tran中activityId,，判断有没有
        String activityId = tran.getActivityId();
        if(StrUtil.isEmpty(activityId)){
            //根据activityName查找对应的市场活动源的id
            Activity activity = activityMapper.selectByName(activityName);
            tran.setActivityId(activity.getId());
        }

        //取出联系人id，判断有没有
        String contactsId = tran.getContactsId();
        if (StrUtil.isEmpty(contactsId)){
            //根据contactsName查找对应的联系人
            Contacts contacts = contactsMapper.selectByName(contactsName);
            tran.setContactsId(contacts.getId());
        }

        //修改交易
        int tranCount = tranMapper.updateByPrimaryKeySelective(tran);
        if(tranCount == 0){
            throw new CrmException(CrmEnum.TRAN_EDIT);
        }

        //添加对应的交易历史
        TranHistory tranHistory = new TranHistory();
        tranHistory.setPossibility(tran.getPossibility());
        tranHistory.setMoney(tran.getMoney());
        tranHistory.setStage(tran.getStage());
        tranHistory.setExpectedDate(tran.getExpectedDate());
        tranHistory.setId(IdUtil.simpleUUID());
        tranHistory.setTranId(tran.getId());
        tranHistory.setCreateBy(user.getName());
        tranHistory.setCreateTime(nowTime);
        int historyCount = tranHistoryMapper.insertSelective(tranHistory);
        if(historyCount == 0){
            throw new CrmException(CrmEnum.TRAN_EDIT);
        }
        resultVo.setMessage("修改交易成功");
        return resultVo;
    }

    //获取当前阶段的所有图标,点击图标修改交易阶段图标
    @Override
    public Map<String,Object> queryStages(String id, Map<String, String> stage2Possibility, Integer index, User user) {

        //1,定义一个map保存结果集
        HashMap<String, Object> map = new HashMap<>();

        //当前交易阶段
        String currentStage = null;
        //当前可能性
        String currentPossibility = null;
        Set<Map.Entry<String, String>> entries = stage2Possibility.entrySet();
        //所有阶段与可能性的集合
        ArrayList<Map.Entry<String, String>> stagePossibilityAll = new ArrayList<>(entries);
        //查询当前的阶段与可能性
        Tran tran = tranMapper.selectByPrimaryKey(id);

        //判断是否点击了
        if (index == null){
            //没点击 -设置查出的阶段与可能性
            currentStage = tran.getStage();
            currentPossibility = tran.getPossibility();

        }else {
            //点击了 -设置index下标在所有阶段与可能性的集合 对应下标的元素
            Map.Entry<String, String> tranEntry = stagePossibilityAll.get(index);
            currentStage = tranEntry.getKey();
            currentPossibility = tranEntry.getValue();
            //创建交易对象-返回，便于修改前台文本
            Tran tran1 = new Tran();
            tran1.setStage(currentStage);
            tran1.setPossibility(currentPossibility);
            tran1.setId(id);

            //修改数据库中交易的阶段与可能性
            int updateTranCount = tranMapper.updateByPrimaryKeySelective(tran1);
            if(updateTranCount == 0){
                throw new CrmException(CrmEnum.TRAN_EDIT);
            }

            //创建对应的交易历史
            TranHistory tranHistory = new TranHistory();
            tranHistory.setCreateTime(DateTime.now().toString());
            tranHistory.setCreateBy(user.getName());
            tranHistory.setId(IdUtil.simpleUUID());
            tranHistory.setPossibility(currentPossibility);
            tranHistory.setStage(currentStage);
            tranHistory.setTranId(tran.getId());
            tranHistory.setExpectedDate(tran.getExpectedDate());
            tranHistory.setMoney(tran.getMoney());
            int count = tranHistoryMapper.insertSelective(tranHistory);
            if(count == 0){
                throw new CrmException(CrmEnum.TRAN_EDIT);
            }
            map.put("tran", tran1);
            map.put("tranHistory", tranHistory);
        }

        //8，定义集合对象，存储当前交易阶段的交易图标对象集合
        ArrayList<TranStageIcon> tranStageIconList = new ArrayList<>();

        //定义一个pointer:第一个可能性为0的阶段的索引位置
        int pointer = 0;
        for (int i = 0; i < stagePossibilityAll.size(); i++) {
            Map.Entry<String, String> entry = stagePossibilityAll.get(i);
            String possibility = entry.getValue();
            if("0".equals(possibility)){
                pointer = i;
                break;
            }
        }

        //定义一个position代表当前交易阶段在所有阶段 中的位置
        int position = 0;
        for (int i = 0; i < stagePossibilityAll.size(); i++) {
            Map.Entry<String, String> entry = stagePossibilityAll.get(i);
            String possibility = entry.getValue();
            if(currentPossibility.equals(possibility)){
                position = i;
                break;
            }
        }

        //能够判断交易失败了，但不能确定在哪一个失败阶段，前7个黑圈，后两个是x，不能确定红x的位置
        if("0".equals(currentPossibility)){
            for (int i = 0; i < stagePossibilityAll.size(); i++) {
                Map.Entry<String, String> entry = stagePossibilityAll.get(i);
                //阶段
                String stage = entry.getKey();
                //可能性
                String possibility = entry.getValue();
                TranStageIcon tranStageIcon = new TranStageIcon();
                if("0".equals(possibility)){
                    if(currentStage.equals(stage)){
                        //红x的位置
                        tranStageIcon.setType("红x");
                    }else {
                        //黑x的位置
                        tranStageIcon.setType("黑x");
                    }
                }else {
                    tranStageIcon.setType("黑圈");
                }
                tranStageIcon.setIndex(String.valueOf(i));
                tranStageIcon.setTitle(stage+":"+possibility);
                tranStageIconList.add(tranStageIcon);
            }

        }else {
            //交易中状态(包含交易成功)，能确定最后两个是黑x
            for (int i = 0; i < stagePossibilityAll.size(); i++) {
                Map.Entry<String, String> entry = stagePossibilityAll.get(i);
                String stage = entry.getKey();
                String possibility = entry.getValue();
                TranStageIcon tranStageIcon = new TranStageIcon();
                //小于当前交易阶段
                if(i < position){
                    //绿圈
                    tranStageIcon.setType("绿圈");
                }else if(i == position){
                    //锚点|
                    tranStageIcon.setType("锚点");
                }else if (i > position && i < pointer){
                    //黑圈
                    tranStageIcon.setType("黑圈");
                }else {
                    tranStageIcon.setType("黑x");
                }
                tranStageIcon.setIndex(String.valueOf(i));
                tranStageIcon.setTitle(stage+":"+possibility);
                tranStageIconList.add(tranStageIcon);
            }
        }
        map.put("list", tranStageIconList);
        return map;
    }

}
