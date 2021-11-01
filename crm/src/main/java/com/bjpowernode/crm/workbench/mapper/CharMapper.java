package com.bjpowernode.crm.workbench.mapper;

import com.bjpowernode.crm.workbench.bean.Tran;

import java.util.List;

/**
 * @author dxt
 * @date 2021年07月19日 11:26
 * 统计图表mapper
 */

public interface CharMapper {

    //交易-柱状统计图
    List<Tran> getTranBar();

    //交易-柱状统计图
    List<Tran> getTranPie();
}
