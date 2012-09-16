package biz.thaicom.eBudgeting.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
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
	
	@Autowired
	private ObjectiveService objectiveService;
	
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

		String url = "/eBudgeting/page/m2f06/";
		List<Map<String,String>> breadcrumb = new ArrayList<Map<String,String>>();
		
		logger.debug(searchTerm);
		if(searchTerm == null || searchTerm.length()==0) {
			model.addAttribute("url", "/eBudgeting/Objective/root");
			model.addAttribute("ROOT", true);
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("url", url);
			map.put("value", "ROOT");
			breadcrumb.add(map);
			model.addAttribute("breadcrumb", breadcrumb);
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
			
			Objective objective = null;
			
			// here we recontruct the breadcrumb
			for(int i=0; i<items.size(); i++) {
				
				HashMap<String, String> map = new HashMap<String, String>();
				
				if(i > 0) {
					url = url  + items.get(i) + "/";
					map.put("url", url);
					int index = objective.getIndex()+1;
					map.put("value", objective.getType().getName() + "ที่  " + index);
					breadcrumb.add(map);
					
				} else {
					map.put("url", url);
					map.put("value", "ROOT");
					breadcrumb.add(map);
					
					map = new HashMap<String, String>();
					url = url + items.get(i) + "/";
					map.put("url", url);
					map.put("value", items.get(i));
					breadcrumb.add(map);

				}
				
				if(i+1 < items.size()) {
					// do this if it's not the last one
					Long nextId = null;
					try {
						nextId = Long.parseLong(items.get(i+1));
					} catch (NumberFormatException e) {
						// we should just failed here! 
					}
					
					objective = objectiveService.findOjectiveById(nextId);
				}
				
				
			}
			model.addAttribute("breadcrumb", breadcrumb);
		}
		
		model.addAttribute("currentPath", url);
		return "m2f06";
	}
	
	
	@RequestMapping("/page/m2f11/")
	public String runder_m2f11(
			Model model, HttpServletRequest request) {
		
		return "m2f11";
	}
	
	@RequestMapping("/page/m2f11/{fiscalYear}")
	public String runder_m2f11OfYear(
			@PathVariable Integer fiscalYear,
			Model model, HttpServletRequest request) {
		
		if(fiscalYear == null) {
			logger.debug("make year selection!");
		}
		
		return "m2f11";
	}

}

