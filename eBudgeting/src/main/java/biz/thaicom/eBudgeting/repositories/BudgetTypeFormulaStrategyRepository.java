package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.model.bgt.BudgetType;
import biz.thaicom.eBudgeting.model.bgt.BudgetTypeFormulaStrategy;

public interface BudgetTypeFormulaStrategyRepository extends
		PagingAndSortingRepository<BudgetTypeFormulaStrategy, Long>, JpaSpecificationExecutor<BudgetTypeFormulaStrategy> {

	public List<BudgetTypeFormulaStrategy> findByfiscalYearAndBudgetType_idOrderByIndexAsc(Integer fiscalYear, Long budgetTypeId);
	
	@Modifying
	@Query("update BudgetTypeFormulaStrategy strategy " +
			"set index = index-1 " +
			"where index > ?1 and fiscalYear = ?2 and budgetType = ?3 ")
	public int reIndex(Integer deleteIndex, Integer fiscalYear, BudgetType budgetType);
	
}
