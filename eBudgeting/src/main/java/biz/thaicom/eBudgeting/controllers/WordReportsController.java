package biz.thaicom.eBudgeting.controllers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import biz.thaicom.eBudgeting.models.pln.ObjectiveDetail;
import biz.thaicom.eBudgeting.services.EntityService;
import biz.thaicom.security.models.Activeuser;
import biz.thaicom.security.models.ThaicomUserDetail;

@Controller
public class WordReportsController {
	private static final Logger logger = LoggerFactory.getLogger(WordReportsController.class);
	
	// กำหนด entityService ไว้ใช้ในการดึง database
	@Autowired
	public EntityService entityService;
	
	
	@RequestMapping("/m61f04.docx/{fiscalYear}/ObejctiveDetail/{objectiveDetailId}/m61f04.docx")
	public String m61f04WordReport(Model model, 
			@PathVariable Long objectiveDetailId,
			@PathVariable Integer fiscalYear,
			@Activeuser ThaicomUserDetail currentUser) {
		
		ObjectiveDetail detail = entityService.findOneObjectiveDetail(objectiveDetailId);
		
		model.addAttribute("detail", detail);
		model.addAttribute("currentUser", currentUser);
		
		return "m61f04.docx";
	}
	
	
}
