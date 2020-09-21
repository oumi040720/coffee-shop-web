package com.fpoly.coffeeshop.controller.admin;


import java.io.IOException;

import java.util.Arrays;
import java.util.List;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fpoly.coffeeshop.model.Menu;
import com.fpoly.coffeeshop.model.Order;
import com.fpoly.coffeeshop.model.OrderDetail;
import com.fpoly.coffeeshop.util.DomainUtil;

@Controller
@RequestMapping(value = "/admin/orderdetail")
public class AdminOrderDetailController {

	private String getDomain() {
		return DomainUtil.getDoamin();
	}
	
	public void getMenu(Model model) {
		String flagDelete = "false";
		String url = getDomain()+"/menu/list/flag_delete/"+flagDelete;

		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<String> result = restTemplate.getForEntity(url, String.class);

		ObjectMapper mapper = new ObjectMapper();
		try {
			List<Menu> menus = mapper.readValue(result.getBody(), new TypeReference<List<Menu>>() {
			});

			model.addAttribute("menus", menus);
		} catch (Exception e) {
		}
	}
	

	@RequestMapping(value = "/add")
	public String showAddPage(Model model) {
		getMenu(model);

		model.addAttribute("check", false);
		model.addAttribute("orderDetails", new OrderDetail());

		return "admin/orderdeatil/edit";
	}

	
	@RequestMapping(value = "/edit")
	public String showUpdatePage(Model model, @RequestParam("orderCode") String orderCode) throws JsonParseException, JsonMappingException, IOException {
		getMenu(model);
		String url =  getDomain()+"/orderdetail/list/search_or/" + orderCode; 

		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
		
		HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);
		ResponseEntity<String> result = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
		
		ObjectMapper mapper = new ObjectMapper();
		List<OrderDetail> orderDetails = mapper.readValue(result.getBody(), new TypeReference<List<OrderDetail>>(){}) ;
		model.addAttribute("orderDetails", orderDetails);
		
		return "admin/orderdetail/list";
	}
	
	
	@RequestMapping(value = "/save")
	@ResponseBody
	public List<OrderDetail> save(Model model, @RequestBody List<OrderDetail> list) {
		
//		for(OrderDetail od : list) {
//			orderserivce.save(od);
//		}
//		list.forEach(e -> {
//			orderserivce.save(e);
//		});
		String url =  getDomain()+"/orderdetail/insert";
		String message = "";
		String alert = "danger";

		
		  RestTemplate restTemplate = new RestTemplate();
		  
		  HttpHeaders headers = new HttpHeaders();
		  headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
		  
		  Boolean result = restTemplate.postForObject(url, list, Boolean.class);
		  System.out.println(result);
		  
		  if (result) { message = "insert success"; alert = "success"; } else { message
		  = "insert fail"; }
		  
		  model.addAttribute("message", message); model.addAttribute("alert", alert);
		

		return list;
	}
}

