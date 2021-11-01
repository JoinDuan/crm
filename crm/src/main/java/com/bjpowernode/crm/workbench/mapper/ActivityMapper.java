package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.bean.Activity;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Dxt
 * @date 2021/7/6 - 16:35
 */
public interface ActivityMapper extends Mapper<Activity> {

    //新增市场活动
    int insertActivity(Activity activity);

    //修改页面根据id查单条
    Activity queryActivityById(String id);

    //查询activity，带模糊查询
    List<Activity> selectActivityAndLikeByOwner(@Param("activity") Activity activity, @Param("userIdList")List<String> userIdList);

    //根据单个删除
    int deleteById(String id);

    //查询线索没有关联的市场活动
    ArrayList<Activity> selectActivityWhereIdNotIn(@Param("list") ArrayList<String> idList,@Param("name")String name);
    //查询市场活动-模糊查询
    ArrayList<Activity> selectLikeName(String name);

    //根据名称 精准查询-id
    Activity selectByName(String activityName);

    //根据联系人id查询市场活动
    List<Activity> selectContactsActivityWhereIdIn(String id);
    //    <!--根据联系人id，市场活动吗名字，模糊查询市场活动，排除掉已经关联的-->
    List<Activity> selectContactsActivityIdNotInAndNameLike(@Param("activityName") String activityName,@Param("contactsId") String contactsId);
}
