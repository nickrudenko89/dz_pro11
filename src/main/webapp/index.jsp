<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script>
    <style>
        .buttonInput {
            width: 50px;
            height: 50px;
        }
        .textInput {
            width: 211px;
            height: 35px;
            text-align: right;
            font-size: x-large;
        }
    </style>
    <title>Калькулятор</title>
    <script>
        window.onload = function () {
            if(document.getElementById('resultInput').value=="0") {
                var date = new Date(0);
                document.cookie = "calculator.newExpression=; path=/; expires=" + date.toUTCString();
                document.cookie = "calculator.operatorExists=; path=/; expires=" + date.toUTCString();
                document.cookie = "calculator.dotExists=; path=/; expires=" + date.toUTCString();
            }
        }

        function typeElement (id,value) {
            var inputValue = document.getElementById('resultInput').value;
            var date = new Date(0);
            var lastSymbol = inputValue.substr(-1);
            if(id==0 || id==1) {                                                                    //CE & C
                document.cookie = "calculator.newExpression=; path=/; expires=" + date.toUTCString();
                document.cookie = "calculator.operatorExists=; path=/; expires=" + date.toUTCString();
                document.cookie = "calculator.dotExists=; path=/; expires=" + date.toUTCString();
                document.getElementById('resultInput').value = 0;
                return;
            }
            else if(id==2) {                                                                        // ←
                if(lastSymbol==".")
                    document.cookie = "calculator.dotExists=; path=/; expires=" + date.toUTCString();
                if(lastSymbol=="+" || lastSymbol=="-" || lastSymbol=="*" || lastSymbol=="/")
                    document.cookie = "calculator.operatorExists=; path=/; expires=" + date.toUTCString();
                if (inputValue.length>1)
                    document.getElementById('resultInput').value = inputValue.substring(0,inputValue.length-1);
                else
                    document.getElementById('resultInput').value = 0;
            }
            else if((id>=4 && id<=6)||(id>=8 && id<=10)||(id>=12 && id<=14)||id==17) {              // 0,1,2,3,4,5,6,7,8,9
                if ((getCookie("calculator.newExpression")==undefined) || (inputValue==0 && lastSymbol!=".")) {
                    document.getElementById('resultInput').value = value;
                    document.cookie = "calculator.newExpression=true";
                    document.cookie = "calculator.dotExists=; path=/; expires=" + date.toUTCString();
                }
                else
                    document.getElementById('resultInput').value += value;
            }
            else if(id == 3 || id == 7 || id == 11 || id == 15) {                                   // +,-,*,/
                document.cookie = "calculator.newExpression=true";
                document.cookie = "calculator.dotExists=; path=/; expires=" + date.toUTCString();
                if(getCookie("calculator.operatorExists")==undefined) {
                    document.cookie = "calculator.operatorExists=true";
                    if (lastSymbol==".")
                        document.getElementById('resultInput').value += "0" + value;
                    else
                        document.getElementById('resultInput').value += value;
                }
                else {
                    if(lastSymbol=="+" || lastSymbol=="-" || lastSymbol=="*" || lastSymbol=="/")
                        document.getElementById('resultInput').value = inputValue.substring(0, inputValue.length - 1) + value;
                    else {
                        if(lastSymbol==".")
                            document.getElementById('resultInput').value += "0";
                        document.getElementById('resultInput').value += value;
                        sendForm('/calculate');
                    }
                }
            }
            else if(id==16) {
                if(getCookie("calculator.operatorExists")==undefined && inputValue!=0) {            //±
                    document.getElementById('resultInput').value = "-" + inputValue;
                }
            }
            else if(id==18) {                                                                       // .
                if(lastSymbol=="+" || lastSymbol=="-" || lastSymbol=="*" || lastSymbol=="/")
                    document.getElementById('resultInput').value += "0" + value;
                else {
                    if(getCookie("calculator.dotExists")==undefined){
                        document.cookie = "calculator.newExpression=true";
                        document.getElementById('resultInput').value += value;
                    }
                }
                document.cookie = "calculator.dotExists=true";
            }
            else if(id==19){                                                                        // =
                if(getCookie("calculator.newExpression")!=undefined) {
                    if(getCookie("calculator.operatorExists")!=undefined) {
                        if(lastSymbol==".")
                            document.getElementById('resultInput').value += "0";
                        else if(lastSymbol=="+" || lastSymbol=="-" || lastSymbol=="*" || lastSymbol=="/")
                            document.getElementById('resultInput').value += "0";
                        document.cookie = "calculator.operatorExists=; path=/; expires=" + date.toUTCString();
                        document.cookie = "calculator.newExpression=; path=/; expires=" + date.toUTCString();
                        sendForm('/calculate');
                    }
                }
            }
        }

        function sendForm(url){
            var date = new Date(0);
            document.cookie = "calculator.dotExists=true";
            var form = $('<form action="' + url + '" method="post">' +
                '<input type="hidden" name="expression" value="' + document.getElementById('resultInput').value + '" />' +
                '</form>');
            $('body').append(form);
            form.submit();
        }

        function getCookie(name) {
            var matches = document.cookie.match(new RegExp(
                "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
            ));
            return matches ? decodeURIComponent(matches[1]) : undefined;
        }
    </script>
</head>
<body>

    <c:if test="${expressionResult==null}">
        <c:set var="textInputValue" value="0"/>
    </c:if>
    <c:if test="${expressionResult!=null}">
        <c:set var="textInputValue" value="${expressionResult}"/>
    </c:if>

    <table>
    <tr><td colspan="4"><input class="textInput" id="resultInput" type="text" value="${textInputValue}"/></td></tr>
    <tr>
    <c:set var="counter" value="0"/>
    <c:forEach var="item" items="CE,C,←,/,7,8,9,*,4,5,6,-,1,2,3,+,±,0,.,=">
        <td>
            <input class="buttonInput" type="button" id="${counter}" value="${item}" onclick="typeElement(${counter},'${item}')"/>
        </td>
        <c:if test="${(counter+1)%4==0}">
            </tr>
            <tr>
        </c:if>
        <c:set var="counter" value="${counter+1}"/>
    </c:forEach>
    </tr>
</table>

</body>
</html>
