package com.teamproject3.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Pattern;

import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.teamproject3.repository.MemberRepository;
import com.teamproject3.vo.Member;
import com.teamproject3.vo.PageRequest;

@Service
public class MemberService implements ServletContextAware {
	
	@Inject MemberRepository memberRepository;
	@Inject PasswordEncoder passwordEncoder;
	private ServletContext servletContext;
	
	public static final String SUCCESS = "success";
	public static final String FAILED = "failed";
	public static final String WRONG_EMAIL = "wrong_email";
	public static final String WRONG_PASSWD = "wrong_passwd";
	public static final String WRONG_NAME = "wrong_name";
	
	public static final String EMAIL_CANNOT_BE_NULL = "email_cannot_be_null";
	public static final String FORMAT_NOT_ACCEPT = "format_not_acccept";

	@Transactional
	public String registerMember(Member member) {
		
		String email = member.getEmail();
		String passwd = member.getPasswd();
		String name = member.getName();
		
		if (!validateEmail(email)) 
			return WRONG_EMAIL;
		if (!validatePasswd(passwd))
			return WRONG_PASSWD;
		if (!validateName(name))
			return WRONG_NAME;
		
		// 비밀번호 암호화
		member.setPasswd(passwordEncoder.encode(passwd));
		
		// member 저장
		memberRepository.insert(member);
		
		return SUCCESS;
	}

	private boolean validateEmail(String email) {
		return email != null || Pattern.matches("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$", email);
	}

	private boolean validatePasswd(String passwd) {
		return passwd != null || Pattern.matches("^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$", passwd);
	}

	private boolean validateName(String name) {
		return name != null || Pattern.matches("^[a-zA-Z0-9ㄱ-ㅎ가-힣]{2,24}$", name);
	}
	
	public List<Member> findAll(int start, int end, PageRequest pageRequest) {
		return memberRepository.selectAll(
				start, end, 
				pageRequest.getSearchOption(),
				pageRequest.getSearchValue());
	}
	
	public int count(PageRequest pageRequest) {
		return memberRepository.count(
				pageRequest.getSearchOption(), 
				pageRequest.getSearchValue());
	}
	
	// 이메일로 프로필 이미지를 가져옴
	public String getProfileImage(String email) {
		
		if (email == null || email.isEmpty()) 
			return EMAIL_CANNOT_BE_NULL;
		
		return memberRepository.selectProfileImageById(email);
	}
	
	// src/main/resources/images/user/profile 경로에 저장
	public String uploadProfileImage(String email, MultipartFile profileImage) throws IOException {
		
		// 이메일이 없으면 안됨...
		if (email == null || email.isEmpty()) {
			return EMAIL_CANNOT_BE_NULL;
		}
		
		// 파일 이름과 포맷을 얻음
		String filename = profileImage.getOriginalFilename();
		String format = filename.substring(filename.lastIndexOf('.') + 1);
		
		// 이미지 파일이 아닌 경우 업로드 거부
		if (!isImageFormat(format))
			return FORMAT_NOT_ACCEPT;
		
		// 저장 경로를 얻음
		String rootPath = servletContext.getRealPath("resources/images/user/profile");
		
		// UUID를 붙여 중복 방지
		String savedPath = UUID.randomUUID().toString() + "_" + filename;
		String targetPath = rootPath + File.separator + savedPath;
		
		// 파일 저장
		FileOutputStream fos = new FileOutputStream(new File(targetPath));
		fos.write(profileImage.getBytes());
		fos.close();
		
		// DB에 파일 경로 저장
		Member member = new Member();
		member.setEmail(email);
		member.setImage(savedPath);
		memberRepository.saveProfileImage(member);
		
		return "success";
	}

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}
	
	// 주어진 포맷 문자열이 이미지 형식인지를 판별
	private boolean isImageFormat(String format) {
		
		// 파일 포맷이 없는 경우 업로드 불가능
		if (format == null || format.isEmpty())
			return false;
		
		// 이미지 포맷이 아닌 경우, 업로드 불가능
		if (!format.equalsIgnoreCase("jpg") &&
			!format.equalsIgnoreCase("jpeg") &&
			!format.equalsIgnoreCase("bmp") &&
			!format.equalsIgnoreCase("gif") &&
			!format.equalsIgnoreCase("png")) {
			return false;
		}
		
		return true;
	}
	
	// 멤버 삭제 처리
	public String deleteMember(String email) {
		try {
			memberRepository.delete(email);
		} catch (Exception e) {
			e.printStackTrace();
			return FAILED;
		}
		return SUCCESS;
	}
	
	// 멤버 계정 복구
	public String recoverMember(String email) {
		try {
			memberRepository.recover(email);
		} catch (Exception e) {
			e.printStackTrace();
			return FAILED;
		}
		return SUCCESS;
	}
	
	// 멤버를 비활성화 함
	public String inactivateMember(String email) {
		try {
			memberRepository.inactivate(email);
		} catch (Exception e) {
			e.printStackTrace();
			return FAILED;
		}
		return SUCCESS;
	}
	
	// 멤버를 활성화 함
	public String activateMember(String email) {
		try {
			memberRepository.activate(email);
		} catch (Exception e) {
			e.printStackTrace();
			return FAILED;
		}
		return SUCCESS;
	}
	
	// 비밀번호를 변경하는 서비스
	public String changePassword(String json) {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> params = null;
		
		try {
			params = mapper.readValue(json, new TypeReference<Map<String, String>>(){});
		} catch (IOException e) {
			e.printStackTrace();
			return FAILED;
		}
		
		String email = params.get("email");
		String passwd = params.get("passwd");
		String newPassword = params.get("newPassword");
		String confirmPassword = params.get("confirmPassword");
		
		// 하나라도 null일 경우 실패
		if (email == null || passwd == null || newPassword == null || confirmPassword == null)
			return FAILED;
		
		// 기존 비밀번호가 일치하지 않으면 인증 실패
		Member member = memberRepository.selectById(email);
		if (!passwordEncoder.matches(passwd, member.getPasswd()))
			return "authentication_failed";
		
		// 새로이 입력한 비밀번호 두개가 일치하지 않으면 실패
		if (!newPassword.equals(confirmPassword))
			return "password_not_match";
		
		// 비밀번호 해시화 한 후 저장
		member.setPasswd(passwordEncoder.encode(newPassword));
		try {
			memberRepository.update(member);
		} catch (Exception e) {
			e.printStackTrace();
			return FAILED;
		}

		return SUCCESS;
	}
	
	// 이름 변경 로직
	public String changeName(String json) {
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> params = null;
		
		try {
			params = mapper.readValue(json, new TypeReference<Map<String, String>>(){});
		} catch (Exception e) {
			e.printStackTrace();
			return FAILED;
		}
		
		String name = params.get("name");
		String passwd = params.get("passwd");
		String email = params.get("email");
		
		// 입력값이 하나라도 null이면 실패
		if (name == null || passwd == null || email == null) {
			return FAILED;
		}
		
		Member member = memberRepository.selectById(email);
		
		// Request의 비밀번호가 다르면 실패
		if (!passwordEncoder.matches(passwd, member.getPasswd())) {
			return FAILED;
		}
		
		member.setName(name);
		try {
			memberRepository.update(member);
		} catch(Exception e) {
			e.printStackTrace();
			return FAILED;
		}
		
		return SUCCESS;
	}

	public int countQuestionById(String email) {
		return memberRepository.countQuestionById(email);
	}

}
