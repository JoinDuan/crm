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
@Table(name = "tbl_clue")
@Data
public class Clue {
    @Id
    private String id;

    private String fullname;//全名 联系人名字
    private String appellation;//联系人尊称
    private String owner;//所有者 外键
    private String company;//客户名称- 公司
    private String job;//职位
    private String email;
    private String phone;//公司座机
    private String website;//网站
    private String mphone;//联系人手机
    private String state;//状态
    private String source;//来源
    private String createBy;
    private String createTime;
    private String editBy;
    private String editTime;
    private String description;//描述
    private String contactSummary;//联系纪要
    private String nextContactTime;
    private String address;


}
