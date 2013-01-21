package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.bgt.BudgetSignOff;
import biz.thaicom.eBudgeting.models.hrx.Organization;

public interface BudgetSignOffRepository extends JpaSpecificationExecutor<BudgetSignOff>,
		PagingAndSortingRepository<BudgetSignOff, Long> {

	public List<BudgetSignOff> findAllByFiscalYearAndRound(Integer fiscalYear, Integer round);
	
	public List<BudgetSignOff> findAllByFiscalYearAndOwner(Integer fiscalYear, Organization owner);	

	public List<BudgetSignOff> findAllByFiscalYearAndOwner_Parent(Integer fiscalYear, Organization parent);

	public BudgetSignOff findOneByFiscalYearAndOwner(Integer fiscalYear,
			Organization workAt);
}
