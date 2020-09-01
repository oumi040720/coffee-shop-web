package com.fpoly.coffeeshop.controller.admin;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fpoly.coffeeshop.model.Menu;
import com.fpoly.coffeeshop.model.OrderDetail;
import com.fpoly.coffeeshop.util.DomainUtil;

@Controller
@RequestMapping(value = "/admin/orderdetail")
public class AdminOrderDetailController {

	private String getDomain() {
		return DomainUtil.getDoamin();
	}
	
	public void getMenu(Model model) {
		String url = getDomain()+"/menu/list";

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
	
	@RequestMapping(value = "/edit")
	public String showUpdatePage(Model model, @RequestParam("orderCode") String orderCode) {
		getMenu(model);

		String url =  getDomain()+"/orderdetail/list/search_or/" + orderCode;

		RestTemplate restTemplate = new RestTemplate();

		ResponseEntity<OrderDetail> orderdetails = restTemplate.getForEntity(url, OrderDetail.class);

		model.addAttribute("check", true);
		model.addAttribute("orderdetails", orderdetails.getBody());

		return "admin/orderdetail/edit";
	}
}
