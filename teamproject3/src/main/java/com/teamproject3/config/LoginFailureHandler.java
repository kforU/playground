package com.teamproject3.config;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Service;

/*
 * 비동기 로그인을 지원하는 로그인 실패 핸들러입니다.
 * 로그인 실패시 "failed"라는 문자열을 반환합니다.
 */
@Service
public class LoginFailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {

		response.setHeader("Content-Type", "text/plain;charset-utf-8");
		response.getOutputStream().write("failed".getBytes("utf-8"));
		
	}

}
