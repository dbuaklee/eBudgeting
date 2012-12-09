package biz.thaicom.eBudgeting.models.pln;


import java.io.Serializable;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="PLN_OBJECTIVETARGET")
@SequenceGenerator(name="PLN_OBJECTIVETARGET_SEQ", sequenceName="PLN_OBJECTIVETARGET_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class ObjectiveTarget implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 3845124436017755638L;

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="PLN_OBJECTIVETARGET_SEQ")
	private Long id;
	
	@Basic
	private String name;
	
	@Basic
	private Integer fiscalYear;
	
	@ManyToMany(mappedBy="targets")
	@JsonIgnore
	private List<Objective> forObjectives;
	
	@Basic
	private Boolean isSumable;
	
	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="TARGETUNIT_ID")
	private TargetUnit unit;

	@OneToMany(mappedBy="target", fetch=FetchType.LAZY)
	private List<TargetValue> values;
	
	@Transient
	private List<TargetValue> filterValues;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Integer getFiscalYear() {
		return fiscalYear;
	}

	public void setFiscalYear(Integer fiscalYear) {
		this.fiscalYear = fiscalYear;
	}

	

	public List<Objective> getForObjectives() {
		return forObjectives;
	}

	public void setForObjectives(List<Objective> forObjectives) {
		this.forObjectives = forObjectives;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public TargetUnit getUnit() {
		return unit;
	}

	public void setUnit(TargetUnit unit) {
		this.unit = unit;
	}

	public List<TargetValue> getValues() {
		return values;
	}

	public void setValues(List<TargetValue> values) {
		this.values = values;
	}

	public List<TargetValue> getFilterValues() {
		return filterValues;
	}

	public void setFilterValues(List<TargetValue> filterValues) {
		this.filterValues = filterValues;
	}

	public Boolean getIsSumable() {
		return isSumable;
	}

	public void setIsSumable(Boolean isSumable) {
		this.isSumable = isSumable;
	}

	
	
	
}
