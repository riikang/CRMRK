package com.crm.rk.action;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;

import org.apache.struts2.ServletActionContext;

import com.crm.rk.model.Chance;
import com.crm.rk.model.Channel;
import com.crm.rk.model.CustomerP;
import com.crm.rk.model.Manager;
import com.crm.rk.model.Mission;
import com.crm.rk.model.Orders;
import com.crm.rk.model.Product;
import com.crm.rk.model.Salesman;
import com.crm.rk.model.Servicelog;
import com.crm.rk.model.UserPower;
import com.crm.rk.service.ChanceService;
import com.crm.rk.service.ChannelService;
import com.crm.rk.service.CustomerPService;
import com.crm.rk.service.ManagerService;
import com.crm.rk.service.MissionService;
import com.crm.rk.service.OrderService;
import com.crm.rk.service.ProductService;
import com.crm.rk.service.SalesmanService;
import com.crm.rk.service.ServicelogService;
import com.crm.rk.service.UserPowerService;
import com.crm.rk.util.JsonDateValueProcessor;
import com.opensymphony.xwork2.ActionContext;

public class InformationAction {
	@Resource private ManagerService managerService;
	@Resource private ChannelService channelService;
	@Resource private SalesmanService salesmanService;
	@Resource private CustomerPService customerPService;
	@Resource private OrderService orderService;
	@Resource private ProductService productService;
	@Resource private UserPowerService userPowerService;
	@Resource private ChanceService chanceService;
	@Resource private ServicelogService servicelogService;
	@Resource private MissionService missionService;
	private UserPower userPower;
	private Manager manager;
	private Channel channel;
	private Salesman salesman;
	private CustomerP customerP;
	private Orders orders;
	private Product product;
	private List<Mission> missions;
	private List<Servicelog> servicelogs;
	private List<Chance> chances;
	private List<Channel> channels;
	private List<Salesman> salesmans;
	private List<CustomerP> customerPs;
	private List<Orders> orderss;
	private List<Product> products;
	private int channelnum=0; 
	private int chancenum=0; 
	private int salesmannum=0;
	private int customernum=0;
	private int productnum=0;
	private int ordersnum=0;
	private int servicelognum=0;
	private int num1=0;
	private double totalmoney=0;
	public List<Mission> getMissions() {
		return missions;
	}
	public void setMissions(List<Mission> missions) {
		this.missions = missions;
	}
	public int getNum1() {
		return num1;
	}
	public void setNum1(int num1) {
		this.num1 = num1;
	}
	public int getServicelognum() {
		return servicelognum;
	}
	public void setServicelognum(int servicelognum) {
		this.servicelognum = servicelognum;
	}
	public List<Servicelog> getServicelogs() {
		return servicelogs;
	}
	public void setServicelogs(List<Servicelog> servicelogs) {
		this.servicelogs = servicelogs;
	}
	public List<Chance> getChances() {
		return chances;
	}
	public void setChances(List<Chance> chances) {
		this.chances = chances;
	}
	public int getChancenum() {
		return chancenum;
	}
	public void setChancenum(int chancenum) {
		this.chancenum = chancenum;
	}
	public UserPower getUserPower() {
		return userPower;
	}
	public void setUserPower(UserPower userPower) {
		this.userPower = userPower;
	}
	public Manager getManager() {
		return manager;
	}
	public void setManager(Manager manager) {
		this.manager = manager;
	}
	public int getChannelnum() {
		return channelnum;
	}
	public void setChannelnum(int channelnum) {
		this.channelnum = channelnum;
	}
	public int getSalesmannum() {
		return salesmannum;
	}
	public void setSalesmannum(int salesmannum) {
		this.salesmannum = salesmannum;
	}
	public int getCustomernum() {
		return customernum;
	}
	public void setCustomernum(int customernum) {
		this.customernum = customernum;
	}
	public int getProductnum() {
		return productnum;
	}
	public void setProductnum(int productnum) {
		this.productnum = productnum;
	}
	public int getOrdersnum() {
		return ordersnum;
	}
	public void setOrdersnum(int ordersnum) {
		this.ordersnum = ordersnum;
	}
	public double getTotalmoney() {
		return totalmoney;
	}
	public void setTotalmoney(double totalmoney) {
		this.totalmoney = totalmoney;
	}
	public Channel getChannel() {
		return channel;
	}
	public void setChannel(Channel channel) {
		this.channel = channel;
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
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public List<Channel> getChannels() {
		return channels;
	}
	public void setChannels(List<Channel> channels) {
		this.channels = channels;
	}
	public List<Salesman> getSalesmans() {
		return salesmans;
	}
	public void setSalesmans(List<Salesman> salesmans) {
		this.salesmans = salesmans;
	}
	public List<CustomerP> getCustomerPs() {
		return customerPs;
	}
	public void setCustomerPs(List<CustomerP> customerPs) {
		this.customerPs = customerPs;
	}
	public List<Orders> getOrderss() {
		return orderss;
	}
	public void setOrderss(List<Orders> orderss) {
		this.orderss = orderss;
	}
	public List<Product> getProducts() {
		return products;
	}
	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public String managerInfo() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<4){
				return "error";
			}else {
				Manager manager1=(Manager)ActionContext.getContext().getApplication().get("manager");
				manager=managerService.findById(Manager.class, manager1.getId());
				channels=channelService.findAllByManager(Channel.class, manager1.getId());
				channelnum=channels.size();
				salesmans=salesmanService.findAllByManager(Salesman.class, manager1.getId());
				salesmannum=salesmans.size();
				customerPs=customerPService.findAllByManager(CustomerP.class, manager1.getId());
				customernum=customerPs.size();
				products=productService.findAllByManager(Product.class, manager1.getId());
				productnum=products.size();
				orderss=orderService.findAllByManager(Orders.class, manager1.getId());
				ordersnum=orderss.size();
				for (int i = 0; i < orderss.size(); i++) {
					totalmoney=totalmoney+orderss.get(i).getDealpriceT();
				}
				return "managerInfo_s";
			}
		}else{
			return "error";
		}
	}
	
	public String salesmanInfo(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level!=2){
				return "error";
			}else {
				salesman=(Salesman)ActionContext.getContext().getApplication().get("user");
				orderss=orderService.findBySalesman(salesman.getId());
				ordersnum=orderss.size();
				chances=chanceService.findChanceBySalesman(salesman.getId());
				chancenum=chances.size();
				servicelogs=servicelogService.findBySalesman(salesman.getId());
				servicelognum=servicelogs.size();
				if(servicelognum>0){
					for (int i = 0; i < servicelogs.size(); i++) {
						if(servicelogs.get(i).getEvaluation().equals("非常满意")||
								servicelogs.get(i).getEvaluation().equals("满意")){
							num1++;
						}
					}
					totalmoney=num1/servicelognum*100;
				}
				return "salesmanInfo_s";
			}
		}else{
			return "error";
		}
	}
	
	public String channelInfo(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level!=3){
				return "error";
			}else {
				salesman=(Salesman)ActionContext.getContext().getApplication().get("user");
				salesmans=salesmanService.findSalesmanByChannel(salesman.getChannel().getId());
				salesmannum=salesmans.size();
				orderss=orderService.findOrdersByChannel(salesman.getChannel().getId());
				ordersnum=orderss.size();
				chances=chanceService.findChanceByChannel(salesman.getChannel().getId());
				chancenum=chances.size();
				missions=missionService.findMissionByChannel(salesman.getChannel().getId());
				num1=missions.size();
				return "channelInfo_s";
			}
		}else{
			return "error";
		}
	}
	
	public String updatemanagerInfo() throws Exception{
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		HttpServletRequest request=ServletActionContext.getRequest();
		int mid=Integer.valueOf(request.getParameter("mid"));
		String name=request.getParameter("name");
		String company=request.getParameter("company");
		manager=managerService.findById(Manager.class, mid);
		manager.setName(name);
		manager.setCompany(company);
		managerService.update(manager);
		manager=managerService.findById(Manager.class, mid);
		JSONObject jsonObject = JSONObject.fromObject(manager,jsonConfig);
		String jsonStr=jsonObject.toString();
		HttpServletResponse response=ServletActionContext.getResponse();
		try {
			response.setCharacterEncoding("utf-8"); 
			response.getWriter().print(jsonStr);
			response.getWriter().flush();  
	        response.getWriter().close();  
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("解析失败");
		}  
		return null;
	}
	
	public String updatesalesmanInfo() throws Exception{
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor()); 
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		HttpServletRequest request=ServletActionContext.getRequest();
		int sid=Integer.valueOf(request.getParameter("sid"));
		String name=request.getParameter("name");
		String conn=request.getParameter("conn");
		String home=request.getParameter("home");
		salesman=salesmanService.findById(Salesman.class, sid);
		salesman.setSname(name);
		salesman.setPhone(conn);
		salesman.setAddress(home);
		salesmanService.update(salesman);
		salesman=salesmanService.findById(Salesman.class, sid);
		JSONObject jsonObject = JSONObject.fromObject(salesman,jsonConfig);
		String jsonStr2=jsonObject.toString();
		HttpServletResponse response=ServletActionContext.getResponse();
		try {
			response.setCharacterEncoding("utf-8"); 
			response.getWriter().print(jsonStr2);
			response.getWriter().flush();  
	        response.getWriter().close();  
		} catch (IOException e) {
			e.printStackTrace();
		}  
		return null;
	}
	
	public String updatechannelInfo() throws Exception{
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor()); 
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		HttpServletRequest request=ServletActionContext.getRequest();
		int cid=Integer.valueOf(request.getParameter("cid"));
		String codeid=request.getParameter("codeid");
		String comid=request.getParameter("comid");
		String comadid=request.getParameter("comadid");
		channel=channelService.findById(Channel.class, cid);
		channel.setPostcode(codeid);
		channel.setWebsite(comid);
		channel.setAddress(comadid);
		channelService.update(channel);
		channel=channelService.findById(Channel.class, cid);
		JSONObject jsonObject = JSONObject.fromObject(channel,jsonConfig);
		String jsonStr=jsonObject.toString();
		HttpServletResponse response=ServletActionContext.getResponse();
		try {
			response.setCharacterEncoding("utf-8"); 
			response.getWriter().print(jsonStr);
			response.getWriter().flush();  
	        response.getWriter().close();  
		} catch (IOException e) {
			e.printStackTrace();
		}  
		return null;
	}
	
	public String validate1() throws Exception{
		int level=(Integer)(ActionContext.getContext().getApplication().get("level"));
		HttpServletRequest request=ServletActionContext.getRequest();
		int idid=Integer.valueOf(request.getParameter("idid"));
		String num1=request.getParameter("num1");
		String flag="";
		if(level==3||level==2){
			salesman=salesmanService.findById(Salesman.class, idid);
			if(salesman.getUserPower().getPassword().equals(num1)){
				flag="1";
			}else{
				flag="0";
			}
		}else if(level==4){
			manager=managerService.findById(Manager.class, idid);
			if(manager.getUserPower().getPassword().equals(num1)){
				flag="1";
			}else{
				flag="0";
			}
		}
		HttpServletResponse response=ServletActionContext.getResponse();
		try {
			response.setCharacterEncoding("utf-8"); 
			response.getWriter().print(flag);
			response.getWriter().flush();  
	        response.getWriter().close();  
		} catch (IOException e) {
			e.printStackTrace();
		}  
		return null;
	}
	
	public String updatepw() throws Exception{
		int level=(Integer)(ActionContext.getContext().getApplication().get("level"));
		HttpServletRequest request=ServletActionContext.getRequest();
		int idid=Integer.valueOf(request.getParameter("idid"));
		String num1=request.getParameter("num1");
		if(level==3||level==2){
			salesman=salesmanService.findById(Salesman.class, idid);
			salesman.getUserPower().setPassword(num1);
			userPowerService.update(salesman.getUserPower());
		}else if(level==4){
			manager=managerService.findById(Manager.class, idid);
			manager.getUserPower().setPassword(num1);
			userPowerService.update(manager.getUserPower());
		}else if(level==1){
			
		}
		return null;
	}
	
}
