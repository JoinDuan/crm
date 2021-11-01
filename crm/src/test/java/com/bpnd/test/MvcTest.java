package com.bpnd.test;

import com.bjpowernode.crm.workbench.bean.Contacts;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * Spring提供的单元测试模块，提供的测试请求功能，测试 crud请求的准确性
 * @WebAppConfiguration +  @Autowired 才能把 MVC的ioc容器注入进来
 *
 * @author dsir
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:spring/applicationContext.xml","file:D:/java-projects-idea/05-CRM/crm/src/main/resources/spring/applicationContext.xml"})
public class MvcTest {

    //传入SpringMVC的ioc
    @Autowired
    WebApplicationContext context;

    //注入虚拟的MVC,获取处理结果
    MockMvc mockMvc;

    @Before//junit的before  不是 aspectJ的before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    /**
     * 测试分页的方法
     * get("/emps")  项目发送请求的uri
     * param("pn","1") 参数  public String getEmps(@RequestParam(value = "pn",defaultValue = "1")
     * andReturn()：拿到返回值
     */
    @Test
    public void testPage() throws Exception {
        //模拟请求拿到返回值
        Contacts contacts1 = new Contacts();
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/workbench/contacts/queryAllContacts")
                .param("page", "1").param("pageSize", "3")).andReturn();

        //请求成功之后，请求域中会有pageInfo，取出pageInfo进行验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码:"+pageInfo.getPageNum());
        System.out.println("总页码:"+pageInfo.getPages());
        System.out.println("总记录数:"+pageInfo.getTotal());
        int[] nums = pageInfo.getNavigatepageNums();
        for (int i : nums) {
            System.out.println("在页面需要连续显示的页码:"+i);
        }
        //获取数据
        List<Contacts> list = pageInfo.getList();
        for (Contacts contacts : list) {
            System.out.println("ID:"+contacts.getId()+",name:"+contacts.getFullname());
        }


    }

}
