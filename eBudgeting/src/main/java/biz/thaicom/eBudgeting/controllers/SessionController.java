package biz.thaicom.eBudgeting.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.thaicom.eBudgeting.models.pln.Objective;
import biz.thaicom.eBudgeting.models.webui.Breadcrumb;


@Controller
public class SessionController {
	
	private static final Logger logger = LoggerFactory.getLogger(SessionController.class);
	
	
	@RequestMapping(value = "/Session/changeCurrentRootFY", method = RequestMethod.GET)
	public @ResponseBody String changeCurrentRootFY(@RequestParam Integer newFiscalYear, HttpSession session) {
		
		if(session.getAttribute("rootFY") != null) {
			@SuppressWarnings("unchecked")
			List<Objective> rootFy = (List<Objective>) session.getAttribute("rootFY");
			
				
			// now find current fyYear
			for(int i=0; i<rootFy.size(); i++) {
				Objective o = rootFy.get(i);
				if(o.getFiscalYear().equals(newFiscalYear)) {
					session.setAttribute("currentRootFY", o);
					logger.debug("newFiscalyear = "  + newFiscalYear);
					break;
				}
			}
			
		}
		
		return "success";
	}
	
	
	@RequestMapping(value="/Session/updateNavbarBreadcrumb", method = RequestMethod.POST)
	public @ResponseBody String updateNavbarBreadcrumb (
			@RequestParam Integer level, @RequestParam String value, @RequestParam String code, HttpSession session) {
		@SuppressWarnings("unchecked")
		List<Breadcrumb> navbarBreadcrumb  = (List<Breadcrumb>) session.getAttribute("navbarBreadcrumb");
		
		if(navbarBreadcrumb == null) {
			navbarBreadcrumb = new ArrayList<Breadcrumb>();
			Breadcrumb b0 = new Breadcrumb();
			Breadcrumb b1 = new Breadcrumb();
			
			navbarBreadcrumb.add(b0);
			navbarBreadcrumb.add(b1);
		}
		
		if(level == 0) {
			navbarBreadcrumb.get(1).setValue(null);
			navbarBreadcrumb.get(1).setUrl(null);
		}
		
		if(navbarBreadcrumb.get(level) != null) {
			navbarBreadcrumb.get(level).setValue(value);
			navbarBreadcrumb.get(level).setUrl(code);
		}
		
		session.setAttribute("navbarBreadcrumb", navbarBreadcrumb);
		
		return "success";
		
	}
	
}
