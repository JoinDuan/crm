package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.base.bean.BarVo;
import com.bjpowernode.crm.base.bean.PieVo;
import com.bjpowernode.crm.workbench.bean.Tran;
import com.bjpowernode.crm.workbench.mapper.CharMapper;
import com.bjpowernode.crm.workbench.mapper.TranMapper;
import com.bjpowernode.crm.workbench.service.CharService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @author dxt
 * @date 2021年07月19日 11:25
 */
@Service
public class CharServiceImpl implements CharService {

    @Autowired
    private CharMapper charMapper;


    /**
     * 交易-柱状统计图
     * @return
     */
    @Override
    public BarVo getTranBar() {
        BarVo barVo = new BarVo();

        List<String> dataList = new ArrayList();
        List<String> titlesList = new ArrayList();

        List<Tran> tranList = charMapper.getTranBar();
        for (Tran tran : tranList) {
            titlesList.add(tran.getStage());
            dataList.add(tran.getMoney());
        }
        barVo.setTitles(titlesList);
        barVo.setData(dataList);
        return barVo;
    }

    /**
     * 交易-饼图
     * @return
     */
    @Override
    public List<PieVo> getTranPie() {
        List<Tran> tranList = charMapper.getTranBar();
        List<PieVo> pieVos = new ArrayList<>();
        for (Tran tran : tranList) {
            PieVo pieVo = new PieVo();
            pieVo.setValue(Long.parseLong(tran.getMoney()+""));
            pieVo.setName(tran.getStage());
            pieVos.add(pieVo);
        }
        return pieVos;
    }


}
