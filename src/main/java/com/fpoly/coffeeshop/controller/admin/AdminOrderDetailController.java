package com.fpoly.coffeeshop.controller.admin;

<<<<<<< HEAD
import java.io.IOException;
=======
>>>>>>> 4500a0465a40be7a5a10a1981371467e6afcd5f0
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
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
	
<<<<<<< HEAD
	@RequestMapping(value = "/add")
	public String showAddPage(Model model) {
		getMenu(model);

		model.addAttribute("check", false);
		model.addAttribute("orderDetails", new OrderDetail());

		return "admin/orderdeatil/edit";
	}
=======
	// THIÊU QUY TRÌNH
	// CLICK CHI TIẾT HÓA ĐƠN >> DANH SÁCH CHI TIẾT HÓA ĐƠN(THIẾU) >> CHỈNH SỬA CHI TIẾT HÓA ĐƠN
>>>>>>> 4500a0465a40be7a5a10a1981371467e6afcd5f0
	
	@RequestMapping(value = "/edit")
	public String showUpdatePage(Model model, @RequestParam("orderCode") String orderCode) throws JsonParseException, JsonMappingException, IOException {
		getMenu(model);

<<<<<<< HEAD
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
	public String save(Model model, @ModelAttribute OrderDetail orderDetails) {
		String url =  getDomain()+"/orderdetail";
		String message = "";
		String alert = "danger";

		RestTemplate restTemplate = new RestTemplate();

		orderDetails.setFlagDelete(false);

		if (orderDetails.getId() == null) {
			url += "/insert";

			Boolean result = restTemplate.postForObject(url, orderDetails, Boolean.class);

			if (result) {
				message = "insert success";
				alert = "success";
			} else {
				message = "insert fail";
			}
		} else {
			url += "/update?id=" + orderDetails.getId();

			try {
				restTemplate.put(url, orderDetails);

				message = "update success";
				alert = "success";
			} catch (Exception e) {
				message = "update fail";
			}
		}

		model.addAttribute("message", message);
		model.addAttribute("alert", alert);

		return "redirect:/admin/orderdeatil/list?page=1";
	}
	
	@RequestMapping(value = "/delete")
	public String delete(Model model, @RequestParam("id") Long id) {
		String url =  getDomain()+"/orderdetail/id/" + id;
		String message = "";
		String alert = "danger";
=======
		// cái này trả về list orderDetails, trong khi edit thì chỉ được 1 đối tượng chứ không phải là 1 list
		String url =  getDomain()+"/orderdetail/list/search_or/" + orderCode; 
>>>>>>> 4500a0465a40be7a5a10a1981371467e6afcd5f0

		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<OrderDetail> reusult = restTemplate.getForEntity(url, OrderDetail.class);
		OrderDetail orderDetails = reusult.getBody();

<<<<<<< HEAD
		String deleteURL =  getDomain()+"/orderdetail/update?id=" + orderDetails.getId();

		try {
			orderDetails.setFlagDelete(true);
			restTemplate.put(deleteURL, orderDetails);

			message = "delete success";
			alert = "success";
		} catch (Exception e) {
			message = "delete fail";
		}

		model.addAttribute("message", message);
		model.addAttribute("alert", alert);

		return "redirect:/admin/orderdetail/list?page=1";
=======
		HttpHeaders headers = new HttpHeaders();
		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
		
		HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);
		ResponseEntity<String> result = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
		
		model.addAttribute("check", true);
//		model.addAttribute("orderdetails", null);
		
		return "admin/orderdetail/edit";
>>>>>>> 4500a0465a40be7a5a10a1981371467e6afcd5f0
	}

	
}

