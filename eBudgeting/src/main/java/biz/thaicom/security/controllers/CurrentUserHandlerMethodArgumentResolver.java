package biz.thaicom.security.controllers;

import java.security.Principal;

import org.springframework.core.MethodParameter;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import biz.thaicom.security.models.Activeuser;
import biz.thaicom.security.models.ThaicomUserDetail;


public class CurrentUserHandlerMethodArgumentResolver implements HandlerMethodArgumentResolver {

	@Override
	public boolean supportsParameter(MethodParameter parameter) {
		// TODO Auto-generated method stub
		return parameter.hasParameterAnnotation(Activeuser.class);
	}

	@Override
	public Object resolveArgument(MethodParameter parameter,
			ModelAndViewContainer mavContainer, NativeWebRequest webRequest,
			WebDataBinderFactory binderFactory) throws Exception {
		if(parameter.hasParameterAnnotation(Activeuser.class)) {
			Principal princial = webRequest.getUserPrincipal();
			return (ThaicomUserDetail) ((Authentication) princial).getPrincipal();
		}
		return null;
	}
	
	   

	
}
