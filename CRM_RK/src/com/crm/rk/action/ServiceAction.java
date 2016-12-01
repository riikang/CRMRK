package com.crm.rk.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;
import org.hibernate.mapping.Array;

import com.crm.rk.model.Channel;
import com.crm.rk.model.Communionlog;
import com.crm.rk.model.CustomerP;
import com.crm.rk.model.Manager;
import com.crm.rk.model.Message;
import com.crm.rk.model.Orders;
import com.crm.rk.model.Product;
import com.crm.rk.model.Salesman;
import com.crm.rk.model.Servicelog;
import com.crm.rk.service.ChannelService;
import com.crm.rk.service.CommunionlogService;
import com.crm.rk.service.CustomerPService;
import com.crm.rk.service.MessageService;
import com.crm.rk.service.OrderService;
import com.crm.rk.service.ProductService;
import com.crm.rk.service.SalesmanService;
import com.crm.rk.service.ServicelogService;
import com.opensymphony.xwork2.ActionContext;

public class ServiceAction {
	@Resource private ServicelogService servicelogService;
	@Resource private ChannelService channelService;
	@Resource private SalesmanService salesmanService;
	@Resource private CustomerPService customerPService;
	@Resource private ProductService productService;
	@Resource private OrderService orderService;
	@Resource private CommunionlogService communionlogService;
	@Resource private MessageService messageService;
	private List<Message> messages;
	private Communionlog communionlog;
	private List<Communionlog> communionlogs;
	private Channel channel;
	private List<Channel> channels;
	private Orders orders;
	private List<Orders> orderss;
	private Salesman salesman;
	private List<Salesman> salesmans;
	private CustomerP customerP;
	private List<CustomerP> customerPs;
	private Product product;
	private List<Product> products;
	private Servicelog servicelog;
	private List<Servicelog> servicelogs;
	private String scid;
	public List<Message> getMessages() {
		return messages;
	}
	public void setMessages(List<Message> messages) {
		this.messages = messages;
	}
	public Communionlog getCommunionlog() {
		return communionlog;
	}
	public void setCommunionlog(Communionlog communionlog) {
		this.communionlog = communionlog;
	}
	public List<Communionlog> getCommunionlogs() {
		return communionlogs;
	}
	public void setCommunionlogs(List<Communionlog> communionlogs) {
		this.communionlogs = communionlogs;
	}
	public Orders getOrders() {
		return orders;
	}
	public void setOrders(Orders orders) {
		this.orders = orders;
	}
	public List<Orders> getOrderss() {
		return orderss;
	}
	public void setOrderss(List<Orders> orderss) {
		this.orderss = orderss;
	}
	public String getScid() {
		return scid;
	}
	public void setScid(String scid) {
		this.scid = scid;
	}
	public Channel getChannel() {
		return channel;
	}
	public void setChannel(Channel channel) {
		this.channel = channel;
	}
	public List<Channel> getChannels() {
		return channels;
	}
	public void setChannels(List<Channel> channels) {
		this.channels = channels;
	}
	public Salesman getSalesman() {
		return salesman;
	}
	public void setSalesman(Salesman salesman) {
		this.salesman = salesman;
	}
	public List<Salesman> getSalesmans() {
		return salesmans;
	}
	public void setSalesmans(List<Salesman> salesmans) {
		this.salesmans = salesmans;
	}
	public CustomerP getCustomerP() {
		return customerP;
	}
	public void setCustomerP(CustomerP customerP) {
		this.customerP = customerP;
	}
	public List<CustomerP> getCustomerPs() {
		return customerPs;
	}
	public void setCustomerPs(List<CustomerP> customerPs) {
		this.customerPs = customerPs;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public List<Product> getProducts() {
		return products;
	}
	public void setProducts(List<Product> products) {
		this.products = products;
	}
	public ServicelogService getServicelogService() {
		return servicelogService;
	}
	public void setServicelogService(ServicelogService servicelogService) {
		this.servicelogService = servicelogService;
	}
	public Servicelog getServicelog() {
		return servicelog;
	}
	public void setServicelog(Servicelog servicelog) {
		this.servicelog = servicelog;
	}
	public List<Servicelog> getServicelogs() {
		return servicelogs;
	}
	public void setServicelogs(List<Servicelog> servicelogs) {
		this.servicelogs = servicelogs;
	}
	
	public String sfindAllservice() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				if (level==3) {
					Salesman salesman=(Salesman)ActionContext.getContext().getApplication().get("user");
					servicelogs=servicelogService.findByChannel(salesman.getChannel().getId());
					customerPs=customerPService.findAllByManager(CustomerP.class, manager.getId());
					return "sfindAllservice_s";
				}else if (level==2) {
					Salesman salesman=(Salesman)ActionContext.getContext().getApplication().get("user");
					servicelogs=servicelogService.findBySalesman(salesman.getId());
					customerPs=customerPService.findAllByManager(CustomerP.class, manager.getId());
					return "sfindAllservice_s";
				}else{
					servicelogs=servicelogService.findAllByManager(Servicelog.class, manager.getId());
					customerPs=customerPService.findAllByManager(CustomerP.class, manager.getId());
					return "sfindAllservice_s";
				}
			}
		}else {
			return "error";
		}
	}
	
	public String findAllservice() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			CustomerP customerP=(CustomerP)ActionContext.getContext().getApplication().get("user");
			servicelogs=servicelogService.findByCustomer(customerP.getId());
			return "findAllservice_s";
		}else {
			return "error";
		}
	}
	
	public String deleteSomeservice() throws Exception{
		if(scid==null||scid==""){
			System.out.println("没有数据");
			return "deleteSomeservice_f";
		}
		else{
			String scid1[]=scid.split(", ");
			int [] scid2 = new int[scid1.length];
			for(int i=0;i<scid1.length;i++){
				scid2[i]=Integer.parseInt(scid1[i]);
			}
			for(int i=0;i<scid2.length;i++){
				servicelogService.deleteById(Servicelog.class, scid2[i]);
			}
			return "deleteSomeservice_s";
		}
	}
	
	public String deleteTheService() throws Exception{
		servicelogService.deleteById(Servicelog.class, servicelog.getId());
		return "deleteTheService_s";
	}
	
	public String findTheService() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			servicelog=servicelogService.findById(Servicelog.class, servicelog.getId());
			communionlogs=communionlogService.findCommunionlogBySerid(servicelog.getId());
			return "findTheService_s";
		}else {
			return "error";
		}
	}
	
	public String sfindTheService() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				servicelog=servicelogService.findById(Servicelog.class, servicelog.getId());
				communionlogs=communionlogService.findCommunionlogBySerid(servicelog.getId());
				customerPs=customerPService.findAllByManager(CustomerP.class, manager.getId());
				channels=channelService.findAllByManager(Channel.class, manager.getId());
				if(servicelog.getSalesman()!=null){
					salesmans=salesmanService.findSalesmanByChannel(servicelog.getSalesman().getChannel().getId());
				}
				if(servicelog.getOrders()!=null){
					orderss=orderService.findAllByManager(Orders.class, manager.getId());
				}
				if(servicelog.getProduct()!=null){
					products=productService.findAllByManager(Product.class, manager.getId());
				}
				return "sfindTheService_s";
			}
		}else {
			return "error";
		}
	}
	
	public String addservice() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			if(orders!=null){
				orders=orderService.findByStringId(Orders.class, orders.getId());
				servicelog.setOrders(orders);
			}
			if(product!=null){
				products=productService.findProductByNameAndManager(product.getPname(), manager.getId());
				servicelog.setProduct(products.get(0));
			}
			//String sctype=ActionContext.getContext().getApplication().get("sctype");
			CustomerP customerP=(CustomerP)ActionContext.getContext().getApplication().get("user");
			servicelog.setCustomerP(customerP);
			servicelog.setManager(manager);
			servicelog.setServiceways("在线交流");
			servicelog.setServicedate(new Date());
			servicelog.setStatus("未处理");
			servicelogService.save(servicelog);
			
			return "addservice_s";
		}else {
			return "error";
		}
	}
	
	public String saddservice() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				if(orders!=null){
					orders=orderService.findByStringId(Orders.class, orders.getId());
					servicelog.setOrders(orders);
					servicelog.setChannel(orders.getChannel());
				}
				if(product!=null){
					products=productService.findProductByNameAndManager(product.getPname(), manager.getId());
					servicelog.setProduct(products.get(0));
				}
				if(level==3||level==2){
					Salesman salesman1=(Salesman)ActionContext.getContext().getApplication().get("user");
					Channel channel=channelService.findById(Channel.class, salesman1.getChannel().getId());
					servicelog.setChannel(channel);
					servicelog.setSalesman(salesman1);
				}
				
				customerPs=customerPService.findCustomerPByNameAndManager(customerP.getCname(), manager.getId());
				servicelog.setCustomerP(customerPs.get(0));
				servicelog.setManager(manager);
				servicelog.setServicedate(new Date());
				servicelog.setStatus("未处理");
				servicelogService.save(servicelog);
				return "saddservice_s";
			}
		}else {
			return "error";
		}
	}
	
	public String findAllOrdersByAjax() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		orderss=orderService.findAllByManager(Orders.class, manager.getId());
		List<Orders> orderss1 = new ArrayList<Orders>();  
		for(int i=0;i<orderss.size();i++){ 
			Orders orders1=new Orders();
			orders1.setTitle(orderss.get(i).getTitle());
			orders1.setId(orderss.get(0).getId());
			orderss1.add(orders1);  
         } 
		JSONArray jsonArray = JSONArray.fromObject(orderss1);
		String jsonStr=jsonArray.toString();
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
	
	public String findAllProductByAjax() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		products=productService.findAllByManager(Product.class, manager.getId());
		List<Product> products1 = new ArrayList<Product>();  
		for(int i=0;i<products.size();i++){ 
			Product product1=new Product();
			product1.setPname(products.get(i).getPname());
			products1.add(product1);  
         } 
		JSONArray jsonArray = JSONArray.fromObject(products1);
		String jsonStr=jsonArray.toString();
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
	
	public String updateServicelog() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			String ev=servicelog.getEvaluation();
			servicelog=servicelogService.findById(Servicelog.class, servicelog.getId());
			servicelog.setEvaluation(ev);
			servicelog.setStatus("已处理");
			servicelogService.update(servicelog);
			return "updateServicelog_s";
		}else {
			return "error";
		}
	}
	
	public String supdateServicelog() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				if(orders!=null){
					orderss=orderService.findByTitleAndManager(orders.getTitle(), manager.getId());
					servicelog.setOrders(orderss.get(0));
					servicelog.setChannel(orderss.get(0).getChannel());
				}
				if(product!=null){
					products=productService.findProductByNameAndManager(product.getPname(), manager.getId());
					servicelog.setProduct(products.get(0));
				}
				customerPs=customerPService.findCustomerPByNameAndManager(customerP.getCname(), manager.getId());
				servicelog.setCustomerP(customerPs.get(0));
				channels=channelService.findChannelByNameAndManager(channel.getCname(), manager.getId());
				if(channels.size()>0){
					servicelog.setChannel(channels.get(0));
				}
				salesmans=salesmanService.findSalesmanByNameAndManager(salesman.getSname(), manager.getId());
				if(salesmans.size()>0){
					servicelog.setSalesman(salesmans.get(0));
				}
				if(servicelog.getStatus().equals("已处理")){
					servicelog.setEvaluation("无法评价");
				}
				servicelog.setManager(manager);
				
				Servicelog servicelog1=(Servicelog)servicelogService.findById(Servicelog.class, servicelog.getId());
				if(level==4){
					if(!servicelog1.getChannel().getCname().equals(servicelog.getChannel().getCname())){
						messages=messageService.findByMidLevelAndPid(servicelog.getId(), 2, servicelog1.getSalesman().getId());
						if(messages.size()>0){
							messageService.delete(messages.get(0));
						}
						List<Salesman> salesmans1=new ArrayList<Salesman>();
						salesmans1=salesmanService.findSalesmanByChannel(servicelog1.getChannel().getId());
						for (int i = 0; i < salesmans1.size(); i++) {
							if(salesmans1.get(i).getUserPower().getLevel()==3){
								messages=messageService.findByMidLevelAndPid(servicelog.getId(), 3, salesmans1.get(i).getId());
								if(messages.size()>0){
									messageService.delete(messages.get(0));
								}
							}
						}
						List<Salesman> salesmans2=new ArrayList<Salesman>();
						salesmans2=salesmanService.findSalesmanByChannel(servicelog.getChannel().getId());
						for (int i = 0; i < salesmans2.size(); i++) {
							if(salesmans2.get(i).getUserPower().getLevel()==3){
								if(salesmans2.get(i).getId()==servicelog.getSalesman().getId()){
									Message message2=new Message(1, 2, servicelog.getId(), 2, servicelog.getSalesman().getId());
									messageService.save(message2);
								}else{
									Message message2=new Message(1, 2, servicelog.getId(), 2, servicelog.getSalesman().getId());
									Message message3=new Message(1, 2, servicelog.getId(), 3, salesmans2.get(i).getId());
									messageService.save(message2);
									messageService.save(message3);
								}
							}
						}
						
					}else{
						if(!servicelog1.getSalesman().getSname().equals(servicelog.getSalesman().getSname())){
							List<Salesman> salesmans1=new ArrayList<Salesman>();
							salesmans1=salesmanService.findSalesmanByChannel(servicelog1.getChannel().getId());
							for (int i = 0; i < salesmans1.size(); i++) {
								if(salesmans1.get(i).getUserPower().getLevel()==3){
									if(salesmans1.get(i).getId()==servicelog1.getSalesman().getId()){
										if(salesmans1.get(i).getId()!=servicelog.getSalesman().getId()){
											Message message=new Message(1, 2, servicelog.getId(), 2, servicelog.getSalesman().getId());
											messageService.save(message);
										}
									}else{
										messages=messageService.findByMidLevelAndPid(servicelog.getId(), 2, servicelog1.getSalesman().getId());
										if(messages.size()>0){
											messageService.delete(messages.get(0));
										}
										if(salesmans1.get(i).getId()==servicelog.getSalesman().getId()){
											
										}else{
										
										}
									}
									messages=messageService.findByMidLevelAndPid(servicelog.getId(), 3, salesmans1.get(i).getId());
									if(messages.size()>0){
										messageService.delete(messages.get(0));
									}
								}
							}
						}
					}
				}
				
				
				servicelogService.update(servicelog);
				return "supdateServicelog_s";
			}
		}else {
			return "error";
		}
	}
	
}
