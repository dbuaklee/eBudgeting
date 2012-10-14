package biz.thaicom.eBudgeting.repositories;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.model.bgt.BudgetTypeFormulaColumn;

public interface BudgetTypeFormulaColumnRepository extends
		PagingAndSortingRepository<BudgetTypeFormulaColumn, Long>, JpaSpecificationExecutor<BudgetTypeFormulaColumn> {

}
