package com.crm.rk.model;

public class Message {
	private int id;
	private int iflook;
	private int type; //1——订单，2——服务记录，3——服务回复，4——任务,5——机会
	private int mid;	//事情id
	private int pid;	//人物id
	private int level;	//1——客户，2——销售员，3——渠道管理员，4——经理
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getIflook() {
		return iflook;
	}
	public void setIflook(int iflook) {
		this.iflook = iflook;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getMid() {
		return mid;
	}
	public void setMid(int mid) {
		this.mid = mid;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public Message(int iflook,int type,int mid,int level,int pid){
		this.iflook=iflook;
		this.type=type;
		this.mid=mid;
		this.level=level;
		this.pid=pid;
	}
	public Message(){}
}
