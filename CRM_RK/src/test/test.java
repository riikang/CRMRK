package test;

import java.util.Date;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.crm.rk.model.CCustomer;
import com.crm.rk.model.Product;
import com.crm.rk.service.CCustomerService;
import com.crm.rk.service.ProductService;

public class test {
	public static void main(String[] args) throws Exception {
		ApplicationContext ctx=new ClassPathXmlApplicationContext("applicationContext.xml");
		//ComboPooledDataSource cpds = (ComboPooledDataSource) ctx.getBean("dataSource"); 
		//cpds.setJdbcUrl("jdbc:mysql://localhost:3306/crm_rk?useUnicode=true&amp;characterEncoding=UTF-8");
		
		ApplicationContext ctx2=new ClassPathXmlApplicationContext("applicationContext.xml");
		ProductService productService = (ProductService) ctx2.getBean("productService");
		List<Product> products;
		products=productService.findAll(Product.class);
		System.out.println(products.size());
            
	}
	
	/*public static void add() throws Exception{
		
//		Product product=new Product();
//		product.setPname("娃a娃");
//		product.setPrice(20);
//		product.setType("玩具");
//		product.setUnit("个");
//		product.setMarket_time(new Date());
//		product.setDescription("!!!!!!!!!!");
//		productService.save(product);
		
		CCustomer cc1=new CCustomer();
		
		cc1.setCompany_name("哈哈哈");
		cc1.setGettime(new Date());
		cc1.setPhonenum("12313213");
		cc1.setName("刚好哈哈");
		//cc.save(cc1);
		
//		pc1.setCname("妈妈");
//		pc1.setGettime(new Date());
//		pc1.setPhonenum("13132132");
//		pc.save(pc1);
		
		System.out.println("保存成功");
	}
	
	public static void delete() throws Exception{
		Product product=new Product();
		product=productService.findById(Product.class,2);
		productService.delete(product);
		System.out.println("删除成功");
	}
	
	public static void update() throws Exception{
		Product product=new Product();
		product=productService.findById(Product.class,3);
		product.setDescription("?????");
		productService.update(product);
		System.out.println("更新成功");
	}
	
	public static void find() throws Exception{
		Product product=new Product();
		product=productService.findById(Product.class,3);
		System.out.println(product.getDescription());
	}*/

}
