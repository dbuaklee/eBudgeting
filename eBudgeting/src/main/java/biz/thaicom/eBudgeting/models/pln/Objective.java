package biz.thaicom.eBudgeting.models.pln;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.Column;
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

import biz.thaicom.eBudgeting.models.bgt.BudgetType;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="PLN_OBJECTIVE")
@SequenceGenerator(name="PLN_OBJECTIVE_SEQ", sequenceName="PLN_OBJECTIVE_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class Objective implements Serializable {
	/**
	 * SerialUID 
	 */
	private static final long serialVersionUID = 6280652136722537800L;
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="PLN_OBJECTIVE_SEQ")
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
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="PARENT_PLN_OBJECTIVE_ID")
	private Objective parent;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="BUDGETTYPE_BGT_BUDGETTYPE_ID")
	private BudgetType budgetType;
	
	@OneToMany(mappedBy="parent", fetch=FetchType.LAZY)
	@OrderColumn(name="IDX")
	private List<Objective> children;
	
	//Normal Getter/Setter
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
	public ObjectiveType getType() {
		return type;
	}
	public void setType(ObjectiveType type) {
		this.type = type;
	}
	public List<Objective> getChildren() {
		return children;
	}
	public void setChildren(List<Objective> children) {
		this.children = children;
	}
	public Objective getParent() {
		return parent;
	}
	public void setParent(Objective parent) {
		this.parent = parent;
	}
	
	public BudgetType getBudgetType() {
		return budgetType;
	}
	public void setBudgetType(BudgetType budgetType) {
		this.budgetType = budgetType;
	}
	
	// loading barebone information about the entity
	public void doBasicLazyLoad() {
		//now we get one parent and its type
		if(this.getParent() != null) {
			this.getParent().getId();
		} 
		if(this.getBudgetType() != null) {
			if(this.getBudgetType().getParent() !=null) {
				this.getBudgetType().getParent().getId();
			}
			this.getBudgetType().getId();
		}
		if(this.getType() != null) {
			this.getType().getId();
			if(this.getType().getParent() != null) {
				this.getType().getParent().getId();
			}
			if(this.getType().getChildren() != null) {
				this.getType().getChildren().size();
			}
		}
		if(this.getChildren() != null) {
			this.getChildren().size();
		}
		
	}
	public void doEagerLoad() {
		this.getType().getId();
		if(this.getBudgetType() != null) {
			this.getBudgetType().getId();
		}
		if(this.getChildren() != null && this.getChildren().size() > 0) {
			// now load all the children
			for(Objective obj : this.children) {
				obj.doEagerLoad();
			}
		}
	}
	

	
}
