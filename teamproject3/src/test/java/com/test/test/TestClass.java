package com.test.test;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;

import javax.inject.Inject;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(
		locations = {
				"file:src/main/webapp/WEB-INF/spring/root-context.xml",
				"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
		})
public class TestClass {

	private MockMvc mockMvc;
	
	@Inject
	WebApplicationContext wac;
	
	@Before
	public void init() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();
	}
	
	@Test
	public void doTest() throws Exception {
		mockMvc.perform(post("/announcement/announceAttachment"))
		.andDo(print());
	}
	 
}
