package Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CalculateController {
    @RequestMapping("/calculate")
    public String calculate(@RequestParam(name = "expression", required = false, defaultValue = "0+0") String expression, Model model) {
        expression = expression.replace("+", " + ");
        expression = expression.replace("-", " - ");
        expression = expression.replace("*", " * ");
        expression = expression.replace("/", " / ");
        String[] expressionValues = expression.split(" ");
        model.addAttribute("expressionResult", calculateExpression(Double.valueOf(expressionValues[0]), Double.valueOf(expressionValues[2]), expressionValues[1]));
        return "/index.jsp";
    }

    private double calculateExpression(double firstNumber, double secondNumber, String operator) {
        if ("+".equals(operator)) {
            return firstNumber + secondNumber;
        } else if ("-".equals(operator)) {
            return firstNumber - secondNumber;
        } else if ("*".equals(operator)) {
            return firstNumber * secondNumber;
        } else if ("/".equals(operator)) {
            if (secondNumber != 0.0) {
                return firstNumber / secondNumber;
            } else {
                return 0.0;
            }
        } else return 0.0;
    }
}
