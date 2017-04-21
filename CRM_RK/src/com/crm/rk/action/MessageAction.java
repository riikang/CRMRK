package com.crm.rk.action;

import javax.annotation.Resource;

import com.crm.rk.model.Chance;
import com.crm.rk.model.CustomerP;
import com.crm.rk.model.Manager;
import com.crm.rk.model.Mission;
import com.crm.rk.model.Orders;
import com.crm.rk.model.Salesman;
import com.crm.rk.model.Servicelog;
import com.crm.rk.service.ChanceService;
import com.crm.rk.service.CustomerPService;
import com.crm.rk.service.ManagerService;
import com.crm.rk.service.MissionService;
import com.crm.rk.service.OrderService;
import com.crm.rk.service.SalesmanService;
import com.crm.rk.service.ServicelogService;
import com.crm.rk.service.UserPowerService;
//站内信息动作类
public class MessageAction {
	@Resource private ManagerService managerService;
	@Resource private SalesmanService salesmanService;
	@Resource private CustomerPService customerPService;
	@Resource private OrderService orderService;
	@Resource private UserPowerService userPowerService;
	@Resource private ChanceService chanceService;
	@Resource private ServicelogService servicelogService;
	@Resource private MissionService missionService;
	private Manager manager;
	private Salesman salesman;
	private CustomerP customerP;
	private Orders orders;
	private Chance chance;
	private Servicelog servicelog;
	private Mission mission;
	public Manager getManager() {
		return manager;
	}
	public void setManager(Manager manager) {
		this.manager = manager;
	}
	public Salesman getSalesman() {
		return salesman;
	}
	public void setSalesman(Salesman salesman) {
		this.salesman = salesman;
	}
	public CustomerP getCustomerP() {
		return customerP;
	}
	public void setCustomerP(CustomerP customerP) {
		this.customerP = customerP;
	}
	public Orders getOrders() {
		return orders;
	}
	public void setOrders(Orders orders) {
		this.orders = orders;
	}
	public Chance getChance() {
		return chance;
	}
	public void setChance(Chance chance) {
		this.chance = chance;
	}
	public Servicelog getServicelog() {
		return servicelog;
	}
	public void setServicelog(Servicelog servicelog) {
		this.servicelog = servicelog;
	}
	public Mission getMission() {
		return mission;
	}
	public void setMission(Mission mission) {
		this.mission = mission;
	}
	
	
	
}
