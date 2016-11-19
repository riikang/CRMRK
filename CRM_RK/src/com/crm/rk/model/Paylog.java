package com.crm.rk.model;

import java.util.Date;

public class Paylog {
	private int id;
	private Orders orders;
	private Date realPayDate;
	private double realPay;
	private double remainingPay;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Orders getOrders() {
		return orders;
	}
	public void setOrders(Orders orders) {
		this.orders = orders;
	}
	public Date getRealPayDate() {
		return realPayDate;
	}
	public void setRealPayDate(Date realPayDate) {
		this.realPayDate = realPayDate;
	}
	public double getRealPay() {
		return realPay;
	}
	public void setRealPay(double realPay) {
		this.realPay = realPay;
	}
	public double getRemainingPay() {
		return remainingPay;
	}
	public void setRemainingPay(double remainingPay) {
		this.remainingPay = remainingPay;
	}
	
}
