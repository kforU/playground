package com.teamproject3.config;

import javax.inject.Inject;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.teamproject3.repository.MemberRepository;
import com.teamproject3.vo.Member;
import com.teamproject3.vo.User;

@Service
public class LoginHandler implements UserDetailsService {
	
	@Inject
	MemberRepository memberRepository;

	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		
		Member member = memberRepository.selectById(email);
		
		// 주어진 이메일에 해당하는 정보가 없거나, deleted 칼럼이 '1'로 되어 있으면 로그인 실패로 간주합니다.
		if (member == null || member.isDeleted())
			throw new UsernameNotFoundException(email);
		
		User user = new User();
		user.setMember(member);
		
		return user;
		
	}

}
