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
import com.fpoly.coffeeshop.model.Role;
import com.fpoly.coffeeshop.model.User;
import com.fpoly.coffeeshop.util.DomainUtil;

@Controller
@RequestMapping(value = "/admin/user")
public class AdminUserController {

	private String getDomain() {
		return DomainUtil.getDoamin();
	}
	
	private void getRole(Model model) {
		String url = getDomain() + "/role/list";
		
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<String> result = restTemplate.getForEntity(url, String.class);
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			List<Role> roles = mapper.readValue(result.getBody(), new TypeReference<List<Role>>(){});
			
			model.addAttribute("roles", roles);
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

		String usersURL = getDomain() + "/user/flag_delete/list?flag_delete=" + flagDelete + "&page=" + page + "&limit=" + limit;
		String totalPagesURL = getDomain() + "/user/flag_delete/total_pages?flag_delete=" + flagDelete + "&page=" + page + "&limit=" + limit;
		
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
			List<User> users = mapper.readValue(result.getBody(), new TypeReference<List<User>>(){});
			request.setAttribute("users", users);
		} catch (Exception e) {
		}
		
		return "admin/user/list";
	}
	
	@RequestMapping(value = "/add")
	public String showAddPage(Model model) {
		getRole(model);
		
		model.addAttribute("check", false);
		model.addAttribute("domain", getDomain());
		model.addAttribute("user", new User());
		
		return "admin/user/edit";
	}
	
	@RequestMapping(value = "/edit")
	public String showUpdatePage(Model model, @RequestParam("username") String username) {
		getRole(model);
		
		String url =  getDomain() + "/user/username/" + username;
		
		RestTemplate restTemplate = new RestTemplate();
		
		ResponseEntity<User> user = restTemplate.getForEntity(url, User.class);
		
		model.addAttribute("check", true);
		model.addAttribute("domain", getDomain());
		model.addAttribute("user", user.getBody());
		
		return "admin/user/edit";
	}
	
	@RequestMapping(value = "/save")
	public String save(Model model, @ModelAttribute User user) {
		String url = getDomain() + "/user";
		String message = "";
		String alert = "danger";
		
		RestTemplate restTemplate = new RestTemplate();
		
		user.setFlagDelete(false);
		
		if (user.getId() == null) {
			url += "/insert";
			
			Boolean result = restTemplate.postForObject(url, user, Boolean.class);
			
			if (result) {
				message = "message_user_insert_success";
				alert = "success";
			} else {
				message = "message_user_insert_fail";
			}
		} else {
			url += "/update?id=" + user.getId();
			
			try {
				restTemplate.put(url, user);
				
				message = "message_user_update_success";
				alert = "success";
			} catch (Exception e) {
				message = "message_user_update_fail";
			}
		}
		
		model.addAttribute("message", message);
		model.addAttribute("alert", alert);
		
		return "redirect:/admin/user/list?page=1";
	}

	@RequestMapping(value = "/delete")
	public String delete(Model model, @RequestParam("username") String username) {
		String url = getDomain() + "/user/username/" + username;
		String message = "";
		String alert = "danger";
		
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<User> reusult = restTemplate.getForEntity(url, User.class);
		User user = reusult.getBody();
		
		String deleteURL = getDomain() + "/user/update?id=" + user.getId();
		
		try {
			user.setFlagDelete(true);
			user.setPassword("123@123zxCV@");
			restTemplate.put(deleteURL, user);
			
			message = "message_user_delete_success";
			alert = "success";
		} catch (Exception e) {
			message = "message_user_delete_fail";
		}
		
		model.addAttribute("message", message);
		model.addAttribute("alert", alert);
		
		return "redirect:/admin/user/list?page=1";
	}
	
	
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public String search(Model model, HttpServletRequest request) {
		String key = request.getParameter("key");
		String page = "1";
		
		model.addAttribute("key", key);
		model.addAttribute("page", page);
		
		return "redirect:/admin/user/search";
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String showSearchPage(HttpServletRequest request) {
		String key = request.getParameter("key");
		String page = request.getParameter("page");
		String flagDelete = "false";
		String limit = "10";
		
		String usersURL = getDomain() + "/user/flag_delete/search/list?key=" + key + "&flag_delete=" + flagDelete + "&page=" + page + "&limit=" + limit;
		String totalPagesURL = getDomain() + "/user/flag_delete/search/total_pages?key=" + key + "&flag_delete=" + flagDelete + "&page=" + page + "&limit=" + limit;

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
			List<User> users = mapper.readValue(result.getBody(), new TypeReference<List<User>>(){});
			request.setAttribute("users", users);
		} catch (Exception e) {
		}
		
		return "admin/user/search";
	}
	
}
