package com.fpoly.coffeeshop.controller.admin;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fpoly.coffeeshop.model.Staff;
import com.fpoly.coffeeshop.model.User;
import com.fpoly.coffeeshop.util.DomainUtil;

@Controller
@RequestMapping(value = "/admin/staff")
public class AdminStaffController {

	private String getDomain() {
		return DomainUtil.getDoamin();
	}
	
	// edit
	private void getUser(Model model) {
		String url = getDomain() + "/user/list/flag_delete/false";
		
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<String> result = restTemplate.getForEntity(url, String.class);
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			List<User> users = mapper.readValue(result.getBody(), new TypeReference<List<User>>(){});
			
			model.addAttribute("users", users);
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

		String usersURL = getDomain() + "/staff/flag_delete/list?flag_delete=" + flagDelete + "&page=" + page + "&limit=" + limit;
		String totalPagesURL = getDomain() + "/staff/flag_delete/total_pages?flag_delete=" + flagDelete + "&page=" + page + "&limit=" + limit;
		
		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
		
		HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);
		ResponseEntity<String> result = restTemplate.exchange(usersURL, HttpMethod.GET, entity, String.class);
		
		request.setAttribute("page", page);
		request.setAttribute("limit", limit);
		request.setAttribute("totalPages", restTemplate.getForObject(totalPagesURL, String.class));
		
		try {
			ObjectMapper mapper = new ObjectMapper();
			List<Staff> staffs = mapper.readValue(result.getBody(), new TypeReference<List<Staff>>(){});
			request.setAttribute("staffs", staffs);
		} catch (Exception e) {
		}
		
		return "admin/staff/list";
	}
	
	@RequestMapping(value = "/add")
	public String showAddPage(Model model) {
		getUser(model);
		
		model.addAttribute("check", false);
		model.addAttribute("staff", new Staff());
		
		return "admin/staff/edit";
	}
	
	@RequestMapping(value = "/edit")
	public String showUpdatePage(Model model, @RequestParam("id") Long id) {
		getUser(model);
		
		String url =  getDomain() + "/staff/id/" + id;
		
		RestTemplate restTemplate = new RestTemplate();
		
		ResponseEntity<Staff> staff = restTemplate.getForEntity(url, Staff.class);
		
		model.addAttribute("check", true);
		model.addAttribute("staff", staff.getBody());
		
		return "admin/staff/edit";
	}
	
	@RequestMapping(value = "/save")
	public String save(Model model, @ModelAttribute Staff staff) {
		String url = getDomain() + "/staff";
		String message = "";
		String alert = "danger";
		
		RestTemplate restTemplate = new RestTemplate();
		
		staff.setFlagDelete(false);
		
		if (staff.getId() == null) {
			url += "/insert";
			
			Boolean result = restTemplate.postForObject(url, staff, Boolean.class);
			
			if (result) {
				message = "insert success";
				alert = "success";
			} else {
				message = "insert fail";
			}
		} else {
			url += "/update?id=" + staff.getId();
			
			try {
				restTemplate.put(url, staff);
				
				message = "update success";
				alert = "success";
			} catch (Exception e) {
				message = "update fail";
			}
		}
		
		model.addAttribute("message", message);
		model.addAttribute("alert", alert);
		
		return "redirect:/admin/staff/list?page=1";
	}
	
	@RequestMapping(value = "/delete")
	public String delete(Model model, @RequestParam("id") Long id) {
		String url = getDomain() + "/staff/id/" + id;
		String message = "";
		String alert = "danger";
		
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<Staff> reusult = restTemplate.getForEntity(url, Staff.class);
		Staff staff = reusult.getBody();
		
		String deleteURL = getDomain() + "/staff/update?id=" + staff.getId();
		
		try {
			staff.setFlagDelete(true);
			restTemplate.put(deleteURL, staff);
			
			message = "delete success";
			alert = "success";
		} catch (Exception e) {
			message = "delete fail";
		}
		
		model.addAttribute("message", message);
		model.addAttribute("alert", alert);
		
		return "redirect:/admin/staff/list?page=1";
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public String search(Model model, HttpServletRequest request) {
		String key = request.getParameter("key");
		String page = "1";
		
		model.addAttribute("key", key);
		model.addAttribute("page", page);
		
		return "redirect:/admin/staff/search";
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String showSearchPage(HttpServletRequest request) {
		String key = request.getParameter("key");
		String page = request.getParameter("page");
		String flagDelete = "false";
		String limit = "10";
		
		String usersURL = getDomain() + "/staff/flag_delete/search/list?key=" + key + "&flag_delete=" + flagDelete + "&page=" + page + "&limit=" + limit;
		String totalPagesURL = getDomain() + "/staff/flag_delete/search/total_pages?key=" + key + "&flag_delete=" + flagDelete + "&page=" + page + "&limit=" + limit;

		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
		
		HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);
		ResponseEntity<String> result = restTemplate.exchange(usersURL, HttpMethod.GET, entity, String.class);
		
		request.setAttribute("key", key);
		request.setAttribute("page", page);
		request.setAttribute("limit", limit);
		request.setAttribute("totalPages", restTemplate.getForObject(totalPagesURL, String.class));
		
		try {
			ObjectMapper mapper = new ObjectMapper();
			List<Staff> staffs = mapper.readValue(result.getBody(), new TypeReference<List<Staff>>(){});
			request.setAttribute("staffs", staffs);
		} catch (Exception e) {
		}
		
		return "admin/staff/search";
	}
	
}