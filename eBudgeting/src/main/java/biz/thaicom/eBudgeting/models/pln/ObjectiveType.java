package biz.thaicom.eBudgeting.models.pln;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;


@Entity
@Table(name="PLN_OBJECTIVETYPE")
@SequenceGenerator(name="PLN_OBJECTIVETYPE_SEQ", sequenceName="PLN_OBJECTIVETYPE_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class ObjectiveType implements Serializable {
	
	
	/**
	 * SerializedUID 
	 */
	private static final long serialVersionUID = -1906396844701411875L;
	
	
	// Field
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="PLN_OBJECTIVETYPE_SEQ")
	private Long id;
	
	@Basic
	private String name;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="PARENT_PLN_OBJECTIVETYPE_ID")
	private ObjectiveType parent;
	
	@OneToMany(mappedBy="parent", fetch=FetchType.LAZY)
	private Set<ObjectiveType> children;
	
	@Basic
	private Integer fiscalYear;
	
	
	// Normat get-set
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
	public ObjectiveType getParent() {
		return parent;
	}
	public void setParent(ObjectiveType parent) {
		this.parent = parent;
	}
	public Set<ObjectiveType> getChildren() {
		return children;
	}
	public void setChildren(Set<ObjectiveType> children) {
		this.children = children;
	}
	public Integer getFiscalYear() {
		return fiscalYear;
	}
	public void setFiscalYear(Integer fiscalYear) {
		this.fiscalYear = fiscalYear;
	}

	
	
}
