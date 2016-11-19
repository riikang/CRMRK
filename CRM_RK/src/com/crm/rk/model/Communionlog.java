package com.crm.rk.model;

import java.util.Date;

public class Communionlog {
	private int id;
	private Servicelog servicelog;
	private String context;
	private Date cdate;
	private String crole;
	private String name; 
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Servicelog getServicelog() {
		return servicelog;
	}
	public void setServicelog(Servicelog servicelog) {
		this.servicelog = servicelog;
	}
	public String getContext() {
		return context;
	}
	public void setContext(String context) {
		this.context = context;
	}
	public Date getCdate() {
		return cdate;
	}
	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}
	public String getCrole() {
		return crole;
	}
	public void setCrole(String crole) {
		this.crole = crole;
	}
	
}
