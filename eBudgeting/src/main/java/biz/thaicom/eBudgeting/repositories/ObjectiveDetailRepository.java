package biz.thaicom.eBudgeting.repositories;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.hrx.Organization;
import biz.thaicom.eBudgeting.models.pln.ObjectiveDetail;

public interface ObjectiveDetailRepository extends JpaSpecificationExecutor<ObjectiveDetail>,
		PagingAndSortingRepository<ObjectiveDetail, Long> {

	
		public ObjectiveDetail findByForObjective_IdAndOwner(Long objectiveId,
			Organization owner);
}
