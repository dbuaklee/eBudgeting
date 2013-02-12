package biz.thaicom.security.models;

import javax.persistence.Entity;

@Entity
public class Program {
	
	Long id;
	
	String name;
	String code;
	String description;
	String link;
}
