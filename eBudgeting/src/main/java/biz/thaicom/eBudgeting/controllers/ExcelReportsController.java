package biz.thaicom.eBudgeting.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ExcelReportsController {
	@RequestMapping("/excel/sample/")
	public String excelSample(Model model) {
		
		
		return "m2f13";
	}
}
