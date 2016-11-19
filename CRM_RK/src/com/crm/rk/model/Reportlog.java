package com.crm.rk.model;

public class Reportlog {
	private int id;
	private ProductReport productReport;
	private Product product;
	private int total;
	private	double money;
	private double moneyed;
	private double moneying;
	public ProductReport getProductReport() {
		return productReport;
	}
	public void setProductReport(ProductReport productReport) {
		this.productReport = productReport;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
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
