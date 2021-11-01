package com.bjpowernode.crm.workbench.service;

import cn.hutool.poi.excel.ExcelWriter;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.bean.ActivityRemark;
import com.bjpowernode.crm.settings.bean.User;
import com.github.pagehelper.PageInfo;

import java.util.List;

/**
 * @author Dxt
 * @date 2021/7/6 - 16:33
 * 市场活动接口
 */
public interface ActivityService {

    //查询所有市场活动信息
    PageInfo<Activity> queryAllActivity(Integer page,Integer pageSize,Activity activity);

    //查询所有市场所有者信息
    List<User> queryAllOwner();

    //修改+新增市场活动
    ResultVo<Activity> addAndEditActivity(Activity activity, User user);

    //填充修改页面信息
    Activity getActivityById(String id);

    //批量与单个删除
    void delActivity(String id);

    //查询市场活动与备注信息
    Activity queryAllRemark(String id);

    //添加市场活动备注信息
    ActivityRemark addRemark(ActivityRemark activity, User user);
    //修改市场活动备注信息
    void editRemark(ActivityRemark activity, User user);
    //删除市场活动备注信息
    void delRemark(String id);

    //写出Excel文件
    ExcelWriter exportExcel();
}
