package com.teamproject3.config;

import javax.inject.Inject;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Inject
	UserDetailsService loginHandler;
	@Inject
	AuthenticationSuccessHandler loginSuccessHandler;
	@Inject
	AuthenticationFailureHandler loginFailureHandler;
	
	@Override
	public void configure(WebSecurity web) throws Exception {
		web
			.ignoring()
			.antMatchers("/resources/**");
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth
			.userDetailsService(loginHandler)
			.passwordEncoder(passwordEncoder());
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
			.csrf().disable()
			.headers().disable()
			.authorizeRequests()
				.antMatchers("/announcement/QnApage")		.access("isAuthenticated()")
				.antMatchers("/ticket/payment")				.access("isAuthenticated()")
				.antMatchers("/member/info")				.access("isAuthenticated()")
				.antMatchers("/member/delete")				.access("isAuthenticated()")
				.antMatchers("/member/recover")				.access("isAuthenticated()")
				.antMatchers("/member/active")				.access("isAuthenticated()")
				.antMatchers("/member/inactive")			.access("isAuthenticated()")
				.antMatchers("/member/uploadProfileImage")	.access("isAuthenticated()")
				.antMatchers("/member/getReservationList")	.access("isAuthenticated()")
				.antMatchers("/producPayment")				.access("isAuthenticated()")
				.antMatchers("/admin/**")					.hasAuthority("ROLE_ADMIN")
				.antMatchers("/**").permitAll()
				.and()
				
			.formLogin()
				.loginPage("/member/login")
				.loginProcessingUrl("/member/doLogin")
				.usernameParameter("email")
				.passwordParameter("passwd")
				.successHandler(loginSuccessHandler)
				.failureHandler(loginFailureHandler)
				.permitAll()
				.and()
				
			.logout()
				.deleteCookies("JSESSIONID")
				.invalidateHttpSession(true)
				.logoutUrl("/member/logout")
				.logoutSuccessUrl("/member/login?logout")
				.and()
				
			.rememberMe()
				.key("myAppKey")
				.tokenValiditySeconds(86400)
				.and()
				
			.sessionManagement()
				.maximumSessions(3)
				.maxSessionsPreventsLogin(true)
				.expiredUrl("/member/login?expired");
	}
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

}
