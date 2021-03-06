package com.crm.rk.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;

import com.crm.rk.model.Chance;
import com.crm.rk.model.Channel;
import com.crm.rk.model.CustomerP;
import com.crm.rk.model.Followup;
import com.crm.rk.model.Manager;
import com.crm.rk.model.Message;
import com.crm.rk.model.Mission;
import com.crm.rk.model.Orders;
import com.crm.rk.model.Product;
import com.crm.rk.model.Salesman;
import com.crm.rk.service.ChanceService;
import com.crm.rk.service.ChannelService;
import com.crm.rk.service.CustomerPService;
import com.crm.rk.service.FollowupService;
import com.crm.rk.service.MessageService;
import com.crm.rk.service.OrderService;
import com.crm.rk.service.ProductService;
import com.crm.rk.service.SalesmanService;
import com.opensymphony.xwork2.ActionContext;
//销售机会动作类
public class ChanceAction {
	@Resource private ChanceService chanceService;
	@Resource private ChannelService channelService;
	@Resource private SalesmanService salesmanService;
	@Resource private ProductService productService;
	@Resource private CustomerPService customerPService;
	@Resource private FollowupService followupService;
	@Resource private MessageService messageService;
	@Resource private OrderService orderService;
	private Followup followup;
	private Chance chance;
	private Channel channel;
	private Salesman salesman;
	private CustomerP customerP;
	private Product product;
	private List<Followup> followups;
	private List<Orders> orderss;
	private List<Chance> chances=new ArrayList<Chance>();
	private List<Channel> channels;
	private List<Salesman> salesmans;
	private List<CustomerP> customerPs;
	private List<Message> messages;
	private List<Product> products;
	private String cid;
	private String meid;
	private String newchanceid;
	public List<Orders> getOrderss() {
		return orderss;
	}
	public void setOrderss(List<Orders> orderss) {
		this.orderss = orderss;
	}
	public String getNewchanceid() {
		return newchanceid;
	}
	public void setNewchanceid(String newchanceid) {
		this.newchanceid = newchanceid;
	}
	public List<Message> getMessages() {
		return messages;
	}
	public void setMessages(List<Message> messages) {
		this.messages = messages;
	}
	public String getMeid() {
		return meid;
	}
	public void setMeid(String meid) {
		this.meid = meid;
	}
	public Followup getFollowup() {
		return followup;
	}
	public void setFollowup(Followup followup) {
		this.followup = followup;
	}
	public List<Followup> getFollowups() {
		return followups;
	}
	public void setFollowups(List<Followup> followups) {
		this.followups = followups;
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
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public Chance getChance() {
		return chance;
	}
	public void setChance(Chance chance) {
		this.chance = chance;
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
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public List<Chance> getChances() {
		return chances;
	}
	public void setChances(List<Chance> chances) {
		this.chances = chances;
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
	public List<Product> getProducts() {
		return products;
	}
	public void setProducts(List<Product> products) {
		this.products = products;
	}
	
	//读取机会（区分权限、经理）
	public String findAllchance() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				if(level==3||level==2){
					Salesman salesman=(Salesman)ActionContext.getContext().getApplication().get("user");
					chances=chanceService.findChanceByChannel(salesman.getChannel().getId());
					customerPs=customerPService.findAllByManager(CustomerP.class, manager.getId());
					channels=channelService.findAllByManager(Channel.class, manager.getId());
					products=productService.findAllByManager(Product.class, manager.getId());
					return "findAllchance_s";
				}else {
					chances=chanceService.findAllByManager(Chance.class, manager.getId());
					customerPs=customerPService.findAllByManager(CustomerP.class, manager.getId());
					channels=channelService.findAllByManager(Channel.class, manager.getId());
					products=productService.findAllByManager(Product.class, manager.getId());
					return "findAllchance_s";
				}
			}
		}else {
			return "error";
		}
	}
	
	//ajax读取销售员信息（区分渠道）
	public String findSalesman(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(channel.getCname()=="null"){
			return null;
		}else{
			channels=channelService.findChannelByNameAndManager(channel.getCname(), manager.getId());
			salesmans=salesmanService.findSalesmanByChannel(channels.get(0).getId());
			List<Salesman> salesmans1 = new ArrayList<Salesman>();  
			for(int i=0;i<salesmans.size();i++){ 
				 Salesman salesman1=new Salesman();
				 salesman1.setSname(salesmans.get(i).getSname()); 
	             salesmans1.add(salesman1);  
	         } 
			JSONArray jsonArray = JSONArray.fromObject(salesmans1);
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
	}
	
	//读取新销售机会（站内消息）
	public String findnewchance() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				String meid1[]=meid.split(",");
				int [] meid2 = new int[meid1.length];
				for(int i=0;i<meid1.length;i++){
					meid2[i]=Integer.parseInt(meid1[i]);
					
				}
				String newchanceid1[]=newchanceid.split(",");
				for(int i=0;i<newchanceid1.length;i++){
					messageService.deleteById(Message.class, Integer.parseInt(newchanceid1[i]));
				}
				for(int i=0;i<meid2.length;i++){
					Chance chance1=new Chance();
					chance1=chanceService.findById(Chance.class, meid2[i]);
					chances.add(chance1);
				}
				return "findnewchance_s";
			}
		}else{
			return "error";
		}
	}
	
	//新增销售机会
	public String addchance() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				products=productService.findProductByNameAndManager(product.getPname(), manager.getId());
				customerPs=customerPService.findCustomerPByNameAndManager(customerP.getCname(), manager.getId());
				channels=channelService.findChannelByNameAndManager(channel.getCname(), manager.getId());
				salesmans=salesmanService.findSalesmanByNameAndManager(salesman.getSname(), manager.getId());
				double ss=products.get(0).getPrice()*chance.getAmount();
				chance.setTotal(ss);
				chance.setGetDate(new Date());
				chance.setCustomerP(customerPs.get(0));
				chance.setProduct(products.get(0));
				chance.setChannel(channels.get(0));
				chance.setSalesman(salesmans.get(0));
				chance.setManager(manager);
				chanceService.save(chance);
				chances=chanceService.findAll(Chance.class);
				
				int pid=0;
				salesmans=salesmanService.findSalesmanByChannel(chances.get(chances.size()-1).getChannel().getId());
				for (int i = 0; i < salesmans.size(); i++) {
					if(salesmans.get(i).getUserPower().getLevel()==3){
						pid=salesmans.get(i).getId();
					}
				}
				
				//根据销售机会信息，判断用户状态
				if(chance.getStage().equals("确认订单")||chance.getStage().equals("成功交易")){
					customerPs.get(0).setStatus("成交客户");
				}else if(chance.getStage().equals("失败交易")){
					customerPs.get(0).setStatus("已流失客户");
				}else{
					customerPs.get(0).setStatus("意向客户");
				}
				customerPService.update(customerPs.get(0));
				
				//生成站内消息
				if(level==4){
					if(pid==chances.get(chances.size()-1).getSalesman().getId()){
						Message message1=new Message(1,5,chances.get(chances.size()-1).getId(),3,chances.get(chances.size()-1).getSalesman().getId());
						messageService.save(message1);
					}else{
						Message message1=new Message(1,5,chances.get(chances.size()-1).getId(),2,chances.get(chances.size()-1).getSalesman().getId());
						Message message2=new Message(1,5,chances.get(chances.size()-1).getId(),3,pid);
						messageService.save(message1);
						messageService.save(message2);
					}
				}
				if(level==3){
					if(pid!=chances.get(chances.size()-1).getSalesman().getId()){
						Message message1=new Message(1,5,chances.get(chances.size()-1).getId(),2,chances.get(chances.size()-1).getSalesman().getId());
						messageService.save(message1);
					}
				}
				return "addchance_s";
			}
		}else {
			return "error";
		}
	}
	
	//判断是否可删除销售机会（单个，防止应为存在外键，而删除出错）
	public String ifcandeleteone(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		if(manager!=null){
			int deleteid=Integer.parseInt(request.getParameter("deleteid"));
			String result="";
			orderss=orderService.findOrdersByChance(deleteid);
			if(orderss.size()>0){
				result="1";
			}else{
				result="0";
			}
			try {
				response.setCharacterEncoding("utf-8"); 
				response.getWriter().print(result);
				response.getWriter().flush();  
		        response.getWriter().close();  
			} catch (IOException e) {
				e.printStackTrace();
			}  
		}else{
			try {
				response.setCharacterEncoding("utf-8"); 
				response.getWriter().print("<script> alert('当前权限等级暂时无法执行此操作');</script>");
				response.getWriter().flush();  
		        response.getWriter().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	//判断是否可删除销售机会（多个，防止应为存在外键，而删除出错）
	public String ifcandelete(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		if(manager!=null){
			String deleteid=request.getParameter("deleteid");
			String result="";
			String deleteid1[]=deleteid.split(", ");
			int [] deleteid2 = new int[deleteid1.length];
			for(int i=0;i<deleteid1.length;i++){
				deleteid2[i]=Integer.parseInt(deleteid1[i]);
				orderss=orderService.findOrdersByChance(deleteid2[i]);;
				if(orderss.size()>0 ){
					result="1";
					break;
				}else{
					result="0";
				}
			}
			try {
				response.setCharacterEncoding("utf-8"); 
				response.getWriter().print(result);
				response.getWriter().flush();  
		        response.getWriter().close();  
			} catch (IOException e) {
				e.printStackTrace();
			}  
		}else{
			try {
				response.setCharacterEncoding("utf-8"); 
				response.getWriter().print("<script> alert('当前权限等级暂时无法执行此操作');</script>");
				response.getWriter().flush();  
		        response.getWriter().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	//删除销售机会（多个）
	public String deleteSomechance() throws Exception{
		if(cid==null||cid==""){
			System.out.println("没有数据");
			return "deleteSomechance_f";
		}
		else{
			String cid1[]=cid.split(", ");
			int [] cid2 = new int[cid1.length];
			for(int i=0;i<cid1.length;i++){
				cid2[i]=Integer.parseInt(cid1[i]);
			}
			for(int i=0;i<cid2.length;i++){
				followups=followupService.findFollowupByChanceId(cid2[i]);
				for (int j = 0; j < followups.size(); j++) {
					followupService.deleteById(Followup.class, followups.get(j).getId());
				}
				chanceService.deleteById(Chance.class, cid2[i]);
			}
			return "deleteSomechance_s";
		}
	}
	
	//读取单个销售机会
	public String findTheChance() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				ActionContext.getContext().getApplication().put("chanceid", chance.getId());
				chance=chanceService.findById(Chance.class, chance.getId());
				channels=channelService.findAllByManager(Channel.class, manager.getId());
				products=productService.findAllByManager(Product.class, manager.getId());
				customerPs=customerPService.findAllByManager(CustomerP.class, manager.getId());
				salesmans=salesmanService.findSalesmanByChannel(chance.getChannel().getId());
				followups=followupService.findFollowupByChanceId(chance.getId());
				return "findTheChance_s";
			}
		}else {
			return "error";
		}
	}
	
	//从跟踪记录返回到对应的销售机会
	public String goBackTheChance() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				int chanceid=(Integer)ActionContext.getContext().getApplication().get("chanceid");
				chance=chanceService.findById(Chance.class, chanceid);
				channels=channelService.findAllByManager(Channel.class, manager.getId());
				products=productService.findAllByManager(Product.class, manager.getId());
				customerPs=customerPService.findAllByManager(CustomerP.class ,manager.getId());
				salesmans=salesmanService.findSalesmanByChannel(chance.getChannel().getId());
				followups=followupService.findFollowupByChanceId(chanceid);
				return "goBackTheChance_s";
			}
		}else {
			return "error";
		}
	}
	
	//删除单个销售机会
	public String deleteTheChance() throws Exception{
		followups=followupService.findFollowupByChanceId(chance.getId());
		for (int j = 0; j < followups.size(); j++) {
			followupService.deleteById(Followup.class, followups.get(j).getId());
		}
		chanceService.deleteById(Chance.class,chance.getId());
		return "deleteTheChance_s";
	}
	
	//更新销售机会，同时判断否需要生成站内消息（判断是否改变了负责销售员，负责渠道）
	public String updateChance() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				products=productService.findProductByNameAndManager(product.getPname(), manager.getId());
				double ss=products.get(0).getPrice()*chance.getAmount();
				chance.setTotal(ss);
				customerPs=customerPService.findCustomerPByNameAndManager(customerP.getCname(), manager.getId());
				channels=channelService.findChannelByNameAndManager(channel.getCname(), manager.getId());
				salesmans=salesmanService.findSalesmanByNameAndManager(salesman.getSname(), manager.getId());
				chance.setCustomerP(customerPs.get(0));
				chance.setProduct(products.get(0));
				chance.setChannel(channels.get(0));
				chance.setSalesman(salesmans.get(0));
				chance.setManager(manager);
				
				Chance chance1=new Chance();
				chance1=chanceService.findById(Chance.class, chance.getId());
				if(chance1.getChannel().getId()==channels.get(0).getId()){
					if(chance1.getSalesman().getId()!=salesmans.get(0).getId()){
						messages=messageService.findByMidLevelAndPid(chance.getId(), 2, chance1.getSalesman().getId());
						if(messages.size()>0){
							messageService.delete(messages.get(0));
						}
						List<Salesman> salesmans1=salesmanService.findSalesmanByChannel(salesmans.get(0).getChannel().getId());
						for (int i = 0; i < salesmans1.size(); i++) {
							if(salesmans1.get(i).getUserPower().getLevel()==3){
								if(salesmans1.get(i).getId()!=salesmans.get(0).getId()){
									Message message1=new Message(1, 5, chance.getId(), 2, salesmans.get(0).getId());
									messageService.save(message1);
								}
							}
						}
					}
				}else{
					List<Salesman> salesmans2=salesmanService.findSalesmanByChannel(chance1.getChannel().getId());
					for (int i = 0; i < salesmans2.size(); i++) {
						if(salesmans2.get(i).getUserPower().getLevel()==3){
							messages=messageService.findByMidLevelAndPid(chance.getId(), 3, salesmans2.get(i).getId());
							if(messages.size()>0){
								messageService.delete(messages.get(0));
							}
						}
					}
					messages=messageService.findByMidLevelAndPid(chance.getId(), 2, chance1.getSalesman().getId());
					if(messages.size()>0){
						messageService.delete(messages.get(0));
					}
					List<Salesman> salesmans1=salesmanService.findSalesmanByChannel(salesmans.get(0).getChannel().getId());
					for (int i = 0; i < salesmans1.size(); i++) {
						if(salesmans1.get(i).getUserPower().getLevel()==3){
							if(salesmans1.get(i).getId()==salesmans.get(0).getId()){
								Message message1=new Message(1, 5, chance.getId(), 3, salesmans.get(0).getId());
								messageService.save(message1);
							}else{
								Message message1=new Message(1, 5, chance.getId(), 2, salesmans.get(0).getId());
								Message message2=new Message(1, 5, chance.getId(), 3, salesmans1.get(i).getId());
								messageService.save(message1);
								messageService.save(message2);
							}
						}
					}
				}
				
				//根据机会信息判断用户状态
				if(chance.getStage().equals("确认订单")||chance.getStage().equals("成功交易")){
					customerPs.get(0).setStatus("成交客户");
				}else if(chance.getStage().equals("失败交易")){
					customerPs.get(0).setStatus("已流失客户");
				}else{
					customerPs.get(0).setStatus("意向客户");
				}
				customerPService.update(customerPs.get(0));
					
				chanceService.update(chance);
				return "updateChance_s";
			}
		}else {
			return "error";
		}
	}
	
	//ajax验证销售机会名称是否重复（新增）
	public String validateInput1(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		if(manager!=null){
			String chancename=request.getParameter("chancename");
			String result="";
			chances=chanceService.findChanceByNameAndManager(chancename, manager.getId());
			if(chances.size()>0){
				result="1";
			}else{
				result="0";
			}
			try {
				response.setCharacterEncoding("utf-8"); 
				response.getWriter().print(result);
				response.getWriter().flush();  
		        response.getWriter().close();  
			} catch (IOException e) {
				e.printStackTrace();
			}  
		}else{
			try {
				response.setCharacterEncoding("utf-8"); 
				response.getWriter().print("<script> alert('当前权限等级暂时无法执行此操作');</script>");
				response.getWriter().flush();  
		        response.getWriter().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	//ajax验证销售机会名称是否重复（更新，需要排除自身）
	public String validateInput2() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		if(manager!=null){
			String chancename=request.getParameter("chancename");
			int chanceid=Integer.valueOf(request.getParameter("chanceid"));
			String result="";
			chance=chanceService.findById(Chance.class, chanceid);
			if(!chance.getName().equals(chancename)){
				chances=chanceService.findChanceByNameAndManager(chancename, manager.getId());
				if(chances.size()>0){
					result="1";
				}else{
					result="0";
				}
			}else{
				result="0";
			}
			try {
				response.setCharacterEncoding("utf-8"); 
				response.getWriter().print(result);
				response.getWriter().flush();  
		        response.getWriter().close();  
			} catch (IOException e) {
				e.printStackTrace();
			}  
		}else{
			try {
				response.setCharacterEncoding("utf-8"); 
				response.getWriter().print("<script> alert('当前权限等级暂时无法执行此操作');</script>");
				response.getWriter().flush();  
		        response.getWriter().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	
}
