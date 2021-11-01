package com.bjpowernode.crm.workbench.controller;

import cn.hutool.core.io.IoUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.utils.CommonUtil;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.bean.ActivityRemark;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.service.ActivityService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @author Dxt
 * @date 2021/7/6 - 16:29
 */
@RestController
public class ActivityController {

    @Autowired
    private ActivityService activityService;

    /**
     * 市场活动分页+模糊查询
     * @param page
     * @param pageSize
     * @return
     */
    @RequestMapping("/workbench/activity/queryAllActivity")
    public PageInfo queryAllActivity(Integer page,Integer pageSize,Activity activity){

        PageInfo<Activity> pageInfo = activityService.queryAllActivity(page,pageSize,activity);

        return pageInfo;
    }

    /**
     * @return  市场活动  所有者下拉框填充 /workbench/activity/addAndEditActivity
     */
    @RequestMapping("/workbench/activity/queryAllOwner")
    public List<User> queryAllOwner(){
        List<User> ownerList = activityService.queryAllOwner();
        return ownerList;
    }

    /**
     * 修改 市场活动与新增市场活动
     * @param activity
     * @param session
     * @return
     */
    @RequestMapping("/workbench/activity/addAndEditActivity")
    public ResultVo<Activity> addAndEditActivity(Activity activity, HttpSession session){
        ResultVo<Activity> resultVo = null;
        User user = (User) session.getAttribute("user");
        try {
            resultVo = activityService.addAndEditActivity(activity, user);
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //填充修改页面信息
    @RequestMapping("/workbench/activity/getActivityById")
    public Activity getActivityById(String id){
        Activity activity = activityService.getActivityById(id);
        return activity;
    }

    //批量与单个删除一起 /workbench/activity/queryAllRemark
    @RequestMapping("/workbench/activity/delActivity")
    public ResultVo<Activity> delActivity(String id){
        ResultVo<Activity> resultVo = new ResultVo<>();
        try {
            activityService.delActivity(id);
            resultVo.setMessage("删除成功");
            resultVo.setOk(true);
        }catch (CrmException e){
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //市场活动详情页+备注信息
    @RequestMapping("/workbench/activity/queryAllRemark")
    public Activity queryAllRemark(String id){
        Activity activity = null;
        activity = activityService.queryAllRemark(id);
        return activity;
    }

    //备注信息添加 /workbench/activity/editRemark
    @RequestMapping("/workbench/activity/addRemark")
    public ResultVo addRemark(ActivityRemark activity,HttpSession session){
        ResultVo<ActivityRemark> resultVo = new ResultVo<>();
        User user = CommonUtil.getCurrentUser(session);
        try
        {
            ActivityRemark remark = activityService.addRemark(activity,user);
            resultVo.setT(remark);
            resultVo.setOk(true);
            resultVo.setMessage("添加成功");
        }catch (CrmException c){
            resultVo.setMessage(c.getMessage());
        }
        return resultVo;
    }

    //备注信息修改   /workbench/activity/delRemark
    @RequestMapping("/workbench/activity/editRemark")
    public ResultVo editRemark(ActivityRemark activity,HttpSession session){
        ResultVo<ActivityRemark> resultVo = new ResultVo<>();
        User user = CommonUtil.getCurrentUser(session);
        try
        {
            activityService.editRemark(activity,user);
            resultVo.setOk(true);
            resultVo.setMessage("修改成功");
        }catch (CrmException c){
            resultVo.setMessage(c.getMessage());
        }
        return resultVo;
    }

    //备注信息删除
    @RequestMapping("/workbench/activity/delRemark")
    public ResultVo delRemark(String id){
        ResultVo resultVo = new ResultVo<>();
        try
        {
            activityService.delRemark(id);
            resultVo.setOk(true);
            resultVo.setMessage("删除成功");
        }catch (CrmException c){
            resultVo.setMessage(c.getMessage());
        }
        return resultVo;
    }

    //写出Excel文件
    @RequestMapping("/workbench/activity/exportExcel")
    public void exportExcel(HttpServletResponse response){
        ExcelWriter excelWriter = null;
        ServletOutputStream out = null;
        try
        {
            //response为HttpServletResponse对象
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8");
            //activity.xlsx是弹出下载对话框的文件名，不能为中文，中文请自行编码
            response.setHeader("Content-Disposition","attachment;filename=activity.xlsx");
            out = response.getOutputStream();
            excelWriter = activityService.exportExcel();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            excelWriter.flush(out, true);
            // 关闭writer，释放内存
            excelWriter.close();
            //此处记得关闭输出Servlet流
            IoUtil.close(out);
        }
    }


}
