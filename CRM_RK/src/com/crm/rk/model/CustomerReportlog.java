package com.crm.rk.model;

public class CustomerReportlog {
	private int id;
	private CustomerReport customerReport;
	private CustomerP customerP;
	private int total;
	private	double money;
	private double moneyed;
	private double moneying;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public CustomerReport getCustomerReport() {
		return customerReport;
	}
	public void setCustomerReport(CustomerReport customerReport) {
		this.customerReport = customerReport;
	}
	public CustomerP getCustomerP() {
		return customerP;
	}
	public void setCustomerP(CustomerP customerP) {
		this.customerP = customerP;
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
