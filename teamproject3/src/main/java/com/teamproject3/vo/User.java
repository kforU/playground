package com.teamproject3.vo;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

/*
 * SpringSecurity에서 요구하는 UserDetails 구현체입니다.
 * Member객체를 멤버로 가짐
 */
public class User implements UserDetails {
	private static final long serialVersionUID = 6121628407035049020L;
	Member member;

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		List<GrantedAuthority> authorities = new ArrayList<>();
		authorities.add(new SimpleGrantedAuthority(member.getRole()));
		return authorities;
	}

	@Override
	public String getPassword() {
		return member.getPasswd();
	}

	@Override
	public String getUsername() {
		return member.getEmail();
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}
	
	public void setMember(Member member) {
		this.member = member;
	}
	
	public Member getMember() {
		return member;
	}

}
