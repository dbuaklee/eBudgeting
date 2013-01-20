package biz.thaicom.eBudgeting.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;


import biz.thaicom.eBudgeting.models.bgt.BudgetType;
import biz.thaicom.eBudgeting.models.pln.Objective;
import biz.thaicom.eBudgeting.models.pln.ObjectiveType;
import biz.thaicom.eBudgeting.models.pln.TargetUnit;
import biz.thaicom.eBudgeting.services.EntityService;

@Controller
public class ExcelReportsController {

	
	// กำหนด entityService ไว้ใช้ในการดึง database
	@Autowired
	public EntityService entityService;
	
	
	@RequestMapping("/admin/excel/sample.xls")
	public String excelSample(Model model) {
		model.addAttribute("fiscalYear", 2556);
		
		return "sample.xls";
	}

	@RequestMapping("/m51r01.xls/{fiscalYear}/file/m51r01.xls")
	public String excelM51R01(@PathVariable Integer fiscalYear, Model model) {
		
		ObjectiveType type = entityService.findObjectiveTypeById((long) 109);
		
		List<Objective> objectiveList = entityService.findObjectivesByFiscalyearAndTypeId(fiscalYear, (long) 109);
		
		model.addAttribute("type", type);
		model.addAttribute("objectiveList", objectiveList);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m51r01.xls";
	}

	@RequestMapping("/m51r02.xls/{fiscalYear}/file/m51r02.xls")
	public String excelM51R02(@PathVariable Integer fiscalYear, Model model) {
		
		ObjectiveType type = entityService.findObjectiveTypeById((long) 121);
		
		List<Objective> objectiveList = entityService.findObjectivesByFiscalyearAndTypeId(fiscalYear, (long) 121);
		
		model.addAttribute("type", type);
		model.addAttribute("objectiveList", objectiveList);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m51r02.xls";
	}

	@RequestMapping("/m51r03.xls/{fiscalYear}/file/m51r03.xls")
	public String excelM51R03(@PathVariable Integer fiscalYear, Model model) {
		
		ObjectiveType type = entityService.findObjectiveTypeById((long) 110);
		
		List<Objective> objectiveList = entityService.findObjectivesByFiscalyearAndTypeId(fiscalYear, (long) 110);
		
		model.addAttribute("type", type);
		model.addAttribute("objectiveList", objectiveList);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m51r03.xls";
	}

	@RequestMapping("/m51r04.xls/{fiscalYear}/file/m51r04.xls")
	public String excelM51R04(@PathVariable Integer fiscalYear, Model model) {
		
		ObjectiveType type = entityService.findObjectiveTypeById((long) 111);
		
		List<Objective> objectiveList = entityService.findObjectivesByFiscalyearAndTypeId(fiscalYear, (long) 111);
		
		model.addAttribute("type", type);
		model.addAttribute("objectiveList", objectiveList);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m51r04.xls";
	}

	@RequestMapping("/m51r05.xls/{fiscalYear}/file/m51r05.xls")
	public String excelM51R05(@PathVariable Integer fiscalYear, Model model) {
		
		ObjectiveType type = entityService.findObjectiveTypeById((long) 112);
		
		List<Objective> objectiveList = entityService.findObjectivesByFiscalyearAndTypeId(fiscalYear, (long) 112);
		
		model.addAttribute("type", type);
		model.addAttribute("objectiveList", objectiveList);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m51r05.xls";
	}

	@RequestMapping("/m51r06.xls/{fiscalYear}/file/m51r06.xls")
	public String excelM51R06(@PathVariable Integer fiscalYear, Model model) {
		
		ObjectiveType type = entityService.findObjectiveTypeById((long) 101);
		
		List<Objective> objectiveList = entityService.findObjectivesByFiscalyearAndTypeId(fiscalYear, (long) 101);
		
		model.addAttribute("type", type);
		model.addAttribute("objectiveList", objectiveList);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m51r06.xls";
	}

	@RequestMapping("/m51r07.xls/{fiscalYear}/file/m51r07.xls")
	public String excelM51R07(@PathVariable Integer fiscalYear, Model model) {
		
		ObjectiveType type = entityService.findObjectiveTypeById((long) 102);
		
		List<Objective> objectiveList = entityService.findObjectivesByFiscalyearAndTypeId(fiscalYear, (long) 102);
		
		model.addAttribute("type", type);
		model.addAttribute("objectiveList", objectiveList);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m51r07.xls";
	}

	@RequestMapping("/m51r08.xls/{fiscalYear}/file/m51r08.xls")
	public String excelM51R08(@PathVariable Integer fiscalYear, Model model) {
		
		ObjectiveType type = entityService.findObjectiveTypeById((long) 103);
		
		List<Objective> objectiveList = entityService.findObjectivesByFiscalyearAndTypeId(fiscalYear, (long) 103);
		
		model.addAttribute("type", type);
		model.addAttribute("objectiveList", objectiveList);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m51r08.xls";
	}

	@RequestMapping("/m51r09.xls/{fiscalYear}/file/m51r09.xls")
	public String excelM51R09(@PathVariable Integer fiscalYear, Model model) {
		
		ObjectiveType type = entityService.findObjectiveTypeById((long) 104);
		
		List<Objective> objectiveList = entityService.findObjectivesByFiscalyearAndTypeId(fiscalYear, (long) 104);
		
		model.addAttribute("type", type);
		model.addAttribute("objectiveList", objectiveList);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m51r09.xls";
	}

	@RequestMapping("/m51r10.xls/{fiscalYear}/file/m51r10.xls")
	public String excelM51R10(@PathVariable Integer fiscalYear, Model model) {
		
		ObjectiveType type = entityService.findObjectiveTypeById((long) 105);
		
		List<Objective> objectiveList = entityService.findObjectivesByFiscalyearAndTypeId(fiscalYear, (long) 105);
		
		model.addAttribute("type", type);
		model.addAttribute("objectiveList", objectiveList);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m51r10.xls";
	}

	@RequestMapping("/m51r11.xls/{fiscalYear}/file/m51r11.xls")
	public String excelM51R11(@PathVariable Integer fiscalYear, Model model) {
		
		ObjectiveType type = entityService.findObjectiveTypeById((long) 106);
		
		List<Objective> objectiveList = entityService.findObjectivesByFiscalyearAndTypeId(fiscalYear, (long) 106);
		
		model.addAttribute("type", type);
		model.addAttribute("objectiveList", objectiveList);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m51r11.xls";
	}

	@RequestMapping("/m51r12.xls/{fiscalYear}/file/m51r12.xls")
	public String excelM51R12(@PathVariable Integer fiscalYear, Model model) {
		
		ObjectiveType type = entityService.findObjectiveTypeById((long) 107);
		
		List<Objective> objectiveList = entityService.findObjectivesByFiscalyearAndTypeId(fiscalYear, (long) 107);
		
		model.addAttribute("type", type);
		model.addAttribute("objectiveList", objectiveList);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m51r12.xls";
	}

	@RequestMapping("/m51r13.xls/{fiscalYear}/file/m51r13.xls")
	public String excelM51R13(@PathVariable Integer fiscalYear, Model model) {
		
		ObjectiveType type = entityService.findObjectiveTypeById((long) 108);
		
		List<Objective> objectiveList = entityService.findObjectivesByFiscalyearAndTypeId(fiscalYear, (long) 108);
		
		model.addAttribute("type", type);
		model.addAttribute("objectiveList", objectiveList);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m51r13.xls";
	}

	@RequestMapping("/m51r14.xls/{fiscalYear}/file/m51r14.xls")
	public String excelM51R14(@PathVariable Integer fiscalYear, Model model) {
		
		List<BudgetType> type = entityService.findBudgetTypeByLevel(fiscalYear, 3);
		
		model.addAttribute("type", type);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m51r14.xls";
	}

	@RequestMapping("/m51r15.xls/{fiscalYear}/file/m51r15.xls")
	public String excelM51R15(@PathVariable Integer fiscalYear, Model model) {
		
		List<BudgetType> type = entityService.findBudgetTypeByLevel(fiscalYear, 3);
		
		model.addAttribute("type", type);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m51r15.xls";
	}

	@RequestMapping("/m51r17.xls/{fiscalYear}/file/m51r17.xls")
	public String excelM51R17(@PathVariable Integer fiscalYear, Model model) {
		
		Objective root = entityService.findOneRootObjectiveByFiscalyear(fiscalYear);
		
		List<Objective> objectiveList = entityService.findAllObjectiveChildren(root.getId());
		
		model.addAttribute("objectiveList", objectiveList);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m51r17.xls";
	}

	@RequestMapping("/m51r18.xls/{fiscalYear}/file/m51r18.xls")
	public String excelM51R18(@PathVariable Integer fiscalYear, Model model) {
		
		List<TargetUnit> unit = entityService.findAllTargetUnits();
		
		model.addAttribute("unit", unit);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m51r18.xls";
	}

	@RequestMapping("/m52r01.xls/{fiscalYear}/file/m52r01.xls")
	public String excelM52R01(@PathVariable Integer fiscalYear, Model model) {
		
		ObjectiveType type = entityService.findObjectiveTypeById((long) 113);
		
		List<Objective> objectiveList = entityService.findObjectivesByFiscalyearAndTypeId(fiscalYear, (long) 113);
		
		model.addAttribute("type", type);
		model.addAttribute("objectiveList", objectiveList);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m52r01.xls";
	}

	@RequestMapping("/m53r01.xls/{fiscalYear}/file/m53r01.xls")
	public String excelM53R01(@PathVariable Integer fiscalYear, Model model) {
		
		ObjectiveType type = entityService.findObjectiveTypeById((long) 114);
		
		List<Objective> objectiveList = entityService.findObjectivesByFiscalyearAndTypeId(fiscalYear, (long) 114);
		
		model.addAttribute("type", type);
		model.addAttribute("objectiveList", objectiveList);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m53r01.xls";
	}

	@RequestMapping("/m53r02.xls/{fiscalYear}/file/m53r02.xls")
	public String excelM53R02(@PathVariable Integer fiscalYear, Model model) {
		
		ObjectiveType type = entityService.findObjectiveTypeById((long) 115);
		
		List<Objective> objectiveList = entityService.findObjectivesByFiscalyearAndTypeId(fiscalYear, (long) 115);
		
		model.addAttribute("type", type);
		model.addAttribute("objectiveList", objectiveList);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m53r02.xls";
	}

	@RequestMapping("/m53r03.xls/{fiscalYear}/file/m53r03.xls")
	public String excelM53R03(@PathVariable Integer fiscalYear, Model model) {
		
		ObjectiveType type = entityService.findObjectiveTypeById((long) 116);
		
		List<Objective> objectiveList = entityService.findObjectivesByFiscalyearAndTypeId(fiscalYear, (long) 116);
		
		model.addAttribute("type", type);
		model.addAttribute("objectiveList", objectiveList);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m53r03.xls";
	}

	@RequestMapping("/m54r01.xls/{fiscalYear}/file/m54r01.xls")
	public String excelM54R01(@PathVariable Integer fiscalYear, Model model) {
		
		ObjectiveType type = entityService.findObjectiveTypeById((long) 118);
		
		List<Objective> objectiveList = entityService.findObjectivesByFiscalyearAndTypeId(fiscalYear, (long) 118);
		
		model.addAttribute("type", type);
		model.addAttribute("objectiveList", objectiveList);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m54r01.xls";
	}

	@RequestMapping("/admin/excel/report1.xls/{id}")
	public String excelReport1(@PathVariable Long id, Model model) {
		
		ObjectiveType type = entityService.findObjectiveTypeById(id);
		
		List<Objective> objectiveList = entityService.findObjectivesOf(type);
		
		model.addAttribute("type", type);
		model.addAttribute("objectiveList", objectiveList);
		
		return "report1.xls";
	}



	@RequestMapping("/admin/excel/report2.xls")
	public String excelReport2 (
		@RequestParam(required=false) String year,
		Model model) {
		model.addAttribute("fiscalYear", year);
		
		return "report2.xls";
	}

	@RequestMapping("/admin/excel/report11.xls/{id}")
	public String excelReport11 (
		@PathVariable Long id, 
		Model model) {
		ObjectiveType type = entityService.findObjectiveTypeById(id);
		List<Objective> objectiveList = entityService.findObjectivesOf(type);
		
		model.addAttribute("type", type);
		model.addAttribute("objectiveList", objectiveList);
		
		return "report11.xls";
	}
	
	@RequestMapping("/admin/excel/track1.xls")
	public String excelTrack1(Model model) {
		model.addAttribute("fiscalYear", 2556);
		
		return "track1.xls";
	}

}
