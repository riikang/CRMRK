package com.crm.rk.service;

import java.util.List;

import com.crm.rk.model.Reportlog;

public interface ReportlogService extends BaseService<Reportlog> {
	public List<Reportlog> findIfHavaReportlog(int id1,int id2);
	public List<Reportlog> findReportlogByPrid(int id);
	public List<Reportlog> findReportlogByProduct(int id);
	public void deleteByProductReportId(Class<Reportlog> entityClass,List<Reportlog> reportlogs);
}
