package com.bjpowernode.crm.workbench.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author dxt
 * @date 2021年07月12日 8:39
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
@Table(name = "tbl_contacts")
@NameStyle(Style.normal)
public class Contacts {

    @Id
    private String id;

    private String owner;//所有者
    private String source;//来源
    private String customerId;//客户id
    private String fullname;//全名
    private String appellation;//称呼
    private String email;//邮件
    private String mphone;//电话
    private String job;//工作,职位
    private String birth;//生日
    private String createBy;//创建人
    private String createTime;//创建时间
    private String editBy;//修改人
    private String editTime;//修改时间
    private String description;//描述
    private String contactSummary;//联系纪要
    private String nextContactTime;//下次联系时间
    private String address;//地址


}
