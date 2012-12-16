package biz.thaicom.eBudgeting.controllers;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import biz.thaicom.eBudgeting.models.pln.Objective;
import biz.thaicom.eBudgeting.services.EntityService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private EntityService entityService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	private static final SimpleDateFormat buddhistYearSDF = new SimpleDateFormat("yyyy", new Locale("th","TH"));
	private static final SimpleDateFormat monthSDF = new SimpleDateFormat("MM", new Locale("th","TH"));
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session ) {
		
		List<Objective> root = entityService.findRootFiscalYear();
		
		if(root!= null && root.size() > 0) {
			session.setAttribute("rootFY", root);
		}
		
		if(session.getAttribute("currentRootFY") == null) {
			Integer year = Integer.parseInt(buddhistYearSDF.format(new Date()));
			Integer month = Integer.parseInt(monthSDF.format(new Date()));
			if(month > 9) {
				year = year+1;
			}
			
			// now find current fyYear
			for(int i=0; i<root.size(); i++) {
				Objective o = root.get(i);
				if(o.getFiscalYear().equals(year)) {
					session.setAttribute("currentRootFY", o);
					logger.debug("year = "  + year);
					break;
				}
			}
		}
		
		model.addAttribute("fySltEnable", true);
		return "dashboard";
	}
	
}
