package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.base.bean.BarVo;
import com.bjpowernode.crm.base.bean.PieVo;

import java.util.List;

/**
 * 统计图表业务层接口
 */
public interface CharService {
    //交易-柱状统计图
    BarVo getTranBar();

    //交易-饼图
    List<PieVo> getTranPie();
}
