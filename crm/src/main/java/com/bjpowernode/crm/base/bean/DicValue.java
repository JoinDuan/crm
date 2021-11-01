package com.bjpowernode.crm.base.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;
@NoArgsConstructor
@AllArgsConstructor
@Data
@Table(name = "tbl_dic_value")
@NameStyle(Style.normal)
public class DicValue {

    @Id
    private String id;
    private String value;//option标签中value属性
    private String text;//option标签的文本
    private String orderNo;//排序字段
    private String typeCode;

}
