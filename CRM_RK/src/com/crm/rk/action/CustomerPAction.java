package com.crm.rk.action;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.crm.rk.dao.UserPowerDao;
import com.crm.rk.model.Chance;
import com.crm.rk.model.CustomerP;
import com.crm.rk.model.CustomerReportlog;
import com.crm.rk.model.EmailMessage;
import com.crm.rk.model.Manager;
import com.crm.rk.model.Orders;
import com.crm.rk.model.Servicelog;
import com.crm.rk.model.UserPower;
import com.crm.rk.service.ChanceService;
import com.crm.rk.service.CustomerPService;
import com.crm.rk.service.CustomerReportlogService;
import com.crm.rk.service.EmailMessageService;
import com.crm.rk.service.OrderService;
import com.crm.rk.service.ServicelogService;
import com.crm.rk.service.UserPowerService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
//客户动作类
public class CustomerPAction extends ActionSupport {
	@Resource private CustomerPService customerPService;
	@Resource private UserPowerService userPowerService;
	@Resource private CustomerReportlogService customerReportlogService;
	@Resource private ChanceService chanceService;
	@Resource private OrderService orderService;
	@Resource private ServicelogService servicelogService;
	private List<UserPower> userPowers;
	private List<CustomerP> customerPs;
	private List<CustomerReportlog> customerReportlogs;
	private List<Chance> chances;
	private List<Orders> orderss;
	private List<Servicelog> servicelogs;
	private UserPower userPower;
	private CustomerP customerP;
	@Resource private EmailMessageService emailMessageService;
	EmailMessage emailMessage;
	List<EmailMessage> emailMessages;
	private String ccid;
	 
	public List<CustomerReportlog> getCustomerReportlogs() {
		return customerReportlogs;
	}
	public void setCustomerReportlogs(List<CustomerReportlog> customerReportlogs) {
		this.customerReportlogs = customerReportlogs;
	}
	public List<Chance> getChances() {
		return chances;
	}
	public void setChances(List<Chance> chances) {
		this.chances = chances;
	}
	public List<Orders> getOrderss() {
		return orderss;
	}
	public void setOrderss(List<Orders> orderss) {
		this.orderss = orderss;
	}
	public List<Servicelog> getServicelogs() {
		return servicelogs;
	}
	public void setServicelogs(List<Servicelog> servicelogs) {
		this.servicelogs = servicelogs;
	}
	public List<UserPower> getUserPowers() {
		return userPowers;
	}
	public void setUserPowers(List<UserPower> userPowers) {
		this.userPowers = userPowers;
	}
	public UserPower getUserPower() {
		return userPower;
	}
	public void setUserPower(UserPower userPower) {
		this.userPower = userPower;
	}
	public EmailMessage getEmailMessage() {
		return emailMessage;
	}
	public void setEmailMessage(EmailMessage emailMessage) {
		this.emailMessage = emailMessage;
	}
	public List<EmailMessage> getEmailMessages() {
		return emailMessages;
	}
	public void setEmailMessages(List<EmailMessage> emailMessages) {
		this.emailMessages = emailMessages;
	}
	public String getCcid() {
		return ccid;
	}
	public void setCcid(String ccid) {
		this.ccid = ccid;
	}
	public List<CustomerP> getCustomerPs() {
		return customerPs;
	}
	public void setCustomerPs(List<CustomerP> customerPs) {
		this.customerPs = customerPs;
	}
	public CustomerP getCustomerP() {
		return customerP;
	}
	public void setCustomerP(CustomerP customerP) {
		this.customerP = customerP;
	}
	
	//读取所有客户
	public	String findAllcustomer(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else{
				customerPs=customerPService.findAllByManager(CustomerP.class, manager.getId());
				return "findAllcustomer_s";
			}
		}else{
			return "error";
		}
	}
	
	//读取所有个人客户
	public String findAllcustomerp() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else{
				customerPs=customerPService.findCustomerPByifcompanyAndManager("否", manager.getId());
				return "findAllcustomerp_s";
			}
		}else{
			return "error";
		}
	}
	
	//读取所有企业客户
	public String findAllcustomerc() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else{
				customerPs=customerPService.findCustomerPByifcompanyAndManager("是", manager.getId());
				return "findAllcustomerc_s";
			}
		}else{
			return "error";
		}
	}
	
	//读取潜在客户
	public String findcustomer1(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else{
				customerPs=customerPService.findCustomerPByStatusAndManager("潜在客户", manager.getId());
				return "findcustomer_s";
			}
		}else{
			return "error";
		}
	}
	
	//读取意向客户
	public String findcustomer2(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else{
				customerPs=customerPService.findCustomerPByStatusAndManager("意向客户", manager.getId());
				return "findcustomer_s";
			}
		}else{
			return "error";
		}
	}
	
	//读取成交客户
	public String findcustomer3(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else{
				customerPs=customerPService.findCustomerPByStatusAndManager("成交客户", manager.getId());
				return "findcustomer_s";
			}
		}else{
			return "error";
		}
	}
	
	//读取已流失客户
	public String findcustomer4(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else{
				customerPs=customerPService.findCustomerPByStatusAndManager("已流失客户", manager.getId());
				return "findcustomer_s";
			}
		}else{
			return "error";
		}
	}
	
	//读取普通会员
	public String findcustomer5(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else{
				customerPs=customerPService.findCustomerPByTypeAndManager("普通会员", manager.getId());
				return "findcustomer_s";
			}
		}else{
			return "error";
		}
	}
	
	//读取VIP1
	public String findcustomer6(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else{
				customerPs=customerPService.findCustomerPByTypeAndManager("VIP1", manager.getId());
				return "findcustomer_s";
			}
		}else{
			return "error";
		}
	}
	
	//读取VIP2
	public String findcustomer7(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else{
				customerPs=customerPService.findCustomerPByTypeAndManager("VIP2", manager.getId());
				return "findcustomer_s";
			}
		}else{
			return "error";
		}
	}
	
	//读取VIP3
	public String findcustomer8(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else{
				customerPs=customerPService.findCustomerPByTypeAndManager("VIP3", manager.getId());
				return "findcustomer_s";
			}
		}else{
			return "error";
		}
	}
	
	//添加客户
	public String addcustomerp() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else{
				UserPower userPower2=new UserPower();
				userPower2.setLevel(1);
				userPower2.setUsername(customerP.getEmail());
				String pw=customerP.getEmail().substring(0, customerP.getEmail().indexOf("@"));
				userPower2.setPassword(pw);
				userPowerService.save(userPower2);
				userPowers=userPowerService.findAll(UserPower.class);
				customerP.setManager(manager);
				customerP.setUserPower(userPowers.get(userPowers.size()-1));
				
				//判断客户状态是否为空，若为空则设为潜在客户
				if(customerP.getStatus()==null||customerP.getStatus().equals("")){
					customerP.setStatus("潜在客户");
				}
				
				customerPService.save(customerP);
				return "addcustomerp_s";
			}
		}else{
			return "error";
		}
	}
	
	//判断客户是否可以删除（单个，防止因为存在外键而报错）
	public String ifcandeleteone(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		if(manager!=null){
			int deleteid=Integer.parseInt(request.getParameter("deleteid"));
			String result="";
			chances=chanceService.findChanceByCustomerp(deleteid);
			orderss=orderService.findByCustomer(deleteid, manager.getId());
			servicelogs=servicelogService.findByCustomer(deleteid);
			if(chances.size()>0 || orderss.size()>0 || servicelogs.size()>0 ){
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
	
	//判断客户是否可以删除（多个，防止因为存在外键而报错）
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
				chances=chanceService.findChanceByCustomerp(deleteid2[i]);
				orderss=orderService.findByCustomer(deleteid2[i], manager.getId());
				servicelogs=servicelogService.findByCustomer(deleteid2[i]);
				if(chances.size()>0 || orderss.size()>0 || servicelogs.size()>0 ){
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
	
	//删除客户（单个）
	public String deleteThecustomerp() throws Exception{
		customerReportlogs=customerReportlogService.findCustomerReportlogByCustomerp(customerP.getId());
		for (int i = 0; i < customerReportlogs.size(); i++) {
			customerReportlogService.deleteById(CustomerReportlog.class, customerReportlogs.get(i).getId());
		}
		customerPService.deleteById(CustomerP.class, customerP.getId());
		return "deleteThecustomerp_s";
	}
	
	//删除客户（多个）
	public String deleteSomecustomerp() throws Exception{
		if(ccid==null||ccid==""){
			System.out.println("没有数据");
			return "deleteSomecustomerp_f";
		}
		else{
			String ccid1[]=ccid.split(", ");
			int [] ccid2 = new int[ccid1.length];
			for(int i=0;i<ccid1.length;i++){
				ccid2[i]=Integer.parseInt(ccid1[i]);
			}
			for(int i=0;i<ccid2.length;i++){
				customerReportlogs=customerReportlogService.findCustomerReportlogByCustomerp(ccid2[i]);
				for (int j = 0; j < customerReportlogs.size(); j++) {
					customerReportlogService.deleteById(CustomerReportlog.class, customerReportlogs.get(j).getId());
				}
				customerPService.deleteById(CustomerP.class,ccid2[i]);
			}
			return "deleteSomecustomerp_s";
		}
	}
	
	//根据ID读取单个客户信息
	public String findThecustomerp() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else{
				customerP=customerPService.findById(CustomerP.class, customerP.getId());
				return "findThecustomerp_s";
			}
		}else{
			return "error";
		}
	}
	
	//更新客户信息
	public String updatecustomerp() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else{
				userPower=userPowerService.findById(UserPower.class, userPower.getId());
				userPower.setUsername(customerP.getEmail());
				customerP.setUserPower(userPower);
				customerP.setManager(manager);
				
				//判断客户状态是否为空，若为空则设为潜在客户
				if(customerP.getStatus()==null||customerP.getStatus().equals("")){
					customerP.setStatus("潜在客户");
				}
				
				userPowerService.update(userPower);
				customerPService.update(customerP);
				return "updatecustomerp_s";
			}
		}else{
			return "error";
		}
	}
	
	//检查用户名称（登陆账号）是否重复
	public String validateInput(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		HttpServletRequest request=ServletActionContext.getRequest();
		String em=request.getParameter("em");
		userPowers=userPowerService.findByUsername(em);
		String result="";
		if(userPowers.size()==0){
			result="0";
		}else{
			result="1";
		}
		HttpServletResponse response=ServletActionContext.getResponse();
		try {
			response.setCharacterEncoding("utf-8"); 
			response.getWriter().print(result);
			response.getWriter().flush();  
	        response.getWriter().close();  
		} catch (IOException e) {
			e.printStackTrace();
		}  
		return null;
	}
	
	//检查用户名称（登陆账号）是否重复（排除自身，用于更新时候调用）
	public String validateInput2() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		HttpServletRequest request=ServletActionContext.getRequest();
		String em=request.getParameter("em");
		int uid=Integer.valueOf(request.getParameter("uid")); 
		userPowers=userPowerService.findByUsername(em);
		userPower=userPowerService.findById(UserPower.class, uid);
		String result="";
		if(userPowers.size()==0){
			result="0";
		}else{
			if(userPowers.get(0).getUsername().equals(userPower.getUsername())){
				result="2";
			}else{
				result="1";
			}
		}
		HttpServletResponse response=ServletActionContext.getResponse();
		try {
			response.setCharacterEncoding("utf-8"); 
			response.getWriter().print(result);
			response.getWriter().flush();  
	        response.getWriter().close();  
		} catch (IOException e) {
			e.printStackTrace();
		}  
		return null;
	}
	
	//验证客户名是否重复（区分经理）
	public String validateInput3(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		if(manager!=null){
			String cname=request.getParameter("cname");
			String result="";
			customerPs=customerPService.findCustomerPByNameAndManager(cname, manager.getId());
			if(customerPs.size()>0){
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
	
	//验证客户名是否重复（区分经理，排除自身，用于更新时候调用）
	public String validateInput4() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		if(manager!=null){
			String cname=request.getParameter("cname");
			int cid=Integer.valueOf(request.getParameter("cid"));
			String result="";
			customerP=customerPService.findById(CustomerP.class, cid);
			if(!customerP.getCname().equals(cname)){
				customerPs=customerPService.findCustomerPByNameAndManager(cname, manager.getId());
				if(customerPs.size()>0){
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
