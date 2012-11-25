package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.bgt.ObjectiveBudgetProposal;

public interface ObjectiveBudgetProposalRepository extends
		JpaSpecificationExecutor<ObjectiveBudgetProposal>, PagingAndSortingRepository<ObjectiveBudgetProposal, Long> {

	List<ObjectiveBudgetProposal> findAllByForObjective_IdAndOwner_Id(
			Long objectiveId, Long ownerId);

}
