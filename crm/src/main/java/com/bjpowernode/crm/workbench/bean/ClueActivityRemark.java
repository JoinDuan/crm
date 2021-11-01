package com.bjpowernode.crm.workbench.bean;

import lombok.Data;
import tk.mybatis.mapper.annotation.NameStyle;

import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author dxt
 * @date 2021年07月14日 9:05
 */
@NameStyle
@Table(name = "tbl_clue_activity_relation")
@Data
public class ClueActivityRemark {

    @Id
    private String id;

    private String clueId;
    private String activityId;

}
