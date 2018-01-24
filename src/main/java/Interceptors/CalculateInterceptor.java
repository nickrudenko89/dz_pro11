package Interceptors;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CalculateInterceptor implements HandlerInterceptor {

    private String secondOperator = "";

    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        String expresion = httpServletRequest.getParameter("expression");
        String lastSymbol = expresion.substring(expresion.length() - 1);
        if ("+".equals(lastSymbol) || "-".equals(lastSymbol) || "*".equals(lastSymbol) || "/".equals(lastSymbol))
            this.secondOperator = lastSymbol;
        return true;
    }

    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
        modelAndView.addObject("expressionResult", modelAndView.getModel().get("expressionResult") + secondOperator);
    }

    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {
        this.secondOperator = "";
    }
}