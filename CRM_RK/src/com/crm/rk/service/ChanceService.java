package com.crm.rk.service;

import java.util.List;

import com.crm.rk.model.Chance;

public interface ChanceService extends BaseService<Chance> {
	public List<Chance> findChanceByName(String name);
	public List<Chance> findChanceByNameAndManager(String name,int id);
	public List<Chance> findChanceByChannel(int id);
	public List<Chance> findChanceBySalesman(int id);
}
