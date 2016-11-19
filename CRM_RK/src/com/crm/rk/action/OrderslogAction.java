package com.crm.rk.action;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import net.sf.excelutils.ExcelException;
import net.sf.excelutils.ExcelUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;

import com.crm.rk.model.Manager;
import com.crm.rk.model.Orders;
import com.crm.rk.model.Paylog;
import com.crm.rk.model.Salesman;
import com.crm.rk.model.Sendlog;
import com.crm.rk.service.OrderService;
import com.crm.rk.service.PaylogService;
import com.crm.rk.service.SendlogService;
import com.crm.rk.util.JsonDateValueProcessor;
import com.opensymphony.xwork2.ActionContext;

public class OrderslogAction {
	@Resource private OrderService orderService;
	@Resource private PaylogService paylogService;
	@Resource private SendlogService sendlogService;
	
	private Orders orders;
	private Paylog paylog;
	private Sendlog sendlog;
	private List<Orders> orderss;
	private List<Paylog> paylogs;
	private List<Sendlog> sendlogs;
	public Orders getOrders() {
		return orders;
	}
	public void setOrders(Orders orders) {
		this.orders = orders;
	}
	public Paylog getPaylog() {
		return paylog;
	}
	public void setPaylog(Paylog paylog) {
		this.paylog = paylog;
	}
	public Sendlog getSendlog() {
		return sendlog;
	}
	public void setSendlog(Sendlog sendlog) {
		this.sendlog = sendlog;
	}
	public List<Orders> getOrderss() {
		return orderss;
	}
	public void setOrderss(List<Orders> orderss) {
		this.orderss = orderss;
	}
	public List<Paylog> getPaylogs() {
		return paylogs;
	}
	public void setPaylogs(List<Paylog> paylogs) {
		this.paylogs = paylogs;
	}
	public List<Sendlog> getSendlogs() {
		return sendlogs;
	}
	public void setSendlogs(List<Sendlog> sendlogs) {
		this.sendlogs = sendlogs;
	}
	
	public String findAllOrders(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				if(level==3||level==2){
					Salesman salesman=(Salesman)ActionContext.getContext().getApplication().get("user");
					orderss=orderService.findOrdersByChannel(salesman.getChannel().getId());
					for (int i = 0; i < orderss.size(); i++) {
						paylogs=paylogService.findPaylogByOrders(orderss.get(i).getId());
						if(paylogs.size()>0){
							orderss.get(i).setRemainingPay(paylogs.get(paylogs.size()-1).getRemainingPay());
						}
					}
					return "findAllOrders_s";
				}else{
					orderss=orderService.findNoPayOrders(manager.getId());
					for (int i = 0; i < orderss.size(); i++) {
						paylogs=paylogService.findPaylogByOrders(orderss.get(i).getId());
						if(paylogs.size()>0){
							orderss.get(i).setRemainingPay(paylogs.get(paylogs.size()-1).getRemainingPay());
						}
					}
					return "findAllOrders_s";
				}
			}
		}else {
			return "error";
		}
	}
	
	public String findTheOrderlog(){
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				orders=orderService.findByStringId(Orders.class, orders.getId());
				sendlogs=sendlogService.findSendlogByOrders(orders.getId());
				paylogs=paylogService.findPaylogByOrders(orders.getId());
				return "findTheOrderlog_s";
			}
		}else {
			return "error";
		}
	}
	
	public String addOrderslog() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				orders=orderService.findByStringId(Orders.class, orders.getId());
				paylog.setOrders(orders);
				paylog.setRemainingPay(orders.getRemainingPay()-paylog.getRealPay());
				orders.setRemainingPay(orders.getRemainingPay()-paylog.getRealPay());
				orders.setPaymoney(orders.getPaymoney()+paylog.getRealPay());
				if(orders.getRemainingPay()<=0){
					orders.setStatus("已付清款项");
				}else{
					orders.setStatus("已付部分款项");
				}
				orderService.update(orders);
				paylogService.save(paylog);
				return "addOrderslog_s";
			}
		}else {
			return "error";
		}
	}
	
	public String addOrderslog2() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				orders=orderService.findByStringId(Orders.class, orders.getId());
				sendlog.setOrders(orders);
				sendlog.setSendPrice(orders.getDealprice()*sendlog.getSendNum());
				sendlogs=sendlogService.findSendlogByOrders(orders.getId());
				if(sendlogs.size()>0){
					sendlog.setRemainingSend(sendlogs.get(sendlogs.size()-1).getRemainingSend()-sendlog.getSendNum());
				}else{
					sendlog.setRemainingSend(orders.getAmount()-sendlog.getSendNum());
				}
				sendlogService.save(sendlog);
				return "addOrderslog2_s";
			}
		}else {
			return "error";
		}
	}
	
	public String updatePaylog() throws Exception{
		JsonConfig jsonConfig = new JsonConfig();  
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		paylog=paylogService.findById(Paylog.class, paylog.getId());
		Paylog paylog1=new Paylog();
		paylog1.setId(paylog.getId());
		paylog1.setOrders(paylog.getOrders());
		paylog1.setRealPay(paylog.getRealPay());
		paylog1.setRealPayDate(paylog.getRealPayDate());
		paylog1.setRemainingPay(paylog.getRemainingPay());
		JSONObject jsonObject = JSONObject.fromObject(paylog1,jsonConfig);
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
	
	public String updatePaylog2() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				orders=orderService.findByStringId(Orders.class, orders.getId());
				paylog.setOrders(orders);
				paylogs=paylogService.findPaylogByOrders(orders.getId());
				if(paylog.getId()==paylogs.get(paylogs.size()-1).getId()){
					paylog.setRemainingPay(paylogs.get(paylogs.size()-2).getRemainingPay()-paylog.getRealPay());
					orders.setRemainingPay(paylogs.get(paylogs.size()-2).getRemainingPay()-paylog.getRealPay());
				}else{
					int ii=0;
					for (int i = 0; i < paylogs.size(); i++) {
						if(paylogs.get(i).getId()==paylog.getId()){
							ii=i;
						}
					}
					if(ii==0){
						paylog.setRemainingPay(orders.getDealpriceT()-paylog.getRealPay());
					}else{
						paylog.setRemainingPay(paylogs.get(ii-1).getRemainingPay()-paylog.getRealPay());
					}
					for (int i = ii+1; i < paylogs.size(); i++) {
						if(paylogs.get(i-1).getId()==paylog.getId()){
							paylogs.get(i).setRemainingPay(paylog.getRemainingPay()-paylogs.get(i).getRealPay());
							paylogService.update(paylogs.get(i));
						}else{
							paylogs.get(i).setRemainingPay(paylogs.get(i-1).getRemainingPay()-paylogs.get(i).getRealPay());
							paylogService.update(paylogs.get(i));
						}
					}
					orders.setRemainingPay(paylogs.get(paylogs.size()-1).getRemainingPay());
				}
				paylogService.update(paylog);
				orders.setPaymoney(orders.getDealpriceT()-orders.getRemainingPay());
				if(orders.getRemainingPay()<=0){
					orders.setStatus("已付清款项");
				}
				orderService.update(orders);
				return "updatePaylog2_s";
			}
		}else {
			return "error";
		}
	}
	
	public String updateSendlog() throws Exception{
		JsonConfig jsonConfig = new JsonConfig();  
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		sendlog=sendlogService.findById(Sendlog.class, sendlog.getId());
		Sendlog sendlog1=new Sendlog();
		sendlog1.setId(sendlog.getId());
		sendlog1.setOrders(sendlog.getOrders());
		sendlog1.setRealSendDate(sendlog.getRealSendDate());
		sendlog1.setRemainingSend(sendlog.getRemainingSend());
		sendlog1.setSendNum(sendlog.getSendNum());
		sendlog1.setSendPrice(sendlog.getSendPrice());
		JSONObject jsonObject = JSONObject.fromObject(sendlog1,jsonConfig);
		String jsonStr1=jsonObject.toString();
		HttpServletResponse response=ServletActionContext.getResponse();
		try {
			response.setCharacterEncoding("utf-8"); 
			response.getWriter().print(jsonStr1);
			response.getWriter().flush();  
	        response.getWriter().close();  
		} catch (IOException e) {
			e.printStackTrace();
		}  
		return null;
	}

	public String updateSendlog2() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				orders=orderService.findByStringId(Orders.class, orders.getId());
				sendlog.setOrders(orders);
				sendlog.setSendPrice(orders.getDealprice()*sendlog.getSendNum());
				sendlogs=sendlogService.findSendlogByOrders(orders.getId());
				if(sendlog.getId()==sendlogs.get(sendlogs.size()-1).getId()){
					sendlog.setRemainingSend(sendlogs.get(sendlogs.size()-2).getRemainingSend()-sendlog.getSendNum());
				}else{
					int ii=0;
					for (int i = 0; i < sendlogs.size(); i++) {
						if(sendlogs.get(i).getId()==sendlog.getId()){
							ii=i;
						}
					}
					if(ii==0){
						sendlog.setRemainingSend(orders.getAmount()-sendlog.getSendNum());
					}else{
						sendlog.setRemainingSend(sendlogs.get(ii-1).getRemainingSend()-sendlog.getSendNum());
					}
					for (int i = ii+1; i < sendlogs.size(); i++) {
						if(sendlogs.get(i-1).getId()==sendlog.getId()){
							sendlogs.get(i).setRemainingSend(sendlog.getRemainingSend()-sendlogs.get(i).getSendNum());
							sendlogService.update(sendlogs.get(i));
						}else{
							sendlogs.get(i).setRemainingSend(sendlogs.get(i-1).getRemainingSend()-sendlogs.get(i).getSendNum());
							sendlogService.update(sendlogs.get(i));
						}
					}
				}
				sendlogService.update(sendlog);
				return "updateSendlog2_s";
			}
		}else {
			return "error";
		}
	}
	
	public void exportTableMessage() throws ExcelException, IOException{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				response.getWriter().println("<script> alert('当前权限等级暂时无法执行此操作');</script>");
			}else{
				orderss=orderService.findAllByManager(Orders.class, manager.getId());
				ExcelUtils.addValue("dataList", orderss);
		    	String tplpath = "/report/excel/exportOrdersInfomation.xls";
		    	response.reset();
		    	response.addHeader("Content-Type", "application/vnd.ms-excel");
		    	String filename = "订单信息统计";
		    	response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filename,"UTF-8") + ".xls");
		    	ExcelUtils.export(request.getSession().getServletContext(),tplpath,response.getOutputStream());
			}
		}else{
			response.getWriter().println("<script> alert('当前权限等级暂时无法执行此操作');</script>");
		}
	}
	
	public String deletePaylog(){
		System.out.println("!!!!!!!!!!!!!!!!"+paylog.getId());
		return "deletePaylog_s";
	}
	
	public String deleteSendlog(){
		System.out.println("!!!!!!!!!!!!!!!!"+sendlog.getId());
		return "deleteSendlog_s";
	}
	
}
