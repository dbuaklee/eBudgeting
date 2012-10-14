package biz.thaicom.eBudgeting.repositories;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.model.bgt.BudgetTypeFormulaColumn;
import biz.thaicom.eBudgeting.model.bgt.BudgetTypeFormulaStrategy;

public interface BudgetTypeFormulaColumnRepository extends
		PagingAndSortingRepository<BudgetTypeFormulaColumn, Long>, JpaSpecificationExecutor<BudgetTypeFormulaColumn> {

	@Modifying
	@Query("update BudgetTypeFormulaColumn column " +
			"set index = index-1 " +
			"where index > ?1 and strategy = ?2 ")
	public int reIndex(Integer deleteIndex, BudgetTypeFormulaStrategy formulaStrategy);
	
}
