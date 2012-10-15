package biz.thaicom.security.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {

	@RequestMapping(value="/login")
	public String login(@RequestParam(required=false) String failed,
			Model model) {
		if(failed != null && failed.length()>0 ) {
			model.addAttribute("failed", true);
		}
		
		return "login";
	}
	
}
