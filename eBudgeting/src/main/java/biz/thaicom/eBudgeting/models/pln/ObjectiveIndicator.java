package biz.thaicom.eBudgeting.models.pln;

import java.util.List;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="PLN_OBJECTIVEINDICATOR")
@SequenceGenerator(name="PLN_OBJECTIVEINDICATOR_SEQ", sequenceName="PLN_OBJECTIVEINDICATOR_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class ObjectiveIndicator {
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="PLN_OBJECTIVEINDICATOR_SEQ")
	private Long id;
	
	@Basic
	private String name;
	
	@Basic
	private Integer fiscalYear;
	
	@OneToMany
	private List<Objective> forObjectives;
	
	
}
