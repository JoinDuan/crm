package com.bjpowernode.crm.workbench.service.impl;

import cn.hutool.core.collection.ListUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.workbench.bean.*;
import com.bjpowernode.crm.workbench.mapper.*;
import com.bjpowernode.crm.workbench.service.ClueService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.*;

/**
 * @author dxt
 * @date 2021年07月13日 14:39
 */
@Service
public class ClueServiceImpl implements ClueService {

    @Autowired
    private ClueMapper clueMapper;
    @Autowired
    private ActivityMapper activityMapper;
    @Autowired
    private ClueActivityRemarkMapper clueActivityRemarkMapper;
    @Autowired
    private ClueRemarkMapper clueRemarkMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private CustomerMapper customerMapper;
    @Autowired
    private ContactsMapper contactsMapper;
    @Autowired
    private CustomerRemarkMapper customerRemarkMapper;
    @Autowired
    private TranMapper tranMapper;
    @Autowired
    private ContactActivityRelationMapper contactActivityRelationMapper;
    @Autowired
    private TranRemarkMapper tranRemarkMapper;
    @Autowired
    private TranHistoryMapper tranHistoryMapper;
    @Autowired
    private ContactsRemarkMapper contactsRemarkMapper;

    //新增clue
    @Override
    public ResultVo addClue(Clue clue, User user) {
        clue.setCreateBy(user.getName());
        clue.setCreateTime(DateTime.now().toString());
        clue.setId(IdUtil.simpleUUID());
        int count = clueMapper.insertSelective(clue);
        if (count == 0) {
            throw new CrmException(CrmEnum.CLUE_ADD);
        }
        ResultVo resultVo = new ResultVo();
        resultVo.setMessage("添加线索成功");
        return resultVo;
    }

    //查询clue+分页+模糊查询
    @Override
    public PageInfo queryAllClue(Integer page, Integer pageSize, Clue clue) {

        PageHelper.startPage(page, pageSize);
        List<Clue> clueList = clueMapper.selectAllClueAndLike(clue);
        PageInfo pageInfo = new PageInfo(clueList);
        return pageInfo;
    }

    //根据id查单条
    @Override
    public Clue queryCustomerById(String id) {
        Clue clue = clueMapper.selectClueById(id);
        return clue;
    }

    //修改线索
    @Override
    public ResultVo editClue(Clue clue, User user) {
        ResultVo resultVo = new ResultVo();
        clue.setEditBy(user.getName());
        clue.setEditTime(DateTime.now().toString());
        int count = clueMapper.updateByPrimaryKeySelective(clue);
        if(count == 0){
            throw new CrmException(CrmEnum.CLUE_EDIT);
        }else {
            resultVo.setMessage("修改成功");
        }
        return resultVo;
    }

    //删除线索，单个与多个
    @Override
    public ResultVo deleteClue(String ids) {
        ResultVo resultVo = new ResultVo();
        if (ids.contains(",")){
            //批量删除
            String[] split = ids.split(",");
            List<String> strings = Arrays.asList(split);
            Example example = new Example(Clue.class);
            example.createCriteria().andIn("id", strings);
            int count = clueMapper.deleteByExample(example);
            if(count == 0){
                throw new CrmException(CrmEnum.CLUE_DEL);
            }
        }else {
            //单个删除
            int count = clueMapper.deleteByPrimaryKey(ids);
            if(count == 0){
                throw new CrmException(CrmEnum.CLUE_DEL);
            }
        }
        resultVo.setMessage("删除成功");
        return resultVo;
    }

    //查询clue+备注+关联的市场活动
    @Override
    public Map<String, Object> queryCustomerAndRemarkAndActivity(String id) {
        HashMap<String, Object> map = MapUtil.newHashMap(16);
        //线索 select * from tbl_clue tc join tbl_user tu on tc.`owner` = tu.id where tc.id='26f6423e0f464515a648f6138d0ac9bf '
        Clue clue = clueMapper.selectClueById(id);
        //市场活动
        List<Activity> activityList = clueMapper.selectRelationActivity(id);
        //备注 select * from tbl_clue_remark tcr right join tbl_clue tc on tcr.clueId = tc.id where tc.id = '26f6423e0f464515a648f6138d0ac9bf'
        List<ClueRemark> clueRemarks = clueMapper.selectClueRemarkByClueId(id);
        map.put("clue", clue);
        map.put("clueRemark", clueRemarks);
        map.put("activity", activityList);
        return map;
    }

    //查询市场活动排除已经关联的
    @Override
    public List<Activity> queryActivityLike(String id, String name) {
        ArrayList<Activity> activityList = ListUtil.toList();
        //查询clue已经关联的市场活动的id
        List<Activity> activities = clueMapper.selectRelationActivity(id);
        ArrayList<String> idList = new ArrayList<>();
        if (activities.size() == 0){
            //没有关联的
            activityList = activityMapper.selectLikeName(name);
        }else {
            //有关联的
            for (Activity activity : activities) {
                idList.add(activity.getId());
            }
            //查询市场活动 id not in
            activityList = activityMapper.selectActivityWhereIdNotIn(idList,name);
        }

        return activityList;
    }

    //关联市场活动
    @Override
    public ResultVo<List> relationActivity(String clueId, String activityIds) {
        ResultVo<List> resultVo = new ResultVo<List>();
        List<Activity> activityList = ListUtil.toList();
        int count = 0;
        if(activityIds.contains(",")){
            //批量关联
            String[] split = activityIds.split(",");
            for (int i = 0; i < split.length; i++) {
                ClueActivityRemark clueActivityRemark = new ClueActivityRemark();
                clueActivityRemark.setId(IdUtil.simpleUUID());
                clueActivityRemark.setClueId(clueId);
                clueActivityRemark.setActivityId(split[i]);
                count = clueActivityRemarkMapper.insert(clueActivityRemark);
            }
            if (count == 0){
                throw new CrmException(CrmEnum.CLUE_ACTIVITY_ADD);
            }else {
                resultVo.setMessage("线索与市场活动关联成功");
            }
            activityList = clueMapper.selectRelationActivity(clueId);
            resultVo.setT(activityList);
            return resultVo;
        } else {
            //单个关联
            ClueActivityRemark clueActivityRemark = new ClueActivityRemark();
            clueActivityRemark.setId(IdUtil.simpleUUID());
            clueActivityRemark.setClueId(clueId);
            clueActivityRemark.setActivityId(activityIds);
            count = clueActivityRemarkMapper.insert(clueActivityRemark);
            if (count == 0){
                throw new CrmException(CrmEnum.CLUE_ACTIVITY_ADD);
            }else {
                resultVo.setMessage("线索与市场活动关联成功");
            }
            activityList = clueMapper.selectRelationActivity(clueId);
            resultVo.setT(activityList);
            return resultVo;
        }

    }

    //删除关联市场活动
    @Override
    public ResultVo relationActivityDelete(String clueId, String activityId) {
        ResultVo resultVo = new ResultVo();
        int count = clueActivityRemarkMapper.deleteClueRelationActivity(clueId, activityId);
        if (count == 0){
            throw new CrmException(CrmEnum.CLUE_ACTIVITY_DEL);
        }else {
            resultVo.setMessage("解除线索与市场活动关联成功");
        }
        return resultVo;
    }

    //新增clue备注
    @Override
    public ResultVo addRemark(ClueRemark clueRemark, User user) {
        clueRemark.setCreateBy(user.getName());
        clueRemark.setCreateTime(DateTime.now().toString());
        clueRemark.setId(IdUtil.simpleUUID());
        ResultVo resultVo = new ResultVo<>();
        int count = clueRemarkMapper.insertSelective(clueRemark);
        if (count != 0){
            resultVo.setMessage("新增线索备注成功");
            resultVo.setOk(true);
        }else {
            throw new CrmException(CrmEnum.CLUE_REMARK_ADD);
        }
        HashMap<Object, Object> map = MapUtil.newHashMap(16);
        Clue clue = clueMapper.selectByPrimaryKey(clueRemark.getClueId());
        Example example = new Example(User.class);
        example.createCriteria().andEqualTo("name", clueRemark.getCreateBy());
        User user1 = userMapper.selectOneByExample(example);
        clueRemark.setClueId(user1.getImg());
        map.put("clueRemark", clueRemark);
        map.put("clue", clue);
        resultVo.setT(map);
        return resultVo;
    }

    //删除clue备注
    @Override
    public ResultVo delRemark(String id) {
        int count = clueRemarkMapper.deleteByPrimaryKey(id);
        ResultVo resultVo = new ResultVo();
        if (count != 0){
            resultVo.setMessage("删除线索备注成功");
        }else {
            throw new CrmException(CrmEnum.CLUE_REMARK_DEL);
        }
        return resultVo;
    }

    //修改备注
    @Override
    public ResultVo updateRemark(ClueRemark clueRemark, User user) {
        ResultVo resultVo = new ResultVo();
        clueRemark.setEditBy(user.getName());
        clueRemark.setEditTime(DateTime.now().toString());
        clueRemark.setEditFlag("1");
        int count = clueRemarkMapper.updateByPrimaryKeySelective(clueRemark);
        if (count != 0){
            resultVo.setMessage("修改备注成功");
        }else {
            throw new CrmException(CrmEnum.CLUE_REMARK_EDIT);
        }
        return resultVo;
    }

    //查询线索，根据id
    @Override
    public Clue queryClueById(String id) {
        return clueMapper.selectClueById(id);
    }

    //查询线索关联的市场活动，根据id
    @Override
    public List<Activity> queryClueRelationActivity(String id, String name) {
        List<Activity> list = null;
        if(StrUtil.isEmpty(name)){
            list = clueMapper.selectRelationActivity(id);
        }else {
            list = clueMapper.selectRelationActivityAndLikeName(id,name);
        }
        return list;
    }

    //线索转换
    @Override
    public ResultVo clueTransForm(String id, String isTran, User user, Tran tran) {
        ResultVo resultVo = new ResultVo();
        //1、根据线索的主键查询线索的信息(线索包含自身的信息，包含客户的信息，包含联系人信息)
        Clue clue = clueMapper.selectByPrimaryKey(id);
        //当前时间，优化性能
        String nowTime = DateTime.now().toString();
        String userName = user.getName();
        //2、先将线索中的客户信息取出来保存在客户表中，当该客户不存在的时候，新建客户(按公司名称精准查询)
        //公司名称
        String company = clue.getCompany();
        Customer customer = new Customer();

        Example example = new Example(Customer.class);
        example.createCriteria().andEqualTo("name", company);
        List<Customer> customerList = customerMapper.selectByExample(example);
        if(customerList.size() == 0){
            //客户不存在，新建客户
            customer.setId(IdUtil.simpleUUID());
            customer.setOwner(clue.getOwner());
            customer.setName(company);
            customer.setWebsite(clue.getWebsite());
            customer.setPhone(clue.getPhone());
            customer.setCreateBy(userName);
            customer.setCreateTime(nowTime);
            customer.setDescription(clue.getDescription());
            customer.setContactSummary(clue.getContactSummary());
            customer.setNextContactTime(clue.getNextContactTime());
            customer.setAddress(clue.getAddress());
            int count = customerMapper.insertSelective(customer);
            if(count == 0){ throw new CrmException(CrmEnum.CLUE_TRANSFORM); }
        }else {
            //有客户存在
            customer = customerList.get(0);
        }
        //3、将线索中联系人信息取出来保存在联系人表中
        Contacts contacts = new Contacts();
        contacts.setId(IdUtil.simpleUUID());
        contacts.setOwner(clue.getOwner());
        contacts.setSource(clue.getSource());
        contacts.setCustomerId(customer.getId());
        contacts.setFullname(clue.getFullname());
        contacts.setAppellation(clue.getAppellation());
        contacts.setEmail(clue.getEmail());
        contacts.setMphone(clue.getMphone());
        contacts.setJob(contacts.getJob());
        contacts.setCreateBy(userName);
        contacts.setCreateTime(nowTime);
        contacts.setContactSummary(clue.getContactSummary());
        contacts.setNextContactTime(clue.getNextContactTime());
        int contactsCount = contactsMapper.insertSelective(contacts);
        if (contactsCount == 0){ throw new CrmException(CrmEnum.CLUE_TRANSFORM); }

        //4、线索中的备注信息取出来保存在客户备注和联系人备注中
        //4.1 保存客户备注信息
        CustomerRemark customerRemark = new CustomerRemark();
        customerRemark.setCreateBy(userName);
        customerRemark.setId(IdUtil.simpleUUID());
        customerRemark.setCreateTime(nowTime);
        customerRemark.setCustomerId(customer.getId());
        int customerRemarkCount = customerRemarkMapper.insertSelective(customerRemark);
        if (customerRemarkCount == 0){ throw new CrmException(CrmEnum.CLUE_TRANSFORM); }

        //4.2 保存联系人备注信息
        ContactsRemark contactsRemark = new ContactsRemark();
        contactsRemark.setId(IdUtil.simpleUUID());
        contactsRemark.setCreateBy(userName);
        contactsRemark.setCreateTime(nowTime);
        contactsRemark.setContactsId(contacts.getId());
        int contactsRemarkCount = contactsRemarkMapper.insertSelective(contactsRemark);
        if (contactsRemarkCount == 0){ throw new CrmException(CrmEnum.CLUE_TRANSFORM); }

        //5、将"线索和市场活动的关系"转换到"联系人和市场活动的关系中"
        //先查询线索关联的市场活动
        List<ClueActivityRemark> clueActivityRelationList = clueActivityRemarkMapper.selectActivityIdByClueId(id);
        ContactActivityRelation contactActivityRelation = new ContactActivityRelation();
        for (ClueActivityRemark clueActivityRemark : clueActivityRelationList) {
            contactActivityRelation.setId(IdUtil.simpleUUID());
            contactActivityRelation.setActivityId(clueActivityRemark.getActivityId());
            contactActivityRelation.setContactsId(contacts.getId());
            int count = contactActivityRelationMapper.insert(contactActivityRelation);
            if (count == 0){ throw new CrmException(CrmEnum.CLUE_TRANSFORM); }
        }

        //6、如果转换过程中发生了交易，创建一条新的交易，交易信息不全，后面可以通过修改交易来完善交易信息
        if("1".equals(isTran)){
            //发生交易，保存交易对象
            tran.setId(IdUtil.simpleUUID());
            tran.setOwner(clue.getOwner());
            tran.setCustomerId(customer.getId());
            tran.setContactsId(contacts.getId());
            tran.setCreateBy(userName);
            tran.setCreateTime(nowTime);
            int tranCount = tranMapper.insertSelective(tran);
            if (tranCount == 0){ throw new CrmException(CrmEnum.CLUE_TRANSFORM); }
            String tranId = tran.getId();
            //7、创建该条交易对应的交易历史以及备注
            //保存交易备注
            TranRemark tranRemark = new TranRemark();
            tranRemark.setId(IdUtil.simpleUUID());
            tranRemark.setCreateBy(userName);
            tranRemark.setCreateTime(nowTime);
            tranRemark.setTranId(tranId);
            int tranRemarkCount = tranRemarkMapper.insertSelective(tranRemark);
            if (tranRemarkCount == 0){ throw new CrmException(CrmEnum.CLUE_TRANSFORM); }

            //保存交易历史
            TranHistory tranHistory = new TranHistory();
            tranHistory.setId(IdUtil.simpleUUID());
            tranHistory.setStage(tran.getStage());
            tranHistory.setMoney(tran.getMoney());
            tranHistory.setExpectedDate(tran.getExpectedDate());
            tranHistory.setCreateBy(userName);
            tranHistory.setCreateTime(nowTime);
            tranHistory.setTranId(tranId);
            int tranHistoryCount = tranHistoryMapper.insertSelective(tranHistory);
            if (tranHistoryCount == 0){throw new CrmException(CrmEnum.CLUE_TRANSFORM);};
        }

        //8、删除线索备注信息
        int clueRemarkCount = clueRemarkMapper.deleteClueRemarkByClueId(id);

        //9、删除线索和市场活动的关联关系
        int clueActivityRemarkCount = clueActivityRemarkMapper.deleteClueRelationActivityByClueId(id);

        //10、删除线索
        int clueCount = clueMapper.deleteByPrimaryKey(id);
        if (clueCount == 0){
            throw new CrmException(CrmEnum.CLUE_TRANSFORM);
        }
        resultVo.setMessage("线索转换成功");
        return resultVo;
    }
}
