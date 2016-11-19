package com.crm.rk.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;

import org.apache.struts2.ServletActionContext;

import com.crm.rk.model.CustomerP;
import com.crm.rk.model.CustomerReport;
import com.crm.rk.model.CustomerReportlog;
import com.crm.rk.model.Manager;
import com.crm.rk.model.Orders;
import com.crm.rk.model.Product;
import com.crm.rk.model.ProductReport;
import com.crm.rk.model.Reportlog;
import com.crm.rk.service.CustomerPService;
import com.crm.rk.service.CustomerReportService;
import com.crm.rk.service.CustomerReportlogService;
import com.crm.rk.service.OrderService;
import com.crm.rk.service.ProductService;
import com.crm.rk.util.JsonDateValueProcessor;
import com.opensymphony.xwork2.ActionContext;

public class CustomerReportAction {
	@Resource private CustomerReportService customerReportService;
	@Resource private CustomerReportlogService customerReportlogService;
	@Resource private CustomerPService customerPService;
	@Resource private OrderService orderService;
	@Resource private ProductService productService;
	private CustomerReportlog customerReportlog;
	private List<CustomerReportlog> customerReportlogs;
	private CustomerReport customerReport;
	private List<CustomerReport> customerReports;
	private CustomerP customerP;
	private List<CustomerP> customerPs;
	private Orders orders;
	private List<Orders> orderss;
	private Product product;
	private List<Product> products;
	private String crid;
	public String getCrid() {
		return crid;
	}
	public void setCrid(String crid) {
		this.crid = crid;
	}
	public CustomerReportlog getCustomerReportlog() {
		return customerReportlog;
	}
	public void setCustomerReportlog(CustomerReportlog customerReportlog) {
		this.customerReportlog = customerReportlog;
	}
	public List<CustomerReportlog> getCustomerReportlogs() {
		return customerReportlogs;
	}
	public void setCustomerReportlogs(List<CustomerReportlog> customerReportlogs) {
		this.customerReportlogs = customerReportlogs;
	}
	public CustomerReport getCustomerReport() {
		return customerReport;
	}
	public void setCustomerReport(CustomerReport customerReport) {
		this.customerReport = customerReport;
	}
	public List<CustomerReport> getCustomerReports() {
		return customerReports;
	}
	public void setCustomerReports(List<CustomerReport> customerReports) {
		this.customerReports = customerReports;
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
	
	public String deleteSomeReport(){
		if(crid==null||crid==""){
			System.out.println("没有数据");
			return "deleteSomeCustomerReport_f";
		}
		else{
			String crid1[]=crid.split(", ");
			int [] crid2 = new int[crid1.length];
			for(int i=0;i<crid1.length;i++){
				crid2[i]=Integer.parseInt(crid1[i]);
			}
			for(int i=0;i<crid2.length;i++){
				System.out.println(crid2[i]);
			}
			return "deleteSomeCustomerReport_s";
		}
	}
	
	public String findAllCustomerReport() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				autoCreateCustomerReport();
				customerReports=customerReportService.findAllByManager(CustomerReport.class, manager.getId());
				return "findAllCustomerReport_s";
			}
		}else {
			return "error";
		}
	}
	
	@SuppressWarnings("deprecation")
	public void autoCreateCustomerReport() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		Date nowDate=new Date();
		if(nowDate.getDate()==1){
			Date startDate=new Date(nowDate.getYear(),nowDate.getMonth()-1,1);
			Date endDate=new Date(nowDate.getYear(), nowDate.getMonth(), 1);
			CustomerReport customerReport1=new CustomerReport();
			customerReport1.setStarttime(startDate);
			customerReport1.setEndtime(endDate);
			String stime=(customerReport1.getStarttime().getYear()+1900)+"-"+(customerReport1.getStarttime().getMonth()+1)+"-"+customerReport1.getStarttime().getDate();
			String etime=(customerReport1.getEndtime().getYear()+1900)+"-"+(customerReport1.getEndtime().getMonth()+1)+"-"+customerReport1.getEndtime().getDate(); 
			customerReport1.setReportname(stime+"——"+etime+"客户消费报告");
			customerReport1.setManager(manager);
			customerReportService.save(customerReport1);
			autoCreateCustomerReportlog();
		}
	}
	
	@SuppressWarnings("deprecation")
	public String CreateCustomerReport() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		String stime=(customerReport.getStarttime().getYear()+1900)+"-"+(customerReport.getStarttime().getMonth()+1)+"-"+customerReport.getStarttime().getDate();
		String etime=(customerReport.getEndtime().getYear()+1900)+"-"+(customerReport.getEndtime().getMonth()+1)+"-"+customerReport.getEndtime().getDate(); 
		customerReport.setReportname(stime+"——"+etime+"客户消费报告");
		customerReport.setManager(manager);
		customerReportService.save(customerReport);
		autoCreateCustomerReportlog();
		return "CreateCustomerReport_s";
	}
	
	@SuppressWarnings("deprecation")
	public void autoCreateCustomerReportlog() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		customerReports=customerReportService.findAllByManager(CustomerReport.class, manager.getId());
		customerReport=customerReports.get(customerReports.size()-1);
		String stime=(customerReport.getStarttime().getYear()+1900)+"-"+(customerReport.getStarttime().getMonth()+1)+"-"+customerReport.getStarttime().getDate();
		String etime=(customerReport.getEndtime().getYear()+1900)+"-"+(customerReport.getEndtime().getMonth()+1)+"-"+customerReport.getEndtime().getDate();
		orderss=orderService.findOrdersByDate(stime, etime, manager.getId());
		customerPs=customerPService.findAllByManager(CustomerP.class, manager.getId());
		for (int i = 0; i < customerPs.size(); i++) {
			for (int j = 0; j < orderss.size(); j++) {
				if(customerPs.get(i).getId()==orderss.get(j).getCustomerP().getId()){
					customerReportlogs=customerReportlogService.findIfHavaReportlog(customerReport.getId(), customerPs.get(i).getId());
					if(customerReportlogs.size()==0){
						CustomerReportlog customerReportlog1=new CustomerReportlog();
						customerReportlog1.setCustomerReport(customerReport);
						customerReportlog1.setCustomerP(customerPs.get(i));
						customerReportlog1.setTotal(orderss.get(j).getAmount());
						customerReportlog1.setMoney(orderss.get(j).getDealpriceT());
						customerReportlog1.setMoneyed(orderss.get(j).getPaymoney());
						customerReportlog1.setMoneying(orderss.get(j).getRemainingPay());
						customerReportlogService.save(customerReportlog1);
					}else{
						customerReportlogs.get(0).setTotal(customerReportlogs.get(0).getTotal()+orderss.get(j).getAmount());
						customerReportlogs.get(0).setMoney(customerReportlogs.get(0).getMoney()+orderss.get(j).getDealpriceT());
						customerReportlogs.get(0).setMoneyed(customerReportlogs.get(0).getMoneyed()+orderss.get(j).getPaymoney());
						customerReportlogs.get(0).setMoneying(customerReportlogs.get(0).getMoneying()+orderss.get(j).getRemainingPay());
						customerReportlogService.update(customerReportlogs.get(0));
					}
				}
			}
		}
	}
	
	public String findTheCustomerReportlog() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				customerReport=customerReportService.findById(CustomerReport.class, customerReport.getId());
				customerReportlogs=customerReportlogService.findCustomerReportlogByCrid(customerReport.getId());
				return "findTheCustomerReportlog_s";
			}
		}else {
			return "error";
		}
	}
	
	@SuppressWarnings("deprecation")
	public String findCustomerConsumelog() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		customerReport=customerReportService.findById(CustomerReport.class, customerReport.getId());
		String stime=(customerReport.getStarttime().getYear()+1900)+"-"+(customerReport.getStarttime().getMonth()+1)+"-"+customerReport.getStarttime().getDate();
		String etime=(customerReport.getEndtime().getYear()+1900)+"-"+(customerReport.getEndtime().getMonth()+1)+"-"+customerReport.getEndtime().getDate();
		orderss=orderService.findOrdersByDate(stime, etime,manager.getId());
		List<Orders> orderss1=new ArrayList<Orders>();
		for (int j = 0; j < orderss.size(); j++) {
			if(orderss.get(j).getCustomerP().getId()==customerP.getId()){
				Orders orders1=new Orders();
				orders1.setDealdate(orderss.get(j).getDealdate());
				orders1.setId(orderss.get(j).getId());
				orders1.setProduct(orderss.get(j).getProduct());
				orders1.setAmount(orderss.get(j).getAmount());
				orders1.setDealpriceT(orderss.get(j).getDealpriceT());
				orderss1.add(orders1);
			}
		}
		JsonConfig jsonConfig = new JsonConfig();  
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor()); 
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		JSONArray jsonArray = JSONArray.fromObject(orderss1,jsonConfig);
		String jsonStr=jsonArray.toString();
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
	
	public String deleteTheCustomerReport(){
		System.out.println(customerReport.getId());
		return "deleteTheCustomerReport_s";
	}
	
}
