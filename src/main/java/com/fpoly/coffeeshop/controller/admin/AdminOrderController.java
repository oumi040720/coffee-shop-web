package com.fpoly.coffeeshop.controller.admin;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fpoly.coffeeshop.model.Customers;
import com.fpoly.coffeeshop.model.Order;
import com.fpoly.coffeeshop.model.OrderDetail;

@Controller
@RequestMapping(value = "/admin/order")
public class AdminOrderController {

	public void getCustomers(Model model) {
		String url = "http://localhost:8080/api/customers/list";

		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<String> result = restTemplate.getForEntity(url, String.class);

		ObjectMapper mapper = new ObjectMapper();
		try {
			List<Customers> customers = mapper.readValue(result.getBody(), new TypeReference<List<Customers>>() {
			});

			model.addAttribute("customers", customers);
		} catch (Exception e) {
		}
	}

	@RequestMapping(value = "/list")
	public String showListPage(HttpServletRequest request) {
		String message = request.getParameter("message");
		String alert = request.getParameter("alert");

		String page = request.getParameter("page");
		String limit = "10";
		String flagDelete = "false";

		if (message != null && alert != null) {
			request.setAttribute("message", message.replaceAll("_", "."));
			request.setAttribute("alert", alert);
		}

		String orderURL = "http://localhost:8080/api/order/flag_delete/list?flag_delete=" + flagDelete + "&page=" + page
				+ "&limit=" + limit;
		String totalPagesURL = "http://localhost:8080/api/order/flag_delete/total_pages?flag_delete=" + flagDelete
				+ "&page=" + page + "&limit=" + limit;
		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));

		HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);
		ResponseEntity<String> result = restTemplate.exchange(orderURL, HttpMethod.GET, entity, String.class);
		request.setAttribute("page", page);
		request.setAttribute("limit", limit);
		request.setAttribute("totalPages", restTemplate.getForObject(totalPagesURL, String.class));

		try {
			ObjectMapper mapper = new ObjectMapper();
			List<Order> orders = mapper.readValue(result.getBody(), new TypeReference<List<Order>>() {
			});
			int a = orders.size();
			request.setAttribute("orders", orders);
			request.setAttribute("length", a);
		} catch (Exception e) {
		}

		return "admin/order/list";
	}

	@RequestMapping(value = "/add")
	public String showAddPage(Model model) {
		getCustomers(model);

		model.addAttribute("check", false);
		model.addAttribute("orders", new Order());

		return "admin/order/edit";
	}

	@RequestMapping(value = "/edit")
	public String showUpdatePage(Model model, @RequestParam("id") Long id) {
		getCustomers(model);

		String url = "http://localhost:8080/api/order/id/" + id;

		RestTemplate restTemplate = new RestTemplate();

		ResponseEntity<Order> orders = restTemplate.getForEntity(url, Order.class);

		model.addAttribute("check", true);
		model.addAttribute("orders", orders.getBody());

		return "admin/order/edit";
	}

	@GetMapping(value = "/orderDetail")
	@ResponseBody
	public List<OrderDetail> fetcOrderDetail(@RequestParam("orderCode") String orderCode) throws URISyntaxException, JsonParseException, JsonMappingException, IOException {
		String url = "http://localhost:8080/api/orderdetail/list/search_or/" + orderCode;
		RestTemplate restTemplate = new RestTemplate();
		RequestEntity<String> req = new RequestEntity(HttpMethod.GET, new URI(url));
		ResponseEntity<String> res = restTemplate.exchange(req, String.class);		
		ObjectMapper obj = new ObjectMapper();		
		return obj.readValue(res.getBody(), new TypeReference<List<OrderDetail>>() {
		});
	}

	@RequestMapping(value = "/save")
	public String save(Model model, @ModelAttribute Order orders) {
		String url = "http://localhost:8080/api/order";
		String message = "";
		String alert = "danger";

		RestTemplate restTemplate = new RestTemplate();

		orders.setFlagDelete(false);

		if (orders.getId() == null) {
			url += "/insert";

			Boolean result = restTemplate.postForObject(url, orders, Boolean.class);

			if (result) {
				message = "insert success";
				alert = "success";
			} else {
				message = "insert fail";
			}
		} else {
			url += "/update?id=" + orders.getId();

			try {
				restTemplate.put(url, orders);

				message = "update success";
				alert = "success";
			} catch (Exception e) {
				message = "update fail";
			}
		}

		model.addAttribute("message", message);
		model.addAttribute("alert", alert);

		return "redirect:/admin/order/list?page=1";
	}

	@RequestMapping(value = "/delete")
	public String delete(Model model, @RequestParam("id") Long id) {
		String url = "http://localhost:8080/api/order/id/" + id;
		String message = "";
		String alert = "danger";

		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<Order> reusult = restTemplate.getForEntity(url, Order.class);
		Order orders = reusult.getBody();

		String deleteURL = "http://localhost:8080/api/order/update?id=" + orders.getId();

		try {
			orders.setFlagDelete(true);
			restTemplate.put(deleteURL, orders);

			message = "delete success";
			alert = "success";
		} catch (Exception e) {
			message = "delete fail";
		}

		model.addAttribute("message", message);
		model.addAttribute("alert", alert);

		return "redirect:/admin/order/list?page=1";
	}

	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public String search(Model model, HttpServletRequest request) {
		String key = request.getParameter("key");
		String page = "1";

		model.addAttribute("key", key);
		model.addAttribute("page", page);

		return "redirect:/admin/order/search";
	}

	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String showSearchPage(HttpServletRequest request) {
		String key = request.getParameter("key");
		String page = request.getParameter("page");
		String flagDelete = "false";
		String limit = "10";

		String orderURL = "http://localhost:8080/api/order/flag_delete/search_o/list?key=" + key + "&flag_delete="
				+ flagDelete + "&page=" + page + "&limit=" + limit;
		String totalPagesURL = "http://localhost:8080/api/order/flag_delete/search_o/total_pages?key=" + key
				+ "&flag_delete=" + flagDelete + "&page=" + page + "&limit=" + limit;

		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));

		HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);
		ResponseEntity<String> result = restTemplate.exchange(orderURL, HttpMethod.GET, entity, String.class);
		System.out.println(result);
		request.setAttribute("key", key);
		request.setAttribute("page", page);
		request.setAttribute("limit", limit);
		request.setAttribute("totalPages", restTemplate.getForObject(totalPagesURL, String.class));

		try {
			ObjectMapper mapper = new ObjectMapper();
			List<Order> orders = mapper.readValue(result.getBody(), new TypeReference<List<Order>>() {
			});
			request.setAttribute("orders", orders);
		} catch (Exception e) {
		}

		return "admin/order/search";
	}
}
