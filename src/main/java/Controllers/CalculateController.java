package Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CalculateController {
    @RequestMapping("/")
    public String Calculate(Model model) {
        model.addAttribute("expressionResult","555");
        return "/index.jsp";
    }
}
