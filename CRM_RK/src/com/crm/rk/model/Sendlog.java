package com.crm.rk.model;

import java.util.Date;

public class Sendlog {
	private int id;
	private Orders orders;
	private Date realSendDate;
	private int sendNum;
	private double sendPrice;
	private int remainingSend;
	public int getRemainingSend() {
		return remainingSend;
	}
	public void setRemainingSend(int remainingSend) {
		this.remainingSend = remainingSend;
	}
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
	public Date getRealSendDate() {
		return realSendDate;
	}
	public void setRealSendDate(Date realSendDate) {
		this.realSendDate = realSendDate;
	}
	public int getSendNum() {
		return sendNum;
	}
	public void setSendNum(int sendNum) {
		this.sendNum = sendNum;
	}
	public double getSendPrice() {
		return sendPrice;
	}
	public void setSendPrice(double sendPrice) {
		this.sendPrice = sendPrice;
	}
	
}
