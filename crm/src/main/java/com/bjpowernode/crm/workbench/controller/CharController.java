package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.base.bean.BarVo;
import com.bjpowernode.crm.base.bean.PieVo;
import com.bjpowernode.crm.workbench.service.CharService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


/**
 * @author dxt
 * @date 2021年07月19日 11:24
 * 统计图表控制器
 */
@RestController
public class CharController {

    @Autowired
    private CharService charService;

    /**
     * 交易-柱状统计图
     * @return
     */
    @GetMapping(value = "/workbench/chart/transaction/bar")
    public BarVo bar(){
        BarVo barVo = charService.getTranBar();
        return barVo;
    }

    /**
     * 交易-饼图
     * @return
     */
    @GetMapping(value = "/workbench/chart/transaction/pie")
    public List<PieVo> pie(){
        List<PieVo> pieVoList = charService.getTranPie();
        return pieVoList;
    }


}
