package biz.thaicom.eBudgeting.model.bgt;

import java.io.Serializable;
import java.util.List;
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
import javax.persistence.OrderColumn;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;


import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="BUDGETTYPE")
@SequenceGenerator(name="BUDGETTYPE_SEQ", sequenceName="BUDGETTYPE_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class BudgetType implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5984004367106256395L;
	
	// Field
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="BUDGETTYPE_SEQ")
	private Long id;
	
	@Basic
	private String name;
	
	@Basic
	private String code;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="BUDGETTYPE_PARENT_ID")
	private BudgetType parent;
	
	@OneToMany(mappedBy="parent", fetch=FetchType.LAZY)
	@OrderColumn(name="index")
	private List<BudgetType> children;
	
	@Basic
	private Integer fiscalYear;
	
	@Basic
	private Integer index;

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

	public BudgetType getParent() {
		return parent;
	}

	public void setParent(BudgetType parent) {
		this.parent = parent;
	}

	public List<BudgetType> getChildren() {
		return children;
	}

	public void setChildren(List<BudgetType> children) {
		this.children = children;
	}

	public Integer getFiscalYear() {
		return fiscalYear;
	}

	public void setFiscalYear(Integer fiscalYear) {
		this.fiscalYear = fiscalYear;
	}

	public Integer getIndex() {
		return index;
	}

	public void setIndex(Integer index) {
		this.index = index;
	}

	public void doEagerLoad() {
		if(this.getParent() != null)
			this.getParent().getId();
		
		if(this.children != null && this.children.size() > 0) {
			for(BudgetType b : this.children) {
				b.doEagerLoad();
			}
		}
		
	}	

	
	
	
}
