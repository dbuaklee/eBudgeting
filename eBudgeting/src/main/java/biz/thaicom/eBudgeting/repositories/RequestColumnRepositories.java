package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.bgt.RequestColumn;

public interface RequestColumnRepositories extends
		PagingAndSortingRepository<RequestColumn, Long>, JpaSpecificationExecutor<RequestColumn> {

	@Query("" +
			"SELECT rc " +
			"FROM RequestColumn rc " +
			"WHERE rc.proposalStrategy.proposal.forObjective.fiscalYear = ?1")
	List<RequestColumn> findAllByFiscalYear(Integer fiscalYear);

}
