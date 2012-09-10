package biz.thaicom.eBudgeting.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.HandlerMapping;

import biz.thaicom.eBudgeting.model.bgt.Objective;
import biz.thaicom.eBudgeting.services.ObjectiveService;

@Controller
public class GenericViewController {

	public static Logger logger = LoggerFactory.getLogger(GenericViewController.class);
	
	@RequestMapping("/jsp/{jspName}")
	public String renderJsp(@PathVariable String jspName) {
		
		return jspName;
	}
	
	@RequestMapping("/page/m2f06/**")
	public String render_m2f06(Model model, HttpServletRequest request) {
		String pattern = (String)
		        request.getAttribute(HandlerMapping.BEST_MATCHING_PATTERN_ATTRIBUTE); 
		
		String searchTerm = new AntPathMatcher().extractPathWithinPattern(pattern, 
		        request.getServletPath());

		
		
		logger.debug(searchTerm);
		if(searchTerm == null || searchTerm.length()==0) {
			model.addAttribute("url", "/eBudgeting/Objective/root");
		} else {
			// now tokenized the string
			StringTokenizer token = new StringTokenizer(searchTerm,"/");
			List<String> items = new ArrayList<String>();
			while(token.hasMoreTokens()){
				items.add(token.nextToken());
			}
			
			if(items.size() == 1) {
				// first part is year
				model.addAttribute("url", "/eBudgeting/Objective/root/"+items.get(0));
			} else {
				model.addAttribute("url", "/eBudgeting/Objective/"+items.get(items.size()-1)+"/children");
				model.addAttribute("lastObjectiveId", items.get(items.size()-1));
				// now we need all parents of this object
				
			}
			
		}
		
		return "m2f06";
	}
}
