package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.bgt.BudgetType;
import biz.thaicom.eBudgeting.models.bgt.FormulaStrategy;

public interface FormulaStrategyRepository extends
		PagingAndSortingRepository<FormulaStrategy, Long>, JpaSpecificationExecutor<FormulaStrategy> {

	public List<FormulaStrategy> findByfiscalYearAndType_idOrderByIndexAsc(Integer fiscalYear, Long budgetTypeId);
	
	@Modifying
	@Query("update FormulaStrategy strategy " +
			"set index = index-1 " +
			"where index > ?1 and fiscalYear = ?2 and budgetType = ?3 ")
	public int reIndex(Integer deleteIndex, Integer fiscalYear, BudgetType budgetType);
	
}
