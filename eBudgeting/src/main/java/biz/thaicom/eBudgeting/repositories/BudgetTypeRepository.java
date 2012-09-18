package biz.thaicom.eBudgeting.repositories;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.model.bgt.BudgetType;

public interface BudgetTypeRepository extends
		PagingAndSortingRepository<BudgetType, Long>, JpaSpecificationExecutor<BudgetType> {

}
