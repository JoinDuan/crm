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
@Table(name = "tbl_dic_type")
@NameStyle(Style.normal)
public class DicType {

    @Id
    private String code;
    private String name;
    private String description;

}
