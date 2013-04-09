package biz.thaicom.security.models;

import java.util.List;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;


public class Menu {

	@Id
	private Long id;
	
	@Basic
	private String code;
	
	@Basic
	private String name;
	
	@Basic 
	private String link; 
	
	@Basic
	private String remark;
	
	@ManyToOne
	@JoinColumn(name="PARENT_MENU_ID")
	private Menu parent;
	
	@OneToMany
	List<Menu> children;
	
	@OneToMany
	List<Role> allowRoles;
}
