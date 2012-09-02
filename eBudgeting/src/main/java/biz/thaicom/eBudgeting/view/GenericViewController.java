package biz.thaicom.eBudgeting.view;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GenericViewController {

	public static Logger logger = LoggerFactory.getLogger(GenericViewController.class);
	
	@RequestMapping("/jsp/{jspName}")
	public String renderJsp(@PathVariable String jspName) {
		
		return jspName;
	}
}
