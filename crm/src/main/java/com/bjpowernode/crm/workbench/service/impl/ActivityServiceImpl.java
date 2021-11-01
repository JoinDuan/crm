package com.bjpowernode.crm.workbench.service.impl;

import cn.hutool.core.util.StrUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.utils.DateTimeUtil;
import com.bjpowernode.crm.base.utils.UUIDUtil;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.bean.ActivityRemark;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.mapper.ActivityMapper;
import com.bjpowernode.crm.workbench.mapper.ActivityRemarkMapper;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.workbench.service.ActivityService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.poi.ss.usermodel.Font;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.Arrays;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

/**
 * @author Dxt
 * @date 2021/7/6 - 16:34
 * 市场活动业务类
 */
@Service
public class ActivityServiceImpl implements ActivityService {

    @Autowired
    private ActivityMapper activityMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ActivityRemarkMapper activityRemarkMapper;

    /**
     * 查询所有市场活动信息
     * @return
     */
    @Override
    public PageInfo<Activity> queryAllActivity(Integer page,Integer pageSize,Activity activity) {
        Example example = new Example(Activity.class);
        Example.Criteria criteria = example.createCriteria();
        //根据Activity的owner模糊查询对应的user的id
        String oldOwner = activity.getOwner();
        if(!StrUtil.isEmpty(oldOwner)){
            Example example1 = new Example(User.class);
            Example.Criteria criteria1 = example1.createCriteria();
            criteria1.andLike("name","%"+oldOwner+"%");
            List<User> userList = userMapper.selectByExample(example1);
            List<String> strings = new CopyOnWriteArrayList<>();
            for (User user : userList) {
                strings.add(user.getId());
            }
            criteria.andIn("owner", strings);
        }
        //名字
        String name = activity.getName();
        if(!StrUtil.isEmpty(name)){
            criteria.andLike("name", "%" + name + "%");
        }
        //开始时间
        String startDate = activity.getStartDate();
        if(!StrUtil.isEmpty(startDate)){
            criteria.andGreaterThanOrEqualTo("startDate",startDate);
        }
        //结束时间
        String endDate = activity.getEndDate();
        if(!StrUtil.isEmpty(endDate)){
            criteria.andLessThanOrEqualTo("endDate",endDate);
        }

        PageHelper.startPage(page, pageSize);
        List<Activity> activities = activityMapper.selectByExample(example);
        for (Activity activity1 : activities) {
            User user = userMapper.selectOneByID(activity1.getOwner());
            activity1.setOwner(user.getName());
        }
        PageInfo<Activity> pageInfo = new PageInfo<>(activities);
        return pageInfo;
    }

    /**
     * @return 市场活动所有者 下拉框填充值
     */
    @Override
    public List<User> queryAllOwner() {
        List<User> users = userMapper.selectAll();
        return users;
    }

    /**
     * 修改+新增市场活动，判断有无id来判断
     * @param activity
     * @param user
     * @return
     */
    @Override
    public ResultVo<Activity> addAndEditActivity(Activity activity, User user) {
        ResultVo resultVo = new ResultVo();
        String id = activity.getId();
        if(StrUtil.isEmpty(id)){
            //新增
            activity.setId(UUIDUtil.getUUID());
            activity.setCreateTime(DateTimeUtil.getSysTime());
            activity.setCreateBy(user.getName());
            int count = activityMapper.insertActivity(activity);
            if (count == 0){
                throw new CrmException(CrmEnum.ACTIVITY_ADD);
            }
            resultVo.setMessage("新增市场活动成功");
        }else {
            //修改
            activity.setEditBy(user.getName());
            activity.setEditTime(DateTimeUtil.getSysTime());
            int count = activityMapper.updateByPrimaryKeySelective(activity);
            if (count == 0){
                throw new CrmException(CrmEnum.ACTIVITY_EDIT);
            }
            resultVo.setMessage("修改市场活动成功");
        }
        resultVo.setOk(true);
        return resultVo;
    }

    //填充修改页面信息
    @Override
    public Activity getActivityById(String id) {
        return activityMapper.queryActivityById(id);
    }

    //批量与单个删除
    @Override
    public void delActivity(String id) {
        if(id.contains(",")){
            //批量删除
            String[] split = id.split(",");
            List<String> strings = Arrays.asList(split);
            Example example = new Example(Activity.class);
            Example.Criteria criteria = example.createCriteria();
            criteria.andIn("id", strings);
            int i = activityMapper.deleteByExample(example);
            if (i == 0) {
                throw new CrmException(CrmEnum.ACTIVITY_DEL);
            }

        }else{
            //单个删除
            int i = activityMapper.deleteByPrimaryKey(id);
            if (i == 0) {
                throw new CrmException(CrmEnum.ACTIVITY_DEL);
            }

        }
    }
    //查询市场活动+备注信息
    @Override
    public Activity queryAllRemark(String id) {
        Activity activity = getActivityById(id);
        User user = userMapper.selectOneByID(activity.getOwner());
        activity.setOwner(user.getName());

        ActivityRemark remark1 = new ActivityRemark();
        remark1.setActivityId(activity.getId());
        List<ActivityRemark> remarkList = activityRemarkMapper.select(remark1);
        for (ActivityRemark activityRemarks : remarkList) {
            User user1 = userMapper.selectOneByID(activityRemarks.getOwner());
            activityRemarks.setImg(user1.getImg());
            activityRemarks.setActivityId(activity.getName());
        }
        activity.setActivityRemarks(remarkList);
        return activity;
    }

    //添加市场活动备注信息
    @Override
    public ActivityRemark addRemark(ActivityRemark activityRemark, User user) {
        activityRemark.setCreateTime(DateTimeUtil.getSysTime());
        activityRemark.setCreateBy(user.getName());
        String id = activityRemark.getId();
        activityRemark.setId(UUIDUtil.getUUID());
        activityRemark.setActivityId(id);
        Activity activity = activityMapper.selectByPrimaryKey(id);
        activityRemark.setOwner(activity.getOwner());
        activityRemark.setImg(user.getImg());
        int count = activityRemarkMapper.insertSelective(activityRemark);
        if (count == 0){
            throw new CrmException(CrmEnum.ACTIVITY_REMARK_ADD);
        }
        activityRemark.setActivityId(activity.getName());
        return activityRemark;
    }

    //修改市场活动备注信息
    @Override
    public void editRemark(ActivityRemark activityRemark, User user) {
        activityRemark.setEditBy(user.getName());
        activityRemark.setEditTime(DateTimeUtil.getSysTime());
        activityRemark.setEditFlag("1");
        int count = activityRemarkMapper.updateByPrimaryKeySelective(activityRemark);
        if (count == 0){
            throw new CrmException(CrmEnum.ACTIVITY_REMARK_EDIT);
        }
    }
    //删除市场活动备注信息
    @Override
    public void delRemark(String id) {
        int count = activityRemarkMapper.deleteRemarkById(id);
        if(count == 0){
            throw new CrmException(CrmEnum.ACTIVITY_REMARK_DEL);
        }
    }

    //写出Excel文件
    @Override
    public ExcelWriter exportExcel() {

        List<Activity> activityList = activityMapper.selectAll();
        // 通过工具类创建writer，创建xlsx格式
        ExcelWriter writer = ExcelUtil.getWriter(true);

        // 合并单元格后的标题行，使用默认标题样式
        writer.merge(activityList.size() - 1, "市场活动列表");

        //设置内容字体
        Font font = writer.createFont();
        font.setBold(true);
        font.setColor(Font.COLOR_NORMAL);
        font.setItalic(true);
        //第二个参数表示是否忽略头部样式
        writer.getStyleSet().setFont(font, true);

        // 一次性写出内容，使用默认样式，强制输出标题
        writer.write(activityList, true);

        return writer;
    }
}
