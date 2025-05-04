package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.lang.management.ManagementFactory;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

@Controller
public class AboutController {

    private final Environment env;

    public AboutController(Environment env) {
        this.env = env;
    }

    @Value("${spring.application.name:Enterprise Java CI/CD App}")
    private String appName;

    @GetMapping("/about")
    public String about(Model model) {
        String version = "1.0.0";
        String port = env.getProperty("server.port", "8080");

        long jvmStartTime = ManagementFactory.getRuntimeMXBean().getStartTime();
        String startupTime = LocalDateTime.ofInstant(
                Instant.ofEpochMilli(jvmStartTime), ZoneId.systemDefault())
                .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        model.addAttribute("appName", appName);
        model.addAttribute("version", version);
        model.addAttribute("port", port);
        model.addAttribute("startupTime", startupTime);
        model.addAttribute("javaVersion", System.getProperty("java.version"));

        return "about";
    }
}
