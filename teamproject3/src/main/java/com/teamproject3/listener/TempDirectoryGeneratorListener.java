package com.teamproject3.listener;

import java.io.File;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/*
 * ContextInitialized 이벤트가 발생하면 MultipartFile의 임시 저장소 폴더를 생성함.
 */
public class TempDirectoryGeneratorListener implements ServletContextListener {
	
	private static Logger logger = LoggerFactory.getLogger(TempDirectoryGeneratorListener.class);

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		
		logger.info("attempt to make directory for multipart processing...");
		
		String rootDirectory = sce.getServletContext().getRealPath("/");
		File tmp = new File(rootDirectory, "../../work/Catalina/localhost/playground/tmp");
		if (!tmp.exists()) {
			tmp.mkdirs();
			logger.debug("{} : MultipartServlet 임시 저장소 폴더 생성...", tmp.getAbsolutePath());
		} else {
			logger.debug("MultipartServlet 임시 저장소 폴더가 이미 존재합니다.");
		}
		
		tmp = new File(rootDirectory + File.separator + "resources/annNavereditor/annUpload");
		if (!tmp.exists()) {
			tmp.mkdirs();
			logger.debug("{} : 공지사항 첨부파일 폴더 생성..", tmp.getAbsolutePath());
		} else {
			logger.debug("공지사항 첨부파일 폴더가 이미 존재합니다.");
		}
		
	}
	
}
