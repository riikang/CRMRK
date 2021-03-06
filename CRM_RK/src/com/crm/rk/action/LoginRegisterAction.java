package com.crm.rk.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import net.sf.json.JSONString;

import org.apache.struts2.ServletActionContext;

import com.crm.rk.model.CustomerP;
import com.crm.rk.model.EmailMessage;
import com.crm.rk.model.Manager;
import com.crm.rk.model.Message;
import com.crm.rk.model.Salesman;
import com.crm.rk.model.UserPower;
import com.crm.rk.service.CustomerPService;
import com.crm.rk.service.EmailMessageService;
import com.crm.rk.service.ManagerService;
import com.crm.rk.service.MessageService;
import com.crm.rk.service.SalesmanService;
import com.crm.rk.service.UserPowerService;
import com.mysql.jdbc.Connection;
import com.opensymphony.xwork2.ActionContext;

import freemarker.template.EmptyMap;
//登录注册动作类
public class LoginRegisterAction {
	@Resource private UserPowerService userPowerService;
	@Resource private SalesmanService salesmanService;
	@Resource private CustomerPService customerPService;
	@Resource private ManagerService managerService;
	@Resource private MessageService messageService;
	@Resource private EmailMessageService emailMessageService;
	private Manager manager;
	private CustomerP customerP;
	private Salesman salesman;
	private UserPower userPower;
	private EmailMessage emailMessage;
	private List<Message> messages;
	private List<Manager> managers;
	private List<CustomerP> customerPs;
	private List<Salesman> salesmans;
	private List<UserPower> userPowers;
	private String idString;
	
	public EmailMessage getEmailMessage() {
		return emailMessage;
	}
	public void setEmailMessage(EmailMessage emailMessage) {
		this.emailMessage = emailMessage;
	}
	public List<Message> getMessages() {
		return messages;
	}
	public void setMessages(List<Message> messages) {
		this.messages = messages;
	}
	public Manager getManager() {
		return manager;
	}
	public void setManager(Manager manager) {
		this.manager = manager;
	}
	public List<Manager> getManagers() {
		return managers;
	}
	public void setManagers(List<Manager> managers) {
		this.managers = managers;
	}
	public String getIdString() {
		return idString;
	}
	public void setIdString(String idString) {
		this.idString = idString;
	}
	public CustomerP getCustomerP() {
		return customerP;
	}
	public void setCustomerP(CustomerP customerP) {
		this.customerP = customerP;
	}
	public Salesman getSalesman() {
		return salesman;
	}
	public void setSalesman(Salesman salesman) {
		this.salesman = salesman;
	}
	public UserPower getUserPower() {
		return userPower;
	}
	public void setUserPower(UserPower userPower) {
		this.userPower = userPower;
	}
	public List<CustomerP> getCustomerPs() {
		return customerPs;
	}
	public void setCustomerPs(List<CustomerP> customerPs) {
		this.customerPs = customerPs;
	}
	public List<Salesman> getSalesmans() {
		return salesmans;
	}
	public void setSalesmans(List<Salesman> salesmans) {
		this.salesmans = salesmans;
	}
	public List<UserPower> getUserPowers() {
		return userPowers;
	}
	public void setUserPowers(List<UserPower> userPowers) {
		this.userPowers = userPowers;
	}
	
	//登录验证
	public String validateLogin(){
		HttpServletRequest request=ServletActionContext.getRequest();
		String un=request.getParameter("un");
		String pw=request.getParameter("pw");
		userPowers=userPowerService.findByUsername(un);
		String result = "";
		if(userPowers.size()==0){
			result="账号不存在";
		}
		if(userPowers.size()>0){
			if(!pw.equals(userPowers.get(0).getPassword())){
				result="账号和密码不一致";
			}else{
				result="ok";
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
	
	//登录后，将登陆用户的权限等级，类，对应经理保存在application
	public String loginSet(){
		if(userPower==null){
			return "loginSet_f";
		}else{
			userPowers=userPowerService.findByUsername(userPower.getUsername());
			if(userPowers.get(0).getLevel()==4){
				managers=managerService.findByUserPower(userPowers.get(0).getId());
				ActionContext.getContext().getApplication().put("level", 4);
				//ActionContext.getContext().getApplication().put("user", managers.get(0));
				ActionContext.getContext().getApplication().put("manager", managers.get(0));
				return "loginSet_4s";
			}
			else if(userPowers.get(0).getLevel()==3){
				salesmans=salesmanService.findSalesmanByUserPower(userPowers.get(0).getId());
				messages=messageService.findByLevelAndPid(3, salesmans.get(0).getId());
				ActionContext.getContext().getApplication().put("level", 3);
				ActionContext.getContext().getApplication().put("user", salesmans.get(0));
				ActionContext.getContext().getApplication().put("manager", salesmans.get(0).getManager());
				ActionContext.getContext().getApplication().put("ssname", salesmans.get(0).getSname());
				return "loginSet_3s";
			}
			else if(userPowers.get(0).getLevel()==2){
				salesmans=salesmanService.findSalesmanByUserPower(userPowers.get(0).getId());
				messages=messageService.findByLevelAndPid(2, salesmans.get(0).getId());
				ActionContext.getContext().getApplication().put("level", 2);
				ActionContext.getContext().getApplication().put("user", salesmans.get(0));
				ActionContext.getContext().getApplication().put("manager", salesmans.get(0).getManager());
				ActionContext.getContext().getApplication().put("ssname", salesmans.get(0).getSname());
				return "loginSet_2s";
			}
			else if(userPowers.get(0).getLevel()==1){
				customerPs=customerPService.findCustomerPByUserPower(userPowers.get(0).getId());
				ActionContext.getContext().getApplication().put("level", 1);
				ActionContext.getContext().getApplication().put("user", customerPs.get(0));
				ActionContext.getContext().getApplication().put("manager", customerPs.get(0).getManager());
				return "loginSet_1s";
			}else {
				return "loginSet_f";
			}
		}
	}
	
	//注册验证用户名是否重复
	public String validateRegister3(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		HttpServletRequest request=ServletActionContext.getRequest();
		String un=request.getParameter("un");
		userPowers=userPowerService.findByUsername(un);
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
	
	//检查用户名似乎否重复，排除自身，用于更新
	public String validateRegister4() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		HttpServletRequest request=ServletActionContext.getRequest();
		int upid=Integer.valueOf(request.getParameter("upid"));
		String un=request.getParameter("un");
		userPower=userPowerService.findById(UserPower.class, upid);
		userPowers=userPowerService.findByUsername(un);
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
	
	//严验证邮箱是否重复
	public String validateRegister1(){
		HttpServletRequest request=ServletActionContext.getRequest();
		String un=request.getParameter("un");
		userPowers=userPowerService.findByEmail(un);
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
	
	/*public String validateRegister2() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		int upid=Integer.valueOf(request.getParameter("upid"));
		String un=request.getParameter("un");
		userPower=userPowerService.findById(UserPower.class, upid);
		userPowers=userPowerService.findByUsername(un);
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
	}*/
	
	//经理注册完成后，预备生成“客户关怀”模块的发送邮件内容，防止产生错误
	public String setRegister() throws Exception{
		userPower.setUsername(manager.getEmail());
		userPower.setLevel(4);
		manager.setUserPower(userPower);
		userPower.setManager(manager);
		userPowerService.save(userPower);
		
		emailMessage=new EmailMessage();
		emailMessage.setContext("生日快乐");
		emailMessage.setTitle("生日祝福");
		emailMessage.setType("生日");
		emailMessage.setManager(manager);
		emailMessageService.save(emailMessage);
		
		return "setRegister_s";
	}
	
	//注销
	public String logout(){
		if(ActionContext.getContext().getApplication().get("level")!=null){
			ActionContext.getContext().getApplication().remove("level");
			if(ActionContext.getContext().getApplication().get("user")!=null){
				ActionContext.getContext().getApplication().remove("user");
			}
			if(ActionContext.getContext().getApplication().get("manager")!=null){
				ActionContext.getContext().getApplication().remove("manager");
			}
			if(ActionContext.getContext().getApplication().get("ssname")!=null){
				ActionContext.getContext().getApplication().remove("ssname");
			}
			return "logout_s";
		}else{
			return "error";
		}
		
	}
	
}
