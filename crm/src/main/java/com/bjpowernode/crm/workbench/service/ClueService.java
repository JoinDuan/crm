package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.base.bean.ResultVo;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.bean.Clue;
import com.bjpowernode.crm.workbench.bean.ClueRemark;
import com.bjpowernode.crm.workbench.bean.Tran;
import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Map;

/**
 * @author dxt
 * @date 2021年07月13日 14:39
 */
public interface ClueService {
    //新增clue
    ResultVo addClue(Clue clue, User user);

    //查询clue+分页+模糊查询
    PageInfo queryAllClue(Integer page, Integer pageSize, Clue clue);

    //查询
    Clue queryCustomerById(String id);

    //修改线索
    ResultVo editClue(Clue clue, User user);

    //删除线索-单个与多个
    ResultVo deleteClue(String ids);

    //查询clue+备注+关联的市场活动
    Map<String, Object> queryCustomerAndRemarkAndActivity(String id);

    //查询市场活动排除已经关联的
    List<Activity> queryActivityLike(String id, String name);

    //关联市场活动
    ResultVo<List> relationActivity(String clueId, String activityIds);

    //删除关联市场活动
    ResultVo relationActivityDelete(String clueId, String activityId);

    //新增clue备注
    ResultVo addRemark(ClueRemark clueRemark, User user);

    //删除clue备注
    ResultVo delRemark(String id);

    //修改clue备注
    ResultVo updateRemark(ClueRemark clueRemark, User user);

    //查询线索 根据id
    Clue queryClueById(String id);

    List<Activity> queryClueRelationActivity(String id,String name);

    //线索转换
    ResultVo clueTransForm(String id, String isTran, User user, Tran tran);
}
