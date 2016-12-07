package com.crm.rk.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.transaction.annotation.Transactional;

import com.crm.rk.dao.ReportlogDao;
import com.crm.rk.model.Reportlog;
import com.crm.rk.service.ReportlogService;
@Transactional(readOnly = false)

public class ReportlogServiceImpl extends BaseServiceImpl<Reportlog> implements ReportlogService {
	@Resource private ReportlogDao reportlogDao;
	public List<Reportlog> findIfHavaReportlog(int id1,int id2){
		return reportlogDao.findIfHavaReportlog(id1, id2);
	}
	public List<Reportlog> findReportlogByPrid(int id){
		return reportlogDao.findReportlogByPrid(id);
	}
	public List<Reportlog> findReportlogByProduct(int id){
		return reportlogDao.findReportlogByProduct(id);
	}
	public void deleteByProductReportId(Class<Reportlog> entityClass,List<Reportlog> reportlogs){
		reportlogDao.deleteByProductReportId(entityClass,reportlogs);
	}
}
