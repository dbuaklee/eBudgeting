package biz.thaicom.eBudgeting.services;

import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import biz.thaicom.eBudgeting.model.bgt.Objective;
import biz.thaicom.eBudgeting.model.bgt.ObjectiveType;
import biz.thaicom.eBudgeting.repositories.ObjectiveRepository;
import biz.thaicom.eBudgeting.repositories.ObjectiveTypeRepository;

@Service
@Transactional
public class ObjectiveServiceMockup implements ObjectiveService {
	private static final Logger logger = LoggerFactory.getLogger(ObjectiveServiceMockup.class);
	
	@Autowired
	private ObjectiveRepository objectiveRepository;
	
	@Autowired
	private ObjectiveTypeRepository objectiveTypeRepository;

	@Override
	public ObjectiveType findObjectiveTypeById(Long id) {
		return objectiveTypeRepository.findOne(id);
	}

	@Override
	public Set<ObjectiveType> findChildrenObjectiveType(ObjectiveType type) {
		ObjectiveType self = objectiveTypeRepository.findOne(type.getId());
		return self.getChildren();
	}

	@Override
	public ObjectiveType findParentObjectiveType(ObjectiveType type) {
		ObjectiveType self = objectiveTypeRepository.findOne(type.getId());
		return self.getParent();
	}

	@Override
	public List<Objective> findObjectivesOf(ObjectiveType type) {
		return objectiveRepository.findByTypeId(type.getId());
	}

	@Override
	public List<Objective> findObjectiveChildren(Objective objective) {
		return findObjectiveChildrenByObjectiveId(objective.getId());
	}

	@Override
	public Objective findParentObjective(Objective objective) {
		Objective self = objectiveRepository.findOne(objective.getId());
		
		return self.getParent();
	}

	@Override
	public Objective findOjectiveById(Long id) {
		Objective objective = objectiveRepository.findOne(id);
		objective.doBasicLazyLoad();
		
		return objective;
	}

	@Override
	public List<Objective> findObjectiveChildrenByObjectiveId(Long id) {
		Objective self = objectiveRepository.findOne(id);
		if(self != null) {
			logger.debug("--id: " + self.getId());
			logger.debug("children.getSize() = " + self.getChildren().size());
			self.getChildren().size();
			for(Objective objective: self.getChildren()) {
				logger.debug(" child.id --> " + objective.getId());
				objective.doBasicLazyLoad();
			}
		}
		return self.getChildren();
	}

	@Override
	public List<Objective> findRootObjectiveByFiscalyear(Integer fiscalYear) {
		
		List<Objective> list = objectiveRepository.findByParentIdAndFiscalYear(null, fiscalYear);
		for(Objective objective : list) {
			objective.doBasicLazyLoad();
		}
		return list;
	}

	@Override
	public List<Integer> findRootFiscalYear() {
		return objectiveRepository.findRootFiscalYear();
	}


}
