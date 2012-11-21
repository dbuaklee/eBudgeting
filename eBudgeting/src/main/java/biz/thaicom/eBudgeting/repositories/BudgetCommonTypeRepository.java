package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.bgt.BudgetCommonType;

public interface BudgetCommonTypeRepository extends
		JpaSpecificationExecutor<BudgetCommonType>, PagingAndSortingRepository<BudgetCommonType, Long> {

	List<BudgetCommonType> findAllByFiscalYear(Integer fiscalYear);

}
