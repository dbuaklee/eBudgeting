package biz.thaicom.security;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import biz.thaicom.security.models.ThaicomUserDetail;

public class ThaicomAuthenticationProcessingFilter extends
		UsernamePasswordAuthenticationFilter {
	
	private static final Logger logger = LoggerFactory.getLogger(ThaicomAuthenticationProcessingFilter.class);

	@Override
	protected void setDetails(HttpServletRequest request,
			UsernamePasswordAuthenticationToken authRequest) {
		super.setDetails(request, authRequest);
		
		
		
	}

	@Override
	protected void successfulAuthentication(HttpServletRequest request,
			HttpServletResponse response, FilterChain chain,
			Authentication authResult) throws IOException, ServletException {
		// TODO Auto-generated method stub
		super.successfulAuthentication(request, response, chain, authResult);
		
		ThaicomUserDetail userDetail = (ThaicomUserDetail) authResult.getPrincipal();
		
		HttpSession session = request.getSession();
		session.setAttribute("userName", userDetail.getUsername() + "@" + userDetail.getWorkAtAbbr() +  authResult.getAuthorities().toString());
		
		logger.debug("putting this into session: " + userDetail.getUsername() + "@" + userDetail.getWorkAtAbbr() +  authResult.getAuthorities().toString());
	}
	
	

	
}
