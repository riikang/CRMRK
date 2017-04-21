package com.crm.rk.action;

import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import com.crm.rk.model.CustomerP;
import com.crm.rk.model.EmailMessage;
import com.crm.rk.model.Manager;
import com.crm.rk.service.CustomerPService;
import com.crm.rk.service.EmailMessageService;
import com.opensymphony.xwork2.ActionContext;
//邮件动作类
public class EmailMessageAction {
	private static ApplicationContext ctx=new ClassPathXmlApplicationContext("applicationContext.xml");
	private JavaMailSender mailSender= (JavaMailSender) ctx.getBean("sender");  
	@Resource private EmailMessageService emailMessageService;
	@Resource private CustomerPService customerPService;
	private CustomerP customerP;
	private List<CustomerP> customerPs;
	EmailMessage emailMessage;
	List<EmailMessage> emailMessages;
	private String ccid;
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
	public String getCcid() {
		return ccid;
	}
	public void setCcid(String ccid) {
		this.ccid = ccid;
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
	
	//更新消息
	public String updateMessage() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				emailMessage.setManager(manager);
				emailMessageService.update(emailMessage);
				return "updateMessage_s";
			}
		}else {
			return "error";
		}
	}
	
	//在导航点击“客户关怀”时候调用
	public String customerpServer() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				customerPs=customerPService.findAllByManager(CustomerP.class, manager.getId());
				emailMessages=emailMessageService.findByManager(manager.getId());
				emailMessage=emailMessages.get(0);
				return "customerpServer_s";
			}
		}else {
			return "error";
		}
	}
	
	//发送邮件
	public String sendSomeEmail() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				if(ccid==null||ccid==""){
					System.out.println("没有数据");
					return "sendSomeEmail_f";
				}
				else{
					emailMessages=emailMessageService.findByManager(manager.getId());
					emailMessage=emailMessages.get(0);
					String ccid1[]=ccid.split(", ");
					int [] ccid2 = new int[ccid1.length];
					for(int i=0;i<ccid1.length;i++){
						ccid2[i]=Integer.parseInt(ccid1[i]);
					}
					for(int i=0;i<ccid2.length;i++){
						customerP=customerPService.findById(CustomerP.class, ccid2[i]);
						try {
							MimeMessage message = mailSender.createMimeMessage();
					        MimeMessageHelper helper = new MimeMessageHelper(message);
					        helper.setFrom("snsd4e9@163.com");
					        helper.setSentDate(new Date());
							helper.setTo(customerP.getEmail());
				            helper.setSubject(emailMessage.getTitle());
				            helper.setText(emailMessage.getContext(),true);
				            mailSender.send(message);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
					return "sendSomeEmail_s";
				}
			}
		}else {
			return "error";
		}
	}
	
}
