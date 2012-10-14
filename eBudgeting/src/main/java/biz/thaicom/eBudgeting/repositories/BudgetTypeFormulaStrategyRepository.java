package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.model.bgt.BudgetTypeFormulaStrategy;

public interface BudgetTypeFormulaStrategyRepository extends
		PagingAndSortingRepository<BudgetTypeFormulaStrategy, Long>, JpaSpecificationExecutor<BudgetTypeFormulaStrategy> {

	public List<BudgetTypeFormulaStrategy> findByfiscalYearAndBudgetType_id(Integer fiscalYear, Long budgetTypeId);
	
}
