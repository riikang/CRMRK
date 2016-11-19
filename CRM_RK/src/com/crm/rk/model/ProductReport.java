package com.crm.rk.model;

import java.util.Date;

public class ProductReport {
	private int id;
	private Date starttime;
	private Date endtime;
	private int total;
	private	double money;
	private double moneyed;
	private double moneying;
	private Manager manager;
	
	public Manager getManager() {
		return manager;
	}
	public void setManager(Manager manager) {
		this.manager = manager;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getStarttime() {
		return starttime;
	}
	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}
	public Date getEndtime() {
		return endtime;
	}
	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public double getMoney() {
		return money;
	}
	public void setMoney(double money) {
		this.money = money;
	}
	public double getMoneyed() {
		return moneyed;
	}
	public void setMoneyed(double moneyed) {
		this.moneyed = moneyed;
	}
	public double getMoneying() {
		return moneying;
	}
	public void setMoneying(double moneying) {
		this.moneying = moneying;
	} 
}
