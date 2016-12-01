package com.crm.rk.action;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.crm.rk.dao.UserPowerDao;
import com.crm.rk.model.CustomerP;
import com.crm.rk.model.EmailMessage;
import com.crm.rk.model.Manager;
import com.crm.rk.model.UserPower;
import com.crm.rk.service.CustomerPService;
import com.crm.rk.service.EmailMessageService;
import com.crm.rk.service.UserPowerService;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class CustomerPAction extends ActionSupport {
	@Resource private CustomerPService customerPService;
	@Resource private UserPowerService userPowerService;
	private List<UserPower> userPowers;
	private List<CustomerP> customerPs;
	private UserPower userPower;
	private CustomerP customerP;
	@Resource private EmailMessageService emailMessageService;
	EmailMessage emailMessage;
	List<EmailMessage> emailMessages;
	private String ccid;
	
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
	
	public String findcustomer5(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else{
				customerPs=customerPService.findCustomerPByTypeAndManager("普通客户", manager.getId());
				return "findcustomer_s";
			}
		}else{
			return "error";
		}
	}
	
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
				customerPService.save(customerP);
				return "addcustomerp_s";
			}
		}else{
			return "error";
		}
	}
	
	public String deleteThecustomerp() throws Exception{
		customerPService.deleteById(CustomerP.class, customerP.getId());
		return "deleteThecustomerp_s";
	}
	
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
				customerPService.deleteById(CustomerP.class,ccid2[i]);
			}
			return "deleteSomecustomerp_s";
		}
	}
	
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
				userPowerService.update(userPower);
				customerPService.update(customerP);
				return "updatecustomerp_s";
			}
		}else{
			return "error";
		}
	}
	
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
