package biz.thaicom.security.services;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.web.servlet.handler.UserRoleAuthorizationInterceptor;

import biz.thaicom.eBudgeting.controllers.rest.BudgetTypeRestController;
import biz.thaicom.eBudgeting.repositories.UserRepository;

public class ThaicomAuthenticationProvider implements AuthenticationProvider {
	private static final Logger logger = LoggerFactory.getLogger(ThaicomAuthenticationProvider.class);
	
	@Autowired
	private UserRepository userRepository;
	
	@Override
	public Authentication authenticate(Authentication authentication)
			throws AuthenticationException {
		logger.debug("Trying to authenticatet:" + authentication.getName() + " with Credentials: " + authentication.getCredentials());
		
		 List<GrantedAuthority> AUTHORITIES = new ArrayList<GrantedAuthority>();
	        AUTHORITIES.add(new SimpleGrantedAuthority("ROLE_USER"));
	        if (userRepository.findByUsernameAndPassword(authentication.getName(),(String) authentication.getCredentials()) != null )
	            return new UsernamePasswordAuthenticationToken(authentication.getName(), authentication.getCredentials(), AUTHORITIES);
	        else
	            return null;
	}

	@Override
	public boolean supports(Class<?> authentication) {
		
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}

}
