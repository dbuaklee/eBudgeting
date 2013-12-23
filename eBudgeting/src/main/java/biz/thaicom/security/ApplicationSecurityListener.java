package biz.thaicom.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationListener;
import org.springframework.security.authentication.event.AbstractAuthenticationEvent;
import org.springframework.security.authentication.event.AuthenticationSuccessEvent;
import org.springframework.security.web.authentication.WebAuthenticationDetails;

public class ApplicationSecurityListener implements ApplicationListener<AbstractAuthenticationEvent> {
	private static final Logger logger = LoggerFactory.getLogger(ApplicationSecurityListener.class);

	@Override
	public void onApplicationEvent(AbstractAuthenticationEvent event) {
		
		if ( event instanceof AuthenticationSuccessEvent )
		{
			AuthenticationSuccessEvent authenticationSuccessEvent = ( AuthenticationSuccessEvent ) event;
			
			WebAuthenticationDetails details = (WebAuthenticationDetails) authenticationSuccessEvent.getAuthentication().getDetails();
			
			logger.debug("authSuccess: " + event.getAuthentication());
			
//			
		}
		else
		{
			logger.debug("undefined: " + event.getClass().getName ());
		}
	}


}
