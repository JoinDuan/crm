package com.bjpowernode.crm.workbench.bean;

import lombok.Data;
import tk.mybatis.mapper.annotation.NameStyle;

import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author dxt
 * @date 2021年07月13日 14:33
 */
@NameStyle
@Table(name = "tbl_clue_remark")
@Data
public class ClueRemark {

    @Id
    private String id;

    private String noteContent;
    private String createBy;
    private String createTime;
    private String editBy;
    private String editTime;
    private String editFlag;
    private String clueId;


}
