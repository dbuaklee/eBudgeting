package biz.thaicom.security.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint;

public class AjaxAwareAuthenticationEntryPoint extends
		LoginUrlAuthenticationEntryPoint {

	public AjaxAwareAuthenticationEntryPoint(final String loginFormUrl) {
	    super(loginFormUrl);
	  }

	  @Override
	  public void commence(final HttpServletRequest request, final HttpServletResponse response, final AuthenticationException authException)
	      throws IOException, ServletException {

	    if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
	      response.sendError(403, "Forbidden");
	    } else {
	      super.commence(request, response, authException);
	    }
	  }
	
}
