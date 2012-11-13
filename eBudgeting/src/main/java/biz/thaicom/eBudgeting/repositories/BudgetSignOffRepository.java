package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.bgt.BudgetSignOff;

public interface BudgetSignOffRepository extends JpaSpecificationExecutor<BudgetSignOff>,
		PagingAndSortingRepository<BudgetSignOff, Long> {

	public List<BudgetSignOff> findAllByFiscalYearAndRound(Integer fiscalYear, Integer round);
	
}
