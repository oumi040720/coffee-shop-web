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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fpoly.coffeeshop.model.Role;
import com.fpoly.coffeeshop.util.DomainUtil;

@Controller
@RequestMapping(value = "/admin/role")
public class AdminRoleController {

	private String getDomain() {
		return DomainUtil.getDoamin();
	}
	
	@RequestMapping(value = "/list")
	public String showListPage(HttpServletRequest request) {
		String message = request.getParameter("message");
		String alert = request.getParameter("alert");
		
		if (message != null && alert != null) {
			request.setAttribute("message", message.replaceAll("_", "."));
			request.setAttribute("alert", alert);
		}
		
		String rolesURL = getDomain() + "/role/list/flag_delete/false";
		
		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
		
		HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);
		ResponseEntity<String> result = restTemplate.exchange(rolesURL, HttpMethod.GET, entity, String.class);
		
		try {
			ObjectMapper mapper = new ObjectMapper();
			List<Role> roles = mapper.readValue(result.getBody(), new TypeReference<List<Role>>(){});
			request.setAttribute("roles", roles);
		} catch (Exception e) {
		}
		
		return "admin/role/list";
	}
	
	@RequestMapping(value = "/add")
	public String showAddPage(Model model) {
		model.addAttribute("check", false);
		model.addAttribute("role", new Role());
		model.addAttribute("domain", getDomain());
		
		return "admin/role/edit";
	}
	
	@RequestMapping(value = "/edit")
	public String showUpdatePage(Model model, @RequestParam("role_code") String roleCode) {
		String url =  getDomain() + "/role/role_code/" + roleCode;
		
		RestTemplate restTemplate = new RestTemplate();
		
		ResponseEntity<Role> user = restTemplate.getForEntity(url, Role.class);
		
		model.addAttribute("check", true);
		model.addAttribute("role", user.getBody());
		model.addAttribute("domain", getDomain());
		
		return "admin/role/edit";
	}
	
	@RequestMapping(value = "/save")
	public String save(Model model, @ModelAttribute Role role) {
		String url = getDomain() + "/role";
		String message = "";
		String alert = "danger";
		
		RestTemplate restTemplate = new RestTemplate();
		
		role.setFlagDelete(false);
		
		if (role.getId() == null) {
			url += "/insert";
			
			Boolean result = restTemplate.postForObject(url, role, Boolean.class);
			
			if (result) {
				message = "message_role_insert_success";
				alert = "success";
			} else {
				message = "message_role_insert_fail";
			}
		} else {
			url += "/update?id=" + role.getId();
			
			try {
				restTemplate.put(url, role);
				
				message = "message_role_update_success";
				alert = "success";
			} catch (Exception e) {
				message = "message_role_update_fail";
			}
		}
		
		model.addAttribute("message", message);
		model.addAttribute("alert", alert);
		
		return "redirect:/admin/role/list?page=1";
	}
	
	@RequestMapping(value = "/delete")
	public String delete(Model model, @RequestParam("role_code") String roleCode) {
		String url = getDomain() + "/role/role_code/" + roleCode;
		String message = "";
		String alert = "danger";
		
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<Role> reusult = restTemplate.getForEntity(url, Role.class);
		Role role = reusult.getBody();
		
		String deleteURL = getDomain() + "/role/update?id=" + role.getId();
		
		try {
			role.setFlagDelete(true);
			restTemplate.put(deleteURL, role);
			
			message = "message_role_delete_success";
			alert = "success";
		} catch (Exception e) {
			message = "message_role_update_fail";
		}
		
		model.addAttribute("message", message);
		model.addAttribute("alert", alert);
		
		return "redirect:/admin/role/list?page=1";
	}
	
}
