package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.bean.Activity;
import com.bjpowernode.crm.workbench.bean.Clue;
import com.bjpowernode.crm.workbench.bean.ClueRemark;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * @author dxt
 * @date 2021年07月13日 14:37
 * 线索接口
 */
public interface ClueMapper extends Mapper<Clue> {

    //查询所有clue，带模糊查询
    List<Clue> selectAllClueAndLike(Clue clue);

    //根据id查单条
    Clue selectClueById(String id);

    //根据clue的ID，查询关联的对应的市场活动
    List<Activity> selectRelationActivity(String id);
    //根据clue的id，查询对应的线索备注
    List<ClueRemark> selectClueRemarkByClueId(String id);

    List<Activity> selectRelationActivityAndLikeName(@Param("id") String id,@Param("name") String name);
}
