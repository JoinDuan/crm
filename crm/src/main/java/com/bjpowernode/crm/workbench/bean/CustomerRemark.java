package com.bjpowernode.crm.workbench.bean;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * @author Dxt
 * @date 2021/7/10 - 8:59
 */
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Table(name = "tbl_customer_remark")
@NameStyle(Style.normal)
public class CustomerRemark {
    @Id
    private String id;

    private String noteContent; //备注内容
    private String createBy; //创建人
    private String createTime;//创建时间
    private String editBy;//修改人
    private String editTime;//修改时间
    private String editFlag;//修改标记
    private String customerId; //外健，客户id

    @Transient//数据库中没有的字段
    private String imag;

}
