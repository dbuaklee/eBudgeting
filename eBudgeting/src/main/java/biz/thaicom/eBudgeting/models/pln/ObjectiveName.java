package biz.thaicom.eBudgeting.models.pln;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="PLN_OBJECTIVENAME")
@SequenceGenerator(name="PLN_OBJECTIVENAME_SEQ", sequenceName="PLN_OBJECTIVENAME_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class ObjectiveName implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3043228740340859261L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="PLN_OBJECTIVENAME_SEQ")
	private Long id;
	
	@Basic
	private String name;
	
	@Basic
	private String code;
	
	@Basic 
	private Integer fiscalYear;
	
	@Basic
	@Column(name="IDX")
	private Integer index;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="TYPE_PLN_OBJECTIVETYPE_ID", nullable=false)
	private ObjectiveType type;
	
	@ManyToMany(fetch=FetchType.LAZY)
	@JoinTable(name="PLN_JOIN_OBJECTIVENAME_TARGET")
	private  List<ObjectiveTarget> targets;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	public Integer getIndex() {
		return index;
	}

	public void setIndex(Integer index) {
		this.index = index;
	}

	public ObjectiveType getType() {
		return type;
	}

	public void setType(ObjectiveType type) {
		this.type = type;
	}

	public Integer getFiscalYear() {
		return fiscalYear;
	}

	public void setFiscalYear(Integer fiscalYear) {
		this.fiscalYear = fiscalYear;
	}

	public List<ObjectiveTarget> getTargets() {
		return targets;
	}

	public void setTargets(List<ObjectiveTarget> targets) {
		this.targets = targets;
	}

	public void addTarget(ObjectiveTarget t) {
		if(this.targets == null) {
			this.targets = new ArrayList<ObjectiveTarget>();
		}
		this.targets.add(t);
		
	}

	
	
}
