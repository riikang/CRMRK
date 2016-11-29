package com.crm.rk.action;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import net.sf.excelutils.ExcelUtils;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;

import com.crm.rk.model.CustomerP;
import com.crm.rk.model.CustomerReport;
import com.crm.rk.model.Manager;
import com.crm.rk.model.Orders;
import com.crm.rk.model.Product;
import com.crm.rk.model.ProductReport;
import com.crm.rk.model.Reportlog;
import com.crm.rk.service.CustomerPService;
import com.crm.rk.service.OrderService;
import com.crm.rk.service.ProductReportService;
import com.crm.rk.service.ProductService;
import com.crm.rk.service.ReportlogService;
import com.crm.rk.util.JsonDateValueProcessor;
import com.opensymphony.xwork2.ActionContext;

public class ProductReportAction {
	@Resource private ProductReportService productReportService;
	@Resource private OrderService orderService;
	@Resource private ProductService productService;
	@Resource private ReportlogService reportlogService;
	@Resource private CustomerPService customerPService;
	private CustomerP customerP;
	private ProductReport productReport;
	private Reportlog reportlog;
	private Product product;
	private Orders orders;
	private List<ProductReport> productReports;
	private List<CustomerP> customerPs;
	private List<Reportlog> reportlogs;
	private List<Product> products;
	private List<Orders> orderss;
	private String prid;
	
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
	public String getPrid() {
		return prid;
	}
	public void setPrid(String prid) {
		this.prid = prid;
	}
	public Reportlog getReportlog() {
		return reportlog;
	}
	public void setReportlog(Reportlog reportlog) {
		this.reportlog = reportlog;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public Orders getOrders() {
		return orders;
	}
	public void setOrders(Orders orders) {
		this.orders = orders;
	}
	public List<Reportlog> getReportlogs() {
		return reportlogs;
	}
	public void setReportlogs(List<Reportlog> reportlogs) {
		this.reportlogs = reportlogs;
	}
	public List<Product> getProducts() {
		return products;
	}
	public void setProducts(List<Product> products) {
		this.products = products;
	}
	public List<Orders> getOrderss() {
		return orderss;
	}
	public void setOrderss(List<Orders> orderss) {
		this.orderss = orderss;
	}
	public ProductReport getProductReport() {
		return productReport;
	}
	public void setProductReport(ProductReport productReport) {
		this.productReport = productReport;
	}
	public List<ProductReport> getProductReports() {
		return productReports;
	}
	public void setProductReports(List<ProductReport> productReports) {
		this.productReports = productReports;
	}
	
	public String findAllProductReport() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				autoCreateProductReport();
				productReports=productReportService.findAllByManager(ProductReport.class, manager.getId());
				return "findAllProductReport_s";
			}
		}else {
			return "error";
		}
	}
	
	@SuppressWarnings("deprecation")
	public void autoCreateProductReport() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		Date nowDate=new Date();
		if(nowDate.getDate()==1){
			int totalnum=0;
			double totalmoney=0,totalmoneyed=0,totalmoneying=0;
			String stime=(nowDate.getYear()+1900)+"-"+(nowDate.getMonth())+"-1";
			String etime=(nowDate.getYear()+1900)+"-"+(nowDate.getMonth()+1)+"-1";
			orderss=orderService.findOrdersByDate(stime, etime,manager.getId());
			Date startDate=new Date(nowDate.getYear(),nowDate.getMonth()-1,1);
			Date endDate=new Date(nowDate.getYear(), nowDate.getMonth(), 1);
			for (int i = 0; i < orderss.size(); i++) {
				totalnum=totalnum+orderss.get(i).getAmount();
				totalmoney=totalmoney+orderss.get(i).getDealpriceT();
				totalmoneyed=totalmoneyed+orderss.get(i).getPaymoney();
				totalmoneying=totalmoneying+orderss.get(i).getRemainingPay();
			}
			ProductReport productReport1=new ProductReport();
			productReport1.setStarttime(startDate);
			productReport1.setEndtime(endDate);
			productReport1.setTotal(totalnum);
			productReport1.setMoney(totalmoney);
			productReport1.setMoneyed(totalmoneyed);
			productReport1.setMoneying(totalmoneying);
			productReport1.setManager(manager);
			productReportService.save(productReport1);
			autoCreateProductReportlog();
		}
	}
	
	@SuppressWarnings("deprecation")
	public void autoCreateProductReportlog() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		productReports=productReportService.findAllByManager(ProductReport.class, manager.getId());
		productReport=productReports.get(productReports.size()-1);
		String stime=(productReport.getStarttime().getYear()+1900)+"-"+(productReport.getStarttime().getMonth()+1)+"-"+productReport.getStarttime().getDate();
		String etime=(productReport.getEndtime().getYear()+1900)+"-"+(productReport.getEndtime().getMonth()+1)+"-"+productReport.getEndtime().getDate();
		orderss=orderService.findOrdersByDate(stime, etime,manager.getId());
		products=productService.findAllByManager(Product.class, manager.getId());
		for (int i = 0; i < products.size(); i++) {
			for (int j = 0; j < orderss.size(); j++) {
				if(products.get(i).getId()==orderss.get(j).getProduct().getId()){
					reportlogs=reportlogService.findIfHavaReportlog(productReport.getId(), products.get(i).getId());
					if(reportlogs.size()==0){
						Reportlog reportlog1=new Reportlog();
						reportlog1.setProductReport(productReport);
						reportlog1.setProduct(products.get(i));
						reportlog1.setTotal(orderss.get(j).getAmount());
						reportlog1.setMoney(orderss.get(j).getDealpriceT());
						reportlog1.setMoneyed(orderss.get(j).getPaymoney());
						reportlog1.setMoneying(orderss.get(j).getRemainingPay());
						reportlogService.save(reportlog1);
					}else{
						reportlogs.get(0).setTotal(reportlogs.get(0).getTotal()+orderss.get(j).getAmount());
						reportlogs.get(0).setMoney(reportlogs.get(0).getMoney()+orderss.get(j).getDealpriceT());
						reportlogs.get(0).setMoneyed(reportlogs.get(0).getMoneyed()+orderss.get(j).getPaymoney());
						reportlogs.get(0).setMoneying(reportlogs.get(0).getMoneying()+orderss.get(j).getRemainingPay());
						reportlogService.update(reportlogs.get(0));
					}
				}
			}
		}
	}
	
	@SuppressWarnings("deprecation")
	public String CreateProductReport() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		int totalnum=0;
		double totalmoney=0,totalmoneyed=0,totalmoneying=0;
		String stime=(productReport.getStarttime().getYear()+1900)+"-"+(productReport.getStarttime().getMonth()+1)+"-"+productReport.getStarttime().getDate();
		String etime=(productReport.getEndtime().getYear()+1900)+"-"+(productReport.getEndtime().getMonth()+1)+"-"+productReport.getEndtime().getDate();
		orderss=orderService.findOrdersByDate(stime, etime, manager.getId());
		if(orderss.size()>0){
			for (int i = 0; i < orderss.size(); i++) {
				totalnum=totalnum+orderss.get(i).getAmount();
				totalmoney=totalmoney+orderss.get(i).getDealpriceT();
				totalmoneyed=totalmoneyed+orderss.get(i).getPaymoney();
				totalmoneying=totalmoneying+orderss.get(i).getRemainingPay();
			}
		}else{
			System.out.println("没有相关记录");
		}
		productReport.setTotal(totalnum);
		productReport.setMoney(totalmoney);
		productReport.setMoneyed(totalmoneyed);
		productReport.setMoneying(totalmoneying);
		productReport.setManager(manager);
		productReportService.save(productReport);
		autoCreateProductReportlog();
		return "CreateProductReport_s";
	}
	
	public String deleteSomeReport(){
		if(prid==null||prid==""){
			System.out.println("没有数据");
			return "deleteSomeReport_f";
		}
		else{
			String prid1[]=prid.split(", ");
			int [] prid2 = new int[prid1.length];
			for(int i=0;i<prid1.length;i++){
				prid2[i]=Integer.parseInt(prid1[i]);
			}
			for(int i=0;i<prid2.length;i++){
				System.out.println(prid2[i]);
			}
			return "deleteSomeReport_s";
		}
	}
	
	public String findTheReportlog() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				return "error";
			}else {
				productReport=productReportService.findById(ProductReport.class, productReport.getId());
				reportlogs=reportlogService.findReportlogByPrid(productReport.getId());
				return "findTheReportlog_s";
			}
		}else {
			return "error";
		}
	}
	
	public String deleteTheProductReport(){
		System.out.println(productReport.getId());
		return "deleteTheProductReport_s";
	}
	
	@SuppressWarnings("deprecation")
	public String findReportlogByPid() throws Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		productReport=productReportService.findById(ProductReport.class, productReport.getId());
		String stime=(productReport.getStarttime().getYear()+1900)+"-"+(productReport.getStarttime().getMonth()+1)+"-"+productReport.getStarttime().getDate();
		String etime=(productReport.getEndtime().getYear()+1900)+"-"+(productReport.getEndtime().getMonth()+1)+"-"+productReport.getEndtime().getDate();
		orderss=orderService.findOrdersByDate(stime, etime,manager.getId());
		List<Orders> orderss2=new ArrayList<Orders>();
		for (int i = 0; i < orderss.size(); i++) {
			if(orderss.get(i).getProduct().getId()==product.getId()){
				Orders orders2=new Orders();
				orders2.setId(orderss.get(i).getId());
				orders2.setDealdate(orderss.get(i).getDealdate());
				orders2.setSalesman(orderss.get(i).getSalesman());
				orders2.setDealpriceT(orderss.get(i).getDealpriceT());
				orders2.setCustomerP(orderss.get(i).getCustomerP());
				orderss2.add(orders2);
			}
		}
		JsonConfig jsonConfig = new JsonConfig();  
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor()); 
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		JSONArray jsonArray = JSONArray.fromObject(orderss2,jsonConfig);
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
	
	public void exportTableMessage() throws NumberFormatException, Exception{
		Manager manager=(Manager)ActionContext.getContext().getApplication().get("manager");
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		if(ActionContext.getContext().getApplication().get("level")!=null){
			int level=(Integer)ActionContext.getContext().getApplication().get("level");
			if(manager==null||level<2){
				response.getWriter().println("<script> alert('当前权限等级暂时无法执行此操作');</script>");
			}else{
				productReport=productReportService.findById(ProductReport.class, Integer.valueOf(prid));
				reportlogs=reportlogService.findReportlogByPrid(productReport.getId());
				ExcelUtils.addValue("productReport", productReport);
				ExcelUtils.addValue("reportlogs", reportlogs);
		    	String tplpath = "/report/excel/exportProductReport.xls";
		    	response.reset();
		    	response.addHeader("Content-Type", "application/vnd.ms-excel");
		    	String filename = productReport.getStarttime()+"至"+productReport.getEndtime()+"产品销量统计表";
		    	ExcelUtils.addValue("title", filename);
		    	response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filename,"UTF-8") + ".xls");
		    	ExcelUtils.export(request.getSession().getServletContext(),tplpath,response.getOutputStream());
			}
		}else{
			response.getWriter().println("<script> alert('当前权限等级暂时无法执行此操作');</script>");
		}
	}
	
	
	
}
