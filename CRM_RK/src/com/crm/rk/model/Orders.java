package com.crm.rk.model;

import java.util.Date;

public class Orders {
	private String id;
	private String title;
	private CustomerP customerP;
	private Channel channel;
	private Product product;
	private Salesman salesman;
	private Chance chance;
	private Manager manager;
	private Date dealdate;
	private Date paydate;
	private Date senddate;
	private int amount;
	private double dealprice;
	private double dealpriceT;
	private double costingT;
	private double profits;
	private String status;
	private String payways;
	private String remarker;
	private String cstatus;
	private String ctype;
	private String currency;
	private double remainingPay;
	private double paymoney;
	public Channel getChannel() {
		return channel;
	}
	public void setChannel(Channel channel) {
		this.channel = channel;
	}
	public Manager getManager() {
		return manager;
	}
	public void setManager(Manager manager) {
		this.manager = manager;
	}
	public double getPaymoney() {
		return paymoney;
	}
	public void setPaymoney(double paymoney) {
		this.paymoney = paymoney;
	}
	public double getRemainingPay() {
		return remainingPay;
	}
	public void setRemainingPay(double remainingPay) {
		this.remainingPay = remainingPay;
	}
	public Date getPaydate() {
		return paydate;
	}
	public void setPaydate(Date paydate) {
		this.paydate = paydate;
	}
	public Date getSenddate() {
		return senddate;
	}
	public void setSenddate(Date senddate) {
		this.senddate = senddate;
	}
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public Salesman getSalesman() {
		return salesman;
	}
	public void setSalesman(Salesman salesman) {
		this.salesman = salesman;
	}
	public Date getDealdate() {
		return dealdate;
	}
	public void setDealdate(Date dealdate) {
		this.dealdate = dealdate;
	}
	public Chance getChance() {
		return chance;
	}
	public void setChance(Chance chance) {
		this.chance = chance;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public CustomerP getCustomerP() {
		return customerP;
	}
	public void setCustomerP(CustomerP customerP) {
		this.customerP = customerP;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public double getDealprice() {
		return dealprice;
	}
	public void setDealprice(double dealprice) {
		this.dealprice = dealprice;
	}
	public double getDealpriceT() {
		return dealpriceT;
	}
	public void setDealpriceT(double dealpriceT) {
		this.dealpriceT = dealpriceT;
	}
	public double getCostingT() {
		return costingT;
	}
	public void setCostingT(double costingT) {
		this.costingT = costingT;
	}
	public double getProfits() {
		return profits;
	}
	public void setProfits(double profits) {
		this.profits = profits;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPayways() {
		return payways;
	}
	public void setPayways(String payways) {
		this.payways = payways;
	}
	public String getRemarker() {
		return remarker;
	}
	public void setRemarker(String remarker) {
		this.remarker = remarker;
	}
	public String getCstatus() {
		return cstatus;
	}
	public void setCstatus(String cstatus) {
		this.cstatus = cstatus;
	}
	public String getCtype() {
		return ctype;
	}
	public void setCtype(String ctype) {
		this.ctype = ctype;
	}
	
}
