package com.fpoly.coffeeshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminDashBoardController {

	@RequestMapping(value = "/admin/dashboard")
	public String showPage() {
		return "admin/dashboard";
	}

}
