package biz.thaicom.eBudgeting.model.bgt;

import java.io.Serializable;

public class FiscalObjective implements Serializable{
	
	/**
	 * SerializeUid 
	 */
	private static final long serialVersionUID = -2172386002170127067L;
	
	
	private Long id;
	private Integer fiscalYear;
	private Objective root;
	
	// Normal Getter/Setter
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
	public Objective getRoot() {
		return root;
	}
	public void setRoot(Objective root) {
		this.root = root;
	}

	
	
}
